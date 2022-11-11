Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCFE625157
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiKKDNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiKKDM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:12:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A72EF42;
        Thu, 10 Nov 2022 19:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668136376; x=1699672376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D2Rd/Pgneu6uQpvUYP+09V/ctmxkFwMNJvxyOCowpy0=;
  b=Pdq3mywfMNQPVHBqLsIsLvShiWWCTPHHmYmRrhMuaw8bFtLm7+LlPE8O
   S5V7sGrhuVHCsr3AvAkAqA0YUsJghmyoBqzuTo4/FlQturgwgVDl8kZZg
   sWZht16t+KbRAovtv3OD8AvAvyNZ8SGXKAezmaGYTgvqmddW2eJqiPrt3
   iVljrVXt9JjKc4JQVGqsv0DupTxzZXrwObmMOVpOq9fPm/Uvh6p0w23Z6
   MldhNMZqo9L9GLOeOymuHklwkp1UhRPO0AZJyPBmVal4WR67Dep1R4Qm6
   LlLXQwoAvD9kwZVyo10n68BUtzHk6dCla/se8dg9uxaoufNbcHLdtmnlP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310224414"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="310224414"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="812296090"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="812296090"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.161.45])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 19:12:55 -0800
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
Subject: [PATCH v3 4/6] cxl/region: Add trigger_poison_list sysfs attribute
Date:   Thu, 10 Nov 2022 19:12:42 -0800
Message-Id: <a696d91e34fc845673345a6b024545df849a8fef.1668115235.git.alison.schofield@intel.com>
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

When a boolean 'true' is written to this attribute the region driver
retrieves the poison list for the capacity each device contributes
to this region. The list includes addresses that are poisoned, or
would result in poison if accessed, and the source of the poison.
The retrieved errors are logged as kernel trace events with the
label 'cxl_poison'.

Devices not supporting the poison list capability are ignored.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 14 +++++++++++
 drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 1c5f4a853ba2..54fad3bdcb2b 100644
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
+		each device contributes to this region. The list includes
+		addresses that are poisoned, or would result in poison if
+		accessed, and the source of the poison. The retrieved
+		errors are logged as kernel trace events with the label
+		'cxl_poison'.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f9ae5ad284ff..68821238491e 100644
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

