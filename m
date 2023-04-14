Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0996E1DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:07:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D640F1;
        Fri, 14 Apr 2023 01:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DD161610;
        Fri, 14 Apr 2023 08:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FEEC433D2;
        Fri, 14 Apr 2023 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681459635;
        bh=CMhlV7gPjxolgtoBHwxReUD4SNxzZsVia1mEu5DPBd8=;
        h=From:To:Cc:Subject:Date:From;
        b=uABKpT3UCvTTNEsfJZpyjJBkygzHhGJQja6hX0ABRo3ZqRlS5uvNVlZFDkeNBkODp
         otvcfYNuh5ilBkLyOcNItBbWSMahvv2QXfZr797hemQq9CMMIAWj38JQH8YderAKqR
         sO6P/HMzoBSFL/erIvEGazK5Sz4CT/bQdL5ou1qDI503nuLI1F734X9l4lJx+GkrH8
         E46a+sPrkwchkLNtJsm+bRvr+0bOnKVL2kW52GfGvMG4J3wnfIpUe/sCIO5MCOiOXV
         czagPpNjp7NFkphzMdAOFXugeRxgOOrwECN3vAsxfc16HFcG4FF6BdZ0i5mGZ6lDre
         BnDVmWVbfjsOA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ixp4xx_crypto: fix building wiht 64-bit dma_addr_t
Date:   Fri, 14 Apr 2023 10:06:56 +0200
Message-Id: <20230414080709.284005-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The crypt_ctl structure must be exactly 64 bytes long to work correctly,
and it has to be a power-of-two size to allow turning the
64-bit division in crypt_phys2virt() into a shift operation, avoiding
the link failure:

ERROR: modpost: "__aeabi_uldivmod" [drivers/crypto/intel/ixp4xx/ixp4xx_crypto.ko] undefined!

The failure now shows up because the driver is available for compile
testing after the move, and a previous fix turned the more descriptive
BUILD_BUG_ON() into a link error.

Change the variably-sized dma_addr_t into the expected 'u32' type that is
needed for the hardware, and reinstate the size check for all 32-bit
architectures to simplify debugging if it hits again.

Fixes: 1bc7fdbf2677 ("crypto: ixp4xx - Move driver to drivers/crypto/intel/ixp4xx")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
index 5d640f13ad1c..ed15379a9818 100644
--- a/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
+++ b/drivers/crypto/intel/ixp4xx/ixp4xx_crypto.c
@@ -118,9 +118,9 @@ struct crypt_ctl {
 	u8 mode;		/* NPE_OP_*  operation mode */
 #endif
 	u8 iv[MAX_IVLEN];	/* IV for CBC mode or CTR IV for CTR mode */
-	dma_addr_t icv_rev_aes;	/* icv or rev aes */
-	dma_addr_t src_buf;
-	dma_addr_t dst_buf;
+	u32 icv_rev_aes;	/* icv or rev aes */
+	u32 src_buf;
+	u32 dst_buf;
 #ifdef __ARMEB__
 	u16 auth_offs;		/* Authentication start offset */
 	u16 auth_len;		/* Authentication data length */
@@ -263,7 +263,8 @@ static int setup_crypt_desc(void)
 {
 	struct device *dev = &pdev->dev;
 
-	BUILD_BUG_ON(!IS_ENABLED(CONFIG_COMPILE_TEST) &&
+	BUILD_BUG_ON(!(IS_ENABLED(CONFIG_COMPILE_TEST) &&
+		       IS_ENABLED(CONFIG_64BIT)) &&
 		     sizeof(struct crypt_ctl) != 64);
 	crypt_virt = dma_alloc_coherent(dev,
 					NPE_QLEN * sizeof(struct crypt_ctl),
@@ -1170,10 +1171,11 @@ static int aead_perform(struct aead_request *req, int encrypt,
 	}
 
 	if (unlikely(lastlen < authsize)) {
+		dma_addr_t dma;
 		/* The 12 hmac bytes are scattered,
 		 * we need to copy them into a safe buffer */
-		req_ctx->hmac_virt = dma_pool_alloc(buffer_pool, flags,
-						    &crypt->icv_rev_aes);
+		req_ctx->hmac_virt = dma_pool_alloc(buffer_pool, flags, &dma);
+		crypt->icv_rev_aes = dma;
 		if (unlikely(!req_ctx->hmac_virt))
 			goto free_buf_dst;
 		if (!encrypt) {
-- 
2.39.2

