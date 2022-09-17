Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176295BB6EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIQHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIQHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B66459A7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220917072400epoutp04e616ddd2340aec131aa65dae9d23e00a~VlPpW-9_q2904629046epoutp04b
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:24:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220917072400epoutp04e616ddd2340aec131aa65dae9d23e00a~VlPpW-9_q2904629046epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399440;
        bh=DuFz+YEWnDIdkeK1uiAdaI/h/uWoctHlSqnVpakc+l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJtk19CQhNlDrUjvYeiGwU8WuLUhfi1YkW/60m00BzmjUwdWYiY+tXxLzfBLiz3O3
         NEjqco0gxu26YNw5Pm6PhrqV9/QvgY7AxZJKWPrbLDAZkKFBlH07Y5WFQqmaWxqAmR
         d8zE9NEMSRlVxecIFew7/ijgI/oHLVi7bEtDNhJQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220917072359epcas1p22a6a93e9f3e736ff5b91b4e5b87bb03b~VlPoX7oGz2419324193epcas1p22;
        Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.231]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MV2Vk1KJYz4x9Pt; Sat, 17 Sep
        2022 07:23:58 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        29.40.07146.E0675236; Sat, 17 Sep 2022 16:23:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p2735d98b043e2382aba1173c6b52af81a~VlPm6WE6y1789517895epcas1p2r;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp1aaca354cfaf1c1d6cba3416536df1c79~VlPm5kpeX0556805568epsmtrp1c;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a35-205ff70000021bea-7c-6325760e5cb1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.45.14392.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip2d6d8624ef35a44bed66c02c90b0a6a9c~VlPmsIjF93199931999epsmtip2U;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 05/13] trinity: Add debugfs module
Date:   Sat, 17 Sep 2022 16:23:48 +0900
Message-Id: <20220917072356.2255620-6-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTQJevTDXZ4OEmVou/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xvq9vewFf30r1v7+wt7AONehi5GDQ0LARGLVtLAuRi4OIYEd
        jBIr921gh3A+MUpMft/M1MXICeR8Y5SYusURxAZpuN52kRmiaC+jxMML7SwQRZ+BnD0CIDab
        gKrEzBlr2EFsEYFyieaNJ8BsZoEciSd3mphBNgsLmEocmxIKEmYBKv99dh4jiM0rYC1x6Np0
        NhCbU8BG4uamJhaIuKDEyZlPWCDGyEs0b50NdoOEwFd2icNf7zNDfOMi8e2+D8SdwhKvjm9h
        h7ClJF72t0HZ2RJTOhaxQNgFEueeb4VqNZa4uCIFxGQW0JRYv0sfokJRYufvuYwQW/kk3n3t
        YYWo5pXoaBOCKFGSWPLnMNRwCYmpM74xQdgeEuu+PGGCBFQ/o8T3fw2MExjlZyF5ZhaSZ2Yh
        bF7AyLyKUSy1oDg3PbXYsMAQHqHJ+bmbGMGJUst0B+PEtx/0DjEycTAeYpTgYFYS4VX1VEkW
        4k1JrKxKLcqPLyrNSS0+xGgKDN6JzFKiyfnAVJ1XEm9oYmlgYmZkbGJhaGaoJM6rp82YLCSQ
        nliSmp2aWpBaBNPHxMEp1cBUdaNUbKHzsxTGOxON/oaf41G6PeEkR3b/BDXF1HzuaCOp1TOK
        LXtmuO5pPJ0+VaVlYU27KotKFNcx7zjfJOu79/V0HG5VN7+J7xdTslrSIMytJMpgz3nrT/gc
        21NrZXmnev49n7SSd73FDFPes3e+KmXue+Bc9X2J+XZTl7VhFft3vujvtyr/5GGx9N2rkrZt
        D77ve2N5utrjzaLDk3Q0VKWyRW/P4lhsItS0e1n0qdlXOG0XFurm/A3Wv/JzZpxdePuRhZsT
        5mzSqZ23lXF+v3Zk4KXMyE7x629PXOYOSUl5ovkmbPn0oNwWTa1/q3Nc3/0TLd/lfVx21+f3
        Oj8s7Jm+mxVsStP8OW/57ctKLMUZiYZazEXFiQAR30hmHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywbQlKhZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfG+r297AV/fSvW/v7C3sA416GLkZND
        QsBE4nrbReYuRi4OIYHdjBKbFjWzQSQkJDbdWw6U4ACyhSUOHy6GqPnIKLHw0iN2kBo2AVWJ
        mTPWgNkiArUSB4/OZwaxmQUKJGY/nckC0issYCpxbEooSJgFqPz32XmMIDavgLXEoWvTwVZx
        CthI3NzUxAJiCwHFZ0+fywRRIyhxcuYTFoiR8hLNW2czT2Dkn4UkNQtJagEj0ypGydSC4tz0
        3GLDAsO81HK94sTc4tK8dL3k/NxNjODA1tLcwbh91Qe9Q4xMHIyHGCU4mJVEeFU9VZKFeFMS
        K6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYMo4OiUlas2asH79
        whBTk0Xd0+cc0374qnrCx2N/7gbw7qx89219WRyLY6Xo/8bt3UFWv2t2amz0vrfo951lx3lE
        txisnp1xWfnf4sab8y3X6d2W+pvhteXs3r/18yS/ej88Mn3esbXb66WVZu9hk5aOE9X+p7iW
        1+NJJy//m9Pth/YcKnngvH7Gv4TGsrRA57isxlWZzPebDuR8WOXt69q29knWW55TP3ujWc5t
        1zl6bK308q2KbjbOV/Zq8GtmhXIsuB+fHdA44++Rji6t3/UFxu+let+ET1yYXPFb8tkEt9p0
        u/V9OkWMR8/8vleaNUk2I37bZfF1c5ZonlxZ+iJhwgaW2t5dLgtd25xuSP1UYinOSDTUYi4q
        TgQAsy/wu9sCAAA=
