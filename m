Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229175F94C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJJALI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 20:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJJAKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 20:10:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F658DFD
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 16:45:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 70so8536991pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 16:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ek3k88x+48cHFgh49huKZfBPc/vqE+ORbnY3ep3OiIg=;
        b=Dor/dVmVq/23dSVQsk0zm+2Ma7RjPD7igDGLvD46yn+Vhs3F0nkJxBBm2iQ6tVc21G
         Dh/nue+e3fQvPp7pKipGQaETzxhnQC+c22O7m4xDxmjhtmkySX1qo+zK+hiArZLGHPYV
         bT20EhmURB/Pl2xowYroOqv5ZGK1xfqruuwYdutW4PWoxAV0Abnj/haq4qXDod0vhYN9
         sjtJIc2XV3W2wuauv6VSOho+OgJ7Bsl/FT5+wdUENYfcPkgiRgSFQBQE3y8xdmDp1q56
         yk7J4PBgGebj/yZJ7F9ue5Q+RjQmYzwhFjYiTRI3l8ZeLv9EJ22AfPRI1a1Sh8mVV0zK
         FoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek3k88x+48cHFgh49huKZfBPc/vqE+ORbnY3ep3OiIg=;
        b=zUgKk4Q69wLCk3tsJIVyD3QLsMzNpIkaB5A1FaddE5bVuH6T3WYUusQDRCR2w7cHOp
         2MJ3im6tWOvge5jukqP+insjI4BVBcjrwLkFq2FduVxvdIZcKJWLgheQy3ZPS+WI/8Gc
         xaM4Vlc870hmyp77wn9hvJEbOwqtE8nkY8eRjb+lM5rddynbssMVxsCBMMQ2eEUsmxPy
         X42VTEvLzx+GZPLDlpSFEF6SYx7958dagJ/DXMQO1i3tYPDHNerkrOCqDjw5q0v+Knpc
         NFOvV3BfBypnDCm6Wy90mbhWjPK+V8pEbjsrH0BR+988pg8vmM/akxsnzhKNrIVP46WJ
         +Zsw==
X-Gm-Message-State: ACrzQf3vZA2fo3VI4TH4HXleQW86DBCqwK0aPRGAIcNb6F99S7jmIFok
        K0QLiHSvmF5WSC/jFVae04bDCA==
X-Google-Smtp-Source: AMsMyM7LzKRdldoWEMa8fRpSbPYmTSfdCvIFv0FjCX8JtYwVDklL1LlgsOczCdj92iWu8OrqHdJuNA==
X-Received: by 2002:a17:90b:4c92:b0:20b:a13:83c7 with SMTP id my18-20020a17090b4c9200b0020b0a1383c7mr21365651pjb.128.1665359138075;
        Sun, 09 Oct 2022 16:45:38 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id h12-20020a63df4c000000b00459a36795cbsm5091638pgj.42.2022.10.09.16.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 16:45:37 -0700 (PDT)
Date:   Sun, 09 Oct 2022 16:45:37 -0700 (PDT)
X-Google-Original-Date: Sun, 09 Oct 2022 16:38:08 PDT (-0700)
Subject:     Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU suspend
In-Reply-To: <YzYTNQRxLr7Q9JR0@spud>
CC:     samuel@sholland.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        aou@eecs.berkeley.edu, atishp@atishpatra.org, dmitriy@oss-tech.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-ea4ae670-742b-424e-9363-c66ad9ee741c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 14:50:45 PDT (-0700), Conor Dooley wrote:
> On Sun, May 08, 2022 at 08:21:21PM -0500, Samuel Holland wrote:
>> Some implementations of the SBI time extension depend on hart-local
>> state (for example, CSRs) that are lost or hardware that is powered
>> down when a CPU is suspended. To be safe, the clockevents driver
>> cannot assume that timer IRQs will be received during CPU suspend.
>>
>> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/clocksource/timer-riscv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index 1767f8bf2013..593d5a957b69 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
>>  static unsigned int riscv_clock_event_irq;
>>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>>  	.name			= "riscv_timer_clockevent",
>> -	.features		= CLOCK_EVT_FEAT_ONESHOT,
>> +	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,

This is listed as being x86-specific in the header, but there's a hanful 
of other ports that enable it for timers as well.  Looks like arm is 
setting this based on DT, which seems reasonable to me: we're working 
around a firmware bug, there should be some way to turn off that 
workaround for firmware that doesn't have the bug. Looks like Intel already
turns this off when ARAT is supported, which seems to be the case for anything
modern, so maybe we're just tripping up on some untested behavior here?  I'm
not sure exactly how we should probe this, but having it only enabled when we
need the workaround seems like the right way to go.

That said, I'm not actually sure this C3STOP feature does what we want 
given the commit description.  The timers on RISC-V are sort of in this 
odd middle-ground between being per-CPU timers and system timers: the 
time they produce is global (or at least close, due to the mtime 
synchronization rules) but the actual interrupts are only one-shot and 
only local.  From poking around the code I think this just tries to 
setup a periodic broadcast timer, but since we use software fallbacks 
to emulate those we'll still end up losing the interrupts/ticks if the 
CPU that was asked for an interrupt has gone to sleep and lost that 
state.

