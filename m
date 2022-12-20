Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBEA65202F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiLTMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLTMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:08:05 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B928101D0;
        Tue, 20 Dec 2022 04:08:04 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u8so2653286ilq.13;
        Tue, 20 Dec 2022 04:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IfSCbSly0o1xrmhQf1IGCRWQZHlNdyx8u0zTgR9ZrpU=;
        b=a9Uqf9GWLFLP3QfFtsjGmHljQ5pgPqPZO8SHJyMWptQ0pJUNxKVndp4mnslM8bosiH
         83qAUgmOQiHLn1EJD2Hs4vNxcYoYqkJe2TxiS+lNxg+fdO+ZCThhTKfsHnce1yU8mE5U
         z8i/BZ8SAMqQeVe2Bz+fu4K628AqM+ZBRDWw2tZXSprUTbGehvNZSbclYGZg1w/3+icd
         TbcMsCoLFh6EULwsqZfqD8Xolb4r7UWIPK2q9+rH8b+dMQtzNOyPxwh6AKeElN6P46KK
         uBs5XOMaCGfBXzs81wSI504CCyxsCoPuDUd4c3Qwcg5CzF5dFcqaXtjwTftHOzQidFqt
         ApFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfSCbSly0o1xrmhQf1IGCRWQZHlNdyx8u0zTgR9ZrpU=;
        b=vPk0IBrO4lSxufWBDvAeM1XTyCz8oOk3SaCuhsqy2BttPOy9eOW8cKW8F5RBPBCk2X
         lHitT6/cUBXg8HQEiWVQdxZ9vPjjIiyu7HrbgvkEcXI9CKvNbxFOICftsEF47pICsvpq
         b7v1OUqBSmdm88qRTu4vVYWJde5Acb8QnUmrnPXgTCVXPh5MqvVVNRNEIR1GqGjm/Cf2
         yTpMYc72m6usKrHFT1AT0k+xAVdUUCVcMpWxJoT49DxVYn6dWHsv20yHQjRYLwMjJrF/
         QSTSuyQrnt8CIpA1jqorIydnYPc4l/NlYgYg8EvYPRHHRoWvDLFpftWzEOn398HZsTMe
         Y7RA==
X-Gm-Message-State: ANoB5pkJvB5ObjfBq4ZzrlwJao0NMs2X8ebGN+A73GWC9slhtGZ1t/sY
        E7L5yuBw2bSLQ/n5kK7wB6GnI7rq3/o=
X-Google-Smtp-Source: AA0mqf6LuIvkSGby69sf3B3Id1bdVuIwxESBnCVO+iyGVlvyCDlx9HOFzWBQ0Rv24JM3Taj3AIEFQQ==
X-Received: by 2002:a92:5408:0:b0:303:6d34:4ba6 with SMTP id i8-20020a925408000000b003036d344ba6mr25801627ilb.2.1671538082967;
        Tue, 20 Dec 2022 04:08:02 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:3e4c:2ca1:8128:e7be])
        by smtp.gmail.com with ESMTPSA id z90-20020a0293e3000000b00389d81b2f67sm4586300jah.160.2022.12.20.04.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:08:02 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] media: i2c: imx219: Split common registers from mode tables
Date:   Tue, 20 Dec 2022 06:07:53 -0600
Message-Id: <20221220120754.2040428-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four modes, and each mode has a table of registers.
Some of the registers are common to all modes, so create new
tables for these common registers to reduce duplicate code.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
V4:  No Change

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index 77bd79a5954e..7f44d62047b6 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -145,23 +145,61 @@ struct imx219_mode {
 	struct imx219_reg_list reg_list;
 };
 
