Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC770D5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjEWHru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjEWHqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28318B;
        Tue, 23 May 2023 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=V2F5GAusl5v7Z9/ExFrBk16K4LK9JB6Nzuc1XGdQbDM=; b=q/awHJ0UGEBFLhqS/Kem21dFO8
        UrqUe7X6+VcibSuQ3U/6iaJ4woeliYVvU0gW2bL/94CXeRxfA3EXW5LhqQb+MK1hK5Dbt/TlbF9SF
        Nd2c35vTILMWnyNRiYbVXTocVbw+/PIrVmFw/srfaU9oPOWlYa2zrHdfdWhp/2Beb9tFARP4ORdYg
        g728oGvlQXRZj/YuOp2rdn62vjBOElOLy4m/EEgNW9Mocbiti4f2V0yQ0Z+Lr//+t3PcFQSxYjyti
        +ifFE8gU2xVLNYMCH1shCmOQEulB/a3q4Zep9xvhE9LzmaDehvFq5ME3AusCR0JZle+QNJ3/qCAom
        KVt7hBeQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mj1-009HBv-1X;
        Tue, 23 May 2023 07:46:31 +0000
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
Subject: [PATCH 19/24] dm: remove dm_get_dev_t
Date:   Tue, 23 May 2023 09:45:30 +0200
Message-Id: <20230523074535.249802-20-hch@lst.de>
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

Open code dm_get_dev_t in the only remaining caller, and propagate the
exact error code from lookup_bdev and early_lookup_bdev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-table.c         | 20 ++++----------------
 include/linux/device-mapper.h |  2 --
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 05aa16da43b0d5..e997f4322a9967 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -323,20 +323,6 @@ static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
 	return 0;
 }
 
-/*
- * Convert the path to a device
- */
-dev_t dm_get_dev_t(const char *path)
-{
-	dev_t dev;
-
-	if (lookup_bdev(path, &dev) &&
-	    early_lookup_bdev(path, &dev))
-		return 0;
-	return dev;
-}
-EXPORT_SYMBOL_GPL(dm_get_dev_t);
-
 /*
  * Add a device to the list, or just increment the usage count if
  * it's already present.
@@ -359,8 +345,10 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (MAJOR(dev) != major || MINOR(dev) != minor)
 			return -EOVERFLOW;
 	} else {
-		dev = dm_get_dev_t(path);
-		if (!dev)
+		r = lookup_bdev(path, &dev);
+		if (r)
+			r = early_lookup_bdev(path, &dev);
+		if (r)
 			return -ENODEV;
 	}
 	if (dev == disk_devt(t->md->disk))
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a52d2b9a68460a..c27b84002d8382 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -170,8 +170,6 @@ struct dm_dev {
 	char name[16];
 };
 
-dev_t dm_get_dev_t(const char *path);
-
 /*
  * Constructors should call these functions to ensure destination devices
  * are opened/closed correctly.
-- 
2.39.2

