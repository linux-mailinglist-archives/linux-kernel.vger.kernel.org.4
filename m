Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65656C7BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjCXJmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCXJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:42:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6BB25955;
        Fri, 24 Mar 2023 02:42:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 613086603113;
        Fri, 24 Mar 2023 09:42:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679650933;
        bh=AB9OIdGkG7L+x9jKjTVnJOyjqXiyjeKHV7UwTBXh5Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHgECBcLpYhbwwEFGM9QDII8gC3Sp6/OdblXdDbTzRj+x0XI+PgbWzSgOWnOMwTOM
         7LZCnoeIbVCOx3aQuoohwiwbkM+VfNnvUoll/ZubFhUoYnv2s7+6pMM+7Gg9wm4LYk
         EX+xjJnJXZwPsgLXOQph6xOUVNSZgwoZzdAvJ4dgSejJTIg7mPg/qp+OAypOXDoST9
         tbZ1q0FJkAf2zkBNens1y2JJ9c339Ahl0/qt16KBh3KuXXTvvfI/lCKSyVA5OSeoz+
         tS64RkyRE0+B4lNlAoXZQq4E7rKhbuJ+cL3te5DSDjb2wlGQaMsHeaZkgRlfKSyNiN
         sCPf4h73Iuezw==
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
Subject: [PATCH v2 2/6] soc: mediatek: pwrap: Move PMIC read test sequence in function
Date:   Fri, 24 Mar 2023 10:42:01 +0100
Message-Id: <20230324094205.33266-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
References: <20230324094205.33266-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC read test is performed in two places: pwrap_init_dual_io()
and pwrap_init_sidly().
In preparation for adding support for PMICs requiring a companion
part, move this sequence to a new function pwrap_pmic_read_test().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 32 +++++++++++++++++-----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 15789a03e6c6..5c500be48f7c 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1455,6 +1455,18 @@ static int pwrap_regmap_write(void *context, u32 adr, u32 wdata)
 	return pwrap_write(context, adr, wdata);
 }
 
+static bool pwrap_pmic_read_test(struct pmic_wrapper *wrp, const u32 *dew_regs,
+				 u16 read_test_val)
+{
+	bool is_success;
+	u32 rdata;
+
+	pwrap_read(wrp, dew_regs[PWRAP_DEW_READ_TEST], &rdata);
+	is_success = ((rdata & U16_MAX) == read_test_val);
+
+	return is_success;
+}
+
 static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
 {
 	bool tmp;
@@ -1498,18 +1510,18 @@ static int pwrap_reset_spislave(struct pmic_wrapper *wrp)
  */
 static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 {
-	u32 rdata;
 	u32 i;
 	u32 pass = 0;
+	bool read_ok;
 	signed char dly[16] = {
 		-1, 0, 1, 0, 2, -1, 1, 1, 3, -1, -1, -1, 3, -1, 2, 1
 	};
 
 	for (i = 0; i < 4; i++) {
 		pwrap_writel(wrp, i, PWRAP_SIDLY);
-		pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_READ_TEST],
-			   &rdata);
-		if (rdata == PWRAP_DEW_READ_TEST_VAL) {
+		read_ok = pwrap_pmic_read_test(wrp, wrp->slave->dew_regs,
+					       PWRAP_DEW_READ_TEST_VAL);
+		if (read_ok) {
 			dev_dbg(wrp->dev, "[Read Test] pass, SIDLY=%x\n", i);
 			pass |= 1 << i;
 		}
@@ -1529,8 +1541,7 @@ static int pwrap_init_sidly(struct pmic_wrapper *wrp)
 static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 {
 	int ret;
-	bool tmp;
-	u32 rdata;
+	bool read_ok, tmp;
 
 	/* Enable dual IO mode */
 	pwrap_write(wrp, wrp->slave->dew_regs[PWRAP_DEW_DIO_EN], 1);
@@ -1546,12 +1557,9 @@ static int pwrap_init_dual_io(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 1, PWRAP_DIO_EN);
 
 	/* Read Test */
-	pwrap_read(wrp,
-		   wrp->slave->dew_regs[PWRAP_DEW_READ_TEST], &rdata);
-	if (rdata != PWRAP_DEW_READ_TEST_VAL) {
-		dev_err(wrp->dev,
-			"Read failed on DIO mode: 0x%04x!=0x%04x\n",
-			PWRAP_DEW_READ_TEST_VAL, rdata);
+	read_ok = pwrap_pmic_read_test(wrp, wrp->slave->dew_regs, PWRAP_DEW_READ_TEST_VAL);
+	if (!read_ok) {
+		dev_err(wrp->dev, "Read failed on DIO mode.\n");
 		return -EFAULT;
 	}
 
-- 
2.40.0

