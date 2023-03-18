Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B06BFBE5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCRRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCRRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:36:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16032510;
        Sat, 18 Mar 2023 10:36:33 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679160991;
        bh=xiqHWSC49shuhqvLfMSzV+Z/2sBGKK0CTZeOzhHDAs0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=escEGlFaiOS+QYZdcY1bMio2R2l7td8fG8+QJfgtwwn1U7FukPM2/3VhQNkKTa6uU
         V/1ahrrS0UtyFBwhxgxcUZSF2SkQ10RmQFMDBMqgaWhwNl65oftrRcGSoUbltGYEZQ
         s/Ilx78c++OY+CLnLa8Gfw4xa6iv02gxyi88sxgU=
Date:   Sat, 18 Mar 2023 17:36:23 +0000
Subject: [PATCH v3 1/3] blk-integrity: use sysfs_emit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v3-1-ceccb4493c46@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679160989; l=2443;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xiqHWSC49shuhqvLfMSzV+Z/2sBGKK0CTZeOzhHDAs0=;
 b=GS9KWf/XOcf6+joq/W3STKHN5uWt9LKXXluB5ziVjcdOrkmhg5sCpKPNHqkVxjuEFtvoTx7VU
 cPY8rnKhctmCpTiyrB+I7aepkOjaxqJziEZXIigqCaqSyou9eeYdeg8
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

Also perform some trivial syntactic cleanups.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 8f01d786f5cb..aca8c783d749 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -248,20 +248,19 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
 {
 	if (bi->profile && bi->profile->name)
-		return sprintf(page, "%s\n", bi->profile->name);
-	else
-		return sprintf(page, "none\n");
+		return sysfs_emit(page, "%s\n", bi->profile->name);
+	return sysfs_emit(page, "none\n");
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
@@ -280,7 +279,7 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 
 static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
+	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_VERIFY));
 }
 
 static ssize_t integrity_generate_store(struct blk_integrity *bi,
@@ -299,13 +298,13 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 
 static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
+	return sysfs_emit(page, "%d\n", !!(bi->flags & BLK_INTEGRITY_GENERATE));
 }
 
 static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
 {
-	return sprintf(page, "%u\n",
-		       (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
+	return sysfs_emit(page, "%u\n",
+			  !!(bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE));
 }
 
 static struct integrity_sysfs_entry integrity_format_entry = {

-- 
2.40.0

