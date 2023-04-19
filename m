Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2766E74F6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjDSIZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjDSIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:25:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D661706
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=3Q8+vJIKMTdavrsl59FUFFHh5cq
        sq8VNH5KnBH0GnBk=; b=kLN1O+SapUu0/jhctblaP79oW6cVwvfoiOW+1ixkZv3
        hZoQPY0ZXw89uf+xB8w0Dp64sijYyBREj8KyjBnAelyk4grUq9zlM5jNzSdQqfSV
        FbMDLbI41+ya24TGPFUVeyHjjXjtF+PQlMRtFRwcc65UIoc86LAvTGX1X0dhsSCU
        =
Received: (qmail 3619070 invoked from network); 19 Apr 2023 10:24:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Apr 2023 10:24:54 +0200
X-UD-Smtp-Session: l3s3148p1@MW+WKKz56KkujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: sh-msiof: Enforce fixed DTDL for R-Car H3
Date:   Wed, 19 Apr 2023 10:24:32 +0200
Message-Id: <20230419082432.33808-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation says only DTDL of 200 is allowed for this SoC.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---

Changes since v1:
* fixed a whitespace issue
* added tags

 drivers/spi/spi-sh-msiof.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 9bca3d076f05..51ceaa485724 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -30,12 +30,15 @@
 
 #include <asm/unaligned.h>
 
+#define SH_MSIOF_FLAG_FIXED_DTDL_200	BIT(0)
+
 struct sh_msiof_chipdata {
 	u32 bits_per_word_mask;
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
 	u16 ctlr_flags;
 	u16 min_div_pow;
+	u32 flags;
 };
 
 struct sh_msiof_spi_priv {
@@ -1073,6 +1076,16 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 	.min_div_pow = 1,
 };
 
+static const struct sh_msiof_chipdata rcar_r8a7795_data = {
+	.bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16) |
+			      SPI_BPW_MASK(24) | SPI_BPW_MASK(32),
+	.tx_fifo_size = 64,
+	.rx_fifo_size = 64,
+	.ctlr_flags = SPI_CONTROLLER_MUST_TX,
+	.min_div_pow = 1,
+	.flags = SH_MSIOF_FLAG_FIXED_DTDL_200,
+};
+
 static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
 	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
@@ -1083,6 +1096,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,msiof-r8a7793",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7794",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7795",   .data = &rcar_r8a7795_data },
 	{ .compatible = "renesas,msiof-r8a7796",   .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen3_data },
@@ -1280,6 +1294,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	if (chipdata->flags & SH_MSIOF_FLAG_FIXED_DTDL_200)
+		info->dtdl = 200;
+
 	if (info->mode == MSIOF_SPI_SLAVE)
 		ctlr = spi_alloc_slave(&pdev->dev,
 				       sizeof(struct sh_msiof_spi_priv));
-- 
2.30.2

