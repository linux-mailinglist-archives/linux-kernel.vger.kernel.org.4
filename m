Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B16B54A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjCJWki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCJWk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:29 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338D12DDE2;
        Fri, 10 Mar 2023 14:40:22 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678488020;
        bh=nk1tYStc/zzpUi5AGWWqN1WDZEH5Vm0XZdrqk1ma6QA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=lwWEYmoeA5l0k+a7OqgPVUExJxAu0/qPVX/T6s69SNvi9pknteXzI85IPj4MoXl+U
         AsMtu8W+sWPHuSP2Wdx2c6WBb64LvVA/kWo6c335kL/6RiWwMaLmv8cqGqnTeZX+yD
         0Pjn4cRcJ6PGCt+0WzTko1jF97VOwp97lyMpeocE=
Date:   Fri, 10 Mar 2023 22:40:02 +0000
Subject: [PATCH v2 1/4] blk-integrity: use sysfs_emit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v2-1-761a50d71900@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678488015; l=2402;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nk1tYStc/zzpUi5AGWWqN1WDZEH5Vm0XZdrqk1ma6QA=;
 b=A0U/T61qUiZ+MOyWS3HHovGCrry1hKKc5vALP14Kt9Yk8q8VAlXS9YRvG0Kqj18SJvubIdbOj
 qjwYYiHyRnFD7buy2DSglL6JHmjA7jYxHalKfhyk1s4FiHBHcwty+iZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct way to emit data into sysfs is via sysfs_emit(), use it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 8f01d786f5cb..5dd820ee4d1c 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -248,20 +248,20 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
 {
 	if (bi->profile && bi->profile->name)
-		return sprintf(page, "%s\n", bi->profile->name);
+		return sysfs_emit(page, "%s\n", bi->profile->name);
 	else
-		return sprintf(page, "none\n");
+		return sysfs_emit(page, "none\n");
 }
 
 static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n", bi->tag_size);
+	return sysfs_emit(page, "%u\n", bi->tag_size);
 }
 
 static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n",
-		       bi->interval_exp ? 1 << bi->interval_exp : 0);
+	return sysfs_emit(page, "%u\n",
+			  bi->interval_exp ? 1 << bi->interval_exp : 0);
 }
 
 static ssize_t integrity_verify_store(struct blk_integrity *bi,
@@ -280,7 +280,7 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 
 static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
+	return sysfs_emit(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
 }
 
 static ssize_t integrity_generate_store(struct blk_integrity *bi,
@@ -299,13 +299,13 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 
 static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
+	return sysfs_emit(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
 }
 
 static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n",
-		       (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
+	return sysfs_emit(page, "%u\n",
+			  (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
 }
 
 static struct integrity_sysfs_entry integrity_format_entry = {

-- 
2.39.2

