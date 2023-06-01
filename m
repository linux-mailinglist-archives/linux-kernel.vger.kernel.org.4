Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59373719328
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjFAGYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjFAGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:23:56 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BF89D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:23:55 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id B6D9A5FD73;
        Thu,  1 Jun 2023 09:23:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685600633;
        bh=kSvrNV01pYKxwurCvddI8AqxMVYMKQLY/eHlqyiGjSc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=fApJxuo1I+DhpC4BGUSekoYjDmIMVAAy0hnnT/WsPI5i7lcRfV1pmAe0GaaiLcxef
         EU83Ar7jcpkqXBZ3bqxtWN2Hu8rGnGnlj3tzkZDkaEIZ7TLEM81GRm5Qa1F2GUJ2gI
         ifkpXX4PmPrMdxpganpJ2dDbnkAmym/c46VakgtVUDSsdIJzoPFsfWyTbejOCagyF4
         Mkwi5sl9l4ER2dEvFT2Wy6JJpCiY9N/hKnE2+UjdpJu7UpCEAqPr1bOGVVKhU+a3Rx
         vIWiS54iPrTSj/pI5uQDPP8A/rpVRhH0LruM93gFH8nJO+qC5vbXgIXkrSmA94Epih
         RfGtZOkZZhlqQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 09:23:53 +0300 (MSK)
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v5 5/6] mtd: rawnand: meson: check buffer length
Date:   Thu, 1 Jun 2023 09:18:48 +0300
Message-ID: <20230601061850.3907800-6-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
References: <20230601061850.3907800-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/01 03:13:00 #21393813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Changelog v4->v5:
 * Move length checks from functions 'meson_nfc_read/write_buf()' to
   'meson_nfc_exec_op()'.

 drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 23a73268421b..2a91916566f4 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -111,6 +111,8 @@
 #define NFC_USER_BYTES		2
 #define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
 
+#define NFC_CMD_RAW_LEN		GENMASK(13, 0)
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -284,7 +286,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
-		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
+		cmd = len | scrambler | DMA_DIR(dir);
 		writel(cmd, nfc->reg_base + NFC_REG_CMD);
 		return;
 	}
@@ -573,7 +575,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		goto out;
 
-	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_N2M | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -597,7 +599,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		return ret;
 
-	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_M2N | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -1044,6 +1046,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_DATA_IN_INSTR:
+			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
+				return -EINVAL;
+
 			buf = meson_nand_op_get_dma_safe_input_buf(instr);
 			if (!buf)
 				return -ENOMEM;
@@ -1052,6 +1057,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_DATA_OUT_INSTR:
+			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
+				return -EINVAL;
+
 			buf = meson_nand_op_get_dma_safe_output_buf(instr);
 			if (!buf)
 				return -ENOMEM;
@@ -1293,6 +1301,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	int nsectors = mtd->writesize / 1024;
+	int raw_writesize;
 	int ret;
 
 	if (!mtd->name) {
@@ -1304,6 +1313,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
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

