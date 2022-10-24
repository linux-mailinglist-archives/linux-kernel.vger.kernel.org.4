Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE545609C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiJXIFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJXIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:05:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617972983E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:05:07 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so5482797otu.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQogVgCRTZ3khO8pknzN3DMcm/zjs+08sc/bQR/cai4=;
        b=WvsJn3SNdiHFJfDdpxcjC72keInSt6i2XM6iQ4MTAiSww4hui3C0DdhAfysFHb5lGV
         N30TTG9r63kkfSNWq8r5g+qUgwrDFGUt6GDnqNDq0zxF0cvJ/GU0RYMPk8kjn59WwdUO
         MvXLfPc3MEL1nJ7qYBV+u140JIzh4wEyt57ElqOfFdC8CjuwHFcrRmwZiFtGin9WXkra
         hrPQW3MZCAGWg7PhRbTOmXqhK2YnTSXiJ90S7S3jCDVaaJHavZirdxz2sNUpJlmbL/Ob
         F10xW3Yye3TFhRwsEcdtLUNf6rC5s6vjRxujbtQb2fDfk64H5TAoaUaLwrtQTRM9Z+rq
         ocpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQogVgCRTZ3khO8pknzN3DMcm/zjs+08sc/bQR/cai4=;
        b=vOZt/2ExLgAS1NvWe5/fkNhrIND0Yoto7KYlaR08h/irfxcwCdnxKDwtxXd7vXi7/h
         DAo8TClKPhT8UTynxuogGKGshn0/R08U/egIIpvRKrzOjlnKTTi9Sx7tfNw7fw8zEbpu
         vLLfHicro0abytZkfYwjxddSVB2WiGCwgEuPB2/o4AdxAIJfGcn+7EZjd5CjDsfDxML4
         Eq1v5xGZiltP6CmnHFu0zywWWcyFz4rJwGUkwL1M+vEAJYMC+VN/w3StJeXyIOFEI7UQ
         g4CUR32CrDqIzwUopz4x07VP3u1rkanQfgfL5T1IzqZ0SHaWFZ4lDw1vZUKQmOSSFdQa
         78XA==
X-Gm-Message-State: ACrzQf0eXfwSIXXMIxQVGRuQc7ndZjWCfXKGkdvlwuPVJoGrQlIgV+5x
        xhGYLUCfug1PHc9ZE+Fzlt00JB42bqtDh90TR9xFfA==
X-Google-Smtp-Source: AMsMyM4xPD69f6QOt0dKLBgsvfX5al/GH/hSsUB/J6P60geH3x3uc+o4NJzHCMRlYGpznaz9A0j0dFQpS1bRnEvDs3g=
X-Received: by 2002:a9d:68d1:0:b0:661:c3ac:c4c1 with SMTP id
 i17-20020a9d68d1000000b00661c3acc4c1mr16186225oto.150.1666598706435; Mon, 24
 Oct 2022 01:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ea4ae670-742b-424e-9363-c66ad9ee741c@palmer-ri-x1c9> <a2dc76e8-406e-5f27-0dc6-846c338660c9@sholland.org>
In-Reply-To: <a2dc76e8-406e-5f27-0dc6-846c338660c9@sholland.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 24 Oct 2022 13:34:55 +0530
Message-ID: <CAK9=C2WVDBKChp1kvVFz8rFGPgWBmtjr-qO_aYDQbsbWyn1PFQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, daniel.lezcano@linaro.org,
        tglx@linutronix.de, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        dmitriy@oss-tech.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:31 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 10/9/22 18:45, Palmer Dabbelt wrote:
> > On Thu, 29 Sep 2022 14:50:45 PDT (-0700), Conor Dooley wrote:
> >> On Sun, May 08, 2022 at 08:21:21PM -0500, Samuel Holland wrote:
> >>> Some implementations of the SBI time extension depend on hart-local
> >>> state (for example, CSRs) that are lost or hardware that is powered
> >>> down when a CPU is suspended. To be safe, the clockevents driver
> >>> cannot assume that timer IRQs will be received during CPU suspend.
> >>>
> >>> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
> >>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >>> ---
> >>>
> >>>  drivers/clocksource/timer-riscv.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/clocksource/timer-riscv.c
> >>> b/drivers/clocksource/timer-riscv.c
> >>> index 1767f8bf2013..593d5a957b69 100644
> >>> --- a/drivers/clocksource/timer-riscv.c
> >>> +++ b/drivers/clocksource/timer-riscv.c
> >>> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
> >>>  static unsigned int riscv_clock_event_irq;
> >>>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
> >>>      .name            = "riscv_timer_clockevent",
> >>> -    .features        = CLOCK_EVT_FEAT_ONESHOT,
> >>> +    .features        = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
> >
> > This is listed as being x86-specific in the header, but there's a hanful
> > of other ports that enable it for timers as well.  Looks like arm is
> > setting this based on DT, which seems reasonable to me: we're working
> > around a firmware bug, there should be some way to turn off that
> > workaround for firmware that doesn't have the bug. Looks like Intel already
> > turns this off when ARAT is supported, which seems to be the case for
> > anything modern, so maybe we're just tripping up on some untested behavior here?
> > I'm not sure exactly how we should probe this, but having it only enabled
> > when we need the workaround seems like the right way to go.
>
> I opened an issue against the SBI spec about what exactly it requires,
> but I got no responses:
>
> https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98
>
> My interpretation of the SBI specification is that it does not require
> maintaining any hart-local state across a non-retentive hart suspend.
> Unless the SBI spec says the timer must fire during/after suspend, then
> there is no firmware bug.

