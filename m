Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6570D5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbjEWHqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235570AbjEWHqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58651CD;
        Tue, 23 May 2023 00:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=reP2l+XnVvInA21X0v/lOVTqA4QVG6IJjXgHOwFE+V4=; b=TiknbaKEzoidb3ydSneKc07lPv
        zm2PypoTv5vEqo1NrmLPg13GEarpmwULlBxL+u3D61Jsn+eQsbLHITlLP1GCbz0U2fz3pm57o/5Lg
        lT8UGZV8JN3Wcvw7Zamd+0lc3QNwXsGCLunYsf8Ck0lowkbPLN7dVx+3fYIUG0/BhHtuDvJmPbQXM
        o6VRGH8mpeJGBSXSQXadscZZ7RbjE+jZp2Faj0VMMvgxsRvBjILR1IxBlANWz38NPpAgiMvQdH3IG
        doWnYX8bB219XPGqyT8edjpiFBufJvjVDVzWJ3bzyeIBPdT/N0GHCuIKxo66vIYcqb/KAaaNO30B6
        y2ygv/sQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mid-009GmR-2X;
        Tue, 23 May 2023 07:46:08 +0000
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
Subject: [PATCH 11/24] init: factor the root_wait logic in prepare_namespace into a helper
Date:   Tue, 23 May 2023 09:45:22 +0200
Message-Id: <20230523074535.249802-12-hch@lst.de>
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

The root_wait logic is a bit obsfucated right now.  Expand it and move it
into a helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/do_mounts.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index be6d14733ba02f..d5c06c1546e82c 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -606,6 +606,26 @@ void __init mount_root(char *root_device_name)
 	}
 }
 
+/* wait for any asynchronous scanning to complete */
+static void __init wait_for_root(char *root_device_name)
+{
+	if (ROOT_DEV != 0)
+		return;
+
+	pr_info("Waiting for root device %s...\n", root_device_name);
+
+	for (;;) {
+		if (driver_probe_done()) {
+			ROOT_DEV = name_to_dev_t(root_device_name);
+			if (ROOT_DEV)
+				break;
+		}
+		msleep(5);
+	}
+	async_synchronize_full();
+
+}
+
 static dev_t __init parse_root_device(char *root_device_name)
 {
 	if (!strncmp(root_device_name, "mtd", 3) ||
@@ -642,16 +662,8 @@ void __init prepare_namespace(void)
 	if (initrd_load(saved_root_name))
 		goto out;
 
-	/* wait for any asynchronous scanning to complete */
-	if ((ROOT_DEV == 0) && root_wait) {
-		printk(KERN_INFO "Waiting for root device %s...\n",
-			saved_root_name);
-		while (!driver_probe_done() ||
-			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
-			msleep(5);
-		async_synchronize_full();
-	}
-
+	if (root_wait)
+		wait_for_root(saved_root_name);
 	mount_root(saved_root_name);
 out:
 	devtmpfs_mount();
-- 
2.39.2