I'm not sure if I'm just misunderstanding what's going on here, though.  
Is there something that describes the behavior this fixes in more 
detail?

>>  	.rating			= 100,
>>  	.set_next_event		= riscv_clock_next_event,
>>  };
>
> After a bit of a painful bisection (with a misdirection into the v5.19
> printk reverts along the way) I have arrived at this commit for causing
> me some issues.
>
> If an AXI read to the PCIe controller on PolarFire SoC times out, the
> system will stall, with an expected:
> 	 io scheduler mq-deadline registered
> 	 io scheduler kyber registered
> 	 microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> 	 microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: axi read request error
> 	 microchip-pcie 2000000000.pcie: axi read timeout
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 Freeing initrd memory: 7336K
> 	 mc_event_handler: 667402 callbacks suppressed
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	 mc_event_handler: 666588 callbacks suppressed
> <truncated>
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	mc_event_handler: 666748 callbacks suppressed
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> 	rcu: 	0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002 softirq=34/36 fqs=2626
> 		(detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
> 	Task dump for CPU 0:
> 	task:swapper/0       state:R  running task     stack:    0 pid:    1 ppid:     0 flags:0x00000008
> 	Call Trace:
> 	mc_event_handler: 666648 callbacks suppressed
>
>  With this patch applied, the system just locks up without RCU stalling:
> 	io scheduler mq-deadline registered
> 	io scheduler kyber registered
> 	microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
> 	microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: axi read request error
> 	microchip-pcie 2000000000.pcie: axi read timeout
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
> 	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
> 	Freeing initrd memory: 7332K
>
> As of yet, I have no idea if RCU stalls for other reasons would also be
> lost.

Sorry this broke stuff.  I'm not entirely sure why this would mask RCU 
stalls, but it seems like we're hitting some pretty odd paths here and 
I'm not sure this is expected to work at all for us.

If non-x86 architectures are meant to be able to set 
CLOCK_EVT_FEAT_C3STOP, maybe we should document what it's supposed to do 
in a more platform-agnostic fashion?

> Thanks,
> Conor.
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [7699f7aacf3ebfee51c670b6f796b2797f0f7487] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
> git bisect good 7699f7aacf3ebfee51c670b6f796b2797f0f7487
> # bad: [63d5172e148bcc174398040861d867bbd2770be4] HACK: jogness
> git bisect bad 63d5172e148bcc174398040861d867bbd2770be4
> # good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
> git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
> # good: [907bb57aa7b471872aab2f2e83e9713a145673f9] Merge tag 'pinctrl-v5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
> git bisect good 907bb57aa7b471872aab2f2e83e9713a145673f9
> # good: [4ad680f083ec360e0991c453e18a38ed9ae500d7] Merge tag 'staging-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect good 4ad680f083ec360e0991c453e18a38ed9ae500d7
> # good: [23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1] Merge tag 'for-5.19/parisc-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
> git bisect good 23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1
> # bad: [7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0] Merge tag 'gpio-fixes-for-v5.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> git bisect bad 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
> # bad: [1f192b9e8d8a5c619b33a868fb1af063af65ce5d] Merge tag 'drm-misc-fixes-2022-06-09' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
> git bisect bad 1f192b9e8d8a5c619b33a868fb1af063af65ce5d
> # good: [b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect good b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8
> # bad: [e17fee8976c3d2ccf9add6d6c8912a37b025d840] Merge tag 'mm-nonmm-stable-2022-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad e17fee8976c3d2ccf9add6d6c8912a37b025d840
> # bad: [c049ecc523171481accd2c83f79ffeecbf53a915] Merge tag 'timers-core-2022-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad c049ecc523171481accd2c83f79ffeecbf53a915
> # bad: [9c04a8ff03def4df3f81219ffbe1ec9b44ff5348] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
> git bisect bad 9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
> # bad: [7160d9c4cce94612d5f42a5db392cd606a38737a] clocksource/drivers/armada-370-xp: Convert to SPDX identifier
> git bisect bad 7160d9c4cce94612d5f42a5db392cd606a38737a
> # bad: [a98399cbc1e05f7b977419f03905501d566cf54e] clocksource/drivers/sp804: Avoid error on multiple instances
> git bisect bad a98399cbc1e05f7b977419f03905501d566cf54e
> # good: [41929c9f628b9990d33a200c54bb0c919e089aa8] clocksource/drivers/ixp4xx: Drop boardfile probe path
> git bisect good 41929c9f628b9990d33a200c54bb0c919e089aa8
> # bad: [232ccac1bd9b5bfe73895f527c08623e7fa0752d] clocksource/drivers/riscv: Events are stopped during CPU suspend
> git bisect bad 232ccac1bd9b5bfe73895f527c08623e7fa0752d
> # first bad commit: [232ccac1bd9b5bfe73895f527c08623e7fa0752d] clocksource/drivers/riscv: Events are stopped during CPU suspend
