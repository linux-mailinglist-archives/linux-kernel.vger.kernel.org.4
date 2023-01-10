Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D337B66469A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjAJQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjAJQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:53:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47DF18E18;
        Tue, 10 Jan 2023 08:53:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C2461795;
        Tue, 10 Jan 2023 16:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B11C433F1;
        Tue, 10 Jan 2023 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673369629;
        bh=SollqPHgY5I7lTwviKqNUa8+yrbzo1QLNEo3j1yUsrE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pcx4YAWaJufTQxXy4GmIV8Y1noj4cbwA15h92+yCwAy6+iAD1g4NCRKi+Pc/MhOrA
         9fZmAqK66hDCjjocSouT92wlgPUXT2FnN45SDl130vtR53DfSKC1oQEkT0Lx7E1SL1
         ltLqOXveg2pUrYZePevnJZCfBbzXF9kpl0BYd47uoGh72YpWX86DYd0ZURIMAlMzGC
         V8yVDpk/rzieN+Y7QR7ojyEB6u6BY/t2e41t2iEnUI/PFt4CbIk+sm+jdpd1KO99+1
         TA1i1vL7vlBrlVJ3Bpm+HFBdpWcpCrAlBH+y7CN7NvNMBTM8gXCBdNIY7wXWVZeel0
         OazQiUHiDX+Dw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <error27@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20221222072150.10627-1-tinghan.shen@mediatek.com>
References: <20221222072150.10627-1-tinghan.shen@mediatek.com>
Subject: Re: [PATCH v1 0/3] Add support of MediaTek mt8188 to SOF
Message-Id: <167336962456.1940041.13852570954333682480.b4-ty@kernel.org>
Date:   Tue, 10 Jan 2023 16:53:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2022 15:21:47 +0800, Tinghan Shen wrote:
> Add support of MediaTek mt8188 SoC DSP to SOF.
> The sof driver patches in this series are taken from
> thesofproject/linux/tree/topic/sof-dev-rebase.
> 
> Tinghan Shen (3):
>   dt-bindings: dsp: mediatek: Add mt8188 dsp compatible
>   ASoC: SOF: mediatek: Support mt8188 platform
>   ASoC: SOF: mediatek: Provide debugfs_add_region_item ops for core
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: dsp: mediatek: Add mt8188 dsp compatible
      commit: e15ec6892832d586069ce575c222366b94ad6a5e
[2/3] ASoC: SOF: mediatek: Support mt8188 platform
      commit: 6b43538f0698695fba9aa0c0b29a80c555cf1b63
[3/3] ASoC: SOF: mediatek: Provide debugfs_add_region_item ops for core
      commit: 6fa8c0732bff8e0ab794736837b25dc7ac38cd54

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
