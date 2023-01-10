Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D1664264
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjAJNvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbjAJNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:50:58 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9DE64EE;
        Tue, 10 Jan 2023 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358657;
  x=1704894657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBWPPr1+kqTd4bU3Mi91t3NpLL6yLU7kv9iml0RWA0w=;
  b=cSmKa9qjjsnjdPUeeXCfU3LJGnsMVCPkTtz9FYcRTS5ReqDGUC21jvmt
   BqRXGb8TM7Q+Cmd8W04/g+V5otzsJTkV0bzhjUtl1T94YhP/NR9eXgmbW
   sYJ8Siu+DnFKnOqowc5g0w2wEBJaSJnKrMW6YMgI/8deN1iIzZ2UbV0S1
   FuKmPm9Hbf3KTcGGiaksEYVQ2WvHki+XTTNHq+hUV+RJ8M6m2azRfANCm
   fScmTcQAJvT/vDZE/LH05Kw4cICYI7hF9MoZcphu9GfojoxwRr3+jZRas
   xfn+7930u5uv3LF6WPIRbXFEVdyNdja7WqnfgoKbhzRhaM9btjVAmc+Rr
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/12] crypto: axis - do not DMA to IV
Date:   Tue, 10 Jan 2023 14:50:32 +0100
Message-ID: <20230110135042.2940847-3-vincent.whitchurch@axis.com>
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

The crypto API does not promise that the IV buffer is suitable for DMA.
Use an intermediate buffer instead.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 87af44ac3e64..d3b6ee065a81 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -321,6 +321,7 @@ struct artpec6_crypto_request_context {
 	u32 cipher_md;
 	bool decrypt;
 	struct artpec6_crypto_req_common common;
+	unsigned char iv_bounce[AES_BLOCK_SIZE] CRYPTO_MINALIGN_ATTR;
 };
 
 struct artpec6_cryptotfm_context {
@@ -1779,7 +1780,8 @@ static int artpec6_crypto_prepare_crypto(struct skcipher_request *areq)
 		return ret;
 
 	if (iv_len) {
-		ret = artpec6_crypto_setup_out_descr(common, areq->iv, iv_len,
+		memcpy(req_ctx->iv_bounce, areq->iv, iv_len);
+		ret = artpec6_crypto_setup_out_descr(common, req_ctx->iv_bounce, iv_len,
 						     false, false);
 		if (ret)
 			return ret;
-- 
2.34.1

