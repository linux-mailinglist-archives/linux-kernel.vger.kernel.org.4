Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BB70F4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjEXLEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjEXLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09D13E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965B063BB0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BA9C433A0;
        Wed, 24 May 2023 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684926274;
        bh=y4WSNpY8SSlTpEkkRsMR3TAjOQ7RO5pCexsKa6zngko=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L/pMlrXcgXt6WJjXMv4dfRYRfzLEBarU/2p8aA+heUgPV+acQkfqSzi+gk38g7uUl
         bBZhvJDCIqazncp3Q997xhWffiPHkas9lwRdnTwCoY7pKwuKjNkN+yFmDZwtknsiLV
         dGXCcl1LVgMkTLOUP0Hvu8hB8rlNuOUvjOKFA/rWkmVbBw2YcXUtCmQdsvBDczTOBj
         QTSRj6upQLkfPWmcoo2oOkjogx5ggtBpxxUNlTmI8foKlwtyzDYV0nY2Rua7EdW0bI
         QUJ0eBbASpaIoZR/LOMfoKMYleR0zst0L18QI4XqLRpabkh3xP8apUWJ0o08Aw7wD/
         k++pHEcNZkgbQ==
From:   Mark Brown <broonie@kernel.org>
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230512110343.66664-1-fido_max@inbox.ru>
References: <20230512110343.66664-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] ASoC: dwc: move DMA init to snd_soc_dai_driver
 probe()
Message-Id: <168492627199.37175.12727003456067615127.b4-ty@kernel.org>
Date:   Wed, 24 May 2023 12:04:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 14:03:42 +0300, Maxim Kochetkov wrote:
> When using DMA mode we are facing with Oops:
> [  396.458157] Unable to handle kernel access to user memory without uaccess routines at virtual address 000000000000000c
> [  396.469374] Oops [#1]
> [  396.471839] Modules linked in:
> [  396.475144] CPU: 0 PID: 114 Comm: arecord Not tainted 6.0.0-00164-g9a8eccdaf2be-dirty #68
> [  396.483619] Hardware name: YMP ELCT FPGA (DT)
> [  396.488156] epc : dmaengine_pcm_open+0x1d2/0x342
> [  396.493227]  ra : dmaengine_pcm_open+0x1d2/0x342
> [  396.498140] epc : ffffffff807fe346 ra : ffffffff807fe346 sp : ffffffc804e138f0
> [  396.505602]  gp : ffffffff817bf730 tp : ffffffd8042c8ac0 t0 : 6500000000000000
> [  396.513045]  t1 : 0000000000000064 t2 : 656e69676e65616d s0 : ffffffc804e13990
> [  396.520477]  s1 : ffffffd801b86a18 a0 : 0000000000000026 a1 : ffffffff816920f8
> [  396.527897]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
> [  396.535319]  a5 : 0000000000000000 a6 : ffffffd801b87040 a7 : 0000000000000038
> [  396.542740]  s2 : ffffffd801b94a00 s3 : 0000000000000000 s4 : ffffffd80427f5e8
> [  396.550153]  s5 : ffffffd80427f5e8 s6 : ffffffd801b44410 s7 : fffffffffffffff5
> [  396.557569]  s8 : 0000000000000800 s9 : 0000000000000001 s10: ffffffff8066d254
> [  396.564978]  s11: ffffffd8059cf768 t3 : ffffffff817d5577 t4 : ffffffff817d5577
> [  396.572391]  t5 : ffffffff817d5578 t6 : ffffffc804e136e8
> [  396.577876] status: 0000000200000120 badaddr: 000000000000000c cause: 000000000000000d
> [  396.586007] [<ffffffff806839f4>] snd_soc_component_open+0x1a/0x68
> [  396.592439] [<ffffffff807fdd62>] __soc_pcm_open+0xf0/0x502
> [  396.598217] [<ffffffff80685d86>] soc_pcm_open+0x2e/0x4e
> [  396.603741] [<ffffffff8066cea4>] snd_pcm_open_substream+0x442/0x68e
> [  396.610313] [<ffffffff8066d1ea>] snd_pcm_open+0xfa/0x212
> [  396.615868] [<ffffffff8066d39c>] snd_pcm_capture_open+0x3a/0x60
> [  396.622048] [<ffffffff8065b35a>] snd_open+0xa8/0x17a
> [  396.627421] [<ffffffff801ae036>] chrdev_open+0xa0/0x218
> [  396.632893] [<ffffffff801a5a28>] do_dentry_open+0x17c/0x2a6
> [  396.638713] [<ffffffff801a6d9a>] vfs_open+0x1e/0x26
> [  396.643850] [<ffffffff801b8544>] path_openat+0x96e/0xc96
> [  396.649518] [<ffffffff801b9390>] do_filp_open+0x7c/0xf6
> [  396.655034] [<ffffffff801a6ff2>] do_sys_openat2+0x8a/0x11e
> [  396.660765] [<ffffffff801a735a>] sys_openat+0x50/0x7c
> [  396.666068] [<ffffffff80003aca>] ret_from_syscall+0x0/0x2
> [  396.674964] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: move DMA init to snd_soc_dai_driver probe()
      commit: 011a8719d6105dcb48077ea7a6a88ac019d4aa50

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

