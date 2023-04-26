Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608976EEF77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbjDZHl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 03:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbjDZHlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:41:20 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6293A84
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 00:41:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 07EF65FD6E;
        Wed, 26 Apr 2023 10:41:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682494875;
        bh=lFkKMy1+KjCHgicUXRzdJGIc8hPDpk710mzG0NQnmJs=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jUL2CLYBxS/WoQs5NM7haOMbV/25yphsVLhxVyEk836/IHqYmOoJQyAiiCPvlPrkT
         9cN2R5MmlBCVcdfPcuiM0QqBeVc5AXP2klavClF23AKXFcIm15zDRRoPRQ2174RbTc
         rgF5nDPVfz7uq8/VIQyd5MK5cLm5yUOckzJWa4L7bu4yRlxpl7ZXTjBWP2FoW34xQO
         6hLDIf8AwMwbM05q9M0WwnkSdt15u7kl2+FM6Vrz63EtgRde0XfEXpha0bL24CKqhr
         RzMI4wWVE639H530S12EJhMvWNJCAH68fr2gtlssuWoi3Z/j7qXidQuyfMy+bw8W6R
         xnFYCvXtRPblw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 26 Apr 2023 10:41:14 +0300 (MSK)
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
Subject: [PATCH v2 2/5] mtd: rawnand: meson: move OOB to non-protected ECC area
Date:   Wed, 26 Apr 2023 10:36:28 +0300
Message-ID: <20230426073632.3905682-3-AVKrasnov@sberdevices.ru>
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

This changes OOB layout by moving it to non-protected ECC area. It fixes
conflict between accesses to OOB and data, because each of them needs
ECC codes, thus making another access to fail. For example when OOB is
written with ECC codes, next write to this page won't update ECC codes
correctly. Else, when OOB is written without ECC, next read of this page
in ECC mode will fail, because ECC engine will miss ECC codes for OOB
which is under ECC.

Also this patch changes OOB read size - whole OOB area will be read in
both ECC and raw modes.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 260 +++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index e828ce3809a9..0a67d82f23c4 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -110,6 +110,9 @@
 
 #define PER_INFO_BYTE		8
 
+#define NFC_USER_BYTES		2
+#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -124,6 +127,7 @@ struct meson_nfc_nand_chip {
 	u8 *data_buf;
 	__le64 *info_buf;
 	u32 nsels;
+	u8 *oob_buf;
 	u8 sels[];
 };
 
@@ -344,7 +348,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, int i)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	int len;
 
-	len = nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
+	len = nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i;
 
 	return meson_chip->data_buf + len;
 }
@@ -355,7 +359,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
 	int len, temp;
 
 	temp = nand->ecc.size + nand->ecc.bytes;
-	len = (temp + 2) * i;
+	len = (temp + NFC_USER_BYTES) * i;
 
 	return meson_chip->data_buf + len;
 }
