Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED06B54A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCJWky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjCJWka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:30 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7862C14416B;
        Fri, 10 Mar 2023 14:40:23 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678488021;
        bh=1YcGn9Ce/hGsN09h+fYjmhHySGAzKoYW3nej9+GPO+A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ehMMQbmvhDOxdGGCpMIJyGiUMN8zm+OrtLsSLxllebonTNUi8fvVneOvxdg80v0Yl
         SgyTcSxNtqf+DbrgMDGgbw3KsorNuCv3pMLOjb3e9Hs+Mo4gVWm+z1A17Q0w4k/Tst
         sl2PUuPisTqvmK3jJr7MKLM1AnCiK1EW987wW+yk=
Date:   Fri, 10 Mar 2023 22:40:03 +0000
Subject: [PATCH v2 2/4] blk-integrity: convert to struct device_attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v2-2-761a50d71900@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678488015; l=7077;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1YcGn9Ce/hGsN09h+fYjmhHySGAzKoYW3nej9+GPO+A=;
 b=7Etw8djoaPtdrIKm3OVT2q7SotBvCDegYUPRFSiDPMfC9hhWUwB0GYOATMcRE+7eub9zkde39
 4tKi/PXzvHmDEyLeppTaNpvScp1EHeX0/lQj+mQqRqud8DYGVk+4Z+V
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

An upcoming patch will register the integrity attributes directly with
the struct device kobject.
For this the attributes have to be implemented in terms of
struct device_attribute.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c | 117 +++++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 5dd820ee4d1c..e1c3e3591c82 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -212,21 +212,15 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	return true;
 }
 
-struct integrity_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct blk_integrity *, char *);
-	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
-};
-
 static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
 				   char *page)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->queue->integrity;
-	struct integrity_sysfs_entry *entry =
-		container_of(attr, struct integrity_sysfs_entry, attr);
+	struct device *dev = disk_to_dev(disk);
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
 
-	return entry->show(bi, page);
+	return dev_attr->show(dev, dev_attr, page);
 }
 
 static ssize_t integrity_attr_store(struct kobject *kobj,
@@ -234,39 +228,52 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 				    size_t count)
 {
 	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct blk_integrity *bi = &disk->queue->integrity;
-	struct integrity_sysfs_entry *entry =
-		container_of(attr, struct integrity_sysfs_entry, attr);
+	struct device *dev = disk_to_dev(disk);
+	struct device_attribute *dev_attr =
+		container_of(attr, struct device_attribute, attr);
 	ssize_t ret = 0;
 
-	if (entry->store)
-		ret = entry->store(bi, page, count);
+	if (dev_attr->store)
+		ret = dev_attr->store(dev, dev_attr, page, count);
 
 	return ret;
 }
 
-static ssize_t integrity_format_show(struct blk_integrity *bi, char *page)
+static inline struct blk_integrity *dev_to_bi(struct device *dev)
+{
+	return &dev_to_disk(dev)->queue->integrity;
+}
+
+static ssize_t format_show(struct device *dev, struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	if (bi->profile && bi->profile->name)
 		return sysfs_emit(page, "%s\n", bi->profile->name);
 	else
 		return sysfs_emit(page, "none\n");
 }
 
-static ssize_t integrity_tag_size_show(struct blk_integrity *bi, char *page)
+static ssize_t tag_size_show(struct device *dev, struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n", bi->tag_size);
 }
 
-static ssize_t integrity_interval_show(struct blk_integrity *bi, char *page)
+static ssize_t protection_interval_bytes_show(struct device *dev,
+					      struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n",
 			  bi->interval_exp ? 1 << bi->interval_exp : 0);
 }
 
-static ssize_t integrity_verify_store(struct blk_integrity *bi,
-				      const char *page, size_t count)
+static ssize_t read_verify_store(struct device *dev, struct device_attribute *attr,
+				 const char *page, size_t count)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
 	char *p = (char *) page;
 	unsigned long val = simple_strtoul(p, &p, 10);
 
@@ -278,14 +285,18 @@ static ssize_t integrity_verify_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_verify_show(struct blk_integrity *bi, char *page)
+static ssize_t read_verify_show(struct device *dev, struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%d\n", (bi->flags & BLK_INTEGRITY_VERIFY) != 0);
 }
 
-static ssize_t integrity_generate_store(struct blk_integrity *bi,
-					const char *page, size_t count)
+static ssize_t write_generate_store(struct device *dev, struct device_attribute *attr,
+				    const char *page, size_t count)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	char *p = (char *) page;
 	unsigned long val = simple_strtoul(p, &p, 10);
 
@@ -297,57 +308,37 @@ static ssize_t integrity_generate_store(struct blk_integrity *bi,
 	return count;
 }
 
-static ssize_t integrity_generate_show(struct blk_integrity *bi, char *page)
+static ssize_t write_generate_show(struct device *dev, struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%d\n", (bi->flags & BLK_INTEGRITY_GENERATE) != 0);
 }
 
-static ssize_t integrity_device_show(struct blk_integrity *bi, char *page)
+static ssize_t device_is_integrity_capable_show(struct device *dev,
+						struct device_attribute *attr, char *page)
 {
+	struct blk_integrity *bi = dev_to_bi(dev);
+
 	return sysfs_emit(page, "%u\n",
 			  (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE) != 0);
 }
 
-static struct integrity_sysfs_entry integrity_format_entry = {
-	.attr = { .name = "format", .mode = 0444 },
-	.show = integrity_format_show,
-};
-
-static struct integrity_sysfs_entry integrity_tag_size_entry = {
-	.attr = { .name = "tag_size", .mode = 0444 },
-	.show = integrity_tag_size_show,
-};
-
-static struct integrity_sysfs_entry integrity_interval_entry = {
-	.attr = { .name = "protection_interval_bytes", .mode = 0444 },
-	.show = integrity_interval_show,
-};
-
-static struct integrity_sysfs_entry integrity_verify_entry = {
-	.attr = { .name = "read_verify", .mode = 0644 },
-	.show = integrity_verify_show,
-	.store = integrity_verify_store,
-};
-
-static struct integrity_sysfs_entry integrity_generate_entry = {
-	.attr = { .name = "write_generate", .mode = 0644 },
-	.show = integrity_generate_show,
-	.store = integrity_generate_store,
-};
-
-static struct integrity_sysfs_entry integrity_device_entry = {
-	.attr = { .name = "device_is_integrity_capable", .mode = 0444 },
-	.show = integrity_device_show,
-};
+static DEVICE_ATTR_RO(format);
+static DEVICE_ATTR_RO(tag_size);
+static DEVICE_ATTR_RO(protection_interval_bytes);
+static DEVICE_ATTR_RW(read_verify);
+static DEVICE_ATTR_RW(write_generate);
+static DEVICE_ATTR_RO(device_is_integrity_capable);
 
 static struct attribute *integrity_attrs[] = {
-	&integrity_format_entry.attr,
-	&integrity_tag_size_entry.attr,
-	&integrity_interval_entry.attr,
-	&integrity_verify_entry.attr,
-	&integrity_generate_entry.attr,
-	&integrity_device_entry.attr,
-	NULL,
+	&dev_attr_format.attr,
+	&dev_attr_tag_size.attr,
+	&dev_attr_protection_interval_bytes.attr,
+	&dev_attr_read_verify.attr,
+	&dev_attr_write_generate.attr,
+	&dev_attr_device_is_integrity_capable.attr,
+	NULL
 };
 ATTRIBUTE_GROUPS(integrity);
 

-- 
2.39.2

