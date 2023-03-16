Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76756BD2C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCPOzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCPOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:55:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9FC48B5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:55:46 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z21so8813727edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1678978545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8vZoXbqek/3Iu5KJTr0xORJ990KMNEeK5gBRiw2Dns=;
        b=1LIXEiDpvlruioKn549DZmluoetlzwpvWiPzMqdX7Lu+35spzUrbehTkx/XZTRBcfD
         VyJRnA56Kxr4WPe2v1zS//YTPZBcvBlb5aJ77adPwHfDhSH6LHQ1SJkm09TpSVskonn6
         A6jXF/UrAi1fDANZLUFUvGvTgBmhlNMJG0bF2vytRMB40x6ddW0BqlHBG3YkUJYudt2T
         pNsnY6nO14A5r0hDqcbxIQXZ5A6YA+MBsX0BPLq/Zn1ghKjdVySw1cxmv/5duoUAsotV
         s/aXSRTHdMDaGTSZIDGlm7wStUWXVjVlcQVISj2ZFBhK0jNAnFEyFMUYI8x2nr6Qety1
         YQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8vZoXbqek/3Iu5KJTr0xORJ990KMNEeK5gBRiw2Dns=;
        b=EYuNrgVWnArqg05xhjkjcNpVnKTrkxgTmDpFI3P22c9SP22riLsnnZPPHlBjyLO64H
         9lw/KrrBYD8Q/vyKbGJ2AP2bxa/l14tRDsy4v4WZTKBNqCkrsbAVAJwtmgf/dEjg3wkU
         kNLsMvW57p4V90Jh6rYN+HPC4waQXKIvpHLPnipZGJ2jyVOLpdTo/KatJm+7jMGsao/T
         qFwpv20e/UWckjHIf60SSozq5ybSESDAMWSib0w8JPHH+XxZ4cEeOOX7682g82u5j2e/
         gKZ4+FVUYMz0bLgLQubl3j1JY0kVNEZXaBiYTi6QHsmmwssNfM8XxRSMuiNUfmnP1AIg
         B30w==
X-Gm-Message-State: AO0yUKXd/ZSnVqoR20SpxmkaKWSZyx5Lh2trgQWCnXVIHENhs1oLxMUP
        TE3cJFHLkmUQVmoTuO+beX9FQw==
X-Google-Smtp-Source: AK7set9hpr2t2sZ0vgvCTecqzsiQpWPQ5WYUZzKI7aOC3KtS6Zmp8DiGc41J2lh+3lhbm419s/vM1g==
X-Received: by 2002:a05:6402:b35:b0:4ac:bbaa:867a with SMTP id bo21-20020a0564020b3500b004acbbaa867amr6344946edb.24.1678978545122;
        Thu, 16 Mar 2023 07:55:45 -0700 (PDT)
Received: from localhost ([194.62.217.1])
        by smtp.gmail.com with ESMTPSA id b27-20020a50ccdb000000b004ad601533a3sm4011035edj.55.2023.03.16.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:55:44 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     linux-block@vger.kernel.org
Cc:     Andreas Hindborg <a.hindborg@samsung.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] block: ublk: enable zoned storage support
Date:   Thu, 16 Mar 2023 15:55:38 +0100
Message-Id: <20230316145539.300523-1-nmi@metaspace.dk>
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

From: Andreas Hindborg <a.hindborg@samsung.com>

Add zoned storage support to ublk: report_zones and operations:
 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET

This allows implementation of zoned storage devices in user space. An
example user space implementation based on ubdsrv is available [1].

[1] https://github.com/metaspace/ubdsrv/commit/2c60b9ffdfb7cb44c5cce0272bb52229ea6c95d4

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---

Changes since v2:
 - Allow reporting of multiple zones in a single request
 - Move zoned functions to separate translation unit
 - Do not overload REQ_OP_DRV_IN for zone report
 - Reserve space in ublk_param_zoned for future parameters
 - Do not overload (struct request).__sector and .__data_len
 - Remove unnecessary conditional compilation 
 - Remove goto statements in ublk_report_zones