-/*
- * Register sets lifted off the i2C interface from the Raspberry Pi firmware
- * driver.
- * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
- */
-static const struct imx219_reg mode_3280x2464_regs[] = {
-	{0x0100, 0x00},
+static const struct imx219_reg imx219_common_regs[] = {
+	{0x0100, 0x00},	/* Mode Select */
+
+	/* To Access Addresses 3000-5fff, send the following commands */
 	{0x30eb, 0x0c},
 	{0x30eb, 0x05},
 	{0x300a, 0xff},
 	{0x300b, 0xff},
 	{0x30eb, 0x05},
 	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
+
+	/* PLL Clock Table */
+	{0x0301, 0x05},	/* VTPXCK_DIV */
+	{0x0303, 0x01},	/* VTSYSCK_DIV */
+	{0x0304, 0x03},	/* PREPLLCK_VT_DIV 0x03 = AUTO set */
+	{0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
+	{0x0306, 0x00},	/* PLL_VT_MPY */
+	{0x0307, 0x39},
+	{0x030b, 0x01},	/* OP_SYS_CLK_DIV */
+	{0x030c, 0x00},	/* PLL_OP_MPY */
+	{0x030d, 0x72},
+
+	/* Undocumented registers */
+	{0x455e, 0x00},
+	{0x471e, 0x4b},
+	{0x4767, 0x0f},
+	{0x4750, 0x14},
+	{0x4540, 0x00},
+	{0x47b4, 0x14},
+	{0x4713, 0x30},
+	{0x478b, 0x10},
+	{0x478f, 0x10},
+	{0x4793, 0x10},
+	{0x4797, 0x0e},
+	{0x479b, 0x0e},
+
+	/* Frame Bank Register Group "A" */
+	{0x0162, 0x0d},	/* Line_Length_A */
+	{0x0163, 0x78},
+	{0x0170, 0x01}, /* X_ODD_INC_A */
+	{0x0171, 0x01}, /* Y_ODD_INC_A */
+
+	/* Output setup registers */
+	{0x0114, 0x01},	/* CSI 2-Lane Mode */
+	{0x0128, 0x00},	/* DPHY Auto Mode */
+	{0x012a, 0x18},	/* EXCK_Freq */
 	{0x012b, 0x00},
+};
+
+/*
+ * Register sets lifted off the i2C interface from the Raspberry Pi firmware
+ * driver.
+ * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
+ */
+static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x0164, 0x00},
 	{0x0165, 0x00},
 	{0x0166, 0x0c},
@@ -174,53 +212,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
 	{0x016d, 0xd0},
 	{0x016e, 0x09},
 	{0x016f, 0xa0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
-	{0x0174, 0x00},
+	{0x0174, 0x00},	/* No-Binning */
 	{0x0175, 0x00},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x0c},
 	{0x0625, 0xd0},
 	{0x0626, 0x09},
 	{0x0627, 0xa0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 };
 
 static const struct imx219_reg mode_1920_1080_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 	{0x0164, 0x02},
 	{0x0165, 0xa8},
 	{0x0166, 0x0a},
@@ -233,49 +233,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
 	{0x016d, 0x80},
 	{0x016e, 0x04},
 	{0x016f, 0x38},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
-	{0x0174, 0x00},
+	{0x0174, 0x00},	/* No-Binning */
 	{0x0175, 0x00},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x07},
 	{0x0625, 0x80},
 	{0x0626, 0x04},
 	{0x0627, 0x38},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
 };
 
 static const struct imx219_reg mode_1640_1232_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x0c},
-	{0x30eb, 0x05},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
 	{0x0164, 0x00},
 	{0x0165, 0x00},
 	{0x0166, 0x0c},
@@ -288,53 +254,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
 	{0x016d, 0x68},
 	{0x016e, 0x04},
 	{0x016f, 0xd0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
-	{0x0174, 0x01},
+	{0x0174, 0x01},	/* x2-Binning */
 	{0x0175, 0x01},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x06},
 	{0x0625, 0x68},
 	{0x0626, 0x04},
 	{0x0627, 0xd0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 };
 
 static const struct imx219_reg mode_640_480_regs[] = {
-	{0x0100, 0x00},
-	{0x30eb, 0x05},
-	{0x30eb, 0x0c},
-	{0x300a, 0xff},
-	{0x300b, 0xff},
-	{0x30eb, 0x05},
-	{0x30eb, 0x09},
-	{0x0114, 0x01},
-	{0x0128, 0x00},
-	{0x012a, 0x18},
-	{0x012b, 0x00},
-	{0x0162, 0x0d},
-	{0x0163, 0x78},
 	{0x0164, 0x03},
 	{0x0165, 0xe8},
 	{0x0166, 0x08},
@@ -347,35 +275,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
 	{0x016d, 0x80},
 	{0x016e, 0x01},
 	{0x016f, 0xe0},
-	{0x0170, 0x01},
-	{0x0171, 0x01},
-	{0x0174, 0x03},
+	{0x0174, 0x03},	/* x2-analog binning */
 	{0x0175, 0x03},
-	{0x0301, 0x05},
-	{0x0303, 0x01},
-	{0x0304, 0x03},
-	{0x0305, 0x03},
-	{0x0306, 0x00},
-	{0x0307, 0x39},
-	{0x030b, 0x01},
-	{0x030c, 0x00},
-	{0x030d, 0x72},
 	{0x0624, 0x06},
 	{0x0625, 0x68},
 	{0x0626, 0x04},
 	{0x0627, 0xd0},
-	{0x455e, 0x00},
-	{0x471e, 0x4b},
-	{0x4767, 0x0f},
-	{0x4750, 0x14},
-	{0x4540, 0x00},
-	{0x47b4, 0x14},
-	{0x4713, 0x30},
-	{0x478b, 0x10},
-	{0x478f, 0x10},
-	{0x4793, 0x10},
-	{0x4797, 0x0e},
-	{0x479b, 0x0e},
 };
 
 static const struct imx219_reg raw8_framefmt_regs[] = {
@@ -1041,6 +946,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
 	if (ret < 0)
 		return ret;
 
+	/* Send all registers that are common to all modes */
+	ret = imx219_write_regs(imx219, imx219_common_regs, ARRAY_SIZE(imx219_common_regs));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
+		goto err_rpm_put;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx219->mode->reg_list;
 	ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
-- 
2.34.1