@@ -363,29 +367,47 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
 static void meson_nfc_get_data_oob(struct nand_chip *nand,
 				   u8 *buf, u8 *oobbuf)
 {
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+	struct mtd_info *mtd = nand_to_mtd(nand);
 	int i, oob_len = 0;
 	u8 *dsrc, *osrc;
+	u8 *oobtail;
 
-	oob_len = nand->ecc.bytes + 2;
+	oob_len = NFC_OOB_PER_ECC(nand);
 	for (i = 0; i < nand->ecc.steps; i++) {
 		if (buf) {
 			dsrc = meson_nfc_data_ptr(nand, i);
 			memcpy(buf, dsrc, nand->ecc.size);
 			buf += nand->ecc.size;
 		}
-		osrc = meson_nfc_oob_ptr(nand, i);
-		memcpy(oobbuf, osrc, oob_len);
-		oobbuf += oob_len;
+
+		if (oobbuf) {
+			osrc = meson_nfc_oob_ptr(nand, i);
+			memcpy(oobbuf, osrc, oob_len);
+			oobbuf += oob_len;
+		}
 	}
+
+	if (!oobbuf)
+		return;
+
+	oobtail = meson_chip->data_buf + nand->ecc.steps *
+		  (nand->ecc.size + oob_len);
+
+	/* 'oobbuf' if already shifted to the start of unused area. */
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
 
-	oob_len = nand->ecc.bytes + 2;
+	oob_len = NFC_OOB_PER_ECC(nand);
 	for (i = 0; i < nand->ecc.steps; i++) {
 		if (buf) {
 			dsrc = meson_nfc_data_ptr(nand, i);
@@ -396,6 +418,12 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 		memcpy(osrc, oobbuf, oob_len);
 		oobbuf += oob_len;
 	}
+
+	oobtail = meson_chip->data_buf + nand->ecc.steps *
+		  (nand->ecc.size + oob_len);
+
+	/* 'oobbuf' if already shifted to the start of unused area. */
+	memcpy(oobtail, oobbuf, mtd->oobsize - nand->ecc.steps * oob_len);
 }
 
 static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
@@ -430,25 +458,12 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
 {
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	__le64 *info;
-	int i, count;
-
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
-		info = &meson_chip->info_buf[i];
-		*info |= oob_buf[count];
-		*info |= oob_buf[count + 1] << 8;
-	}
-}
-
-static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
-{
-	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
-	__le64 *info;
-	int i, count;
+	int i;
 
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += 2) {
+	for (i = 0; i < nand->ecc.steps; i++) {
 		info = &meson_chip->info_buf[i];
-		oob_buf[count] = *info;
-		oob_buf[count + 1] = *info >> 8;
+		/* Always ignore user bytes programming. */
+		*info |= 0xffff;
 	}
 }
 
@@ -746,18 +761,160 @@ static int meson_nfc_write_page_raw(struct nand_chip *nand, const u8 *buf,
 	return meson_nfc_write_page_sub(nand, page, 1);
 }
 
+static u32 meson_nfc_get_oob_bytes(struct nand_chip *nand)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+
+	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
+}
+
+static int __meson_nfc_write_oob(struct nand_chip *nand, int page, u8 *oob_buf)
+{
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	u32 page_size = mtd->writesize + mtd->oobsize;
+	u32 oob_rest_bytes = meson_nfc_get_oob_bytes(nand);
+	int ret;
+
+	/* After user's bytes and ECC codes are written by hardware,
+	 * we have unused bytes at the end of OOB area. This is actual
+	 * OOB area for the OOB data.
+	 * Example:
+	 * There are two blocks of data, covered with ECC (1KB each),
+	 * each block uses corresponding part of OOB: 2B of user's
+	 * data, and 14B of ECC code. All of this requires 2 x (1KB +
+	 * 2B + 14B) = 2080B. Page is 2112B, so there is unused 32B
+	 * at the end of OOB. This function fills it with provided
+	 * OOB data.
+	 *
+	 * 'oob_buf':
+	 * 00: 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
+	 * 10: 10 11 12 13 14 15 16 17 18 19 1A 1B 1C 1D 1E 1F
+	 * 20: 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F
+	 * 30: 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F
+	 *
+	 * User's bytes will be: [ ff ff ] and [ ff ff ]
+	 *
+	 * OOB values after writing everything:
+	 * 00: ff ff [     ECC code of first 1KB of data     ]
+	 * 10: ff ff [     ECC code of second 1KB of data    ]
+	 * 20: 20 21 22 23 24 25 26 27 28 29 2A 2B 2C 2D 2E 2F
+	 * 30: 30 31 32 33 34 35 36 37 38 39 3A 3B 3C 3D 3E 3F
+	 */
+	if (!oob_rest_bytes)
+		return 0;
+
+	ret = nand_prog_page_begin_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	memcpy(meson_chip->oob_buf, oob_buf + (mtd->oobsize - oob_rest_bytes),
+	       oob_rest_bytes);
+
+	ret = nand_change_write_column_op(nand, page_size - oob_rest_bytes,
+					  meson_chip->oob_buf,
+					  oob_rest_bytes, false);
+	if (ret)
+		return ret;
+
+	return nand_prog_page_end_op(nand);
+}
+
+static int __meson_nfc_read_oob(struct nand_chip *nand, int page,
+				u8 *oob_buf)
+{
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	u32 oob_rest_bytes;
+	u32 page_size;
+	int ret;
+	int i;
+
+	/* Read ECC codes and user bytes. See OOB layout details above
+	 * in '__meson_nfc_write_oob()'.
+	 */
+	for (i = 0; i < nand->ecc.steps; i++) {
+		u32 ecc_offs = nand->ecc.size * (i + 1) +
+			       NFC_OOB_PER_ECC(nand) * i;
+
+		ret = meson_nfc_wait_dev_ready(nand);
+		if (ret)
+			return ret;
+
+		ret = nand_read_page_op(nand, page, 0, NULL, 0);
+		if (ret)
+			return ret;
+
+		ret = meson_nfc_wait_dev_ready(nand);
+		if (ret)
+			return ret;
+
+		/* Use temporary buffer, because 'nand_change_read_column_op()'
+		 * seems work with some alignment, so we can't read data to
+		 * 'oob_buf' directly.
+		 */
+		ret = nand_change_read_column_op(nand, ecc_offs, meson_chip->oob_buf,
+						 NFC_OOB_PER_ECC(nand), false);
+		if (ret)
+			return ret;
+
+		memcpy(oob_buf + i * NFC_OOB_PER_ECC(nand),
+		       meson_chip->oob_buf,
+		       NFC_OOB_PER_ECC(nand));
+	}
+
+	/* Read rest of OOB. */
+	oob_rest_bytes = meson_nfc_get_oob_bytes(nand);
+
+	if (!oob_rest_bytes)
+		return 0;
+
+	ret = meson_nfc_wait_dev_ready(nand);
+	if (ret)
+		return ret;
+
+	ret = nand_read_page_op(nand, page, 0, NULL, 0);
+	if (ret)
+		return ret;
+
+	ret = meson_nfc_wait_dev_ready(nand);
+	if (ret)
+		return ret;
+
+	page_size = mtd->writesize + mtd->oobsize;
+
+	ret = nand_change_read_column_op(nand, page_size - oob_rest_bytes,
+					 meson_chip->oob_buf,
+					 oob_rest_bytes, false);
+
+	if (!ret)
+		memcpy(oob_buf + (mtd->oobsize - oob_rest_bytes),
+		       meson_chip->oob_buf,
+		       oob_rest_bytes);
+
+	return ret;
+}
+
 static int meson_nfc_write_page_hwecc(struct nand_chip *nand,
 				      const u8 *buf, int oob_required, int page)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	u8 *oob_buf = nand->oob_poi;
