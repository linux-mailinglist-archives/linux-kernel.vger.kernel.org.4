Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2E664261
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbjAJNvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbjAJNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:50:59 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF81D14D3D;
        Tue, 10 Jan 2023 05:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358658;
  x=1704894658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=imTnDMnDHu3Au0k4Q8/xix4gLYf+kdvkY3vppCY1wrw=;
  b=JMjJ0U59I01d/2qkjigFdDLuh+Y2aqC0XKc7rcJCis3BR5wiE6Zmx12w
   FYVThwmkBg9xHoU9QPBK1Ao6fd436ilarcvtpIWUrEJd+ckmjbEdjjj/m
   Zj5Rz2Ek/nLv9VKi4djITF0I+SinjGLRK8c3eAqVK4aa6hV98GeFgyGx+
   h6hfmqpTHQvkTIlNcbpT9BKS/a4WGgpCZy0xyPeAfxZoU1ih14p3dHMFS
   SnwH67IEMQh0Go2cszGYN/LtgaBJJ6ZLXlkYf68bOfzEwTv1kY2NZk7vM
   irzArzYfymXEtFhM6yt5PBytSGz7lK7yYfNQjfIxwgoAoRzDVwyMTHLLV
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars Persson <larper@axis.com>
Subject: [PATCH 01/12] crypto: axis - do not DMA to ahash_request.result
Date:   Tue, 10 Jan 2023 14:50:31 +0100
Message-ID: <20230110135042.2940847-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Persson <larper@axis.com>

The crypto API does not promise that the result pointer is suitable
for DMA.  Use an intermediate result buffer and let the CPU copy the
digest to the ahash_request.

Signed-off-by: Lars Persson <larper@axis.com>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 51c66afbe677..87af44ac3e64 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -276,6 +276,7 @@ enum artpec6_crypto_hash_flags {
 	HASH_FLAG_FINALIZE = 8,
 	HASH_FLAG_HMAC = 16,
 	HASH_FLAG_UPDATE_KEY = 32,
+	HASH_FLAG_FINALIZED = 64,
 };
 
 struct artpec6_crypto_req_common {
@@ -1493,12 +1494,15 @@ static int artpec6_crypto_prepare_hash(struct ahash_request *areq)
 			return error;
 
 		/* Descriptor for the final result */
-		error = artpec6_crypto_setup_in_descr(common, areq->result,
+		error = artpec6_crypto_setup_in_descr(common,
+						      req_ctx->digeststate,
 						      digestsize,
 						      true);
 		if (error)
 			return error;
 
+		req_ctx->hash_flags |= HASH_FLAG_FINALIZED;
+
 	} else { /* This is not the final operation for this request */
 		if (!run_hw)
 			return ARTPEC6_CRYPTO_PREPARE_HASH_NO_START;
@@ -2216,6 +2220,14 @@ static void artpec6_crypto_complete_aead(struct crypto_async_request *req)
 
 static void artpec6_crypto_complete_hash(struct crypto_async_request *req)
 {
+	struct ahash_request *areq = container_of(req, struct ahash_request, base);
+	struct artpec6_hash_request_context *ctx = ahash_request_ctx(areq);
+	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
+	size_t digestsize = crypto_ahash_digestsize(ahash);
+
+	if (ctx->hash_flags & HASH_FLAG_FINALIZED)
+		memcpy(areq->result, ctx->digeststate, digestsize);
+
 	req->complete(req, 0);
 }
 
-- 
2.34.1

