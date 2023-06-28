Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8753D7418A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjF1THV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjF1THA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:07:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C6213D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991f956fb5aso18171866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979216; x=1690571216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pg7qlCroyjqfExyu0Mf7wmo/LFcyzu8Rds2rnmf83TY=;
        b=vVn82u2esZzVa5ZwtSPC/bCJhdLMHBQdCVjMNWzggQ9tMXOBCnrEC1XcWzz+Zxo0LC
         TicovbfO2FpRpQXUaNDTNLavQ0REUkhMu3JxyKfHC61baP4wPnHlXRGDfP6IuA7+4OK5
         D2Xrc/CmCPUhXEnfZV/LaumLhogYf/JLuK1KxhqZHbC4Pkc+wtThCGdnu+8uXh0ZLK4s
         NIqgElyqPwWu15FeXtNwGwFTWSRYETXDlvSzTZw2VuHX5FjkRGtCnKXqtacRIw2KqtVX
         Xe2gv4B52yt9LqcGPxLYNlmwmZm7SJA7P07avT36HYpSZucRL+RwuWjpO5eK4rG+GbPH
         dLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979216; x=1690571216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pg7qlCroyjqfExyu0Mf7wmo/LFcyzu8Rds2rnmf83TY=;
        b=NaQ1AmR5D0kzB7Xd0SlPnKhV1Bc3dSvVx+VONilpe0iVq0txDz1xWwRD4ZJG9FRQSJ
         Vqb79s0mpJ+B89QeaM39ANxGC5PWVeQy25PNH3kdpI/hkJ6eOqY3togNZG1mtvsIvd9P
         YeAm7OdqO+y/r0188a2B0XhHIfNuA52ItlRv3eFxIwcYSTqpa7FAtqzo915uM0CpAq1q
         zhPZqCADVzpIFE7DqmM750TozvJnaRg4ZxTZRCAovVQcVDAwPgzSoZjVbrxnKZHnerab
         7NcRWqm0GdbXUHkEhCccRt7fM1pLtSOFzGazymvcSZhDcc0eKlTxz0dfchW8gJNCh9T4
         cQhg==
X-Gm-Message-State: AC+VfDwipjhesR++Z0PkdgmDDC7GebUWt/Cue3hUVeU0kUj/6XNThnG/
        zXgiSJJpU1lyyV1WJCZMgGMMCQ==
X-Google-Smtp-Source: ACHHUZ6aO63aB0ivLxr314wK6McsLRCMFWp7e9PqpM9WsM4lyJcifxxqvJmzXY5bM+GY/o7VLsyMTg==
X-Received: by 2002:a17:907:7d9e:b0:991:bd74:ea3e with SMTP id oz30-20020a1709077d9e00b00991bd74ea3emr8214488ejc.4.1687979215931;
        Wed, 28 Jun 2023 12:06:55 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id j8-20020a1709062a0800b00992316f0690sm1938987eje.74.2023.06.28.12.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:55 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v4 3/4] ublk: enable zoned storage support
Date:   Wed, 28 Jun 2023 21:06:48 +0200
Message-ID: <20230628190649.11233-4-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628190649.11233-1-nmi@metaspace.dk>
References: <20230628190649.11233-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Note: This commit changes the ublk kernel module name from `ublk_drv.ko` to
`ublk.ko` in order to link multiple translation units into the module.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS                    |   1 +
 drivers/block/Kconfig          |   4 +
 drivers/block/Makefile         |   4 +-
 drivers/block/ublk_drv-zoned.c | 144 +++++++++++++++++++++++++++++++++
 drivers/block/ublk_drv.c       |  64 +++++++++++++--
 drivers/block/ublk_drv.h       |  15 ++++
 include/uapi/linux/ublk_cmd.h  |  14 ++++
 7 files changed, 239 insertions(+), 7 deletions(-)
 create mode 100644 drivers/block/ublk_drv-zoned.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ace71c90751c..db8a8deb5926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21555,6 +21555,7 @@ S:	Maintained
 F:	Documentation/block/ublk.rst
 F:	drivers/block/ublk_drv.c
 F:	drivers/block/ublk_drv.h
+F:	drivers/block/ublk_drv-zoned.c
 F:	include/uapi/linux/ublk_cmd.h
 
 UCLINUX (M68KNOMMU AND COLDFIRE)
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..c58dfd035557 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -402,6 +402,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 	  suggested to enable N if your application(ublk server) switches to
 	  ioctl command encoding.
 
