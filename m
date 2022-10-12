Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3515FCD27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJLV3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJLV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:28:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC21204E7;
        Wed, 12 Oct 2022 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665610112; x=1697146112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLRDy1lhIF8KSdDHKDhLRtFvARkcXs+aDxSBTabc5hM=;
  b=JUJ1I/e2ZQDm37ZuhuNyG8jwK6XBMXWlo7oBd74tmyT7+y9kSRAFLB2A
   E96J0FfjvqafmWHTxUPAyMVbMMSJtEQNS0W72biHAYEtAkU8r5DZRumLw
   oc7GK5TXzB0OUzGy6VnVR5f86/bdQh04c1U/8sHIj/5yiBifItwSXSc/0
   27XX3JAbaQugiy9cB1iYvV8yX3c7XrgajHRCeop8xnDLUFTdyG9jNaukb
   4TFMi/PztWAcvzUE9mLxpLYbqxcSt0lynY+X2qvNURWL+WkACdTkye4ML
   vaoA7GsimW12hoTm6JP7yx/aXRfImpFlOiGAY/CK7GSTaWgtrDryLYnmh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="306543892"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="306543892"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="689834258"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="689834258"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.3.191])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 14:28:28 -0700
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
Subject: [PATCH v2 4/4] cxl/region: Add trigger_poison_list sysfs attribute
Date:   Wed, 12 Oct 2022 14:28:20 -0700
Message-Id: <b5e7787816326854b736c922f7fcf195fba71338.1665606782.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665606782.git.alison.schofield@intel.com>
References: <cover.1665606782.git.alison.schofield@intel.com>
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

When a boolean 'true' is written to this attribute the region driver
retrieves the poison list for the capacity each device contributes
to this region. The list includes addresses that are poisoned, or
would result in poison if accessed, and the source of the poison.
The retrieved errors are logged as kernel trace events with the
label 'cxl_poison'.

Devices not supporting the poison list capability are ignored.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 ++++++++++
 drivers/cxl/core/region.c               | 34 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index ab3665f8738e..7e33f6ee4992 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -368,3 +368,17 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		trace events with the label 'cxl_poison'.
+
+
+What:		/sys/bus/cxl/devices/regionZ/trigger_poison_list
+Date:		October, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) When a boolean 'true' is written to this attribute the
+		region driver retrieves the poison list for the capacity
+		each device contributes to this region. The list includes
+		addresses that are poisoned, or would result in poison if
+		accessed, and the source of the poison. The retrieved
+		errors are logged as kernel trace events with the label
+		'cxl_poison'.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ad21b2aa3b0a..e20207934336 100644
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
+		offset = cxl_dpa_resource(cxled);
+		length = cxl_dpa_size(cxled);
+		rc = cxl_mem_get_poison(cxlmd, offset, length,
+					dev_name(&cxlr->dev));
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
@@ -282,6 +314,7 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 
 	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
 		return 0;
+
 	return a->mode;
 }
 
@@ -555,6 +588,7 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
+	&dev_attr_trigger_poison_list.attr,
 	NULL,
 };
 
-- 
2.37.3

