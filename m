Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42A70D5AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbjEWHqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjEWHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:46:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF8119;
        Tue, 23 May 2023 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=os0MBKKbxqig3Onswrq7Zcvd+L0EYsCNlnX80lA2o9g=; b=fekrZqAoQ4hechvxjoK8F7dWKk
        5f5fS0BS6/TMGtsVCSThfqxK4EyqTmCpcQUuksucwHHaz8mxgLl+oQlV0P2A6iBioeLOEgHoXJcCl
        40lgBbs5Wly6X56KLIB0nV+/r0wKF9pLUxHF5UBSwB+icaY6QiZ3mSna4clKWX+cej2SwcJ5byDB2
        xdZVTUACgJTL47xvgS86JV4hUtfW0g3/+/R7fmZ2oVWAbKgVHl2PhyljuOtB21GAX9q1B8P2+TYr5
        r6VwB/dmng2zncC+qn0WDnKxoAWQ8EGds/p37+gEHXr6KF89G8ID7pin3hPrwoQTZQi9IAl0CgUkT
        zUqxZbgQ==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1Mib-009Gjq-0W;
        Tue, 23 May 2023 07:46:05 +0000
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
Subject: [PATCH 10/24] init: handle ubi/mtd root mounting like all other root types
Date:   Tue, 23 May 2023 09:45:21 +0200
Message-Id: <20230523074535.249802-11-hch@lst.de>
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

Assign a Root_Generic magic value for UBI/MTD root and handle the root
mounting in mount_root like all other root types.  Besides making the
code more clear this also means that UBI/MTD root can be used together
with an initrd (not that anyone should care).

Also factor parsing of the root name into a helper now that it can
be easily done and will get more complicated with subsequent patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/root_dev.h |  1 +
 init/do_mounts.c         | 23 ++++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index ed3ea8da642972..847c9a06101b76 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -9,6 +9,7 @@
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
 	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
+	Root_Generic = MKDEV(UNNAMED_MAJOR, 253),
 	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
 };
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 74cc96bffbdd71..be6d14733ba02f 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -591,6 +591,10 @@ void __init mount_root(char *root_device_name)
 	case Root_CIFS:
 		mount_cifs_root();
 		break;
+	case Root_Generic:
+		mount_root_generic(root_device_name, root_device_name,
+				   root_mountflags);
+		break;
 	case 0:
 		if (root_device_name && root_fs_names &&
 		    mount_nodev_root(root_device_name) == 0)
@@ -602,6 +606,14 @@ void __init mount_root(char *root_device_name)
 	}
 }
 
+static dev_t __init parse_root_device(char *root_device_name)
+{
+	if (!strncmp(root_device_name, "mtd", 3) ||
+	    !strncmp(root_device_name, "ubi", 3))
+		return Root_Generic;
+	return name_to_dev_t(root_device_name);
+}
+
 /*
  * Prepare the namespace - decide what/where to mount, load ramdisks, etc.
  */
@@ -624,15 +636,8 @@ void __init prepare_namespace(void)
 
 	md_run_setup();
 
-	if (saved_root_name[0]) {
-		if (!strncmp(saved_root_name, "mtd", 3) ||
-		    !strncmp(saved_root_name, "ubi", 3)) {
-			mount_root_generic(saved_root_name, saved_root_name,
-					   root_mountflags);
-			goto out;
-		}
-		ROOT_DEV = name_to_dev_t(saved_root_name);
-	}
+	if (saved_root_name[0])
+		ROOT_DEV = parse_root_device(saved_root_name);
 
 	if (initrd_load(saved_root_name))
 		goto out;
-- 
2.39.2

