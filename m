Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B474773D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjGDQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGDQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:52:25 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D94F1AC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:52:23 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb41682472so8819756e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489541; x=1691081541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IbxDPtV+Ude4FwnmirBRUCqAsNikpq+PKfinxScon4=;
        b=Qf4EevxqFwYjDF2rm85BVu5Pe6LQkltmxGuS0nohZAdqUvZJNBwgqkbiaTu5q1fm9u
         XiD/fBPm3FEzX//cQaAE1uvLeXenpjSmb/WI6q94srhJTQYiwvBL0bVy1MmqpLpUvLh3
         LC42GOqV2dIubP51oBPaWvJBSy/tPMuyj2w93XERFIQGFXXRLxSN0AZs7yiYQz1wxIgd
         h4w8bqWZb4zAx5/00MHBlsV4p+mDIx7pLH/o2DkU7XlR38wazNNJL4yodqGizxRphpNG
         ren1t+uDd7ecmySBD/tYSf2wytOh3+5faoG1PHuZopxCTL9yjOSTQ4KtS0/yWvN1jhd7
         LKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489541; x=1691081541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IbxDPtV+Ude4FwnmirBRUCqAsNikpq+PKfinxScon4=;
        b=VXHv6Agq387Q2GyoOlBeb8m4T0MUeW6GmXkfpsaD5cSsmmSV5GHkQeyHCy6PrsWG84
         kFSTBgx1zNPAvrdaxCKdG8XIv8PZAtQfysV+s4lL7fFNM6qMFXd1/4ShoMqCxpNL73VG
         DTr6XHdGnBUhTzcfMB13TtC0UCtWqxkhDNaWr3LxTKQ7paZ2Y4R7h2XzO5dIxzUeyWGG
         pZ38WZqrjvVeKhHVUiSdjAYKeBzcmuLchHTavSwGF6NTyMLjQi0eX2+63/iaF9vRX3Kn
         aHxlO/kWxwwOt5LFTERFV+bVjpOcO+1exqBipE7Z8MVoaD59u+1KevGcOCf8f4eQMR+4
         8Dig==
X-Gm-Message-State: ABy/qLY/rPAa2v3APijnKS2aMsg3FIwxlP9oIdtVnIanguALW1bYGdJH
        tYKRG5EUZ5r5+jyDxMFJNfqBCA==
X-Google-Smtp-Source: APBJJlE05k/M/yMNBzXugLt7Qz8wxv98HJjq+cydoTxtgvIVDSVbnljM3yS9HvCtgP+M+vv2Ld081w==
X-Received: by 2002:a05:6512:3586:b0:4fb:7642:88d3 with SMTP id m6-20020a056512358600b004fb764288d3mr9963050lfr.27.1688489541078;
        Tue, 04 Jul 2023 09:52:21 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id k22-20020a056402049600b0051e0bf5807bsm3688514edv.49.2023.07.04.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:20 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 5/5] ublk: enable zoned storage support
Date:   Tue,  4 Jul 2023 18:52:09 +0200
Message-ID: <20230704165209.514591-6-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704165209.514591-1-nmi@metaspace.dk>
References: <20230704165209.514591-1-nmi@metaspace.dk>
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
 - REQ_OP_ZONE_APPEND

The zone append feature uses the `addr` field of `struct ublksrv_io_cmd` to
communicate ALBA back to the kernel. Therefore ublk must be used with the
user copy feature (UBLK_F_USER_COPY) for zoned storage support to be
available. Without this feature, ublk will not allow zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS                   |   1 +
 drivers/block/Kconfig         |   5 +
 drivers/block/Makefile        |   1 +
 drivers/block/ublk-zoned.c    | 225 ++++++++++++++++++++++++++++++++++
 drivers/block/ublk.c          |  92 +++++++++++---
 drivers/block/ublk.h          |  72 +++++++++++
 include/uapi/linux/ublk_cmd.h |  28 +++++
 7 files changed, 410 insertions(+), 14 deletions(-)
 create mode 100644 drivers/block/ublk-zoned.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f193cd43958..8277f3e3e8e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21553,6 +21553,7 @@ M:	Ming Lei <ming.lei@redhat.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/block/ublk.rst
