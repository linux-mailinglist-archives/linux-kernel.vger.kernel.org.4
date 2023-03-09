Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFC6B2E97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCIUYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCIUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:23:57 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6186C61A8E;
        Thu,  9 Mar 2023 12:23:55 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678393432;
        bh=V4DiMXUAlaGpfb/ouDcwZ5s91T1/n4kCKJbIR1SgzHI=;
        h=From:Date:Subject:To:Cc:From;
        b=hlHN4mXUUUBTbBJFqaJF7k+nJCiPDj/Z3QEkvw6FEn9xdqnWK+A2HNT3usVShSIDT
         71P3alBdfZEaxv8ACbID5ASh3W8+GfRbve3rltWGMovSp14my2J8kwyY7ZeugODuYi
         spAOLYdNQCu1RGW+OIQi18JV2fNKLr/HO+iG4vmY=
Date:   Thu, 09 Mar 2023 20:23:41 +0000
Subject: [PATCH] block: don't embed integrity_kobj into gendisk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAExACmQC/x2NUQrCMBAFr1L220CaQkGvIlKS9JmuDVvZtKKU3
 t3o5wyPeTsVKKPQpdlJ8eLCi1RoTw3FyUuC4bEyOes629mzmZfwGBQZvsAkyMhlHlhWJOX1Y+D
 6aENsXe891Uj4zYJ6iVPNyJZzlU/Fnd//1+vtOL7NDnmNhQAAAA==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678393429; l=4201;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=V4DiMXUAlaGpfb/ouDcwZ5s91T1/n4kCKJbIR1SgzHI=;
 b=W6X3J/kXyiZzwSPLstGMD/Bk9b0badxTht4HARLoN7LcMySEjbAfIwmwC95nozbZYhwcI6Tto
 9WqQsHMJNL4AtTbo+NoleObSHXdhGjBpBg73pBPmNyNn+BVAnfgUNds
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A struct kobject is only supposed to be embedded into objects which
lifetime it will manage.
Objects of type struct gendisk however are refcounted by their part0
block_device.
Therefore the integrity_kobj should not be embedded but split into its
own independently managed object.

This will also provide a proper .release function for the ktype which
avoid warnings like the following:
kobject: 'integrity' (000000005198bea8): does not have a release() function, it is broken and must be fixed.

While modifying blk_integrity_del() also drop the explicit call to
kobject_uevent(KOBJ_REMOVE) as the driver care will do this
automatically.

Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/lkml/60b2b66c-22c9-1d38-ed1c-7b7d95e32720@alu.unizg.hr/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c  | 32 ++++++++++++++++++++++++--------
 include/linux/blkdev.h |  2 +-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 8f01d786f5cb..40adf33f5535 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -218,10 +218,15 @@ struct integrity_sysfs_entry {
 	ssize_t (*store)(struct blk_integrity *, const char *, size_t);
 };
 
+static inline struct gendisk *integrity_kobj_to_disk(struct kobject *kobj)
+{
+	return dev_to_disk(kobj_to_dev(kobj->parent));
+}
+
 static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
 				   char *page)
 {
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
+	struct gendisk *disk = integrity_kobj_to_disk(kobj);
 	struct blk_integrity *bi = &disk->queue->integrity;
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
@@ -233,7 +238,7 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 				    struct attribute *attr, const char *page,
 				    size_t count)
 {
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
+	struct gendisk *disk = integrity_kobj_to_disk(kobj);
 	struct blk_integrity *bi = &disk->queue->integrity;
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
@@ -356,9 +361,15 @@ static const struct sysfs_ops integrity_ops = {
 	.store	= &integrity_attr_store,
 };
 
+static void integrity_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct kobj_type integrity_ktype = {
 	.default_groups = integrity_groups,
 	.sysfs_ops	= &integrity_ops,
+	.release        = integrity_release,
 };
 
 static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
@@ -442,16 +453,21 @@ int blk_integrity_add(struct gendisk *disk)
 {
 	int ret;
 
-	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
+	disk->integrity_kobj = kmalloc(sizeof(*disk->integrity_kobj), GFP_KERNEL);
+	if (!disk->integrity_kobj)
+		return -ENOMEM;
+
+	ret = kobject_init_and_add(disk->integrity_kobj, &integrity_ktype,
 				   &disk_to_dev(disk)->kobj, "%s", "integrity");
-	if (!ret)
-		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
+	if (ret)
+		kobject_put(disk->integrity_kobj);
+	else
+		kobject_uevent(disk->integrity_kobj, KOBJ_ADD);
+
 	return ret;
 }
 
 void blk_integrity_del(struct gendisk *disk)
 {
-	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
-	kobject_del(&disk->integrity_kobj);
-	kobject_put(&disk->integrity_kobj);
+	kobject_put(disk->integrity_kobj);
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d1aee08f8c18..2fbfb3277a2b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -164,7 +164,7 @@ struct gendisk {
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct kobject integrity_kobj;
+	struct kobject *integrity_kobj;
 #endif	/* CONFIG_BLK_DEV_INTEGRITY */
 
 #ifdef CONFIG_BLK_DEV_ZONED

---
base-commit: 44889ba56cbb3d51154660ccd15818bc77276696
change-id: 20230309-kobj_release-gendisk_integrity-e26c0bc126aa

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

