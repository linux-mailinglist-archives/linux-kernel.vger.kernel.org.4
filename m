Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FB6DE0CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 18:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDKQSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDKQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 12:17:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A75FFB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:16:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so4614296wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 09:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681229785; x=1683821785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQOU2NxcA3yCNJObcmxy+gfhS7V/5K9QCr7rxWQRSCc=;
        b=w4nLujlkK2kPUHBbGgWURVjMNtN7wv3feP7uzPldzYCs/EZ0GmNCQhhHFGLTAY+Gi5
         +Lp8L9G1hkQsoR4T/dP2rnFkQKkZXj7JVGKt2lrBdp2Y9cUjeunzhGlijbiFiuE09YMq
         8oYD9lZ/+fe3Tmd7PwYMP9Neo0olfAjzmJV4bg+3wvDDwtBoIp95WGcK3lzcKDyPBQbo
         xr5gW0S3s9YIrEBW+lx4H009CWTnN7QSRWYImt3lc7oi4UOHjQVAn+FI7WBpxxNs7mMA
         oYTwb7x0T2CieNCJ+JHcPAG+ZgWjhkKlYOaEY5U39P11b+wlJGKSllAt7arcPFJdCxn+
         S4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681229785; x=1683821785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQOU2NxcA3yCNJObcmxy+gfhS7V/5K9QCr7rxWQRSCc=;
        b=duEzpgMPYKP8lqXH1GTsdxpXkUBRDchW2GKf4114iKJNRlavQD7NifBfkEX2ut7uj7
         PHnTERLheA/ZjZgPcoB/NQ49Q77mRBy0gzF+McK+qFG2nc0Ze7Az5rcec0gGvuge/KsU
         2h2X8dNzB3YjkCL/z6OmJmGjHEmKx0YXNulYZb0poKS44k9RHbLtDXIvWPQEbBxKSZNz
         RBfDHrzw4DSiLLwUdf+kdSVlMrKjafg/z0VzIRMP+qqnpHe1yXj9GN3sDUA5DfldXEQP
         qq2kk8TI0gnR0U+RVQC0RwMFac2+D9yaDh26Z16ZHEmPO0HBkETnPAnBID24sjtaU29x
         srsQ==
X-Gm-Message-State: AAQBX9ebiNMzMFvbntbK6Zb/IhrYndZHA4p206jilMYAOlo+H+l7J7T3
        RQFlDgNPE4YHiog+WcQc1Vy2HQ==
X-Google-Smtp-Source: AKy350ZI3OMMZN8klF1UVUUig8s+iGaTms+boTblI8oKaQxUKj3bSCRKrhXp0lQDjqs/Ax6/me7yQA==
X-Received: by 2002:a05:600c:4da5:b0:3f0:4275:395f with SMTP id v37-20020a05600c4da500b003f04275395fmr9211597wmp.13.1681229785055;
        Tue, 11 Apr 2023 09:16:25 -0700 (PDT)
Received: from klimova1.roam.corp.google.com ([194.75.181.122])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b003f0652084b8sm21282192wms.20.2023.04.11.09.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:16:24 -0700 (PDT)
Date:   Tue, 11 Apr 2023 17:16:21 +0100
From:   Alexey Klimov <alexey.klimov@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Message-ID: <20230411171621.0544249a.alexey.klimov@linaro.org>
In-Reply-To: <20230320093614.GB2196776@hirez.programming.kicks-ass.net>
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
        <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
        <CANgGJDpd4Gm5HhQW__oMAv1yUqSPZ7FSGoQLYTmug=TUk4cn4g@mail.gmail.com>
        <20230320090558.GF2194297@hirez.programming.kicks-ass.net>
        <20230320093614.GB2196776@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 10:36:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

Sorry for the delay.
(adding Mark in c/c)

