Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8E5BB6F4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIQHZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIQHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:11 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A64505B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220917072400epoutp04ef478883371c646aae660d0607465e98~VlPpcUHFp2922529225epoutp04b
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220917072400epoutp04ef478883371c646aae660d0607465e98~VlPpcUHFp2922529225epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399440;
        bh=5J299PNSV9On+DufuXExL84p/AfLlL1SenNEX0X8or4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9q9DvGjxIaErtl16VRRmIjhGr895jTK/Fy+apGqzRigYibQnSDLoB+yH5rAxrbdc
         sspRBLiL+kYEyEeA8YCNP3CBfPh5e+EwBR+V09pGfu64ta97RfglWbrLMQkmnStJgC
         dOTmPzFJw2/xMtm3N4X/3MUAHMa2lKKvS6B0VgcE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p2d9b7ef80c3493647e29a81fa5d7abe5c~VlPo_wbFk1789517895epcas1p2t;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.36.134]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MV2Vk6npRz4x9Pp; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.71.51827.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epcas1p4e110e2025c90d78fad2182ec5cd66eb7~VlPntQZGs1033410334epcas1p4h;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epsmtrp27d0b9fe1cd6cc7eda09db09231f2b2c4~VlPnsh0xp1654916549epsmtrp20;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
X-AuditID: b6c32a36-f25ff7000000ca73-2b-6325760ecef9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.F0.18644.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072358epsmtip2a5a45b3e87b2b4e50bbce6907deddf5d~VlPna_s6Y2357323573epsmtip2g;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 11/13] trinity: Add trace module
Date:   Sat, 17 Sep 2022 16:23:54 +0900
Message-Id: <20220917072356.2255620-12-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTV5evTDXZYO8cM4u/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xoxn/cwFX6cwVsz5LdjA+LS6i5GTQ0LARGLvhFmMXYxcHEIC
        Oxgl+hd/YINwPjFKvFr7mxXC+cwoMWHLHFaYliV9m5ghErsYJb73zGCHq9q3fyEbSBWbgKrE
        zBlr2EFsEYFyieaNJ8BsZoEciSd3mphBbGEBY4nZqxsZQWwWoPr2FfNYQGxeARuJmW27weo5
        geybm5qg4oISJ2c+YYGYIy/RvHU22BUSAh/ZJX68WQo0iAPIcZE49KwW4lJhiVfHt7BD2FIS
        n9/tZYOwsyWmdCxigbALJM4938oM0WoscXFFCojJLKApsX6XPkSFosTO33MZIbbySbz72sMK
        Uc0r0dEmBFGiJLHkz2GoRRISU2d8Y4KwPSQWXe2EhmE/o8SDPb0sExjlZyF5ZhaSZ2YhbF7A
        yLyKUSy1oDg3PbXYsMAIHqnJ+bmbGMEJU8tsB+Oktx/0DjEycTAeYpTgYFYS4VX1VEkW4k1J
        rKxKLcqPLyrNSS0+xGgKDN6JzFKiyfnAlJ1XEm9oYmlgYmZkbGJhaGaoJM6rp82YLCSQnliS
        mp2aWpBaBNPHxMEp1cBkEbTs0r+UvAL5CbeCAtV14x95dBxcqPV1p7TxjisLLBN0jBtn9Ofm
        Vu2a4Gq0wv/2hNrMpSXF630CrY1kfjRfDD8assN2JuNXPc7ZiVlXFqldNz6n2fV34vO3HTMM
        m9ucjS9N23Rsc1Zc/cnDKtds+iv/7FvDfY7jTFvWlDAZu+Bqk3Dfm2s5Zda82xphsGCjnYhM
        wGQT5kvfM27v/fW5xyL10JvSyVN7tDYr73PNSN6h68CZqCy5g3HXK2O9kxdzGQ80q1iFss02
        OrUu0rExJq6RN7yj2aV2gfJ6W6VYm8BTNwN/bJ/xcK/g/Ept1fzDkV+TxW9/ZdEwO7D/wvcT
        yS6ffwXP3nxsXYZwnJQSS3FGoqEWc1FxIgD/9Lx/IQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSvC5fmWqywZ694hZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGjGf9zAVfpzBWzPkt2MD4tLqLkZND
        QsBEYknfJuYuRi4OIYEdjBK3Xzxnh0hISGy6txwowQFkC0scPlwMUfORUeLHqXdsIDVsAqoS
        M2esAasXEaiVOHh0PjOIzSxQIDH76UwWEFtYwFhi9upGRhCbBai+fcU8sDivgI3EzLbdYL2c
        QPbNTU1gcSEBa4nZ0+cyQdQISpyc+YQFYqa8RPPW2cwTGPlnIUnNQpJawMi0ilEytaA4Nz23
        2LDAKC+1XK84Mbe4NC9dLzk/dxMjOLS1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeVU+VZCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY5lpPulwX+/ISXy8D
        Q82KdZsdxQ3WMButmCfSO/vCrB98vo3+t62cv63cfOel8MO4N1JJiw47a5873cWeGWz5YFlW
        WH5scviOdXNlwu+l3HvWPGNNrPHfbClhSbbysr1MEruDvi2rLbn6KvWpxlrHw/vVm9YkN/9I
        3L3ozHyr8l9uWxdbaqbLR+xx+yP66Kla8ue9Znrd71V+V7BM/G6qG6jMsF3y21aHjNQTqW/4
        vmbr/sx/bTcnMe1v/5ubl87tXPNXWePcmsiP5hOZXsj7f9OQ0dQSi9pYq+rtP5H9wf1bb5cY
        +mqe+BWuYOLxRkr37qvlM7Pa89wue68uFLOezdvhsHcv34bei44SyT9ylViKMxINtZiLihMB
        MU8TF9wCAAA=
