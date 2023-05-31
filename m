Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206657180C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjEaM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjEaM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B84171E;
        Wed, 31 May 2023 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jAZ2Lpqv9w5tzIli0lU63w8hNYKgTil+4KnJbbgvAd4=; b=UBhnHR7tsbXBNcXozGzoAjkIw2
        MFcqbMK0VVBdrlGV6tiaPKxNZ4E925KNHcCNdYoDv9fc7iQzaGQV22ra72qUlZGKkgNSXf8RUDaOj
        2TlDEhN2o5DfklyFWBeAGNy5FcQ9kXUsP4YwSA2Vz2+uKy5lP3G+M1b1pHHCDriCiym7mGkbusrjP
        snwMSYDPSuK+iN+FPNNk38/Takavevair0pjmyDThqvMYcFYdS7bXmDyxDIbzeWwVhPfeHLyotnzJ
        vHxk6qey3uyNxI+WSv0sJ7vWV8nHKJJxs6WeuER2AgTsiCKJEpzRuWqb9RkC0h/N5F+JUcacoDVTp
        iMBryhzA==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LNz-00HRoS-0G;
        Wed, 31 May 2023 12:57:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Loic Poulain <loic.poulain@linaro.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 16/24] block: move more code to early-lookup.c
Date:   Wed, 31 May 2023 14:55:27 +0200
Message-Id: <20230531125535.676098-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531125535.676098-1-hch@lst.de>
References: <20230531125535.676098-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_lookup_devt is only used by code in early-lookup.c, so move it
there.

printk_all_partitions and it's helper bdevt_str are only used by the
early init code in init/do_mounts.c, so they should go there as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/early-lookup.c   | 92 ++++++++++++++++++++++++++++++++++++++++++
 block/genhd.c          | 92 ------------------------------------------
 include/linux/blkdev.h |  1 -
 3 files changed, 92 insertions(+), 93 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 9fc30d039508af..6016e781b6a0e2 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -120,6 +120,35 @@ static int devt_from_partlabel(const char *label, dev_t *devt)
 	return 0;
 }
 
+static dev_t blk_lookup_devt(const char *name, int partno)
+{
+	dev_t devt = MKDEV(0, 0);
+	struct class_dev_iter iter;
+	struct device *dev;
+
+	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
+	while ((dev = class_dev_iter_next(&iter))) {
+		struct gendisk *disk = dev_to_disk(dev);
+
+		if (strcmp(dev_name(dev), name))
+			continue;
+
+		if (partno < disk->minors) {
+			/* We need to return the right devno, even
+			 * if the partition doesn't exist yet.
+			 */
+			devt = MKDEV(MAJOR(dev->devt),
+				     MINOR(dev->devt) + partno);
+		} else {
+			devt = part_devt(disk, partno);
+			if (devt)
+				break;
+		}
+	}
+	class_dev_iter_exit(&iter);
+	return devt;
+}
+
 static int devt_from_devname(const char *name, dev_t *devt)
 {
 	int part;
@@ -222,3 +251,66 @@ int early_lookup_bdev(const char *name, dev_t *devt)
 	return devt_from_devnum(name, devt);
 }
 EXPORT_SYMBOL_GPL(early_lookup_bdev);
+
+static char __init *bdevt_str(dev_t devt, char *buf)
+{
+	if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
+		char tbuf[BDEVT_SIZE];
+		snprintf(tbuf, BDEVT_SIZE, "%02x%02x", MAJOR(devt), MINOR(devt));
+		snprintf(buf, BDEVT_SIZE, "%-9s", tbuf);
+	} else
+		snprintf(buf, BDEVT_SIZE, "%03x:%05x", MAJOR(devt), MINOR(devt));
+
+	return buf;
+}
+
+/*
+ * print a full list of all partitions - intended for places where the root
+ * filesystem can't be mounted and thus to give the victim some idea of what
+ * went wrong
+ */
+void __init printk_all_partitions(void)
+{
+	struct class_dev_iter iter;
+	struct device *dev;
+
+	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
+	while ((dev = class_dev_iter_next(&iter))) {
+		struct gendisk *disk = dev_to_disk(dev);
+		struct block_device *part;
+		char devt_buf[BDEVT_SIZE];
+		unsigned long idx;
+
+		/*
+		 * Don't show empty devices or things that have been
+		 * suppressed
+		 */
+		if (get_capacity(disk) == 0 || (disk->flags & GENHD_FL_HIDDEN))
+			continue;
+
+		/*
+		 * Note, unlike /proc/partitions, I am showing the numbers in
+		 * hex - the same format as the root= option takes.
+		 */
+		rcu_read_lock();
+		xa_for_each(&disk->part_tbl, idx, part) {
+			if (!bdev_nr_sectors(part))
+				continue;
+			printk("%s%s %10llu %pg %s",
+			       bdev_is_partition(part) ? "  " : "",
+			       bdevt_str(part->bd_dev, devt_buf),
+			       bdev_nr_sectors(part) >> 1, part,
+			       part->bd_meta_info ?
+					part->bd_meta_info->uuid : "");
+			if (bdev_is_partition(part))
+				printk("\n");
+			else if (dev->parent && dev->parent->driver)
+				printk(" driver: %s\n",
+					dev->parent->driver->name);
+			else
+				printk(" (driver?)\n");
+		}
+		rcu_read_unlock();
+	}
+	class_dev_iter_exit(&iter);
+}
diff --git a/block/genhd.c b/block/genhd.c
index 1cb489b927d50a..aa28f296fe391b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -318,18 +318,6 @@ void blk_free_ext_minor(unsigned int minor)
 	ida_free(&ext_devt_ida, minor);
 }
 
