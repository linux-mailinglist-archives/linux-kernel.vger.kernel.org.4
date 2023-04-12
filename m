Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F36DF6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjDLNN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDLNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:13:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D076B8;
        Wed, 12 Apr 2023 06:12:42 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B83D660326E;
        Wed, 12 Apr 2023 14:12:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305146;
        bh=nJdVU7VlnC0bQc4i84vLOllab4PclCES7DJKViJt7vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnzTv6u0bpKYXhvdAO5TSi0QbpIKV66dtN0ZVEIK+7pHbzA14NTV8lpAIsQnKxg+D
         idU2mxsP+ZLATp7v2RYBRuDQZcNTKMg6RIt3SMQ58txjvS6jznKO0YzgBGjuAtCqHy
         sSBzjNlq89W5Si07Bz3GsYo4aXXxzl8DDs2wbKN5aIloNwBJHMbUxxX33rZ2Vi9Ron
         1YwUALMH9AUmeKoedys+2yS2f60mPF/oTRwx/nwxaXTDBIj/kVGcL7kaeHxGbDOd84
         tYl1ZyGUPHhXkEFfV40VQMH1DodYMfvV2AmxcriVg6eSDDmY3j78p3RXSEykDDAZ9A
         yIG0VHz/KeIiA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        amergnat@baylibre.com, flora.fu@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 5/6] soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332 companion
Date:   Wed, 12 Apr 2023 15:12:15 +0200
Message-Id: <20230412131216.198313-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
References: <20230412131216.198313-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MT6331 PMIC and for its companion MT6332 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 47 ++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 366e40b802e4..ceeac43f7bd1 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -170,6 +170,40 @@ static const u32 mt6323_regs[] = {
 	[PWRAP_DEW_RDDMY_NO] =		0x01a4,
 };
 
+static const u32 mt6331_regs[] = {
+	[PWRAP_DEW_DIO_EN] =		0x018c,
+	[PWRAP_DEW_READ_TEST] =		0x018e,
+	[PWRAP_DEW_WRITE_TEST] =	0x0190,
+	[PWRAP_DEW_CRC_SWRST] =		0x0192,
+	[PWRAP_DEW_CRC_EN] =		0x0194,
+	[PWRAP_DEW_CRC_VAL] =		0x0196,
+	[PWRAP_DEW_MON_GRP_SEL] =	0x0198,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x019a,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x019c,
+	[PWRAP_DEW_CIPHER_EN] =		0x019e,
+	[PWRAP_DEW_CIPHER_RDY] =	0x01a0,
+	[PWRAP_DEW_CIPHER_MODE] =	0x01a2,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x01a4,
+	[PWRAP_DEW_RDDMY_NO] =		0x01a6,
+};
+
+static const u32 mt6332_regs[] = {
+	[PWRAP_DEW_DIO_EN] =		0x80f6,
+	[PWRAP_DEW_READ_TEST] =		0x80f8,
+	[PWRAP_DEW_WRITE_TEST] =	0x80fa,
+	[PWRAP_DEW_CRC_SWRST] =		0x80fc,
+	[PWRAP_DEW_CRC_EN] =		0x80fe,
+	[PWRAP_DEW_CRC_VAL] =		0x8100,
+	[PWRAP_DEW_MON_GRP_SEL] =	0x8102,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x8104,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x8106,
+	[PWRAP_DEW_CIPHER_EN] =		0x8108,
+	[PWRAP_DEW_CIPHER_RDY] =	0x810a,
+	[PWRAP_DEW_CIPHER_MODE] =	0x810c,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x810e,
+	[PWRAP_DEW_RDDMY_NO] =		0x8110,
+};
+
 static const u32 mt6351_regs[] = {
 	[PWRAP_DEW_DIO_EN] =		0x02F2,
 	[PWRAP_DEW_READ_TEST] =		0x02F4,
@@ -1182,6 +1216,8 @@ static int mt8186_regs[] = {
 
 enum pmic_type {
 	PMIC_MT6323,
+	PMIC_MT6331,
+	PMIC_MT6332,
 	PMIC_MT6351,
 	PMIC_MT6357,
 	PMIC_MT6358,
@@ -2041,6 +2077,16 @@ static const struct pwrap_slv_type pmic_mt6323 = {
 		PWRAP_SLV_CAP_SECURITY,
 };
 
+static const struct pwrap_slv_type pmic_mt6331 = {
+	.dew_regs = mt6331_regs,
+	.type = PMIC_MT6331,
+	.comp_dew_regs = mt6332_regs,
+	.comp_type = PMIC_MT6332,
+	.regops = &pwrap_regops16,
+	.caps = PWRAP_SLV_CAP_SPI | PWRAP_SLV_CAP_DUALIO |
+		PWRAP_SLV_CAP_SECURITY,
+};
+
 static const struct pwrap_slv_type pmic_mt6351 = {
 	.dew_regs = mt6351_regs,
 	.type = PMIC_MT6351,
@@ -2086,6 +2132,7 @@ static const struct pwrap_slv_type pmic_mt6397 = {
 
 static const struct of_device_id of_slave_match_tbl[] = {
 	{ .compatible = "mediatek,mt6323", .data = &pmic_mt6323 },
+	{ .compatible = "mediatek,mt6331", .data = &pmic_mt6331 },
 	{ .compatible = "mediatek,mt6351", .data = &pmic_mt6351 },
 	{ .compatible = "mediatek,mt6357", .data = &pmic_mt6357 },
 	{ .compatible = "mediatek,mt6358", .data = &pmic_mt6358 },
-- 
2.40.0

