Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A65608D10
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJVL67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:58:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED432CCA1F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:58:48 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mvfr66gQfzmVDL;
        Sat, 22 Oct 2022 19:53:58 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 19:58:46 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 19:58:46 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>, <yangyicong@huawei.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>
Subject: [PATCH V10 1/2] drivers/coresight: Add UltraSoc System Memory Buffer driver
Date:   Sat, 22 Oct 2022 19:59:28 +0800
Message-ID: <20221022115929.7503-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221022115929.7503-1-hejunhao3@huawei.com>
References: <20221022115929.7503-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

This patch adds driver for UltraSoc SMB(System Memory Buffer)
device. SMB provides a way to buffer messages from ETM, and
store these "CPU instructions trace" in system memory.

SMB is developed by UltraSoc technology, which is acquired by
Siemens, and we still use "UltraSoc" to name driver.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Tested-by: JunHao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/Kconfig        |  11 +
 drivers/hwtracing/coresight/Makefile       |   1 +
 drivers/hwtracing/coresight/ultrasoc-smb.c | 635 +++++++++++++++++++++
 drivers/hwtracing/coresight/ultrasoc-smb.h | 116 ++++
 4 files changed, 763 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 45c1eb5dfcb7..05d791cb05e3 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -201,4 +201,15 @@ config CORESIGHT_TRBE
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-trbe.
+
+config ULTRASOC_SMB
+	tristate "Ultrasoc system memory buffer drivers"
+	depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
+	help
+	  This driver provides support for the Ultrasoc system memory buffer (SMB).
+	  SMB is responsible for receiving the trace data from Coresight ETM devices
+	  and storing them to a system buffer.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ultrasoc-smb.
 endif
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index b6c4a48140ec..344dba8d6ff8 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
 obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
 coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 		   coresight-cti-sysfs.o
+obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
new file mode 100644
index 000000000000..a03a55f1f80b
--- /dev/null
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Siemens System Memory Buffer driver.
+ * Copyright(c) 2022, HiSilicon Limited.
+ */
+
+#include <linux/atomic.h>
+#include <linux/acpi.h>
+#include <linux/circ_buf.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "coresight-etm-perf.h"
+#include "coresight-priv.h"
+#include "ultrasoc-smb.h"
+
+DEFINE_CORESIGHT_DEVLIST(sink_devs, "ultra_smb");
+
+#define ULTRASOC_SMB_DSM_UUID	"82ae1283-7f6a-4cbe-aa06-53e8fb24db18"
+
+static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
+{
+	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
+
+	return !(buf_status & SMB_BUF_NOT_EMPTY);
+}
+
+static void smb_buffer_sync_status(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+
+	sdb->wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - sdb->start_addr;
+	sdb->rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR) - sdb->start_addr;
+	if (sdb->wr_offset == sdb->rd_offset && !smb_buffer_is_empty(drvdata))
+		sdb->full = true;
+	else
+		sdb->full = false;
+}
+
+static void smb_reset_buffer_status(struct smb_drv_data *drvdata)
+{
+	writel(SMB_RESET_BUF_STS, drvdata->base + SMB_LB_INT_STS);
+}
+
+/* Purge data remaining in hardware path in case them influence next trace */
+static void smb_purge_data(struct smb_drv_data *drvdata)
+{
+	writel(SMB_PURGED, drvdata->base + SMB_LB_PURGE);
+}
+
+static void smb_update_data_size(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+
+	smb_purge_data(drvdata);
+	smb_buffer_sync_status(drvdata);
+	if (sdb->full) {
+		sdb->data_size = sdb->buf_size;
+		return;
+	}
+
+	sdb->data_size = CIRC_CNT(sdb->wr_offset, sdb->rd_offset, sdb->buf_size);
+}
+
+static int smb_open(struct inode *inode, struct file *file)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+					struct smb_drv_data, miscdev);
+	int ret = 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (local_read(&drvdata->reading)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (atomic_read(drvdata->csdev->refcnt)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	local_set(&drvdata->reading, 1);
+out:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static ssize_t smb_read(struct file *file, char __user *data, size_t len,
+			loff_t *ppos)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+					struct smb_drv_data, miscdev);
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	struct device *dev = &drvdata->csdev->dev;
+	ssize_t to_copy = 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (!sdb->data_size) {
+		smb_update_data_size(drvdata);
+		if (!sdb->data_size)
+			goto out;
+	}
+
+	to_copy = min(sdb->data_size, len);
+
+	/* Copy parts of trace data when read pointer wrap around SMB buffer */
+	if (sdb->rd_offset + to_copy > sdb->buf_size)
+		to_copy = sdb->buf_size - sdb->rd_offset;
+
+	if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset,
+			 to_copy)) {
+		dev_dbg(dev, "Failed to copy data to user\n");
+		to_copy = -EFAULT;
+		goto out;
+	}
+
+	*ppos += to_copy;
+	sdb->data_size -= to_copy;
+	sdb->rd_offset += to_copy;
+	sdb->rd_offset %= sdb->buf_size;
+	writel(sdb->start_addr + sdb->rd_offset,
+	       drvdata->base + SMB_LB_RD_ADDR);
+	dev_dbg(dev, "%zu bytes copied\n", to_copy);
+out:
+	if (!sdb->data_size)
+		smb_reset_buffer_status(drvdata);
+	mutex_unlock(&drvdata->mutex);
+	return to_copy;
+}
+
+static int smb_release(struct inode *inode, struct file *file)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+					struct smb_drv_data, miscdev);
+
+	mutex_lock(&drvdata->mutex);
+	local_set(&drvdata->reading, 0);
+	mutex_unlock(&drvdata->mutex);
+
+	return 0;
+}
+
+static const struct file_operations smb_fops = {
+	.owner		= THIS_MODULE,
+	.open		= smb_open,
+	.read		= smb_read,
+	.release	= smb_release,
+	.llseek		= no_llseek,
+};
+
+smb_reg(read_pos, SMB_LB_RD_ADDR);
+smb_reg(write_pos, SMB_LB_WR_ADDR);
+smb_reg(buf_status, SMB_LB_INT_STS);
+
+static ssize_t buf_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(dev->parent);
+
+	return sysfs_emit(buf, "0x%lx\n", drvdata->sdb.buf_size);
+}
+static DEVICE_ATTR_RO(buf_size);
+
+static struct attribute *smb_sink_attrs[] = {
+	&dev_attr_read_pos.attr,
+	&dev_attr_write_pos.attr,
+	&dev_attr_buf_status.attr,
+	&dev_attr_buf_size.attr,
+	NULL,
+};
+
+static const struct attribute_group smb_sink_group = {
+	.attrs = smb_sink_attrs,
+	.name = "mgmt",
+};
+
+static const struct attribute_group *smb_sink_groups[] = {
+	&smb_sink_group,
+	NULL,
+};
+
+static void smb_enable_hw(struct smb_drv_data *drvdata)
+{
+	writel(SMB_HW_ENABLE, drvdata->base + SMB_GLOBAL_EN);
+}
+
+static void smb_disable_hw(struct smb_drv_data *drvdata)
+{
+	writel(0x0, drvdata->base + SMB_GLOBAL_EN);
+}
+
+static void smb_enable_sysfs(struct coresight_device *csdev)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	if (drvdata->mode != CS_MODE_DISABLED)
+		return;
+
+	smb_enable_hw(drvdata);
+	drvdata->mode = CS_MODE_SYSFS;
+}
+
+static int smb_enable_perf(struct coresight_device *csdev, void *data)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct perf_output_handle *handle = data;
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
+	pid_t pid;
+
+	if (!buf)
+		return -EINVAL;
+
+	/* Get a handle on the pid of the target process */
+	pid = buf->pid;
+
+	/* Device is already in used by other session */
+	if (drvdata->pid != -1 && drvdata->pid != pid)
+		return -EBUSY;
+
+	if (drvdata->pid == -1) {
+		smb_enable_hw(drvdata);
+		drvdata->pid = pid;
+		drvdata->mode = CS_MODE_PERF;
+	}
+
+	return 0;
+}
+
+static int smb_enable(struct coresight_device *csdev, u32 mode, void *data)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret = 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	/* Do nothing, the trace data is reading by other interface now */
+	if (local_read(&drvdata->reading)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Do nothing, the SMB is already enabled as other mode */
+	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		smb_enable_sysfs(csdev);
+		break;
+	case CS_MODE_PERF:
+		ret = smb_enable_perf(csdev, data);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		goto out;
+
+	atomic_inc(csdev->refcnt);
+
+	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
+out:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static int smb_disable(struct coresight_device *csdev)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret = 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (local_read(&drvdata->reading)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (atomic_dec_return(csdev->refcnt)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+
+	smb_disable_hw(drvdata);
+	smb_purge_data(drvdata);
+
+	/* Dissociate from the target process. */
+	drvdata->pid = -1;
+	drvdata->mode = CS_MODE_DISABLED;
+
+	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
+out:
+	mutex_unlock(&drvdata->mutex);
+	return ret;
+}
+
+static void *smb_alloc_buffer(struct coresight_device *csdev,
+			      struct perf_event *event, void **pages,
+			      int nr_pages, bool overwrite)
+{
+	struct cs_buffers *buf;
+	int node;
+
+	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
+	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->snapshot = overwrite;
+	buf->nr_pages = nr_pages;
+	buf->data_pages = pages;
+	buf->pid = task_pid_nr(event->owner);
+
+	return buf;
+}
+
+static void smb_free_buffer(void *config)
+{
+	struct cs_buffers *buf = config;
+
+	kfree(buf);
+}
+
+static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
+				 struct cs_buffers *buf,
+				 unsigned long head,
+				 unsigned long data_size)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	char **dst_pages = (char **)buf->data_pages;
+	unsigned long to_copy;
+	long pg_idx, pg_offset;
+
+	pg_idx = head >> PAGE_SHIFT;
+	pg_offset = head & (PAGE_SIZE - 1);
+
+	while (data_size) {
+		unsigned long pg_space = PAGE_SIZE - pg_offset;
+
+		/* Copy parts of trace data when read pointer wrap around */
+		if (sdb->rd_offset + pg_space > sdb->buf_size)
+			to_copy = sdb->buf_size - sdb->rd_offset;
+		else
+			to_copy = min(data_size, pg_space);
+
+		memcpy(dst_pages[pg_idx] + pg_offset,
+			      sdb->buf_base + sdb->rd_offset, to_copy);
+
+		pg_offset += to_copy;
+		if (pg_offset >= PAGE_SIZE) {
+			pg_offset = 0;
+			pg_idx++;
+			pg_idx %= buf->nr_pages;
+		}
+		data_size -= to_copy;
+		sdb->rd_offset += to_copy;
+		sdb->rd_offset %= sdb->buf_size;
+	}
+
+	sdb->data_size = 0;
+	writel(sdb->start_addr + sdb->rd_offset, drvdata->base + SMB_LB_RD_ADDR);
+
+	/*
+	 * Data remained in link cannot be purged when SMB is full, so
+	 * synchronize the read pointer to write pointer, to make sure
+	 * these remained data won't influence next trace.
+	 */
+	if (sdb->full) {
+		smb_purge_data(drvdata);
+		writel(readl(drvdata->base + SMB_LB_WR_ADDR),
+		       drvdata->base + SMB_LB_RD_ADDR);
+	}
+	smb_reset_buffer_status(drvdata);
+}
+
+static unsigned long smb_update_buffer(struct coresight_device *csdev,
+				       struct perf_output_handle *handle,
+				       void *sink_config)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	struct cs_buffers *buf = sink_config;
+	unsigned long data_size = 0;
+	bool lost = false;
+
+	if (!buf)
+		return 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	/* Don't do anything if another tracer is using this sink. */
+	if (atomic_read(csdev->refcnt) != 1)
+		goto out;
+
+	smb_disable_hw(drvdata);
+	smb_update_data_size(drvdata);
+	data_size = sdb->data_size;
+
+	/*
+	 * The SMB buffer may be bigger than the space available in the
+	 * perf ring buffer (handle->size). If so advance the offset so
+	 * that we get the latest trace data.
+	 */
+	if (data_size > handle->size) {
+		sdb->rd_offset += data_size - handle->size;
+		sdb->rd_offset %= sdb->buf_size;
+		data_size = handle->size;
+		lost = true;
+	}
+
+	smb_sync_perf_buffer(drvdata, buf, handle->head, data_size);
+	if (!buf->snapshot && lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+
+	smb_enable_hw(drvdata);
+out:
+	mutex_unlock(&drvdata->mutex);
+	return data_size;
+}
+
+static const struct coresight_ops_sink smb_cs_ops = {
+	.enable		= smb_enable,
+	.disable	= smb_disable,
+	.alloc_buffer	= smb_alloc_buffer,
+	.free_buffer	= smb_free_buffer,
+	.update_buffer	= smb_update_buffer,
+};
+
+static const struct coresight_ops cs_ops = {
+	.sink_ops	= &smb_cs_ops,
+};
+
+static int smb_init_data_buffer(struct platform_device *pdev,
+				struct smb_data_buffer *sdb)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, SMB_BUF_INFO_RES);
+	if (IS_ERR(res)) {
+		dev_err(&pdev->dev, "SMB device failed to get resource\n");
+		return -EINVAL;
+	}
+
+	sdb->start_addr = res->start & SMB_BASE_LOW_MASK;
+	sdb->buf_size = resource_size(res);
+	if (sdb->buf_size == 0)
+		return -EINVAL;
+
+	/*
+	 * This is a chunk of memory, use classic mapping with better
+	 * performance.
+	 */
+	base = devm_memremap(&pdev->dev, sdb->start_addr, sdb->buf_size,
+				MEMREMAP_WB);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	sdb->buf_base = base;
+
+	return 0;
+}
+
+static void smb_init_hw(struct smb_drv_data *drvdata)
+{
+	/* First disable smb and clear the status of SMB buffer */
+	smb_reset_buffer_status(drvdata);
+	smb_disable_hw(drvdata);
+	smb_purge_data(drvdata);
+
+	writel(SMB_BUF_CFG_STREAMING, drvdata->base + SMB_LB_CFG_LO);
+	writel(SMB_MSG_FILTER, drvdata->base + SMB_LB_CFG_HI);
+	writel(SMB_GLOBAL_CFG, drvdata->base + SMB_CFG_REG);
+	writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
+	writel(SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
+}
+
+static int smb_register_sink(struct platform_device *pdev,
+			     struct smb_drv_data *drvdata)
+{
+	struct coresight_platform_data *pdata = NULL;
+	struct coresight_desc desc = { 0 };
+	int ret;
+
+	pdata = coresight_get_platform_data(&pdev->dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	desc.type = CORESIGHT_DEV_TYPE_SINK;
+	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
+	desc.ops = &cs_ops;
+	desc.pdata = pdata;
+	desc.dev = &pdev->dev;
+	desc.groups = smb_sink_groups;
+	desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);
+	if (!desc.name) {
+		dev_err(&pdev->dev, "Failed to alloc coresight device name");
+		return -ENOMEM;
+	}
+	desc.access = CSDEV_ACCESS_IOMEM(drvdata->base);
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	drvdata->miscdev.name = desc.name;
+	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->miscdev.fops = &smb_fops;
+	ret = misc_register(&drvdata->miscdev);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		dev_err(&pdev->dev, "Failed to register misc, ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
+static void smb_unregister_sink(struct smb_drv_data *drvdata)
+{
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+}
+
+static int smb_config_inport(struct device *dev, bool enable)
+{
+	u64 func = enable ? 1 : 0;
+	union acpi_object *obj;
+	guid_t guid;
+	u64 rev = 0;
+
+	/*
+	 * Using DSM calls to enable/disable ultrasoc hardwares on
+	 * tracing path, to prevent ultrasoc packet format being exposed.
+	 */
+	if (guid_parse(ULTRASOC_SMB_DSM_UUID, &guid)) {
+		dev_err(dev, "Get GUID failed\n");
+		return -EINVAL;
+	}
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &guid, rev, func, NULL);
+	if (!obj)
+		dev_err(dev, "ACPI handle failed\n");
+	else
+		ACPI_FREE(obj);
+
+	return 0;
+}
+
+static int smb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct smb_drv_data *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->base = devm_platform_ioremap_resource(pdev, SMB_BASE_ADDR_RES);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(dev, "Failed to ioremap resource\n");
+		return PTR_ERR(drvdata->base);
+	}
+
+	ret = smb_init_data_buffer(pdev, &drvdata->sdb);
+	if (ret) {
+		dev_err(dev, "Failed to init buffer, ret = %d\n", ret);
+		return ret;
+	}
+
+	smb_init_hw(drvdata);
+	mutex_init(&drvdata->mutex);
+	drvdata->pid = -1;
+
+	ret = smb_register_sink(pdev, drvdata);
+	if (ret) {
+		dev_err(dev, "Failed to register smb sink\n");
+		return ret;
+	}
+
+	ret = smb_config_inport(dev, true);
+	if (ret) {
+		smb_unregister_sink(drvdata);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+	return 0;
+}
+
+static int smb_remove(struct platform_device *pdev)
+{
+	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = smb_config_inport(&pdev->dev, false);
+	if (ret)
+		return ret;
+
+	smb_unregister_sink(drvdata);
+	return 0;
+}
+
+static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
+	{"HISI03A1", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
+
+static struct platform_driver smb_driver = {
+	.driver = {
+		.name = "ultrasoc-smb",
+		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = smb_probe,
+	.remove = smb_remove,
+};
+module_platform_driver(smb_driver);
+
+MODULE_DESCRIPTION("UltraSoc SMB CoreSight driver");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
+MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
new file mode 100644
index 000000000000..2f2b90fdb128
--- /dev/null
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Siemens System Memory Buffer driver.
+ * Copyright(c) 2022, HiSilicon Limited.
+ */
+
+#ifndef _ULTRASOC_SMB_H
+#define _ULTRASOC_SMB_H
+
+#include <linux/coresight.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+
+/* Offset of SMB logical buffer registers */
+#define SMB_CFG_REG		0x00
+#define SMB_GLOBAL_EN		0x04
+#define SMB_GLOBAL_INT		0x08
+#define SMB_LB_CFG_LO		0x40
+#define SMB_LB_CFG_HI		0x44
+#define SMB_LB_INT_CTRL		0x48
+#define SMB_LB_INT_STS		0x4c
+#define SMB_LB_LIMIT		0x58
+#define SMB_LB_RD_ADDR		0x5c
+#define SMB_LB_WR_ADDR		0x60
+#define SMB_LB_PURGE		0x64
+
+/* Set SMB_CFG_REG register */
+#define SMB_BURST_LEN		GENMASK(7, 4)
+#define SMB_IDLE_PRD		GENMASK(15, 12)
+#define SMB_MEM_WR		GENMASK(17, 16)
+#define SMB_MEM_RD		(GENMASK(26, 25) | GENMASK(23, 22))
+#define SMB_GLOBAL_CFG		(SMB_IDLE_PRD |	SMB_MEM_WR | SMB_MEM_RD | \
+				 SMB_BURST_LEN)
+
+/* Set SMB_GLOBAL_INT register */
+#define SMB_INT_EN		BIT(0)
+#define SMB_INT_TYPE_PULSE	BIT(1)
+#define SMB_INT_POLARITY_HIGH	BIT(2)
+#define SMB_GLB_INT_CFG		(SMB_INT_EN | SMB_INT_TYPE_PULSE |	\
+				 SMB_INT_POLARITY_HIGH)
+
+/* Set SMB_LB_CFG_LO register */
+#define SMB_BUF_EN		BIT(0)
+#define SMB_BUF_SINGLE_END	BIT(1)
+#define SMB_BUF_INIT		BIT(8)
+#define SMB_BUF_CONTINUOUS	BIT(11)
+#define SMB_FILTER_FLOW		GENMASK(19, 16)
+#define SMB_BUF_CFG_STREAMING	(SMB_BUF_INIT | SMB_BUF_CONTINUOUS |	\
+				 SMB_FILTER_FLOW | SMB_BUF_SINGLE_END |	\
+				 SMB_BUF_EN)
+
+#define SMB_BASE_LOW_MASK	GENMASK(31, 0)
+
+/* Set SMB_LB_CFG_HI register */
+#define SMB_MSG_FILTER		GENMASK(15, 8)
+
+/* Set SMB_LB_INT_CTRL */
+#define SMB_BUF_INT_EN		BIT(0)
+#define SMB_BUF_NOTE_MASK	GENMASK(11, 8)
+#define SMB_BUF_INT_CFG		(SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
+
+#define SMB_BUF_NOT_EMPTY       BIT(0)
+#define SMB_RESET_BUF_STS       GENMASK(3, 0)
+#define SMB_PURGED              BIT(0)
+#define SMB_HW_ENABLE           BIT(0)
+
+#define SMB_BASE_ADDR_RES       0
+#define SMB_BUF_INFO_RES        1
+
+/**
+ * struct smb_data_buffer - Details of the buffer used by SMB
+ * @buf_base:	Memory mapped base address of SMB.
+ * @start_addr:	SMB buffer start Physical address.
+ * @buf_size:	Size of the buffer.
+ * @data_size:	Size of Trace data copy to userspace.
+ * @rd_offset:	Offset of the read pointer in the buffer.
+ * @wr_offset:	Offset of the write pointer in the buffer.
+ * @status:	Status of SMB buffer.
+ */
+struct smb_data_buffer {
+	void __iomem *buf_base;
+	u32 start_addr;
+	unsigned long buf_size;
+	unsigned long data_size;
+	unsigned long rd_offset;
+	unsigned long wr_offset;
+	bool full;
+};
+
+/**
+ * struct smb_drv_data - specifics associated to an SMB component
+ * @base:	Memory mapped base address for SMB component.
+ * @csdev:	Component vitals needed by the framework.
+ * @sdb:	Data buffer for SMB.
+ * @miscdev:	Specifics to handle "/dev/xyz.smb" entry.
+ * @mutex:	Control data access to one at a time.
+ * @reading:	Synchronise user space access to SMB buffer.
+ * @pid:	Process ID of the process being monitored by the
+ * 		session that is using this component.
+ * @mode:	how this SMB is being used, perf mode or sysfs mode.
+ */
+struct smb_drv_data {
+	void __iomem *base;
+	struct coresight_device	*csdev;
+	struct smb_data_buffer sdb;
+	struct miscdevice miscdev;
+	struct mutex mutex;
+	local_t reading;
+	pid_t pid;
+	u32 mode;
+};
+
+#define smb_reg(name, offset)                                   \
+	coresight_simple_reg32(struct smb_drv_data, name, offset)
+
+#endif
-- 
2.33.0

