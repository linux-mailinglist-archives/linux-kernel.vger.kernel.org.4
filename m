Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646A6709BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjESQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:05:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CED9E;
        Fri, 19 May 2023 09:05:33 -0700 (PDT)
Received: from ipservice-092-217-072-086.092.217.pools.vodafone-ip.de ([92.217.72.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1q02bk-0001Ah-JD; Fri, 19 May 2023 18:05:32 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/3] hwrng: imx-rngc - use bitfield macros to read rng type
Date:   Fri, 19 May 2023 18:04:32 +0200
Message-Id: <20230519160433.287161-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230519160433.287161-1-martin@kaiser.cx>
References: <20230427185357.923412-1-martin@kaiser.cx>
 <20230519160433.287161-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the mechanism from bitfield.h to read the rng type field in the
version_id register. This makes the code a tiny bit simpler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index cf29c323453a..b5f7b91bd13e 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -27,7 +27,7 @@
 #define RNGC_FIFO			0x0014
 
 /* the fields in the ver id register */
-#define RNGC_TYPE_SHIFT		28
+#define RNG_TYPE			GENMASK(31, 28)
 #define RNGC_VER_MAJ_SHIFT		8
 
 /* the rng_type field */
@@ -251,7 +251,7 @@ static int imx_rngc_probe(struct platform_device *pdev)
 		return irq;
 
 	ver_id = readl(rngc->base + RNGC_VER_ID);
-	rng_type = ver_id >> RNGC_TYPE_SHIFT;
+	rng_type = FIELD_GET(RNG_TYPE, ver_id);
 	/*
 	 * This driver supports only RNGC and RNGB. (There's a different
 	 * driver for RNGA.)
-- 
2.30.2

