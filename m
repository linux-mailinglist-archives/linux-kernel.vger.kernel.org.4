Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E06BFBEA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCRRgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCRRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:36:41 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4F32CCC;
        Sat, 18 Mar 2023 10:36:34 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679160992;
        bh=Xz3A71Xt+usyZIbojziGhRFnHUkQe6YfrFKvdDZ19dg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jXPtwAxwMMwwP6K+ga/8tz18pVPeNxGGMBIWsAs2YaZJ/ZmKXdSZbAraqmFoSD2BD
         UE9YjJBnMzATdi4Nui9UvcLUcyKAjoBBd5CfVaEtVGYCRP/YFJBya51YibEw4RRZCU
         LgbHbZOpNHkiwI1KN8Sc3cdgoTdtwvhaTqqI65Jw=
Date:   Sat, 18 Mar 2023 17:36:25 +0000
Subject: [PATCH v3 3/3] blk-integrity: register sysfs attributes on struct
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230309-kobj_release-gendisk_integrity-v3-3-ceccb4493c46@weissschuh.net>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679160989; l=6072;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xz3A71Xt+usyZIbojziGhRFnHUkQe6YfrFKvdDZ19dg=;
 b=2U3O7ocMYoeaeihuqJWefsHccVSxbvUqWMscIYKs5VQpG/9Xji88guNw1K7fmxChCkDUm0fG6
 4f/rGktRrV5AXbm2wG7H0Ql1KG2GXgNuxKitjh19AIe+AGjw6E7Cs7e
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

The "integrity" kobject only acted as a holder for static sysfs entries.
It also was embedded into struct gendisk without managing it, violating
assumptions of the driver core.

Instead register the sysfs entries directly onto the struct device.

Also drop the now unused member integrity_kobj from struct gendisk.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 block/blk-integrity.c  | 55 +++-----------------------------------------------
 block/blk.h            | 10 +--------
 block/genhd.c          | 12 ++++-------
 include/linux/blkdev.h |  3 ---
 4 files changed, 8 insertions(+), 72 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 1cbfdea88c72..d4e9b4556d14 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -212,31 +212,6 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 	return true;
 }
 
-static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
-				   char *page)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-
-	return dev_attr->show(dev, dev_attr, page);
-}
-
-static ssize_t integrity_attr_store(struct kobject *kobj,
-				    struct attribute *attr, const char *page,
-				    size_t count)
-{
-	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
-	struct device *dev = disk_to_dev(disk);
-	struct device_attribute *dev_attr =
-		container_of(attr, struct device_attribute, attr);
-
-	if (!dev_attr->store)
-		return 0;
-	return dev_attr->store(dev, dev_attr, page, count);
-}
-
 static inline struct blk_integrity *dev_to_bi(struct device *dev)
 {
 	return &dev_to_disk(dev)->queue->integrity;
@@ -345,16 +320,10 @@ static struct attribute *integrity_attrs[] = {
 	&dev_attr_device_is_integrity_capable.attr,
 	NULL
 };
-ATTRIBUTE_GROUPS(integrity);
 
-static const struct sysfs_ops integrity_ops = {
-	.show	= &integrity_attr_show,
-	.store	= &integrity_attr_store,
-};
-
-static const struct kobj_type integrity_ktype = {
-	.default_groups = integrity_groups,
-	.sysfs_ops	= &integrity_ops,
+const struct attribute_group blk_integrity_attr_group = {
+	.name = "integrity",
+	.attrs = integrity_attrs,
 };
 
 static blk_status_t blk_integrity_nop_fn(struct blk_integrity_iter *iter)
@@ -433,21 +402,3 @@ void blk_integrity_unregister(struct gendisk *disk)
 	memset(bi, 0, sizeof(*bi));
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
-
-int blk_integrity_add(struct gendisk *disk)
-{
-	int ret;
-
-	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
-				   &disk_to_dev(disk)->kobj, "%s", "integrity");
-	if (!ret)
-		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
-	return ret;
-}
-
-void blk_integrity_del(struct gendisk *disk)
-{
-	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
-	kobject_del(&disk->integrity_kobj);
-	kobject_put(&disk->integrity_kobj);
-}
diff --git a/block/blk.h b/block/blk.h
index cc4e8873dfde..4859290b04a2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -214,8 +214,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
 				bip_next->bip_vec[0].bv_offset);
 }
 
-int blk_integrity_add(struct gendisk *disk);
-void blk_integrity_del(struct gendisk *);
+extern const struct attribute_group blk_integrity_attr_group;
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline bool blk_integrity_merge_rq(struct request_queue *rq,
 		struct request *r1, struct request *r2)
@@ -248,13 +247,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 static inline void bio_integrity_free(struct bio *bio)
 {
 }
-static inline int blk_integrity_add(struct gendisk *disk)
-{
-	return 0;
-}
-static inline void blk_integrity_del(struct gendisk *disk)
-{
-}
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
 unsigned long blk_rq_timeout(unsigned long timeout);
diff --git a/block/genhd.c b/block/genhd.c
index 02d9cfb9e077..7348c4408453 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -480,15 +480,11 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
-	ret = blk_integrity_add(disk);
-	if (ret)
-		goto out_del_block_link;
-
 	disk->part0->bd_holder_dir =
 		kobject_create_and_add("holders", &ddev->kobj);
 	if (!disk->part0->bd_holder_dir) {
 		ret = -ENOMEM;
-		goto out_del_integrity;
+		goto out_del_block_link;
 	}
 	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
 	if (!disk->slave_dir) {
@@ -551,8 +547,6 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	disk->slave_dir = NULL;
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
-out_del_integrity:
-	blk_integrity_del(disk);
 out_del_block_link:
 	if (!sysfs_deprecated)
 		sysfs_remove_link(block_depr, dev_name(ddev));
@@ -615,7 +609,6 @@ void del_gendisk(struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk_live(disk) && !(disk->flags & GENHD_FL_HIDDEN)))
 		return;
 
-	blk_integrity_del(disk);
 	disk_del_events(disk);
 
 	mutex_lock(&disk->open_mutex);
@@ -1152,6 +1145,9 @@ static const struct attribute_group *disk_attr_groups[] = {
 	&disk_attr_group,
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	&blk_trace_attr_group,
+#endif
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	&blk_integrity_attr_group,
 #endif
 	NULL
 };
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..cc2b9e110728 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -163,9 +163,6 @@ struct gendisk {
 	struct timer_rand_state *random;
 	atomic_t sync_io;		/* RAID */
 	struct disk_events *ev;
-#ifdef  CONFIG_BLK_DEV_INTEGRITY
-	struct kobject integrity_kobj;
-#endif	/* CONFIG_BLK_DEV_INTEGRITY */
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*

-- 
2.40.0

