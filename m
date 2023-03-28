Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424616CCAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjC1T43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjC1T40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:56:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175AD1BE1;
        Tue, 28 Mar 2023 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680033385; x=1711569385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pNleVDsOKO+SQXxRv8CZk7/1rEyCdwTx0A5JZpAvdk=;
  b=DwT6Q2XvK9Lmli2/QoHwmFU8zQHquGP7TvUBc5resLBrCGsaHoMRqdoi
   gQ9K7p2DsXN1YKhGsqVZC6xqwEitWLq6d0JkG7MqQSwgdH0Xd6zceRBWT
   FjyLlsLhIVpNvZqvSIeOKahyRvBe0akU2MwUM8SX24157rGIStZA7FI2S
   8QCz16WX+expsjGs1Z20WwDfTF43bl3fdGd/iptxbMxEzbgZKlSCDmKDc
   P2Z0hMHACPC7warATC1AFMN6HrDKNsgbo3jx+TBvZPD3xZ6Y2yDOnBF3k
   nGB5FmhXw58rmN/rn7m4nPY2h14Ggl81lA26q1pVsGgNxYNM6mkAm7gMm
   w==;
X-IronPort-AV: E=Sophos;i="5.98,297,1673938800"; 
   d="scan'208";a="144351914"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 12:56:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 12:56:22 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 12:56:22 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/4] crypto: atmel-tdes - Detecting in-place operations with two sg lists
Date:   Tue, 28 Mar 2023 12:56:27 -0700
Message-ID: <ad0815e3b8ffcb9d627895fe2464ef15dbb44a56.1680019905.git.Ryan.Wanner@microchip.com>
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

Avoiding detecting finely in-place operations with different
scatter lists. Copying the source data for decryption into rctx->lastc
regardless if the operation is in-place or not. This allows in-place
operations with different scatter lists without affecting other
operations.

This approach takes less resources than parsing both scatter lists to
check if they are equal.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/crypto/atmel-tdes.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 8b7bc1076e0d..edf18073516e 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -565,17 +565,12 @@ atmel_tdes_set_iv_as_last_ciphertext_block(struct atmel_tdes_dev *dd)
 	if (req->cryptlen < ivsize)
 		return;
 
-	if (rctx->mode & TDES_FLAGS_ENCRYPT) {
+	if (rctx->mode & TDES_FLAGS_ENCRYPT)
 		scatterwalk_map_and_copy(req->iv, req->dst,
 					 req->cryptlen - ivsize, ivsize, 0);
-	} else {
-		if (req->src == req->dst)
-			memcpy(req->iv, rctx->lastc, ivsize);
-		else
-			scatterwalk_map_and_copy(req->iv, req->src,
-						 req->cryptlen - ivsize,
-						 ivsize, 0);
-	}
+	else
+		memcpy(req->iv, rctx->lastc, ivsize);
+
 }
 
 static void atmel_tdes_finish_req(struct atmel_tdes_dev *dd, int err)
@@ -722,7 +717,7 @@ static int atmel_tdes_crypt(struct skcipher_request *req, unsigned long mode)
 	rctx->mode = mode;
 
 	if ((mode & TDES_FLAGS_OPMODE_MASK) != TDES_FLAGS_ECB &&
-	    !(mode & TDES_FLAGS_ENCRYPT) && req->src == req->dst) {
+	    !(mode & TDES_FLAGS_ENCRYPT)) {
 		unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 
 		if (req->cryptlen >= ivsize)
-- 
2.37.2

