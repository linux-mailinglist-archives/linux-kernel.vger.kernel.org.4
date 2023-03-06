Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E886AC894
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCFQqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 11:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjCFQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 11:44:43 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D538018;
        Mon,  6 Mar 2023 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121045; x=1709657045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXvEa28VXtdoLixlsJmztqlPJr3dXY1XkOJhYU6re0I=;
  b=IfC9WGCSxYta2sYdoJSxVOc70PW2WQ+pkECLaaVn81LdCYAO7ooF6Wa+
   EPho0dQuZE8yOBYozKAEa5CdUG0f25la3jbs6lejrjXS4Uj3FukdvXbWs
   OZrevaRnbyY5cXeYf+Qn8wKaozZVsS6fLZwxFwBOurkmgEbnDUIoU0A8c
   kudallAI28v3G46vfpQGgYdZIuMKRHAygo/eFdkIv3G+u1OczDUOQxaaD
   D63lkTlsAaQwztl7cQs3Y2nibQU5ZLHcImrh0zi7y9OqX0t3oUn8ly8Gc
   f9FLB+PPZt+zntw7pM0y0p205r9bcZHYXhO1Ovcb7IRL9RPO7WofstkSm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181186"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181186"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504559"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504559"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:59 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 14/16] dmaengine: idxd: expose fault counters to sysfs
Date:   Mon,  6 Mar 2023 08:31:36 -0800
Message-Id: <20230306163138.587484-15-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

Expose cr_faults and cr_fault_failures counters to the user space. This
allows a user app to keep track of how many fault the application is
causing with the completion record (CR) and also the number of failures
of the CR writeback. Having a high number of cr_fault_failures is bad as
the app is submitting descriptors with the CR addresses that are bad. User
monitoring daemon may want to consider killing the application as it may be
malicious and attempting to flood the device event log.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../ABI/stable/sysfs-driver-dma-idxd          | 17 +++++++
 drivers/dma/idxd/cdev.c                       | 46 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
index e01916611452..73ab86196a41 100644
--- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
+++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
@@ -318,3 +318,20 @@ Description:	Allows control of the number of batch descriptors that can be
 		1 (1/2 of max value), 2 (1/4 of the max value), and 3 (1/8 of
 		the max value). It's visible only on platforms that support
 		the capability.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/cr_faults
+Date:		Sept 14, 2022
+KernelVersion:	6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the number of Completion Record (CR) faults this application
+		has caused.
+
+What:		/sys/bus/dsa/devices/wq<m>.<n>/dsa<x>\!wq<m>.<n>/file<y>/cr_fault_failures
+Date:		Sept 14, 2022
+KernelVersion:	6.4.0
+Contact:	dmaengine@vger.kernel.org
+Description:	Show the number of Completion Record (CR) faults failures that this
+		application has caused. The failure counter is incremented when the
+		driver cannot fault in the address for the CR. Typically this is caused
+		by a bad address programmed in the submitted descriptor or a malicious
+		submitter is using bad CR address on purpose.
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 2ff9a680ea5e..9fc6565bf807 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -59,6 +59,51 @@ static inline struct idxd_user_context *dev_to_uctx(struct device *dev)
 	return container_of(idxd_dev, struct idxd_user_context, idxd_dev);
 }
 
+static ssize_t cr_faults_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctx->counters[COUNTER_FAULTS]);
+}
+static DEVICE_ATTR_RO(cr_faults);
+
+static ssize_t cr_fault_failures_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+
+	return sysfs_emit(buf, "%llu\n", ctx->counters[COUNTER_FAULT_FAILS]);
+}
+static DEVICE_ATTR_RO(cr_fault_failures);
+
+static struct attribute *cdev_file_attributes[] = {
+	&dev_attr_cr_faults.attr,
+	&dev_attr_cr_fault_failures.attr,
+	NULL
+};
+
+static umode_t cdev_file_attr_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct idxd_user_context *ctx = dev_to_uctx(dev);
+	struct idxd_wq *wq = ctx->wq;
+
+	if (!wq_pasid_enabled(wq))
+		return 0;
+
+	return a->mode;
+}
+
+static const struct attribute_group cdev_file_attribute_group = {
+	.attrs = cdev_file_attributes,
+	.is_visible = cdev_file_attr_visible,
+};
+
+static const struct attribute_group *cdev_file_attribute_groups[] = {
+	&cdev_file_attribute_group,
+	NULL
+};
+
 static void idxd_file_dev_release(struct device *dev)
 {
 	struct idxd_user_context *ctx = dev_to_uctx(dev);
@@ -98,6 +143,7 @@ static void idxd_file_dev_release(struct device *dev)
 static struct device_type idxd_cdev_file_type = {
 	.name = "idxd_file",
 	.release = idxd_file_dev_release,
+	.groups = cdev_file_attribute_groups,
 };
 
 static void idxd_cdev_dev_release(struct device *dev)
-- 
2.37.1