X-CMS-MailID: 20220917072358epcas1p4e110e2025c90d78fad2182ec5cd66eb7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p4e110e2025c90d78fad2182ec5cd66eb7
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p4e110e2025c90d78fad2182ec5cd66eb7@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for trace declaration.

'trinity' ftrace module added several trace points.
The points are located on each ioctl control, wakeup,
irq, and run trigger.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile              |   1 +
 drivers/misc/trinity/trinity.c             |  58 +++-
 drivers/misc/trinity/trinity_trace.c       |  15 +
 drivers/misc/trinity/trinity_trace.h       | 329 +++++++++++++++++++++
 drivers/misc/trinity/trinity_vision2_drv.c |   9 +
 5 files changed, 410 insertions(+), 2 deletions(-)
 create mode 100644 drivers/misc/trinity/trinity_trace.c
 create mode 100644 drivers/misc/trinity/trinity_trace.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index 462b7c61f39f..ac747bdbf46d 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -8,5 +8,6 @@ trinity-y += trinity_sched.o
 trinity-y += trinity_debug.o
 trinity-y += trinity_stat.o
 trinity-y += trinity_sysfs.o
+trinity-y += trinity_trace.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 0463140c0ae6..53c6ab92c26d 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -16,6 +16,7 @@
 #include "trinity_common.h"
 #include "trinity_sched.h"
 #include "trinity_stat.h"
+#include "trinity_trace.h"
 
 #define TRINITY_PADDR_BASE (0x0)
 
@@ -375,6 +376,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof((desc->ver))))
 			return -EFAULT;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_VERSION");
 		break;
 	}
 	case TRINITY_IOCTL_GET_API_LEVEL: {
@@ -384,6 +387,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof(api_level)))
 			return -EFAULT;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_API_LEVEL");
 		break;
 	}
 	case TRINITY_IOCTL_GET_STATE: {
@@ -394,6 +399,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof(ready)))
 			return -EFAULT;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_STATE");
 		break;
 	}
 	case TRINITY_IOCTL_GET_TOPS: {
@@ -401,6 +408,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof((drv->tops))))
 			return -EFAULT;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_TOPS");
