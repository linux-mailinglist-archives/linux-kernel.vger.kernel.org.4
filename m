Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67762744EC6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjGBRhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjGBRhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:37:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE0183;
        Sun,  2 Jul 2023 10:37:01 -0700 (PDT)
Received: from dslb-188-097-041-125.188.097.pools.vodafone-ip.de ([188.97.41.125] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qG10N-0007s9-Rs; Sun, 02 Jul 2023 19:36:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] hwrng: nomadik - use dev_err_probe
Date:   Sun,  2 Jul 2023 19:35:03 +0200
Message-Id: <20230702173503.163152-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230702173503.163152-1-martin@kaiser.cx>
References: <20230702173503.163152-1-martin@kaiser.cx>
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

Use dev_err_probe to print a message and return an error. This makes the
code a tiny bit shorter.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/nomadik-rng.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index 3774adf903a8..8c6a40d6ce3d 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -39,11 +39,8 @@ static int nmk_rng_probe(struct amba_device *dev, const struct amba_id *id)
 	int ret;
 
 	rng_clk = devm_clk_get_enabled(&dev->dev, NULL);
-	if (IS_ERR(rng_clk)) {
-		dev_err(&dev->dev, "could not get rng clock\n");
-		ret = PTR_ERR(rng_clk);
-		return ret;
-	}
+	if (IS_ERR(rng_clk))
+		return dev_err_probe(&dev->dev, PTR_ERR(rng_clk), "could not get rng clock\n");
 
 	ret = amba_request_regions(dev, dev->dev.init_name);
 	if (ret)
-- 
2.30.2