+F:	drivers/block/ublk-zoned.c
 F:	drivers/block/ublk.c
 F:	drivers/block/ublk.h
 F:	include/uapi/linux/ublk_cmd.h
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..2d76e9693c2d 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -373,6 +373,7 @@ config BLK_DEV_RBD
 config BLK_DEV_UBLK
 	tristate "Userspace block driver (Experimental)"
 	select IO_URING
+  select BLK_DEV_UBLK_ZONED if BLK_DEV_ZONED
 	help
 	  io_uring based userspace block driver. Together with ublk server, ublk
 	  has been working well, but interface with userspace or command data
@@ -402,6 +403,10 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 	  suggested to enable N if your application(ublk server) switches to
 	  ioctl command encoding.
 
+config BLK_DEV_UBLK_ZONED
+	bool
+	depends on BLK_DEV_UBLK && BLK_DEV_ZONED
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 38f2229623a8..6c700936d427 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 
 obj-$(CONFIG_BLK_DEV_UBLK)			+= ublk_drv.o
 ublk_drv-$(CONFIG_BLK_DEV_UBLK)			+= ublk.o
+ublk_drv-$(CONFIG_BLK_DEV_UBLK_ZONED)		+= ublk-zoned.o
 
 swim_mod-y	:= swim.o swim_asm.o
diff --git a/drivers/block/ublk-zoned.c b/drivers/block/ublk-zoned.c
new file mode 100644
index 000000000000..6ddde2ac63e3
--- /dev/null
+++ b/drivers/block/ublk-zoned.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Andreas Hindborg <a.hindborg@samsung.com>
+ */
+#include <linux/blkzoned.h>
+#include <linux/ublk_cmd.h>
+#include <linux/vmalloc.h>
+
+#include "ublk.h"
+
+
+static int get_nr_zones(const struct ublk_device *ub)
+{
+	const struct ublk_param_basic *p = &ub->params.basic;
+
+	if (p->chunk_sectors)
+		return p->dev_sectors / p->chunk_sectors;
+	else
+		return 0;
+}
+
+int ublk_set_nr_zones(struct ublk_device *ub)
+{
+	const struct ublk_param_basic *p = &ub->params.basic;
+
+	if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
+		return -EINVAL;
+
+	if (ublk_dev_is_zoned(ub)) {
+		ub->ub_disk->nr_zones = get_nr_zones(ub);
+		if (!ub->ub_disk->nr_zones)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+void ublk_disk_set_zoned(struct ublk_device *ub)
+{
+	if (ublk_dev_is_zoned(ub)) {
+		disk_set_zoned(ub->ub_disk, BLK_ZONED_HM);
+		blk_queue_required_elevator_features(ub->ub_disk->queue,
+						     ELEVATOR_F_ZBD_SEQ_WRITE);
+	}
+}
+
+void ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
+				  struct ublk_io *io, struct request *req)
+{
+	if (io->flags & UBLK_IO_FLAG_ZONE_APPEND)
+		req->__sector = ub_cmd->addr;
+	io->flags &= ~UBLK_IO_FLAG_ZONE_APPEND;
+}
+
+int ublk_revalidate_disk_zones(struct ublk_device *ub)
+{
+	int ret = 0;
+
+	if (ublk_dev_is_zoned(ub))
+		ret = blk_revalidate_disk_zones(ub->ub_disk, NULL);
+
+	return ret;
+}
+
+int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+	int nr_zones;
+
+	if (ublk_dev_is_zoned(ub) && !(ublk_dev_params_zoned(ub)))
+		return -EINVAL;
+
+	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
+		return -EINVAL;
+
+	if (!ublk_dev_params_zoned(ub))
+		return 0;
+
+	if (!p->max_zone_append_sectors)
+		return -EINVAL;
+
+	nr_zones = get_nr_zones(ub);
+
+	if (p->max_active_zones > nr_zones)
+		return -EINVAL;
+
+	if (p->max_open_zones > nr_zones)
+		return -EINVAL;
+
+	return 0;
+}
+
+int ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	const struct ublk_param_zoned *p = &ub->params.zoned;
+
+	if (ublk_dev_is_zoned(ub) && !(ublk_dev_params_zoned(ub)))
+		return -EINVAL;
+
+	if (!ublk_dev_is_zoned(ub) && ublk_dev_params_zoned(ub))
+		return -EINVAL;
+
+	if (!ublk_dev_params_zoned(ub))
+		return 0;
+
+	disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
+	disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
+	blk_queue_max_zone_append_sectors(ub->ub_disk->queue, p->max_zone_append_sectors);
+
+	return 0;
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
+	*buflen = 0;
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
+	int ret;
+	struct blk_zone *buffer;
+	size_t buffer_length;
+
+	if (!ublk_dev_is_zoned(ub))
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
+		struct request *req;
+		struct ublk_rq_data *pdu;
+		blk_status_t status;
+
+		memset(buffer, 0, buffer_length);
+
+		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			goto out;
+		}
+
+		pdu = blk_mq_rq_to_pdu(req);
+		pdu->operation = UBLK_IO_OP_REPORT_ZONES;
+		pdu->sector = sector;
+		pdu->nr_sectors = remaining_zones * zone_size_sectors;
+
+		ret = blk_rq_map_kern(disk->queue, req, buffer, buffer_length,
+					GFP_KERNEL);
+		if (ret) {
+			blk_mq_free_request(req);
+			goto out;
+		}
+
+		status = blk_execute_rq(req, 0);
+		ret = blk_status_to_errno(status);
+		blk_mq_free_request(req);
+		if (ret)
+			goto out;
+
+		for (unsigned int i = 0; i < zones_in_request; i++) {
+			struct blk_zone *zone = buffer + i;
+
+			ret = cb(zone, i, data);
+			if (ret)
+				goto out;
+
+			done_zones++;
+			sector += zone_size_sectors;
+
+			/* A zero length zone means don't ask for more zones */
+			if (!zone->len) {
+				ret = done_zones;
+				goto out;
+			}
+		}
+	}
+
+	ret = done_zones;
+
+out:
+	kvfree(buffer);
+	return ret;
+}
diff --git a/drivers/block/ublk.c b/drivers/block/ublk.c
index 0b1ec102aaae..c97a8f14f8a9 100644
--- a/drivers/block/ublk.c
+++ b/drivers/block/ublk.c
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
@@ -137,7 +138,7 @@ static inline unsigned ublk_pos_to_tag(loff_t pos)
 		UBLK_TAG_BITS_MASK;
 }
 
