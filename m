Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0C6BBC33
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjCOSej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCOSeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E096A4F;
        Wed, 15 Mar 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905252; x=1710441252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sZA92xYaQ0h8ypQ1+D2Khsxotdmw78gsyoPN7vgwzww=;
  b=k+ZTZ5EXH4L4AGvlKO0mLkIaxPLy8OiEjOd9xB5vxf80oca/p0VF/6eJ
   5HDvIOtuzWyvqXgLHGL4RFSuchrvOhw4PhOgZoDCDOKcA4DN5Mw9iacHx
   6YvypD+vf5KabPm2I3/VZExbhVMrfpdjMppBodJXZItiVAImsk7yEyvS+
   1UMCBJB+isAbvI8i/ucBIN5tyqOOlfjnkFlQMzMAkMOuSo0B+ZsEczQno
   2XyHJS/+SJb/pUrBM0Q3VctSgViB9LZoE1k6kUQpcvSLVTA1pdrfzx0Hg
   UUaOujJSR8knEoUzJSBNESEBYQShiYgYUjimlO2a9ex7L+yL9A0t0BN0Y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154543"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154543"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435211"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435211"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:07 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 4D801580BF2;
        Wed, 15 Mar 2023 11:34:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 05/11] platform/x86/intel/pmt: telemetry: Add telemetry read functions
Date:   Wed, 15 Mar 2023 11:33:59 -0700
Message-Id: <20230315183405.2465630-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export symbols to allow access to Intel PMT Telemetry data on available
devices. Provides APIs to search, register, and read telemetry using a
kref managed pointer that serves as a handle to a telemetry entry.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c     |  28 +--
 drivers/platform/x86/intel/pmt/class.h     |  30 +++-
 drivers/platform/x86/intel/pmt/crashlog.c  |   2 +-
 drivers/platform/x86/intel/pmt/telemetry.c | 196 ++++++++++++++++++++-
 drivers/platform/x86/intel/pmt/telemetry.h | 120 +++++++++++++
 5 files changed, 353 insertions(+), 23 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index acc96f0cc224..4fc8d48ef3be 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -17,7 +17,7 @@
 #include "../vsec.h"
 #include "class.h"
 
-#define PMT_XA_START		0
+#define PMT_XA_START		1
 #define PMT_XA_MAX		INT_MAX
 #define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
 #define GUID_SPR_PUNIT		0x9956f43f
@@ -160,12 +160,12 @@ static struct class intel_pmt_class = {
 };
 
 static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
-				    struct intel_pmt_header *header,
 				    struct intel_vsec_device *ivdev,
 				    struct resource *disc_res)
 {
 	struct pci_dev *pci_dev = ivdev->pcidev;
 	struct device *dev = &ivdev->auxdev.dev;
+	struct intel_pmt_header *header = &entry->header;
 	u8 bir;
 
 	/*
@@ -271,7 +271,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 	if (ns->attr_grp) {
 		ret = sysfs_create_group(entry->kobj, ns->attr_grp);
 		if (ret)
-			goto fail_sysfs;
+			goto fail_sysfs_create_group;
 	}
 
 	/* if size is 0 assume no data buffer, so no file needed */
@@ -296,13 +296,23 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 	entry->pmt_bin_attr.size = entry->size;
 
 	ret = sysfs_create_bin_file(&dev->kobj, &entry->pmt_bin_attr);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto fail_ioremap;
 
+	if (ns->pmt_add_handle) {
+		ret = ns->pmt_add_handle(entry, parent);
+		if (ret)
+			goto fail_add_handle;
+	}
+
+	return 0;
+
+fail_add_handle:
+	sysfs_remove_bin_file(entry->kobj, &entry->pmt_bin_attr);
 fail_ioremap:
 	if (ns->attr_grp)
 		sysfs_remove_group(entry->kobj, ns->attr_grp);
-fail_sysfs:
+fail_sysfs_create_group:
 	device_unregister(dev);
 fail_dev_create:
 	xa_erase(ns->xa, entry->devid);
@@ -314,7 +324,6 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 			 struct intel_vsec_device *intel_vsec_dev, int idx)
 {
 	struct device *dev = &intel_vsec_dev->auxdev.dev;
-	struct intel_pmt_header header;
 	struct resource	*disc_res;
 	int ret;
 
@@ -324,16 +333,15 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
 	if (IS_ERR(entry->disc_table))
 		return PTR_ERR(entry->disc_table);
 
-	ret = ns->pmt_header_decode(entry, &header, dev);
+	ret = ns->pmt_header_decode(entry, dev);
 	if (ret)
 		return ret;
 
-	ret = intel_pmt_populate_entry(entry, &header, intel_vsec_dev, disc_res);
+	ret = intel_pmt_populate_entry(entry, intel_vsec_dev, disc_res);
 	if (ret)
 		return ret;
 
 	return intel_pmt_dev_register(entry, ns, dev);
-
 }
 EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, INTEL_PMT);
 
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index 17bc40b77efc..7b730cdaed5a 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 #include "../vsec.h"
+#include "telemetry.h"
 
 /* PMT access types */
 #define ACCESS_BARID		2