X-CMS-MailID: 20220917072357epcas1p2735d98b043e2382aba1173c6b52af81a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p2735d98b043e2382aba1173c6b52af81a
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p2735d98b043e2382aba1173c6b52af81a@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides debugfs feature.

It create debugfs entry for driver and provides apis to print
out messages, model info and input info. Default directory
of debugfs is named 'trinity', and each driver has own
debug file.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
---
 drivers/misc/trinity/Makefile        |   1 +
 drivers/misc/trinity/trinity_debug.c | 331 +++++++++++++++++++++++++++
 2 files changed, 332 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_debug.c

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index 2a8c4fed135e..5d3e89dd0dd7 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 trinity-y := trinity.o
 trinity-y += trinity_dma.o trinity_hwmem.o
 trinity-y += trinity_sched.o
+trinity-y += trinity_debug.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity_debug.c b/drivers/misc/trinity/trinity_debug.c
new file mode 100644
index 000000000000..9add728a101b
--- /dev/null
+++ b/drivers/misc/trinity/trinity_debug.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Implementation of debug functions for trinity drivers
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "trinity_common.h"
+
+#define TRINITY_DEVVER(drv) (drv->desc->ver >> TRINITY_SHIFT_DEV)
+#define TRINITY_DEBUGFS_DIR ("trinity")
+#define TRINITY_DEBUGFS_MAX (1024UL)
+#define TRINITY_DEBUGFS_LENGTH (255)
+
+struct trinity_debugfs_msg {
+	char msg[TRINITY_DEBUGFS_LENGTH + 1]; /* including NULL */
+};
+
+struct trinity_debugfs_entry {
+	struct dentry *dentry;
+	spinlock_t lock;
+
+	unsigned long msg_max;
+	unsigned long msg_num;
+	unsigned long msg_off;
+
+	struct trinity_dma msg_buf;
+};
+
+static struct dentry *trinity_debugfs;
+
+static size_t trinity_debug_append_app_id(struct trinity_driver *drv, char *msg)
+{
+	return snprintf(msg, TRINITY_DEBUGFS_LENGTH, "[%d] ",
+			trinity_get_app_id());
+}
+
+static char *trinity_debug_get_msg_buf(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct trinity_debugfs_msg *buf;
+
+	if (!entry || entry->msg_max == 0)
+		return NULL;
+
+	spin_lock(&entry->lock);
+	if (entry->msg_num == entry->msg_max) {
+		buf = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.addr)[entry->msg_off];
+		entry->msg_off = (entry->msg_off + 1) % entry->msg_max;
+	} else {
+		buf = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.addr)[entry->msg_num++];
+	}
+	spin_unlock(&entry->lock);
+
+	memset(buf, '\x00', sizeof(*buf));
+	return buf->msg;
+}
+
+/**
+ * trinity_debug_dump_msg() - Dump trinity debug message
+ *
+ * @drv: an instance of the trinity driver
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_msg(struct trinity_driver *drv, const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+}
+
+/**
+ * trinity_debug_dump_input() - Dump trinity input data
+ *
+ * @drv: an instance of the trinity driver
+ * @input: an instance of the trinity model
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_model(struct trinity_driver *drv,
+			      const struct trinity_model *model,
+			      const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+
+	len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\n\tid(0x%llx) dbuf_fd(%d) program_offset_addr(0x%llx) program_size(0x%llx)\n",
+			model->config.id, model->config.dbuf_fd,
+			model->config.program_offset_addr, model->config.program_size);
+	len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\tmetadata_dbuf_fd(%d) metadata_ext_dbuf_fd(%d) metadata_ext_size(0x%llx)",
+			model->config.metadata_dbuf_fd,
+			model->config.metadata_ext_dbuf_fd,
+			model->config.metadata_ext_size);
+}
+
+/**
+ * trinity_debug_dump_input() - Dump trinity input data
+ *
+ * @drv: an instance of the trinity driver
+ * @input: an instance of the trinity input
+ * @fmt: tag message format
+ */
+void trinity_debug_dump_input(struct trinity_driver *drv,
+			      const struct trinity_input *input,
+			      const char *fmt, ...)
+{
+	char *msg;
+	size_t len;
+	va_list args;
+
+	msg = trinity_debug_get_msg_buf(drv);
+	if (msg == NULL)
+		return;
+
+	len = trinity_debug_append_app_id(drv, msg);
+
+	va_start(args, fmt);
+	len += vsnprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len, fmt, args);
+	va_end(args);
+
+	len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\n\tdbuf_fd(%d) model_id(0x%llx)\n",
+			input->config.dbuf_fd, input->config.model_id);
+	len += snprintf(msg + len, TRINITY_DEBUGFS_LENGTH - len,
+			"\ttimeout_ms(%lld) priority(%u) num_segments(%u) input_mode(%d) output_mode(%d)",
+			input->config.timeout_ms, input->config.priority,
+			input->config.num_segments, input->config.input_mode,
+			input->config.output_mode);
+}
+
+static int trinity_debugfs_show(struct seq_file *s, void *unsed)
+{
+	struct trinity_driver *drv = s->private;
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct trinity_debugfs_msg *msg;
+	unsigned long i, offset;
+
+	spin_lock(&entry->lock);
+	for (i = 0; i < entry->msg_num; i++) {
+		offset = (entry->msg_off + i) % entry->msg_max;
+		msg = &((struct trinity_debugfs_msg *)
+				entry->msg_buf.addr)[offset];
+
+		seq_puts(s, msg->msg);
+		seq_puts(s, "\n");
+	}
+	spin_unlock(&entry->lock);
+
+	return 0;
+}
+
+static int trinity_debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, trinity_debugfs_show, inode->i_private);
+}
+
+static const struct file_operations trinity_debugfs_fops = {
+	.open = trinity_debugfs_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+/**
+ * trinity_debug_add() - Add trinity debug file system entry
+ *
+ * @drv: an instance of the trinity driver
+ */
+int trinity_debug_add(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry;
+	struct dentry *dentry;
+	const char *name = drv->name;
+
+	if (name == NULL)
+		return -EINVAL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	dentry = debugfs_create_file_unsafe(name, 0400, trinity_debugfs, drv,
+					    &trinity_debugfs_fops);
+	if (IS_ERR(dentry)) {
+		kfree(entry);
+		return PTR_ERR(dentry);
+	}
+
+	entry->dentry = dentry;
+	spin_lock_init(&entry->lock);
+
+	drv->debugfs_pdata = entry;
+
+	return 0;
+}
+
+/**
+ * trinity_debug_remove() - Remove trinity debug file system entry
+ *
+ * @drv: an instance of the trinity driver
+ */
+void trinity_debug_remove(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+
+	trinity_debug_clear(drv, 0);
+
+	debugfs_remove(entry->dentry);
+	kfree(entry);
+
+	drv->debugfs_pdata = NULL;
+}
+
+/**
+ * trinity_debug_clear() - Clear debug message entity
+ *
+ * @drv: an instance of the trinity driver
+ * @msg_max: reset max size of debug message entity
+ */
+void trinity_debug_clear(struct trinity_driver *drv, unsigned long msg_max)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	struct device *dev = drv_to_dev_ptr(drv);
+	size_t size;
+
+	/* maximum size limit: 256KiB */
+	if (msg_max > TRINITY_DEBUGFS_MAX) {
+		dev_err(dev, "Too much debugfs entries (limit: %lu)",
+			TRINITY_DEBUGFS_MAX);
+		return;
+	}
+
+	spin_lock(&entry->lock);
+
+	/* disable debugfs temporally */
+	trinity_dma_free(dev, &entry->msg_buf);
+	entry->msg_max = 0;
+	entry->msg_num = 0;
+	entry->msg_off = 0;
+
+	if (msg_max == 0)
+		goto out;
+
+	/* reallocate debugfs buffer */
+	size = PAGE_ALIGN(msg_max * sizeof(struct trinity_debugfs_msg));
+	if (trinity_dma_alloc(dev, size, &entry->msg_buf) < 0) {
+		dev_warn(dev, "No available memory for debugfs");
+		goto out;
+	}
+	/* more available entries due to page size alignment */
+	entry->msg_max = size / sizeof(struct trinity_debugfs_msg);
+
+out:
+	spin_unlock(&entry->lock);
+}
+
+/**
+ * trinity_debug_exit() - Get max size of debug message entity
+ *
+ * @drv: an instance of the trinity driver
+ *
+ * Return: max size of debug message entity
+ */
+unsigned long trinity_debug_get_max(struct trinity_driver *drv)
+{
+	struct trinity_debugfs_entry *entry = drv->debugfs_pdata;
+	unsigned long msg_max;
+
+	spin_lock(&entry->lock);
+	msg_max = entry->msg_max;
+	spin_unlock(&entry->lock);
+
+	return msg_max;
+}
+
+/**
+ * trinity_debug_exit() - Initialize debug file system
+ */
+int trinity_debug_init(void)
+{
+	struct dentry *entry;
+
+	entry = debugfs_create_dir(TRINITY_DEBUGFS_DIR, NULL);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	trinity_debugfs = entry;
+
+	return 0;
+}
+
+/**
+ * trinity_debug_exit() - Exit debug file system
+ */
+void trinity_debug_exit(void)
+{
+	debugfs_remove_recursive(trinity_debugfs);
+}
-- 
2.25.1

