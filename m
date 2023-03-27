Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9306CA7D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjC0OiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjC0OiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:38:10 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7462D3C2F;
        Mon, 27 Mar 2023 07:38:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d22so5280906pgw.2;
        Mon, 27 Mar 2023 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679927886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N726YLpoNB5RGdOtvvZkB0nJn1KgXTZQIHiRPAmj7CQ=;
        b=htFUjOyKs+DmGnkMkAkMAvbjZw0FMXO4Hie41OEIl1c8PTpsuEkvJu/Y4yCeq6COAZ
         kIZYvs3MLJht5AbE+Yp2N0aMKPC6ktAkNxRztGR5NdyIola8nQzft+Yzk4WFvU0xhQoT
         0+tjLETt1F+EHATjpxcxRtioxDgcVE30AgMIFDp9eJM0xFWMiDNsJyrTdZlr1R63iWEv
         xRy3pEFHnhwB2x/SGgeDVkIi1K8sf6si/tYzI10K9wL98BwfyZFR8CCIX05q/slBsgbo
         cMTeVCrVo2VBWf3Awmc/3Z7ejRoJrGKLVidZlO4H0tU89H0/GvvnraGszgFu72/YiCqb
         UtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N726YLpoNB5RGdOtvvZkB0nJn1KgXTZQIHiRPAmj7CQ=;
        b=VydTy+cPg7kkBT/bjTjKSaoUUdJmqcZMS3KRBkCf0LdoPYk4pTDsRQ7oXpL0XYK3FY
         MhIYmL0a4TaaVOoa6+ledTM2dAX3+uUng7iF8jzraLA38hCdHxzR9EX+ScCr+EQ6KVgk
         jXXO5ofSXizt2+VV2cwYtyCt0zz62L3/t9Idug2E38keCYbswnVpk/Zcrpog6kgAZJZC
         tC36g8czuiRa0grti9wS46kSIt4V8UlEA5vRi9jLNm+xU0LMaptcnB42TUVOJQXDTSlv
         fwxbFFGEBw9UWoxP4WZQKiB+ufzTshuinsyidTgldEfk/Z853jxqN+77aueyiuvQol0z
         iViQ==
X-Gm-Message-State: AAQBX9d+3OnuJeGMJD+eTTM+L+Rh9PgiNJo/L04ph/L8Xxi7LSxPcmCj
        XBe4OHRdSLaGOo+RNZz+nnYrZ8vEjn0=
X-Google-Smtp-Source: AKy350ab+oujHAeza7+yePjgjm9xllRsouqtXt5Ko6OpJHGEym9ETzYHlxb7UysfMq50gAzNFhQX/Q==
X-Received: by 2002:a62:1b85:0:b0:627:ecd4:84a5 with SMTP id b127-20020a621b85000000b00627ecd484a5mr10886102pfb.14.1679927886213;
        Mon, 27 Mar 2023 07:38:06 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:b47c:3979:4a3b:2b03])
        by smtp.gmail.com with ESMTPSA id u16-20020aa78490000000b00627df85cd72sm17204404pfn.199.2023.03.27.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:38:05 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk
Cc:     Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 2/2] block: null_blk: make fault-injection dynamically configurable per device
Date:   Mon, 27 Mar 2023 23:37:33 +0900
Message-Id: <20230327143733.14599-3-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230327143733.14599-1-akinobu.mita@gmail.com>
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The null_blk driver has multiple driver-specific fault injection
mechanisms.  Each fault injection configuration can only be specified by a
module parameter and cannot be reconfigured without reloading the driver.
Also, each configuration is common to all devices and is initialized every
time a new device is added.

This change adds the following subdirectories for each null_blk device.

/sys/kernel/config/nullb/<disk>/timeout_inject
/sys/kernel/config/nullb/<disk>/requeue_inject
/sys/kernel/config/nullb/<disk>/init_hctx_fault_inject

