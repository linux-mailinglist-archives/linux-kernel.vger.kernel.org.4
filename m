Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613016E51D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQU00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjDQU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:26:23 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7795FEB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 13:26:00 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id oVPSpee2zSbkVoVPTp9Pz8; Mon, 17 Apr 2023 22:25:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681763116;
        bh=3onsbqZgKfvrXgPm/nW/ZF4q8OzaHmYxJu4RGrC1D6U=;
        h=From:To:Cc:Subject:Date;
        b=ZYJegovxU/r5wUZqc2AuOcLGEoKUXh8XzjZN4HvUyxJJ4fd6Mo0DqAD5RiL4ThcHe
         l0pvp/0p8CBXDXEypDegzNS+/+Gi0TT5KQ+Gibg9vtvmnUxcdX+dR6846L+Vt9f+Ub
         7e1xkbitW9ZhgbZQNrK5wXfkImsHx7p6Zt6229Vt0bJel826+2haY12YdBeX2bJjaV
         zPW4YxdGdepDialzEASqca1Fp2ngjd7dYIBy3wonShZ0dnO39VhZWATr2G3vdYhoxf
         8WP7Eo+OfkhbZEN6SFuST7GuVxuH0/r79URE/7CfyJnYvAKGZ6unibwMYWwduZr8Vj
         zoZz0/c8mFf4g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 22:25:16 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()
Date:   Mon, 17 Apr 2023 22:25:09 +0200
Message-Id: <bedaeefc8e2099ab255e7542e7d671889678de86.1681763086.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SS_ENCRYPTION is (0 << 7 = 0), so the test can never be true.
Use a direct comparison to SS_ENCRYPTION instead.

The same king of test is already done the same way in sun8i_ss_run_task().

Fixes: 359e893e8af4 ("crypto: sun8i-ss - rework handling of IV")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
index 83c6dfad77e1..16966cc94e24 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c
@@ -151,7 +151,7 @@ static int sun8i_ss_setup_ivs(struct skcipher_request *areq)
 		}
 		rctx->p_iv[i] = a;
 		/* we need to setup all others IVs only in the decrypt way */
-		if (rctx->op_dir & SS_ENCRYPTION)
+		if (rctx->op_dir == SS_ENCRYPTION)
 			return 0;
 		todo = min(len, sg_dma_len(sg));
 		len -= todo;
-- 
2.34.1

