Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548769F1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjBVJhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjBVJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:36:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CD3B860;
        Wed, 22 Feb 2023 01:34:21 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4019566021D4;
        Wed, 22 Feb 2023 09:32:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677058372;
        bh=QE7F/onyjKYUPvtkvg2U39BtyxJXdvTS4fCO6hEXZIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCMC0VDx3Ew6xuhCMweNhAmsc58BbMOnCuVVzzAbkZQTCwpXmwDz252qcUqdhBoU+
         F5HhKzxDifr/DC54YkRscSj+ssQNbe95Lo0c/+nhmYUyrYICt1x6Tb/iNXdml/JcH1
         /vDJhpeChdlyInLHfUJMnI7szjn8+naNl4RJYq3LsjjS39TarETLvWjJpP6SfYBtuH
         pvYoa0VjkEpsxHTAjY7KlErvVuRtE2rjRsBoxGln68ADU87/HjZH8w+OGIo4eVojIM
         1we+KA8XMoQ9V2YomAr2UhQ/88kCrWT7AE2DIZ+z0bJvGohwBVDa3D8dOHWR9xUmdA
         o5evPmYLDeO7w==
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
Subject: [PATCH v6 2/4] ASoC: cs35l41: Refactor error release code
Date:   Wed, 22 Feb 2023 09:32:42 +0000
Message-Id: <20230222093244.938156-3-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222093244.938156-1-lucas.tanure@collabora.com>
References: <20230222093244.938156-1-lucas.tanure@collabora.com>
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

Add cs35l41_error_release function to handle error release sequences.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 64 ++++++++++----------------------------
 1 file changed, 16 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index f2b5032daa6a..c006364e5335 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -369,6 +369,16 @@ static void cs35l41_boost_enable(struct cs35l41_private *cs35l41, unsigned int e
 	}
 }
 
+
+static void cs35l41_error_release(struct cs35l41_private *cs35l41, unsigned int irq_err_bit,
+				  unsigned int rel_err_bit)
+{
+	regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1, irq_err_bit);
+	regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
+	regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, rel_err_bit, rel_err_bit);
+	regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, rel_err_bit, 0);
+}
+
 static irqreturn_t cs35l41_irq(int irq, void *data)
 {
 	struct cs35l41_private *cs35l41 = data;
@@ -405,54 +415,26 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	 */
 	if (status[0] & CS35L41_AMP_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "Amp short error\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_AMP_SHORT_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_AMP_SHORT_ERR_RLS,
-				   CS35L41_AMP_SHORT_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_AMP_SHORT_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_AMP_SHORT_ERR, CS35L41_AMP_SHORT_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_TEMP_WARN) {
 		dev_crit_ratelimited(cs35l41->dev, "Over temperature warning\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_TEMP_WARN);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_WARN_ERR_RLS,
-				   CS35L41_TEMP_WARN_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_WARN_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_TEMP_WARN, CS35L41_TEMP_WARN_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_TEMP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "Over temperature error\n");
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_TEMP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_ERR_RLS,
-				   CS35L41_TEMP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_TEMP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_TEMP_ERR, CS35L41_TEMP_ERR_RLS);
 		ret = IRQ_HANDLED;
 	}
 
 	if (status[0] & CS35L41_BST_OVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "VBST Over Voltage error\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_OVP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_OVP_ERR_RLS,
-				   CS35L41_BST_OVP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_OVP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_OVP_ERR, CS35L41_BST_OVP_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
@@ -460,14 +442,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	if (status[0] & CS35L41_BST_DCM_UVP_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "DCM VBST Under Voltage Error\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_DCM_UVP_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_UVP_ERR_RLS,
-				   CS35L41_BST_UVP_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_UVP_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_DCM_UVP_ERR, CS35L41_BST_UVP_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
@@ -475,14 +450,7 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	if (status[0] & CS35L41_BST_SHORT_ERR) {
 		dev_crit_ratelimited(cs35l41->dev, "LBST error: powering off!\n");
 		cs35l41_boost_enable(cs35l41, 0);
-		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
-			     CS35L41_BST_SHORT_ERR);
-		regmap_write(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN, 0);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_SHORT_ERR_RLS,
-				   CS35L41_BST_SHORT_ERR_RLS);
-		regmap_update_bits(cs35l41->regmap, CS35L41_PROTECT_REL_ERR_IGN,
-				   CS35L41_BST_SHORT_ERR_RLS, 0);
+		cs35l41_error_release(cs35l41, CS35L41_BST_SHORT_ERR, CS35L41_BST_SHORT_ERR_RLS);
 		cs35l41_boost_enable(cs35l41, 1);
 		ret = IRQ_HANDLED;
 	}
-- 
2.39.2

