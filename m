Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104F62A47C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiKOVtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiKOVtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:49:01 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412462FA;
        Tue, 15 Nov 2022 13:48:59 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1ov3nW-0005KN-32; Tue, 15 Nov 2022 22:48:50 +0100
Date:   Tue, 15 Nov 2022 21:47:25 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Golle <daniel@makrotopia.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v5 4/4] mtd: add option to enable scanning for partitions
Message-ID: <88d7c15691af5d956275b5326303d5aeb3ea1d2f.1668548123.git.daniel@makrotopia.org>
References: <cover.1668548123.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1668548123.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
partition parsers on non-NAND mtdblock as well as ubiblock devices
in case it is selected.
Never scan partitions on NAND-backed mtdblock devices, ubiblock
should be used instead.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/Kconfig       | 11 +++++++++++
 drivers/mtd/mtd_blkdevs.c |  4 +++-
 drivers/mtd/ubi/block.c   |  5 ++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 796a2eccbef0..12874dec1569 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -69,6 +69,17 @@ config MTD_BLOCK_RO
 	  You do not need this option for use with the DiskOnChip devices. For
 	  those, enable NFTL support (CONFIG_NFTL) instead.
 
+config MTD_BLOCK_PARTITIONS
+	bool "Scan for partitions on MTD block devices"
+	depends on MTD_BLOCK || MTD_BLOCK_RO
+	default y if FIT_PARTITION
+	help
+	  Scan MTD block devices for partitions (ie. MBR, GPT, uImage.FIT, ...).
+	  (NAND devices are omitted, ubiblock should be used instead when)
+
+	  Unless your MTD partitions contain sub-partitions mapped using a
+	  partition table, say no.
+
 comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK."
 	depends on MTD_BLOCK || MTD_BLOCK_RO
 
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 60b222799871..e6f2e0888246 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	} else {
 		snprintf(gd->disk_name, sizeof(gd->disk_name),
 			 "%s%d", tr->name, new->devnum);
-		gd->flags |= GENHD_FL_NO_PART;
+
+		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->mtd))
+			gd->flags |= GENHD_FL_NO_PART;
 	}
 
 	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 75eaecc8639f..e617635ff6e6 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -430,7 +430,10 @@ int ubiblock_create(struct ubi_volume_info *vi)
 		ret = -ENODEV;
 		goto out_cleanup_disk;
 	}
-	gd->flags |= GENHD_FL_NO_PART;
+
+	if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS))
+		gd->flags |= GENHD_FL_NO_PART;
+
 	gd->private_data = dev;
 	sprintf(gd->disk_name, "ubiblock%d_%d", dev->ubi_num, dev->vol_id);
 	set_capacity(gd, disk_capacity);
-- 
2.38.1

