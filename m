Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF97719327
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjFAGYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjFAGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:23:55 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335F123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:23:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 72BA35FD72;
        Thu,  1 Jun 2023 09:23:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1685600632;
        bh=RbeJZbPNkWc/tUGhF37aQ2jFIYQedtb7n/HATu1dFBI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=DYOOKSL3iwT1sDNakbtCoAF7EQ6viEyK0vOSWBs24C1yd8pQB9P3Iz391+Q2IEKxN
         VJGLniY6KfbnWQ46A2ViYa/Um94b/4ddtcohTyZ8KZFOhpxN+QOBBbuS/pBrKQw9MC
         FQB12l1ajCc0sU5s/bVnWJUF+79pGJPdBfIVu+7UySj3P+Yg5a2xkXhJk8rGw734ZZ
         TYz949gVlDlMslkrZmuFTC9SXemy0LHlMkZPrfYBLEhrosWA1zDTqLo5lsTQ0RWSPZ
         QIALMPHovO9KbQxstX7ZaDeNlmpOa8hKCt/ooAXJCFHpt6zTA+zJdi+hyOkhzw0lT3
         s79+fo2afv+3w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  1 Jun 2023 09:23:52 +0300 (MSK)
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
Subject: [RFC PATCH v5 4/6] mtd: rawnand: meson: use macro for OOB area
Date:   Thu, 1 Jun 2023 09:18:47 +0300
Message-ID: <20230601061850.3907800-5-AVKrasnov@sberdevices.ru>
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

This replaces constants and same patterns for OOB handling with special
macroses.

Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
---
 drivers/mtd/nand/raw/meson_nand.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index e42c28be02f3..23a73268421b 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -108,6 +108,9 @@
 
 #define PER_INFO_BYTE		8
 
+#define NFC_USER_BYTES		2
+#define NFC_OOB_PER_ECC(nand)	((nand)->ecc.bytes + NFC_USER_BYTES)
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -339,7 +342,7 @@ static u8 *meson_nfc_oob_ptr(struct nand_chip *nand, int i)
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	int len;
 
-	len = nand->ecc.size * (i + 1) + (nand->ecc.bytes + 2) * i;
+	len = nand->ecc.size * (i + 1) + NFC_OOB_PER_ECC(nand) * i;
 
 	return meson_chip->data_buf + len;
 }
@@ -350,7 +353,7 @@ static u8 *meson_nfc_data_ptr(struct nand_chip *nand, int i)
 	int len, temp;
 
 	temp = nand->ecc.size + nand->ecc.bytes;
-	len = (temp + 2) * i;
+	len = (temp + NFC_USER_BYTES) * i;
 
 	return meson_chip->data_buf + len;
 }
@@ -364,7 +367,7 @@ static void meson_nfc_get_data_oob(struct nand_chip *nand,
 	u8 *dsrc, *osrc;
 	u8 *oobtail;
 
-	oob_len = nand->ecc.bytes + 2;
+	oob_len = NFC_OOB_PER_ECC(nand);
 	for (i = 0; i < nand->ecc.steps; i++) {
 		if (buf) {
 			dsrc = meson_nfc_data_ptr(nand, i);
@@ -393,7 +396,7 @@ static void meson_nfc_set_data_oob(struct nand_chip *nand,
 	u8 *dsrc, *osrc;
 	u8 *oobtail;
 
-	oob_len = nand->ecc.bytes + 2;
+	oob_len = NFC_OOB_PER_ECC(nand);
 	for (i = 0; i < nand->ecc.steps; i++) {
 		if (buf) {
 			dsrc = meson_nfc_data_ptr(nand, i);
@@ -452,7 +455,7 @@ static void meson_nfc_set_user_byte(struct nand_chip *nand, u8 *oob_buf)
 	__le64 *info;
 	int i, count;
 
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
+	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += NFC_OOB_PER_ECC(nand)) {
 		info = &meson_chip->info_buf[i];
 		*info |= oob_buf[count];
 		*info |= oob_buf[count + 1] << 8;
@@ -465,7 +468,7 @@ static void meson_nfc_get_user_byte(struct nand_chip *nand, u8 *oob_buf)
 	__le64 *info;
 	int i, count;
 
-	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += (nand->ecc.bytes + 2)) {
+	for (i = 0, count = 0; i < nand->ecc.steps; i++, count += NFC_OOB_PER_ECC(nand)) {
 		info = &meson_chip->info_buf[i];
 		oob_buf[count] = *info;
 		oob_buf[count + 1] = *info >> 8;
@@ -661,7 +664,7 @@ static u32 meson_nfc_oob_free_bytes(struct nand_chip *nand)
 {
 	struct mtd_info *mtd = nand_to_mtd(nand);
 
-	return mtd->oobsize - nand->ecc.steps * (nand->ecc.bytes + 2);
+	return mtd->oobsize - nand->ecc.steps * NFC_OOB_PER_ECC(nand);
 }
 
 static int meson_nfc_write_oob(struct nand_chip *nand, int page)
@@ -712,11 +715,11 @@ static int meson_nfc_read_oob(struct nand_chip *nand, int page)
 	/* Read ECC codes and user bytes. */
 	for (i = 0; i < nand->ecc.steps; i++) {
 		u32 ecc_offs = nand->ecc.size * (i + 1) +
-			       (nand->ecc.bytes + 2) * i;
+			       NFC_OOB_PER_ECC(nand) * i;
 
 		ret = nand_change_read_column_op(nand, ecc_offs,
-						 oob_buf + i * (nand->ecc.bytes + 2),
-						 (nand->ecc.bytes + 2), false);
+						 oob_buf + i * NFC_OOB_PER_ECC(nand),
+						 NFC_OOB_PER_ECC(nand), false);
 		if (ret)
 			return ret;
 	}
@@ -918,12 +921,14 @@ static int meson_nfc_read_page_hwecc(struct nand_chip *nand, u8 *buf,
 
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
@@ -1073,7 +1078,7 @@ static int meson_ooblayout_ecc(struct mtd_info *mtd, int section,
 	if (section >= nand->ecc.steps)
 		return -ERANGE;
 
-	oobregion->offset =  2 + (section * (2 + nand->ecc.bytes));
+	oobregion->offset = NFC_USER_BYTES + (section * NFC_OOB_PER_ECC(nand));
 	oobregion->length = nand->ecc.bytes;
 
 	return 0;
@@ -1091,7 +1096,7 @@ static int meson_ooblayout_free(struct mtd_info *mtd, int section,
 	/* Split rest of OOB area (not covered by ECC engine) per each
 	 * ECC section. This will be OOB data available to user.
 	 */
-	oobregion->offset = (section + nand->ecc.steps) * (2 + nand->ecc.bytes);
+	oobregion->offset = (section + nand->ecc.steps) * NFC_OOB_PER_ECC(nand);
 	oobregion->length = oob_bytes / nand->ecc.steps;
 
 	return 0;
-- 
2.35.0

