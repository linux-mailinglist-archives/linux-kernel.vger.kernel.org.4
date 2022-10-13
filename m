Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75705FD9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJMM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJMM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:56:48 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F5139E45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:56:47 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 97F821B45BA;
        Thu, 13 Oct 2022 14:56:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 60F4E1B45BC;
        Thu, 13 Oct 2022 14:56:45 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 09EF31802204;
        Thu, 13 Oct 2022 20:56:43 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        viorel.suman@nxp.com
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: ak4458: add optional reset control to instead of gpio
Date:   Thu, 13 Oct 2022 20:36:51 +0800
Message-Id: <1665664611-21350-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Add optional reset control instead of GPIO to manage codec
PDN pin.

As there is reference counter for reset control, so need
to remove one ak4458_reset in runtime resume to make the
reference counter balance.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index 626310859814..ac328d598291 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -13,6 +13,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
@@ -46,6 +47,7 @@ struct ak4458_priv {
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpiod;
+	struct reset_control *reset;
 	struct gpio_desc *mute_gpiod;
 	int digfil;	/* SSLOW, SD, SLOW bits */
 	int fs;		/* sampling rate */
@@ -633,6 +635,12 @@ static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
 	if (ak4458->reset_gpiod) {
 		gpiod_set_value_cansleep(ak4458->reset_gpiod, active);
 		usleep_range(1000, 2000);
+	} else if (!IS_ERR_OR_NULL(ak4458->reset)) {
+		if (active)
+			reset_control_assert(ak4458->reset);
+		else
+			reset_control_deassert(ak4458->reset);
+		usleep_range(1000, 2000);
 	}
 }
 
@@ -668,7 +676,6 @@ static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
 
-	ak4458_reset(ak4458, true);
 	ak4458_reset(ak4458, false);
 
 	regcache_cache_only(ak4458->regmap, false);
@@ -748,6 +755,10 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 
 	ak4458->drvdata = of_device_get_match_data(&i2c->dev);
 
+	ak4458->reset = devm_reset_control_get_optional_shared(ak4458->dev, NULL);
+	if (IS_ERR(ak4458->reset))
+		return PTR_ERR(ak4458->reset);
+
 	ak4458->reset_gpiod = devm_gpiod_get_optional(ak4458->dev, "reset",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(ak4458->reset_gpiod))
-- 
2.34.1

