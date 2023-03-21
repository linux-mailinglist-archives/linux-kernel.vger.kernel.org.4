Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018A6C2AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCUG74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCUG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:59:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69456A7F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:59:38 -0700 (PDT)
Received: from ubuntu-CJ.centvel.lan ([78.31.41.93])
        by smtp.orange.fr with ESMTPA
        id eVy0pApSCqbhzeVy1p9iHb; Tue, 21 Mar 2023 07:59:36 +0100
X-ME-Helo: ubuntu-CJ.centvel.lan
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 21 Mar 2023 07:59:36 +0100
X-ME-IP: 78.31.41.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        kim.phillips@freescale.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] crypto: caam: Clear some memory in instantiate_rng()
Date:   Tue, 21 Mar 2023 07:59:30 +0100
Message-Id: <41a7e41bb5a14f1e6e68a81c16c90e3ad4542ab1.1679381782.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the comment at the end of the 'for' loop just a few lines
below, it looks needed to clear 'desc'.

So it should also be cleared for the first iteration.

Move the memset() to the beginning of the loop to be safe.

Fixes: 281922a1d4f5 ("crypto: caam - add support for SEC v5.x RNG4")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 --> v2:
   - move the memset() instead of doing s/kmalloc/kzalloc/
   - adding a Fixes tag

v1:
   https://lore.kernel.org/all/16d6bf3bd7a6e96a8262fcd4680e3ccbb5a50478.1679355849.git.christophe.jaillet@wanadoo.fr/

For for loop has been introduceD in commit 1005bccd7a4a ("crypto: caam -
enable instantiation of all RNG4 state handles"). But if 'desc' really
needs to be cleared, the issue was there before (thus the Fixes tag in
the commit log)
---
 drivers/crypto/caam/ctrl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 6278afb951c3..71b14269a997 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -284,6 +284,10 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		const u32 rdsta_if = RDSTA_IF0 << sh_idx;
 		const u32 rdsta_pr = RDSTA_PR0 << sh_idx;
 		const u32 rdsta_mask = rdsta_if | rdsta_pr;
+
+		/* Clear the contents before using the descriptor */
+		memset(desc, 0x00, CAAM_CMD_SZ * 7);
+
 		/*
 		 * If the corresponding bit is set, this state handle
 		 * was initialized by somebody else, so it's left alone.
@@ -327,8 +331,6 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 		}
 
 		dev_info(ctrldev, "Instantiated RNG4 SH%d\n", sh_idx);
-		/* Clear the contents before recreating the descriptor */
-		memset(desc, 0x00, CAAM_CMD_SZ * 7);
 	}
 
 	kfree(desc);
-- 
2.32.0

