Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0BE6CD8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjC2Lnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjC2Lnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:43:40 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396B3422E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:43:34 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id DA99F5FD1E;
        Wed, 29 Mar 2023 14:43:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1680090211;
        bh=w/vWujC1+XPSD+C2mUNWQ7JnaRNnxNuI+zCkN445pWA=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Rdul/wsL/UelP9MMB/QTEpG1KwmjxGoHF5j4cXcrqol5vib8N42J7Ggu73f+9X+4G
         3N60wx4yALxiz2TY+hOU0UVPhzI76Gx4eCoK9iBrEayHMWL5M55Er6NsCsL4cBXbUY
         H4iF788/DsBpvRNOz7HLRtpkBXRtf/rVHHFWxH8yx1zBRYM5Yu5jFBmmN5LbB1OrxP
         uabhSOzf+z8Gcp0vLbni6ANNOYjoxnaqph00ATpWLUtL5hoqmz+IPiU8yZLFvziWH5
         uO7MG+Lb3K6gaFtTm3osCnvMUzbNzA1EV3b7N3LJLgFNDCpJ/uLgI2KuGL2kuYAMF8
         XxooZjeiXecpw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 29 Mar 2023 14:43:30 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Chuanhong Guo <gch981213@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Felix Matouschek <felix@matouschek.org>, <kernel@kempniu.pl>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v4] mtd: spinand: add support for ESMT F50x1G41LB
Date:   Wed, 29 Mar 2023 14:42:40 +0300
Message-ID: <20230329114240.378722-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/29 07:09:00 #21026578
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuanhong Guo <gch981213@gmail.com>

This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
It seems that ESMT likes to use random JEDEC ID from other vendors.
Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
JEDEC ID in variable name.

Datasheets:
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 The implementation has been tested on the Amlogic A113L SoC based
 device connected with ESMT F50L1G41LB spinand flash.

 Changes v4 since v3 at [1]:
   - rebase on top of nand/next

 Changes v3 since v2 at [2]:
   - fix OOB layout

 Changes v2 since v1 at [3]:
   - drop 0x7f padding from SPINAND_ID.

 Links:
   [1] https://lore.kernel.org/lkml/20230322151625.791131-1-mmkurbanov@sberdevices.ru/
   [2] https://lore.kernel.org/lkml/20220413083824.247136-1-gch981213@gmail.com/
   [3] https://lore.kernel.org/lkml/20220413042337.160263-1-gch981213@gmail.com/

 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/esmt.c   | 135 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 4ec973b8b6bf..cd8b66bf7740 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o alliancememory.o ato.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs := core.o alliancememory.o ato.o esmt.o gigadevice.o macronix.o
+spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 638391f77d8c..393ff37f0d23 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -939,6 +939,7 @@ static const struct nand_ops spinand_ops = {
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&alliancememory_spinand_manufacturer,
 	&ato_spinand_manufacturer,
+	&esmt_c8_spinand_manufacturer,
 	&gigadevice_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
new file mode 100644
index 000000000000..1a3ffb982335
--- /dev/null
+++ b/drivers/mtd/nand/spi/esmt.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author:
+ *	Chuanhong Guo <gch981213@gmail.com> - the main driver logic
+ *	Martin Kurbanov <mmkurbanov@sberdevices.ru> - OOB layout
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+/* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
+#define SPINAND_MFR_ESMT_C8			0xc8
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
+			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+/*
+ * OOB spare area map (64 bytes)
+ *
+ * Bad Block Markers
+ * filled by HW and kernel                 Reserved
+ *   |                 +-----------------------+-----------------------+
+ *   |                 |                       |                       |
+ *   |                 |    OOB free data Area |non ECC protected      |
+ *   |   +-------------|-----+-----------------|-----+-----------------|-----+
+ *   |   |             |     |                 |     |                 |     |
+ * +-|---|----------+--|-----|--------------+--|-----|--------------+--|-----|--------------+
+ * | |   | section0 |  |     |    section1  |  |     |    section2  |  |     |    section3  |
+ * +-v-+-v-+---+----+--v--+--v--+-----+-----+--v--+--v--+-----+-----+--v--+--v--+-----+-----+
+ * |   |   |   |    |     |     |     |     |     |     |     |     |     |     |     |     |
+ * |0:1|2:3|4:7|8:15|16:17|18:19|20:23|24:31|32:33|34:35|36:39|40:47|48:49|50:51|52:55|56:63|
+ * |   |   |   |    |     |     |     |     |     |     |     |     |     |     |     |     |
+ * +---+---+-^-+--^-+-----+-----+--^--+--^--+-----+-----+--^--+--^--+-----+-----+--^--+--^--+
+ *           |    |                |     |                 |     |                 |     |
+ *           |    +----------------|-----+-----------------|-----+-----------------|-----+
+ *           |             ECC Area|(Main + Spare) - filled|by ESMT NAND HW        |
+ *           |                     |                       |                       |
+ *           +---------------------+-----------------------+-----------------------+
+ *                         OOB ECC protected Area - not used due to
+ *                         partial programming from some filesystems
+ *                             (like JFFS2 with cleanmarkers)
+ */
+
+#define ESMT_OOB_SECTION_COUNT			4
+#define ESMT_OOB_SECTION_SIZE(nand) \
+	(nanddev_per_page_oobsize(nand) / ESMT_OOB_SECTION_COUNT)
+#define ESMT_OOB_FREE_SIZE(nand) \
+	(ESMT_OOB_SECTION_SIZE(nand) / 2)
+#define ESMT_OOB_ECC_SIZE(nand) \
+	(ESMT_OOB_SECTION_SIZE(nand) - ESMT_OOB_FREE_SIZE(nand))
+#define ESMT_OOB_BBM_SIZE			2
+
+static int f50l1g41lb_ooblayout_ecc(struct mtd_info *mtd, int section,
+				    struct mtd_oob_region *region)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+
+	if (section >= ESMT_OOB_SECTION_COUNT)
+		return -ERANGE;
+
+	region->offset = section * ESMT_OOB_SECTION_SIZE(nand) +
+			 ESMT_OOB_FREE_SIZE(nand);
+	region->length = ESMT_OOB_ECC_SIZE(nand);
+
+	return 0;
+}
+
+static int f50l1g41lb_ooblayout_free(struct mtd_info *mtd, int section,
+				     struct mtd_oob_region *region)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+
+	if (section >= ESMT_OOB_SECTION_COUNT)
+		return -ERANGE;
+
+	/*
+	 * Reserve space for bad blocks markers (section0) and
+	 * reserved bytes (sections 1-3)
+	 */
+	region->offset = section * ESMT_OOB_SECTION_SIZE(nand) + 2;
+
+	/* Use only 2 non-protected ECC bytes per each OOB section */
+	region->length = 2;
+
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
+	.ecc = f50l1g41lb_ooblayout_ecc,
+	.free = f50l1g41lb_ooblayout_free,
+};
+
+static const struct spinand_info esmt_c8_spinand_table[] = {
+	SPINAND_INFO("F50L1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+	SPINAND_INFO("F50D1G41LB",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
+};
+
+static const struct spinand_manufacturer_ops esmt_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer esmt_c8_spinand_manufacturer = {
+	.id = SPINAND_MFR_ESMT_C8,
+	.name = "ESMT",
+	.chips = esmt_c8_spinand_table,
+	.nchips = ARRAY_SIZE(esmt_c8_spinand_table),
+	.ops = &esmt_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 01be9f0f008a..3e285c09d16d 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -262,6 +262,7 @@ struct spinand_manufacturer {
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer alliancememory_spinand_manufacturer;
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
--
2.40.0

