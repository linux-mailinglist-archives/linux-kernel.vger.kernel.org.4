Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3890D733F04
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjFQHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:12:08 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBAC211D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:12:06 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AQ6OqsOdNhQKVAQ6OqaPHj; Sat, 17 Jun 2023 09:12:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686985925;
        bh=uwjvZj5RduTr+IL/itfPrhtkCpiCiq3BjJuJN5U78E8=;
        h=From:To:Cc:Subject:Date;
        b=Q/XB/le1cPA7lV0lwHKtheheqImQ1ZC+UbmBb0RrLc5UUPy0ApWfj8i+ezLJggG61
         MrPi/9TLFjqBilDykja7HpJCw9l0Ys1/tpSW0E1ShgsgKWHVl26PLf+HLxY0/WzZGN
         0I/RbY3K0/VvylXKDIb0Js6FWQfR7GC8sPCC6C4t66qaQy55ZxoW4Zv0jtJcGa9qcX
         hwkfloujL0ivqu1ygVejbFVMGc7IZW4VskCT5IgA3ofTSCTcQkq4e1Mjz9cePLCu71
         RZquMs4za+u16/DKyE3eBKvCH3aX4WZnFyaEkSKoRziCaA1y2Nn/MLLytcLDPjuEVZ
         gfPZLMLPt13HA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 17 Jun 2023 09:12:05 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: adp5588-keys - Use devm_regulator_get_enable()
Date:   Sat, 17 Jun 2023 09:12:03 +0200
Message-Id: <af343b5b0d740cc9f8863264c30e3da4215721d7.1686985911.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regulator_get_enable() instead of hand writing it. It saves some
line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/keyboard/adp5588-keys.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 896a5a989ddc..61e8e43e9c2b 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -713,17 +713,11 @@ static int adp5588_fw_parse(struct adp5588_kpad *kpad)
 	return 0;
 }
 
-static void adp5588_disable_regulator(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int adp5588_probe(struct i2c_client *client)
 {
 	struct adp5588_kpad *kpad;
 	struct input_dev *input;
 	struct gpio_desc *gpio;
-	struct regulator *vcc;
 	unsigned int revid;
 	int ret;
 	int error;
@@ -749,16 +743,7 @@ static int adp5588_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	vcc = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(vcc))
-		return PTR_ERR(vcc);
-
-	error = regulator_enable(vcc);
-	if (error)
-		return error;
-
-	error = devm_add_action_or_reset(&client->dev,
-					 adp5588_disable_regulator, vcc);
+	error = devm_regulator_get_enable(&client->dev, "vcc");
 	if (error)
 		return error;
 
-- 
2.34.1

