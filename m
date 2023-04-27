Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35436F0C55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbjD0TIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbjD0TIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:08:32 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F72049DA;
        Thu, 27 Apr 2023 12:08:10 -0700 (PDT)
Received: from ipservice-092-217-081-249.092.217.pools.vodafone-ip.de ([92.217.81.249] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ps6l4-0003RX-PD; Thu, 27 Apr 2023 20:54:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] hwrng: imx-rngc - use bitfield macros to read fifo level
Date:   Thu, 27 Apr 2023 20:53:55 +0200
Message-Id: <20230427185357.923412-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230427185357.923412-1-martin@kaiser.cx>
References: <20230427185357.923412-1-martin@kaiser.cx>
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

Use the mechanism from bitfield.h to read the fifo level field in the
status register. This makes the code a tiny bit simpler.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index a1c24148ed31..861a615ac7df 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -17,6 +17,7 @@
 #include <linux/hw_random.h>
 #include <linux/completion.h>
 #include <linux/io.h>
+#include <linux/bitfield.h>
 
 #define RNGC_VER_ID			0x0000
 #define RNGC_COMMAND			0x0004
@@ -44,8 +45,7 @@
 #define RNGC_CTRL_AUTO_SEED		0x00000010
 
 #define RNGC_STATUS_ERROR		0x00010000
-#define RNGC_STATUS_FIFO_LEVEL_MASK	0x00000f00
-#define RNGC_STATUS_FIFO_LEVEL_SHIFT	8
+#define RNGC_STATUS_FIFO_LEVEL		GENMASK(11, 8)
 #define RNGC_STATUS_SEED_DONE		0x00000020
 #define RNGC_STATUS_ST_DONE		0x00000010
 
@@ -133,9 +133,7 @@ static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
 			break;
 
 		/* how many random numbers are in FIFO? [0-16] */
-		level = (status & RNGC_STATUS_FIFO_LEVEL_MASK) >>
-			RNGC_STATUS_FIFO_LEVEL_SHIFT;
-
+		level = FIELD_GET(RNGC_STATUS_FIFO_LEVEL, status);
 		if (level) {
 			/* retrieve a random number from FIFO */
 			*(u32 *)data = readl(rngc->base + RNGC_FIFO);
-- 
2.30.2

