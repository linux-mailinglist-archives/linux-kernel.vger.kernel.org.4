Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29AB664263
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbjAJNvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbjAJNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:51:03 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93D2F7A7;
        Tue, 10 Jan 2023 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673358660;
  x=1704894660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lvf8Py85+laCpLifVy0ksENVI/hrPFpksg+ojS6TM10=;
  b=h0JmM4T/fLgrBeEcYwca5bXVSFqSPvY8i58kSVV6oCmQFc+al+6CMS0h
   jBEeWwVgPRtGbRbSQvLLB4YlhhyfSCZ9tbKleOABR4JGSXaddiJETasrX
   B1CXZ72A7/Bb9PfIEisBHtoItweD10MXpx0KQTMiBzAGNas5S+rbQiUGS
   419pWsRA6UftGuLD4PM1D0qu+QngKc1TsEts16RIYA8J8BHKdnEjF2JBP
   1jIhWHrgWfF/9VneHGN8PwzNGxAVwD+F4B2/vw1tJvMpGUHhXg2G4FovJ
   Jqd3R4Ky+hZ78Lp+ClWqhgrwhfJc2xJy4katrBnRwaq43ksDUkw/MnedH
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <jesper.nilsson@axis.com>, <lars.persson@axis.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/12] crypto: axis - fix XTS blocksize
Date:   Tue, 10 Jan 2023 14:50:37 +0100
Message-ID: <20230110135042.2940847-8-vincent.whitchurch@axis.com>
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

Use the correct XTS blocksize to fix this warning with
CRYPTO_MANAGER_EXTRA_TESTS:

 skcipher: blocksize for artpec6-xts-aes (1) doesn't match generic impl
 (16)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/crypto/axis/artpec6_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/axis/artpec6_crypto.c b/drivers/crypto/axis/artpec6_crypto.c
index 78d067ce4138..5f30f3d0315f 100644
--- a/drivers/crypto/axis/artpec6_crypto.c
+++ b/drivers/crypto/axis/artpec6_crypto.c
@@ -2831,7 +2831,7 @@ static struct skcipher_alg crypto_algos[] = {
 			.cra_priority = 300,
 			.cra_flags = CRYPTO_ALG_ASYNC |
 				     CRYPTO_ALG_ALLOCATES_MEMORY,
-			.cra_blocksize = 1,
+			.cra_blocksize = AES_BLOCK_SIZE,
 			.cra_ctxsize = sizeof(struct artpec6_cryptotfm_context),
 			.cra_alignmask = 3,
 			.cra_module = THIS_MODULE,
-- 
2.34.1