SBI spec only defines the mechanism to enter HART suspend state. All
other details (such as timer interrupt firing during/after suspend) are platform
or implementation specific which needs to be discovered from DT/ACPI.

>
> > That said, I'm not actually sure this C3STOP feature does what we want
> > given the commit description.  The timers on RISC-V are sort of in this
> > odd middle-ground between being per-CPU timers and system timers: the
> > time they produce is global (or at least close, due to the mtime
> > synchronization rules) but the actual interrupts are only one-shot and
> > only local.
>
> And if we cannot rely on the interrupt being delivered, we cannot rely
> on the SBI time extension to work across cpuidle entry.

Just like ARM, we need a DT property to discover this platform specific
behaviour.

I had sent out a small series to do this for DT.
Refer, "[PATCH v2 0/2] Improve CLOCK_EVT_FEAT_C3STOP feature setting"
https://lore.kernel.org/all/20220727114302.302201-1-apatel@ventanamicro.com/

>
> > From poking around the code I think this just tries to
> > setup a periodic broadcast timer, but since we use software fallbacks to
> > emulate those we'll still end up losing the interrupts/ticks if the CPU
> > that was asked for an interrupt has gone to sleep and lost that state.
>
> So by extension, non-retentive cpuidle states cannot be used if the SBI
> timer is the only available timer, since there is no hardware broadcast
> timer to use as a backup.
>
> > I'm not sure if I'm just misunderstanding what's going on here, though.
> > Is there something that describes the behavior this fixes in more detail?
>
> The motivating scenario for this patch is the C906, where the MTIMER is
> in the same reset domain as the CPU, so the timer state is lost during
> non-retentive suspend. Without this patch, if riscv_timer_clockevent is
> the current clockevent driver, then the CPU fails to wake up from
> suspend. However, this same problem would occur on any CPU where the
> timer or interrupt delivery stops working during suspend.

Yes, I recall CLOCK_EVT_FEAT_C3STOP was added for C906 but
we should go the DT/ACPI route.

Regards,
Anup