> On Mon, Mar 20, 2023 at 10:05:58AM +0100, Peter Zijlstra wrote:
> > On Fri, Mar 17, 2023 at 02:11:25AM +0000, Alexey Klimov wrote:  
> > > On Wed, 15 Mar 2023 at 11:16, Peter Zijlstra
> > > <peterz@infradead.org> wrote:  
> > > >
> > > >
> > > > (could you wrap your email please)  
> > > 
> > > Ouch. Sorry.
> > >   
> > > > On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:  
> > > > > #regzbot introduced: 0c5ffc3d7b15 #regzbot title:
> > > > > CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and
> > > > > slow-stuck reboots
> > > > >
> > > > > The upstream changes are being merged into android-mainline
> > > > > repo and at some point we started to observe kernel panics on
> > > > > reboot or long reboot times.  
> > > >
> > > > On what hardware? I find it somewhat hard to follow this DT
> > > > code :/  
> > > 
> > > Pixel 6.  
> > 
> > What actual cpuidle driver is that thing using? Is there any
> > out-of-tree code involved? Mark tells me anything arm64 should be
> > using PSCI, so let me to stare hard at that again.

Yep, it uses PSCI (psci_idle). But there is some out-of-tree code
involved.

> So specifically, your problem sounds like rcu_synchronize() is taking
> very much longer than it used to. Specifically combined with the patch
> that makes it 'go-away' this seems to indicate you lost a
> ct_cpuidle_enter() call, which is what ends up telling RCU the cpu is
> idle and no longer partakes in the whole grace period machinery. Not
> telling RCU this results in RCU waiting for an idle cpu to report back
> on it's RCU progress, but it being idle means it's not going to be
> doing that and things sorta wait around until RCU gets fed up and
> starts spraying IPIs to try and get things moving.
 
rcu_barrier().

Eventually managed to make sysrq work and blocked tasks point to
rcu_barrier():

[  454.626264][    C4] task:init state:D stack:9728 pid:1 ppid:0
flags:0x04000008
[  454.626463][    C4] Call trace:
[  454.626570][    C4]  __switch_to+0x180/0x308
[  454.626733][    C4]  __schedule+0x620/0x9e4
[  454.626892][    C4]  schedule+0x84/0xf4
[  454.627039][    C4]  schedule_timeout+0x48/0x1d8
[  454.627215][    C4]  wait_for_common+0xe0/0x1a8
[  454.627388][    C4]  wait_for_completion+0x20/0x30
[  454.627571][    C4]  rcu_barrier+0x3f8/0x674
[  454.627734][    C4]  netdev_run_todo+0x74/0x5d8
[  454.627907][    C4]  rtnl_unlock+0x18/0x2c
[  454.628063][    C4]  dhd_unregister_net+0x30/0x54 [bcmdhd4389]
[  454.629084][    C4]  wl_cfg80211_unregister_static_if+0x98/0x18c
[bcmdhd4389]
[  454.630101][    C4]  wl_cfg80211_detach+0xcc/0x344
[bcmdhd4389]
[  454.631091][    C4]  dhd_detach+0x4d0/0xc78 [bcmdhd4389]
[  454.632064][    C4]  dhdpcie_bus_release+0x28c/0x6bc [bcmdhd4389]
[  454.633052][    C4]  dhdpcie_pci_remove+0xb4/0x1a4 [bcmdhd4389]
[  454.634036][    C4]  pci_device_remove+0x60/0x118
[  454.634152][    C4]  device_release_driver_internal+0x19c/0x2f0
[  454.634291][    C4]  driver_detach+0x98/0xe0
[  454.634395][    C4]  bus_remove_driver+0x80/0xbc
[  454.634504][    C4]  driver_unregister+0x38/0x64
[  454.634616][    C4]  pci_unregister_driver+0x2c/0xb8
[  454.634735][    C4]  dhdpcie_bus_unregister+0xd8/0x1b0 [bcmdhd4389]
[  454.635739][    C4]  dhd_bus_unregister+0x24/0x50 [bcmdhd4389]
[  454.636722][    C4]  dhd_reboot_callback+0x19c/0x1d8 [bcmdhd4389]
[  454.637709][    C4]  blocking_notifier_call_chain+0x78/0xc8
[  454.637836][    C4]  kernel_power_off+0x2c/0xfc
[  454.637946][    C4]  __arm64_sys_reboot+0x270/0x27c
[  454.638060][    C4]  invoke_syscall+0x60/0x130
[  454.638169][    C4]  el0_svc_common+0xbc/0x100
[  454.638278][    C4]  do_el0_svc+0x38/0xb0
[  454.638377][    C4]  el0_svc+0x34/0xc4
[  454.638464][    C4]  el0t_64_sync_handler+0x8c/0xfc
[  454.638573][    C4]  el0t_64_sync+0x1a8/0x1ac