@@ -18,8 +19,27 @@
 #define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
 
 struct xarray;
+struct pci_dev;
+
+struct telem_handle {
+	struct pci_dev		*parent;
+	struct telem_header	header;
+	struct device		*dev;
+	void __iomem		*base;
+	bool			present;
+	struct kref		kref;
+};
+
+struct intel_pmt_header {
+	u32	base_offset;
+	u32	size;
+	u32	guid;
+	u8	access_type;
+};
 
 struct intel_pmt_entry {
+	struct telem_handle	*handle;
+	struct intel_pmt_header	header;
 	struct bin_attribute	pmt_bin_attr;
 	struct kobject		*kobj;
 	void __iomem		*disc_table;
@@ -30,20 +50,14 @@ struct intel_pmt_entry {
 	int			devid;
 };
 
-struct intel_pmt_header {
-	u32	base_offset;
-	u32	size;
-	u32	guid;
-	u8	access_type;
-};
-
 struct intel_pmt_namespace {
 	const char *name;
 	struct xarray *xa;
 	const struct attribute_group *attr_grp;
 	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
-				 struct intel_pmt_header *header,
 				 struct device *dev);
+	int (*pmt_add_handle)(struct intel_pmt_entry *entry,
+			      struct device *dev);
 };
 
 bool intel_pmt_is_early_client_hw(struct device *dev);
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index bbb3d61d09f4..4014c02cafdb 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -223,10 +223,10 @@ static const struct attribute_group pmt_crashlog_group = {
 };
 
 static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
-				      struct intel_pmt_header *header,
 				      struct device *dev)
 {
 	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header *header = &entry->header;
 	struct crashlog_entry *crashlog;
 
 	if (!pmt_crashlog_supported(entry))
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 71cdef42084a..39ec8d9fb5b1 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -30,6 +30,14 @@
 /* Used by client hardware to identify a fixed telemetry entry*/
 #define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
 
+#define NUM_BYTES_QWORD(v)	((v) << 3)
+#define SAMPLE_ID_OFFSET(v)	((v) << 3)
+
+#define NUM_BYTES_DWORD(v)	((v) << 2)
+#define SAMPLE_ID_OFFSET32(v)	((v) << 2)
+
+static DEFINE_MUTEX(entry_lock);
+
 enum telem_type {
 	TELEM_TYPE_PUNIT = 0,
 	TELEM_TYPE_CRASHLOG,
@@ -58,10 +66,10 @@ static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
 }
 
 static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
-				   struct intel_pmt_header *header,
 				   struct device *dev)
 {
 	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header *header = &entry->header;
 
 	if (pmt_telem_region_overlaps(entry, dev))
 		return 1;
@@ -84,21 +92,199 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
 	return 0;
 }
 
+static int pmt_telem_add_handle(struct intel_pmt_entry *entry,
+				struct device *dev)
+{
+	struct telem_handle *handle;
+
+	entry->handle = kzalloc(sizeof(*(entry->handle)), GFP_KERNEL);
+	if (!entry->handle)
+		return -ENOMEM;
+
+	handle = entry->handle;
+	handle->dev = dev;
+	handle->parent = to_pci_dev(dev->parent);
+	handle->header.access_type = entry->header.access_type;
+	handle->header.guid = entry->header.guid;
+	handle->header.base_offset = entry->header.base_offset;
+	handle->header.size = entry->header.size;
+	handle->base = entry->base;
+	handle->present = true;
+
+	kref_init(&handle->kref);
+
+	return 0;
+}
+
 static DEFINE_XARRAY_ALLOC(telem_array);
 static struct intel_pmt_namespace pmt_telem_ns = {
 	.name = "telem",
 	.xa = &telem_array,
 	.pmt_header_decode = pmt_telem_header_decode,
+	.pmt_add_handle = pmt_telem_add_handle,
 };
 
