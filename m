Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E807F74773A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGDQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjGDQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:52:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA071AC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 09:52:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51dfa0771cdso4387741a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 09:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688489536; x=1691081536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmeNaedvzJG5TN3SYyJwsVgz2v8XaFGPq/mxdzNq3MQ=;
        b=hsY9Plq6xsZwALy6I424gNrBfMMGHepEgIEhkVotKU8rhkli2WV14MmfZ669RuEkRf
         gnBL6RSfyJq6J5qlB3haPLuxh9sNaZHNwmypq/Q89rIN4uZZISIJkOnpHxdxxPsAk1Mr
         JX4i/Ys9YJ5r97psNoKs92oayg/XECLqYfKdDOchU9l4DlPJVsnydN+pi905UAHT5sga
         W8B4reNoYndKs/4loeHOQYvPUnXKq7TOJpnYVZHe23hiIpjWUw4xwgxEW+GsfGRxY7jk
         hYIGsFuoLjTgej5fvpGM/EnDKmqyAFqLZ24MQ0lzia6ebVtMFbU8E7uhT9wftvbClbw/
         hgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489536; x=1691081536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmeNaedvzJG5TN3SYyJwsVgz2v8XaFGPq/mxdzNq3MQ=;
        b=lWVmer1cgUI7w7qguQKbLg6Ki0HVZ7FBOMpMNUYj3aZJ96pQEeQ1WC7QHJbjrUjwmi
         7SfkOnCJKODHb5ULXRm2BlFXBeS3/3z/Oroufrh0ABJMSeU7cm5Fvoi7ToiVTmEflexQ
         vkH+Q84TP5kpDwDLAyqgHdEF/FhXaTreTVgrJLy+ST8TSwfrmn/AETVzcAlWG8TsTxXu
         daVjZ3xAFLBcLYe9B1Opie40I98uMkplLdFvRqLQb5xCedNQaKayhIE5o7e0VBdVkQN+
         Zkhrzn1xf30gs/K12hR8FErQLK3zo4XONkOef4PqdSYR+G2r9FlU29MRNgb3FdY4/yRg
         fywA==
X-Gm-Message-State: ABy/qLaoNOZEw/SxKuyRIMZpILuu/2dpHkod80+IGBALtmtrFsgTANB4
        y4pueQxeZGy/lu5Q4U/s58d8BA==
X-Google-Smtp-Source: APBJJlG8GPj0bBbD2hx+Rq69InEGsQahjuI9GyztcbvUv14cy/+RrHzd/jkgBZPeGAUcnM/pQuIoFg==
X-Received: by 2002:a17:907:20a4:b0:973:9f60:c57e with SMTP id pw4-20020a17090720a400b009739f60c57emr9620153ejb.2.1688489535956;
        Tue, 04 Jul 2023 09:52:15 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906088500b0098963eb0c3dsm13479053eje.26.2023.07.04.09.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:52:15 -0700 (PDT)
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
Subject: [PATCH v5 2/5] ublk: move types to shared header file
Date:   Tue,  4 Jul 2023 18:52:06 +0200
Message-ID: <20230704165209.514591-3-nmi@metaspace.dk>
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

This change is in preparation for ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS              |   1 +
 drivers/block/ublk_drv.c |  92 +---------------------------------
 drivers/block/ublk_drv.h | 103 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 91 deletions(-)
 create mode 100644 drivers/block/ublk_drv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..ace71c90751c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21554,6 +21554,7 @@ L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/block/ublk.rst
 F:	drivers/block/ublk_drv.c
+F:	drivers/block/ublk_drv.h
 F:	include/uapi/linux/ublk_cmd.h
 
 UCLINUX (M68KNOMMU AND COLDFIRE)
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..bca0c4e1cfd8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -45,6 +45,7 @@
 #include <linux/namei.h>
 #include <linux/kref.h>
 #include <uapi/linux/ublk_cmd.h>
+#include "ublk_drv.h"
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
@@ -62,63 +63,11 @@
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
 		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
 
-struct ublk_rq_data {
-	struct llist_node node;
-
-	struct kref ref;
-};
 
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
 };
 
