Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD935B97F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIOJqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiIOJpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:43 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AF99B59;
        Thu, 15 Sep 2022 02:45:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1663235136; bh=5iADcUyCkoKBLtPlXxKURQhY4TmQ9CXYiJ51cQuH6qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ILCBgd+d2F1xL5yu8ExrZbyMrdANyfkHWDDq1OYbz9YKhvikJan6iTzh+1Qji5Z7x
         jEnAyyGRvAKxwoE+PdMbGByP02azv2pzva2VVwhm2zJmP8JGQ4cO4e9GPnxhxWNgKh
         84TYPjlcgAAsejYG1goLel0jkxdD0OrBBH36NYBk=
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matt Flax <flatmax@flatmax.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: [PATCH v2 08/11] ASoC: cs42l42: Export regmap elements to core namespace
Date:   Thu, 15 Sep 2022 11:44:41 +0200
Message-Id: <20220915094444.11434-9-povik+lin@cutebit.org>
In-Reply-To: <20220915094444.11434-1-povik+lin@cutebit.org>
References: <20220915094444.11434-1-povik+lin@cutebit.org>
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

Export the regmap callbacks for indicating readable/volatile registers,
also the range structure, to the CS42L42 core namespace. This is in
advance of reusing these bits in a CS42L83 driver frontend.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/codecs/cs42l42.c | 9 ++++++---
 sound/soc/codecs/cs42l42.h | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 3ace16259d1a..7b9237f0ce78 100644
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

