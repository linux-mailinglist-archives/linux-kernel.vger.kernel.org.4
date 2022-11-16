Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E462C1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiKPPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiKPPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:01:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216FB22;
        Wed, 16 Nov 2022 07:01:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CAFC61E65;
        Wed, 16 Nov 2022 15:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028CAC433D7;
        Wed, 16 Nov 2022 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668610893;
        bh=GCLTsKWd3l2oU79ad7ndCO0sGERp+hW9GVMLdBk7v+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6oeGQT7ibMjTKUpuBJc/iLSrD/y8yIheNo+1A3Wl3g3cIXSnrXH8an5f9/qL4+T7
         H1Ue8sXOWsXvTv3u0CAf/47KNbeyokRY07nH6hk/bAqzD3sZPbmIQFQHepipNxGzj2
         p6ZJ+9TZje56oRJvdJO38EFN1kD9bqjMzCyVSRSLDGT3Y7GSTtqUBAu6FGZMJiQ60M
         w9nTxOhsy5ulhI1N7aItOSnKRSpqFX0pE4vy30/lmYUUPQ/WO/laRhKdjTc32CI1aK
         tdNMg4uDeOy5nJS2fjGV6DfFIRuN8YEqqoiZUB+xOk56dUsQsE6sTCHJ2ZFpjAG4NM
         iW4ODprbIdsPQ==
Date:   Wed, 16 Nov 2022 16:01:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Message-ID: <20221116150130.GD816333@lothringen>
References: <20221115131926.3409974-1-qiang1.zhang@intel.com>
 <20221116124716.GA813995@lothringen>
 <PH0PR11MB5880FD7499114743BCE3E5A3DA079@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880FD7499114743BCE3E5A3DA079@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:07:28PM +0000, Zhang, Qiang1 wrote:
> On Tue, Nov 15, 2022 at 09:19:26PM +0800, Zqiang wrote:
> >And more important! On unpark time RCU_KTHREAD_OFFCPU isn't cleared. Only the
> >rcuc kthread does it, and after your patch it couldn't be awaken to perform
> >that, unless rcuc is lucky enough to have rcu_data.rcu_cpu_has_work = 1
> >by the time it unparks and that isn't guaranteed. So rcuc may sleep forever.
> 
> Thanks for review, yes I should register an unpark function to clear RCU_KTHREAD_OFFCPU.
> Is the following modification more appropriate?
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ccad468887e..a2248af0ccda 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, int status)
>          * If the thread is yielding, only wake it when this
>          * is invoked from idle
>          */
> -       if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)))
> +       if (t && (status != RCU_KTHREAD_YIELDING || is_idle_task(current)) &&
> +                               status != RCU_KTHREAD_OFFCPU)
>                 wake_up_process(t);
>  }
> 
> @@ -2407,7 +2408,14 @@ static void invoke_rcu_core(void)
> 
>  static void rcu_cpu_kthread_park(unsigned int cpu)
>  {
> -       per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) = RCU_KTHREAD_OFFCPU;
> +       WARN_ON_ONCE(cpu != smp_processor_id());
> +       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_OFFCPU);
> +}
> +
> +static void rcu_cpu_kthread_unpark(unsigned int cpu)
> +{
> +       WARN_ON_ONCE(cpu != smp_processor_id());
> +       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_ONCPU);
>  }
> 
>  static int rcu_cpu_kthread_should_run(unsigned int cpu)
> @@ -2460,6 +2468,7 @@ static struct smp_hotplug_thread rcu_cpu_thread_spec = {
>         .thread_comm            = "rcuc/%u",
>         .setup                  = rcu_cpu_kthread_setup,
>         .park                   = rcu_cpu_kthread_park,
> +       .unpark                 = rcu_cpu_kthread_unpark,

Well, personally I don't think it's worth the burden because wake_up_process()
already does an early exit if it's not dealing with a TASK_[UN]INTERRUPTIBLE task and
the window is so short and rare that it doesn't look like a good candidate for
extra optimization;

Thanks.
