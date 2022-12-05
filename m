Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83A6428B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiLEMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiLEMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:44:02 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF655B9;
        Mon,  5 Dec 2022 04:44:01 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id g10so4794417qkl.6;
        Mon, 05 Dec 2022 04:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzUzCOp5X19qeZL1cceQwqgkE2PSOUqJ0E86UtOHRyA=;
        b=SP9lITzDqy5eX7H4sqNy5xHmfdl8TBUlplVspn6L1KswcRtTJcLHwhVl4gBBstf3ML
         VzUg+fklykSsQIXHh43vReEzTEYhUadJw81l1mYmDyIGwriacFp1+2XLwn8RWyyIPjuJ
         QIJQNGuYiThVY4MhKuROBHNWJOiv9ZvTrdxEBwakaseP8aIKwZfZqe+96rjwNmClGGqx
         GBK3HgEufrby6Z7+ylEWNqzse7c/y+eEqmxdlXSLmTTEoU2TSaNccFHjDbSdlEFJJwSK
         WLLcH5ufd9RuZgV8/08/QNw3qKjbNkwI60l6DuR2FsBKHXWXpBLsnh427I6yjgZr2wmf
         u8Gw==
X-Gm-Message-State: ANoB5pnOf6AjAWVGqfCSiYXc25tSpOADnhHwkPbp31Ugk4cmuIr7MLSl
        RIJjX57keDeglf/vWjC9pGgux5tp0cOwPi0vfpc=
X-Google-Smtp-Source: AA0mqf7S7sVxeiHwSk0PWz9FjQsjzPmSWEmNWlCSfo35QAYSIjKR/w40D+fWE7Xl8AAOqsw1/bu/5QeSfAflW3D8jGM=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr72744089qki.23.1670244240586; Mon, 05
 Dec 2022 04:44:00 -0800 (PST)
MIME-Version: 1.0
References: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
 <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
 <Y4zm9T+WYmyWwik4@zn.tnic> <7a094893-0c2e-a09b-3a10-02fe7aa8680b@gmail.com>
In-Reply-To: <7a094893-0c2e-a09b-3a10-02fe7aa8680b@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 13:43:45 +0100
Message-ID: <CAJZ5v0gthM-shi9udDmjiknKV29DYOr5o6b4b=taJEwZedM5=w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Defer setting boost MSRs
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 4, 2022 at 8:20 PM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>
>
>
> On 12/4/2022 12:29 PM, Borislav Petkov wrote:
> > On Thu, Nov 03, 2022 at 07:19:47PM +0100, Rafael J. Wysocki wrote:
> >> On Wed, Nov 2, 2022 at 9:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> >>>
> >>> When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
> >>> MSR) before the driver is registered with cpufreq.  This can be very time
> >>> consuming, because it is done with a CPU hotplug startup callback, and
> >>> cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
> >>> on each CPU one at a time, waiting for each to run before calling the next.
> >>>
> >>> If cpufreq_register_driver() fails--if, for example, there are no ACPI
> >>> P-states present--this is wasted time.
> >>>
> >>> Since cpufreq already sets up a CPU hotplug startup callback if and when
> >>> acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
> >>> which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
> >>> exit quickly if it is loaded but not needed.
> >>>
> >>> On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.
> >>>
> >>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> >>> ---
> >>>   drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
> >>>   1 file changed, 3 insertions(+), 28 deletions(-)
> >
> > ...
> >
> >> Applied as 6.2 material, thanks!
> >
> > My 32-bit Atom doesn't like this one. Reverting fixes it ofc.
> >
> > [   22.780260] unchecked MSR access error: WRMSR to 0x1a0 (tried to write 0x0000004364950488) at rIP: 0xf80b37d4 (boost_set_msr.isra.0+0x9c/0x114 [acpi_cpufreq])
> > [   22.781186] Call Trace:
> > [   22.781186]  boost_set_msr_each+0x15/0x1c [acpi_cpufreq]
> > [   22.781186]  __flush_smp_call_function_queue+0x132/0x1cc
> > [   22.781186]  ? sysvec_call_function+0x30/0x30
> > [   22.781186]  generic_smp_call_function_single_interrupt+0x12/0x18
> > [   22.781186]  __sysvec_call_function_single.constprop.0+0x43/0x1d8
> > [   22.781186]  sysvec_call_function_single+0x18/0x30
> > [   22.781186]  handle_exception+0x133/0x133
> > [   22.781186] EIP: finish_task_switch.isra.0+0x124/0x3a8
> > [   22.781186] Code: d8 e8 8c 16 92 00 85 f6 75 e8 a1 04 24 6c c2 85 c0 0f 8f 9b 00 00 00 89 d8 e8 e4 02 92 00 e8 53 9e 0b 00 fb 64 a1 40 f9 69 c2 <8b> 80 5c 0f 00 00 85 c0 0f 85 72 01 00 00 a1 28 24 6c c2 64 8b 15
> > [   22.781186] EAX: c32e2700 EBX: f748af40 ECX: 00000000 EDX: c1c3876e
> > [   22.781186] ESI: 00000000 EDI: 00000000 EBP: c3241f90 ESP: c3241f78
> > [   22.781186] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000206
> > [   22.781186]  ? uevent_seqnum_show+0x1b/0x28
> > [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
> > [   22.781186]  ? sysvec_call_function+0x30/0x30
> > [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
> > [   22.781186]  ? sysvec_call_function+0x30/0x30
> > [   22.781186]  ? finish_task_switch.isra.0+0x124/0x3a8
> > [   22.781186]  schedule_tail+0x12/0x78
> > [   22.781186]  schedule_tail_wrapper+0x9/0x10
> > [   22.781186]  ret_from_fork+0x5/0x28
> > [   22.781186] EIP: 0xb7fba549
> > [   22.781186] Code: Unable to access opcode bytes at 0xb7fba51f.
> > [   22.781186] EAX: 00000000 EBX: 01200011 ECX: 00000000 EDX: 00000000
> > [   22.781186] ESI: 00000000 EDI: b7bfe868 EBP: 00000000 ESP: bfcfedc0
> > [   22.781186] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> >
>
> I believe I see the problem... acpi_cpufreq_cpu_init is calling set_boost() directly without checking to see if acpi_cpufreq_driver.set_boost was set, so it is trying to set the MSR on CPUs that don't support it.
>
> Thanks, I can submit a patch to fix this.

Yes, please.

Note that I need to get this fix shortly, though, or I will just
revert the problemating commit before the 6.2 merge window opens.
