Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B665660D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 00:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiLZXep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 18:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiLZXeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 18:34:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5517267C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 15:34:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0501ECE0E60
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 23:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C2AC433F1;
        Mon, 26 Dec 2022 23:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672097652;
        bh=hI0abZTfZBfmL7iS41Sw/Kw7JuoSmWB5bH2uy6CIx0Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=SO5NI+Q8paXlF7tZMy3yL1VvIsR8LUFy1NOHEw7fxL2wJT08iQDN+HPe7hAd8wQhi
         S3KaqrRQ9EbvAvIbrCXgjuvBrzpBjnaYGlHkb6RCYX//PeRwmmlnjW//sVi9eJ8CDm
         JTvetu5X0ghrAQRcJFc5j1PIHsxC7cir5nh7NAVE3vgWgdaKzarPSvYph/n+ERPmpe
         NDO562ouyEeJdZ94jfLHSy3WHyvWL0F5Af5oEQAakm3QdzWWyT53XdiSh6VkYN6qdH
         0GzKgFEt6e7ljg7Fe+dWG2cG+M6GVwfC6GZbD+hNygvg/6WZ1KOdu+7unjIn5E7OqJ
         G/mDKqY4Yb45w==
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
        "balamurugan . c" <balamurugan.c@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        David Lin <CTLIN0@nuvoton.com>, Brent Lu <brent.lu@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20221222042624.557869-1-ajye_huang@compal.corp-partner.google.com>
References: <20221222042624.557869-1-ajye_huang@compal.corp-partner.google.com>
Subject: Re: [PATCH v3] ASoC: Intel: sof_nau8825: add variant with nau8318 amplifier.
Message-Id: <167209764839.330820.10080062555953013632.b4-ty@kernel.org>
Date:   Mon, 26 Dec 2022 23:34:08 +0000
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

On Thu, 22 Dec 2022 12:26:24 +0800, Ajye Huang wrote:
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
