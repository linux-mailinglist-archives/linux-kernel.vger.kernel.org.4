Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F8725E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbjFGMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbjFGMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49811BD5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:08:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50D2B63562
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF3DC433EF;
        Wed,  7 Jun 2023 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686139718;
        bh=ajWdmE+oEITOfGOM0DiF4YY95IS+tAiw8M8wSeFjfJc=;
        h=From:To:Cc:Subject:Date:From;
        b=Bi+Wp+C6tbHnzgHh1p+180dQ/zx9IUMtY1VfKbsF+Z6NcjawkF67gfhSgdhHTpAPy
         K/+O9EkvHkxjVf8Va3NjQUEkwAfD3NKQkywYkVXXdHO3agZsQJ5ep0O3v82jqjxoMd
         DgsOe7DtWJjJes8wCRxqJIZ5l+jLK4GIORNxAUWEv1Qgs/KuyMsy9Jp9PtghSfHphS
         31S29SmnQ1uIFM1z4Uco4AzI8ppCeQ4yDaRZOkLlDVrVZBcN18fTfItUrJC82TpIHB
         jRAqUAmruppRV96n5IsNE13ScmceWymV5DOSGPtUY/xUXiv/PEFdDANPLFLISbTtqN
         Pb8HNcN+6mFjg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
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
Subject: [PATCH] ASoC: mediatek: mt8188-mt6359: add i2c dependency
Date:   Wed,  7 Jun 2023 14:08:15 +0200
Message-Id: <20230607120831.3587379-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver is missing this dependency, causing a possible
build failure:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98390
WARNING: unmet direct dependencies detected for SND_SOC_NAU8825
  Depends on [m]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=m]
  Selected by [y]:
  - SND_SOC_MT8188_MT6359 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_MT8188 [=y] && MTK_PMIC_WRAP [=y]
aarch64-linux-ld: sound/soc/codecs/max98390.o: in function `max98390_i2c_probe':
max98390.c:(.text+0x514): undefined reference to `__devm_regmap_init_i2c'

Fixes: 9f08dcbddeb30 ("ASoC: mediatek: mt8188-mt6359: support new board with nau88255")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 4ea012342b522..90db67e0ce4fb 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -223,6 +223,7 @@ config SND_SOC_MT8188
 config SND_SOC_MT8188_MT6359
 	tristate "ASoC Audio driver for MT8188 with MT6359 and I2S codecs"
 	depends on SND_SOC_MT8188 && MTK_PMIC_WRAP
+	depends on I2C
 	select SND_SOC_MT6359
 	select SND_SOC_HDMI_CODEC
 	select SND_SOC_DMIC
-- 
2.39.2

