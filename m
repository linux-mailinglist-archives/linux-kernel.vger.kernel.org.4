Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298695FDC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJMON6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJMONu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FD50B83;
        Thu, 13 Oct 2022 07:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38886617EC;
        Thu, 13 Oct 2022 14:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ACAC433D6;
        Thu, 13 Oct 2022 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665670423;
        bh=AQduuDPRz+ukUglRpLevsrSLIjIFqtofoE9q13bN9RE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sySmIm6XLPp6Pfii6YNdD9JseogsLPgRTdlGNgJ22u/LSa+8ujFDEDCxLLK6APMdO
         oh8fuSrnqg/abevO3IIUO/dqpEubc6JZFfKbM/ov7dFZ6ue4/yALXQjCBQArwFvY8n
         P3KBd6xY8jIN9Vb3/lbpIlDyrO7BQCmqnHwtNRT1NG/WRnI/Ns9pJAiweAPI5OzLjD
         gxOZHsLlLlS+P4/Nx7UHHkFBUOlnJtTSURuUBREOcsZ6F2XOKXu1A3yJYA6g/vqTa4
         wqcKAhKhiDpnUwuFFrS4H4m6tA0BT7J+RyVWz6oTrR7dqut8h3/2ezVbR2IfF93Jbz
         BldUK+8qEIdRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C876D5C32BF; Thu, 13 Oct 2022 07:13:39 -0700 (PDT)
Date:   Thu, 13 Oct 2022 07:13:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix use __this_cpu_read() warning in preemptible
 code
Message-ID: <20221013141339.GY4221@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221013044148.2894320-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013044148.2894320-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 12:41:48PM +0800, Zqiang wrote:
> BUG: using __this_cpu_read() in preemptible [00000000]
> code: rcu_torture_fqs/398
> caller is __this_cpu_preempt_check+0x13/0x20
> CPU: 3 PID: 398 Comm: rcu_torture_fqs Not tainted 6.0.0-rc1-yoctodev-standard+
> Call Trace:
> <TASK>
> dump_stack_lvl+0x5b/0x86
> dump_stack+0x10/0x16
> check_preemption_disabled+0xe5/0xf0
> __this_cpu_preempt_check+0x13/0x20
> rcu_force_quiescent_state.part.0+0x1c/0x170
> rcu_force_quiescent_state+0x1e/0x30
> rcu_torture_fqs+0xca/0x160
> ? rcu_torture_boost+0x430/0x430
> kthread+0x192/0x1d0
> ? kthread_complete_and_exit+0x30/0x30
> ret_from_fork+0x22/0x30
> </TASK>
> 
> When enable rcutorture.fqs_duration, the rcu_force_quiescent_state() be
> invoked in rcu_torture_fqs task context, invoke __this_cpu_read() in
> preemptible code section will trigger the above calltrace.
> 
> This commit convert __this_cpu_read() to raw_cpu_read() to avoid
> this warning.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good eyes!  Queued, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96d678c9cfb6..282002e62cf3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2436,7 +2436,7 @@ void rcu_force_quiescent_state(void)
>  	struct rcu_node *rnp_old = NULL;
>  
>  	/* Funnel through hierarchy to reduce memory contention. */
> -	rnp = __this_cpu_read(rcu_data.mynode);
> +	rnp = raw_cpu_read(rcu_data.mynode);
>  	for (; rnp != NULL; rnp = rnp->parent) {
>  		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
>  		       !raw_spin_trylock(&rnp->fqslock);
> -- 
> 2.25.1
> 
