Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4DB6B5A24
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCKJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCKJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:42:08 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2031981;
        Sat, 11 Mar 2023 01:42:06 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pavEB-002xbR-I9; Sat, 11 Mar 2023 17:09:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 11 Mar 2023 17:09:23 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Sat, 11 Mar 2023 17:09:23 +0800
Subject: [v7 PATCH 7/8] crypto: stm32 - Fix empty message processing
References: <ZAxFBR3TdA7jUAgJ@gondor.apana.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Message-Id: <E1pavEB-002xbR-I9@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the emptymsg check in stm32_hash_copy_hash to rely on whether
we have any existing hash state, rather than whether this particular
update request is empty.  

Also avoid computing the hash for empty messages as this could hang.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/stm32/stm32-hash.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 478822fc7a4e..f898ec62b459 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -95,6 +95,7 @@
 #define HASH_FLAGS_SHA1			BIT(19)
 #define HASH_FLAGS_SHA224		BIT(20)
 #define HASH_FLAGS_SHA256		BIT(21)
+#define HASH_FLAGS_EMPTY		BIT(22)
 #define HASH_FLAGS_HMAC			BIT(23)
 
 #define HASH_OP_UPDATE			1
@@ -310,13 +311,6 @@ static void stm32_hash_write_ctrl(struct stm32_hash_dev *hdev, int bufcnt)
 				reg |= HASH_CR_LKEY;
 		}
 
-		/*
-		 * On the Ux500 we need to set a special flag to indicate that
-		 * the message is zero length.
-		 */
-		if (hdev->pdata->ux500 && bufcnt == 0)
-			reg |= HASH_CR_UX500_EMPTYMSG;
-
 		if (!hdev->polled)
 			stm32_hash_write(hdev, HASH_IMR, HASH_DCIE);
 
@@ -366,13 +360,23 @@ static void stm32_hash_append_sg(struct stm32_hash_request_ctx *rctx)
 static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 			       const u8 *buf, size_t length, int final)
 {
+	struct stm32_hash_request_ctx *rctx = ahash_request_ctx(hdev->req);
+	struct stm32_hash_state *state = &rctx->state;
 	unsigned int count, len32;
 	const u32 *buffer = (const u32 *)buf;
 	u32 reg;
 
-	if (final)
+	if (final) {
 		hdev->flags |= HASH_FLAGS_FINAL;
 
+		/* Do not process empty messages if hw is buggy. */
+		if (!(hdev->flags & HASH_FLAGS_INIT) && !length &&
+		    hdev->pdata->broken_emptymsg) {
+			state->flags |= HASH_FLAGS_EMPTY;
+			return 0;
+		}
+	}
+
 	len32 = DIV_ROUND_UP(length, sizeof(u32));
 
 	dev_dbg(hdev->dev, "%s: length: %zd, final: %x len32 %i\n",
@@ -827,7 +831,7 @@ static void stm32_hash_copy_hash(struct ahash_request *req)
 	__be32 *hash = (void *)rctx->digest;
 	unsigned int i, hashsize;
 
-	if (hdev->pdata->broken_emptymsg && !req->nbytes)
+	if (hdev->pdata->broken_emptymsg && (state->flags & HASH_FLAGS_EMPTY))
 		return stm32_hash_emptymsg_fallback(req);
 
 	switch (state->flags & HASH_FLAGS_ALGO_MASK) {
