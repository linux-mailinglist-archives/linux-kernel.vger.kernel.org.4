Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E805B641EA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLDS3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDS3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:29:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8730112A9B;
        Sun,  4 Dec 2022 10:29:16 -0800 (PST)
Received: from zn.tnic (p200300ea9733e799329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e799:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 755611EC0662;
        Sun,  4 Dec 2022 19:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670178554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lN8frKuhbaasaQJGEoiPgCA0LmRdK0VQNNyuQB2MjRA=;
        b=lozCNi0LBzmr7CUeSL4cou2nl9OvNILUvzB3GVvOsT9ipRAQtwJUuTW8PtWXidk8f2iOY+
        enYjO4utqS2T0OIq/jYTGYu11SgE2LUFQpxUV9gYqXtWgVBdq2en3lVhfCpbDM1TU5lOC6
        kLlZZ9FKrjAts/rT747ygAescekIKfA=
Date:   Sun, 4 Dec 2022 19:29:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: acpi: Defer setting boost MSRs
Message-ID: <Y4zm9T+WYmyWwik4@zn.tnic>
References: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
 <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 07:19:47PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 2, 2022 at 9:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> >
> > When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
> > MSR) before the driver is registered with cpufreq.  This can be very time
> > consuming, because it is done with a CPU hotplug startup callback, and
> > cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
> > on each CPU one at a time, waiting for each to run before calling the next.
> >
> > If cpufreq_register_driver() fails--if, for example, there are no ACPI
> > P-states present--this is wasted time.
> >
> > Since cpufreq already sets up a CPU hotplug startup callback if and when
> > acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
> > which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
> > exit quickly if it is loaded but not needed.
> >
> > On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.
> >
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
> >  1 file changed, 3 insertions(+), 28 deletions(-)

...

> Applied as 6.2 material, thanks!

My 32-bit Atom doesn't like this one. Reverting fixes it ofc.

[   22.780260] unchecked MSR access error: WRMSR to 0x1a0 (tried to write 0x0000004364950488) at rIP: 0xf80b37d4 (boost_set_msr.isra.0+0x9c/0x114 [acpi_cpufreq])
[   22.781186] Call Trace:
[   22.781186]  boost_set_msr_each+0x15/0x1c [acpi_cpufreq]
[   22.781186]  __flush_smp_call_function_queue+0x132/0x1cc
[   22.781186]  ? sysvec_call_function+0x30/0x30
[   22.781186]  generic_smp_call_function_single_interrupt+0x12/0x18
[   22.781186]  __sysvec_call_function_single.constprop.0+0x43/0x1d8
[   22.781186]  sysvec_call_function_single+0x18/0x30
[   22.781186]  handle_exception+0x133/0x133
[   22.781186] EIP: finish_task_switch.isra.0+0x124/0x3a8
[   22.781186] Code: d8 e8 8c 16 92 00 85 f6 75 e8 a1 04 24 6c c2 85 c0 0f 8f 9b 00 00 00 89 d8 e8 e4 02 92 00 e8 53 9e 0b 00 fb 64 a1 40 f9 69 c2 <8b> 80 5c 0f 00 00 85 c0 0f 85 72 01 00 00 a1 28 24 6c c2 64 8b 15
[   22.781186] EAX: c32e2700 EBX: f748af40 ECX: 00000000 EDX: c1c3876e
[   22.781186] ESI: 00000000 EDI: 00000000 EBP: c3241f90 ESP: c3241f78
[   22.781186] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000206
[   22.781186]  ? uevent_seqnum_show+0x1b/0x28
[   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
[   22.781186]  ? sysvec_call_function+0x30/0x30
[   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
[   22.781186]  ? sysvec_call_function+0x30/0x30
[   22.781186]  ? finish_task_switch.isra.0+0x124/0x3a8
[   22.781186]  schedule_tail+0x12/0x78
[   22.781186]  schedule_tail_wrapper+0x9/0x10
[   22.781186]  ret_from_fork+0x5/0x28
[   22.781186] EIP: 0xb7fba549
[   22.781186] Code: Unable to access opcode bytes at 0xb7fba51f.
[   22.781186] EAX: 00000000 EBX: 01200011 ECX: 00000000 EDX: 00000000
[   22.781186] ESI: 00000000 EDI: b7bfe868 EBP: 00000000 ESP: bfcfedc0
[   22.781186] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
