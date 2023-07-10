Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3574DF48
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGJU3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGJU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:29:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296C1A8;
        Mon, 10 Jul 2023 13:29:31 -0700 (PDT)
Received: from 250.57.4.146.static.wline.lns.sme.cust.swisscom.ch ([146.4.57.250] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIxVh-0002mg-5h; Mon, 10 Jul 2023 22:29:29 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     aric.pzqi@ingenic.com, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 6/7] hwrng: ingenic - don't disable the rng in ingenic_trng_remove
Date:   Mon, 10 Jul 2023 22:27:32 +0200
Message-Id: <20230710202733.116133-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230710202733.116133-1-martin@kaiser.cx>
References: <20230710202733.116133-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to disable the rng in ingenic_trng_remove.

The driver's init function sets the CFG_GEN_EN bit to enable the
rng. The cleanup function clears CFG_GEN_EN to revert this.

The remove function calls hwrng_unregister. If the ingenic-trng is not
the current rng at this point, CFG_GEN_EN has already been cleared. If
the ingenic-trng is the current rng, drop_current_rng will call the
cleanup function.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ingenic-trng.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/char/hw_random/ingenic-trng.c b/drivers/char/hw_random/ingenic-trng.c
index cc88a941c929..9c54721f8399 100644
--- a/drivers/char/hw_random/ingenic-trng.c
+++ b/drivers/char/hw_random/ingenic-trng.c
@@ -111,14 +111,9 @@ static int ingenic_trng_probe(struct platform_device *pdev)
 static int ingenic_trng_remove(struct platform_device *pdev)
 {
 	struct ingenic_trng *trng = platform_get_drvdata(pdev);
-	unsigned int ctrl;
 
 	hwrng_unregister(&trng->rng);
 
-	ctrl = readl(trng->base + TRNG_REG_CFG_OFFSET);
-	ctrl &= ~CFG_GEN_EN;
-	writel(ctrl, trng->base + TRNG_REG_CFG_OFFSET);
-
 	return 0;
 }
 
-- 
2.30.2

