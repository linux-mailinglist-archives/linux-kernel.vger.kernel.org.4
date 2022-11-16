Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2262BE89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKPMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKPMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:47:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC221167EA;
        Wed, 16 Nov 2022 04:47:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFB5FCE19DA;
        Wed, 16 Nov 2022 12:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BF5C433C1;
        Wed, 16 Nov 2022 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668602840;
        bh=tKLpMlH43+Qp3G1HljC8JkJIT/xBjIxdBYhEplhIlas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bqm9xOt5Hv+xGuCPRbdv5wlwB9N2yJWiNBxdnZ3qZmrzMupjjucPh4HkTAgBMgQcb
         6NqGw1DmG1z0tdFbwB8Cl2CWdHlaRc2JqjQL/gWQaH2a4EY2Durhp/Ijglc8qjWvDq
         /fmCJqMJAcQKDxEhkFaocn+S/TQ0poysS/pFil5LQCo1GtjlF4ClH3SO63RdSSrYPf
         UG1amBzpILy5qDMvEovh4WDPxl+FGJBduIF0fkEoYQcgc6w/pcTEE8JlSgQfg45+WL
         WSyLKj8p4h+MTTc+MpqlV5tl+QzpvVAvHB1yzg+jOz66XCIzF9sdo6+a/6+FJmuixK
         FYDrB2lSe7Png==
Date:   Wed, 16 Nov 2022 13:47:16 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Message-ID: <20221116124716.GA813995@lothringen>
References: <20221115131926.3409974-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115131926.3409974-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 09:19:26PM +0800, Zqiang wrote:
> For CONFIG_PREEMPT_RT=y kernel, the "use_softirq=0" will be set, the
> RCU_SOFTIRQ processing is moved to per-CPU rcuc kthreads which created
> by smpboot_register_percpu_thread(). when CPU is going offline, the
> corresponding rcu_data.rcu_cpu_kthread_status is set RCU_KTHREAD_OFFCPU,
> and the rcuc kthreads enter TASK_PARKED state, kthreads in TASK_PARKED
> state only accept kthread_unpark() to wakeup.
> 
> Therefore, This commit avoid invoke wake_up_process() to rcuc kthreads
> in TASK_PARKED state.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ccad468887e..49dd87356851 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, int status)
>  	 * If the thread is yielding, only wake it when this
>  	 * is invoked from idle
>  	 */
> -	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> +	if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)) &&
> +				status != RCU_KTHREAD_OFFCPU)
>  		wake_up_process(t);

There is a tiny window where this can happen (between CPUHP_TEARDOWN_CPU
and CPUHP_AP_SMPBOOT_THREADS) and it can't cause a spurious unpark because
wake_up_process() only wakes up from TASK_[UN]INTERRUPTIBLE states. And even
if it did, the KTHREAD_SHOULD_PARK bit would still be on.

And more important! On unpark time RCU_KTHREAD_OFFCPU isn't cleared. Only the
rcuc kthread does it, and after your patch it couldn't be awaken to perform
that, unless rcuc is lucky enough to have rcu_data.rcu_cpu_has_work = 1
by the time it unparks and that isn't guaranteed. So rcuc may sleep forever.

OTOH one cleanup that could be done is to make rcu_cpu_kthread_park() to use
__this_cpu_write as it's guaranteed that cpu == smp_processor_id().

Thanks.