v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metaspace.dk/
v2: https://lore.kernel.org/all/20230224200502.391570-1-nmi@metaspace.dk/

 drivers/block/Kconfig          |   4 +
 drivers/block/Makefile         |   1 +
 drivers/block/ublk_drv-zoned.c | 142 +++++++++++++++++++++++++++++++++
 drivers/block/ublk_drv.c       | 113 ++++++++++++++------------
 drivers/block/ublk_drv.h       |  69 ++++++++++++++++
 include/uapi/linux/ublk_cmd.h  |  37 +++++++--
 6 files changed, 308 insertions(+), 58 deletions(-)
 create mode 100644 drivers/block/ublk_drv-zoned.c
 create mode 100644 drivers/block/ublk_drv.h

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index f79f20430ef7..311e401eece5 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -385,6 +385,10 @@ config BLK_DEV_UBLK
 	  can handle batch more effectively, but task_work_add() isn't exported
 	  for module, so ublk has to be built to kernel.
 
+config BLK_DEV_UBLK_ZONED
+	def_bool y
+	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..0de9379ba9df 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -38,5 +38,6 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
+obj-$(CONFIG_BLK_DEV_UBLK_ZONED)		+= ublk_drv-zoned.o
 
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zoned.c
new file mode 100644
index 000000000000..fbcbe1bbf653
--- /dev/null
+++ b/drivers/block/ublk_drv-zoned.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
+ */
+#include <linux/blkzoned.h>
+#include <linux/ublk_cmd.h>
+#include "ublk_drv.h"
+
+void ublk_set_nr_zones(struct ublk_device *ub)
+{
+	const struct ublk_param_basic *p = &ub->params.basic;
+
+	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
+		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
+}
+
+void ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	if (ub->dev_info.flags & UBLK_F_ZONED) {
+		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
+		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+	}
+}
+
+int ublk_revalidate_disk_zones(struct gendisk *disk)
+{
+	return blk_revalidate_disk_zones(disk, NULL);
+}
+
+// Based on virtblk_alloc_report_buffer
+static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
+				      unsigned int nr_zones,
+				      unsigned int zone_sectors, size_t *buflen)
+{
+	struct request_queue *q = ublk->ub_disk->queue;
+	size_t bufsize;
+	void *buf;
+
+	nr_zones = min_t(unsigned int, nr_zones,
+			 get_capacity(ublk->ub_disk) >> ilog2(zone_sectors));
+
+	bufsize = nr_zones * sizeof(struct blk_zone);
+	bufsize =
+		min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
+	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
+
+	while (bufsize >= sizeof(struct blk_zone)) {
+		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
+		if (buf) {
+			*buflen = bufsize;
+			return buf;
+		}
+		bufsize >>= 1;
+	}
+
+	bufsize = 0;
+	return NULL;
+}
+
+int ublk_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb, void *data)
+{
+	unsigned int done_zones = 0;
+	struct ublk_device *ub = disk->private_data;
+	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
+	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
+	struct blk_zone *buffer;
+	size_t buffer_length;
+	unsigned int max_zones_per_request;
+
+	if (!(ub->dev_info.flags & UBLK_F_ZONED))
+		return -EOPNOTSUPP;
+
+	nr_zones = min_t(unsigned int, ub->ub_disk->nr_zones - first_zone,
+			 nr_zones);
+
+	buffer = ublk_alloc_report_buffer(ub, nr_zones, zone_size_sectors,
+					  &buffer_length);
+	if (!buffer)
+		return -ENOMEM;
+
+	max_zones_per_request = buffer_length / sizeof(struct blk_zone);
+
+	while (done_zones < nr_zones) {
+		unsigned int remaining_zones = nr_zones - done_zones;
+		unsigned int zones_in_request = min_t(
+			unsigned int, remaining_zones, max_zones_per_request);
+		int err = 0;
+		struct request *req;
+		struct ublk_rq_data *pdu;
+		blk_status_t status;
+
+		memset(buffer, 0, buffer_length);
+
+		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
+		if (IS_ERR(req))
+			return PTR_ERR(req);
+
+		pdu = blk_mq_rq_to_pdu(req);
+		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
+		pdu->sector = sector;
+		pdu->nr_sectors = remaining_zones * zone_size_sectors;
+
+		err = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
+					GFP_KERNEL);
+		if (err) {
+			blk_mq_free_request(req);
+			kvfree(buffer);
+			return err;
+		}
+
+		status = blk_execute_rq(req, 0);
+		err = blk_status_to_errno(status);
+		blk_mq_free_request(req);
+		if (err) {
+			kvfree(buffer);
+			return err;
+		}
+
+		for (unsigned int i = 0; i < zones_in_request; i++) {
+			struct blk_zone *zone = buffer + i;
+
+			err = cb(zone, i, data);
+			if (err)
+				return err;
+
+			done_zones++;
+			sector += zone_size_sectors;
+
+			/* A zero length zone means don't ask for more zones */
+			if (!zone->len) {
+				kvfree(buffer);
+				return done_zones;
+			}
+		}
+	}
+
+	kvfree(buffer);
+	return done_zones;
+}
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index d1d1c8d606c8..69a3e7dedfc0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -44,6 +44,7 @@
 #include <linux/task_work.h>
 #include <linux/namei.h>
 #include <uapi/linux/ublk_cmd.h>
