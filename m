Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CE68F094
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjBHOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBHOSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:18:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F033644C;
        Wed,  8 Feb 2023 06:18:44 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A72F66020AF;
        Wed,  8 Feb 2023 14:18:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675865923;
        bh=6EQxMlnnbv5hQCSpawkKi8+yCzwMB/cj6uq7qeXpAmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxu3acsB3Z4pGe+NyfMJU6eZJFDkQ45gHxuzBgQ4/C7plyqkvVBS3XXlMpYJJdGPk
         agjbCiu65ObncOoH5wWsV2/WGWOBFdJkYm/KPmg6sHM7f3dP8ByzICNWWj3ShhK9yK
         nCm67Olu7vThW1dsHBEetQ4tOUOzAHn0AUnAceskM9FXCEnad7hTOnRxMQqdYt2Bo9
         KzSxnC4RJG1fiXx5IvEbqmFgpdhZSJZevl5GsQAnZMOYXjpsAHnmDN5UU1lqGhK2ow
         BrF8P3ZpbUrC09IU0JYoK8ob25o/CqrRafMVTYJyW4o80gv38mZDBJaDo84Mtp26Jk
         eFVem1hZ7Ctug==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH v3 1/4] ASoC: cs35l41: Only disable internal boost
Date:   Wed,  8 Feb 2023 14:18:36 +0000
Message-Id: <20230208141839.1097377-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208141839.1097377-1-lucas.tanure@collabora.com>
References: <20230208141839.1097377-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error situations, only the internal boost case should be disabled and
re-enabled.
Also, for other boost cases re-enabling the boost to the default internal
boost config is incorrect.

Fixes: 6450ef559056 ("ASoC: cs35l41: CS35L41 Boosted Smart Amplifier")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index c223d83e02cf..f2b5032daa6a 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -356,6 +356,19 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 	WM_ADSP_FW_CONTROL("DSP1", 0),
 };
 
+static void cs35l41_boost_enable(struct cs35l41_private *cs35l41, unsigned int enable)
+{
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+		enable = enable ? CS35L41_BST_EN_DEFAULT : CS35L41_BST_DIS_FET_OFF;
+		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
+				enable << CS35L41_BST_EN_SHIFT);
+		break;
+	default:
+		break;
+	}
+}
+
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -431,8 +444,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 
 	if (status[0] & CS35L41_BST_OVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "VBST Over Voltage error\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_OVP_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -441,16 +453,13 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_OVP_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_OVP_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_DCM_UVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "DCM VBST Under Voltage Error\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_DCM_UVP_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -459,16 +468,13 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_UVP_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_UVP_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "LBST error: powering off!\n");
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK, 0);
+		cs35l41_boost_enable(cs35l41, 0);
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 			     CS35L41_BST_SHORT_ERR);
 		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
@@ -477,9 +483,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 				   CS35L41_BST_SHORT_ERR_RLS);
 		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
 				   CS35L41_BST_SHORT_ERR_RLS, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2,
-				   CS35L41_BST_EN_MASK,
-				   CS35L41_BST_EN_DEFAULT << CS35L41_BST_EN_SHIFT);
+		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.39.1

