Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F567180D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjEaM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbjEaM6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:58:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2B124;
        Wed, 31 May 2023 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Eb3aGI6n4ytEG8s7b8hrZ+gUQ6cXP36Kx70RBR7HPKY=; b=c3P5AWBv0AGRi2WjLeefQt8p1U
        61YRrFR7iCVpyfZWbW0h1CQKRy7sW+1IywAx74ihcFduGXy9i39NUCsLMrskEEeoaUexPOvgqpi0T
        PFhbXRwrJJUJo9yVlxTarVQ5/Ov3CO2L5akUzC2OAh5uA5glLLLi/B7yIKzdkUyEs8KLFrOH3KYwu
        M6pjiF+/Edr97OZxVkjVB3Mtq8SNTChhtw2QYbPitjZQrhKT70iOjn9w06qQYH7TB/ucjVxytCvvX
        +tOR5D+eLh2tmE0RJNEv+E5v6OdHcl8MyHL606Wup8yyNV4Uv0VmxYojd/mMdWIeWR1d5miOvnH61
        gmrjIpRA==;
Received: from [2001:4bb8:182:6d06:2e49:a56:513a:92ee] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LO9-00HRzk-0U;
        Wed, 31 May 2023 12:57:17 +0000
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
Subject: [PATCH 19/24] dm: remove dm_get_dev_t
Date:   Wed, 31 May 2023 14:55:30 +0200
Message-Id: <20230531125535.676098-20-hch@lst.de>
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

Open code dm_get_dev_t in the only remaining caller, and propagate the
exact error code from lookup_bdev and early_lookup_bdev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-table.c         | 22 +++++-----------------
 include/linux/device-mapper.h |  2 --
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 05aa16da43b0d5..1576b408768d4b 100644
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
@@ -359,9 +345,11 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (MAJOR(dev) != major || MINOR(dev) != minor)
 			return -EOVERFLOW;
 	} else {
-		dev = dm_get_dev_t(path);
-		if (!dev)
-			return -ENODEV;
+		r = lookup_bdev(path, &dev);
+		if (r)
+			r = early_lookup_bdev(path, &dev);
+		if (r)
+			return r;
 	}
 	if (dev == disk_devt(t->md->disk))
 		return -EINVAL;
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

