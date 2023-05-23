Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD4470D5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjEWHrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjEWHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5135F196;
        Tue, 23 May 2023 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1j9PBfjt7C2OyHwYLb5o3ix4kUllkeK0wk1Jd5LdU0M=; b=bANGpmMPSjXPMHstCgaRRkjVxe
        bc1gOv4QuRafF7E+izc51x/WzpLGtmhh9y7Qyh7DOTVJFsd+MU5GKquOFAWgLV+px2CQrgGL6TZbo
        lobwzr4zeypkc0IByP4jhVev+D2cLRl88de8olNUn55W6+8voZzakshGeKbji4NTocT+fcr7kyAO2
        SHgTdyIVWPm+R0KcuPAztO91gZnzTTs0K9dxNMCkiiE7OXsIj4YXHxtzkPCv+9mzlB9mUrsHwTfMT
        qVNY1OZt+2atpAsjDzDPxoQz7gmkHx8yTNiZITXxZi6ycXLfe4VbUXwV4PpGbr6jM1LCVD6Kmu/Bq
        WXq1qvNA==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Miu-009H5F-2p;
        Tue, 23 May 2023 07:46:26 +0000
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
Subject: [PATCH 17/24] dm-snap: simplify the origin_dev == cow_dev check in snapshot_ctr
Date:   Tue, 23 May 2023 09:45:28 +0200
Message-Id: <20230523074535.249802-18-hch@lst.de>
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

Use the block_device acquired in dm_get_device for the check instead
of doing an extra lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-snap.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 9c49f53760d066..7832974b73eb03 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -1241,7 +1241,6 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	int i;
 	int r = -EINVAL;
 	char *origin_path, *cow_path;
-	dev_t origin_dev, cow_dev;
 	unsigned int args_used, num_flush_bios = 1;
 	fmode_t origin_mode = FMODE_READ;
 
@@ -1279,24 +1278,21 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ti->error = "Cannot get origin device";
 		goto bad_origin;
 	}
-	origin_dev = s->origin->bdev->bd_dev;
 
 	cow_path = argv[0];
 	argv++;
 	argc--;
 
-	cow_dev = dm_get_dev_t(cow_path);
-	if (cow_dev && cow_dev == origin_dev) {
-		ti->error = "COW device cannot be the same as origin device";
-		r = -EINVAL;
-		goto bad_cow;
-	}
-
 	r = dm_get_device(ti, cow_path, dm_table_get_mode(ti->table), &s->cow);
 	if (r) {
 		ti->error = "Cannot get COW device";
 		goto bad_cow;
 	}
+	if (s->cow->bdev && s->cow->bdev == s->origin->bdev) {
+		ti->error = "COW device cannot be the same as origin device";
+		r = -EINVAL;
+		goto bad_store;
+	}
 
 	r = dm_exception_store_create(ti, argc, argv, s, &args_used, &s->store);
 	if (r) {
-- 
2.39.2

