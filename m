Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBF5EFF67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiI2VvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI2Vuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D7125DA6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 14:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EE29B82680
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 21:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E84C433C1;
        Thu, 29 Sep 2022 21:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664488250;
        bh=iGUp7VIeUN/ZWvk8RO77IvV3MaCQ4WUCXUtZ3sjWMRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmfPpgSRBz0JBVqj0xGpXMEQwBUud0CRXUA1ugugE5gfSq8op1bOfhF0spyQUteKT
         kXo1k+sfG1AmmVojdPtsOVKa9ySPrQZYQEfj41D1Sf2EJ/c8Jm3fXCWKNw/GcptDP7
         4/mHFYxACL7qsnJdNoWFqFaQfw47+9ykm9zLLmLUaAw7GjgGQpddxmfg4N9C7rFcRV
         aCvq4kcRNDsH74FM2SG0w1MVj4RUy9mRg7dIV4K8P8xXZK5FHpeN9saipZ5IZrzFZX
         JWCjIW6w0MO48qcijlwrSshJYEs1/SmfQqh0WP5opsrv5IoZgwNsLRCUJiuqdNTg1q
         N3P2mzSAdPpBg==
Date:   Thu, 29 Sep 2022 22:50:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] clocksource/drivers/riscv: Events are stopped during CPU
 suspend
Message-ID: <YzYTNQRxLr7Q9JR0@spud>
References: <20220509012121.40031-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509012121.40031-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 08:21:21PM -0500, Samuel Holland wrote:
> Some implementations of the SBI time extension depend on hart-local
> state (for example, CSRs) that are lost or hardware that is powered
> down when a CPU is suspended. To be safe, the clockevents driver
> cannot assume that timer IRQs will be received during CPU suspend.
> 
> Fixes: 62b019436814 ("clocksource: new RISC-V SBI timer driver")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/clocksource/timer-riscv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 1767f8bf2013..593d5a957b69 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -34,7 +34,7 @@ static int riscv_clock_next_event(unsigned long delta,
>  static unsigned int riscv_clock_event_irq;
>  static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
>  	.name			= "riscv_timer_clockevent",
> -	.features		= CLOCK_EVT_FEAT_ONESHOT,
> +	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
>  	.rating			= 100,
>  	.set_next_event		= riscv_clock_next_event,
>  };

After a bit of a painful bisection (with a misdirection into the v5.19
printk reverts along the way) I have arrived at this commit for causing
me some issues.

If an AXI read to the PCIe controller on PolarFire SoC times out, the
system will stall, with an expected:
	 io scheduler mq-deadline registered
	 io scheduler kyber registered
	 microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
	 microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: axi read request error
	 microchip-pcie 2000000000.pcie: axi read timeout
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 Freeing initrd memory: 7336K
	 mc_event_handler: 667402 callbacks suppressed
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	 microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	 mc_event_handler: 666588 callbacks suppressed
<truncated>
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	mc_event_handler: 666748 callbacks suppressed
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	rcu: 	0-...0: (1 GPs behind) idle=19f/1/0x4000000000000002 softirq=34/36 fqs=2626 
		(detected by 1, t=5256 jiffies, g=-1151, q=1143 ncpus=4)
	Task dump for CPU 0:
	task:swapper/0       state:R  running task     stack:    0 pid:    1 ppid:     0 flags:0x00000008
	Call Trace:
	mc_event_handler: 666648 callbacks suppressed

 With this patch applied, the system just locks up without RCU stalling:
	io scheduler mq-deadline registered
	io scheduler kyber registered
	microchip-pcie 2000000000.pcie: host bridge /soc/pcie@2000000000 ranges:
	microchip-pcie 2000000000.pcie:      MEM 0x2008000000..0x2087ffffff -> 0x0008000000
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: axi read request error
	microchip-pcie 2000000000.pcie: axi read timeout
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: sec error in pcie2axi buffer
	microchip-pcie 2000000000.pcie: ded error in pcie2axi buffer
	Freeing initrd memory: 7332K

As of yet, I have no idea if RCU stalls for other reasons would also be
lost.

Thanks,
Conor.

git bisect start
# status: waiting for both good and bad commits
# good: [7699f7aacf3ebfee51c670b6f796b2797f0f7487] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
git bisect good 7699f7aacf3ebfee51c670b6f796b2797f0f7487
# bad: [63d5172e148bcc174398040861d867bbd2770be4] HACK: jogness
git bisect bad 63d5172e148bcc174398040861d867bbd2770be4
# good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# good: [907bb57aa7b471872aab2f2e83e9713a145673f9] Merge tag 'pinctrl-v5.19-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect good 907bb57aa7b471872aab2f2e83e9713a145673f9
# good: [4ad680f083ec360e0991c453e18a38ed9ae500d7] Merge tag 'staging-5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect good 4ad680f083ec360e0991c453e18a38ed9ae500d7
# good: [23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1] Merge tag 'for-5.19/parisc-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux
git bisect good 23df9ba64bb9e26cfee6b34f5c3ece49a8a61ee1
# bad: [7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0] Merge tag 'gpio-fixes-for-v5.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad 7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0
# bad: [1f192b9e8d8a5c619b33a868fb1af063af65ce5d] Merge tag 'drm-misc-fixes-2022-06-09' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
git bisect bad 1f192b9e8d8a5c619b33a868fb1af063af65ce5d
# good: [b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8
# bad: [e17fee8976c3d2ccf9add6d6c8912a37b025d840] Merge tag 'mm-nonmm-stable-2022-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad e17fee8976c3d2ccf9add6d6c8912a37b025d840
# bad: [c049ecc523171481accd2c83f79ffeecbf53a915] Merge tag 'timers-core-2022-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad c049ecc523171481accd2c83f79ffeecbf53a915
# bad: [9c04a8ff03def4df3f81219ffbe1ec9b44ff5348] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
git bisect bad 9c04a8ff03def4df3f81219ffbe1ec9b44ff5348
# bad: [7160d9c4cce94612d5f42a5db392cd606a38737a] clocksource/drivers/armada-370-xp: Convert to SPDX identifier
git bisect bad 7160d9c4cce94612d5f42a5db392cd606a38737a
# bad: [a98399cbc1e05f7b977419f03905501d566cf54e] clocksource/drivers/sp804: Avoid error on multiple instances
git bisect bad a98399cbc1e05f7b977419f03905501d566cf54e
# good: [41929c9f628b9990d33a200c54bb0c919e089aa8] clocksource/drivers/ixp4xx: Drop boardfile probe path
git bisect good 41929c9f628b9990d33a200c54bb0c919e089aa8
# bad: [232ccac1bd9b5bfe73895f527c08623e7fa0752d] clocksource/drivers/riscv: Events are stopped during CPU suspend
git bisect bad 232ccac1bd9b5bfe73895f527c08623e7fa0752d
# first bad commit: [232ccac1bd9b5bfe73895f527c08623e7fa0752d] clocksource/drivers/riscv: Events are stopped during CPU suspend