+	int ret;
 
 	memcpy(meson_chip->data_buf, buf, mtd->writesize);
 	memset(meson_chip->info_buf, 0, nand->ecc.steps * PER_INFO_BYTE);
 	meson_nfc_set_user_byte(nand, oob_buf);
 
-	return meson_nfc_write_page_sub(nand, page, 0);
+	ret = meson_nfc_write_page_sub(nand, page, 0);
+	if (ret)
+		return ret;
+
+	if (oob_required)
+		ret = __meson_nfc_write_oob(nand, page, oob_buf);
+
+	return ret;
 }
 
 static void meson_nfc_check_ecc_pages_valid(struct meson_nfc *nfc,
@@ -857,7 +1014,7 @@ static int meson_nfc_read_page_raw(struct nand_chip *nand, u8 *buf,
 	if (ret)
 		return ret;
 
-	meson_nfc_get_data_oob(nand, buf, oob_buf);
+	meson_nfc_get_data_oob(nand, buf, oob_required ? oob_buf : NULL);
 
 	return 0;
 }
@@ -877,12 +1034,12 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 	if (ret)
 		return ret;
 
-	meson_nfc_get_user_byte(nand, oob_buf);
 	ret = meson_nfc_ecc_correct(nand, &bitflips, &correct_bitmap);
 	if (ret == ECC_CHECK_RETURN_FF) {
 		if (buf)
 			memset(buf, 0xff, mtd->writesize);
 		memset(oob_buf, 0xff, mtd->oobsize);
+		return bitflips;
 	} else if (ret < 0) {
 		if ((nand->options & NAND_NEED_SCRAMBLING) || !buf) {
 			mtd->ecc_stats.failed++;
@@ -894,12 +1051,14 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 
 		for (i = 0; i < nand->ecc.steps ; i++) {
 			u8 *data = buf + i * ecc->size;
-			u8 *oob = nand->oob_poi + i * (ecc->bytes + 2);
+			u8 *oob = nand->oob_poi + i * NFC_OOB_PER_ECC(nand);
 
 			if (correct_bitmap & BIT_ULL(i))
 				continue;
+
 			ret = nand_check_erased_ecc_chunk(data,	ecc->size,
-							  oob, ecc->bytes + 2,
+							  oob,
+							  NFC_OOB_PER_ECC(nand),
 							  NULL, 0,
 							  ecc->strength);
 			if (ret < 0) {
@@ -913,17 +1072,30 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 		memcpy(buf, meson_chip->data_buf, mtd->writesize);
 	}
 
+	if (oob_required)
+		__meson_nfc_read_oob(nand, page, oob_buf);
+
 	return bitflips;
 }
 
 static int meson_nfc_read_oob_raw(struct nand_chip *nand, int page)
 {
-	return meson_nfc_read_page_raw(nand, NULL, 1, page);
+	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
 }
 
 static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 {
-	return meson_nfc_read_page_hwecc(nand, NULL, 1, page);
+	return __meson_nfc_read_oob(nand, page, nand->oob_poi);
+}
+
+static int meson_nfc_write_oob_raw(struct nand_chip *nand, int page)
+{
+	return __meson_nfc_write_oob(nand, page, nand->oob_poi);
+}
+
+static int meson_nfc_write_oob(struct nand_chip *nand, int page)
+{
+	return __meson_nfc_write_oob(nand, page, nand->oob_poi);
 }
 
 static bool meson_nfc_is_buffer_dma_safe(const void *buffer)
@@ -1056,7 +1228,7 @@ static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section >= nand->ecc.steps)
 		return -ERANGE;
 
-	oobregion->offset =  2 + (section * (2 + nand->ecc.bytes));
+	oobregion->offset = NFC_USER_BYTES + section * NFC_OOB_PER_ECC(nand);
 	oobregion->length = nand->ecc.bytes;
 
 	return 0;
@@ -1066,12 +1238,16 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
 				struct mtd_oob_region *oobregion)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
+	u32 oob_rest_bytes = meson_nfc_get_oob_bytes(nand);
 
 	if (section >= nand->ecc.steps)
 		return -ERANGE;
 
-	oobregion->offset = section * (2 + nand->ecc.bytes);
-	oobregion->length = 2;
+	/* Split rest of OOB area (not covered by ECC engine) per each
+	 * ECC section. This will be OOB data available to user.
+	 */
+	oobregion->offset = (section + nand->ecc.steps) * NFC_OOB_PER_ECC(nand);
+	oobregion->length = oob_rest_bytes / nand->ecc.steps;
 
 	return 0;
 }
