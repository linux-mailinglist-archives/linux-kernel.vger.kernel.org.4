Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2776625156
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKKDNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiKKDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:55 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED05B5AC;
        Thu, 10 Nov 2022 19:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136374; x=1699672374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VsDB9dzd0mEr75cQiAY7peAbT1Qp+7elj42fOh/7AAo=;
  b=CXohdT7Bp1D0gxxie1HJ5GTlDiS1KHIObiEM6VNDOq6BbB+o2LwpYQn3
   r4oxhfv+ZihSdO7BnjpIll94sTegw4VD1Of/TudnjgkjxsnBjzvEwkZZu
   seHoX1oVbHDnZX3CEQrOrSIs0/NkHEtMia5wf9J5imuzOcJH93li2gqf6
   3hToYwXOyn0uPoezSNCMHAABVMhjOmpVJ104/45+78XLxuD0QmjVgkaxf
   Fmc4rVy16POO3iWefrexaply2w9Nv9TZ3U7rDMajHSBuJaqtvEUXIgU/B
   wLR8W1QZ/3G4Xy7K9GE3iyv4ZMF/QR81FsIFrPCob/4pwLqJD2LQXN32e
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224411"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296085"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296085"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:53 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] cxl/memdev: Add trigger_poison_list sysfs attribute
Date:   Thu, 10 Nov 2022 19:12:41 -0800
Message-Id: <5055dd47526d900f85f43bb0d85f4ccd4c9502b6.1668115235.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1668115235.git.alison.schofield@intel.com>
References: <cover.1668115235.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

When a boolean 'true' is written to this attribute the memdev driver
retrieves the poison list from the device. The list includes addresses
that are poisoned, or would result in poison if accessed, and the
source of the poison. This attribute is only visible for devices
supporting the capability. The retrieved errors are logged as kernel
trace events with the label 'cxl_poison'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++
 drivers/cxl/core/memdev.c               | 41 +++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..1c5f4a853ba2 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -388,3 +388,17 @@ Description:
 		1), and checks that the hardware accepts the commit request.
 		Reading this value indicates whether the region is committed or
 		not.
+
+
+What:		/sys/bus/cxl/devices/memX/trigger_poison_list
+Date:		November, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a boolean 'true' is written to this attribute the
+		memdev driver retrieves the poison list from the device. The
+		list includes addresses that are poisoned or would result in
+		poison if accessed, and the source of the poison. This
+		attribute is only visible for devices supporting the
+		capability. The retrieved errors are logged as kernel
+		trace events with the label 'cxl_poison'.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a7754..06d265db5127 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,45 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t trigger_poison_list_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 offset, length;
+	bool tmp;
+	int rc;
+
+	if (kstrtobool(buf, &tmp))
+		return -EINVAL;
+
+	/* Per CXL Spec, separate the pmem and ram poison list reads */
+	if (resource_size(&cxlds->pmem_res)) {
+		offset = cxlds->pmem_res.start;
+		length = resource_size(&cxlds->pmem_res);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc)
+			return rc;
+	}
+	if (resource_size(&cxlds->ram_res)) {
+		offset = cxlds->ram_res.start;
+		length = resource_size(&cxlds->ram_res);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
+		if (rc)
+			return rc;
+	}
+	return len;
+}
+static DEVICE_ATTR_WO(trigger_poison_list);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_trigger_poison_list.attr,
 	NULL,
 };
 
@@ -130,6 +163,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 {
 	if (!IS_ENABLED(CONFIG_NUMA) && a == &dev_attr_numa_node.attr)
 		return 0;
+
+	if (a == &dev_attr_trigger_poison_list.attr) {
+		struct device *dev = kobj_to_dev(kobj);
+
+		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
+			      to_cxl_memdev(dev)->cxlds->enabled_cmds))
+			return 0;
+	}
 	return a->mode;
 }
 
-- 
2.37.3

