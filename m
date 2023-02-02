Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30040688590
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 18:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjBBRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBBRhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 12:37:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1076414
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 09:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A794861C2E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 17:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ADCC433EF;
        Thu,  2 Feb 2023 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359411;
        bh=KP9QG+sF1vvAP8/fJTd2GxrPLXDXXes9zY/KqqcMzXQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qJgdXMIOKV+BIEjYZHCjYi0ndbfkZikCDfUjoKCzrcUQtarRubsV6+lKykcbbnMze
         VxEy0cBTDBiab9BBFXFMmmCQt3uwkdTEisKHs9+dyB19LF36i8XYUFj2hzji8lTpyj
         oqs3djFZfAM5aWSzGjHVYrH57LOMbwojMGRaMiLdv2qxuusATlJQoeem1+51QBMfhM
         GOjDGECr3IxaAoCyLItm9LK2egmjAGk1Fxus2MMqPDvaTWxE+8g8zuLZmhx+GZnzPK
         oJSSCA9/6HghTfGM29l62ITB32XMot5iUdf0+/AuGVKrO22mLbGnOlwxFSuky36Vn0
         OtzAo2eQePIag==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        ssabakar@amd.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20230203123254.1898794-1-Vsujithkumar.Reddy@amd.com>
References: <20230203123254.1898794-1-Vsujithkumar.Reddy@amd.com>
Subject: Re: [PATCH] ASoC: SOF: amd: Fix for handling spurious interrupts
 from DSP
Message-Id: <167535940664.1002862.2489220522555148757.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 17:36:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Feb 2023 18:02:52 +0530, V sujith kumar Reddy wrote:
> As interrupts are Level-triggered,unless and until we deassert the register
> the interrupts are generated which causes spurious interrupts unhandled.
> 
> Now we deasserted the interrupt at top half which solved the below
> "nobody cared" warning.
> 
> warning reported in dmesg:
> 	irq 80: nobody cared (try booting with the "irqpoll" option)
> 	CPU: 5 PID: 2735 Comm: irq/80-AudioDSP
> 		Not tainted 5.15.86-15817-g4c19f3e06d49 #1 1bd3fd932cf58caacc95b0504d6ea1e3eab22289
> 	Hardware name: Google Skyrim/Skyrim, BIOS Google_Skyrim.15303.0.0 01/03/2023
> 	Call Trace:
> 	<IRQ>
> 	dump_stack_lvl+0x69/0x97
> 	 __report_bad_irq+0x3a/0xae
> 	note_interrupt+0x1a9/0x1e3
> 	handle_irq_event_percpu+0x4b/0x6e
> 	handle_irq_event+0x36/0x5b
> 	handle_fasteoi_irq+0xae/0x171
> 	 __common_interrupt+0x48/0xc4
> 	</IRQ>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: amd: Fix for handling spurious interrupts from DSP
      commit: 2e7c6652f9b86c01cbd4e988057a746a3a461969

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