Each fault injection attribute can be dynamically set per device by a
corresponding file in these directories.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 .../fault-injection/fault-injection.rst       |  8 ++
 drivers/block/null_blk/Kconfig                |  2 +-
 drivers/block/null_blk/main.c                 | 93 ++++++++++++++-----
 drivers/block/null_blk/null_blk.h             |  7 +-
 4 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 08e420e10973..b64809514b0f 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -52,6 +52,14 @@ Available fault injection capabilities
   status code is NVME_SC_INVALID_OPCODE with no retry. The status code and
   retry flag can be set via the debugfs.
 
+- Null test block driver fault injection
+
+  inject IO timeouts by setting config items under
+  /sys/kernel/config/nullb/<disk>/timeout_inject,
+  inject requeue requests by setting config items under
+  /sys/kernel/config/nullb/<disk>/requeue_inject, and
+  inject init_hctx() errors by setting config items under
+  /sys/kernel/config/nullb/<disk>/init_hctx_fault_inject.
 
 Configure fault-injection capabilities behavior
 -----------------------------------------------
diff --git a/drivers/block/null_blk/Kconfig b/drivers/block/null_blk/Kconfig
index 6bf1f8ca20a2..ff23bb9346d0 100644
--- a/drivers/block/null_blk/Kconfig
+++ b/drivers/block/null_blk/Kconfig
@@ -9,4 +9,4 @@ config BLK_DEV_NULL_BLK
 
 config BLK_DEV_NULL_BLK_FAULT_INJECTION
 	bool "Support fault injection for Null test block driver"
-	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION
+	depends on BLK_DEV_NULL_BLK && FAULT_INJECTION_CONFIGFS
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e6b032c8ecc..fd3a9cf2ea92 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -250,7 +250,7 @@ static void null_free_device_storage(struct nullb_device *dev, bool is_cache);
 
 static inline struct nullb_device *to_nullb_device(struct config_item *item)
 {
-	return item ? container_of(item, struct nullb_device, item) : NULL;
+	return item ? container_of(to_config_group(item), struct nullb_device, group) : NULL;
 }
 
 static inline ssize_t nullb_device_uint_attr_show(unsigned int val, char *page)
@@ -593,8 +593,29 @@ static const struct config_item_type nullb_device_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+
+static void nullb_add_fault_config(struct nullb_device *dev)
+{
+	fault_config_init(&dev->timeout_config, "timeout_inject");
+	fault_config_init(&dev->requeue_config, "requeue_inject");
+	fault_config_init(&dev->init_hctx_fault_config, "init_hctx_fault_inject");
+
+	configfs_add_default_group(&dev->timeout_config.group, &dev->group);
+	configfs_add_default_group(&dev->requeue_config.group, &dev->group);
+	configfs_add_default_group(&dev->init_hctx_fault_config.group, &dev->group);
+}
+
+#else
+
+static void nullb_add_fault_config(struct nullb_device *dev)
+{
+}
+
+#endif
+
 static struct
-config_item *nullb_group_make_item(struct config_group *group, const char *name)
+config_group *nullb_group_make_group(struct config_group *group, const char *name)
 {
 	struct nullb_device *dev;
 
@@ -605,9 +626,10 @@ config_item *nullb_group_make_item(struct config_group *group, const char *name)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	config_item_init_type_name(&dev->item, name, &nullb_device_type);
+	config_group_init_type_name(&dev->group, name, &nullb_device_type);
+	nullb_add_fault_config(dev);
 
-	return &dev->item;
+	return &dev->group;
 }
 
 static void
@@ -645,7 +667,7 @@ static struct configfs_attribute *nullb_group_attrs[] = {
 };
 
 static struct configfs_group_operations nullb_group_ops = {
-	.make_item	= nullb_group_make_item,
+	.make_group	= nullb_group_make_group,
 	.drop_item	= nullb_group_drop_item,
 };
 