-static void ublk_dev_param_basic_apply(struct ublk_device *ub)
+static int ublk_dev_param_basic_apply(struct ublk_device *ub)
 {
 	struct request_queue *q = ub->ub_disk->queue;
 	const struct ublk_param_basic *p = &ub->params.basic;
@@ -162,6 +163,8 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
 		set_disk_ro(ub->ub_disk, true);
 
 	set_capacity(ub->ub_disk, p->dev_sectors);
+
+	return ublk_set_nr_zones(ub);
 }
 
 static void ublk_dev_param_discard_apply(struct ublk_device *ub)
@@ -191,6 +194,9 @@ static int ublk_validate_params(const struct ublk_device *ub)
 
 		if (p->max_sectors > (ub->dev_info.max_io_buf_bytes >> 9))
 			return -EINVAL;
+
+		if (ublk_dev_is_zoned(ub) && !p->chunk_sectors)
+			return -EINVAL;
 	} else
 		return -EINVAL;
 
@@ -209,20 +215,24 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_DEVT)
 		return -EINVAL;
 
-	return 0;
+	return ublk_dev_param_zoned_validate(ub);
 }
 
 static int ublk_apply_params(struct ublk_device *ub)
 {
+	int ret;
+
 	if (!(ub->params.types & UBLK_PARAM_TYPE_BASIC))
 		return -EINVAL;
 
-	ublk_dev_param_basic_apply(ub);
+	ret = ublk_dev_param_basic_apply(ub);
+	if (ret)
+		return ret;
 
 	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
 		ublk_dev_param_discard_apply(ub);
 
-	return 0;
+	return ublk_dev_param_zoned_apply(ub);
 }
 
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
@@ -392,6 +402,7 @@ static const struct block_device_operations ub_fops = {
 	.owner =	THIS_MODULE,
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
+	.report_zones =	ublk_report_zones,
 };
 
 #define UBLK_MAX_PIN_PAGES	32