-/*
- * io command is active: sqe cmd is received, and its cqe isn't done
- *
- * If the flag is set, the io command is owned by ublk driver, and waited
- * for incoming blk-mq request from the ublk block device.
- *
- * If the flag is cleared, the io command will be completed, and owned by
- * ublk server.
- */
-#define UBLK_IO_FLAG_ACTIVE	0x01
-
-/*
- * IO command is completed via cqe, and it is being handled by ublksrv, and
- * not committed yet
- *
- * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
- * cross verification
- */
-#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
-
-/*
- * IO command is aborted, so this flag is set in case of
- * !UBLK_IO_FLAG_ACTIVE.
- *
- * After this flag is observed, any pending or new incoming request
- * associated with this io command will be failed immediately
- */
-#define UBLK_IO_FLAG_ABORTED 0x04
-
-/*
- * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
- * get data buffer address from ublksrv.
- *
- * Then, bio data could be copied into this data buffer for a WRITE request
- * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
- */
-#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
-
-struct ublk_io {
-	/* userspace buffer address from io cmd */
-	__u64	addr;
-	unsigned int flags;
-	int res;
-
-	struct io_uring_cmd *cmd;
-};
-
 struct ublk_queue {
 	int q_id;
 	int q_depth;
@@ -140,45 +89,6 @@ struct ublk_queue {
 
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
diff --git a/drivers/block/ublk_drv.h b/drivers/block/ublk_drv.h
new file mode 100644
index 000000000000..2a4ab721d513
--- /dev/null
+++ b/drivers/block/ublk_drv.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _UBLK_DRV_H
+#define _UBLK_DRV_H
+
+#include <uapi/linux/ublk_cmd.h>
+#include <linux/blk-mq.h>
+#include <linux/cdev.h>
+
+/*
+ * io command is active: sqe cmd is received, and its cqe isn't done
+ *
+ * If the flag is set, the io command is owned by ublk driver, and waited
+ * for incoming blk-mq request from the ublk block device.
+ *
+ * If the flag is cleared, the io command will be completed, and owned by
+ * ublk server.
+ */
+#define UBLK_IO_FLAG_ACTIVE	0x01
+
+/*
+ * IO command is completed via cqe, and it is being handled by ublksrv, and
+ * not committed yet
+ *
+ * Basically exclusively with UBLK_IO_FLAG_ACTIVE, so can be served for
+ * cross verification
+ */
+#define UBLK_IO_FLAG_OWNED_BY_SRV 0x02
+
+/*
+ * IO command is aborted, so this flag is set in case of
+ * !UBLK_IO_FLAG_ACTIVE.
+ *
+ * After this flag is observed, any pending or new incoming request
+ * associated with this io command will be failed immediately
+ */
+#define UBLK_IO_FLAG_ABORTED 0x04
+
+/*
+ * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
+ * get data buffer address from ublksrv.
+ *
+ * Then, bio data could be copied into this data buffer for a WRITE request
+ * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
+ */
+#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
+
+
+struct ublk_device {
+	struct gendisk		*ub_disk;
+
+	char	*__queues;
+
+	unsigned int	queue_size;
+	struct ublksrv_ctrl_dev_info	dev_info;
+
+	struct blk_mq_tag_set	tag_set;
+
+	struct cdev		cdev;
+	struct device		cdev_dev;
+
+#define UB_STATE_OPEN		0
+#define UB_STATE_USED		1
+#define UB_STATE_DELETED	2
+	unsigned long		state;
+	int			ub_number;
+
+	struct mutex		mutex;
+
+	spinlock_t		mm_lock;
+	struct mm_struct	*mm;
+
+	struct ublk_params	params;
+
+	struct completion	completion;
+	unsigned int		nr_queues_ready;
+	unsigned int		nr_privileged_daemon;
+
+	/*
+	 * Our ubq->daemon may be killed without any notification, so
+	 * monitor each queue's daemon periodically
+	 */
+	struct delayed_work	monitor_work;
+	struct work_struct	quiesce_work;
+	struct work_struct	stop_work;
+};
+
+struct ublk_rq_data {
+	struct llist_node node;
+
+	struct kref ref;
+};
+
+struct ublk_io {
+	/* userspace buffer address from io cmd */
+	__u64 addr;
+	unsigned int flags;
+	int res;
+
+	struct io_uring_cmd *cmd;
+};
+
+#endif
-- 
2.41.0

