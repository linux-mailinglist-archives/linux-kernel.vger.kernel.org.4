Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A885E7418AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjF1THL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjF1TG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:06:59 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556802134
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99286af0260so17651766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1687979215; x=1690571215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL2rSnLNVvXtnKVS/60xfeay+8umeUcihwVxY5tjP98=;
        b=N/l8Ikg1L9otvySPGQDLDjHIJK0ZEZHD7iOlMTOao9itYccG7s15NluGTE1ZOWd1/r
         lV4Sxvo1cFnCXpuV8MLHEgY3gY4xwoqvSkcxFXgQbxEY5VBWWn+W7SlZwnTUD8UGqRY9
         gQL67nR+wH4ZLkOOjqOsN2Dl79jVqr6Y3yhpq6DhSvV/Rjfql9wrdoZmDxAnAhIOuyZN
         8bT8iq6SSgnHS0VtBaf//U2UGM+sEmFp5YrCNOZk+wjMyjIp/nQR0TkHGFxcGTKf8bfQ
         taqy445nhmULOrmGlwiUBwT+j0VmIrIrdPhYQte3FlfvzxJO3IMrdw/PJ9mGTXD4TM5p
         RKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687979215; x=1690571215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL2rSnLNVvXtnKVS/60xfeay+8umeUcihwVxY5tjP98=;
        b=UF/UrdciROPgwDNgAK/14eLP7CFNJFyjp9FiFxjMsc2Arw8Do0Asf9qVpVumllnSu0
         RUSWo7wcuE0m86ZkgZLLPpxjKrmkANEo7lYCx3Wq3tIvtX7Y2RaQEE26Ude2J/pFzAaB
         IcndVNZl5wVf50RTM7JbNOD6c3BzLz6ONX/q4g5Vg2FEk3vZZlEgGQpmckjTEtmnNqq9
         DgljGZXCMkroH+0C0HaJ4STCbewKmwHZKM82V8jcaaOyAQ+9v31z9xxGboozLemFIPx5
         7r6CzczNwV912CMNf+SJAWOjMdn3aIYYNwwu3ZbU8k9z/lNztf3bfDbj3rxiG0dsjaMj
         CL8g==
X-Gm-Message-State: AC+VfDzMZkri1KgLZ0JiwdATWY1aDIfoyErtAPpKUPqM1+T7lg4q36MG
        0xvHGW+UsjYrho0gPPhLelFhng==
X-Google-Smtp-Source: ACHHUZ5x3knptxNXIQj3zQ7QcYltcI4pcOh5ETBx90OgXMw7Vd6N57BuDhypugw1hngg6zeZ6Pmj1g==
X-Received: by 2002:a17:907:360e:b0:96a:4ea0:a1e7 with SMTP id bk14-20020a170907360e00b0096a4ea0a1e7mr34442458ejc.50.1687979214735;
        Wed, 28 Jun 2023 12:06:54 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id ec10-20020a170906b6ca00b009893650453fsm6057136ejb.173.2023.06.28.12.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 12:06:54 -0700 (PDT)
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
Subject: [PATCH v4 2/4] ublk: move types to shared header file
Date:   Wed, 28 Jun 2023 21:06:47 +0200
Message-ID: <20230628190649.11233-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628190649.11233-1-nmi@metaspace.dk>
References: <20230628190649.11233-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This change is in preparation for ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS              |  1 +
 drivers/block/ublk_drv.c | 45 +-------------------------------
 drivers/block/ublk_drv.h | 55 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 44 deletions(-)
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
index 1c823750c95a..e519dc0d9fe7 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -45,6 +45,7 @@
 #include <linux/namei.h>
 #include <linux/kref.h>
 #include <uapi/linux/ublk_cmd.h>
+#include "ublk_drv.h"
 
 #define UBLK_MINORS		(1U << MINORBITS)
 
@@ -62,11 +63,6 @@
 #define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | \
 		UBLK_PARAM_TYPE_DISCARD | UBLK_PARAM_TYPE_DEVT)
 
-struct ublk_rq_data {
-	struct llist_node node;
-
-	struct kref ref;
-};
 
 struct ublk_uring_cmd_pdu {
 	struct ublk_queue *ubq;
@@ -140,45 +136,6 @@ struct ublk_queue {
 
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
index 000000000000..f81e62256456
--- /dev/null
+++ b/drivers/block/ublk_drv.h
@@ -0,0 +1,55 @@
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
+#endif
-- 
2.41.0

