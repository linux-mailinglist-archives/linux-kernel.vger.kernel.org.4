Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4804B6C9519
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjCZOVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjCZOVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:21:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DAC5BBE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:21:19 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gRFFphd6xpD2AgRFFplFF9; Sun, 26 Mar 2023 16:21:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 16:21:18 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: i2c: ov7670: Use the devm_clk_get_optional() helper
Date:   Sun, 26 Mar 2023 16:21:16 +0200
Message-Id: <a6fd15c221a76c92a23afa9b678555d6639acea7.1679840463.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() instead of hand writing it.
This saves some loC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/ov7670.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index b1bb0833571e..ecbded4f0765 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -1894,14 +1894,9 @@ static int ov7670_probe(struct i2c_client *client)
 			info->pclk_hb_disable = true;
 	}
 
-	info->clk = devm_clk_get(&client->dev, "xclk"); /* optional */
-	if (IS_ERR(info->clk)) {
-		ret = PTR_ERR(info->clk);
-		if (ret == -ENOENT)
-			info->clk = NULL;
-		else
-			return ret;
-	}
+	info->clk = devm_clk_get_optional(&client->dev, "xclk");
+	if (IS_ERR(info->clk))
+		return PTR_ERR(info->clk);
 
 	ret = ov7670_init_gpio(client, info);
 	if (ret)
-- 
2.34.1

