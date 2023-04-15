Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A306E3272
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDOQ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:29:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227AC40F5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:29:01 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id nilnpmo5muZFDnilnpv4vy; Sat, 15 Apr 2023 18:29:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
        s=t20230301; t=1681576140;
        bh=YsiWv6bqCCOxDwt4FovLlKlpgNUCDzr+TCLIp5uyNw0=;
        h=From:To:Cc:Subject:Date;
        b=GAVwofU1F+a6cmdEitjtAipdJku2R+oAahfLTu7vabqbm/q2LPX9MKr2CMwU/jNwR
         /Ia55aBwxSTRQFLF9aESomYpnQyn+y4rNYvyz2wbZ8nKbGDE04hLFMnqXw7eDLeXfR
         sRmr5z5M4QM3Dx86XWNuvFtIuWL/FnH+Lo00rT3mnt7mfEnPzxxsZ+eFjUPSwvsb3R
         L///3xfGzxAonw74NTwHO51DvST7KfgthCzF9A5E1ZnL4f6boqmoMyE6f0ohOVbkNh
         KCbHTbFv+TXmXWZ8SSzqEhSRM8zdadxx8LooDqPMKTotkcrBKGDhnFAZfzaOSRAbVW
         nTp/ljV2z65/g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 15 Apr 2023 18:29:00 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: ov5693: Simplify an error message
Date:   Sat, 15 Apr 2023 18:28:58 +0200
Message-Id: <928f2f70de241d0fa66801b46d736ad0f881eb72.1681576102.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() already display the error code. There is no need to
duplicate it explicitly in the error message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/i2c/ov5693.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index e3c3bed69ad6..d23786afd754 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -404,8 +404,8 @@ static int ov5693_read_reg(struct ov5693_device *ov5693, u32 addr, u32 *value)
 	ret = i2c_transfer(client->adapter, msg, 2);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
-				     "Failed to read register 0x%04x: %d\n",
-				     addr & OV5693_REG_ADDR_MASK, ret);
+				     "Failed to read register 0x%04x\n",
+				     addr & OV5693_REG_ADDR_MASK);
 
 	*value = 0;
 	for (i = 0; i < len; ++i) {
-- 
2.34.1

