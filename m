Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF6D6EEF78
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjDZHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjDZHlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:41:21 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94413598
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:41:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B0D445FD6F;
        Wed, 26 Apr 2023 10:41:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682494877;
        bh=GCpo3UaP2HYQhMMQr3cMgybV/FrB3rhVTLdLNVE21/Q=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Le71LnCQCn+WC96q1gYCy+28e4+c9Bt0j1+VHuDHDCMDV6+UzzfXyPAWP+HSfJULF
         3uEptYV77aXx/0uzdBIjK8IJEcOjH649/1L0a50N7tfeDStpaBrzLKASjgBQBC/DyV
         RUU9hw+bXfG2v2Iv62uEW9h6yoB8V7UK+44ytIWqUlNjUGiBcbUGEzKqDyLJ3HmFdX
         nJFeHq1TYAnAs5Hgwi1lA30X3/AMsrjp0txf9Oqja8wpqrkuMM3iuj6398ecvjvGr6
         ydvDvNzHUD86+Bn+wWrOKQLhGwbWAdNRm0PQClGtAQuV7Ser/8ATsLKcKDtvXxsQQN
         YdylpOYXIsPOw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 10:41:17 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/5] mtd: rawnand: meson: check buffer length
Date:   Wed, 26 Apr 2023 10:36:29 +0300
Message-ID: <20230426073632.3905682-4-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
References: <20230426073632.3905682-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/26 04:45:00 #21166225
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This NAND controller has limited buffer length, so check it before
command execution to avoid length trim. Also check MTD write size on
chip attach.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 0a67d82f23c4..ef0fe88773be 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -113,6 +113,8 @@
 #define NFC_USER_BYTES		2
 #define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
 
+#define NFC_CMD_RAW_LEN		GENMASK(13, 0)
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -304,7 +306,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
-		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
+		cmd = len | scrambler | DMA_DIR(dir);
 		writel(cmd, nfc->reg_base + NFC_REG_CMD);
 		return;
 	}
@@ -556,6 +558,9 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	u32 cmd;
 	u8 *info;
 
+	if (len > NFC_CMD_RAW_LEN)
+		return -EINVAL;
+
 	info = kzalloc(PER_INFO_BYTE, GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -565,7 +570,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		goto out;
 
-	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_N2M | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -584,12 +589,15 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
 	int ret = 0;
 	u32 cmd;
 
+	if (len > NFC_CMD_RAW_LEN)
+		return -EINVAL;
+
 	ret = meson_nfc_dma_buffer_setup(nand, buf, len, NULL,
 					 0, DMA_TO_DEVICE);
 	if (ret)
 		return ret;
 
-	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_M2N | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -1446,6 +1454,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	int nsectors = mtd->writesize / 1024;
+	int raw_writesize;
 	int ret;
 
 	if (!mtd->name) {
@@ -1457,6 +1466,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 			return -ENOMEM;
 	}
 
+	raw_writesize = mtd->writesize + mtd->oobsize;
+	if (raw_writesize > NFC_CMD_RAW_LEN) {
+		dev_err(nfc->dev, "too big write size in raw mode: %d > %ld\n",
+			raw_writesize, NFC_CMD_RAW_LEN);
+		return -EINVAL;
+	}
+
 	if (nand->bbt_options & NAND_BBT_USE_FLASH)
 		nand->bbt_options |= NAND_BBT_NO_OOB;
 
-- 
2.35.0

