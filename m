Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7EF70D5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjEWHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjEWHqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768011A;
        Tue, 23 May 2023 00:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BOtvo2QkhpnKNrqVZX60VmJ53d8jKRahCxNIQR8Da1k=; b=VJ7bzvqRzAknKL8HckX4vSg28u
        XVN0Nn6Q5RMRGID0IU1iNT7xuFOy/iGqFqXvFP0jDsjFuR7hl9SEUNbqoLBA1CMA0ngC2JFqOx0L1
        MZqtHp3RJ6L+HLgDygEC3Yarhx6JEHZgA7nBDqqpxKRczJUFvJBR3ksCqiW2llzT4aiFc7K5mLs+H
        hhZP2DpK6VXsj9vaXqI7jQe4UB4eu4xp6THLqLROh7dX0qihSfnWi3/5qRyc5YgcDkorsm6nDD1nq
        yngrtl+ugiHEjMfgkPcWXw9q2pWGObpvhvVbPb5rBELOgqpuC0GV4gH/j/lcfktgz8cDRA4Bqq8aW
        x64HC7+A==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mj4-009HEh-16;
        Tue, 23 May 2023 07:46:34 +0000
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
Subject: [PATCH 20/24] dm: only call early_lookup_bdev from early boot context
Date:   Tue, 23 May 2023 09:45:31 +0200
Message-Id: <20230523074535.249802-21-hch@lst.de>
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

early_lookup_bdev is supposed to only be called from the early boot
code, but dm_get_device calls it as a general fallback when lookup_bdev
fails, which is problematic because early_lookup_bdev bypasses all normal
path based permission checking, and might cause problems with certain
container environments renaming devices.

Switch to only call early_lookup_bdev when dm is built-in and the system
state in not running yet.  This means it is still available when tables
are constructed by dm-init.c from the kernel command line, but not
otherwise.

Note that this strictly speaking changes the kernel ABI as the PARTUUID=
and PARTLABEL= style syntax is now not available during a running
systems.  They never were intended for that, but this breaks things
we'll have to figure out a way to make them available again.  But if
avoidable in any way I'd rather avoid that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-table.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e997f4322a9967..c230241a76b374 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -326,8 +326,11 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
 /*
  * Add a device to the list, or just increment the usage count if
  * it's already present.
+ *
+ * Note: the __ref annotation is because this function can call the __init
+ * marked early_lookup_bdev when called during early boot code from dm-init.c.
  */
-int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
+int __ref dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		  struct dm_dev **result)
 {
 	int r;
@@ -346,8 +349,10 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 			return -EOVERFLOW;
 	} else {
 		r = lookup_bdev(path, &dev);
-		if (r)
+#ifndef MODULE
+		if (r && system_state < SYSTEM_RUNNING)
 			r = early_lookup_bdev(path, &dev);
+#endif
 		if (r)
 			return -ENODEV;
 	}
-- 
2.39.2

