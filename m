Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5770472B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjEPH6K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 May 2023 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjEPH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:58:03 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591A30C2;
        Tue, 16 May 2023 00:58:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1E33E24E302;
        Tue, 16 May 2023 15:58:00 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 15:58:00 +0800
Received: from ubuntu.localdomain (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 16 May
 2023 15:57:57 +0800
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH 1/2] crypto: starfive - Update hash module irq handling
Date:   Tue, 16 May 2023 15:57:51 +0800
Message-ID: <20230516075752.659287-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516075752.659287-1-jiajie.ho@starfivetech.com>
References: <20230516075752.659287-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hash driver needs to check the value of irq mask register before writing
as it will mask irq of other modules.

Co-developed-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 drivers/crypto/starfive/jh7110-hash.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/starfive/jh7110-hash.c b/drivers/crypto/starfive/jh7110-hash.c
index 3801e44f2f33..5064150b8a1c 100644
--- a/drivers/crypto/starfive/jh7110-hash.c
+++ b/drivers/crypto/starfive/jh7110-hash.c
@@ -39,6 +39,7 @@
 #define STARFIVE_HASH_SHAWKLEN		(STARFIVE_HASH_REGS_OFFSET + 0x24)
 
 #define STARFIVE_HASH_BUFLEN		SHA512_BLOCK_SIZE
+#define STARFIVE_HASH_RESET		0x2
 
 static inline int starfive_hash_wait_busy(struct starfive_cryp_ctx *ctx)
 {
@@ -95,6 +96,7 @@ static void starfive_hash_start(void *param)
 	struct starfive_cryp_dev *cryp = ctx->cryp;
 	union starfive_alg_cr alg_cr;
 	union starfive_hash_csr csr;
+	u32 stat;
 
 	dma_unmap_sg(cryp->dev, rctx->in_sg, rctx->in_sg_len, DMA_TO_DEVICE);
 
@@ -107,7 +109,9 @@ static void starfive_hash_start(void *param)
 	csr.firstb = 0;
 	csr.final = 1;
 
-	writel(~STARFIVE_IE_MASK_HASH_DONE, cryp->base + STARFIVE_IE_MASK_OFFSET);
+	stat = readl(cryp->base + STARFIVE_IE_MASK_OFFSET);
+	stat &= ~STARFIVE_IE_MASK_HASH_DONE;
+	writel(stat, cryp->base + STARFIVE_IE_MASK_OFFSET);
 	writel(csr.v, cryp->base + STARFIVE_HASH_SHACSR);
 }
 
@@ -223,6 +227,9 @@ void starfive_hash_done_task(unsigned long param)
 	if (!err)
 		err = starfive_hash_copy_hash(cryp->req.hreq);
 
+	/* Reset to clear hash_done in irq register*/
+	writel(STARFIVE_HASH_RESET, cryp->base + STARFIVE_HASH_SHACSR);
+
 	crypto_finalize_hash_request(cryp->engine, cryp->req.hreq, err);
 }
 
-- 
2.25.1

