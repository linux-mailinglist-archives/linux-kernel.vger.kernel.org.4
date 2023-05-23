Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE8E70D5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjEWHs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjEWHr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:47:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E976E43;
        Tue, 23 May 2023 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D34j/jIpT3tAQ3mj3VVRjyTOGpd7sal98So30f9hkUc=; b=HU/D9i+NHKLZXhKkNzlfqCXp8i
        LDAo+HnfOcbGb7KGVNzgmeN8ylv5VaUSbGWg8nMyCFJ8p/hOi1tT3PlwV66BJXDiSySQcRy6usQQz
        Uh+xQvVrvdNSQzAAmLenFZGkTuyzQGg+zJM0s02O+cpPqMR8CRm4P4796GwkJ4lZP/Hq2ZcPv1h4L
        im393C3UhKsQoq1UUvNpFsQ1OnBhrNKBbDL6EkqxGy+tEYksfZCCCbBQLzbKja4de2KYUSkN3h26T
        6EsIqVaVj7/byMDG+niWhCRSEbLz7UQevTCpVxZZ+FdUQGjr/c4ivo53aDL50h/HbTDaeMM/NeT6D
        9wPZldxA==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MjA-009HLC-0s;
        Tue, 23 May 2023 07:46:40 +0000
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
Subject: [PATCH 22/24] mtd: block2mtd: factor the early block device open logic into a helper
Date:   Tue, 23 May 2023 09:45:33 +0200
Message-Id: <20230523074535.249802-23-hch@lst.de>
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

Simply add_device a bit by splitting out the cumbersome early boot logic
into a separate helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/devices/block2mtd.c | 53 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 4c21e9f13bead5..182eed68c75634 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -215,34 +215,18 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 	kfree(dev);
 }
 
-
-static struct block2mtd_dev *add_device(char *devname, int erase_size,
-		char *label, int timeout)
+static struct block_device *mdtblock_early_get_bdev(const char *devname,
+		fmode_t mode, int timeout, struct block2mtd_dev *dev)
 {
+	struct block_device *bdev = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
-#endif
-	const fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
-	struct block_device *bdev;
-	struct block2mtd_dev *dev;
-	char *name;
-
-	if (!devname)
-		return NULL;
-
-	dev = kzalloc(sizeof(struct block2mtd_dev), GFP_KERNEL);
-	if (!dev)
-		return NULL;
 
-	/* Get a handle on the device */
-	bdev = blkdev_get_by_path(devname, mode, dev);
-
-#ifndef MODULE
 	/*
 	 * We might not have the root device mounted at this point.
 	 * Try to resolve the device name by other means.
 	 */
-	for (i = 0; IS_ERR(bdev) && i <= timeout; i++) {
+	for (i = 0; i <= timeout; i++) {
 		dev_t devt;
 
 		if (i)
@@ -254,12 +238,35 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 			msleep(1000);
 		wait_for_device_probe();
 
-		if (early_lookup_bdev(devname, &devt))
-			continue;
-		bdev = blkdev_get_by_dev(devt, mode, dev);
+		if (!early_lookup_bdev(devname, &devt)) {
+			bdev = blkdev_get_by_dev(devt, mode, dev);
+			if (!IS_ERR(bdev))
+				break;
+		}
 	}
 #endif
+	return bdev;
+}
+
+static struct block2mtd_dev *add_device(char *devname, int erase_size,
+		char *label, int timeout)
+{
+	const fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
+	struct block_device *bdev;
+	struct block2mtd_dev *dev;
+	char *name;
 
+	if (!devname)
+		return NULL;
+
+	dev = kzalloc(sizeof(struct block2mtd_dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	/* Get a handle on the device */
+	bdev = blkdev_get_by_path(devname, mode, dev);
+	if (IS_ERR(bdev))
+		bdev = mdtblock_early_get_bdev(devname, mode, timeout, dev);
 	if (IS_ERR(bdev)) {
 		pr_err("error: cannot open device %s\n", devname);
 		goto err_free_block2mtd;
-- 
2.39.2

