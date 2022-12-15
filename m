Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A464E2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiLOVSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLOVSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:18:03 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325259142;
        Thu, 15 Dec 2022 13:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671139082; x=1702675082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aRw8JrUibr2BZHp3e7ft45UdfvnTap5W0KSsdC4zYxU=;
  b=JAUZ7DCzF3bxV53TocT9ZlGnMyLX0en/O2G5eHnAZl17QEsFpH98FxCn
   jDTsiuEAymdICB6WhdYragYEffE7tSBdVtwLPUwW+a6R8w4z5d1uKU9+U
   ghp/IBEE/YZY8FNlritXaxyL+ABM7mhQmN2AW9lzN3tDPmzrdx+Vv/peU
   SsvYsHLqWQd290qRqPb5xsuszL/FegNMS0LpKOTY3If1MltjcrUNxYd1W
   +WarGG/aIekXe8cG5eLL9LQA3B//v8+xyeZ5mQjmqzXlV7sWFbmjb0EiD
   A/oTOpyubPF4w4AG3QxaANVgp39t9y1xCfoLLzP1rQEXqtsMvZoY363KF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="302230307"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="302230307"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="649570086"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="649570086"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.178])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 13:17:52 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 4/5] cxl/region: Add trigger_poison_list sysfs attribute
Date:   Thu, 15 Dec 2022 13:17:46 -0800
Message-Id: <35395936fc9b8fdcb1d75bf13c770dab3b2f94a9.1671135967.git.alison.schofield@intel.com>
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

When a boolean 'true' is written to this attribute the region driver
retrieves the poison list for the capacity each device contributes
to this region. The list consists of addresses that are poisoned,
or would result in poison if accessed, and the source of the poison.
The retrieved errors are logged as kernel trace events with the
label 'cxl_poison'.

Devices not supporting the poison list capability are ignored.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++++
 drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index df40ed09ea67..b715a4609718 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -402,3 +402,17 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		trace events with the label 'cxl_poison'.
+
+
+What:		/sys/bus/cxl/devices/regionZ/trigger_poison_list
+Date:		November, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a boolean 'true' is written to this attribute the
+		region driver retrieves the poison list for the capacity
+		each device contributes to this region. The list consists
+		of addresses that are poisoned, or would result in poison
+		if accessed, and the source of the poison. The retrieved
+		errors are logged as kernel trace events with the label
+		'cxl_poison'.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 02f28da519e3..62ba9aa6bbf8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -72,6 +72,38 @@ static int is_dup(struct device *match, void *data)
 	return 0;
 }
 
+static ssize_t trigger_poison_list_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	u64 offset, length;
+	int rc, i;
+	bool tmp;
+
+	if (kstrtobool(buf, &tmp))
+		return -EINVAL;
+
+	for (i = 0; i <  p->nr_targets; i++) {
+		cxled = p->targets[i];
+		cxlmd = cxled_to_memdev(cxled);
+		if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON,
+			      cxlmd->cxlds->enabled_cmds))
+			continue;
+
+		offset = cxl_dpa_resource_start(cxled);
+		length = cxl_dpa_size(cxled);
+		rc = cxl_mem_get_poison(cxlmd, offset, length, cxlr);
+		if (rc)
+			return rc;
+	}
+	return len;
+}
+static DEVICE_ATTR_WO(trigger_poison_list);
+
 static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t len)
 {
@@ -570,6 +602,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
+	&dev_attr_trigger_poison_list.attr,
 	NULL,
 };
 
-- 
2.37.3