-static char *bdevt_str(dev_t devt, char *buf)
-{
-	if (MAJOR(devt) <= 0xff && MINOR(devt) <= 0xff) {
-		char tbuf[BDEVT_SIZE];
-		snprintf(tbuf, BDEVT_SIZE, "%02x%02x", MAJOR(devt), MINOR(devt));
-		snprintf(buf, BDEVT_SIZE, "%-9s", tbuf);
-	} else
-		snprintf(buf, BDEVT_SIZE, "%03x:%05x", MAJOR(devt), MINOR(devt));
-
-	return buf;
-}
-
 void disk_uevent(struct gendisk *disk, enum kobject_action action)
 {
 	struct block_device *part;
@@ -755,57 +743,6 @@ void blk_request_module(dev_t devt)
 }
 #endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
-/*
- * print a full list of all partitions - intended for places where the root
- * filesystem can't be mounted and thus to give the victim some idea of what
- * went wrong
- */
-void __init printk_all_partitions(void)
-{
-	struct class_dev_iter iter;
-	struct device *dev;
-
-	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
-	while ((dev = class_dev_iter_next(&iter))) {
-		struct gendisk *disk = dev_to_disk(dev);
-		struct block_device *part;
-		char devt_buf[BDEVT_SIZE];
-		unsigned long idx;
-
-		/*
-		 * Don't show empty devices or things that have been
-		 * suppressed
-		 */
-		if (get_capacity(disk) == 0 || (disk->flags & GENHD_FL_HIDDEN))
-			continue;
-
-		/*
-		 * Note, unlike /proc/partitions, I am showing the numbers in
-		 * hex - the same format as the root= option takes.
-		 */
-		rcu_read_lock();
-		xa_for_each(&disk->part_tbl, idx, part) {
-			if (!bdev_nr_sectors(part))
-				continue;
-			printk("%s%s %10llu %pg %s",
-			       bdev_is_partition(part) ? "  " : "",
-			       bdevt_str(part->bd_dev, devt_buf),
-			       bdev_nr_sectors(part) >> 1, part,
-			       part->bd_meta_info ?
-					part->bd_meta_info->uuid : "");
-			if (bdev_is_partition(part))
-				printk("\n");
-			else if (dev->parent && dev->parent->driver)
-				printk(" driver: %s\n",
-					dev->parent->driver->name);
-			else
-				printk(" (driver?)\n");
-		}
-		rcu_read_unlock();
-	}
-	class_dev_iter_exit(&iter);
-}
-
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *disk_seqf_start(struct seq_file *seqf, loff_t *pos)
@@ -1339,35 +1276,6 @@ dev_t part_devt(struct gendisk *disk, u8 partno)
 	return devt;
 }
 
-dev_t blk_lookup_devt(const char *name, int partno)
-{
-	dev_t devt = MKDEV(0, 0);
-	struct class_dev_iter iter;
-	struct device *dev;
-
-	class_dev_iter_init(&iter, &block_class, NULL, &disk_type);
-	while ((dev = class_dev_iter_next(&iter))) {
-		struct gendisk *disk = dev_to_disk(dev);
-
-		if (strcmp(dev_name(dev), name))
-			continue;
-
-		if (partno < disk->minors) {
-			/* We need to return the right devno, even
-			 * if the partition doesn't exist yet.
-			 */
-			devt = MKDEV(MAJOR(dev->devt),
-				     MINOR(dev->devt) + partno);
-		} else {
-			devt = part_devt(disk, partno);
-			if (devt)
-				break;
-		}
-	}
-	class_dev_iter_exit(&iter);
-	return devt;
-}
-
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0bda6cb98d7eb8..0ce09ecfa3a7af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -838,7 +838,6 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
 void inc_diskseq(struct gendisk *disk);
-dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
 
 extern int blk_register_queue(struct gendisk *disk);
-- 
2.39.2

