Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D824466426C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjAJNvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjAJNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:04 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2661138AEC;
        Tue, 10 Jan 2023 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358661;
  x=1704894661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0o6C4Z0fqkBE+QbzIuVUWhJF6tXZkBBn8amIrYpgsE4=;
  b=eKXy+xQVwCBCX6t2xBW3l2KdBQ6wmn9gCPW25aAMe2t1SLCJ6kzTAOAD
   iVd+MBXn+/oYxP2zkvpmujAE/4+37pDG82jFXVchoWEIp/xbENNOHRo8S
   xUvK0EYLvRTGwTVX1pKyQ0wEnoxMXFSSWCtBBcx5Oy3RGLSX22Do+RePz
   sHp+shW1c6MLddkqVL2UNYhNUOkcC80tc9xHAilqSS11UIHcLX7K4m+Za
   +I/8CDbq66mQyrkjlJ5YTXxv++hGiVYJyu4upslD6EDIRFkLdrVS6hstx
   yeh1OhLe5yVyd5F/k3IT5sW3nNCsLTB/axmdDcIvpKkdKH/C8jVPsWp+R
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/12] crypto: axis - allow small size for AEAD
Date:   Tue, 10 Jan 2023 14:50:42 +0100
Message-ID: <20230110135042.2940847-13-vincent.whitchurch@axis.com>
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

Allow sizes smaller than the AES block size to fix this failure with
CRYPTO_MANAGER_EXTRA_TESTS:

 alg: aead: artpec-gcm-aes decryption failed on test vector "random:
 alen=0 plen=1 authsize=4 klen=32 novrfy=0"; expected_error=0,
 actual_error=-22, cfg="random: inplace_one_sglist may_sleep use_final
 src_divs=[<reimport>9.71%@+778, <flush>23.43%@+2818, 52.69%@+6,
 <flush>11.98%@+1030, 2.19%@+3986] iv_offset=40 key_offset=32"

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 938faf3afa69..b6fa2af42cd0 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -1452,8 +1452,6 @@ static int artpec6_crypto_aead_decrypt(struct aead_request *req)
 	struct artpec6_crypto_aead_req_ctx *req_ctx = aead_request_ctx(req);
 
 	req_ctx->decrypt = true;
-	if (req->cryptlen < AES_BLOCK_SIZE)
-		return -EINVAL;
 
 	ret = artpec6_crypto_common_init(&req_ctx->common,
 				  &req->base,
-- 
2.34.1

