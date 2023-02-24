Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA016A0258
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjBWFT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbjBWFTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:19:18 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBDA47432;
        Wed, 22 Feb 2023 21:19:05 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 5896C1A00A14;
        Thu, 23 Feb 2023 13:19:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yXrtiH0GntNQ; Thu, 23 Feb 2023 13:19:40 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 10B9E1A0092F;
        Thu, 23 Feb 2023 13:19:40 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        mcoquelin.stm32@gmail.com
Cc:     linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] stm32: stm32-hash: Add kmalloc_array allocation check
Date:   Sat, 25 Feb 2023 05:50:19 +0800
Message-Id: <20230224215019.3687-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rctx->hw_context allocation of the context pointer failed. Returning
-ENOMEM and assigning NULL to the out pointer should improve the
robustness of the function.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/crypto/stm32/stm32-hash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index d33006d43f76..18e79f62be96 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -970,6 +970,10 @@ static int stm32_hash_export(struct ahash_request *req, void *out)
 	rctx->hw_context = kmalloc_array(3 + HASH_CSR_REGISTER_NUMBER,
 					 sizeof(u32),
 					 GFP_KERNEL);
+	if (rctx->hw_context == NULL) {
+		out = NULL;
+		return -ENOMEM;
+	}
 
 	preg = rctx->hw_context;
 
-- 
2.18.2