@@ -506,7 +517,8 @@ static inline bool ublk_need_map_req(const struct request *req)
 
 static inline bool ublk_need_unmap_req(const struct request *req)
 {
-	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
+	return ublk_rq_has_data(req) &&
+	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
@@ -590,6 +602,7 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
+	struct ublk_rq_data *pdu = blk_mq_rq_to_pdu(req);
 	u32 ublk_op;
 
 	switch (req_op(req)) {
@@ -608,6 +621,37 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
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
+			return BLK_STS_OK;
+		default:
+			return BLK_STS_IOERR;
+		}
+	case REQ_OP_ZONE_APPEND:
+		ublk_op = UBLK_IO_OP_ZONE_APPEND;
+		io->flags |= UBLK_IO_FLAG_ZONE_APPEND;
+		break;
+	case REQ_OP_ZONE_RESET_ALL:
+	case REQ_OP_DRV_OUT:
+		/* We do not support zone append or reset_all yet */
+		fallthrough;
 	default:
 		return BLK_STS_IOERR;
 	}
@@ -661,7 +705,8 @@ static inline void __ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
+	    req_op(req) != REQ_OP_DRV_IN)
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
@@ -1025,6 +1070,8 @@ static void ublk_commit_completion(struct ublk_device *ub,
 	/* find the io request and complete */
 	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
 
+	ublk_zoned_commit_completion(ub_cmd, io, req);
+
 	if (req && likely(!blk_should_fake_timeout(req->q)))
 		ublk_put_req_ref(ubq, req);
 }
@@ -1324,7 +1371,8 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+	if (ublk_support_user_copy(ubq) &&
+	    !(io->flags & UBLK_IO_FLAG_ZONE_APPEND) && ub_cmd->addr) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1447,11 +1495,14 @@ static inline bool ublk_check_ubuf_dir(const struct request *req,
 		int ubuf_dir)
 {
 	/* copy ubuf to request pages */
-	if (req_op(req) == REQ_OP_READ && ubuf_dir == ITER_SOURCE)
+	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) &&
+	    ubuf_dir == ITER_SOURCE)
 		return true;
 
 	/* copy request pages to ubuf */
-	if (req_op(req) == REQ_OP_WRITE && ubuf_dir == ITER_DEST)
+	if ((req_op(req) == REQ_OP_WRITE ||
+	     req_op(req) == REQ_OP_ZONE_APPEND) &&
+	    ubuf_dir == ITER_DEST)
 		return true;
 
 	return false;
@@ -1780,6 +1831,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
 
+	ublk_disk_set_zoned(ub);
+
 	ret = ublk_apply_params(ub);
 	if (ret)
 		goto out_put_disk;
@@ -1788,8 +1841,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
-	get_device(&ub->cdev_dev);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	ret = ublk_revalidate_disk_zones(ub);
+	if (ret)
+		goto out_put_disk;
+
+	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
 		/*
@@ -1950,6 +2007,13 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
+	/* Zoned storage support requires user copy feature */
+	if (ublk_dev_is_zoned(ub) &&
+	    (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) || !ublk_dev_is_user_copy(ub))) {
+		ret = -EINVAL;
+		goto out_free_dev_number;
+	}
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
diff --git a/drivers/block/ublk.h b/drivers/block/ublk.h
index fcbcc6b02aa0..b78ab43cea82 100644
--- a/drivers/block/ublk.h
+++ b/drivers/block/ublk.h
@@ -45,6 +45,10 @@
  */
 #define UBLK_IO_FLAG_NEED_GET_DATA 0x08
 
+/*
+ * Set when IO is Zone Append
+ */
+#define UBLK_IO_FLAG_ZONE_APPEND 0x10
 
 struct ublk_device {
 	struct gendisk		*ub_disk;
@@ -89,6 +93,9 @@ struct ublk_rq_data {
 	struct llist_node node;
 
 	struct kref ref;
+	__u32 operation;
+	__u64 sector;
+	__u32 nr_sectors;
 };
 
 struct ublk_io {
@@ -100,9 +107,74 @@ struct ublk_io {
 	struct io_uring_cmd *cmd;
 };
 
+static inline int ublk_dev_params_zoned(const struct ublk_device *ub)
+{
+	return ub->params.types & UBLK_PARAM_TYPE_ZONED;
+}
+
+static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_ZONED;
+}
+
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
 }
 