+#include "ublk_drv.h"
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
@@ -53,16 +54,13 @@
 		| UBLK_F_NEED_GET_DATA \
 		| UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
-		| UBLK_F_UNPRIVILEGED_DEV)
+		| UBLK_F_UNPRIVILEGED_DEV \
+		| UBLK_F_ZONED)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
-		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
-
-struct ublk_rq_data {
-	struct llist_node node;
-	struct callback_head work;
-};
+#define UBLK_PARAM_TYPE_ALL                                \
+	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
@@ -135,45 +133,6 @@ struct ublk_queue {
 
 #define UBLK_DAEMON_MONITOR_PERIOD	(5 * HZ)
 
-struct ublk_device {
-	struct gendisk		*ub_disk;
-
-	char	*__queues;
-
-	unsigned int	queue_size;
-	struct ublksrv_ctrl_dev_info	dev_info;
-
-	struct blk_mq_tag_set	tag_set;
-
-	struct cdev		cdev;
-	struct device		cdev_dev;
-
-#define UB_STATE_OPEN		0
-#define UB_STATE_USED		1
-#define UB_STATE_DELETED	2
-	unsigned long		state;
-	int			ub_number;
-
-	struct mutex		mutex;
-
-	spinlock_t		mm_lock;
-	struct mm_struct	*mm;
-
-	struct ublk_params	params;
-
-	struct completion	completion;
-	unsigned int		nr_queues_ready;
-	unsigned int		nr_privileged_daemon;
-
-	/*
-	 * Our ubq->daemon may be killed without any notification, so
-	 * monitor each queue's daemon periodically
-	 */
-	struct delayed_work	monitor_work;
-	struct work_struct	quiesce_work;
-	struct work_struct	stop_work;
-};
-
 /* header of ublk_params */
 struct ublk_params_header {
 	__u32	len;
@@ -225,6 +184,9 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ublk_set_nr_zones(ub);
 }
 
 static void ublk_dev_param_discard_apply(struct ublk_device *ub)
@@ -285,6 +247,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_TYPE_ZONED))
+		ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -420,9 +385,10 @@ static int ublk_open(struct block_device *bdev, fmode_t mode)
 }
 
 static const struct block_device_operations ub_fops = {
-	.owner =	THIS_MODULE,
-	.open =		ublk_open,
-	.free_disk =	ublk_free_disk,
+	.owner = THIS_MODULE,
+	.open = ublk_open,
+	.free_disk = ublk_free_disk,
+	.report_zones = ublk_report_zones,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -558,7 +524,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (req_op(req) == REQ_OP_READ && ublk_rq_has_data(req)) {
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) && ublk_rq_has_data(req)) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -607,6 +573,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
+	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -625,6 +592,35 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 	case REQ_OP_WRITE_ZEROES:
 		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
 		break;
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
+	case REQ_OP_DRV_OUT:
+		ublk_op = pdu->operation;
+		switch (ublk_op) {
+		case UBLK_IO_OP_REPORT_ZONES:
+			iod->op_flags = ublk_op | ublk_req_build_flags(req);
+			iod->nr_sectors = pdu->nr_sectors;
+			iod->start_sector = pdu->sector;
+			iod->addr = io->addr;
+			return BLK_STS_OK;
+		default:
+			return BLK_STS_IOERR;
+		}
+	case REQ_OP_ZONE_APPEND:
+	case REQ_OP_ZONE_RESET_ALL:
+		/* We do not support zone append or reset_all yet */
+		fallthrough;
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -671,7 +667,8 @@ static void ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN) {
 		blk_mq_end_request(req, BLK_STS_OK);
 		return;
 	}