@@ -1258,6 +1434,9 @@ static int meson_nand_bch_mode(struct nand_chip *nand)
 
 static void meson_nand_detach_chip(struct nand_chip *nand)
 {
+	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
+
+	kfree(meson_chip->oob_buf);
 	meson_nfc_free_buffer(nand);
 }
 
@@ -1299,9 +1478,9 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 	nand->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
 	nand->ecc.write_page_raw = meson_nfc_write_page_raw;
 	nand->ecc.write_page = meson_nfc_write_page_hwecc;
-	nand->ecc.write_oob_raw = nand_write_oob_std;
-	nand->ecc.write_oob = nand_write_oob_std;
 
+	nand->ecc.write_oob_raw = meson_nfc_write_oob_raw;
+	nand->ecc.write_oob = meson_nfc_write_oob;
 	nand->ecc.read_page_raw = meson_nfc_read_page_raw;
 	nand->ecc.read_page = meson_nfc_read_page_hwecc;
 	nand->ecc.read_oob_raw = meson_nfc_read_oob_raw;
@@ -1311,9 +1490,16 @@ static int meson_nand_attach_chip(struct nand_chip *nand)
 		dev_err(nfc->dev, "16bits bus width not supported");
 		return -EINVAL;
 	}
+
+	meson_chip->oob_buf = kmalloc(nand->ecc.bytes, GFP_KERNEL);
+	if (!meson_chip->oob_buf)
+		return -ENOMEM;
+
 	ret = meson_chip_buffer_init(nand);
-	if (ret)
+	if (ret) {
+		kfree(meson_chip->oob_buf);
 		return -ENOMEM;
+	}
 
 	return ret;
 }
-- 
2.35.0