+
 		break;
 	}
 	case TRINITY_IOCTL_GET_DSPM: {
@@ -408,6 +418,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof((drv->dspm))))
 			return -EFAULT;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_GET_DSPM");
+
 		break;
 	}
 	case TRINITY_IOCTL_GET_NEXT_REQUEST: {
@@ -417,6 +430,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 sizeof(req_id)))
 			return -EFAULT;
 
+		trace_trinity_ioctl_next_req(drv->dev_id, trinity_get_app_id(),
+					     req_id);
+
 		break;
 	}
 	case TRINITY_IOCTL_HWMEM_ALLOC: {
@@ -430,6 +446,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (err >= 0)
 			trinity_stat_app_total_alloc(drv, hwmem.size);
 
+		trace_trinity_ioctl_hwmem_alloc(
+			drv->dev_id, trinity_get_app_id(), hwmem.size, err);
+
 		break;
 	}
 	case TRINITY_IOCTL_HWMEM_DEALLOC: {
@@ -447,6 +466,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (err == 0)
 			trinity_stat_app_total_freed(drv, dbuf->size);
 
+		trace_trinity_ioctl_hwmem_dealloc(
+			drv->dev_id, trinity_get_app_id(), hwmem.dbuf_fd);
+
 		break;
 	}
 	case TRINITY_IOCTL_REGISTER_MODEL: {
@@ -471,6 +493,11 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &model->config, sizeof(model->config)))
 			return -EFAULT;
 
+		trace_trinity_ioctl_register_model(
+			model->config.metadata_dbuf_fd,
+			model->config.metadata_ext_dbuf_fd,
+			model->config.metadata_ext_size);
+
 		break;
 	}
 	case TRINITY_IOCTL_DEREGISTER_MODEL: {
@@ -481,6 +508,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 		err = trinity_deregister_model(drv, id);
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_DEREGISTER_MODEL");
 		break;
 	}
 	case TRINITY_IOCTL_RUN_INPUT: {
@@ -511,6 +540,11 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 			return err;
 		}
 
+		trace_trinity_ioctl_run_input(
+			input->config.timeout_ms, input->config.priority,
+			input->config.num_segments, input->config.input_mode,
+			input->config.output_mode);
+
 		if (copy_to_user((struct trinity_input __user *)arg,
 				 &input->config, sizeof(input->config))) {
 			drv->desc->dealloc_req(drv, req);
@@ -527,9 +561,16 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		if (!IDU_LOADED(drv))
 			return -EFAULT;
 
-		if (drv->desc->stop_reqs)
+		if (drv->desc->stop_reqs) {
 			schedule_work(&drv->work_stop);
-
+			trace_trinity_ioctl_msg(drv->dev_id,
+						trinity_get_app_id(),
+						"TRINITY_IOCTL_STOP_REQUESTS");
+		} else {
+			trace_trinity_ioctl_msg(
+				drv->dev_id, trinity_get_app_id(),
+				"TRINITY_IOCTL_STOP_REQUESTS: not supported");
+		}
 		break;
 	}
 	case TRINITY_IOCTL_STAT_CURRENT_APP: {
@@ -546,6 +587,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &ioctl_stat_app, sizeof(ioctl_stat_app)))
 			return -EACCES;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_CURRENT_APP");
 		break;
 	}
 	case TRINITY_IOCTL_STAT_APPS: {
@@ -562,6 +605,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &ioctl_stat_apps, sizeof(ioctl_stat_apps)))
 			return -EACCES;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_APPS");
 		break;
 	}
 	case TRINITY_IOCTL_STAT_REQS: {
@@ -581,6 +626,8 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &ioctl_stat_reqs, sizeof(ioctl_stat_reqs)))
 			return -EACCES;
 
