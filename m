Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7035B3A36
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiIINza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiIINyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:54:53 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91795FCC;
        Fri,  9 Sep 2022 06:54:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1662731680; bh=7ptJCN9nATn9uDBcMGbXpo6rfRfMfA+dgnRJT7fm8AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rNVALXYEVGITpfBIDipXLXlJW8g3bx6rGwNFvMaCmnxz3mP4qrE88O7z0WFlKDfPa
         0+VDmBrBRKOurY1q3pOvPrgX6DUVq3n8M5Tl8ydcPny0ZrgggUfB/ewtfdFfDjpiJZ
         WtPpaEseAWnVTZolM2azQ2Sr5oGmrAuMqm8R1LvE=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matt Flax <flatmax@flatmax.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH 08/10] ASoC: cs42l42: Export regmap elements to core namespace
Date:   Fri,  9 Sep 2022 15:53:32 +0200
Message-Id: <20220909135334.98220-9-povik+lin@cutebit.org>
In-Reply-To: <20220909135334.98220-1-povik+lin@cutebit.org>
References: <20220909135334.98220-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the regmap callbacks for indicating readable/volatile registers,
also the range structure, in the CS42L42 core namespace. This is in
advance of reusing these bits in a CS42L83 driver frontend.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 9 ++++++---
 sound/soc/codecs/cs42l42.h | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a22d84db356c..f7a4d51538dd 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -171,7 +171,7 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_ASP_RX_DAI1_CH2_BIT_LSB,	0x00 },
 };
 
-static bool cs42l42_readable_register(struct device *dev, unsigned int reg)
+bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS42L42_PAGE_REGISTER:
@@ -330,8 +330,9 @@ static bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_readable_register, SND_SOC_CS42L42_CORE);
 
-static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
+bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case CS42L42_DEVID_AB:
@@ -362,8 +363,9 @@ static bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 		return false;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(cs42l42_volatile_register, SND_SOC_CS42L42_CORE);
 
-static const struct regmap_range_cfg cs42l42_page_range = {
+const struct regmap_range_cfg cs42l42_page_range = {
 	.name = "Pages",
 	.range_min = 0,
 	.range_max = CS42L42_MAX_REGISTER,
@@ -373,6 +375,7 @@ static const struct regmap_range_cfg cs42l42_page_range = {
 	.window_start = 0,
 	.window_len = 256,
 };
+EXPORT_SYMBOL_NS_GPL(cs42l42_page_range, SND_SOC_CS42L42_CORE);
 
 const struct regmap_config cs42l42_regmap = {
 	.reg_bits = 8,
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 2a9f178f6190..be6f979c82ec 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -52,10 +52,14 @@ struct  cs42l42_private {
 	bool init_done;
 };
 
+extern const struct regmap_range_cfg cs42l42_page_range;
 extern const struct regmap_config cs42l42_regmap;
 extern const struct snd_soc_component_driver cs42l42_soc_component;
 extern struct snd_soc_dai_driver cs42l42_dai;
 
+bool cs42l42_readable_register(struct device *dev, unsigned int reg);
+bool cs42l42_volatile_register(struct device *dev, unsigned int reg);
+
 int cs42l42_suspend(struct device *dev);
 int cs42l42_resume(struct device *dev);
 void cs42l42_resume_restore(struct device *dev);
-- 
2.33.0

