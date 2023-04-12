Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44D66DF6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDLNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDLNMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:12:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447CF7ED2;
        Wed, 12 Apr 2023 06:12:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 623D06603254;
        Wed, 12 Apr 2023 14:12:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681305145;
        bh=wAeCus0gvy0VBSmyxSDYV3/UIGGEcqaMqVMivTGBVYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DwGh6lDoFr/4RXdlBm/UHePy/FWZcYvN4L6ugFK4WkCRZmakkE5w1XVd3abagz9xU
         F49qyyUlHEWkPSVvrhsTZJ05Lo15r4QDpW6LMirsSN3krhq/dG+P1DaANiDHkiOQAQ
         bISOZb15AlhY7j0xi9I4TYzjo9yiC5hpX8IsNYolWsXZkVWqH6jmmdID+59EFn2qPO
         XgPaABBh6/cD9XOf7bcypUH294gV1J8sCeLe4+7KzQeP2N6JKgyK5z81+8Xvp2j7Lv
         V3ykugWoqoP1lKBwb3uoSVarfy7a5dGDyPgeRpDr3/B6Epn8XgO9zp6gg5yZ/1Wu+L
         tK4Vy4ZJ8EZvQ==
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
Subject: [PATCH v3 4/6] soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
Date:   Wed, 12 Apr 2023 15:12:14 +0200
Message-Id: <20230412131216.198313-5-angelogioacchino.delregno@collabora.com>
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

Some PMICs are designed to work with a companion part, which provides
more regulators and/or companion devices such as LED controllers,
display backlight controllers, battery charging, fuel gauge, etc:
this kind of PMICs are usually present in smartphone platforms, where
tight integration is required.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 73 ++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index a33a1b1820cb..366e40b802e4 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -47,6 +47,7 @@
 
 /* macro for device wrapper default value */
 #define PWRAP_DEW_READ_TEST_VAL		0x5aa5
+#define PWRAP_DEW_COMP_READ_TEST_VAL	0xa55a
 #define PWRAP_DEW_WRITE_TEST_VAL	0xa55a
 
 /* macro for manual command */
@@ -1222,12 +1223,16 @@ struct pwrap_slv_regops {
  * struct pwrap_slv_type - PMIC device wrapper definitions
  * @dew_regs:      Device Wrapper (DeW) register offsets
  * @type:          PMIC Type (model)
+ * @comp_dew_regs: Device Wrapper (DeW) register offsets for companion device
+ * @comp_type:     Companion PMIC Type (model)
  * @regops:        Register R/W ops
  * @caps:          Capability flags for the target device
  */
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
+	const u32 *comp_dew_regs;
+	enum pmic_type comp_type;
 	const struct pwrap_slv_regops *regops;
 	u32 caps;
 };
@@ -1548,9 +1553,12 @@ static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 {
 	int ret;
 	bool read_ok, tmp;
+	bool comp_read_ok = true;
 
 	/* Enable dual IO mode */
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
+	if (wrp->slave->comp_dew_regs)
+		pwrap_write(wrp, wrp->slave->comp_dew_regs[PWRAP_DEW_DIO_EN], 1);
 
 	/* Check IDLE & INIT_DONE in advance */
 	ret = readx_poll_timeout(pwrap_is_fsm_idle_and_sync_idle, wrp, tmp, tmp,
@@ -1564,8 +1572,14 @@ static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 
 	/* Read Test */
 	read_ok = pwrap_pmic_read_test(wrp, wrp->slave->dew_regs, PWRAP_DEW_READ_TEST_VAL);
-	if (!read_ok) {
-		dev_err(wrp->dev, "Read failed on DIO mode.\n");
+	if (wrp->slave->comp_dew_regs)
+		comp_read_ok = pwrap_pmic_read_test(wrp, wrp->slave->comp_dew_regs,
+						    PWRAP_DEW_COMP_READ_TEST_VAL);
+	if (!read_ok || !comp_read_ok) {
+		dev_err(wrp->dev, "Read failed on DIO mode. Main PMIC %s%s\n",
+			!read_ok ? "fail" : "success",
+			wrp->slave->comp_dew_regs && !comp_read_ok ?
+			", Companion PMIC fail" : "");
 		return -EFAULT;
 	}
 
@@ -1640,19 +1654,41 @@ static bool pwrap_is_cipher_ready(struct pmic_wrapper *wrp)
 	return pwrap_readl(wrp, PWRAP_CIPHER_RDY) & 1;
 }
 
-static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
+static bool __pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp, const u32 *dew_regs)
 {
 	u32 rdata;
 	int ret;
 
-	ret = pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_RDY],
-			 &rdata);
+	ret = pwrap_read(wrp, dew_regs[PWRAP_DEW_CIPHER_RDY], &rdata);
 	if (ret)
 		return false;
 
 	return rdata == 1;
 }
 
+
+static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
+{
+	bool ret = __pwrap_is_pmic_cipher_ready(wrp, wrp->slave->dew_regs);
+
+	if (!ret)
+		return ret;
+
+	/* If there's any companion, wait for it to be ready too */
+	if (wrp->slave->comp_dew_regs)
+		ret = __pwrap_is_pmic_cipher_ready(wrp, wrp->slave->comp_dew_regs);
+
+	return ret;
+}
+
+static void pwrap_config_cipher(struct pmic_wrapper *wrp, const u32 *dew_regs)
+{
+	pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x1);
+	pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
+	pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
+	pwrap_write(wrp, dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
+}
+
 static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 {
 	int ret;
@@ -1689,10 +1725,11 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 	}
 
 	/* Config cipher mode @PMIC */
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x1);
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_SWRST], 0x0);
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_KEY_SEL], 0x1);
-	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_IV_SEL], 0x2);
+	pwrap_config_cipher(wrp, wrp->slave->dew_regs);
+
+	/* If there is any companion PMIC, configure cipher mode there too */
+	if (wrp->slave->comp_type > 0)
+		pwrap_config_cipher(wrp, wrp->slave->comp_dew_regs);
 
 	switch (wrp->slave->type) {
 	case PMIC_MT6397:
@@ -1754,6 +1791,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 
 static int pwrap_init_security(struct pmic_wrapper *wrp)
 {
+	u32 crc_val;
 	int ret;
 
 	/* Enable encryption */
@@ -1762,14 +1800,21 @@ static int pwrap_init_security(struct pmic_wrapper *wrp)
 		return ret;
 
 	/* Signature checking - using CRC */
-	if (pwrap_write(wrp,
-			wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1))
-		return -EFAULT;
+	ret = pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_EN], 0x1);
+	if (ret == 0 && wrp->slave->comp_dew_regs)
+		ret = pwrap_write(wrp, wrp->slave->comp_dew_regs[PWRAP_DEW_CRC_EN], 0x1);
 
 	pwrap_writel(wrp, 0x1, PWRAP_CRC_EN);
 	pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
-	pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
-		     PWRAP_SIG_ADR);
+
+	/* CRC value */
+	crc_val = wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL];
+	if (wrp->slave->comp_dew_regs)
+		crc_val |= wrp->slave->comp_dew_regs[PWRAP_DEW_CRC_VAL] << 16;
+
+	pwrap_writel(wrp, crc_val, PWRAP_SIG_ADR);
+
+	/* PMIC Wrapper Arbiter priority */
 	pwrap_writel(wrp,
 		     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
 
-- 
2.40.0

