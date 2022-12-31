Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA1A65A60C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbiLaSZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 13:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbiLaSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 13:25:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF1E9E;
        Sat, 31 Dec 2022 10:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9100B801BE;
        Sat, 31 Dec 2022 18:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EE7C433EF;
        Sat, 31 Dec 2022 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672511111;
        bh=untildj83gdrgB5eLYPyziJwlrL6AaeJlm/kfFmc2ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KIudxlN2FVqrOCypw/GjiUwwY3a8EWMrt/HQYJ67m4zPJtWA5+gDXiggXYHPZR1Ci
         d0azq3JnJmVaAl9wev3f1beNoOrsSW8obW5+P+q+/htvxNaXZtcYVY41/YcdEKIA5k
         xI1TMTR88OpEX1kndD06ycmuy4Slg2kUOeVeo50qhNGn91oh2cUGOyJ+UTk4T9N+84
         mLPF6rOb7HUcfUU4orqMfzpw8urPXdoDtdWRPtEfQLHw5AD/SHa6dLc5MEQ2BuM6tI
         rnfNPnw1eSMOGOa+3oKNK1WLVgyXf29UDUluJG2O8XoEsNSv4dMjdngJR2+xpT+u6W
         OqsoWp+X72lig==
Date:   Sat, 31 Dec 2022 19:25:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Message-ID: <20221231182508.GB205110@lothringen>
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
 <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 12:08:49PM -0800, Paul E. McKenney wrote:
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 249c2967d9e6c..7cc4856da0817 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  	struct rcu_node *rnp_root = rcu_get_root();
> +	unsigned long flags;
>  
>  	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
>  	jiffies_stall = rcu_exp_jiffies_till_stall_check();
> @@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
>  		if (synchronize_rcu_expedited_wait_once(1))
>  			return;
>  		rcu_for_each_leaf_node(rnp) {
> +			raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  			mask = READ_ONCE(rnp->expmask);
>  			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
>  				rdp = per_cpu_ptr(&rcu_data, cpu);
>  				if (rdp->rcu_forced_tick_exp)
>  					continue;
>  				rdp->rcu_forced_tick_exp = true;
> -				preempt_disable();
>  				if (cpu_online(cpu))
>  					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
> -				preempt_enable();
>  			}
> +			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
>  		j = READ_ONCE(jiffies_till_first_fqs);
>  		if (synchronize_rcu_expedited_wait_once(j + HZ))

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

BTW why are we forcing the tick on the whole node?
And shouldn't we set the tick dependency from rcu_exp_handler() instead?

Thanks.
