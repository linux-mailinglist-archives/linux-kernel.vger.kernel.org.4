Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC74733EFE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjFQHFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQHFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:05:51 -0400
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB4319A1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:05:48 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AQ0GqVBftuHEfAQ0GqXvsF; Sat, 17 Jun 2023 09:05:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686985545;
        bh=WaC9vyc9s/L0ETpLjq5kGLLrHASUjYwQHKod4eCpJlU=;
        h=From:To:Cc:Subject:Date;
        b=GFs52UZqJ5HBgxIzvwFp6LVefUM8MKHIcQqzw6/CZrHwJ72SKuFYKHijoq+Gp75kO
         92YzOja+1G0FOSvOskZ2cEPt5n72zmOftpEijMX/XEQ8AuStFeQpdob9kTdmKRKaZy
         siSRXW0KnjOOSVPna4alpFFswLOvsqBLtFgA/iNbOUSFQdhtx14iexQp2II5lPmv9/
         qP+dPHcVHJyAztJp5CaynhGuGFAroQ/w4ESOFEfpuFwTodR0dvhxLKShaplrDD2+Eb
         brXe1lwGXq9qjvkn/SlNpTLFinjsom07z2m7/zIv69yIjIzuElqY7NKY0wNmj6SW7x
         aNO1oy8jqKPuQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 17 Jun 2023 09:05:45 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Samuel Holland <samuel@sholland.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-input@vger.kernel.org
Subject: [PATCH] Input: pinephone-keyboard - Use devm_regulator_get_enable()
Date:   Sat, 17 Jun 2023 09:05:42 +0200
Message-Id: <78d7a4719ed7c372a7aa62afb66d4f1561799b5f.1686985515.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regulator_get_enable() instead of hand writing it. It saves some
line of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/keyboard/pinephone-keyboard.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/input/keyboard/pinephone-keyboard.c b/drivers/input/keyboard/pinephone-keyboard.c
index 038ff3549a7a..147b1f288a33 100644
--- a/drivers/input/keyboard/pinephone-keyboard.c
+++ b/drivers/input/keyboard/pinephone-keyboard.c
@@ -318,40 +318,22 @@ static void ppkb_close(struct input_dev *input)
 	ppkb_set_scan(client, false);
 }
 
-static void ppkb_regulator_disable(void *regulator)
-{
-	regulator_disable(regulator);
-}
-
 static int ppkb_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	unsigned int phys_rows, phys_cols;
 	struct pinephone_keyboard *ppkb;
-	struct regulator *vbat_supply;
 	u8 info[PPKB_MATRIX_SIZE + 1];
 	struct device_node *i2c_bus;
 	int ret;
 	int error;
 
-	vbat_supply = devm_regulator_get(dev, "vbat");
-	error = PTR_ERR_OR_ZERO(vbat_supply);
+	error = devm_regulator_get_enable(dev, "vbat");
 	if (error) {
 		dev_err(dev, "Failed to get VBAT supply: %d\n", error);
 		return error;
 	}
 
-	error = regulator_enable(vbat_supply);
-	if (error) {
-		dev_err(dev, "Failed to enable VBAT: %d\n", error);
-		return error;
-	}
-
-	error = devm_add_action_or_reset(dev, ppkb_regulator_disable,
-					 vbat_supply);
-	if (error)
-		return error;
-
 	ret = i2c_smbus_read_i2c_block_data(client, 0, sizeof(info), info);
 	if (ret != sizeof(info)) {
 		error = ret < 0 ? ret : -EIO;
-- 
2.34.1

