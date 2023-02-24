Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043DF6A2306
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBXUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBXUGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:06:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C366F412
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:06:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ee7so1880281edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30gf0rPstzyMPgRfzhpDZTMYvGIimgy2DAXLAV9LSyo=;
        b=KPOQd8I6f7Hq9/JtY80heHYfMZzze+K0RpW5TVAq0qXt5J7fKlE8Jmu4YayBVlkfJX
         Lg0iGzG13MnMwi8Pkz1d9l9CuY7j3E513tUaRR88dakCsP+uRoTBGWekISJATnEkCwsC
         pUa3XAMepncQIleMMB+wueuGKtQ739ttdR7g+R9cccRvwCgF/BqN3qppZT+T2MOjl1Xo
         GJyIR0us9R345ymUeQD12s9V4hjsFwtoXxniEp8LgGyJfEB2aEWADin+z+/Unuxy8FPe
         ZIu3oymMY7JNyPsDMG0Zm+FfXtamRFHjW5ANioPH/rvoI7WCW7p6acfbbJ+o7NEQMjqL
         nkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30gf0rPstzyMPgRfzhpDZTMYvGIimgy2DAXLAV9LSyo=;
        b=RY4iQInU+Ctr/jIQdO4dur5K16rJ/VFdh61nqFAyXIN3yNc1qYZWm42RkE+oxiPrF5
         Gqa4ctUQ386NqcgkHDkH2DB2XM07hDOIo/+4OW8Z17KaqWk9gh/ENwlPLzLQhh/C+AZr
         l/1I/ftOnaV9pbltZ/MnXv1ugGc2jbXtBJ92FFqU0wQx8HCzH4M0dOxJMDHlSSCmK84c
         qE0+lIbiAMF2haEVaoZQBuztBGOWTRr8kYUapVvBooGp3Slg/nEdSrYfitg//cwzmxXW
         Jnd/jspcOGvfks9rSCbc3np75IwneJXPO1sedhhhjLoVt+3CcVr3PNP3gIZsENUO5wkq
         xflQ==
X-Gm-Message-State: AO0yUKXH/4iHpGhzHvOFr0aI/twG+y5crHuyBTHQuv8ODvrr/UYampK/
        D0/aIm0oEMQ5/AU4Uu/DkF+P7Q==
X-Google-Smtp-Source: AK7set/m71Kz7iT8oau2QaOiGyMPUvQcBpFY/vOV0Nh4ufDbsTpUgC4NIN6pnaNxbqXlpYRqR8tklQ==
X-Received: by 2002:a17:906:4914:b0:88f:9445:f8df with SMTP id b20-20020a170906491400b0088f9445f8dfmr25108688ejq.21.1677269154744;
        Fri, 24 Feb 2023 12:05:54 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id gc20-20020a1709072b1400b008d85435f914sm6194833ejc.98.2023.02.24.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 12:05:54 -0800 (PST)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] block: ublk: enable zoned storage support
Date:   Fri, 24 Feb 2023 21:05:01 +0100
Message-Id: <20230224200502.391570-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add zoned storage support to ublk: report_zones and operations:
 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET

This allows implementation of zoned storage devices in user space. An
example user space implementation based on ubdsrv is available [1].

[1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e680dc718cc1f6d

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
Changes since v1:
 - Fixed conditional compilation bug
 - Refactored to collect conditional code additions together
 - Fixed style errors
 - Zero stack allocated value used for zone report

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@intel.com/
v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metaspace.dk/

 drivers/block/ublk_drv.c      | 150 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  18 ++++
 2 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6368b56eacf1..37e516903867 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -20,6 +20,7 @@
 #include <linux/major.h>
 #include <linux/wait.h>
 #include <linux/blkdev.h>
+#include <linux/blkzoned.h>
 #include <linux/init.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -51,10 +52,12 @@
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
-		| UBLK_F_USER_RECOVERY_REISSUE)
+		| UBLK_F_USER_RECOVERY_REISSUE \
+		| UBLK_F_ZONED)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
+#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD \
+			     | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_rq_data {
 	struct llist_node node;
@@ -187,6 +190,98 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static void ublk_set_nr_zones(struct ublk_device *ub)
+{
+	const struct ublk_param_basic *p = &ub->params.basic;
+
+	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
+		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
+}
+
+static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	if (ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
+		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+	}
+}
+
+static int ublk_revalidate_disk_zones(struct gendisk *disk)
+{
+	return blk_revalidate_disk_zones(disk, NULL);
+}
+
+static int ublk_report_zones(struct gendisk *disk, sector_t sector,
+			     unsigned int nr_zones, report_zones_cb cb,
+			     void *data)
+{
+	struct ublk_device *ub;
+	unsigned int zone_size;
+	unsigned int first_zone;
+	int ret = 0;
+
+	ub = disk->private_data;
+
+	if (!(ub->dev_info.flags & UBLK_F_ZONED))
+		return -EINVAL;
+
+	zone_size = disk->queue->limits.chunk_sectors;
+	first_zone = sector >> ilog2(zone_size);
+	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
+
+	for (unsigned int i = 0; i < nr_zones; i++) {
+		struct request *req;
+		blk_status_t status;
+		struct blk_zone info = {0};
+
+		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
+
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			goto out;
+		}
+
+		req->__sector = sector;
+
+		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
+				      GFP_KERNEL);
+
+		if (ret)
+			goto out;
+
+		status = blk_execute_rq(req, 0);
+		ret = blk_status_to_errno(status);
+		if (ret)
+			goto out;
+
+		blk_mq_free_request(req);
+
+		ret = cb(&info, i, data);
+		if (ret)
+			goto out;
+
+		/* A zero length zone means don't ask for more zones */
+		if (!info.len) {
+			nr_zones = i;
+			break;
+		}
+
+		sector += zone_size;
+	}
+	ret = nr_zones;
+
+ out:
+	return ret;
+}
+#else
+void ublk_set_nr_zones(struct ublk_device *ub);
+void ublk_dev_param_zoned_apply(struct ublk_device *ub);
+int ublk_revalidate_disk_zones(struct gendisk *disk);
+#endif
+
 static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	struct request_queue *q = ub->ub_disk->queue;
