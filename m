Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54A719326
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjFAGYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFAGXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:23:54 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A2711F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:23:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 0C4EF5FD71;
        Thu,  1 Jun 2023 09:23:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685600631;
        bh=7eTR50v34sY25ZJ8i04tdkgYJSBwBxdc7ZcDECCVA3w=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=UBazfj3D0Atm0e+kKGESZT2K03zy4ZSpZ+7qozsJSSVFNE8wXzWRaNHHx81vYj1d7
         M3ZV9Z/AEz5z78IWv30tiw8bZAMO2H5uMwAwX3P39FvDNUM9irMcvruP2S9zUuyyH8
         jwkOF+Si2vdAPE174nByviokBXNvY2uAK3bcZy9ad7JoaugLEUb8zdYYK1PEgkoHUa
         D1hmrj/Jhvn1d9L0ADZ25Vw/OmAHudxDeN/dnN17qaVc13y16WiADrRumH5a9yuCLp
         fYa/5NDEd8CNqOhU5t2ZcPNNoMt490JgF9rD4f8iCNrsLBvGl5rTzqLVHudjtoPZGH
         5KLCOtaybk8Kg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 09:23:51 +0300 (MSK)
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
Subject: [RFC PATCH v5 3/6] mtd: rawnand: meson: only expose unprotected user OOB bytes
Date:   Thu, 1 Jun 2023 09:18:46 +0300
Message-ID: <20230601061850.3907800-4-AVKrasnov@sberdevices.ru>
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

This moves free bytes of OOB to non-protected ECC area. It is needed to
make JFFS2 works correctly with this NAND controller. Problem fires when
JFFS2 driver writes cleanmarker to some page and later it tries to write
to this page - write will be done successfully, but after that such page
becomes unreadable due to invalid ECC codes. This happens because second
write needs to update ECC codes, but it is impossible to do it correctly
without block erase. So idea of this patch is to use the unprotected OOB
area to store the cleanmarkers, so that they can be written by the
filesystem without caring much about the page being empty or not: the
ECC codes will not be written anyway.

JFFS2 is only useful on tiny NAND devices, where UBI does not fit, which
are usually true SLC flashes, with the capability of writing a page with
empty (0xFF) data, and still be able to write actual data to it later in
a second write.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 Changelog v4->v5:
 * Drop cosmetic changes from this patch.
 * Do not ignore ECC protected user bytes provided by hw. Even these
   bytes are out of user area of OOB, its values are still read from
   the provided OOB buffer and written by hardware. Same behaviour is
   preserved for read access - such bytes are read from DMA buffer and
   placed to OOB buffer.
 * OOB read and write become more lightweight because I removed heavy
   READ0 and PAGEPROG command from it (both commands are still sent
   when OOB access is performed using OOB callbacks). In case of page
   read/write OOB data is handled in the internal SRAM of the controller.
 * Commit message updated.
 * Temporary buffer for OOB read/write is removed. Seems everything
   works correctly without it.

 drivers/mtd/nand/raw/meson_nand.c | 134 ++++++++++++++++++++++++++----
 1 file changed, 117 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 82a629025adc..e42c28be02f3 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -358,8 +358,11 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
 static void meson_nfc_get_data_oob(struct nand_chip *nand,
 				   u8 *buf, u8 *oobbuf)
 {
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	int i, oob_len = 0;
 	u8 *dsrc, *osrc;
+	u8 *oobtail;
 
 	oob_len = nand->ecc.bytes + 2;
 	for (i = 0; i < nand->ecc.steps; i++) {
@@ -368,17 +371,27 @@ static void meson_nfc_get_data_oob(struct nand_chip *nand,
 			memcpy(buf, dsrc, nand->ecc.size);
 			buf += nand->ecc.size;
 		}
+
 		osrc = meson_nfc_oob_ptr(nand, i);
 		memcpy(oobbuf, osrc, oob_len);
 		oobbuf += oob_len;
 	}
+
+	oobtail = meson_chip->data_buf + nand->ecc.steps *
+		  (nand->ecc.size + oob_len);
+
+	/* 'oobbuf' points to the start of user area. */
+	memcpy(oobbuf, oobtail, mtd->oobsize - nand->ecc.steps * oob_len);
 }
 
 static void meson_nfc_set_data_oob(struct nand_chip *nand,
 				   const u8 *buf, u8 *oobbuf)
 {
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	int i, oob_len = 0;
 	u8 *dsrc, *osrc;
+	u8 *oobtail;
 
 	oob_len = nand->ecc.bytes + 2;
 	for (i = 0; i < nand->ecc.steps; i++) {
@@ -391,6 +404,12 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 		memcpy(osrc, oobbuf, oob_len);
 		oobbuf += oob_len;
 	}
+
+	oobtail = meson_chip->data_buf + nand->ecc.steps *
+		  (nand->ecc.size + oob_len);
+
+	/* 'oobbuf' points to the start of user area. */
+	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
 }
 
 static int meson_nfc_queue_rb(struct nand_chip *nand, int timeout_ms)
