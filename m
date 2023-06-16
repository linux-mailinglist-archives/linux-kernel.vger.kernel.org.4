Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD41A7326E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbjFPFxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbjFPFxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:53:12 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60472D63
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:53:06 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B3A1A06A2;
        Fri, 16 Jun 2023 07:43:03 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AC4A61A068F;
        Fri, 16 Jun 2023 07:43:02 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3BFDC180222B;
        Fri, 16 Jun 2023 13:43:01 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com, Alison Wang <alison.wang@nxp.com>
Subject: [PATCH 1/8] ethosu: Add Arm Ethos-U driver
Date:   Fri, 16 Jun 2023 13:59:06 +0800
Message-Id: <20230616055913.2360-2-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616055913.2360-1-alison.wang@nxp.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ethos-U Linux driver is to provide an example of how a rich operating
system like Linux can dispatch inferences to an Arm Cortex-M subsystem,
consisting of an Arm Cortex-M and an Arm Ethos-U NPU.

Link: https://git.mlplatform.org/ml/ethos-u/ethos-u-linux-driver-stack.git
Tag: 22.02

Signed-off-by: Kristofer Jonsson <kristofer.jonsson@arm.com>
Signed-off-by: Per Astrand <per.astrand@arm.com>
Signed-off-by: Jonny Svärd <jonny.svaerd@arm.com>
Signed-off-by: Lior Dekel <Lior.dekel@arm.com>
Signed-off-by: Henrik Hoglind <henrik.hoglind@arm.com>
Signed-off-by: Davide Grohmann <davide.grohmann@arm.com>
Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/ethosu/Kconfig               |  24 +
 drivers/firmware/ethosu/Makefile              |  28 ++
 drivers/firmware/ethosu/ethosu_buffer.c       | 312 ++++++++++++
 drivers/firmware/ethosu/ethosu_buffer.h       | 106 ++++
 .../firmware/ethosu/ethosu_core_interface.h   | 183 +++++++
 drivers/firmware/ethosu/ethosu_device.c       | 474 ++++++++++++++++++
 drivers/firmware/ethosu/ethosu_device.h       |  88 ++++
 drivers/firmware/ethosu/ethosu_driver.c       | 191 +++++++
 drivers/firmware/ethosu/ethosu_inference.c    | 417 +++++++++++++++
 drivers/firmware/ethosu/ethosu_inference.h    | 120 +++++
 drivers/firmware/ethosu/ethosu_mailbox.c      | 377 ++++++++++++++
 drivers/firmware/ethosu/ethosu_mailbox.h      | 140 ++++++
 drivers/firmware/ethosu/ethosu_network.c      | 201 ++++++++
 drivers/firmware/ethosu/ethosu_network.h      |  81 +++
 drivers/firmware/ethosu/uapi/ethosu.h         | 207 ++++++++
 17 files changed, 2951 insertions(+)
 create mode 100644 drivers/firmware/ethosu/Kconfig
 create mode 100644 drivers/firmware/ethosu/Makefile
 create mode 100644 drivers/firmware/ethosu/ethosu_buffer.c
 create mode 100644 drivers/firmware/ethosu/ethosu_buffer.h
 create mode 100644 drivers/firmware/ethosu/ethosu_core_interface.h
 create mode 100644 drivers/firmware/ethosu/ethosu_device.c
 create mode 100644 drivers/firmware/ethosu/ethosu_device.h
 create mode 100644 drivers/firmware/ethosu/ethosu_driver.c
 create mode 100644 drivers/firmware/ethosu/ethosu_inference.c
 create mode 100644 drivers/firmware/ethosu/ethosu_inference.h
 create mode 100644 drivers/firmware/ethosu/ethosu_mailbox.c
 create mode 100644 drivers/firmware/ethosu/ethosu_mailbox.h
 create mode 100644 drivers/firmware/ethosu/ethosu_network.c
 create mode 100644 drivers/firmware/ethosu/ethosu_network.h
 create mode 100644 drivers/firmware/ethosu/uapi/ethosu.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..bbad6dc81e7b 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -308,6 +308,7 @@ source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