@@ -212,6 +307,9 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ublk_set_nr_zones(ub);
 }
 
 static void ublk_dev_param_discard_apply(struct ublk_device *ub)
@@ -268,6 +366,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_TYPE_ZONED))
+		ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -361,9 +462,13 @@ static void ublk_free_disk(struct gendisk *disk)
 	put_device(&ub->cdev_dev);
 }
 
+
 static const struct block_device_operations ub_fops = {
-	.owner =	THIS_MODULE,
-	.free_disk =	ublk_free_disk,
+	.owner = THIS_MODULE,
+	.free_disk = ublk_free_disk,
+#ifdef CONFIG_BLK_DEV_ZONED
+	.report_zones = ublk_report_zones,
+#endif
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -499,7 +604,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (req_op(req) == REQ_OP_READ && ublk_rq_has_data(req)) {
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) && ublk_rq_has_data(req)) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -566,6 +671,26 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	case REQ_OP_WRITE_ZEROES:
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
+#ifdef CONFIG_BLK_DEV_ZONED
+	case REQ_OP_ZONE_OPEN:
+		ublk_op = UBLK_IO_OP_ZONE_OPEN;
+		break;
+	case REQ_OP_ZONE_CLOSE:
+		ublk_op = UBLK_IO_OP_ZONE_CLOSE;
+		break;
+	case REQ_OP_ZONE_FINISH:
+		ublk_op = UBLK_IO_OP_ZONE_FINISH;
+		break;
+	case REQ_OP_ZONE_RESET:
+		ublk_op = UBLK_IO_OP_ZONE_RESET;
+		break;
+	case REQ_OP_DRV_IN:
+		ublk_op = UBLK_IO_OP_DRV_IN;
+		break;
+	case REQ_OP_ZONE_APPEND:
+		/* We do not support zone append yet */
+		fallthrough;
+#endif
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -612,7 +737,8 @@ static void ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN) {
 		blk_mq_end_request(req, BLK_STS_OK);
 		return;
 	}
@@ -1535,6 +1661,15 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	if (ret)
 		goto out_put_disk;
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_zoned(disk, BLK_ZONED_HM);
+		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
+		ret = ublk_revalidate_disk_zones(disk);
+		if (ret)
+			goto out_put_disk;
+	}
+
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
@@ -1673,6 +1808,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ub->dev_info.flags &= ~UBLK_F_ZONED;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 8f88e3a29998..074b97821575 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -78,6 +78,10 @@
 #define UBLK_F_USER_RECOVERY	(1UL << 3)
 
 #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
+/*
+ * Enable zoned device support
+ */
+#define UBLK_F_ZONED (1ULL << 5)
 
 /* device state */
 #define UBLK_S_DEV_DEAD	0
@@ -129,6 +133,12 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_OP_DISCARD	3
 #define		UBLK_IO_OP_WRITE_SAME	4
 #define		UBLK_IO_OP_WRITE_ZEROES	5
+#define		UBLK_IO_OP_ZONE_OPEN		10
+#define		UBLK_IO_OP_ZONE_CLOSE		11
+#define		UBLK_IO_OP_ZONE_FINISH		12
+#define		UBLK_IO_OP_ZONE_APPEND		13
+#define		UBLK_IO_OP_ZONE_RESET		15
+#define		UBLK_IO_OP_DRV_IN		34
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
@@ -214,6 +224,12 @@ struct ublk_param_discard {
 	__u16	reserved0;
 };
 
+struct ublk_param_zoned {
+	__u64	max_open_zones;
+	__u64	max_active_zones;
+	__u64	max_append_size;
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -224,10 +240,12 @@ struct ublk_params {
 	__u32	len;
 #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
+#define UBLK_PARAM_TYPE_ZONED           (1 << 2)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
+	struct ublk_param_zoned		zoned;
 };
 
 #endif

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.39.2