@@ -433,7 +452,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
 	__le64 *info;
 	int i, count;
 
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
+	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
 		info = &meson_chip->info_buf[i];
 		*info |= oob_buf[count];
 		*info |= oob_buf[count + 1] << 8;
@@ -446,7 +465,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
 	__le64 *info;
 	int i, count;
 
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
+	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
 		info = &meson_chip->info_buf[i];
 		oob_buf[count] = *info;
 		oob_buf[count + 1] = *info >> 8;
@@ -638,6 +657,84 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 	return 0;
 }
 
+static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+
+	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);
+}
+
+static int meson_nfc_write_oob(struct nand_chip *nand, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	u32 page_size = mtd->writesize + mtd->oobsize;
+	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
+	u8 *oob_buf;
+	int ret;
+
+	if (!oob_bytes)
+		return 0;
+
+	/* Called as OOB write helper, will send NAND_CMD_PAGEPROG. */
+	if (page != -1) {
+		ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
+	oob_buf = nand->oob_poi;
+
+	ret = nand_change_write_column_op(nand, page_size - oob_bytes,
+					  oob_buf + (mtd->oobsize - oob_bytes),
+					  oob_bytes, false);
+	if (ret)
+		return ret;
+
+	return (page != -1) ? nand_prog_page_end_op(nand) : 0;
+}
+
+static int meson_nfc_read_oob(struct nand_chip *nand, int page)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	u8 *oob_buf = nand->oob_poi;
+	u32 oob_bytes;
+	u32 page_size;
+	int ret;
+	int i;
+
+	/* Called as OOB read helper, send NAND_CMD_READ0. */
+	if (page != -1) {
+		ret = nand_read_page_op(nand, page, 0, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
+	/* Read ECC codes and user bytes. */
+	for (i = 0; i < nand->ecc.steps; i++) {
+		u32 ecc_offs = nand->ecc.size * (i + 1) +
+			       (nand->ecc.bytes + 2) * i;
+
+		ret = nand_change_read_column_op(nand, ecc_offs,
+						 oob_buf + i * (nand->ecc.bytes + 2),
+						 (nand->ecc.bytes + 2), false);
+		if (ret)
+			return ret;
+	}
+
+	oob_bytes = meson_nfc_oob_free_bytes(nand);
+
+	if (!oob_bytes)
+		return 0;
+
+	page_size = mtd->writesize + mtd->oobsize;
+
+	ret = nand_change_read_column_op(nand, page_size - oob_bytes,
+					 oob_buf + (mtd->oobsize - oob_bytes),
+					 oob_bytes, false);
+
+	return ret;
+}
+
 static int meson_nfc_write_page_sub(struct nand_chip *nand,
 				    int page, int raw)
 {
@@ -674,6 +771,12 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 				     NFC_CMD_SCRAMBLER_DISABLE);
 	}
 
+	if (!raw) {
+		ret = meson_nfc_write_oob(nand, -1);
+		if (ret)
+			return ret;
+	}
+
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
 	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max));
@@ -834,17 +937,10 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 		memcpy(buf, meson_chip->data_buf, mtd->writesize);
 	}
 
-	return bitflips;
-}
-
-static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
-{
-	return meson_nfc_read_page_raw(nand, NULL, 1, page);
-}
+	if (oob_required && ret)
+		meson_nfc_read_oob(nand, -1);
 
-static int meson_nfc_read_oob(struct nand_chip *nand, int page)
-{
-	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
+	return bitflips;
 }
 
 static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
@@ -987,12 +1083,16 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
 				struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
+	u32 oob_bytes = meson_nfc_oob_free_bytes(nand);
 
 	if (section >= nand->ecc.steps)
 		return -ERANGE;
 
-	oobregion->offset = section * (2 + nand->ecc.bytes);
-	oobregion->length = 2;
+	/* Split rest of OOB area (not covered by ECC engine) per each
+	 * ECC section. This will be OOB data available to user.
+	 */
+	oobregion->offset = (section + nand->ecc.steps) * (2 + nand->ecc.bytes);
+	oobregion->length = oob_bytes / nand->ecc.steps;
 
 	return 0;
 }
@@ -1220,12 +1320,12 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	nand->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
 	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
 	nand->ecc.write_page = meson_nfc_write_page_hwecc;
-	nand->ecc.write_oob_raw = nand_write_oob_std;
-	nand->ecc.write_oob = nand_write_oob_std;
 
+	nand->ecc.write_oob_raw = meson_nfc_write_oob;
+	nand->ecc.write_oob = meson_nfc_write_oob;
 	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
 	nand->ecc.read_page = meson_nfc_read_page_hwecc;
-	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
+	nand->ecc.read_oob_raw = meson_nfc_read_oob;
 	nand->ecc.read_oob = meson_nfc_read_oob;
 
 	if (nand->options & NAND_BUSWIDTH_16) {
-- 
2.35.0