+config BLK_DEV_UBLK_ZONED
+	def_bool y
+	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..bc1649e20ec2 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -37,6 +37,8 @@ obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
-obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
+obj-$(CONFIG_BLK_DEV_UBLK)		+= ublk.o
+ublk-$(CONFIG_BLK_DEV_UBLK)		+= ublk_drv.o
+ublk-$(CONFIG_BLK_DEV_UBLK_ZONED)	+= ublk_drv-zoned.o
 
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/ublk_drv-zoned.c b/drivers/block/ublk_drv-zoned.c
new file mode 100644
index 000000000000..ea86bf4b3681
--- /dev/null
+++ b/drivers/block/ublk_drv-zoned.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
+ */
+#include <linux/blkzoned.h>
+#include <linux/ublk_cmd.h>
+#include <linux/vmalloc.h>
+
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
+/* Based on virtblk_alloc_report_buffer */
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
+	struct ublk_device *ub = disk->private_data;
+	unsigned int zone_size_sectors = disk->queue->limits.chunk_sectors;
+	unsigned int first_zone = sector >> ilog2(zone_size_sectors);
+	unsigned int done_zones = 0;
+	unsigned int max_zones_per_request;
+	struct blk_zone *buffer;
+	size_t buffer_length;
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
index e519dc0d9fe7..88fa39853c61 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -57,12 +57,13 @@
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_UNPRIVILEGED_DEV \
 		| UBLK_F_CMD_IOCTL_ENCODE \
-		| UBLK_F_USER_COPY)
+		| UBLK_F_USER_COPY \
+		| UBLK_F_ZONED)
 
 /* All UBLK_PARAM_TYPE_* should be included here */
-#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
-		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
-
+#define UBLK_PARAM_TYPE_ALL                                \
+	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
 
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
@@ -209,6 +210,9 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ublk_set_nr_zones(ub);
 }
 
 static void ublk_dev_param_discard_apply(struct ublk_device *ub)
@@ -269,6 +273,9 @@ static int ublk_apply_params(struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_TYPE_ZONED))
+		ublk_dev_param_zoned_apply(ub);
+
 	return 0;
 }
 
@@ -439,6 +446,7 @@ static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
+	.report_zones =	ublk_report_zones,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -553,7 +561,8 @@ static inline bool ublk_need_map_req(const struct request *req)
 
 static inline bool ublk_need_unmap_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
+	return ublk_rq_has_data(req) &&
+	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
@@ -637,6 +646,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
+	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -655,6 +665,35 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
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
+	case REQ_OP_DRV_OUT:
+		/* We do not support zone append or reset_all yet */
+		fallthrough;
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -708,7 +747,8 @@ static inline void __ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
@@ -1835,6 +1875,15 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
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
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 	ret = add_disk(disk);
@@ -1997,6 +2046,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (ub->dev_info.flags & UBLK_F_USER_COPY)
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
+	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
+		ub->dev_info.flags &= ~UBLK_F_ZONED;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
index f81e62256456..7242430fd6b9 100644
--- a/drivers/block/ublk_drv.h
+++ b/drivers/block/ublk_drv.h
@@ -50,6 +50,21 @@ struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
+	enum ublk_op operation;
+	__u64 sector;
+	__u32 nr_sectors;
 };
 
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
 #endif
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 471b3b983045..436525afffe8 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -176,6 +176,11 @@
 /* Copy between request and user buffer by pread()/pwrite() */
 #define UBLK_F_USER_COPY	(1UL << 7)
 
+/*
+ * Enable zoned device support
+ */
+#define UBLK_F_ZONED (1ULL << 8)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -242,6 +247,7 @@ enum ublk_op {
 	UBLK_IO_OP_ZONE_APPEND = 13,
 	UBLK_IO_OP_ZONE_RESET = 15,
 	__UBLK_IO_OP_DRV_IN_START = 32,
+	UBLK_IO_OP_REPORT_ZONES = __UBLK_IO_OP_DRV_IN_START,
 	__UBLK_IO_OP_DRV_IN_END = 96,
 	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
 	__UBLK_IO_OP_DRV_OUT_END = 160,
@@ -342,6 +348,12 @@ struct ublk_param_devt {
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
@@ -353,11 +365,13 @@ struct ublk_params {
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
-- 
2.41.0

