Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E554E6CCB00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjC1T41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC1T4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:56:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF631FC3;
        Tue, 28 Mar 2023 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680033384; x=1711569384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/F2de+iehabZIds7kVXZap20zLfbkzaLODGMMhLmfRE=;
  b=xuwHJTJYpPguYJxbHLSi94HWnROhsO5q9xrqSn/k8D3tK0rG22mT4Pjq
   1v+H0HlzonlMuGJvBm/cxuoIFoVnGbI1MegWO6lq+eIqnvw1bEMrVoWpj
   aSHY/Cd+GExi/t93BuVicEYpznvW9RKdX/ThnH4QaH6h3zCXHBc7vMpnM
   08xe94Vb/PN4Mn2O32cw3jz0N23vqrWyabaYYFY51f6lyQJ+nFtPFjlaD
   4+HMvwV6Bp65MIXX77poDXwaVFRPDrpd+jC52Z2gvmr3nZ3W8zyoYnj3D
   Sw1JOByFOiD1UQqvbfdUfRmatbAW/quxbJq07mLtdC5yUkqyoGmgF6zJA
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,297,1673938800"; 
   d="scan'208";a="206741354"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 12:56:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 12:56:21 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 12:56:21 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 1/4] crypto: atmel-sha: Add zero length message digest support for hmac
Date:   Tue, 28 Mar 2023 12:56:26 -0700
Message-ID: <f559c0e90d4b8dbd4be8820082aa74a645ef32a9.1680019905.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1680019905.git.Ryan.Wanner@microchip.com>
References: <cover.1680019905.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add softare padding to hmac-sha digest for zero length messages.
Using the atmel_sha_fill_padding() to fill the buffer with a padded
empty message with a length of the block size.

Create a temporary scatter list from the padded buffer to pass into the
data processing functions.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/crypto/atmel-sha.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 00be792e605c..b42e3a0b8cb5 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1948,14 +1948,32 @@ static int atmel_sha_hmac_digest2(struct atmel_sha_dev *dd)
 	struct atmel_sha_reqctx *ctx = ahash_request_ctx(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct atmel_sha_hmac_ctx *hmac = crypto_ahash_ctx(tfm);
+	struct scatterlist *sgbuf;
 	size_t hs = ctx->hash_size;
 	size_t i, num_words = hs / sizeof(u32);
 	bool use_dma = false;
 	u32 mr;
 
 	/* Special case for empty message. */
-	if (!req->nbytes)
-		return atmel_sha_complete(dd, -EINVAL); // TODO:
+	if (!req->nbytes) {
+		req->nbytes = 0;
+		ctx->bufcnt = 0;
+		ctx->digcnt[0] = 0;
+		ctx->digcnt[1] = 0;
+		switch (ctx->flags & SHA_FLAGS_ALGO_MASK) {
+		case SHA_FLAGS_SHA1:
+		case SHA_FLAGS_SHA224:
+		case SHA_FLAGS_SHA256:
+			atmel_sha_fill_padding(ctx, 64);
+			break;
+
+		case SHA_FLAGS_SHA384:
+		case SHA_FLAGS_SHA512:
+			atmel_sha_fill_padding(ctx, 128);
+			break;
+		}
+		sg_init_one(&dd->tmp, ctx->buffer, ctx->bufcnt);
+	}
 
 	/* Check DMA threshold and alignment. */
 	if (req->nbytes > ATMEL_SHA_DMA_THRESHOLD &&
@@ -1985,12 +2003,20 @@ static int atmel_sha_hmac_digest2(struct atmel_sha_dev *dd)
 
 	atmel_sha_write(dd, SHA_CR, SHA_CR_FIRST);
 
+	/* Special case for empty message. */
+	if (!req->nbytes) {
+		sgbuf = &dd->tmp;
+		req->nbytes = ctx->bufcnt;
+	} else {
+		sgbuf = req->src;
+	}
+
 	/* Process data. */
 	if (use_dma)
-		return atmel_sha_dma_start(dd, req->src, req->nbytes,
+		return atmel_sha_dma_start(dd, sgbuf, req->nbytes,
 					   atmel_sha_hmac_final_done);
 
-	return atmel_sha_cpu_start(dd, req->src, req->nbytes, false, true,
+	return atmel_sha_cpu_start(dd, sgbuf, req->nbytes, false, true,
 				   atmel_sha_hmac_final_done);
 }
 
-- 
2.37.2

