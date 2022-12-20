Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE631651D57
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiLTJ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLTJ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:29:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB776253;
        Tue, 20 Dec 2022 01:29:47 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Nbrq80RJpzRqCM;
        Tue, 20 Dec 2022 17:28:36 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 17:29:45 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi6124@gmail.com>, <f.fangjian@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH v15 1/2] drivers/coresight: Add UltraSoc System Memory Buffer driver
Date:   Tue, 20 Dec 2022 17:29:44 +0800
Message-ID: <20221220092945.30722-2-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221220092945.30722-1-hejunhao3@huawei.com>
References: <20221220092945.30722-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Add driver for UltraSoc SMB(System Memory Buffer) device.
SMB provides a way to buffer messages from ETM, and store
these "CPU instructions trace" in system memory.
The SMB device is identifier as ACPI HID "HISI03A1". Device
system memory address resources are allocated using the _CRS
method and buffer modes is the circular buffer mode.

SMB is developed by UltraSoc technology, which is acquired by
Siemens, and we still use "UltraSoc" to name driver.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Tested-by: JunHao He <hejunhao3@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/hwtracing/coresight/Kconfig        |  12 +
 drivers/hwtracing/coresight/Makefile       |   1 +
 drivers/hwtracing/coresight/ultrasoc-smb.c | 648 +++++++++++++++++++++
 drivers/hwtracing/coresight/ultrasoc-smb.h | 125 ++++
 4 files changed, 786 insertions(+)
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 45c1eb5dfcb7..ba035d7894e0 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -201,4 +201,16 @@ config CORESIGHT_TRBE
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-trbe.
+
+config ULTRASOC_SMB
+	tristate "Ultrasoc system memory buffer drivers"
+	depends on ACPI || COMPILE_TEST
+	depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
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
index 000000000000..2560fdbb8ebf
--- /dev/null
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -0,0 +1,648 @@
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
+static bool smb_buffer_not_empty(struct smb_drv_data *drvdata)
+{
+	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS_REG);
+
+	return FIELD_GET(SMB_LB_INT_STS_NOT_EMPTY_MSK, buf_status);
+}
+
+static void smb_update_data_size(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	u32 buf_wrptr;
+
+	buf_wrptr = readl(drvdata->base + SMB_LB_WR_ADDR_REG) -
+			  sdb->buf_hw_base;
+
+	/* Buffer is full */
+	if (buf_wrptr == sdb->buf_rdptr && smb_buffer_not_empty(drvdata)) {
+		sdb->data_size = sdb->buf_size;
+		return;
+	}
+
+	/* The buffer mode is circular buffer mode */
+	sdb->data_size = CIRC_CNT(buf_wrptr, sdb->buf_rdptr,
+				  sdb->buf_size);
+}
+
+/*
+ * The read pointer adds @nbytes bytes (may round up to the beginning)
+ * after the data is read or discarded, while needing to update the
+ * available data size.
+ */
+static void smb_update_read_ptr(struct smb_drv_data *drvdata, u32 nbytes)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+
+	sdb->buf_rdptr += nbytes;
+	sdb->buf_rdptr %= sdb->buf_size;
+	writel(sdb->buf_hw_base + sdb->buf_rdptr,
+	       drvdata->base + SMB_LB_RD_ADDR_REG);
+
+	sdb->data_size -= nbytes;
+}
+
+static void smb_reset_buffer(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	u32 write_ptr;
+
+	/*
+	 * We must flush and discard any data left in hardware path
+	 * to avoid corrupting the next session.
+	 * Note: The write pointer will never exceed the read pointer.
+	 */
+	writel(SMB_LB_PURGE_PURGED, drvdata->base + SMB_LB_PURGE_REG);
+
+	/* Reset SMB logical buffer status flags */
+	writel(SMB_LB_INT_STS_RESET, drvdata->base + SMB_LB_INT_STS_REG);
+
+	write_ptr = readl(drvdata->base + SMB_LB_WR_ADDR_REG);
+
+	/* Do nothing, not data left in hardware path */
+	if (!write_ptr || write_ptr == sdb->buf_rdptr + sdb->buf_hw_base)
+		return;
+
+	/*
+	 * The SMB_LB_WR_ADDR_REG register is read-only,
+	 * Synchronize the read pointer to write pointer.
+	 */
+	writel(write_ptr, drvdata->base + SMB_LB_RD_ADDR_REG);
+	sdb->buf_rdptr = write_ptr - sdb->buf_hw_base;
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
+	if (drvdata->reading) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (atomic_read(drvdata->csdev->refcnt)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	smb_update_data_size(drvdata);
+
+	drvdata->reading = true;
+out:
+	mutex_unlock(&drvdata->mutex);
+
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
+	if (!len)
+		return 0;
+
+	mutex_lock(&drvdata->mutex);
+
+	if (!sdb->data_size)
+		goto out;
+
+	to_copy = min(sdb->data_size, len);
+
+	/* Copy parts of trace data when read pointer wrap around SMB buffer */
+	if (sdb->buf_rdptr + to_copy > sdb->buf_size)
+		to_copy = sdb->buf_size - sdb->buf_rdptr;
+
+	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
+		dev_dbg(dev, "Failed to copy data to user\n");
+		to_copy = -EFAULT;
+		goto out;
+	}
+
+	*ppos += to_copy;
+
+	smb_update_read_ptr(drvdata, to_copy);
+
+	dev_dbg(dev, "%zu bytes copied\n", to_copy);
+out:
+	if (!sdb->data_size)
+		smb_reset_buffer(drvdata);
+	mutex_unlock(&drvdata->mutex);
+
+	return to_copy;
+}
+
+static int smb_release(struct inode *inode, struct file *file)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+					struct smb_drv_data, miscdev);
+
+	mutex_lock(&drvdata->mutex);
+	drvdata->reading = false;
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
+	coresight_simple_reg32(read_pos, SMB_LB_RD_ADDR_REG),
+	coresight_simple_reg32(write_pos, SMB_LB_WR_ADDR_REG),
+	coresight_simple_reg32(buf_status, SMB_LB_INT_STS_REG),
+	&dev_attr_buf_size.attr,
+	NULL
+};
+
+static const struct attribute_group smb_sink_group = {
+	.attrs = smb_sink_attrs,
+	.name = "mgmt",
+};
+
+static const struct attribute_group *smb_sink_groups[] = {
+	&smb_sink_group,
+	NULL
+};
+
+static void smb_enable_hw(struct smb_drv_data *drvdata)
+{
+	writel(SMB_GLB_EN_HW_ENABLE, drvdata->base + SMB_GLB_EN_REG);
+}
+
+static void smb_disable_hw(struct smb_drv_data *drvdata)
+{
+	writel(0x0, drvdata->base + SMB_GLB_EN_REG);
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
+	if (drvdata->reading) {
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
+
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
+	if (drvdata->reading) {
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
+
+	/* Dissociate from the target process. */
+	drvdata->pid = -1;
+	drvdata->mode = CS_MODE_DISABLED;
+
+	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
+out:
+	mutex_unlock(&drvdata->mutex);
+
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
+				 unsigned long head)
+{
+	struct smb_data_buffer *sdb = &drvdata->sdb;
+	char **dst_pages = (char **)buf->data_pages;
+	unsigned long to_copy;
+	long pg_idx, pg_offset;
+
+	pg_idx = head >> PAGE_SHIFT;
+	pg_offset = head & (PAGE_SIZE - 1);
+
+	while (sdb->data_size) {
+		unsigned long pg_space = PAGE_SIZE - pg_offset;
+
+		to_copy = min(sdb->data_size, pg_space);
+
+		/* Copy parts of trace data when read pointer wrap around */
+		if (sdb->buf_rdptr + to_copy > sdb->buf_size)
+			to_copy = sdb->buf_size - sdb->buf_rdptr;
+
+		memcpy(dst_pages[pg_idx] + pg_offset,
+			      sdb->buf_base + sdb->buf_rdptr, to_copy);
+
+		pg_offset += to_copy;
+		if (pg_offset >= PAGE_SIZE) {
+			pg_offset = 0;
+			pg_idx++;
+			pg_idx %= buf->nr_pages;
+		}
+		smb_update_read_ptr(drvdata, to_copy);
+	}
+
+	smb_reset_buffer(drvdata);
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
+
+	/*
+	 * The SMB buffer may be bigger than the space available in the
+	 * perf ring buffer (handle->size). If so advance the offset so
+	 * that we get the latest trace data.
+	 */
+	if (sdb->data_size > handle->size) {
+		smb_update_read_ptr(drvdata, sdb->data_size - handle->size);
+		lost = true;
+	}
+
+	data_size = sdb->data_size;
+	smb_sync_perf_buffer(drvdata, buf, handle->head);
+	if (!buf->snapshot && lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+out:
+	mutex_unlock(&drvdata->mutex);
+
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
+	void *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, SMB_BUF_ADDR_RES);
+	if (IS_ERR(res)) {
+		dev_err(&pdev->dev, "SMB device failed to get resource\n");
+		return -EINVAL;
+	}
+
+	sdb->buf_rdptr = 0;
+	sdb->buf_hw_base = FIELD_GET(SMB_BUF_ADDR_LO_MSK, res->start);
+	sdb->buf_size = resource_size(res);
+	if (sdb->buf_size == 0)
+		return -EINVAL;
+
+	/*
+	 * This is a chunk of memory, use classic mapping with better
+	 * performance.
+	 */
+	base = devm_memremap(&pdev->dev, sdb->buf_hw_base, sdb->buf_size,
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
+	smb_disable_hw(drvdata);
+	smb_reset_buffer(drvdata);
+
+	writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
+	writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
+	writel(SMB_GLB_CFG_DEFAULT, drvdata->base + SMB_GLB_CFG_REG);
+	writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLB_INT_REG);
+	writel(SMB_LB_INT_CTRL_CFG, drvdata->base + SMB_LB_INT_CTRL_REG);
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
+	if (!obj) {
+		dev_err(dev, "ACPI handle failed\n");
+		return -ENODEV;
+	}
+
+	ACPI_FREE(obj);
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
+	drvdata->base = devm_platform_ioremap_resource(pdev, SMB_REG_ADDR_RES);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(dev, "Failed to ioremap resource\n");
+		return PTR_ERR(drvdata->base);
+	}
+
+	smb_init_hw(drvdata);
+
+	ret = smb_init_data_buffer(pdev, &drvdata->sdb);
+	if (ret) {
+		dev_err(dev, "Failed to init buffer, ret = %d\n", ret);
+		return ret;
+	}
+
+	mutex_init(&drvdata->mutex);
+	drvdata->pid = -1;
+
+	ret = smb_register_sink(pdev, drvdata);
+	if (ret) {
+		dev_err(dev, "Failed to register SMB sink\n");
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
+
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
+
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
+	{"HISI03A1", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
+#endif
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
index 000000000000..7dfbe42e37a0
--- /dev/null
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Siemens System Memory Buffer driver.
+ * Copyright(c) 2022, HiSilicon Limited.
+ */
+
+#ifndef _ULTRASOC_SMB_H
+#define _ULTRASOC_SMB_H
+
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+
+/* Offset of SMB global registers */
+#define SMB_GLB_CFG_REG		0x00
+#define SMB_GLB_EN_REG		0x04
+#define SMB_GLB_INT_REG		0x08
+
+/* Offset of SMB logical buffer registers */
+#define SMB_LB_CFG_LO_REG	0x40
+#define SMB_LB_CFG_HI_REG	0x44
+#define SMB_LB_INT_CTRL_REG	0x48
+#define SMB_LB_INT_STS_REG	0x4c
+#define SMB_LB_RD_ADDR_REG	0x5c
+#define SMB_LB_WR_ADDR_REG	0x60
+#define SMB_LB_PURGE_REG	0x64
+
+/* Set global config register */
+#define SMB_GLB_CFG_BURST_LEN_MSK	GENMASK(11, 4)
+#define SMB_GLB_CFG_IDLE_PRD_MSK	GENMASK(15, 12)
+#define SMB_GLB_CFG_MEM_WR_MSK		GENMASK(21, 16)
+#define SMB_GLB_CFG_MEM_RD_MSK		GENMASK(27, 22)
+#define SMB_GLB_CFG_DEFAULT	(FIELD_PREP(SMB_GLB_CFG_BURST_LEN_MSK, 0xf) | \
+				 FIELD_PREP(SMB_GLB_CFG_IDLE_PRD_MSK, 0xf) | \
+				 FIELD_PREP(SMB_GLB_CFG_MEM_WR_MSK, 0x3) | \
+				 FIELD_PREP(SMB_GLB_CFG_MEM_RD_MSK, 0x1b))
+
+#define SMB_GLB_EN_HW_ENABLE	BIT(0)
+
+/* Set global interrupt control register */
+#define SMB_GLB_INT_EN		BIT(0)
+#define SMB_GLB_INT_PULSE	BIT(1) /* Interrupt type: 1 - Pulse */
+#define SMB_GLB_INT_ACT_H	BIT(2) /* Interrupt polarity: 1 - Active high */
+#define SMB_GLB_INT_CFG		(SMB_GLB_INT_EN | SMB_GLB_INT_PULSE | \
+				 SMB_GLB_INT_ACT_H)
+
+/* Set logical buffer config register lower 32 bits */
+#define SMB_LB_CFG_LO_EN		BIT(0)
+#define SMB_LB_CFG_LO_SINGLE_END	BIT(1)
+#define SMB_LB_CFG_LO_INIT		BIT(8)
+#define SMB_LB_CFG_LO_CONT		BIT(11)
+#define SMB_LB_CFG_LO_FLOW_MSK		GENMASK(19, 16)
+#define SMB_LB_CFG_LO_DEFAULT	(SMB_LB_CFG_LO_EN | SMB_LB_CFG_LO_SINGLE_END | \
+				 SMB_LB_CFG_LO_INIT | SMB_LB_CFG_LO_CONT | \
+				 FIELD_PREP(SMB_LB_CFG_LO_FLOW_MSK, 0xf))
+
+/* Set logical buffer config register upper 32 bits */
+#define SMB_LB_CFG_HI_RANGE_UP_MSK	GENMASK(15, 8)
+#define SMB_LB_CFG_HI_DEFAULT	FIELD_PREP(SMB_LB_CFG_HI_RANGE_UP_MSK, 0xff)
+
+/*
+ * Set logical buffer interrupt control register.
+ * The register control the validity of both real-time events and
+ * interrupts. When logical buffer status changes causes to issue
+ * an interrupt at the same time as it issues a real-time event.
+ * Real-time events are used in SMB driver, which needs to get the buffer
+ * status. Interrupts are used in debugger mode.
+ * SMB_LB_INT_CTRL_BUF_NOTE_MASK control which events flags or interrupts
+ * are valid.
+ */
+#define SMB_LB_INT_CTRL_EN		BIT(0)
+#define SMB_LB_INT_CTRL_BUF_NOTE_MSK	GENMASK(11, 8)
+#define SMB_LB_INT_CTRL_CFG	(SMB_LB_INT_CTRL_EN | \
+				 FIELD_PREP(SMB_LB_INT_CTRL_BUF_NOTE_MSK, 0xf))
+
+/* Set logical buffer interrupt status register */
+#define SMB_LB_INT_STS_NOT_EMPTY_MSK	BIT(0)
+#define SMB_LB_INT_STS_BUF_RESET_MSK	GENMASK(3, 0)
+#define SMB_LB_INT_STS_RESET	FIELD_PREP(SMB_LB_INT_STS_BUF_RESET_MSK, 0xf)
+
+#define SMB_LB_PURGE_PURGED	BIT(0)
+
+#define SMB_REG_ADDR_RES	0
+#define SMB_BUF_ADDR_RES	1
+#define SMB_BUF_ADDR_LO_MSK	GENMASK(31, 0)
+
+/**
+ * struct smb_data_buffer - Details of the buffer used by SMB
+ * @buf_base:	Memory mapped base address of SMB.
+ * @buf_hw_base:	SMB buffer start Physical base address, only used 32bits.
+ * @buf_size:	Size of the buffer.
+ * @data_size:	Size of the available trace data for SMB.
+ * @buf_rdptr:	Current read position (index) within the buffer.
+ */
+struct smb_data_buffer {
+	void *buf_base;
+	u32 buf_hw_base;
+	unsigned long buf_size;
+	unsigned long data_size;
+	unsigned long buf_rdptr;
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
+ *		session that is using this component.
+ * @mode:	How this SMB is being used, perf mode or sysfs mode.
+ */
+struct smb_drv_data {
+	void __iomem *base;
+	struct coresight_device	*csdev;
+	struct smb_data_buffer sdb;
+	struct miscdevice miscdev;
+	struct mutex mutex;
+	bool reading;
+	pid_t pid;
+	u32 mode;
+};
+
+#endif
-- 
2.33.0