>
> >>>      .rating            = 100,
> >>>      .set_next_event        = riscv_clock_next_event,
> >>>  };
> >>
> >> After a bit of a painful bisection (with a misdirection into the v5.19
> >> printk reverts along the way) I have arrived at this commit for causing
> >> me some issues.
> >>
> >> If an AXI read to the PCIe controller on PolarFire SoC times out, the
> >> system will stall, with an expected:
> >>      io scheduler mq-deadline registered
> >>      io scheduler kyber registered
> >>      microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000
> >> ranges:
> >>      microchip-pcie 2000000000.pcie:      MEM
> >> 0x2008000000..0x2087ffffff -> 0x0008000000
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: axi read request error
> >>      microchip-pcie 2000000000.pcie: axi read timeout
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      Freeing initrd memory: 7336K
> >>      mc_event_handler: 667402 callbacks suppressed
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>      microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>      mc_event_handler: 666588 callbacks suppressed
> >> <truncated>
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     mc_event_handler: 666748 callbacks suppressed
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> >>     rcu:     0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002
> >> softirq=34/36 fqs=2626
> >>         (detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
> >>     Task dump for CPU 0:
> >>     task:swapper/0       state:R  running task     stack:    0 pid:
> >> 1 ppid:     0 flags:0x00000008
> >>     Call Trace:
> >>     mc_event_handler: 666648 callbacks suppressed
> >>
> >>  With this patch applied, the system just locks up without RCU stalling:
> >>     io scheduler mq-deadline registered
> >>     io scheduler kyber registered
> >>     microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000
> >> ranges:
> >>     microchip-pcie 2000000000.pcie:      MEM
> >> 0x2008000000..0x2087ffffff -> 0x0008000000
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: axi read request error
> >>     microchip-pcie 2000000000.pcie: axi read timeout
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> >>     microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> >>     Freeing initrd memory: 7332K
> >>
> >> As of yet, I have no idea if RCU stalls for other reasons would also be
> >> lost.
> >
> > Sorry this broke stuff.  I'm not entirely sure why this would mask RCU
> > stalls, but it seems like we're hitting some pretty odd paths here and
> > I'm not sure this is expected to work at all for us.
>
> I'm confused here. The RCU stall is itself a bug, right? Are you sure
> this patch is wrongly masking the stall, or is it possibly just avoiding
> some buggy code and not causing a stall in the first place?
>
> Regards,
> Samuel
>
> > If non-x86 architectures are meant to be able to set
> > CLOCK_EVT_FEAT_C3STOP, maybe we should document what it's supposed to do
> > in a more platform-agnostic fashion?
> >
> >> Thanks,
> >> Conor.
> >>
> >> git bisect start
> >> # status: waiting for both good and bad commits
> >> # good: [7699f7aacf3ebfee51c670b6f796b2797f0f7487] RISC-V: Prepare
> >> dropping week attribute from arch_kexec_apply_relocations[_add]
> >> git bisect good 7699f7aacf3ebfee51c670b6f796b2797f0f7487
> >> # bad: [63d5172e148bcc174398040861d867bbd2770be4] HACK: jogness
> >> git bisect bad 63d5172e148bcc174398040861d867bbd2770be4
> >> # good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag
> >> 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
> >> git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
> >> # good: [907bb57aa7b471872aab2f2e83e9713a145673f9] Merge tag
> >> 'pinctrl-v5.19-1' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> >> git bisect good 907bb57aa7b471872aab2f2e83e9713a145673f9
> >> # good: [4ad680f083ec360e0991c453e18a38ed9ae500d7] Merge tag
> >> 'staging-5.19-rc1' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> >> git bisect good 4ad680f083ec360e0991c453e18a38ed9ae500d7
> >> # good: [23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1] Merge tag
> >> 'for-5.19/parisc-2' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> >> git bisect good 23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1
> >> # bad: [7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0] Merge tag
> >> 'gpio-fixes-for-v5.19-rc2' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> >> git bisect bad 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
> >> # bad: [1f192b9e8d8a5c619b33a868fb1af063af65ce5d] Merge tag
> >> 'drm-misc-fixes-2022-06-09' of
> >> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
> >> git bisect bad 1f192b9e8d8a5c619b33a868fb1af063af65ce5d
> >> # good: [b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8] Merge tag
> >> 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> >> git bisect good b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8
> >> # bad: [e17fee8976c3d2ccf9add6d6c8912a37b025d840] Merge tag
> >> 'mm-nonmm-stable-2022-06-05' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >> git bisect bad e17fee8976c3d2ccf9add6d6c8912a37b025d840
> >> # bad: [c049ecc523171481accd2c83f79ffeecbf53a915] Merge tag
> >> 'timers-core-2022-06-05' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> >> git bisect bad c049ecc523171481accd2c83f79ffeecbf53a915
> >> # bad: [9c04a8ff03def4df3f81219ffbe1ec9b44ff5348]
> >> clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
> >> git bisect bad 9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
> >> # bad: [7160d9c4cce94612d5f42a5db392cd606a38737a]
> >> clocksource/drivers/armada-370-xp: Convert to SPDX identifier
> >> git bisect bad 7160d9c4cce94612d5f42a5db392cd606a38737a
> >> # bad: [a98399cbc1e05f7b977419f03905501d566cf54e]
> >> clocksource/drivers/sp804: Avoid error on multiple instances
> >> git bisect bad a98399cbc1e05f7b977419f03905501d566cf54e
> >> # good: [41929c9f628b9990d33a200c54bb0c919e089aa8]
> >> clocksource/drivers/ixp4xx: Drop boardfile probe path
> >> git bisect good 41929c9f628b9990d33a200c54bb0c919e089aa8
> >> # bad: [232ccac1bd9b5bfe73895f527c08623e7fa0752d]
> >> clocksource/drivers/riscv: Events are stopped during CPU suspend
> >> git bisect bad 232ccac1bd9b5bfe73895f527c08623e7fa0752d
> >> # first bad commit: [232ccac1bd9b5bfe73895f527c08623e7fa0752d]
> >> clocksource/drivers/riscv: Events are stopped during CPU suspend
>
