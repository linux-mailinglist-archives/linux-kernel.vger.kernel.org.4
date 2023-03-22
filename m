Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3A6C4F33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCVPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjCVPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:12 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AB64271
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:17:09 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1724C5FD42;
        Wed, 22 Mar 2023 18:17:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679498227;
        bh=PE5BBQKZYaZpy2ceXFudsdtpoaJahbTFeAodv44PEEk=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=mrJC46T6+MrE4S/SZgYyLvjKVrjkajNxRQPo180pmdelR99/Wvwqs0M+8fEqbhIjY
         c/svfsvckzUGKXcVH7apjkPt93n1jUIEYp0Z3G+Mm9kZ4GAT84NWUIZbNghLfCsIFe
         pydG7MrZ1oQGuYkpu5h/k/YoTOuvA905w5U7OwNhspnwJPnPrFcUC9gKq+TRSMz6tQ
         afaDn7wOEv1iwfK0M0f1+OURpXTEtxRYTtTgNbfr+Pw544+8T7y8pEZJ1eg9YbsC7U
         5wleQSK13PFD15NB2LCHGvzo3blbwMQLD90ucDkaO0CWPRu61MOwT0oNJjNy8UQWqG
         GRtz4mO4cW6tQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 22 Mar 2023 18:17:05 +0300 (MSK)
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
Subject: [PATCH v3] mtd: spinand: add support for ESMT F50x1G41LB
Date:   Wed, 22 Mar 2023 18:16:25 +0300
Message-ID: <20230322151625.791131-1-mmkurbanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/22 10:34:00 #20990985
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
The implementation has been tested on the Amlogic A113L SoC based device
connected with ESMT F50L1G41LB spinand flash.

Changes v3 since v2 at [1]:
  - fix OOB layout

Changes v2 since v1 at [2]:
  - drop 0x7f padding from SPINAND_ID.

Links:
  [1] https://lore.kernel.org/lkml/20220413083824.247136-1-gch981213@gmail.com/
  [2] https://lore.kernel.org/lkml/20220413042337.160263-1-gch981213@gmail.com/
---
 drivers/mtd/nand/spi/Makefile |   3 +-
 drivers/mtd/nand/spi/core.c   |   1 +
 drivers/mtd/nand/spi/esmt.c   | 135 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h   |   1 +
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/esmt.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index b520fe634041..c8ab4c9bf0e6 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o ato.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
+spinand-objs := core.o ato.o esmt.o gigadevice.o macronix.o micron.o
+spinand-objs += paragon.o toshiba.o winbond.o xtx.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index dacd9c0e8b20..af3988c870c3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -938,6 +938,7 @@ static const struct nand_ops spinand_ops = {

 static const struct spinand_manufacturer *spinand_manufacturers[] = {
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
index 6d3392a7edc6..2469b8ede770 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -261,6 +261,7 @@ struct spinand_manufacturer {

 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer ato_spinand_manufacturer;
+extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
--
2.40.0

