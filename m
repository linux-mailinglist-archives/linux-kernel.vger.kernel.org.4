Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F49723F46
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjFFKWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjFFKWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:22:21 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7310F1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:22:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id CF6835FD1B;
        Tue,  6 Jun 2023 13:22:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686046927;
        bh=DTBB8jOO77vAsxmiB/i7I8AL4Y5HWSjjJbkLXHcxMxY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=IWy/fUlAKarZIURZ2S8lVHBjPYVcItMkVqJahSnQb8MZcKSTbqACk4UPLrXx7FLzK
         J0p9mFLwW2hBU0f6GZtZVCdFtjHg828gCqRRoirrS+t0QYzxSRpci5x7JCfVKjuzHA
         So1aAl8dxz3LeFi1zf+uG1htVtaH//OLvWj0Rey8YY10jyeuZbVawWeShdRFEmEWMp
         X8enaFbnsAvtOSwXflXLqPlqEL22+y5reYcffxPIU0JcXYOJQkN/cxviSV5sW97+ou
         3ItNT1+TMqwFXNxHvA8050B5bWXpIR5LKaBatPFLF4RRR7kkDHuBUmecooP4/OxRyh
         s/WEctiWRU/ow==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue,  6 Jun 2023 13:22:06 +0300 (MSK)
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
Subject: [PATCH v2] mtd: rawnand: meson: check buffer length
Date:   Tue, 6 Jun 2023 13:16:43 +0300
Message-ID: <20230606101644.3297859-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/06 07:40:00 #21442908
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

Meson NAND controller has limited buffer length, so check it before
command execution to avoid length trim. Also check MTD write size on
chip attach.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 47 +++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 23a73268421b..db6b18753071 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -111,6 +111,8 @@
 
 #define PER_INFO_BYTE		8
 
+#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
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
@@ -1007,6 +1009,31 @@ meson_nand_op_put_dma_safe_output_buf(const struct nand_op_instr *instr,
 		kfree(buf);
 }
 
+static int meson_nfc_check_op(struct nand_chip *chip,
+			      const struct nand_operation *op)
+{
+	int op_id;
+
+	for (op_id = 0; op_id < op->ninstrs; op_id++) {
+		const struct nand_op_instr *instr;
+
+		instr = &op->instrs[op_id];
+
+		switch (instr->type) {
+		case NAND_OP_DATA_IN_INSTR:
+		case NAND_OP_DATA_OUT_INSTR:
+			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
+				return -ENOTSUPP;
+
+			break;
+		default:
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int meson_nfc_exec_op(struct nand_chip *nand,
 			     const struct nand_operation *op, bool check_only)
 {
@@ -1015,10 +1042,12 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 	const struct nand_op_instr *instr = NULL;
 	void *buf;
 	u32 op_id, delay_idle, cmd;
+	int err;
 	int i;
 
-	if (check_only)
-		return 0;
+	err = meson_nfc_check_op(nand, op);
+	if (err || check_only)
+		return err;
 
 	meson_nfc_select_chip(nand, op->cs);
 	for (op_id = 0; op_id < op->ninstrs; op_id++) {
@@ -1293,6 +1322,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	int nsectors = mtd->writesize / 1024;
+	int raw_writesize;
 	int ret;
 
 	if (!mtd->name) {
@@ -1304,6 +1334,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
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