and

[   13.799675][    C2] task:kworker/1:1     state:D stack:12784 pid:97
  ppid:2      flags:0x00000008
[   13.799879][    C2] Workqueue: events
slab_caches_to_rcu_destroy_workfn
[   13.800112][    C2] Call trace:
[   13.800231][    C2]  __switch_to+0x180/0x308
[   13.800394][    C2]  __schedule+0x620/0x9e4
[   13.800553][    C2]  schedule+0x84/0xf4
[   13.800700][    C2]  schedule_timeout+0x48/0x1d8
[   13.800876][    C2]  wait_for_common+0xe0/0x1a8
[   13.801049][    C2]  wait_for_completion+0x20/0x30
[   13.801232][    C2]  rcu_barrier+0x3f8/0x674
[   13.801394][    C2]  slab_caches_to_rcu_destroy_workfn+0x90/0x108
[   13.801627][    C2]  process_one_work+0x1f0/0x454
[   13.801807][    C2]  worker_thread+0x330/0x43c
[   13.801977][    C2]  kthread+0x10c/0x1b8
[   13.802127][    C2]  ret_from_fork+0x10/0x20

 
> Now...  if a driver sets CPUIDLE_FLAG_RCU_IDLE it promises to call
> ct_cpuidle_{enter,exit}() itself. Hence for any driver that does *NOT*
> set that flag, cpuidle_enter_state() calls these functions.
> 
> Now, fo PSCI, the DT handler is psci_enter_idle_state(), which uses
> CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(), which per the other email, means
> that it's low_level_idle_enter := psci_cpu_suspend_enter(), *will*
> call ct_cpuidle_{enter,exit}().
> 
> Then if we look at psci_cpu_suspend_enter(), it has two cases
> depending on psci_power_state_loses_context(). If it doesn't lose
> context it does ct_cpuidle_enter() right there and proceeds to call
> psci_ops.cpu_suspend() -- whatever that does.
> 
> If it does lose state, then it depends on CONFIG_ARM64, on arm64 we do
> not call ct_cpuidle_{enter,exit}() but proceed into cpu_suspend().
> 
> We can find that function in arch/arm64/kernel/suspend.c, and if you
> look at it, you'll note it does in fact call ct_cpuidle_{enter,exit}()
> as per promises made.
> 
> So AFAICT every path into idle will pass through ct_cpuidle_enter().
 
I tried to understand where ct_cpuidle_{enter,exit}() is missing and
narrow it down until found out that the problem is cpu pm notifier
returning NOTIFY_BAD during reboot and calls to ct_cpuidle_{enter,exit}
are correct. Thanks for checking.

In __CPU_PM_CPU_IDLE_ENTER() macro we have:

	if (!is_retention)
		__ret =  cpu_pm_enter();
	if (!__ret) {
		if (!is_rcu)
			ct_cpuidle_enter();
		__ret = low_level_idle_enter(state);
		if (!is_rcu)
			ct_cpuidle_exit();
		if (!is_retention)
			cpu_pm_exit();
	}

While rebooting cpu_pm_enter() returns an error since one of the
notifiers starts to return NOTIFY_BAD. Looks like kernel starts to
"spin" trying to put CPUs in idle state and always gets an error from
cpu_pm_enter() never reaching the section covered by
ct_cpuidle_{enter,exit}. Before the mentioned commit all of this were
under ct_cpuidle_{enter,exit}. Hence, yes, in some sense we lost a
ct_cpuidle_enter+exit() call. As long as I manually cover this small
piece with ct_cpuidle_{enter,exit} for testing, the reboot times return
back to as it was before the commit. Currently I removed returning
NOTIFY_BAD from notifier when rebooting.

It seems RCU waits for these CPUs to attend RCU machinery.
Also it probably does not count as an upstream regression since it
involves out of tree code but in theory this could happen with any
other notifier. Probably WARN_ONCE() will be too bad too.

The cpu pm notifier is this one, line 972,
exynos_cpu_pm_notify_callback():
https://android.googlesource.com/kernel/gs/+/refs/tags/android-t-qpr3-beta-2_r0.5/drivers/soc/google/exynos-cpupm.c#972

Thank you for checking all this!

Best regards,
Alexey