@@ -1601,6 +1598,15 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
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
@@ -1746,6 +1752,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
 		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ub->dev_info.flags &= ~UBLK_F_ZONED;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
new file mode 100644
index 000000000000..7b21235d7673
--- /dev/null
+++ b/drivers/block/ublk_drv.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _UBLK_DRV_H
+#define _UBLK_DRV_H
+
+#include <uapi/linux/ublk_cmd.h>
+#include <linux/blk-mq.h>
+#include <linux/cdev.h>
+
+struct ublk_device {
+	struct gendisk *ub_disk;
+
+	char *__queues;
+
+	unsigned int queue_size;
+	struct ublksrv_ctrl_dev_info dev_info;
+
+	struct blk_mq_tag_set tag_set;
+
+	struct cdev cdev;
+	struct device cdev_dev;
+
+#define UB_STATE_OPEN 0
+#define UB_STATE_USED 1
+#define UB_STATE_DELETED 2
+	unsigned long state;
+	int ub_number;
+
+	struct mutex mutex;
+
+	spinlock_t mm_lock;
+	struct mm_struct *mm;
+
+	struct ublk_params params;
+
+	struct completion completion;
+	unsigned int nr_queues_ready;
+	unsigned int nr_privileged_daemon;
+
+	/*
+	 * Our ubq->daemon may be killed without any notification, so
+	 * monitor each queue's daemon periodically
+	 */
+	struct delayed_work monitor_work;
+	struct work_struct quiesce_work;
+	struct work_struct stop_work;
+};
+
+struct ublk_rq_data {
+	struct llist_node node;
+	struct callback_head work;
+	enum ublk_op operation;
+	__u64 sector;
+	__u32 nr_sectors;
+};
+
+void ublk_set_nr_zones(struct ublk_device *ub);
+void ublk_dev_param_zoned_apply(struct ublk_device *ub);
+int ublk_revalidate_disk_zones(struct gendisk *disk);
+
+#ifdef CONFIG_BLK_DEV_UBLK_ZONED
+int ublk_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb,
+		      void *data);
+#else
+#define ublk_report_zones NULL
+#endif
+
+#endif
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index f6238ccc7800..a9c3e71b0756 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -102,6 +102,11 @@
  */
 #define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
 
+/*
+ * Enable zoned device support
+ */
+#define UBLK_F_ZONED (1ULL << 6)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -155,12 +160,24 @@ struct ublksrv_ctrl_dev_info {
 	__u64   reserved2;
 };
 
-#define		UBLK_IO_OP_READ		0
-#define		UBLK_IO_OP_WRITE		1
-#define		UBLK_IO_OP_FLUSH		2
-#define		UBLK_IO_OP_DISCARD	3
-#define		UBLK_IO_OP_WRITE_SAME	4
-#define		UBLK_IO_OP_WRITE_ZEROES	5
+enum ublk_op {
+	UBLK_IO_OP_READ = 0,
+	UBLK_IO_OP_WRITE = 1,
+	UBLK_IO_OP_FLUSH = 2,
+	UBLK_IO_OP_DISCARD = 3,
+	UBLK_IO_OP_WRITE_SAME = 4,
+	UBLK_IO_OP_WRITE_ZEROES = 5,
+	UBLK_IO_OP_ZONE_OPEN = 10,
+	UBLK_IO_OP_ZONE_CLOSE = 11,
+	UBLK_IO_OP_ZONE_FINISH = 12,
+	UBLK_IO_OP_ZONE_APPEND = 13,
+	UBLK_IO_OP_ZONE_RESET = 15,
+	__UBLK_IO_OP_DRV_IN_START = 32,
+	UBLK_IO_OP_REPORT_ZONES = __UBLK_IO_OP_DRV_IN_START,
+	__UBLK_IO_OP_DRV_IN_END = 96,
+	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
+	__UBLK_IO_OP_DRV_OUT_END = 160,
+};
 
 #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
 #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
@@ -257,6 +274,12 @@ struct ublk_param_devt {
 	__u32   disk_minor;
 };
 
+struct ublk_param_zoned {
+	__u32	max_open_zones;
+	__u32	max_active_zones;
+	__u8	reserved[24];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -268,11 +291,13 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_BASIC           (1 << 0)
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
+#define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
+	struct ublk_param_zoned	zoned;
 };
 
 #endif

base-commit: eeac8ede17557680855031c6f305ece2378af326
-- 
2.39.2