@@ -676,6 +698,13 @@ static struct nullb_device *null_alloc_dev(void)
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
+
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+	dev->timeout_config.attr = null_timeout_attr;
+	dev->requeue_config.attr = null_requeue_attr;
+	dev->init_hctx_fault_config.attr = null_init_hctx_attr;
+#endif
+
 	INIT_RADIX_TREE(&dev->data, GFP_ATOMIC);
 	INIT_RADIX_TREE(&dev->cache, GFP_ATOMIC);
 	if (badblocks_init(&dev->badblocks, 0)) {
@@ -1529,24 +1558,48 @@ static void null_submit_bio(struct bio *bio)
 	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
 }
 
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+
+static bool should_timeout_request(struct request *rq)
+{
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct nullb_device *dev = cmd->nq->dev;
+
+	return should_fail(&dev->timeout_config.attr, 1);
+}
+
+static bool should_requeue_request(struct request *rq)
+{
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+	struct nullb_device *dev = cmd->nq->dev;
+
+	return should_fail(&dev->requeue_config.attr, 1);
+}
+
+static bool should_init_hctx_fail(struct nullb_device *dev)
+{
+	return should_fail(&dev->init_hctx_fault_config.attr, 1);
+}
+
+#else
+
 static bool should_timeout_request(struct request *rq)
 {
-#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
-	if (g_timeout_str[0])
-		return should_fail(&null_timeout_attr, 1);
-#endif
 	return false;
 }
 
 static bool should_requeue_request(struct request *rq)
 {
-#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
-	if (g_requeue_str[0])
-		return should_fail(&null_requeue_attr, 1);
-#endif
 	return false;
 }
 
+static bool should_init_hctx_fail(struct nullb_device *dev)
+{
+	return false;
+}
+
+#endif
+
 static void null_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nullb *nullb = set->driver_data;
@@ -1743,10 +1796,8 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 	struct nullb *nullb = hctx->queue->queuedata;
 	struct nullb_queue *nq;
 
-#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
-	if (g_init_hctx_str[0] && should_fail(&null_init_hctx_attr, 1))
+	if (should_init_hctx_fail(nullb->dev))
 		return -EFAULT;
-#endif
 
 	nq = &nullb->queues[hctx_idx];
 	hctx->driver_data = nq;
@@ -2066,9 +2117,6 @@ static int null_add_dev(struct nullb_device *dev)
 		if (rv)
 			goto out_cleanup_queues;
 
-		if (!null_setup_fault())
-			goto out_cleanup_tags;
-
 		nullb->tag_set->timeout = 5 * HZ;
 		nullb->disk = blk_mq_alloc_disk(nullb->tag_set, nullb);
 		if (IS_ERR(nullb->disk)) {
@@ -2130,10 +2178,10 @@ static int null_add_dev(struct nullb_device *dev)
 
 	null_config_discard(nullb);
 
-	if (config_item_name(&dev->item)) {
+	if (config_item_name(&dev->group.cg_item)) {
 		/* Use configfs dir name as the device name */
 		snprintf(nullb->disk_name, sizeof(nullb->disk_name),
-			 "%s", config_item_name(&dev->item));
+			 "%s", config_item_name(&dev->group.cg_item));
 	} else {
 		sprintf(nullb->disk_name, "nullb%d", nullb->index);
 	}
@@ -2233,6 +2281,9 @@ static int __init null_init(void)
 		g_home_node = NUMA_NO_NODE;
 	}
 
+	if (!null_setup_fault())
+		return -EINVAL;
+
 	if (g_queue_mode == NULL_Q_RQ) {
 		pr_err("legacy IO path is no longer available\n");
 		return -EINVAL;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index eb5972c50be8..929f659dd255 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -69,7 +69,12 @@ enum {
 
 struct nullb_device {
 	struct nullb *nullb;
-	struct config_item item;
+	struct config_group group;
+#ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
+	struct fault_config timeout_config;
+	struct fault_config requeue_config;
+	struct fault_config init_hctx_fault_config;
+#endif
 	struct radix_tree_root data; /* data stored in the disk */
 	struct radix_tree_root cache; /* disk cache data */
 	unsigned long flags; /* device flags */
-- 
2.34.1

