Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2714D722F75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjFETQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjFETQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:09 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1CAA7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:16:05 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D666F5FD20;
        Mon,  5 Jun 2023 22:16:02 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685992562;
        bh=G6c6j8iAcdDSpK0GLScKOrdhbGc4x8WhHl8LdEBggUo=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ph1/Z7289OW3MlYDjIPY3ymnd754+Fc+LM4w90GVoZvQt50+TOLtGQQCJhmum0Jtr
         Yw2tCnJGI1BTqEK+c2w8WNipSIchj4D+GB4st9OfZ3jQzseRWAcpxJoV8Zl2rpGBlF
         gnahOoM81pABGHi4HKKNYIhNBovbrN+LeTKq0s6dmi+lVLf5NHsCwXjBABDrxvs5IO
         KsVgogDJPRNz7UmGP+Q7+f+PccfLxpOF0zVd4ZWO3wTPyFzfI5KreTXAg35NqSb8br
         1JwQ7QJGe3KDsjvIwRe8bYsEeAJbTFqxdLK3r1NxmRrSganbZ/fRRvED6Wa6VpZF3r
         EJkoJi5xyvUGg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon,  5 Jun 2023 22:16:00 +0300 (MSK)
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
Subject: [PATCH v1] mtd: rawnand: meson: check buffer length
Date:   Mon, 5 Jun 2023 22:10:46 +0300
Message-ID: <20230605191047.1820016-1-AVKrasnov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/05 13:50:00 #21435193
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mtd/nand/raw/meson_nand.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 074e14225c06..bfb5363cac23 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -108,6 +108,8 @@
 
 #define PER_INFO_BYTE		8
 
+#define NFC_CMD_RAW_LEN	GENMASK(13, 0)
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -280,7 +282,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
-		cmd = (len & GENMASK(13, 0)) | scrambler | DMA_DIR(dir);
+		cmd = len | scrambler | DMA_DIR(dir);
 		writel(cmd, nfc->reg_base + NFC_REG_CMD);
 		return;
 	}
@@ -544,7 +546,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		goto out;
 
-	cmd = NFC_CMD_N2M | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_N2M | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -568,7 +570,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
 	if (ret)
 		return ret;
 
-	cmd = NFC_CMD_M2N | (len & GENMASK(13, 0));
+	cmd = NFC_CMD_M2N | len;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
@@ -936,6 +938,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_DATA_IN_INSTR:
+			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
+				return -EINVAL;
+
 			buf = meson_nand_op_get_dma_safe_input_buf(instr);
 			if (!buf)
 				return -ENOMEM;
@@ -944,6 +949,9 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			break;
 
 		case NAND_OP_DATA_OUT_INSTR:
+			if (instr->ctx.data.len > NFC_CMD_RAW_LEN)
+				return -EINVAL;
+
 			buf = meson_nand_op_get_dma_safe_output_buf(instr);
 			if (!buf)
 				return -ENOMEM;
@@ -1181,6 +1189,7 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	int nsectors = mtd->writesize / 1024;
+	int raw_writesize;
 	int ret;
 
 	if (!mtd->name) {
@@ -1192,6 +1201,13 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
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

