Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64DD74DDBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGJTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGJTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEE120;
        Mon, 10 Jul 2023 12:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D65A5611A8;
        Mon, 10 Jul 2023 19:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A240C433C8;
        Mon, 10 Jul 2023 19:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689015959;
        bh=7/GxSGB10HNgJpz9lhQO6UFYjmBhl6x+8u7b/vkUkHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PaVkKxAnR8dYtwgR9i+fItAhybu+MR7myX7H6FreI8c+C5Ud9DJxErLK8JegSkJ5z
         icNOm9wrvKDHpouY9+u+U3PqXdIwOtzIlC4Qf+qbbacOiW6NIYXZ8sjc5PLoTPNyy2
         SP8CQjUc/pbSVTAYgZ6hbHhFJDSLRnDp8AESIZtjGaNzTmFWsKsuPj31fqAijuXSG1
         nOERWgcs1KD7RL+fnk5sbcFCDJnpP7JC/vSDMy6tOWpbImsVsT4ExlyobnhX3NDsTQ
         coo2HtOOBTJXoLhAt9bp1SeuiQyo5Busu2r2bRIBbWCRJy5T5iG3HbWQEq/JTVpXk5
         g7alrNneVwEcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C148FCE00C6; Mon, 10 Jul 2023 12:05:58 -0700 (PDT)
Date:   Mon, 10 Jul 2023 12:05:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Don't dump the stalled CPU on where RCU GP
 kthread last ran twice
Message-ID: <39430021-dc0d-4abd-8266-642e4e2dc7df@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230705073020.2030-1-thunder.leizhen@huawei.com>
 <20230705073020.2030-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705073020.2030-3-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:30:20PM +0800, Zhen Lei wrote:
> The stacks of all stalled CPUs will be dumped. If the CPU on where RCU GP
> kthread last ran is stalled, its stack does not need to be dumped again.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

This one looks good.  Please feel free to rebase it before 1/2 and repost.

							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index dcfaa3d5db2cbc7..cc884cd49e026a3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -534,12 +534,14 @@ static void rcu_check_gp_kthread_starvation(void)
>  		       data_race(READ_ONCE(rcu_state.gp_state)),
>  		       gpk ? data_race(READ_ONCE(gpk->__state)) : ~0, cpu);
>  		if (gpk) {
> +			struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
>  			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
>  			pr_err("RCU grace-period kthread stack dump:\n");
>  			sched_show_task(gpk);
>  			if (cpu_is_offline(cpu)) {
>  				pr_err("RCU GP kthread last ran on offline CPU %d.\n", cpu);
> -			} else  {
> +			} else if (!(data_race(READ_ONCE(rdp->mynode->qsmask)) & rdp->grpmask)) {
>  				pr_err("Stack dump where RCU GP kthread last ran:\n");
>  				dump_cpu_task(cpu);
>  			}
> -- 
> 2.25.1
> 