+source "drivers/firmware/ethosu/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/psci/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..6c597a78daa7 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -33,6 +33,7 @@ obj-y				+= cirrus/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-y				+= efi/
+obj-$(CONFIG_ETHOSU)		+= ethosu/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= smccc/
diff --git a/drivers/firmware/ethosu/Kconfig b/drivers/firmware/ethosu/Kconfig
new file mode 100644
index 000000000000..ce837f45f8e5
--- /dev/null
+++ b/drivers/firmware/ethosu/Kconfig
@@ -0,0 +1,24 @@
+#
+# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+#
+# This program is free software and is provided to you under the terms of the
+# GNU General Public License version 2 as published by the Free Software
+# Foundation, and any use by you of this program is subject to the terms
+# of such GNU licence.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+config ETHOSU
+    tristate "Arm Ethos-U NPU support"
+    help
+      Arm Ethos-U NPU driver.
diff --git a/drivers/firmware/ethosu/Makefile b/drivers/firmware/ethosu/Makefile
new file mode 100644
index 000000000000..933efee1b22f
--- /dev/null
+++ b/drivers/firmware/ethosu/Makefile
@@ -0,0 +1,28 @@
+#
+# (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+#
+# This program is free software and is provided to you under the terms of the
+# GNU General Public License version 2 as published by the Free Software
+# Foundation, and any use by you of this program is subject to the terms
+# of such GNU licence.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, you can access it online at
+# http://www.gnu.org/licenses/gpl-2.0.html.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+obj-$(CONFIG_ETHOSU) = ethosu.o
+
+ethosu-objs := ethosu_driver.o \
+               ethosu_buffer.o \
+               ethosu_device.o \
+               ethosu_inference.o \
+               ethosu_mailbox.o \
+               ethosu_network.o
diff --git a/drivers/firmware/ethosu/ethosu_buffer.c b/drivers/firmware/ethosu/ethosu_buffer.c
new file mode 100644
index 000000000000..43a433355f30
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_buffer.c
@@ -0,0 +1,312 @@
+/*
+ * (C) COPYRIGHT 2020-2021 Arm Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_buffer.h"
+
+#include "ethosu_device.h"
+#include "uapi/ethosu.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_address.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+/****************************************************************************
+ * Variables
+ ****************************************************************************/
+
+static int ethosu_buffer_release(struct inode *inode,
+				 struct file *file);
+
+static int ethosu_buffer_mmap(struct file *file,
+			      struct vm_area_struct *vma);
+
+static long ethosu_buffer_ioctl(struct file *file,
+				unsigned int cmd,
+				unsigned long arg);
+
+static const struct file_operations ethosu_buffer_fops = {
+	.release        = &ethosu_buffer_release,
+	.mmap           = &ethosu_buffer_mmap,
+	.unlocked_ioctl = &ethosu_buffer_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = &ethosu_buffer_ioctl,
+#endif
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/*
+ * The 'dma-ranges' device tree property for shared dma memory does not seem
+ * to be fully supported for coherent memory. Therefor we apply the DMA range
+ * offset ourselves.
+ */
+static dma_addr_t ethosu_buffer_dma_ranges(struct device *dev,
+					   dma_addr_t dma_addr,
+					   size_t dma_buf_size)
+{
+	struct device_node *node = dev->of_node;
+	const __be32 *ranges;
+	int len;
+	int naddr;
+	int nsize;
+	int inc;
+	int i;
+
+	if (!node)
+		return dma_addr;
+
+	/* Get the #address-cells and #size-cells properties */
+	naddr = of_n_addr_cells(node);
+	nsize = of_n_size_cells(node);
+
+	/* Read the 'dma-ranges' property */
+	ranges = of_get_property(node, "dma-ranges", &len);
+	if (!ranges || len <= 0)
+		return dma_addr;
+
+	dev_dbg(dev, "ranges=%p, len=%d, naddr=%d, nsize=%d\n",
+		ranges, len, naddr, nsize);
+
+	len /= sizeof(*ranges);
+	inc = naddr + naddr + nsize;
+
+	for (i = 0; (i + inc) <= len; i += inc) {
+		dma_addr_t daddr;
+		dma_addr_t paddr;
+		dma_addr_t size;
+
+		daddr = of_read_number(&ranges[i], naddr);
+		paddr = of_read_number(&ranges[i + naddr], naddr);
+		size = of_read_number(&ranges[i + naddr + naddr], nsize);
+
+		dev_dbg(dev, "daddr=0x%llx, paddr=0x%llx, size=0x%llx\n",
+			daddr, paddr, size);
+
+		if (dma_addr >= paddr &&
+		    (dma_addr + dma_buf_size) < (paddr + size))
+			return dma_addr + daddr - paddr;
+	}
+
+	return dma_addr;
+}
+
+static bool ethosu_buffer_verify(struct file *file)
+{
+	return file->f_op == &ethosu_buffer_fops;
+}
+
+static void ethosu_buffer_destroy(struct kref *kref)
+{
+	struct ethosu_buffer *buf =
+		container_of(kref, struct ethosu_buffer, kref);
+
+	dev_info(buf->edev->dev, "Buffer destroy. handle=0x%pK\n", buf);
+
+	dma_free_coherent(buf->edev->dev, buf->capacity, buf->cpu_addr,
+			  buf->dma_addr_orig);
+	devm_kfree(buf->edev->dev, buf);
+}
+
+static int ethosu_buffer_release(struct inode *inode,
+				 struct file *file)
+{
+	struct ethosu_buffer *buf = file->private_data;
+
+	dev_info(buf->edev->dev, "Buffer release. handle=0x%pK\n", buf);
+
+	ethosu_buffer_put(buf);
+
+	return 0;
+}
+
+static int ethosu_buffer_mmap(struct file *file,
+			      struct vm_area_struct *vma)
+{
+	struct ethosu_buffer *buf = file->private_data;
+	int ret;
+
+	dev_info(buf->edev->dev, "Buffer mmap. handle=0x%pK\n", buf);
+
+	ret = dma_mmap_coherent(buf->edev->dev, vma, buf->cpu_addr,
+				buf->dma_addr_orig,
+				buf->capacity);
+
+	return ret;
+}
+
+static long ethosu_buffer_ioctl(struct file *file,
+				unsigned int cmd,
+				unsigned long arg)
+{
+	struct ethosu_buffer *buf = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret = -EINVAL;
+
+	ret = mutex_lock_interruptible(&buf->edev->mutex);
+	if (ret)
+		return ret;
+
+	dev_info(buf->edev->dev, "Ioctl. cmd=%u, arg=%lu\n", cmd, arg);
+
+	switch (cmd) {
+	case ETHOSU_IOCTL_BUFFER_SET: {
+		struct ethosu_uapi_buffer uapi;
+
+		if (copy_from_user(&uapi, udata, sizeof(uapi)))
+			break;
+
+		dev_info(buf->edev->dev,
+			 "Ioctl: Buffer set. size=%u, offset=%u\n",
+			 uapi.size, uapi.offset);
+
+		ret = ethosu_buffer_resize(buf, uapi.size, uapi.offset);
+		break;
+	}
+	case ETHOSU_IOCTL_BUFFER_GET: {
+		struct ethosu_uapi_buffer uapi;
+
+		uapi.size = buf->size;
+		uapi.offset = buf->offset;
+
+		dev_info(buf->edev->dev,
+			 "Ioctl: Buffer get. size=%u, offset=%u\n",
+			 uapi.size, uapi.offset);
+
+		if (copy_to_user(udata, &uapi, sizeof(uapi)))
+			break;
+
+		ret = 0;
+		break;
+	}
+	default: {
+		dev_err(buf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
+			cmd, arg);
+		break;
+	}
+	}
+
+	mutex_unlock(&buf->edev->mutex);
+
+	return ret;
+}
+
+int ethosu_buffer_create(struct ethosu_device *edev,
+			 size_t capacity)
+{
+	struct ethosu_buffer *buf;
+	int ret = -ENOMEM;
+
+	buf = devm_kzalloc(edev->dev, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf->edev = edev;
+	buf->capacity = capacity;
+	buf->offset = 0;
+	buf->size = 0;
+	kref_init(&buf->kref);
+
+	buf->cpu_addr = dma_alloc_coherent(buf->edev->dev, capacity,
+					   &buf->dma_addr_orig, GFP_KERNEL);
+	if (!buf->cpu_addr)
+		goto free_buf;
+
+	buf->dma_addr = ethosu_buffer_dma_ranges(buf->edev->dev,
+						 buf->dma_addr_orig,
+						 buf->capacity);
+
+	ret = anon_inode_getfd("ethosu-buffer", &ethosu_buffer_fops, buf,
+			       O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto free_dma;
+
+	buf->file = fget(ret);
+	fput(buf->file);
+
+	dev_info(buf->edev->dev,
+		 "Buffer create. handle=0x%pK, capacity=%zu, cpu_addr=0x%pK, dma_addr=0x%llx, dma_addr_orig=0x%llx, phys_addr=0x%llx\n",
+		 buf, capacity, buf->cpu_addr, buf->dma_addr,
+		 buf->dma_addr_orig, virt_to_phys(buf->cpu_addr));
+
+	return ret;
+
+free_dma:
+	dma_free_coherent(buf->edev->dev, buf->capacity, buf->cpu_addr,
+			  buf->dma_addr_orig);
+
+free_buf:
+	devm_kfree(buf->edev->dev, buf);
+
+	return ret;
+}
+
+struct ethosu_buffer *ethosu_buffer_get_from_fd(int fd)
+{
+	struct ethosu_buffer *buf;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return ERR_PTR(-EINVAL);
+
+	if (!ethosu_buffer_verify(file)) {
+		fput(file);
+
+		return ERR_PTR(-EINVAL);
+	}
+
+	buf = file->private_data;
+	ethosu_buffer_get(buf);
+	fput(file);
+
+	return buf;
+}
+
+void ethosu_buffer_get(struct ethosu_buffer *buf)
+{
+	kref_get(&buf->kref);
+}
+
+void ethosu_buffer_put(struct ethosu_buffer *buf)
+{
+	kref_put(&buf->kref, ethosu_buffer_destroy);
+}
+
+int ethosu_buffer_resize(struct ethosu_buffer *buf,
+			 size_t size,
+			 size_t offset)
+{
+	if ((size + offset) > buf->capacity)
+		return -EINVAL;
+
+	buf->size = size;
+	buf->offset = offset;
+
+	return 0;
+}
diff --git a/drivers/firmware/ethosu/ethosu_buffer.h b/drivers/firmware/ethosu/ethosu_buffer.h
new file mode 100644
index 000000000000..14f26c2b0a9d
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_buffer.h
@@ -0,0 +1,106 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_BUFFER_H
+#define ETHOSU_BUFFER_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include <linux/kref.h>
+#include <linux/types.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct ethosu_device;
+struct device;
+
+/**
+ * struct ethosu_buffer - Buffer
+ * @dev:		Device
+ * @file:		File
+ * @kref:		Reference counting
+ * @capacity:		Maximum capacity of the buffer
+ * @offset:		Offset to first byte of buffer
+ * @size:		Size of the data in the buffer
+ * @cpu_addr:		Kernel mapped address
+ * @dma_addr:		DMA address
+ * @dma_addr_orig:	Original DMA address before range mapping
+ *
+ * 'offset + size' must not be larger than 'capacity'.
+ */
+struct ethosu_buffer {
+	struct ethosu_device *edev;
+	struct file          *file;
+	struct kref          kref;
+	size_t               capacity;
+	size_t               offset;
+	size_t               size;
+	void                 *cpu_addr;
+	dma_addr_t           dma_addr;
+	dma_addr_t           dma_addr_orig;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_buffer_create() - Create buffer
+ *
+ * This function must be called in the context of a user space process.
+ *
+ * Return: fd on success, else error code.
+ */
+int ethosu_buffer_create(struct ethosu_device *edev,
+			 size_t capacity);
+
+/**
+ * ethosu_buffer_get_from_fd() - Get buffer handle from fd
+ *
+ * This function must be called from a user space context.
+ *
+ * Return: Pointer on success, else ERR_PTR.
+ */
+struct ethosu_buffer *ethosu_buffer_get_from_fd(int fd);
+
+/**
+ * ethosu_buffer_get() - Put buffer
+ */
+void ethosu_buffer_get(struct ethosu_buffer *buf);
+
+/**
+ * ethosu_buffer_put() - Put buffer
+ */
+void ethosu_buffer_put(struct ethosu_buffer *buf);
+
+/**
+ * ethosu_buffer_resize() - Resize and validate buffer
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_buffer_resize(struct ethosu_buffer *buf,
+			 size_t size,
+			 size_t offset);
+
+#endif /* ETHOSU_BUFFER_H */
diff --git a/drivers/firmware/ethosu/ethosu_core_interface.h b/drivers/firmware/ethosu/ethosu_core_interface.h
new file mode 100644
index 000000000000..ef63c3b55352
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_core_interface.h
@@ -0,0 +1,183 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_CORE_INTERFACE_H
+#define ETHOSU_CORE_INTERFACE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+#ifdef __cplusplus
+namespace EthosU {
+#endif
+
+/** Maximum number of IFM/OFM buffers per inference */
+#define ETHOSU_CORE_BUFFER_MAX 16
+
+/** Maximum number of PMU counters to be returned for inference */
+#define ETHOSU_CORE_PMU_MAX 8
+
+#define ETHOSU_CORE_MSG_MAGIC 0x41457631
+#define ETHOSU_CORE_MSG_VERSION_MAJOR 0
+#define ETHOSU_CORE_MSG_VERSION_MINOR 2
+#define ETHOSU_CORE_MSG_VERSION_PATCH 0
+
+/**
+ * enum ethosu_core_msg_type - Message types
+ *
+ * Types for the messages sent between the host and the core subsystem.
+ */
+enum ethosu_core_msg_type {
+	ETHOSU_CORE_MSG_ERR = 1,
+	ETHOSU_CORE_MSG_PING,
+	ETHOSU_CORE_MSG_PONG,
+	ETHOSU_CORE_MSG_INFERENCE_REQ,
+	ETHOSU_CORE_MSG_INFERENCE_RSP,
+	ETHOSU_CORE_MSG_VERSION_REQ,
+	ETHOSU_CORE_MSG_VERSION_RSP,
+	ETHOSU_CORE_MSG_CAPABILITIES_REQ,
+	ETHOSU_CORE_MSG_CAPABILITIES_RSP,
+	ETHOSU_CORE_MSG_MAX
+};
+
+/**
+ * struct ethosu_core_msg - Message header
+ */
+struct ethosu_core_msg {
+	uint32_t magic;
+	uint32_t type;
+	uint32_t length;
+};
+
+/**
+ * struct ethosu_core_queue_header - Message queue header
+ */
+struct ethosu_core_queue_header {
+	uint32_t size;
+	uint32_t read;
+	uint32_t write;
+};
+
+/**
+ * struct ethosu_core_queue - Message queue
+ *
+ * Dynamically sized message queue.
+ */
+struct ethosu_core_queue {
+	struct ethosu_core_queue_header header;
+	uint8_t                         data[];
+};
+
+enum ethosu_core_status {
+	ETHOSU_CORE_STATUS_OK,
+	ETHOSU_CORE_STATUS_ERROR
+};
+
+struct ethosu_core_buffer {
+	uint32_t ptr;
+	uint32_t size;
+};
+
+struct ethosu_core_inference_req {
+	uint64_t                  user_arg;
+	uint32_t                  ifm_count;
+	struct ethosu_core_buffer ifm[ETHOSU_CORE_BUFFER_MAX];
+	uint32_t                  ofm_count;
+	struct ethosu_core_buffer ofm[ETHOSU_CORE_BUFFER_MAX];
+	struct ethosu_core_buffer network;
+	uint8_t                   pmu_event_config[ETHOSU_CORE_PMU_MAX];
+	uint32_t                  pmu_cycle_counter_enable;
+};
+
+struct ethosu_core_inference_rsp {
+	uint64_t user_arg;
+	uint32_t ofm_count;
+	uint32_t ofm_size[ETHOSU_CORE_BUFFER_MAX];
+	uint32_t status;
+	uint8_t  pmu_event_config[ETHOSU_CORE_PMU_MAX];
+	uint32_t pmu_event_count[ETHOSU_CORE_PMU_MAX];
+	uint32_t pmu_cycle_counter_enable;
+	uint64_t pmu_cycle_counter_count;
+};
+
+/**
+ * struct ethosu_core_msg_verson - Message protocol version
+ */
+struct ethosu_core_msg_version {
+	uint8_t major;
+	uint8_t minor;
+	uint8_t patch;
+	uint8_t _reserved;
+};
+
+/**
+ * struct ethosu_core_capabilities_req - Message capabilities request
+ */
+struct ethosu_core_capabilities_req {
+	uint64_t user_arg;
+};
+
+/**
+ * struct ethosu_core_capabilities_rsp - Message capabilities response
+ */
+struct ethosu_core_msg_capabilities_rsp {
+	uint64_t user_arg;
+	uint32_t version_status;
+	uint32_t version_minor;
+	uint32_t version_major;
+	uint32_t product_major;
+	uint32_t arch_patch_rev;
+	uint32_t arch_minor_rev;
+	uint32_t arch_major_rev;
+	uint32_t driver_patch_rev;
+	uint32_t driver_minor_rev;
+	uint32_t driver_major_rev;
+	uint32_t macs_per_cc;
+	uint32_t cmd_stream_version;
+	uint32_t custom_dma;
+};
+
+/**
+ * enum ethosu_core_msg_err_type - Error types
+ */
+enum ethosu_core_msg_err_type {
+	ETHOSU_CORE_MSG_ERR_GENERIC = 0,
+	ETHOSU_CORE_MSG_ERR_UNSUPPORTED_TYPE,
+	ETHOSU_CORE_MSG_ERR_INVALID_PAYLOAD,
+	ETHOSU_CORE_MSG_ERR_INVALID_SIZE,
+	ETHOSU_CORE_MSG_ERR_INVALID_MAGIC,
+	ETHOSU_CORE_MSG_ERR_MAX
+};
+
+/**
+ * struct ethosu_core_msg_err - Error message struct
+ */
+struct ethosu_core_msg_err {
+	uint32_t type;     /* optional use of extra error code */
+	char     msg[128];
+};
+#ifdef __cplusplus
+} /*namespace EthosU */
+#endif
+
+#endif
diff --git a/drivers/firmware/ethosu/ethosu_device.c b/drivers/firmware/ethosu/ethosu_device.c
new file mode 100644
index 000000000000..e6f1e8012b06
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_device.c
@@ -0,0 +1,474 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_device.h"
+
+#include "ethosu_buffer.h"
+#include "ethosu_core_interface.h"
+#include "ethosu_inference.h"
+#include "ethosu_network.h"
+#include "uapi/ethosu.h"
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+
+/****************************************************************************
+ * Defines
+ ****************************************************************************/
+
+#define DMA_ADDR_BITS 32 /* Number of address bits */
+
+#define CAPABILITIES_RESP_TIMEOUT_MS 2000
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static void ethosu_capabilities_destroy(struct kref *kref)
+{
+	struct ethosu_capabilities *cap =
+		container_of(kref, struct ethosu_capabilities, refcount);
+
+	list_del(&cap->list);
+
+	devm_kfree(cap->edev->dev, cap);
+}
+
+static int ethosu_capabilities_find(struct ethosu_capabilities *cap,
+				    struct list_head *capabilties_list)
+{
+	struct ethosu_capabilities *cur;
+
+	list_for_each_entry(cur, capabilties_list, list) {
+		if (cur == cap)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ethosu_capability_rsp(struct ethosu_device *edev,
+				 struct ethosu_core_msg_capabilities_rsp *msg)
+{
+	struct ethosu_capabilities *cap;
+	struct ethosu_uapi_device_capabilities *capabilities;
+	int ret;
+
+	cap = (struct ethosu_capabilities *)msg->user_arg;
+	ret = ethosu_capabilities_find(cap, &edev->capabilities_list);
+	if (0 != ret) {
+		dev_warn(edev->dev,
+			 "Handle not found in capabilities list. handle=0x%p\n",
+			 cap);
+
+		/* NOTE: do not call complete or kref_put on invalid data! */
+		return ret;
+	}
+
+	capabilities = cap->capabilities;
+
+	capabilities->hw_id.version_status = msg->version_status;
+	capabilities->hw_id.version_minor = msg->version_minor;
+	capabilities->hw_id.version_major = msg->version_major;
+	capabilities->hw_id.product_major = msg->product_major;
+	capabilities->hw_id.arch_patch_rev = msg->arch_patch_rev;
+	capabilities->hw_id.arch_minor_rev = msg->arch_minor_rev;
+	capabilities->hw_id.arch_major_rev = msg->arch_major_rev;
+	capabilities->driver_patch_rev = msg->driver_patch_rev;
+	capabilities->driver_minor_rev = msg->driver_minor_rev;
+	capabilities->driver_major_rev = msg->driver_major_rev;
+	capabilities->hw_cfg.macs_per_cc = msg->macs_per_cc;
+	capabilities->hw_cfg.cmd_stream_version = msg->cmd_stream_version;
+	capabilities->hw_cfg.custom_dma = msg->custom_dma;
+
+	complete(&cap->done);
+
+	kref_put(&cap->refcount, ethosu_capabilities_destroy);
+
+	return 0;
+}
+
+/* Incoming messages */
+static int ethosu_handle_msg(struct ethosu_device *edev)
+{
+	int ret;
+	struct ethosu_core_msg header;
+
+	union {
+		struct ethosu_core_msg_err              error;
+		struct ethosu_core_inference_rsp        inf;
+		struct ethosu_core_msg_version          version;
+		struct ethosu_core_msg_capabilities_rsp capabilities;
+	} data;
+
+	/* Read message */
+	ret = ethosu_mailbox_read(&edev->mailbox, &header, &data, sizeof(data));
+	if (ret)
+		return ret;
+
+	switch (header.type) {
+	case ETHOSU_CORE_MSG_ERR:
+		if (header.length != sizeof(data.error)) {
+			dev_warn(edev->dev,
+				 "Msg: Error message of incorrect size. size=%u, expected=%zu\n", header.length,
+				 sizeof(data.error));
+			ret = -EBADMSG;
+			break;
+		}
+
+		data.error.msg[sizeof(data.error.msg) - 1] = '\0';
+		dev_warn(edev->dev, "Msg: Error. type=%u, msg=\"%s\"\n",
+			 data.error.type, data.error.msg);
+		ret = -EBADMSG;
+		break;
+	case ETHOSU_CORE_MSG_PING:
+		dev_info(edev->dev, "Msg: Ping\n");
+		ret = ethosu_mailbox_pong(&edev->mailbox);
+		break;
+	case ETHOSU_CORE_MSG_PONG:
+		dev_info(edev->dev, "Msg: Pong\n");
+		break;
+	case ETHOSU_CORE_MSG_INFERENCE_RSP:
+		if (header.length != sizeof(data.inf)) {
+			dev_warn(edev->dev,
+				 "Msg: Inference response of incorrect size. size=%u, expected=%zu\n", header.length,
+				 sizeof(data.inf));
+			ret = -EBADMSG;
+			break;
+		}
+
+		dev_info(edev->dev,
+			 "Msg: Inference response. user_arg=0x%llx, ofm_count=%u, status=%u\n",
+			 data.inf.user_arg, data.inf.ofm_count,
+			 data.inf.status);
+		ethosu_inference_rsp(edev, &data.inf);
+		break;
+	case ETHOSU_CORE_MSG_VERSION_RSP:
+		if (header.length != sizeof(data.version)) {
+			dev_warn(edev->dev,
+				 "Msg: Version response of incorrect size. size=%u, expected=%zu\n", header.length,
+				 sizeof(data.version));
+			ret = -EBADMSG;
+			break;
+		}
+
+		dev_info(edev->dev, "Msg: Version response v%u.%u.%u\n",
+			 data.version.major, data.version.minor,
+			 data.version.patch);
+
+		/* Check major and minor version match, else return error */
+		if (data.version.major != ETHOSU_CORE_MSG_VERSION_MAJOR ||
+		    data.version.minor != ETHOSU_CORE_MSG_VERSION_MINOR) {
+			dev_warn(edev->dev, "Msg: Version mismatch detected! ");
+			dev_warn(edev->dev, "Local version: v%u.%u.%u\n",
+				 ETHOSU_CORE_MSG_VERSION_MAJOR,
+				 ETHOSU_CORE_MSG_VERSION_MINOR,
+				 ETHOSU_CORE_MSG_VERSION_PATCH);
+		}
+
+		break;
+	case ETHOSU_CORE_MSG_CAPABILITIES_RSP:
+		if (header.length != sizeof(data.capabilities)) {
+			dev_warn(edev->dev,
+				 "Msg: Capabilities response of incorrect size. size=%u, expected=%zu\n", header.length,
+				 sizeof(data.capabilities));
+			ret = -EBADMSG;
+			break;
+		}
+
+		dev_info(edev->dev,
+			 "Msg: Capabilities response ua%llx vs%hhu v%hhu.%hhu p%hhu av%hhu.%hhu.%hhu dv%hhu.%hhu.%hhu mcc%hhu csv%hhu cd%hhu\n",
+			 data.capabilities.user_arg,
+			 data.capabilities.version_status,
+			 data.capabilities.version_major,
+			 data.capabilities.version_minor,
+			 data.capabilities.product_major,
+			 data.capabilities.arch_major_rev,
+			 data.capabilities.arch_minor_rev,
+			 data.capabilities.arch_patch_rev,
+			 data.capabilities.driver_major_rev,
+			 data.capabilities.driver_minor_rev,
+			 data.capabilities.driver_patch_rev,
+			 data.capabilities.macs_per_cc,
+			 data.capabilities.cmd_stream_version,
+			 data.capabilities.custom_dma);
+
+		ret = ethosu_capability_rsp(edev, &data.capabilities);
+		break;
+	default:
+		/* This should not happen due to version checks */
+		dev_warn(edev->dev, "Msg: Protocol error\n");
+		ret = -EPROTO;
+		break;
+	}
+
+	return ret;
+}
+
+static int ethosu_open(struct inode *inode,
+		       struct file *file)
+{
+	struct ethosu_device *edev =
+		container_of(inode->i_cdev, struct ethosu_device, cdev);
+
+	file->private_data = edev;
+
+	dev_info(edev->dev, "Opening device node.\n");
+
+	return nonseekable_open(inode, file);
+}
+
+static int ethosu_send_capabilities_request(struct ethosu_device *edev,
+					    void __user *udata)
+{
+	struct ethosu_uapi_device_capabilities uapi;
+	struct ethosu_capabilities *cap;
+	int ret;
+	int timeout;
+
+	cap = devm_kzalloc(edev->dev, sizeof(struct ethosu_capabilities),
+			   GFP_KERNEL);
+	if (!cap)
+		return -ENOMEM;
+
+	cap->edev = edev;
+	cap->capabilities = &uapi;
+	kref_init(&cap->refcount);
+	init_completion(&cap->done);
+	list_add(&cap->list, &edev->capabilities_list);
+
+	ret = ethosu_mailbox_capabilities_request(&edev->mailbox, cap);
+	if (0 != ret)
+		goto put_kref;
+
+	/*
+	 * Increase ref counter since we sent the pointer out to
+	 * response handler thread. That thread is responsible to
+	 * decrease the ref counter before exiting. So the memory
+	 * can be freed.
+	 *
+	 * NOTE: if no response is received back, the memory is leaked.
+	 */
+	kref_get(&cap->refcount);
+	/* Unlock the mutex before going to block on the condition */
+	mutex_unlock(&edev->mutex);
+	/* wait for response to arrive back */
+	timeout = wait_for_completion_timeout(&cap->done,
+					      msecs_to_jiffies(
+						      CAPABILITIES_RESP_TIMEOUT_MS));
+	/* take back the mutex before resuming to do anything */
+	ret = mutex_lock_interruptible(&edev->mutex);
+	if (0 != ret)
+		goto put_kref;
+
+	if (0 == timeout /* timed out*/) {
+		dev_warn(edev->dev,
+			 "Msg: Capabilities response lost - timeout\n");
+		ret = -EIO;
+		goto put_kref;
+	}
+
+	ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
+
+put_kref:
+	kref_put(&cap->refcount, ethosu_capabilities_destroy);
+
+	return ret;
+}
+
+static long ethosu_ioctl(struct file *file,
+			 unsigned int cmd,
+			 unsigned long arg)
+{
+	struct ethosu_device *edev = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret = -EINVAL;
+
+	ret = mutex_lock_interruptible(&edev->mutex);
+	if (ret)
+		return ret;
+
+	dev_info(edev->dev, "Ioctl. cmd=%u, arg=%lu\n", cmd, arg);
+
+	switch (cmd) {
+	case ETHOSU_IOCTL_VERSION_REQ:
+		dev_info(edev->dev, "Ioctl: Send version request\n");
+		ret = ethosu_mailbox_version_request(&edev->mailbox);
+		break;
+	case ETHOSU_IOCTL_CAPABILITIES_REQ:
+		dev_info(edev->dev, "Ioctl: Send capabilities request\n");
+		ret = ethosu_send_capabilities_request(edev, udata);
+		break;
+	case ETHOSU_IOCTL_PING: {
+		dev_info(edev->dev, "Ioctl: Send ping\n");
+		ret = ethosu_mailbox_ping(&edev->mailbox);
+		break;
+	}
+	case ETHOSU_IOCTL_BUFFER_CREATE: {
+		struct ethosu_uapi_buffer_create uapi;
+
+		dev_info(edev->dev, "Ioctl: Buffer create\n");
+
+		if (copy_from_user(&uapi, udata, sizeof(uapi)))
+			break;
+
+		dev_info(edev->dev, "Ioctl: Buffer. capacity=%u\n",
+			 uapi.capacity);
+
+		ret = ethosu_buffer_create(edev, uapi.capacity);
+		break;
+	}
+	case ETHOSU_IOCTL_NETWORK_CREATE: {
+		struct ethosu_uapi_network_create uapi;
+
+		if (copy_from_user(&uapi, udata, sizeof(uapi)))
+			break;
+
+		dev_info(edev->dev, "Ioctl: Network. fd=%u\n", uapi.fd);
+
+		ret = ethosu_network_create(edev, &uapi);
+		break;
+	}
+	default: {
+		dev_err(edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
+			cmd, arg);
+		break;
+	}
+	}
+
+	mutex_unlock(&edev->mutex);
+
+	return ret;
+}
+
+static void ethosu_mbox_rx(void *user_arg)
+{
+	struct ethosu_device *edev = user_arg;
+	int ret;
+
+	mutex_lock(&edev->mutex);
+
+	do {
+		ret = ethosu_handle_msg(edev);
+		if (ret && ret != -ENOMSG)
+			/* Need to start over in case of error, empty the queue
+			 * by fast-forwarding read position to write position.
+			 * */
+			ethosu_mailbox_reset(&edev->mailbox);
+	} while (ret == 0);
+
+	mutex_unlock(&edev->mutex);
+}
+
+int ethosu_dev_init(struct ethosu_device *edev,
+		    struct device *dev,
+		    struct class *class,
+		    dev_t devt,
+		    struct resource *in_queue,
+		    struct resource *out_queue)
+{
+	static const struct file_operations fops = {
+		.owner          = THIS_MODULE,
+		.open           = &ethosu_open,
+		.unlocked_ioctl = &ethosu_ioctl,
+#ifdef CONFIG_COMPAT
+		.compat_ioctl   = &ethosu_ioctl,
+#endif
+	};
+	struct device *sysdev;
+	int ret;
+
+	edev->dev = dev;
+	edev->class = class;
+	edev->devt = devt;
+	mutex_init(&edev->mutex);
+	INIT_LIST_HEAD(&edev->capabilities_list);
+	INIT_LIST_HEAD(&edev->inference_list);
+
+	ret = of_reserved_mem_device_init(edev->dev);
+	if (ret)
+		return ret;
+
+	dma_set_mask_and_coherent(edev->dev, DMA_BIT_MASK(DMA_ADDR_BITS));
+
+	ret = ethosu_mailbox_init(&edev->mailbox, dev, in_queue, out_queue,
+				  ethosu_mbox_rx, edev);
+	if (ret)
+		goto release_reserved_mem;
+
+	cdev_init(&edev->cdev, &fops);
+	edev->cdev.owner = THIS_MODULE;
+
+	ret = cdev_add(&edev->cdev, edev->devt, 1);
+	if (ret) {
+		dev_err(edev->dev, "Failed to add character device.\n");
+		goto deinit_mailbox;
+	}
+
+	sysdev = device_create(edev->class, NULL, edev->devt, edev,
+			       "ethosu%d", MINOR(edev->devt));
+	if (IS_ERR(sysdev)) {
+		dev_err(edev->dev, "Failed to create device.\n");
+		ret = PTR_ERR(sysdev);
+		goto del_cdev;
+	}
+
+	dev_info(edev->dev,
+		 "Created Arm Ethos-U device. name=%s, major=%d, minor=%d\n",
+		 dev_name(sysdev), MAJOR(edev->devt), MINOR(edev->devt));
+
+	return 0;
+
+del_cdev:
+	cdev_del(&edev->cdev);
+
+deinit_mailbox:
+	ethosu_mailbox_deinit(&edev->mailbox);
+
+release_reserved_mem:
+	of_reserved_mem_device_release(edev->dev);
+
+	return ret;
+}
+
+void ethosu_dev_deinit(struct ethosu_device *edev)
+{
+	ethosu_mailbox_deinit(&edev->mailbox);
+	device_destroy(edev->class, edev->cdev.dev);
+	cdev_del(&edev->cdev);
+	of_reserved_mem_device_release(edev->dev);
+
+	dev_info(edev->dev, "%s\n", __FUNCTION__);
+}
diff --git a/drivers/firmware/ethosu/ethosu_device.h b/drivers/firmware/ethosu/ethosu_device.h
new file mode 100644
index 000000000000..3afdda84862d
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_device.h
@@ -0,0 +1,88 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_DEVICE_H
+#define ETHOSU_DEVICE_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "uapi/ethosu.h"
+#include "ethosu_mailbox.h"
+
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+/**
+ * struct ethosu_device - Device structure
+ */
+struct ethosu_device {
+	struct device         *dev;
+	struct cdev           cdev;
+	struct                class *class;
+	dev_t                 devt;
+	struct mutex          mutex;
+	struct ethosu_mailbox mailbox;
+	struct list_head      capabilities_list;
+	struct list_head      inference_list;
+};
+
+/**
+ * struct ethosu_capabilities - Capabilities internal struct
+ */
+struct ethosu_capabilities {
+	struct ethosu_device                   *edev;
+	struct completion                      done;
+	struct kref                            refcount;
+	struct ethosu_uapi_device_capabilities *capabilities;
+	struct list_head                       list;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_dev_init() - Initialize the device
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_dev_init(struct ethosu_device *edev,
+		    struct device *dev,
+		    struct class *class,
+		    dev_t devt,
+		    struct resource *in_queue,
+		    struct resource *out_queue);
+
+/**
+ * ethosu_dev_deinit() - Initialize the device
+ */
+void ethosu_dev_deinit(struct ethosu_device *edev);
+
+#endif /* ETHOSU_DEVICE_H */
diff --git a/drivers/firmware/ethosu/ethosu_driver.c b/drivers/firmware/ethosu/ethosu_driver.c
new file mode 100644
index 000000000000..9d02431d3194
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_driver.c
@@ -0,0 +1,191 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#include <linux/bitmap.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ethosu_device.h"
+
+/****************************************************************************
+ * Defines
+ ****************************************************************************/
+
+#define ETHOSU_DRIVER_VERSION "1.0"
+#define ETHOSU_DRIVER_NAME    "ethosu"
+
+#define MINOR_BASE      0 /* Minor version starts at 0 */
+#define MINOR_COUNT    64 /* Allocate minor versions */
+
+/****************************************************************************
+ * Variables
+ ****************************************************************************/
+
+static struct class *ethosu_class;
+
+static dev_t devt;
+
+static DECLARE_BITMAP(minors, MINOR_COUNT);
+
+/****************************************************************************
+ * Arm Ethos-U
+ ****************************************************************************/
+
+static int ethosu_pdev_probe(struct platform_device *pdev)
+{
+	struct ethosu_device *edev;
+	struct resource *in_queue_res;
+	struct resource *out_queue_res;
+	int minor;
+	int ret;
+
+	dev_info(&pdev->dev, "Probe\n");
+
+	minor = find_first_zero_bit(minors, MINOR_COUNT);
+	if (minor >= MINOR_COUNT) {
+		dev_err(&pdev->dev, "No more minor numbers.\n");
+
+		return -ENOMEM;
+	}
+
+	/* Get path to TCM memory */
+	in_queue_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						    "in_queue");
+	if (IS_ERR(in_queue_res)) {
+		dev_err(&pdev->dev, "Failed to get in_queue resource.\n");
+
+		return PTR_ERR(in_queue_res);
+	}
+
+	out_queue_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						     "out_queue");
+	if (IS_ERR(out_queue_res)) {
+		dev_err(&pdev->dev, "Failed to get out_queue resource.\n");
+
+		return PTR_ERR(out_queue_res);
+	}
+
+	/* Allocate memory for Arm Ethos-U device */
+	edev = devm_kzalloc(&pdev->dev, sizeof(*edev), GFP_KERNEL);
+	if (!edev)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, edev);
+
+	/* Initialize device */
+	ret = ethosu_dev_init(edev, &pdev->dev, ethosu_class,
+			      MKDEV(MAJOR(devt), minor), in_queue_res,
+			      out_queue_res);
+	if (ret)
+		goto free_dev;
+
+	set_bit(minor, minors);
+
+	return 0;
+
+free_dev:
+	devm_kfree(&pdev->dev, edev);
+
+	return ret;
+}
+
+static int ethosu_pdev_remove(struct platform_device *pdev)
+{
+	struct ethosu_device *edev = platform_get_drvdata(pdev);
+
+	clear_bit(MINOR(edev->devt), minors);
+	ethosu_dev_deinit(edev);
+
+	return 0;
+}
+
+static const struct of_device_id ethosu_pdev_match[] = {
+	{ .compatible = "arm,ethosu" },
+	{ /* Sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, ethosu_pdev_match);
+
+static struct platform_driver ethosu_pdev_driver = {
+	.probe                  = &ethosu_pdev_probe,
+	.remove                 = &ethosu_pdev_remove,
+	.driver                 = {
+		.name           = ETHOSU_DRIVER_NAME,
+		.owner          = THIS_MODULE,
+		.of_match_table = of_match_ptr(ethosu_pdev_match),
+	},
+};
+
+/****************************************************************************
+ * Module init and exit
+ ****************************************************************************/
+
+static int __init ethosu_init(void)
+{
+	int ret;
+
+	ethosu_class = class_create(THIS_MODULE, ETHOSU_DRIVER_NAME);
+	if (IS_ERR(ethosu_class)) {
+		printk("Failed to create class '%s'.\n", ETHOSU_DRIVER_NAME);
+
+		return PTR_ERR(ethosu_class);
+	}
+
+	ret = alloc_chrdev_region(&devt, MINOR_BASE, MINOR_COUNT,
+				  ETHOSU_DRIVER_NAME);
+	if (ret) {
+		printk("Failed to allocate chrdev region.\n");
+		goto destroy_class;
+	}
+
+	ret = platform_driver_register(&ethosu_pdev_driver);
+	if (ret) {
+		printk("Failed to register Arm Ethos-U platform driver.\n");
+		goto region_unregister;
+	}
+
+	return 0;
+
+region_unregister:
+	unregister_chrdev_region(devt, MINOR_COUNT);
+
+destroy_class:
+	class_destroy(ethosu_class);
+
+	return ret;
+}
+
+static void __exit ethosu_exit(void)
+{
+	platform_driver_unregister(&ethosu_pdev_driver);
+	unregister_chrdev_region(devt, MINOR_COUNT);
+	class_destroy(ethosu_class);
+}
+
+module_init(ethosu_init)
+module_exit(ethosu_exit)
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Arm Ltd");
+MODULE_DESCRIPTION("Arm Ethos-U NPU Driver");
+MODULE_VERSION(ETHOSU_DRIVER_VERSION);
diff --git a/drivers/firmware/ethosu/ethosu_inference.c b/drivers/firmware/ethosu/ethosu_inference.c
new file mode 100644
index 000000000000..6fde92c148a0
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_inference.c
@@ -0,0 +1,417 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_inference.h"
+
+#include "ethosu_buffer.h"
+#include "ethosu_core_interface.h"
+#include "ethosu_device.h"
+#include "ethosu_network.h"
+#include "uapi/ethosu.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/poll.h>
+
+/****************************************************************************
+ * Variables
+ ****************************************************************************/
+
+static int ethosu_inference_release(struct inode *inode,
+				    struct file *file);
+
+static unsigned int ethosu_inference_poll(struct file *file,
+					  poll_table *wait);
+
+static long ethosu_inference_ioctl(struct file *file,
+				   unsigned int cmd,
+				   unsigned long arg);
+
+static const struct file_operations ethosu_inference_fops = {
+	.release        = &ethosu_inference_release,
+	.poll           = &ethosu_inference_poll,
+	.unlocked_ioctl = &ethosu_inference_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = &ethosu_inference_ioctl,
+#endif
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static const char *status_to_string(const enum ethosu_uapi_status status)
+{
+	switch (status) {
+	case ETHOSU_UAPI_STATUS_OK: {
+		return "Ok";
+	}
+	case ETHOSU_UAPI_STATUS_ERROR: {
+		return "Error";
+	}
+	default: {
+		return "Unknown";
+	}
+	}
+}
+
+static int ethosu_inference_send(struct ethosu_inference *inf)
+{
+	int ret;
+
+	if (inf->pending)
+		return -EINVAL;
+
+	inf->status = ETHOSU_UAPI_STATUS_ERROR;
+
+	ret = ethosu_mailbox_inference(&inf->edev->mailbox, inf,
+				       inf->ifm_count, inf->ifm,
+				       inf->ofm_count, inf->ofm,
+				       inf->net->buf,
+				       inf->pmu_event_config,
+				       ETHOSU_PMU_EVENT_MAX,
+				       inf->pmu_cycle_counter_enable);
+	if (ret)
+		return ret;
+
+	inf->pending = true;
+
+	ethosu_inference_get(inf);
+
+	return 0;
+}
+
+static int ethosu_inference_find(struct ethosu_inference *inf,
+				 struct list_head *inference_list)
+{
+	struct ethosu_inference *cur;
+
+	list_for_each_entry(cur, inference_list, list) {
+		if (cur == inf)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static bool ethosu_inference_verify(struct file *file)
+{
+	return file->f_op == &ethosu_inference_fops;
+}
+
+static void ethosu_inference_kref_destroy(struct kref *kref)
+{
+	struct ethosu_inference *inf =
+		container_of(kref, struct ethosu_inference, kref);
+
+	dev_info(inf->edev->dev,
+		 "Inference destroy. handle=0x%pK, status=%d\n",
+		 inf, inf->status);
+
+	list_del(&inf->list);
+
+	while (inf->ifm_count-- > 0)
+		ethosu_buffer_put(inf->ifm[inf->ifm_count]);
+
+	while (inf->ofm_count-- > 0)
+		ethosu_buffer_put(inf->ofm[inf->ofm_count]);
+
+	ethosu_network_put(inf->net);
+	devm_kfree(inf->edev->dev, inf);
+}
+
+static int ethosu_inference_release(struct inode *inode,
+				    struct file *file)
+{
+	struct ethosu_inference *inf = file->private_data;
+
+	dev_info(inf->edev->dev,
+		 "Inference release. handle=0x%pK, status=%d\n",
+		 inf, inf->status);
+
+	ethosu_inference_put(inf);
+
+	return 0;
+}
+
+static unsigned int ethosu_inference_poll(struct file *file,
+					  poll_table *wait)
+{
+	struct ethosu_inference *inf = file->private_data;
+	int ret = 0;
+
+	poll_wait(file, &inf->waitq, wait);
+
+	if (!inf->pending)
+		ret |= POLLIN;
+
+	return ret;
+}
+
+static long ethosu_inference_ioctl(struct file *file,
+				   unsigned int cmd,
+				   unsigned long arg)
+{
+	struct ethosu_inference *inf = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret;
+
+	ret = mutex_lock_interruptible(&inf->edev->mutex);
+	if (ret)
+		return ret;
+
+	dev_info(inf->edev->dev, "Ioctl: cmd=%u, arg=%lu\n", cmd, arg);
+
+	switch (cmd) {
+	case ETHOSU_IOCTL_INFERENCE_STATUS: {
+		struct ethosu_uapi_result_status uapi;
+		int i;
+
+		uapi.status = inf->status;
+
+		for (i = 0; i < ETHOSU_PMU_EVENT_MAX; i++) {
+			uapi.pmu_config.events[i] =
+				inf->pmu_event_config[i];
+			uapi.pmu_count.events[i] =
+				inf->pmu_event_count[i];
+		}
+
+		uapi.pmu_config.cycle_count = inf->pmu_cycle_counter_enable;
+		uapi.pmu_count.cycle_count = inf->pmu_cycle_counter_count;
+
+		dev_info(inf->edev->dev,
+			 "Ioctl: Inference status. status=%s (%d)\n",
+			 status_to_string(uapi.status), uapi.status);
+
+		ret = copy_to_user(udata, &uapi, sizeof(uapi)) ? -EFAULT : 0;
+
+		break;
+	}
+	default: {
+		dev_err(inf->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
+			cmd, arg);
+		break;
+	}
+	}
+
+	mutex_unlock(&inf->edev->mutex);
+
+	return ret;
+}
+
+int ethosu_inference_create(struct ethosu_device *edev,
+			    struct ethosu_network *net,
+			    struct ethosu_uapi_inference_create *uapi)
+{
+	struct ethosu_inference *inf;
+	uint32_t i;
+	int fd;
+	int ret = -ENOMEM;
+
+	inf = devm_kzalloc(edev->dev, sizeof(*inf), GFP_KERNEL);
+	if (!inf)
+		return -ENOMEM;
+
+	inf->edev = edev;
+	inf->net = net;
+	inf->pending = false;
+	inf->status = ETHOSU_UAPI_STATUS_ERROR;
+	kref_init(&inf->kref);
+	init_waitqueue_head(&inf->waitq);
+
+	/* Get pointer to IFM buffers */
+	for (i = 0; i < uapi->ifm_count; i++) {
+		inf->ifm[i] = ethosu_buffer_get_from_fd(uapi->ifm_fd[i]);
+		if (IS_ERR(inf->ifm[i])) {
+			ret = PTR_ERR(inf->ifm[i]);
+			goto put_ifm;
+		}
+
+		inf->ifm_count++;
+	}
+
+	/* Get pointer to OFM buffer */
+	for (i = 0; i < uapi->ofm_count; i++) {
+		inf->ofm[i] = ethosu_buffer_get_from_fd(uapi->ofm_fd[i]);
+		if (IS_ERR(inf->ofm[i])) {
+			ret = PTR_ERR(inf->ofm[i]);
+			goto put_ofm;
+		}
+
+		inf->ofm_count++;
+	}
+
+	/* Configure PMU and cycle counter */
+	dev_info(inf->edev->dev,
+		 "Configuring events for PMU. events=[%u, %u, %u, %u]\n",
+		 uapi->pmu_config.events[0], uapi->pmu_config.events[1],
+		 uapi->pmu_config.events[2], uapi->pmu_config.events[3]);
+
+	/* Configure events and reset count for all events */
+	for (i = 0; i < ETHOSU_PMU_EVENT_MAX; i++) {
+		inf->pmu_event_config[i] = uapi->pmu_config.events[i];
+		inf->pmu_event_count[i] = 0;
+	}
+
+	if (uapi->pmu_config.cycle_count)
+		dev_info(inf->edev->dev, "Enabling cycle counter\n");
+
+	/* Configure cycle counter and reset any previous count */
+	inf->pmu_cycle_counter_enable = uapi->pmu_config.cycle_count;
+	inf->pmu_cycle_counter_count = 0;
+
+	/* Increment network reference count */
+	ethosu_network_get(net);
+
+	/* Create file descriptor */
+	ret = fd = anon_inode_getfd("ethosu-inference", &ethosu_inference_fops,
+				    inf, O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto put_net;
+
+	/* Store pointer to file structure */
+	inf->file = fget(ret);
+	fput(inf->file);
+
+	/* Add inference to inference list */
+	list_add(&inf->list, &edev->inference_list);
+
+	/* Send inference request to Arm Ethos-U subsystem */
+	(void)ethosu_inference_send(inf);
+
+	dev_info(edev->dev, "Inference create. handle=0x%pK, fd=%d",
+		 inf, fd);
+
+	return fd;
+
+put_net:
+	ethosu_network_put(inf->net);
+
+put_ofm:
+	while (inf->ofm_count-- > 0)
+		ethosu_buffer_put(inf->ofm[inf->ofm_count]);
+
+put_ifm:
+	while (inf->ifm_count-- > 0)
+		ethosu_buffer_put(inf->ifm[inf->ifm_count]);
+
+	devm_kfree(edev->dev, inf);
+
+	return ret;
+}
+
+struct ethosu_inference *ethosu_inference_get_from_fd(int fd)
+{
+	struct ethosu_inference *inf;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return ERR_PTR(-EINVAL);
+
+	if (!ethosu_inference_verify(file)) {
+		fput(file);
+
+		return ERR_PTR(-EINVAL);
+	}
+
+	inf = file->private_data;
+	ethosu_inference_get(inf);
+	fput(file);
+
+	return inf;
+}
+
+void ethosu_inference_get(struct ethosu_inference *inf)
+{
+	kref_get(&inf->kref);
+}
+
+void ethosu_inference_put(struct ethosu_inference *inf)
+{
+	kref_put(&inf->kref, &ethosu_inference_kref_destroy);
+}
+
+void ethosu_inference_rsp(struct ethosu_device *edev,
+			  struct ethosu_core_inference_rsp *rsp)
+{
+	struct ethosu_inference *inf =
+		(struct ethosu_inference *)rsp->user_arg;
+	int ret;
+	int i;
+
+	ret = ethosu_inference_find(inf, &edev->inference_list);
+	if (ret) {
+		dev_warn(edev->dev,
+			 "Handle not found in inference list. handle=0x%p\n",
+			 rsp);
+
+		return;
+	}
+
+	inf->pending = false;
+
+	if (rsp->status == ETHOSU_CORE_STATUS_OK &&
+	    inf->ofm_count <= ETHOSU_CORE_BUFFER_MAX) {
+		uint32_t i;
+
+		inf->status = ETHOSU_UAPI_STATUS_OK;
+
+		for (i = 0; i < inf->ofm_count; i++) {
+			struct ethosu_buffer *ofm = inf->ofm[i];
+
+			ret = ethosu_buffer_resize(
+				ofm, ofm->size + rsp->ofm_size[i],
+				ofm->offset);
+			if (ret)
+				inf->status = ETHOSU_UAPI_STATUS_ERROR;
+		}
+	} else {
+		inf->status = ETHOSU_UAPI_STATUS_ERROR;
+	}
+
+	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++) {
+		inf->pmu_event_config[i] = rsp->pmu_event_config[i];
+		inf->pmu_event_count[i] = rsp->pmu_event_count[i];
+	}
+
+	inf->pmu_cycle_counter_enable = rsp->pmu_cycle_counter_enable;
+	inf->pmu_cycle_counter_count = rsp->pmu_cycle_counter_count;
+
+	dev_info(edev->dev,
+		 "PMU events. config=[%u, %u, %u, %u], count=[%u, %u, %u, %u]\n",
+		 inf->pmu_event_config[0], inf->pmu_event_config[1],
+		 inf->pmu_event_config[2], inf->pmu_event_config[3],
+		 inf->pmu_event_count[0], inf->pmu_event_count[1],
+		 inf->pmu_event_count[2], inf->pmu_event_count[3]);
+
+	dev_info(edev->dev,
+		 "PMU cycle counter. enable=%u, count=%llu\n",
+		 inf->pmu_cycle_counter_enable,
+		 inf->pmu_cycle_counter_count);
+	wake_up_interruptible(&inf->waitq);
+
+	ethosu_inference_put(inf);
+}
diff --git a/drivers/firmware/ethosu/ethosu_inference.h b/drivers/firmware/ethosu/ethosu_inference.h
new file mode 100644
index 000000000000..07370ca01f22
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_inference.h
@@ -0,0 +1,120 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_INFERENCE_H
+#define ETHOSU_INFERENCE_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "uapi/ethosu.h"
+
+#include <linux/kref.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct ethosu_buffer;
+struct ethosu_core_inference_rsp;
+struct ethosu_device;
+struct ethosu_network;
+struct ethosu_uapi_inference_create;
+struct file;
+
+/**
+ * struct ethosu_inference - Inference struct
+ * @edev:			Arm Ethos-U device
+ * @file:			File handle
+ * @kref:			Reference counter
+ * @waitq:			Wait queue
+ * @ifm:			Pointer to IFM buffer
+ * @ofm:			Pointer to OFM buffer
+ * @net:			Pointer to network
+ * @pending:			Pending response from the firmware
+ * @status:			Inference status
+ * @pmu_event_config:		PMU event configuration
+ * @pmu_event_count:		PMU event count after inference
+ * @pmu_cycle_counter_enable:	PMU cycle counter config
+ * @pmu_cycle_counter_count:	PMU cycle counter count after inference
+ */
+struct ethosu_inference {
+	struct ethosu_device    *edev;
+	struct file             *file;
+	struct kref             kref;
+	wait_queue_head_t       waitq;
+	uint32_t                ifm_count;
+	struct ethosu_buffer    *ifm[ETHOSU_FD_MAX];
+	uint32_t                ofm_count;
+	struct ethosu_buffer    *ofm[ETHOSU_FD_MAX];
+	struct ethosu_network   *net;
+	bool                    pending;
+	enum ethosu_uapi_status status;
+	uint8_t                 pmu_event_config[ETHOSU_PMU_EVENT_MAX];
+	uint32_t                pmu_event_count[ETHOSU_PMU_EVENT_MAX];
+	uint32_t                pmu_cycle_counter_enable;
+	uint64_t                pmu_cycle_counter_count;
+	struct list_head        list;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_inference_create() - Create inference
+ *
+ * This function must be called in the context of a user space process.
+ *
+ * Return: fd on success, else error code.
+ */
+int ethosu_inference_create(struct ethosu_device *edev,
+			    struct ethosu_network *net,
+			    struct ethosu_uapi_inference_create *uapi);
+
+/**
+ * ethosu_inference_get_from_fd() - Get inference handle from fd
+ *
+ * This function must be called from a user space context.
+ *
+ * Return: Pointer on success, else ERR_PTR.
+ */
+struct ethosu_inference *ethosu_inference_get_from_fd(int fd);
+
+/**
+ * ethosu_inference_get() - Get inference
+ */
+void ethosu_inference_get(struct ethosu_inference *inf);
+
+/**
+ * ethosu_inference_put() - Put inference
+ */
+void ethosu_inference_put(struct ethosu_inference *inf);
+
+/**
+ * ethosu_inference_rsp() - Handle inference response
+ */
+void ethosu_inference_rsp(struct ethosu_device *edev,
+			  struct ethosu_core_inference_rsp *rsp);
+
+#endif /* ETHOSU_INFERENCE_H */
diff --git a/drivers/firmware/ethosu/ethosu_mailbox.c b/drivers/firmware/ethosu/ethosu_mailbox.c
new file mode 100644
index 000000000000..7f159f3b0a60
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_mailbox.c
@@ -0,0 +1,377 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_mailbox.h"
+
+#include "ethosu_buffer.h"
+#include "ethosu_core_interface.h"
+#include "ethosu_device.h"
+
+#include <linux/resource.h>
+#include <linux/uio.h>
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static void ethosu_core_set_size(struct ethosu_buffer *buf,
+				 struct ethosu_core_buffer *cbuf)
+{
+	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset;
+	cbuf->size = (uint32_t)buf->size;
+}
+
+static void ethosu_core_set_capacity(struct ethosu_buffer *buf,
+				     struct ethosu_core_buffer *cbuf)
+{
+	cbuf->ptr = (uint32_t)buf->dma_addr + buf->offset + buf->size;
+	cbuf->size = (uint32_t)buf->capacity - buf->offset - buf->size;
+}
+
+static size_t ethosu_queue_available(struct ethosu_core_queue *queue)
+{
+	size_t size = queue->header.write - queue->header.read;
+
+	if (queue->header.read > queue->header.write)
+		size += queue->header.size;
+
+	return size;
+}
+
+static size_t ethosu_queue_capacity(struct ethosu_core_queue *queue)
+{
+	return queue->header.size - ethosu_queue_available(queue);
+}
+
+static int ethosu_queue_write(struct ethosu_mailbox *mbox,
+			      const struct kvec *vec,
+			      size_t length)
+{
+	struct ethosu_core_queue *queue = mbox->in_queue;
+	uint8_t *dst = &queue->data[0];
+	uint32_t wpos = queue->header.write;
+	size_t total_size;
+	size_t i;
+	int ret;
+
+	for (i = 0, total_size = 0; i < length; i++)
+		total_size += vec[i].iov_len;
+
+	if (total_size > ethosu_queue_capacity(queue))
+		return -EINVAL;
+
+	for (i = 0; i < length; i++) {
+		const uint8_t *src = vec[i].iov_base;
+		const uint8_t *end = src + vec[i].iov_len;
+
+		while (src < end) {
+			dst[wpos] = *src++;
+			wpos = (wpos + 1) % queue->header.size;
+		}
+	}
+
+	queue->header.write = wpos;
+
+	ret = mbox_send_message(mbox->tx, queue);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ethosu_queue_write_msg(struct ethosu_mailbox *mbox,
+				  uint32_t type,
+				  void *data,
+				  size_t length)
+{
+	struct ethosu_core_msg msg = {
+		.magic = ETHOSU_CORE_MSG_MAGIC,
+		.type  = type,                 .length= length
+	};
+	const struct kvec vec[2] = {
+		{ &msg, sizeof(msg) },
+		{ data, length      }
+	};
+
+	return ethosu_queue_write(mbox, vec, 2);
+}
+
+static int ethosu_queue_read(struct ethosu_mailbox *mbox,
+			     void *data,
+			     size_t length)
+{
+	struct ethosu_core_queue *queue = mbox->out_queue;
+	uint8_t *src = &queue->data[0];
+	uint8_t *dst = (uint8_t *)data;
+	const uint8_t *end = dst + length;
+	uint32_t rpos = queue->header.read;
+	size_t queue_avail = ethosu_queue_available(queue);
+
+	if (length == 0)
+		return 0;
+	else if (queue_avail == 0)
+		return -ENOMSG;
+	else if (length > queue_avail)
+		return -EBADMSG;
+
+	while (dst < end) {
+		*dst++ = src[rpos];
+		rpos = (rpos + 1) % queue->header.size;
+	}
+
+	queue->header.read = rpos;
+
+	return 0;
+}
+
+void ethosu_mailbox_reset(struct ethosu_mailbox *mbox)
+{
+	mbox->out_queue->header.read = mbox->out_queue->header.write;
+}
+
+int ethosu_mailbox_read(struct ethosu_mailbox *mbox,
+			struct ethosu_core_msg *header,
+			void *data,
+			size_t length)
+{
+	int ret;
+
+	/* Read message header magic */
+	ret = ethosu_queue_read(mbox, header, sizeof(*header));
+	if (ret) {
+		if (ret != -ENOMSG)
+			dev_warn(mbox->dev,
+				 "Msg: Failed to read message header\n");
+
+		return ret;
+	}
+
+	if (header->magic != ETHOSU_CORE_MSG_MAGIC) {
+		dev_warn(mbox->dev,
+			 "Msg: Invalid magic. Got: %08X but expected %08X\n",
+			 header->magic, ETHOSU_CORE_MSG_MAGIC);
+
+		return -EINVAL;
+	}
+
+	dev_info(mbox->dev,
+		 "mbox: Read msg header. magic=%08X, type=%u, length=%u",
+		 header->magic, header->type, header->length);
+
+	/* Check that payload is not larger than allocated buffer */
+	if (header->length > length) {
+		dev_warn(mbox->dev,
+			 "Msg: Buffer size (%zu) too small for message (%u)\n",
+			 sizeof(data), header->length);
+
+		return -ENOMEM;
+	}
+
+	/* Read payload data */
+	ret = ethosu_queue_read(mbox, data, header->length);
+	if (ret) {
+		dev_warn(mbox->dev, "Msg: Failed to read payload data\n");
+
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+
+int ethosu_mailbox_ping(struct ethosu_mailbox *mbox)
+{
+	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_PING, NULL, 0);
+}
+
+int ethosu_mailbox_pong(struct ethosu_mailbox *mbox)
+{
+	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_PONG, NULL, 0);
+}
+
+int ethosu_mailbox_version_request(struct ethosu_mailbox *mbox)
+{
+	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_VERSION_REQ, NULL,
+				      0);
+}
+
+int ethosu_mailbox_capabilities_request(struct ethosu_mailbox *mbox,
+					void *user_arg)
+{
+	struct ethosu_core_capabilities_req req = {
+		.user_arg = (ptrdiff_t)user_arg
+	};
+
+	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_CAPABILITIES_REQ,
+				      &req,
+				      sizeof(req));
+}
+
+int ethosu_mailbox_inference(struct ethosu_mailbox *mbox,
+			     void *user_arg,
+			     uint32_t ifm_count,
+			     struct ethosu_buffer **ifm,
+			     uint32_t ofm_count,
+			     struct ethosu_buffer **ofm,
+			     struct ethosu_buffer *network,
+			     uint8_t *pmu_event_config,
+			     uint8_t pmu_event_config_count,
+			     uint8_t pmu_cycle_counter_enable)
+{
+	struct ethosu_core_inference_req inf;
+	uint32_t i;
+
+	/* Verify that the uapi and core has the same number of pmus */
+	if (pmu_event_config_count != ETHOSU_CORE_PMU_MAX) {
+		dev_err(mbox->dev, "PMU count misconfigured.\n");
+
+		return -EINVAL;
+	}
+
+	inf.user_arg = (ptrdiff_t)user_arg;
+	inf.ifm_count = ifm_count;
+	inf.ofm_count = ofm_count;
+	inf.pmu_cycle_counter_enable = pmu_cycle_counter_enable;
+
+	for (i = 0; i < ifm_count; i++)
+		ethosu_core_set_size(ifm[i], &inf.ifm[i]);
+
+	for (i = 0; i < ofm_count; i++)
+		ethosu_core_set_capacity(ofm[i], &inf.ofm[i]);
+
+	for (i = 0; i < ETHOSU_CORE_PMU_MAX; i++)
+		inf.pmu_event_config[i] = pmu_event_config[i];
+
+	ethosu_core_set_size(network, &inf.network);
+
+	return ethosu_queue_write_msg(mbox, ETHOSU_CORE_MSG_INFERENCE_REQ,
+				      &inf, sizeof(inf));
+}
+
+static void ethosu_mailbox_rx_work(struct work_struct *work)
+{
+	struct ethosu_mailbox *mbox = container_of(work, typeof(*mbox), work);
+
+	mbox->callback(mbox->user_arg);
+}
+
+static void ethosu_mailbox_rx_callback(struct mbox_client *client,
+				       void *message)
+{
+	struct ethosu_mailbox *mbox =
+		container_of(client, typeof(*mbox), client);
+
+	dev_info(mbox->dev, "mbox: Received message.\n");
+
+	queue_work(mbox->wq, &mbox->work);
+}
+
+static void ethosu_mailbox_tx_done(struct mbox_client *client,
+				   void *message,
+				   int r)
+{
+	if (r)
+		dev_warn(client->dev, "mbox: Failed sending message (%d)\n", r);
+	else
+		dev_info(client->dev, "mbox: Message sent\n");
+}
+
+int ethosu_mailbox_init(struct ethosu_mailbox *mbox,
+			struct device *dev,
+			struct resource *in_queue,
+			struct resource *out_queue,
+			ethosu_mailbox_cb callback,
+			void *user_arg)
+{
+	int ret;
+
+	mbox->dev = dev;
+	mbox->callback = callback;
+	mbox->user_arg = user_arg;
+
+	mbox->client.dev = dev;
+	mbox->client.rx_callback = ethosu_mailbox_rx_callback;
+	mbox->client.tx_prepare = NULL; /* preparation of data is handled
+	                                 * through the
+	                                 * queue functions */
+	mbox->client.tx_done = ethosu_mailbox_tx_done;
+	mbox->client.tx_block = true;
+	mbox->client.knows_txdone = false;
+	mbox->client.tx_tout = 500;
+
+	mbox->in_queue = devm_ioremap_resource(mbox->dev, in_queue);
+	if (IS_ERR(mbox->in_queue))
+		return PTR_ERR(mbox->in_queue);
+
+	mbox->out_queue = devm_ioremap_resource(mbox->dev, out_queue);
+	if (IS_ERR(mbox->out_queue)) {
+		ret = PTR_ERR(mbox->out_queue);
+		goto unmap_in_queue;
+	}
+
+	mbox->wq = create_singlethread_workqueue("ethosu_workqueue");
+	if (!mbox->wq) {
+		dev_err(mbox->dev, "Failed to create work queue\n");
+		ret = -EINVAL;
+		goto unmap_out_queue;
+	}
+
+	INIT_WORK(&mbox->work, ethosu_mailbox_rx_work);
+
+	mbox->tx = mbox_request_channel_byname(&mbox->client, "tx");
+	if (IS_ERR(mbox->tx)) {
+		dev_warn(mbox->dev, "mbox: Failed to request tx channel\n");
+		ret = PTR_ERR(mbox->tx);
+		goto workqueue_destroy;
+	}
+
+	mbox->rx = mbox_request_channel_byname(&mbox->client, "rx");
+	if (IS_ERR(mbox->rx)) {
+		dev_info(dev, "mbox: Using same channel for RX and TX\n");
+		mbox->rx = mbox->tx;
+	}
+
+	return 0;
+
+workqueue_destroy:
+	destroy_workqueue(mbox->wq);
+
+unmap_out_queue:
+	devm_iounmap(mbox->dev, mbox->out_queue);
+
+unmap_in_queue:
+	devm_iounmap(mbox->dev, mbox->in_queue);
+
+	return ret;
+}
+
+void ethosu_mailbox_deinit(struct ethosu_mailbox *mbox)
+{
+	if (mbox->rx != mbox->tx)
+		mbox_free_channel(mbox->rx);
+
+	mbox_free_channel(mbox->tx);
+	destroy_workqueue(mbox->wq);
+	devm_iounmap(mbox->dev, mbox->out_queue);
+	devm_iounmap(mbox->dev, mbox->in_queue);
+}
diff --git a/drivers/firmware/ethosu/ethosu_mailbox.h b/drivers/firmware/ethosu/ethosu_mailbox.h
new file mode 100644
index 000000000000..5cd5e62198b8
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_mailbox.h
@@ -0,0 +1,140 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_MAILBOX_H
+#define ETHOSU_MAILBOX_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+#include "ethosu_core_interface.h"
+
+#include <linux/types.h>
+#include <linux/mailbox_client.h>
+#include <linux/workqueue.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct device;
+struct ethosu_buffer;
+struct ethosu_device;
+struct ethosu_core_msg;
+struct ethosu_core_queue;
+struct resource;
+
+typedef void (*ethosu_mailbox_cb)(void *user_arg);
+
+struct ethosu_mailbox {
+	struct device            *dev;
+	struct workqueue_struct  *wq;
+	struct work_struct       work;
+	struct ethosu_core_queue __iomem *in_queue;
+	struct ethosu_core_queue __iomem *out_queue;
+	struct mbox_client       client;
+	struct mbox_chan         *rx;
+	struct mbox_chan         *tx;
+	ethosu_mailbox_cb        callback;
+	void                     *user_arg;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_mailbox_init() - Initialize mailbox
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_mailbox_init(struct ethosu_mailbox *mbox,
+			struct device *dev,
+			struct resource *in_queue,
+			struct resource *out_queue,
+			ethosu_mailbox_cb callback,
+			void *user_arg);
+
+/**
+ * ethosu_mailbox_deinit() - Deinitialize mailbox
+ */
+void ethosu_mailbox_deinit(struct ethosu_mailbox *mbox);
+
+/**
+ * ethosu_mailbox_read() - Read message from mailbox
+ *
+ * Return: 0 message read, else error code.
+ */
+int ethosu_mailbox_read(struct ethosu_mailbox *mbox,
+			struct ethosu_core_msg *header,
+			void *data,
+			size_t length);
+
+/**
+ * ethosu_mailbox_reset() - Reset to end of queue
+ */
+void ethosu_mailbox_reset(struct ethosu_mailbox *mbox);
+
+/**
+ * ethosu_mailbox_ping() - Send ping message
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_mailbox_ping(struct ethosu_mailbox *mbox);
+
+/**
+ * ethosu_mailbox_pong() - Send pong response
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_mailbox_pong(struct ethosu_mailbox *mbox);
+
+/**
+ * ethosu_mailbox_version_response - Send version request
+ *
+ * Return: 0 on succes, else error code
+ */
+int ethosu_mailbox_version_request(struct ethosu_mailbox *mbox);
+
+/**
+ * ethosu_mailbox_capabilities_request() - Send capabilities request
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_mailbox_capabilities_request(struct ethosu_mailbox *mbox,
+					void *user_arg);
+
+/**
+ * ethosu_mailbox_inference() - Send inference
+ *
+ * Return: 0 on success, else error code.
+ */
+int ethosu_mailbox_inference(struct ethosu_mailbox *mbox,
+			     void *user_arg,
+			     uint32_t ifm_count,
+			     struct ethosu_buffer **ifm,
+			     uint32_t ofm_count,
+			     struct ethosu_buffer **ofm,
+			     struct ethosu_buffer *network,
+			     uint8_t *pmu_event_config,
+			     uint8_t pmu_event_config_count,
+			     uint8_t pmu_cycle_counter_enable);
+
+#endif /* ETHOSU_MAILBOX_H */
diff --git a/drivers/firmware/ethosu/ethosu_network.c b/drivers/firmware/ethosu/ethosu_network.c
new file mode 100644
index 000000000000..4d68f0537e38
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_network.c
@@ -0,0 +1,201 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include "ethosu_network.h"
+
+#include "ethosu_buffer.h"
+#include "ethosu_device.h"
+#include "ethosu_inference.h"
+#include "uapi/ethosu.h"
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+
+/****************************************************************************
+ * Variables
+ ****************************************************************************/
+
+static int ethosu_network_release(struct inode *inode,
+				  struct file *file);
+
+static long ethosu_network_ioctl(struct file *file,
+				 unsigned int cmd,
+				 unsigned long arg);
+
+static const struct file_operations ethosu_network_fops = {
+	.release        = &ethosu_network_release,
+	.unlocked_ioctl = &ethosu_network_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = &ethosu_network_ioctl,
+#endif
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+static bool ethosu_network_verify(struct file *file)
+{
+	return file->f_op == &ethosu_network_fops;
+}
+
+static void ethosu_network_destroy(struct kref *kref)
+{
+	struct ethosu_network *net =
+		container_of(kref, struct ethosu_network, kref);
+
+	dev_info(net->edev->dev, "Network destroy. handle=0x%pK\n", net);
+
+	ethosu_buffer_put(net->buf);
+	devm_kfree(net->edev->dev, net);
+}
+
+static int ethosu_network_release(struct inode *inode,
+				  struct file *file)
+{
+	struct ethosu_network *net = file->private_data;
+
+	dev_info(net->edev->dev, "Network release. handle=0x%pK\n", net);
+
+	ethosu_network_put(net);
+
+	return 0;
+}
+
+static long ethosu_network_ioctl(struct file *file,
+				 unsigned int cmd,
+				 unsigned long arg)
+{
+	struct ethosu_network *net = file->private_data;
+	void __user *udata = (void __user *)arg;
+	int ret = -EINVAL;
+
+	ret = mutex_lock_interruptible(&net->edev->mutex);
+	if (ret)
+		return ret;
+
+	dev_info(net->edev->dev, "Ioctl: cmd=%u, arg=%lu\n", cmd, arg);
+
+	switch (cmd) {
+	case ETHOSU_IOCTL_INFERENCE_CREATE: {
+		struct ethosu_uapi_inference_create uapi;
+
+		if (copy_from_user(&uapi, udata, sizeof(uapi)))
+			break;
+
+		dev_info(net->edev->dev,
+			 "Ioctl: Inference. ifm_fd=%u, ofm_fd=%u\n",
+			 uapi.ifm_fd[0], uapi.ofm_fd[0]);
+
+		ret = ethosu_inference_create(net->edev, net, &uapi);
+		break;
+	}
+	default: {
+		dev_err(net->edev->dev, "Invalid ioctl. cmd=%u, arg=%lu",
+			cmd, arg);
+		break;
+	}
+	}
+
+	mutex_unlock(&net->edev->mutex);
+
+	return ret;
+}
+
+int ethosu_network_create(struct ethosu_device *edev,
+			  struct ethosu_uapi_network_create *uapi)
+{
+	struct ethosu_buffer *buf;
+	struct ethosu_network *net;
+	int ret = -ENOMEM;
+
+	buf = ethosu_buffer_get_from_fd(uapi->fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	net = devm_kzalloc(edev->dev, sizeof(*net), GFP_KERNEL);
+	if (!net) {
+		ret = -ENOMEM;
+		goto put_buf;
+	}
+
+	net->edev = edev;
+	net->buf = buf;
+	kref_init(&net->kref);
+
+	ret = anon_inode_getfd("ethosu-network", &ethosu_network_fops, net,
+			       O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto free_net;
+
+	net->file = fget(ret);
+	fput(net->file);
+
+	dev_info(edev->dev, "Network create. handle=0x%pK",
+		 net);
+
+	return ret;
+
+free_net:
+	devm_kfree(edev->dev, net);
+
+put_buf:
+	ethosu_buffer_put(buf);
+
+	return ret;
+}
+
+struct ethosu_network *ethosu_network_get_from_fd(int fd)
+{
+	struct ethosu_network *net;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return ERR_PTR(-EINVAL);
+
+	if (!ethosu_network_verify(file)) {
+		fput(file);
+
+		return ERR_PTR(-EINVAL);
+	}
+
+	net = file->private_data;
+	ethosu_network_get(net);
+	fput(file);
+
+	return net;
+}
+
+void ethosu_network_get(struct ethosu_network *net)
+{
+	kref_get(&net->kref);
+}
+
+void ethosu_network_put(struct ethosu_network *net)
+{
+	kref_put(&net->kref, ethosu_network_destroy);
+}
diff --git a/drivers/firmware/ethosu/ethosu_network.h b/drivers/firmware/ethosu/ethosu_network.h
new file mode 100644
index 000000000000..bb70afcb2572
--- /dev/null
+++ b/drivers/firmware/ethosu/ethosu_network.h
@@ -0,0 +1,81 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_NETWORK_H
+#define ETHOSU_NETWORK_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include <linux/kref.h>
+#include <linux/types.h>
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+struct ethosu_buffer;
+struct ethosu_device;
+struct ethosu_uapi_network_create;
+struct device;
+struct file;
+
+struct ethosu_network {
+	struct ethosu_device *edev;
+	struct file          *file;
+	struct kref          kref;
+	struct ethosu_buffer *buf;
+};
+
+/****************************************************************************
+ * Functions
+ ****************************************************************************/
+
+/**
+ * ethosu_network_create() - Create network
+ *
+ * This function must be called in the context of a user space process.
+ *
+ * Return: fd on success, else error code.
+ */
+int ethosu_network_create(struct ethosu_device *edev,
+			  struct ethosu_uapi_network_create *uapi);
+
+/**
+ * ethosu_network_get_from_fd() - Get network handle from fd
+ *
+ * This function must be called from a user space context.
+ *
+ * Return: Pointer on success, else ERR_PTR.
+ */
+struct ethosu_network *ethosu_network_get_from_fd(int fd);
+
+/**
+ * ethosu_network_get() - Get network
+ */
+void ethosu_network_get(struct ethosu_network *net);
+
+/**
+ * ethosu_network_put() - Put network
+ */
+void ethosu_network_put(struct ethosu_network *net);
+
+#endif /* ETHOSU_NETWORK_H */
diff --git a/drivers/firmware/ethosu/uapi/ethosu.h b/drivers/firmware/ethosu/uapi/ethosu.h
new file mode 100644
index 000000000000..903316dff7b3
--- /dev/null
+++ b/drivers/firmware/ethosu/uapi/ethosu.h
@@ -0,0 +1,207 @@
+/*
+ * (C) COPYRIGHT 2020 ARM Limited. All rights reserved.
+ *
+ * This program is free software and is provided to you under the terms of the
+ * GNU General Public License version 2 as published by the Free Software
+ * Foundation, and any use by you of this program is subject to the terms
+ * of such GNU licence.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
+ */
+
+#ifndef ETHOSU_H
+#define ETHOSU_H
+
+/****************************************************************************
+ * Includes
+ ****************************************************************************/
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+#ifdef __cplusplus
+namespace EthosU {
+#endif
+
+/****************************************************************************
+ * Defines
+ ****************************************************************************/
+
+#define ETHOSU_IOCTL_BASE               0x01
+#define ETHOSU_IO(nr)                   _IO(ETHOSU_IOCTL_BASE, nr)
+#define ETHOSU_IOR(nr, type)            _IOR(ETHOSU_IOCTL_BASE, nr, type)
+#define ETHOSU_IOW(nr, type)            _IOW(ETHOSU_IOCTL_BASE, nr, type)
+#define ETHOSU_IOWR(nr, type)           _IOWR(ETHOSU_IOCTL_BASE, nr, type)
+
+#define ETHOSU_IOCTL_PING               ETHOSU_IO(0x00)
+#define ETHOSU_IOCTL_VERSION_REQ        ETHOSU_IO(0x01)
+#define ETHOSU_IOCTL_CAPABILITIES_REQ   ETHOSU_IO(0x02)
+#define ETHOSU_IOCTL_BUFFER_CREATE      ETHOSU_IOR(0x10, \
+						   struct ethosu_uapi_buffer_create)
+#define ETHOSU_IOCTL_BUFFER_SET         ETHOSU_IOR(0x11, \
+						   struct ethosu_uapi_buffer)
+#define ETHOSU_IOCTL_BUFFER_GET         ETHOSU_IOW(0x12, \
+						   struct ethosu_uapi_buffer)
+#define ETHOSU_IOCTL_NETWORK_CREATE     ETHOSU_IOR(0x20, \
+						   struct ethosu_uapi_network_create)
+#define ETHOSU_IOCTL_INFERENCE_CREATE   ETHOSU_IOR(0x30, \
+						   struct ethosu_uapi_inference_create)
+#define ETHOSU_IOCTL_INFERENCE_STATUS   ETHOSU_IOR(0x31, \
+						   struct ethosu_uapi_result_status)
+
+/* Maximum number of IFM/OFM file descriptors per network */
+#define ETHOSU_FD_MAX                   16
+
+/* Maximum number of PMUs available */
+#define ETHOSU_PMU_EVENT_MAX             8
+
+/****************************************************************************
+ * Types
+ ****************************************************************************/
+
+/**
+ * enum ethosu_uapi_status - Status
+ */
+enum ethosu_uapi_status {
+	ETHOSU_UAPI_STATUS_OK,
+	ETHOSU_UAPI_STATUS_ERROR
+};
+
+/**
+ * struct ethosu_uapi_buffer_create - Create buffer request
+ * @capacity:	Maximum capacity of the buffer
+ */
+struct ethosu_uapi_buffer_create {
+	__u32 capacity;
+};
+
+/**
+ * struct ethosu_uapi_buffer - Buffer descriptor
+ * @offset:	Offset to where the data starts
+ * @size:	Size of the data
+ *
+ * 'offset + size' must not exceed the capacity of the buffer.
+ */
+struct ethosu_uapi_buffer {
+	__u32 offset;
+	__u32 size;
+};
+
+/**
+ * struct ethosu_uapi_network_create - Create network request
+ * @fd:		Buffer file descriptor
+ */
+struct ethosu_uapi_network_create {
+	__u32 fd;
+};
+
+/**
+ * struct ethosu_uapi_pmu_config - Configure performance counters
+ * @events:             Array of counters to configure, set to non-zero for
+ *                      each counter to enable corresponding event.
+ * @cycle_count:        Set to enable the cycle counter.
+ */
+struct ethosu_uapi_pmu_config {
+	__u32 events[ETHOSU_PMU_EVENT_MAX];
+	__u32 cycle_count;
+};
+
+/**
+ * struct ethosu_uapi_pmu_counts - Status of performance counters
+ * @events:             Count for respective configured events.
+ * @cycle_count:        Count for cycle counter.
+ */
+struct ethosu_uapi_pmu_counts {
+	__u32 events[ETHOSU_PMU_EVENT_MAX];
+	__u64 cycle_count;
+};
+
+/**
+ * struct ethosu_uapi_device_hw_id - Device hardware identification
+ * @version_status:            Version status
+ * @version_minor:             Version minor
+ * @version_major:             Version major
+ * @product_major:             Product major
+ * @arch_patch_rev:            Architecture version patch
+ * @arch_minor_rev:            Architecture version minor
+ * @arch_major_rev:            Architecture version major
+ */
+struct ethosu_uapi_device_hw_id {
+	__u32 version_status;
+	__u32 version_minor;
+	__u32 version_major;
+	__u32 product_major;
+	__u32 arch_patch_rev;
+	__u32 arch_minor_rev;
+	__u32 arch_major_rev;
+};
+
+/**
+ * struct ethosu_uapi_device_hw_cfg - Device hardware configuration
+ * @macs_per_cc:               MACs per clock cycle
+ * @cmd_stream_version:        NPU command stream version
+ * @custom_dma:                Custom DMA enabled
+ */
+struct ethosu_uapi_device_hw_cfg {
+	__u32 macs_per_cc;
+	__u32 cmd_stream_version;
+	__u32 custom_dma;
+};
+
+/**
+ * struct ethosu_uapi_capabilities - Device capabilities
+ * @hw_id:                     Hardware identification
+ * @hw_cfg:                    Hardware configuration
+ * @driver_patch_rev:          Driver version patch
+ * @driver_minor_rev:          Driver version minor
+ * @driver_major_rev:          Driver version major
+ */
+struct ethosu_uapi_device_capabilities {
+	struct ethosu_uapi_device_hw_id  hw_id;
+	struct ethosu_uapi_device_hw_cfg hw_cfg;
+	__u32                            driver_patch_rev;
+	__u32                            driver_minor_rev;
+	__u32                            driver_major_rev;
+};
+
+/**
+ * struct ethosu_uapi_inference_create - Create network request
+ * @ifm_count:		Number of IFM file descriptors
+ * @ifm_fd:		IFM buffer file descriptors
+ * @ofm_count:		Number of OFM file descriptors
+ * @ofm_fd:		OFM buffer file descriptors
+ */
+struct ethosu_uapi_inference_create {
+	__u32                         ifm_count;
+	__u32                         ifm_fd[ETHOSU_FD_MAX];
+	__u32                         ofm_count;
+	__u32                         ofm_fd[ETHOSU_FD_MAX];
+	struct ethosu_uapi_pmu_config pmu_config;
+};
+
+/**
+ * struct ethosu_uapi_result_status - Status of inference
+ * @status	Status of run inference.
+ * @pmu_config	Configured performance counters.
+ * @pmu_count	Perfomance counters values, when status is
+ *              ETHOSU_UAPI_STATUS_OK.
+ */
+struct ethosu_uapi_result_status {
+	enum ethosu_uapi_status       status;
+	struct ethosu_uapi_pmu_config pmu_config;
+	struct ethosu_uapi_pmu_counts pmu_count;
+};
+
+#ifdef __cplusplus
+} /* namespace EthosU */
+#endif
+#endif
-- 
2.17.1

