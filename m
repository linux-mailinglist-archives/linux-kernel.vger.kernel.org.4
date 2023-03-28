Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D96CCB03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjC1T4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC1T41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:56:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6143AA2;
        Tue, 28 Mar 2023 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680033386; x=1711569386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B79al2p37wc0hLyQzNhdQMnWH/qY4G74yzTaZc4Qtqg=;
  b=lDCtGG9aG8/HR4efU839qQZ04ThxubNmUC1iY2ZIlGybwZxGFRMKDCZG
   Kr+iy+ALaMlc1yLPbn2OTT1RSV+y6qkhbMq06SiLNLxFYWjlR8GCz23aY
   7EWuVtCldWiasJt0o1yLLOaKx4sVEU5PfX1Fz5Za6JwMorTLJzvLcGDU0
   xQRQAWR/sprUk4LP/QybdE8nt2Jhkry+d48XVnORIS/DHR2mC27lXkYqB
   IVMvoBGL7/U1/sTn/W7TztHDkN3mO09ykcHtNaQlXjHA9mY3XqIZTZNKC
   crVrPOdJ6QzIFgCK1munlUhdTvSfvfsDZP3JKErczO27RXRUjGRfQu6Jy
   g==;
X-IronPort-AV: E=Sophos;i="5.98,297,1673938800"; 
   d="scan'208";a="144351915"
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
Subject: [PATCH 3/4] crypto: atmel-aes - Detecting in-place operations two sg lists
Date:   Tue, 28 Mar 2023 12:56:28 -0700
Message-ID: <74e969a12021b008d12d871d8d4d9162905f3c48.1680019905.git.Ryan.Wanner@microchip.com>
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
operations with different scatter lists.

This approach takes less resources than parsing both scatter lists to
check if they are equal.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/crypto/atmel-aes.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 063394cfa874..08a923c2a0eb 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -493,17 +493,11 @@ static void atmel_aes_set_iv_as_last_ciphertext_block(struct atmel_aes_dev *dd)
 	if (req->cryptlen < ivsize)
 		return;
 
-	if (rctx->mode & AES_FLAGS_ENCRYPT) {
+	if (rctx->mode & AES_FLAGS_ENCRYPT)
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
 }
 
 static inline struct atmel_aes_ctr_ctx *
@@ -1146,7 +1140,7 @@ static int atmel_aes_crypt(struct skcipher_request *req, unsigned long mode)
 	rctx->mode = mode;
 
 	if (opmode != AES_FLAGS_ECB &&
-	    !(mode & AES_FLAGS_ENCRYPT) && req->src == req->dst) {
+	    !(mode & AES_FLAGS_ENCRYPT)) {
 		unsigned int ivsize = crypto_skcipher_ivsize(skcipher);
 
 		if (req->cryptlen >= ivsize)
-- 
2.37.2

