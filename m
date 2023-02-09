Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6C691481
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjBIXfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjBIXez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:34:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD81567794;
        Thu,  9 Feb 2023 15:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675985670; x=1707521670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ib0/GcCFRrSl6cREklL0bMUgy5eAnlntcEuONs3IVBQ=;
  b=PlF2puszAQ3OZMhxAjNeYtzVXE3E2SHmFK6o2+4/e7iaTgfRP4nlIJpu
   gR7px1U3eKcFeUI3cvx1bmLyJ8N7oByLQ2qsuKZ9DEb61ztcTUmaV5EU5
   WC7GUumYf/SeS5SqJHIl635rFlTL6YIe/j8nHRmupON6ccx2HdDs2ysZ5
   A75zvmOP1mhHqzCmysTmVOtkrizKddIt7ArddK4o4M16XX3JyMeH5LFDr
   w6PM/+3yOHKhyzV982VWg/UcV5pPnxl46B5s7fSp8L6129JNkuGR/URBg
   DVuaIkz5r5YgcFKaqTKq7WeonDZ68f8SLGeB/yrU9Xd2X1D0JqQSOmR1C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="416508723"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="416508723"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756592040"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="756592040"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.13.232])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 15:33:06 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] cxl/memdev: Add trigger_poison_list sysfs attribute
Date:   Thu,  9 Feb 2023 15:32:56 -0800
Message-Id: <f579dc6a72af91e2859f8cecdc575b156e000723.1675983077.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1675983077.git.alison.schofield@intel.com>
References: <cover.1675983077.git.alison.schofield@intel.com>
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
retrieves the poison list from the device. The list consists of
addresses that are poisoned, or would result in poison if accessed,
and the source of the poison. This attribute is only visible for
devices supporting the capability. The retrieved errors are logged
as kernel trace events with the label 'cxl_poison'.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++
 drivers/cxl/core/memdev.c               | 56 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  2 +-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 329a7e46c805..035213f47882 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -403,3 +403,17 @@ Description:
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
+		list consists of addresses that are poisoned, or would result
+		in poison if accessed, and the source of the poison. This
+		attribute is only visible for devices supporting the
+		capability. The retrieved errors are logged as kernel
+		trace events with the label 'cxl_poison'.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a74a93310d26..19b833c9cf35 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,60 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 offset, length;
+	int rc = 0;
+
+	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
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
+		/*
+		 * Invalid Physical Address is not an error for
+		 * volatile addresses. Device support is optional.
+		 */
+		if (rc == -EFAULT)
+			rc = 0;
+	}
+	return rc;
+}
+
+static ssize_t trigger_poison_list_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	bool trigger;
+	int rc;
+
+	if (kstrtobool(buf, &trigger) || !trigger)
+		return -EINVAL;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_get_poison_by_memdev(cxlmd);
+	up_read(&cxl_dpa_rwsem);
+
+	return rc ? rc : len;
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
 
@@ -130,6 +178,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
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
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 17ea575f8a06..7c2489dd344c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -140,7 +140,7 @@ struct cxl_mbox_cmd {
 	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
 	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
 	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
-	C(PADDR, -ENXIO, "physical address specified is invalid"),		\
+	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
 	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
 	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
 	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
-- 
2.37.3