+		trace_trinity_ioctl_msg(drv->dev_id, trinity_get_app_id(),
+					"TRINITY_IOCTL_STAT_REQS");
 		break;
 	}
 	case TRINITY_IOCTL_GET_PROFILE_META: {
@@ -606,6 +653,10 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &profile, sizeof(profile)))
 			return -EACCES;
 
+		trace_trinity_ioctl_get_profile_meta(drv->dev_id,
+						     trinity_get_app_id(),
+						     profile.req_id,
+						     profile.profile_size);
 		break;
 	}
 	case TRINITY_IOCTL_GET_PROFILE_BUFF: {
@@ -624,6 +675,9 @@ long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 				 &profile, sizeof(profile)))
 			return -EACCES;
 
+		trace_trinity_ioctl_get_profile_buff(
+			drv->dev_id, trinity_get_app_id(), profile.req_id,
+			profile.profile_pos, profile.profile_size);
 		break;
 	}
 	case TRINITY_IOCTL_IDU_SET: {
diff --git a/drivers/misc/trinity/trinity_trace.c b/drivers/misc/trinity/trinity_trace.c
new file mode 100644
index 000000000000..d5721273eeb1
--- /dev/null
+++ b/drivers/misc/trinity/trinity_trace.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Trace source for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "trinity_trace.h"
+#endif
diff --git a/drivers/misc/trinity/trinity_trace.h b/drivers/misc/trinity/trinity_trace.h
new file mode 100644
index 000000000000..c4f03deeee90
--- /dev/null
+++ b/drivers/misc/trinity/trinity_trace.h
@@ -0,0 +1,329 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Trace header for trinity devices
+ *
+ * Copyright (C) 2021-2022 Samsung Electronics
+ * Copyright (C) 2021 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#if !defined(__DRIVERS_MISC_TRINITY_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __DRIVERS_MISC_TRINITY_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM trinity
+#define TRACE_INCLUDE_FILE trinity_trace
+
+// clang-format off
+TRACE_EVENT(triv2_run_trigger,
+	TP_PROTO(u32 device_id, s32 slot),
+	TP_ARGS(device_id, slot),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+	),
+	TP_printk("device_id=%u slot=%d",
+		__entry->device_id,
+		__entry->slot)
+);
+TRACE_EVENT(triv2_wakeup_cp,
+	TP_PROTO(u32 device_id),
+	TP_ARGS(device_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+	),
+	TP_printk("device_id=%u",
+		__entry->device_id)
+);
+TRACE_EVENT(triv2_handle_irq,
+	TP_PROTO(u32 device_id, s32 irq),
+	TP_ARGS(device_id, irq),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, irq)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->irq = irq;
+	),
+	TP_printk("device_id=%u irq=%d",
+		__entry->device_id,
+		__entry->irq)
+);
+TRACE_EVENT(triv2_handle_threaded_irq,
+	TP_PROTO(u32 device_id, s32 irq),
+	TP_ARGS(device_id, irq),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, irq)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->irq = irq;
+	),
+	TP_printk("device_id=%u irq=%d",
+		__entry->device_id,
+		__entry->irq)
+);
+TRACE_EVENT(triv2_handle_cmd_done,
+	TP_PROTO(u32 device_id, s32 slot, u32 cycles, u32 time),
+	TP_ARGS(device_id, slot, cycles, time),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+		__field(u32, cycles)
+		__field(u32, time)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+		__entry->cycles = cycles;
+		__entry->time = time;
+	),
+	TP_printk("device_id=%u slot=%d cycles=%u time(us)=%u",
+		__entry->device_id,
+		__entry->slot,
+		__entry->cycles,
+		__entry->time)
+);
+TRACE_EVENT(triv2_map_sched_data,
+	TP_PROTO(u32 device_id, s32 slot, u32 batch_size, u32 in_cnt, u32 out_cnt),
+	TP_ARGS(device_id, slot, batch_size, in_cnt, out_cnt),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+		__field(u32, batch_size)
+		__field(u32, in_cnt)
+		__field(u32, out_cnt)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+		__entry->batch_size = batch_size;
+		__entry->in_cnt = in_cnt;
+		__entry->out_cnt = out_cnt;
+	),
+	TP_printk("device_id=%u slot=%d batch_size=%u in_cnt=%u out_cnt=%u",
+		__entry->device_id,
+		__entry->slot,
+		__entry->batch_size,
+		__entry->in_cnt,
+		__entry->out_cnt)
+);
+TRACE_EVENT(triv2_unmap_sched_data,
+	TP_PROTO(u32 device_id, s32 slot),
+	TP_ARGS(device_id, slot),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, slot)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->slot = slot;
+	),
+	TP_printk("device_id=%u slot=%d",
+		__entry->device_id,
+		__entry->slot)
+);
+TRACE_EVENT(trinity_ioctl_msg,
+	TP_PROTO(u32 device_id, s32 app_id, char *msg),
+	TP_ARGS(device_id, app_id, msg),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(char*, msg)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->msg = msg;
+	),
+	TP_printk("device_id=%u app_id=%d msg=%s",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->msg)
+);
+TRACE_EVENT(trinity_ioctl_next_req,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id),
+	TP_ARGS(device_id, app_id, req_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id)
+);
+TRACE_EVENT(trinity_ioctl_stop_req,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id),
+	TP_ARGS(device_id, app_id, req_id),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id)
+);
+TRACE_EVENT(trinity_ioctl_hwmem_alloc,
+	TP_PROTO(u32 device_id, s32 app_id, s64 size, s32 dbuf_fd),
+	TP_ARGS(device_id, app_id, size, dbuf_fd),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s64, size)
+		__field(s32, dbuf_fd)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->size = size;
+		__entry->dbuf_fd = dbuf_fd;
+	),
+	TP_printk("device_id=%u app_id=%d size=%lld dbuf_fd=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->size,
+		__entry->dbuf_fd)
+);
+TRACE_EVENT(trinity_ioctl_hwmem_dealloc,
+	TP_PROTO(u32 device_id, s32 app_id, s32 dbuf_fd),
+	TP_ARGS(device_id, app_id, dbuf_fd),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, dbuf_fd)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->dbuf_fd = dbuf_fd;
+	),
+	TP_printk("device_id=%u app_id=%d dbuf_fd=%d",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->dbuf_fd)
+);
+TRACE_EVENT(trinity_ioctl_get_profile_meta,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id, u32 profile_size),
+	TP_ARGS(device_id, app_id, req_id, profile_size),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+		__field(u32, profile_size)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+		__entry->profile_size = profile_size;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d profile_size=%u",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id,
+		__entry->profile_size)
+);
+TRACE_EVENT(trinity_ioctl_get_profile_buff,
+	TP_PROTO(u32 device_id, s32 app_id, s32 req_id, u32 profile_pos,
+		u32 profile_size),
+	TP_ARGS(device_id, app_id, req_id, profile_pos, profile_size),
+	TP_STRUCT__entry(
+		__field(u32, device_id)
+		__field(s32, app_id)
+		__field(s32, req_id)
+		__field(u32, profile_pos)
+		__field(u32, profile_size)
+	),
+	TP_fast_assign(
+		__entry->device_id = device_id;
+		__entry->app_id = app_id;
+		__entry->req_id = req_id;
+		__entry->profile_pos = profile_pos;
+		__entry->profile_size = profile_size;
+	),
+	TP_printk("device_id=%u app_id=%d req_id=%d profile_pos=%u profile_size=%u",
+		__entry->device_id,
+		__entry->app_id,
+		__entry->req_id,
+		__entry->profile_pos,
+		__entry->profile_size)
+);
+TRACE_EVENT(trinity_ioctl_register_model,
+	TP_PROTO(s32 metadata_dbuf_fd, s32 metadata_ext_dbuf_fd,
+		u64 metadata_ext_size),
+	TP_ARGS(metadata_dbuf_fd, metadata_ext_dbuf_fd, metadata_ext_size),
+	TP_STRUCT__entry(
+		__field(s32, metadata_dbuf_fd)
+		__field(s32, metadata_ext_dbuf_fd)
+		__field(u64, metadata_ext_size)
+	),
+	TP_fast_assign(
+		__entry->metadata_dbuf_fd = metadata_dbuf_fd;
+		__entry->metadata_ext_dbuf_fd = metadata_ext_dbuf_fd;
+		__entry->metadata_ext_size = metadata_ext_size;
+	),
+	TP_printk("metadata_dbuf_fd=%d metadata_ext_dbuf_fd=%d metadata_ext_size=0x%llx",
+		__entry->metadata_dbuf_fd,
+		__entry->metadata_ext_dbuf_fd,
+		__entry->metadata_ext_size)
+);
+TRACE_EVENT(trinity_ioctl_run_input,
+	TP_PROTO(s64 timeout_ms, u32 priority, u32 num_segments, s32 input_mode,
+		s32 output_mode),
+	TP_ARGS(timeout_ms, priority, num_segments, input_mode, output_mode),
+	TP_STRUCT__entry(
+		__field(s64, timeout_ms)
+		__field(u32, priority)
+		__field(u32, num_segments)
+		__field(s32, input_mode)
+		__field(s32, output_mode)
+	),
+	TP_fast_assign(
+		__entry->timeout_ms = timeout_ms;
+		__entry->priority = priority;
+		__entry->num_segments = num_segments;
+		__entry->input_mode = input_mode;
+		__entry->output_mode = output_mode;
+	),
+	TP_printk("timeout_ms=%lld priority=%u num_segments=%u input_mode=%d output_mode=%d",
+		__entry->timeout_ms,
+		__entry->priority,
+		__entry->num_segments,
+		__entry->input_mode,
+		__entry->output_mode)
+);
+// clang-format on
+
+#endif /* __DRIVERS_MISC_TRINITY_TRACE_H__ */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../drivers/misc/trinity
+#include <trace/define_trace.h>
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
index 111623322895..8299cb3e25c1 100644
--- a/drivers/misc/trinity/trinity_vision2_drv.c
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -18,6 +18,7 @@
 
 #include "trinity_common.h"
 #include "trinity_sched.h"
