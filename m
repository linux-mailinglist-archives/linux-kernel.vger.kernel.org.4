Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7124E72CD00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjFLRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjFLRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABD1BFD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C8562C25
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C36C4339B;
        Mon, 12 Jun 2023 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686591355;
        bh=yC5mi0XHtFLtIv5jLmar9jZwOk85IwJ3eKL6+ztXRvM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fcFgNk+B1+RWU1Yja2l/rB3cVIJfFbRkcTNtESIVYy+A2BQIvAAVLpAXSl4hcE4g0
         y24jT/5PPmP5n+EoQSSX2SSw54TIfOiLB8a4KGEs7V3V0cU3BDujndngxdlP02Bxtj
         vaofVez8+4vzTFqH2Y4uBOtHqKXPksh2qOQdyDLh8FTwH2WZDcqRNLpqR4S3V0XFYG
         aiZNm1HQJriOYSitf6EePTEdpLwuZQxrJ1ZsOc70fGmtvicN5mCqz6zdrbOXOlIqLF
         lqPZWHg0sUIxpcYLLczq5FefKYAyBUkMh4nCypfuRH4gvZWkfZvJexj1V+F6TuggTI
         pCXko+RIau8oQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <20230612110958.592674-1-brent.lu@intel.com>
References: <20230612110958.592674-1-brent.lu@intel.com>
Subject: Re: [PATCH 00/12] ASoC: Intel: avs: remove redundant dapm routes
Message-Id: <168659135251.88952.16253642341528642250.b4-ty@kernel.org>
Date:   Mon, 12 Jun 2023 18:35:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2023 19:09:46 +0800, Brent Lu wrote:
> This patch series remove redundant dapm routes declared in multiple machine
> drivers. These routes will be created by snd_soc_dapm_connect_dai_link_widgets()
> during soundcard initialization. Following is the kernel log from a KBL
> chromebook nocturne.
> 
> dmic:
> [   13.773455] avs_dmic avs_dmic: connected DAI link dmic-codec:Capture -> dmic-platform:DMIC Rx
> [   13.773460] avs_dmic avs_dmic: connected DAI link dmic-codec:Capture -> dmic-platform:DMIC WoV Rx
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: Intel: avs-da7219: remove redundant dapm routes
        commit: 530ca0a7ed04230408775b495034941346ea5db1
[02/12] ASoC: Intel: avs-dmic: remove redundant dapm routes
        commit: c2076f4fa4f15559ed7e568186c4089479a62154
[03/12] ASoC: Intel: avs-hdaudio: remove redundant dapm routes
        commit: 12ea56d73c548929ef1a498848905b04bfe85f90
[04/12] ASoC: Intel: avs-max98357a: remove redundant dapm routes
        commit: d48e3cd5aaecd7769b073f65bb95004a54bc76e6
[05/12] ASoC: Intel: avs-max98373: remove redundant dapm routes
        commit: b4df7ce9905b1e8cb84ee247ca7db6ae004bc508
[06/12] ASoC: Intel: avs-max98927: remove redundant dapm routes
        commit: 9868ca64fd7a87cf997040452519b07e47a8d008
[07/12] ASoC: Intel: avs-nau8825: remove redundant dapm routes
        commit: ae7d66822de5aeaf991eda96c823ee9dffebfe46
[08/12] ASoC: Intel: avs-rt274: remove redundant dapm routes
        commit: 6227269fb375af2ff239a68499856abfd6a2bceb
[09/12] ASoC: Intel: avs-rt286: remove redundant dapm routes
        commit: cca1ac1f097afa7ad6e587d6f1e86fd738ede508
[10/12] ASoC: Intel: avs-rt298: remove redundant dapm routes
        commit: eae0655316a5d741ab27c7b3a67a55b0af970e19
[11/12] ASoC: Intel: avs-rt5682: remove redundant dapm routes
        commit: 96b5452fe43c23451050b3efa5197bd10dce9bc6
[12/12] ASoC: Intel: avs-ssm4567: remove redundant dapm routes
        commit: 51bdf6ebe5b7da8d1b86cf66fe7e21de353e5218

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

