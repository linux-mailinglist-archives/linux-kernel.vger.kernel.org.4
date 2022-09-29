Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA25EFEEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiI2UzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiI2UzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:55:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA77237F7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:55:01 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 022D566022C0;
        Thu, 29 Sep 2022 21:54:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664484899;
        bh=u8vd513Z6iUQllRWnPPQC4Zl83VQH1gtqG8/V8QUGJY=;
        h=From:To:Cc:Subject:Date:From;
        b=I/90rkr6oP3p4/r66yBm0/dLpFtqmvwZowTrJZa7HwvaxaDCOTd7hVQ6WN5moCpuG
         kSnOh59WkOk3oAzHztGOC7GkcU0OTbhRcLlor3GABI+J7TpimDAtBr13pqXkDgE3xe
         QRcnkGpWhOpbHYZjSPohsLAKI3I7VWkWYmpduoNX6z2FKlbYM8kLL/Ffr8jU39XnLl
         uoVmuvbBDymYkNUgDLMfrm3AbgLbiFSWl46yCPajy7LDNRMMzC1MJRlIWCPX1z9KlI
         A0DNr8d+0l9LIHQ2HDuJJlFvwh0oAmjdfeGqwSs3nZeH8BcemKMHQ5w6siipsFbF8R
         fNXFXrYqZFYrg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Jaroslav Kysela <perex@perex.cz>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: mt8192-mt6359: Set the driver name for the card
Date:   Thu, 29 Sep 2022 16:54:53 -0400
Message-Id: <20220929205453.1144142-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASoC core automatically populates the driver name field in the card
from the card name if left unset. However, since the driver name can be
at most 16 characters long, wrapping will happen if the card name is
longer, which is the case for the mt8192-mt6359 driver.

Explicitly set the driver name for the card in order to avoid said
wrapping and have a readable driver name exposed to userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Issue noticed while upstreaming the UCM file for this driver [1].

[1] https://github.com/alsa-project/alsa-ucm-conf/pull/217

 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index ff40ccd36f7e..b93c3237ef2d 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -24,6 +24,8 @@
 #include "mt8192-afe-clk.h"
 #include "mt8192-afe-gpio.h"
 
+#define DRIVER_NAME "mt8192_mt6359"
+
 #define RT1015_CODEC_DAI	"rt1015-aif"
 #define RT1015_DEV0_NAME	"rt1015.1-0028"
 #define RT1015_DEV1_NAME	"rt1015.1-0029"
@@ -1070,6 +1072,7 @@ static struct snd_soc_codec_conf rt1015_amp_conf[] = {
 
 static struct snd_soc_card mt8192_mt6359_rt1015_rt5682_card = {
 	.name = RT1015_RT5682_CARD_NAME,
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = mt8192_mt6359_dai_links,
 	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
@@ -1105,6 +1108,7 @@ static const struct snd_kcontrol_new mt8192_mt6359_rt1015p_rt5682x_controls[] =
 };
 
 static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682x_card = {
+	.driver_name = DRIVER_NAME,
 	.owner = THIS_MODULE,
 	.dai_link = mt8192_mt6359_dai_links,
 	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
@@ -1266,7 +1270,7 @@ static const struct dev_pm_ops mt8192_mt6359_pm_ops = {
 
 static struct platform_driver mt8192_mt6359_driver = {
 	.driver = {
-		.name = "mt8192_mt6359",
+		.name = DRIVER_NAME,
 #ifdef CONFIG_OF
 		.of_match_table = mt8192_mt6359_dt_match,
 #endif
-- 
2.37.3

