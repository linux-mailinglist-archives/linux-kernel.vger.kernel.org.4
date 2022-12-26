Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47865660A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiLZXeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLZXeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:34:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4AF271D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 15:34:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC96660ECE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DE1C433F0;
        Mon, 26 Dec 2022 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097639;
        bh=cx2UV/XZSUwl0u2PvYhFJExdluhmE61BWnOpv7ZABhE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mLy/XBMywYSr9ZHF43thfnROkic5Ai7ApzlfYn6YChs6ih7Gl2U1QfJQ1+tVO9Rkc
         zaWIhjUItUBzL17RJvrYwqn1xTBXVSWd/Y1FN2rJbfN0xUvGhHdyF0QVqoMK4ImlBj
         0/DMirhlVpG9gEBXBLz3nQ+OxW0kqcw1jaqXDUrpBPlx8Cnz25dl3Ad9WdieWBnFQ6
         CH/bLvksgG49ubvwIVzuU7c9gq2OCoiVA5fsHE58T6HeFA1KcVE5A8O4hwTLkhgc1r
         Z0u4xfS77iMEpAxduEtAsiAGRC4gV3Rto/Wu5TOOOdGY+7Gyg2yF1VhUE4ISVFQEt3
         duIWgTEvkz82g==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Yong Zhi <yong.zhi@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
References: <20221216154938.9426-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v2] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
Message-Id: <167209763526.330820.3472409126479136319.b4-ty@kernel.org>
Date:   Mon, 26 Dec 2022 23:33:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-7ab1d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 23:49:38 +0800, Ajye Huang wrote:
> This patch adds the driver data for two nau8318 speaker amplifiers on
> SSP1 and nau8825 on SSP0 for ADL platform.
> 
> The nau8315 and nau8318 are both Nuvoton Amp chips. They use the same
> Amp driver nau8315.c. The acpi_device_id for nau8315 is "NVTN2010",
> for nau8318 is "NVTN2012".
> The nau8825 is one of Nuvoton headset codec, and its acpi_device_id is
> "10508825".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
      commit: ba7523bb0f494fc440d3a9bb0b665cfcaa192d0c

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
