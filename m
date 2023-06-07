Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E60726727
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFGRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjFGRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD36F1FD5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 10:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3567C63706
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 17:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11B0C4339B;
        Wed,  7 Jun 2023 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686158629;
        bh=DXFobuRLa5VJEYRkra8Yv2W5Fag/nn80UUPhzCO37/I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=p9nzJqhdievT3cH7sdFgcIONCpvuxD8owzg6hRkrjZd0OL6tPCLciW64eWZO5mMg0
         sSx+jhvZNZ9crQzrNhpmkeUemXISN7HHUv/D/NmIIvJ/LCbimo4iuCOlJOykgeWXuQ
         0kckTA81K5cmSPFB6+nKB4/vYFNvcRg9wuULRE+XVjBn51EUZlTHrOsKgmii9ivnlQ
         hblqGMos5ZPcOqWHfRL/+DnW2wZpYk11Qw7k3+35NfX5n76tR9V6TAKqgGwV79E1gK
         aVgii1F/QLjWZv1ndoz2FzWOVd59MmrXS6lIhACOZ0d/767G1j9a7dlNmTiAtr4iiQ
         TCRlb9u2CEb0w==
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20230607120831.3587379-1-arnd@kernel.org>
References: <20230607120831.3587379-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188-mt6359: add i2c dependency
Message-Id: <168615862657.61571.8647819742396271999.b4-ty@kernel.org>
Date:   Wed, 07 Jun 2023 18:23:46 +0100
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

On Wed, 07 Jun 2023 14:08:15 +0200, Arnd Bergmann wrote:
> The newly added driver is missing this dependency, causing a possible
> build failure:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MAX98390
> WARNING: unmet direct dependencies detected for SND_SOC_NAU8825
>   Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=m]
>   Selected by [y]:
>   - SND_SOC_MT8188_MT6359 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8188 [=y] && MTK_PMIC_WRAP [=y]
> aarch64-linux-ld: sound/soc/codecs/max98390.o: in function `max98390_i2c_probe':
> max98390.c:(.text+0x514): undefined reference to `__devm_regmap_init_i2c'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8188-mt6359: add i2c dependency
      commit: 484ede9bcb031a98880817480b685cac0ec96f2b

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

