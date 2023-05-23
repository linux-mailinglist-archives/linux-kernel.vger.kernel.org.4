Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B0F70D5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjEWHsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235792AbjEWHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:47:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D0D133;
        Tue, 23 May 2023 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rB1XU3Q8mH+jzryPymiOq8Z/Y0ZEGIxvnUDI5lAUFnE=; b=IR3nBxbwuu4MvPChQwEdKu7V2t
        xvTbSx8RpoJmbaknVJE3FRJUB6ZAhXcsqBq6+bDaCYEso5zOtbKW4kdNUovGSy1cTwV7uWaC76p3N
        8K5EiUbtIqL48X/CNwd2ZD9JxfiMbTKmQlkwf/vshQJzaNFKR/QG41jChIm2cCdWwlHGWrUkQqRm0
        z649ZBBMXxltpSAY9YfGkv0KEDD1np48IkIbTBbgUIM9snFv/mWKs4QgQqLg3BOvgiT2qN3oycCI9
        C9mn8cH/4bGVSXIcLByijq5fhix9QwhCzaWWsqA5BChrcJ5ojWsbTmGp/OTc23+aAP9hq/duaKrzg
        S4lHoyCg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1MjD-009HOR-0Y;
        Tue, 23 May 2023 07:46:43 +0000
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
Subject: [PATCH 23/24] mtd: block2mtd: don't call early_lookup_bdev after the system is running
Date:   Tue, 23 May 2023 09:45:34 +0200
Message-Id: <20230523074535.249802-24-hch@lst.de>
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
code, but mdtblock_early_get_bdev is called as a general fallback when
lookup_bdev fails, which is problematic because early_lookup_bdev
bypasses all normal path based permission checking, and might cause
problems with certain container environments renaming devices.

Switch to only call early_lookup_bdev when dm is built-in and the system
state in not running yet.

Note that this strictly speaking changes the kernel ABI as the PARTUUID=
and PARTLABEL= style syntax is now not available during a running
systems.  They never were intended for that, but this breaks things
we'll have to figure out a way to make them available again.  But if
avoidable in any way I'd rather avoid that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/devices/block2mtd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 182eed68c75634..59e4c71cfc6f53 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -215,13 +215,23 @@ static void block2mtd_free_device(struct block2mtd_dev *dev)
 	kfree(dev);
 }
 
-static struct block_device *mdtblock_early_get_bdev(const char *devname,
+/*
+ * This function is marked __ref because it calls the __init marked
+ * early_lookup_bdev when called from the early boot code.
+ */
+static struct block_device __ref *mdtblock_early_get_bdev(const char *devname,
 		fmode_t mode, int timeout, struct block2mtd_dev *dev)
 {
 	struct block_device *bdev = ERR_PTR(-ENODEV);
 #ifndef MODULE
 	int i;
 
+	/*
+	 * We can't use early_lookup_bdev from a running system.
+	 */
+	if (system_state >= SYSTEM_RUNNING)
+		return bdev;
+
 	/*
 	 * We might not have the root device mounted at this point.
 	 * Try to resolve the device name by other means.
-- 
2.39.2

