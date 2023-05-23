Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9898D70D5F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjEWHsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjEWHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:47:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A391E5C;
        Tue, 23 May 2023 00:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9B9Q5RDcOkQVHhQcbSUKb6IuqOR/HrhtGX8DsjrEY38=; b=Np9j14NJ3gyLQvNx0tekwf7Ovf
        uQnoq7NH4MC7d2AAqT1B+qQNaq73b06tsCSBmoNWRNfBW6F0BTzu5oePtSiUmH8+E3PWScBXuzlLS
        M8kGgMKX6BxZmy5iUngyne92c3aF0Y5Dbm6S7XdV37mN1ihXYho4P4LCOELU/xbQU+eKlD/aFMQk8
        jxn1CchGb8AgZSMCDZjfvL/NoOOrv0aLZQ3LDUPLSl6YOd30I5Phg/xONcm8hWqY/FWhUvx35IgjW
        6Hb26MVfy3n+1S0oPfv03VjKucGProqJJrY3NcUzIBfp1Z80xEHEIXNWttkaz+L26SAMYKor/7QPN
        ZVduL80Q==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MjF-009HS4-3A;
        Tue, 23 May 2023 07:46:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 24/24] block: mark early_lookup_bdev as __init
Date:   Tue, 23 May 2023 09:45:35 +0200
Message-Id: <20230523074535.249802-25-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523074535.249802-1-hch@lst.de>
References: <20230523074535.249802-1-hch@lst.de>
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

early_lookup_bdev is now only used during the early boot code as it
should, so mark it __init to not waste run time memory on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/early-lookup.c   | 19 +++++++++----------
 include/linux/blkdev.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 6016e781b6a0e2..3ff0d2e4dcbfb8 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Code for looking up block devices in the early boot code before mounting the
- * root file system.  Unfortunately currently also abused in a few other places.
+ * root file system.
  */
 #include <linux/blkdev.h>
 #include <linux/ctype.h>
@@ -18,7 +18,7 @@ struct uuidcmp {
  *
  * Returns 1 if the device matches, and 0 otherwise.
  */
-static int match_dev_by_uuid(struct device *dev, const void *data)
+static int __init match_dev_by_uuid(struct device *dev, const void *data)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
 	const struct uuidcmp *cmp = data;
@@ -42,7 +42,7 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
  *
  * Returns the matching dev_t on success or 0 on failure.
  */
-static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
+static int __init devt_from_partuuid(const char *uuid_str, dev_t *devt)
 {
 	struct uuidcmp cmp;
 	struct device *dev = NULL;
@@ -98,7 +98,7 @@ static int devt_from_partuuid(const char *uuid_str, dev_t *devt)
  *
  * Returns 1 if the device matches, and 0 otherwise.
  */
-static int match_dev_by_label(struct device *dev, const void *data)
+static int __init match_dev_by_label(struct device *dev, const void *data)
 {
 	struct block_device *bdev = dev_to_bdev(dev);
 	const char *label = data;
@@ -108,7 +108,7 @@ static int match_dev_by_label(struct device *dev, const void *data)
 	return 1;
 }
 
-static int devt_from_partlabel(const char *label, dev_t *devt)
+static int __init devt_from_partlabel(const char *label, dev_t *devt)
 {
 	struct device *dev;
 
@@ -120,7 +120,7 @@ static int devt_from_partlabel(const char *label, dev_t *devt)
 	return 0;
 }
 
-static dev_t blk_lookup_devt(const char *name, int partno)
+static dev_t __init blk_lookup_devt(const char *name, int partno)
 {
 	dev_t devt = MKDEV(0, 0);
 	struct class_dev_iter iter;
@@ -149,7 +149,7 @@ static dev_t blk_lookup_devt(const char *name, int partno)
 	return devt;
 }
 
-static int devt_from_devname(const char *name, dev_t *devt)
+static int __init devt_from_devname(const char *name, dev_t *devt)
 {
 	int part;
 	char s[32];
@@ -193,7 +193,7 @@ static int devt_from_devname(const char *name, dev_t *devt)
 	return -EINVAL;
 }
 
-static int devt_from_devnum(const char *name, dev_t *devt)
+static int __init devt_from_devnum(const char *name, dev_t *devt)
 {
 	unsigned maj, min, offset;
 	char *p, dummy;
@@ -240,7 +240,7 @@ static int devt_from_devnum(const char *name, dev_t *devt)
  *	name contains slashes, the device name has them replaced with
  *	bangs.
  */
-int early_lookup_bdev(const char *name, dev_t *devt)
+int __init early_lookup_bdev(const char *name, dev_t *devt)
 {
 	if (strncmp(name, "PARTUUID=", 9) == 0)
 		return devt_from_partuuid(name + 9, devt);
@@ -250,7 +250,6 @@ int early_lookup_bdev(const char *name, dev_t *devt)
 		return devt_from_devname(name + 5, devt);
 	return devt_from_devnum(name, devt);
 }
-EXPORT_SYMBOL_GPL(early_lookup_bdev);
 
 static char __init *bdevt_str(dev_t devt, char *buf)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 361341aea82ce5..a07776e5b27940 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1493,7 +1493,7 @@ int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
 void printk_all_partitions(void);
-int early_lookup_bdev(const char *pathname, dev_t *dev);
+int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
 static inline void invalidate_bdev(struct block_device *bdev)
 {
-- 
2.39.2