+static void pmt_telem_handle_release(struct kref *kref)
+{
+	struct telem_handle *handle;
+
+	handle = container_of(kref, struct telem_handle, kref);
+	kfree(handle);
+}
+
+/*
+ * driver api
+ */
+int pmt_telem_get_next_entry(int start)
+{
+	struct intel_pmt_entry *entry;
+	unsigned long found_idx;
+
+	mutex_lock(&entry_lock);
+	xa_for_each_start(&telem_array, found_idx, entry, start) {
+		/*
+		 * Return first found index after start.
+		 * 0 is not valid id.
+		 */
+		if (found_idx > start)
+			break;
+	}
+	mutex_unlock(&entry_lock);
+
+	return found_idx == start ? 0 : found_idx;
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_get_next_entry, INTEL_PMT);
+
+struct telem_handle *pmt_telem_register_handle(int devid)
+{
+	struct intel_pmt_entry *entry;
+	unsigned long index = devid;
+
+	mutex_lock(&entry_lock);
+	entry = xa_find(&telem_array, &index, index, XA_PRESENT);
+	if (!entry) {
+		mutex_unlock(&entry_lock);
+		return ERR_PTR(-ENXIO);
+	}
+
+	kref_get(&entry->handle->kref);
+	mutex_unlock(&entry_lock);
+
+	return entry->handle;
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_register_handle, INTEL_PMT);
+
+void pmt_telem_unregister_handle(struct telem_handle *handle)
+{
+	kref_put(&handle->kref, pmt_telem_handle_release);
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_unregister_handle, INTEL_PMT);
+
+int pmt_telem_get_devid_info(int devid, struct telem_entry_info *info)
+{
+	struct intel_pmt_entry *entry;
+	unsigned long index = devid;
+	int err = 0;
+
+	if (!info)
+		return -EINVAL;
+
+	mutex_lock(&entry_lock);
+	entry = xa_find(&telem_array, &index, index, XA_PRESENT);
+	if (!entry) {
+		err = -ENXIO;
+		goto unlock;
+	}
+
+	info->pdev = entry->handle->parent;
+	info->header = entry->handle->header;
+
+unlock:
+	mutex_unlock(&entry_lock);
+	return err;
+
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_get_devid_info, INTEL_PMT);
+
+int
+pmt_telem_read(struct telem_handle *handle, u32 id, u64 *data, u32 count)
+{
+	u32 offset, size;
+
+	if (!handle->present)
+		return -ENODEV;
+
+	offset = SAMPLE_ID_OFFSET(id);
+	size = handle->header.size;
+
+	if ((offset + NUM_BYTES_QWORD(count)) > size)
+		return -EINVAL;
+
+	memcpy_fromio(data, handle->base + offset, NUM_BYTES_QWORD(count));
+
+	return handle->present ? 0 : -EPIPE;
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_read, INTEL_PMT);
+
+int
+pmt_telem_read32(struct telem_handle *handle, u32 id, u32 *data, u32 count)
+{
+	u32 offset, size;
+
+	if (!handle->present)
+		return -ENODEV;
+
+	offset = SAMPLE_ID_OFFSET32(id);
+	size = handle->header.size;
+
+	if ((offset + NUM_BYTES_DWORD(count)) > size)
+		return -EINVAL;
+
+	memcpy_fromio(data, handle->base + offset, NUM_BYTES_DWORD(count));
+
+	return handle->present ? 0 : -EPIPE;
+}
+EXPORT_SYMBOL_NS_GPL(pmt_telem_read32, INTEL_PMT);
+
+struct telem_handle *
+pmt_telem_find_and_register_handle(struct pci_dev *pcidev, u32 guid, u16 pos)
+{
+	int devid = 0;
+	int inst = 0;
+	int err = 0;
+
+	while ((devid = pmt_telem_get_next_entry(devid))) {
+		struct telem_entry_info info;
+
+		err = pmt_telem_get_devid_info(devid, &info);
+		if (err)
+			return ERR_PTR(err);
+
+		if (info.header.guid == guid && info.pdev == pcidev) {
+			if (inst == pos)
+				return pmt_telem_register_handle(devid);
+			++inst;
+		}
+	}
+
+	return ERR_PTR(-ENXIO);
+}
+EXPORT_SYMBOL_NS(pmt_telem_find_and_register_handle, INTEL_PMT);
+
 static void pmt_telem_remove(struct auxiliary_device *auxdev)
 {
 	struct pmt_telem_priv *priv = auxiliary_get_drvdata(auxdev);
 	int i;
 
-	for (i = 0; i < priv->num_entries; i++)
-		intel_pmt_dev_destroy(&priv->entry[i], &pmt_telem_ns);
-}
+	mutex_lock(&entry_lock);
+	for (i = 0; i < priv->num_entries; i++) {
+		struct intel_pmt_entry *entry = &priv->entry[i];
+
+		kref_put(&entry->handle->kref, pmt_telem_handle_release);
+		intel_pmt_dev_destroy(entry, &pmt_telem_ns);
+	}
+	mutex_unlock(&entry_lock);
+};
 
 static int pmt_telem_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
 {
@@ -117,7 +303,9 @@ static int pmt_telem_probe(struct auxiliary_device *auxdev, const struct auxilia
 	for (i = 0; i < intel_vsec_dev->num_resources; i++) {
 		struct intel_pmt_entry *entry = &priv->entry[priv->num_entries];
 
+		mutex_lock(&entry_lock);
 		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, intel_vsec_dev, i);
+		mutex_unlock(&entry_lock);
 		if (ret < 0)
 			goto abort_probe;
 		if (ret)
diff --git a/drivers/platform/x86/intel/pmt/telemetry.h b/drivers/platform/x86/intel/pmt/telemetry.h
new file mode 100644
index 000000000000..c78184f08d2e
--- /dev/null
+++ b/drivers/platform/x86/intel/pmt/telemetry.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INTEL_PMT_TELEM_H
+#define _INTEL_PMT_TELEM_H
+
+#include <linux/pm_runtime.h>
+
+/* Telemetry types */
+#define PMT_TELEM_TELEMETRY	0
+#define PMT_TELEM_CRASHLOG	1
+
+struct telem_handle;
+
+struct telem_header {
+	u8	access_type;
+	u16	size;
+	u32	guid;
+	u32	base_offset;
+};
+
+struct telem_entry_info {
+	struct pci_dev		*pdev;
+	struct telem_header	header;
+};
+
+struct pci_dev;
+
+/**
+ * pmt_telem_get_next_devid() - Get next devid for a telemetry entry
+ * @start:  starting devid to look from
+ *
+ * Use in a while loop to retrieve the devid of all available telemetry
+ * entries.
+ *
+ * Return:
+ * * devid       - devid of the next present handle from start
+ * * 0           - when no more handles are present after start
+ */
+int pmt_telem_get_next_entry(int start);
+
+/**
+ * pmt_telem_get_devid_info() - Get telemetry info for a telemetry entry from
+ * its devid
+ * @devid:  devid of the telemetry entry
+ * @info:   Endpoint info structure to be populated
+ *
+ * Return:
+ * * 0           - Success
+ * * -ENXIO      - devid no found
+ * * -EINVAL     - info is NULL
+ */
+int pmt_telem_get_devid_info(int devid, struct telem_entry_info *info);
+
+/**
+ * pmt_telem_register_handle() - Register a telemetry handle
+ * @devid:  devid of the telemetry entry
+ *
+ * Increments the kref usage counter for the handle.
+ *
+ * Return:
+ * * handle      - On success returns pointer to the telemetry handle
+ * * -ENXIO      - devid not found
+ */
+struct telem_handle *pmt_telem_register_handle(int devid);
+
+/**
+ * pmt_telem_unregister_handle() - Unregister a telemetry handle
+ * @handle: handle to unregister
+ *
+ * Decrements the kref usage counter for the handle.
+ */
+void pmt_telem_unregister_handle(struct telem_handle *handle);
+
+/**
+ * pmt_telem_find_and_register_handle() - Find and get a handle to a telemetry
+ * entry
+ * @pdev:   PCI device of the telemetry provider
+ * @guid:   GUID of the telemetry space
+ * @pos:    Instance of the guid in case of multiple instances
+ *
+ * Return:
+ * * handle      - On success returns pointer to the telemetry handle
+ * * -ENXIO      - Telemetry provider not found
+ */
+struct telem_handle *pmt_telem_find_and_register_handle(struct pci_dev *pcidev,
+							u32 guid, u16 pos);
+
+/**
+ * pmt_telem_read() - Read telemetry sample(s) from handle
+ * @ep:     Telemetry handle
+ * @id:     Starting sample id
+ * @data:   Allocated qword buffer
+ * @count:  Number of consecutive samples/qwords to read
+ *
+ * Return:
+ * * 0           - Success
+ * * -ENODEV	 - Entry is not present
+ * * -EINVAL     - The offset is out bounds of the sample space
+ * * -EPIPE	 - The device was removed during the read. Data written
+ *		   but should be considered invalid
+ */
+int pmt_telem_read(struct telem_handle *handle, u32 id, u64 *data,
+		   u32 count);
+
+/**
+ * pmt_telem_read32() - Read dword samples from handle
+ * @ep:     Telemetry handle
+ * @id:     Starting sample id
+ * @data:   Allocated dword buffer
+ * @count:  Number of consecutive samples/dwords to read
+ *
+ * Return:
+ * * 0           - Success
+ * * -ENODEV	 - Entry is not present
+ * * -EINVAL     - The offset is out bounds of the sample space
+ * * -EPIPE	 - The device was removed during the read. Data written
+ *		   but should be considered invalid.
+ */
+int pmt_telem_read32(struct telem_handle *handle, u32 id, u32 *data,
+		     u32 count);
+#endif
-- 
2.34.1