+#ifndef CONFIG_BLK_DEV_ZONED
+
+static inline int ublk_set_nr_zones(struct ublk_device *ub)
+{
+	return 0;
+}
+
+static inline void ublk_disk_set_zoned(struct ublk_device *ub)
+{
+}
+
+static inline int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
+{
+	if (ublk_dev_params_zoned(ub))
+		return -EINVAL;
+	return 0;
+}
+
+static inline int ublk_dev_param_zoned_apply(struct ublk_device *ub)
+{
+	if (ublk_dev_params_zoned(ub))
+		return -EINVAL;
+	return 0;
+}
+
+static inline void
+ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
+			     struct ublk_io *io, struct request *req)
+{
+}
+
+static inline int ublk_revalidate_disk_zones(struct ublk_device *ub)
+{
+	return 0;
+}
+
+#define ublk_report_zones (NULL)
+
+#else
+
+int ublk_set_nr_zones(struct ublk_device *ub);
+void ublk_disk_set_zoned(struct ublk_device *ub);
+int ublk_dev_param_zoned_validate(const struct ublk_device *ub);
+int ublk_dev_param_zoned_apply(struct ublk_device *ub);
+void ublk_zoned_commit_completion(const struct ublksrv_io_cmd *ub_cmd,
+				  struct ublk_io *io, struct request *req);
+int ublk_revalidate_disk_zones(struct ublk_device *ub);
+int ublk_report_zones(struct gendisk *disk, sector_t sector,
+		      unsigned int nr_zones, report_zones_cb cb,
+		      void *data);
+
+#endif
+
+
+
 #endif
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index a32810c8ef2b..13b76e665aed 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -176,6 +176,12 @@
 /* Copy between request and user buffer by pread()/pwrite() */
 #define UBLK_F_USER_COPY	(1UL << 7)
 
+/*
+ * User space sets this flag when setting up the device to request zoned storage support. Kernel may
+ * deny the request by returning an error.
+ */
+#define UBLK_F_ZONED (1ULL << 8)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
@@ -235,7 +241,20 @@ struct ublksrv_ctrl_dev_info {
 #define		UBLK_IO_OP_DISCARD		(3)
 #define		UBLK_IO_OP_WRITE_SAME		(4)
 #define		UBLK_IO_OP_WRITE_ZEROES		(5)
+#define		UBLK_IO_OP_ZONE_OPEN		(10)
+#define		UBLK_IO_OP_ZONE_CLOSE		(11)
+#define		UBLK_IO_OP_ZONE_FINISH		(12)
+#define		UBLK_IO_OP_ZONE_APPEND		(13)
+#define		UBLK_IO_OP_ZONE_RESET		(15)
 #define		__UBLK_IO_OP_DRV_IN_START	(32)
+/* Construct a zone report. The report request is carried in `struct ublksrv_io_desc`. The
+ * `start_sector` field must be the first sector of a zone and shall indicate the first zone of the
+ * report. The `nr_sectors` shall indicate how many zones should be reported (divide by zone size to
+ * get number of zones in the report) and must be an integer multiple of the zone size. The report
+ * shall be delivered as a `struct blk_zone` array. To report fewer zones than requested, zero the
+ * last entry of the returned array.
+ */
+#define		UBLK_IO_OP_REPORT_ZONES		(__UBLK_IO_OP_DRV_IN_START)
 #define		__UBLK_IO_OP_DRV_IN_END		(96)
 #define		__UBLK_IO_OP_DRV_OUT_START	(__UBLK_IO_OP_DRV_IN_END)
 #define		__UBLK_IO_OP_DRV_OUT_END	(160)
@@ -335,6 +354,13 @@ struct ublk_param_devt {
 	__u32   disk_minor;
 };
 
+struct ublk_param_zoned {
+	__u32	max_open_zones;
+	__u32	max_active_zones;
+	__u32	max_zone_append_sectors;
+	__u8	reserved[20];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -346,11 +372,13 @@ struct ublk_params {
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

