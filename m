Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AD76E81E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjDST0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDST0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:26:00 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289586E85;
        Wed, 19 Apr 2023 12:25:59 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1ppDRF-0003xn-1W;
        Wed, 19 Apr 2023 21:25:57 +0200
Date:   Wed, 19 Apr 2023 20:25:51 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] pwm: mediatek: Add support for MT7981
Message-ID: <e22d8e66558f094b544aa208c722a7f88fd0bde1.1681932165.git.daniel@makrotopia.org>
References: <cover.1681932165.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681932165.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM unit on MT7981 uses different register offsets than previous
MediaTek PWM units. Add support for these new offsets and add support
for PWM on MT7981 which has 3 PWM channels, one of them is typically
used for a temperature controlled fan.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/pwm/pwm-mediatek.c | 54 ++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 5b5eeaff35da6..2bfb5bedf570b 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -34,10 +34,14 @@
 
 #define PWM_CLK_DIV_MAX		7
 
+#define REG_V1			1
+#define REG_V2			2
+
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
 	bool has_ck_26m_sel;
+	u8 reg_ver;
 };
 
 /**
@@ -59,10 +63,14 @@ struct pwm_mediatek_chip {
 	const struct pwm_mediatek_of_data *soc;
 };
 
-static const unsigned int pwm_mediatek_reg_offset[] = {
+static const unsigned int mtk_pwm_reg_offset_v1[] = {
 	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
 };
 
+static const unsigned int mtk_pwm_reg_offset_v2[] = {
+	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x1c0, 0x200, 0x0240
+};
+
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
@@ -111,7 +119,19 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 				       unsigned int num, unsigned int offset,
 				       u32 value)
 {
-	writel(value, chip->regs + pwm_mediatek_reg_offset[num] + offset);
+	u32 pwm_offset;
+
+	switch (chip->soc->reg_ver) {
+	case REG_V2:
+		pwm_offset = mtk_pwm_reg_offset_v2[num];
+		break;
+
+	case REG_V1:
+	default:
+		pwm_offset = mtk_pwm_reg_offset_v1[num];
+	}
+
+	writel(value, chip->regs + pwm_offset + offset);
 }
 
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -285,60 +305,77 @@ static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = false,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt6795_pwm_data = {
 	.num_pwms = 7,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = false,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = true,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
 	.has_ck_26m_sel = false,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
 	.has_ck_26m_sel = false,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = false,
+	.reg_ver = REG_V1,
 };
 
-static const struct pwm_mediatek_of_data mt8183_pwm_data = {
-	.num_pwms = 4,
+static const struct pwm_mediatek_of_data mt7981_pwm_data = {
+	.num_pwms = 3,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = true,
+	.reg_ver = REG_V2,
 };
 
-static const struct pwm_mediatek_of_data mt8365_pwm_data = {
-	.num_pwms = 3,
+static const struct pwm_mediatek_of_data mt7986_pwm_data = {
+	.num_pwms = 2,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = true,
+	.reg_ver = REG_V1,
 };
 
-static const struct pwm_mediatek_of_data mt7986_pwm_data = {
-	.num_pwms = 2,
+static const struct pwm_mediatek_of_data mt8183_pwm_data = {
+	.num_pwms = 4,
+	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
+	.reg_ver = REG_V1,
+};
+
+static const struct pwm_mediatek_of_data mt8365_pwm_data = {
+	.num_pwms = 3,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = true,
+	.reg_ver = REG_V1,
 };
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
 	.has_ck_26m_sel = true,
+	.reg_ver = REG_V1,
 };
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
@@ -348,6 +385,7 @@ static const struct of_device_id pwm_mediatek_of_match[] = {
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
 	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
+	{ .compatible = "mediatek,mt7981-pwm", .data = &mt7981_pwm_data },
 	{ .compatible = "mediatek,mt7986-pwm", .data = &mt7986_pwm_data },
 	{ .compatible = "mediatek,mt8183-pwm", .data = &mt8183_pwm_data },
 	{ .compatible = "mediatek,mt8365-pwm", .data = &mt8365_pwm_data },
-- 
2.40.0