+#include "trinity_trace.h"
 #include "trinity_vision2_profile.h"
 #include "trinity_vision2_regs.h"
 
@@ -396,6 +397,8 @@ static void triv2_wakeup_cp(const struct trinity_driver *drv)
 	void *addr =
 		trinity_get_iomem_addr(drv->mmreg_vaddr[0], OFFSET_CP_PROC_SET);
 
+	trace_triv2_wakeup_cp(drv->dev_id);
+
 	trinity_set_bit(BIT_SET_SEND_EVT1, addr);
 }
 
@@ -482,6 +485,8 @@ static void triv2_run_trigger(const struct trinity_driver *drv, int slot)
 	struct triv2_cmd_info *cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
 	struct triv2_req *t_req = cmd_info->reqs[slot];
 
+	trace_triv2_run_trigger(drv->dev_id, slot);
+
 	if (!t_req) {
 		dev_err(drv_to_dev_ptr(drv),
 			"Unable to find the corresponding req");
@@ -546,6 +551,10 @@ static void triv2_handle_cmd_done(struct trinity_driver *drv,
 		req->stat->prev_cycles = cmd->total_cycles;
 		req->stat->num_runs++;
 		req->stat->total_time += req->stat->prev_time;
+
+		trace_triv2_handle_cmd_done(drv->dev_id, cmd->slot,
+					    cmd->total_cycles,
+					    req->stat->prev_time);
 	}
 
 	t_req->total_cycles = cmd->total_cycles;
-- 
2.25.1

