Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385364E2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLOVSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiLOVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E0655A8B;
        Thu, 15 Dec 2022 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139081; x=1702675081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6DX+flXm++eiMCOQrPkWRYABHnX0vxtX2uRfeiLesU=;
  b=AOq/H945rYgjJZ+WAXwbNDGviMZYNh0w7+REOIcQ6hH/t1QZZml8PhMM
   4uPB61WTjWVBljiQe0GpcPre+pGlXLJiInlvyTPNR2xMw1sn2oxY115+I
   RJFqrrJaAB1ZdJCCbkQZIPAwTFPoRpJBielr77aiFkoyLzx38D6ZN1U88
   iQQf9SkwWysioSUdhG4I/N2Ymvc8J2+fyaZldlQGXZuUk0WQNrSoUchdg
   6KmZZXdfPyZbRdbyfEM/AriDcWTMC7THSS0I8jA9c5sLhtEp9uzuhEUFO
   HO0HC424PWqL6PFNxRwQ7WJ9o92y+fqjwZ0jaa+bfSt8P80K/xituQl1s
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230302"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230302"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570083"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570083"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:51 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] cxl/memdev: Add trigger_poison_list sysfs attribute
Date:   Thu, 15 Dec 2022 13:17:45 -0800
Message-Id: <965d66486eb3ebbca6b1b265678130edd66f105e.1671135967.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1671135967.git.alison.schofield@intel.com>
References: <cover.1671135967.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++
 drivers/cxl/core/memdev.c               | 45 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..df40ed09ea67 100644
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
+		list consists of addresses that are poisoned, or would result
+		in poison if accessed, and the source of the poison. This
+		attribute is only visible for devices supporting the
+		capability. The retrieved errors are logged as kernel
+		trace events with the label 'cxl_poison'.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index a74a93310d26..e0af7e9c9989 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,49 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
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
+		if (rc && rc != -EFAULT)
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
 
@@ -130,6 +167,14 @@ static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
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
index f53fae20f502..28ba0cd8f2d3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -139,7 +139,7 @@ struct cxl_mbox_cmd {
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

