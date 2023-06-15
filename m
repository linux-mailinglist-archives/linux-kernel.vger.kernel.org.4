Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1302373205D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjFOTdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjFOTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:33:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6D2952;
        Thu, 15 Jun 2023 12:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686857604; x=1718393604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2MAIr5Lerk3ugq5d1wX1Hd5M7o1qfRrF+I/iAoiMuk=;
  b=Rl44lUNaVXlKPiNo1fHNgBVWHHDAud+RjiM8uvzhhNG3lZKdu4UXNwpA
   gnObwejMjsd9qWpzONbX8ysFBMFymY7gOub5qBMgHdCaLpOnXSTZJZPBD
   ikiq8NHpoJVyaPBWnHZcAkQ+UmLAl76Qc+SZuWJn9RJi1GwwzZhZEEGpt
   VSCeJFaibWEmlyH3k/Y930mDwS7f0L0iESQOn383lRW29Jzu1Q4Mo+qqQ
   f2P+ZGcS4LFGXVlRZBh7+qgDxH5jVJFv7vYR5D/Em7igt2IRyOlIHylUe
   8aiFHXkKEWQANLOl3mr2MEmYLaCNxHGYJYa0t6pgDgFhQf6EFTHD6TBpR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359019793"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="359019793"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 12:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825414309"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825414309"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 12:33:23 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/2] platform/x86/intel/tpmi: Read feature control status
Date:   Thu, 15 Jun 2023 12:33:01 -0700
Message-Id: <20230615193302.2507338-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230615193302.2507338-1-srinivas.pandruvada@linux.intel.com>
References: <20230615193302.2507338-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the PM features can be locked or disabled. In that case, write
interface can be locked.

This status is read via a mailbox. There is one TPMI ID which provides
base address for interface and data register for mail box operation.
The mailbox operations is defined in the TPMI specification. Refer to
https://github.com/intel/tpmi_power_management/ for TPMI specifications.

An API is exposed to feature drivers to read feature control status.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
As suggested by Dan Williams changed ioremap to devm_ioremap() after
review by Andy.

 drivers/platform/x86/intel/tpmi.c | 147 ++++++++++++++++++++++++++++++
 include/linux/intel_tpmi.h        |   2 +
 2 files changed, 149 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index a5227951decc..9545e9cdb924 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -47,8 +47,11 @@
  */
 
 #include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
 #include <linux/intel_tpmi.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
@@ -98,6 +101,7 @@ struct intel_tpmi_pm_feature {
  * @feature_count:	Number of TPMI of TPMI instances pointed by tpmi_features
  * @pfs_start:		Start of PFS offset for the TPMI instances in this device
  * @plat_info:		Stores platform info which can be used by the client drivers
+ * @tpmi_control_mem:	Memory mapped IO for getting control information
  *
  * Stores the information for all TPMI devices enumerated from a single PCI device.
  */
@@ -107,6 +111,7 @@ struct intel_tpmi_info {
 	int feature_count;
 	u64 pfs_start;
 	struct intel_tpmi_plat_info plat_info;
+	void __iomem *tpmi_control_mem;
 };
 
 /**
@@ -139,6 +144,7 @@ enum intel_tpmi_id {
 	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
 	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
 	TPMI_ID_SST = 5, /* Speed Select Technology */
+	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
 	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
 };
 
@@ -175,6 +181,144 @@ struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 
+/* TPMI Control Interface */
+
+#define TPMI_CONTROL_STATUS_OFFSET	0x00
+#define TPMI_COMMAND_OFFSET		0x08
+#define TPMI_DATA_OFFSET		0x0C
+/*
+ * Spec is calling for max 1 seconds to get ownership at the worst
+ * case. Read at 10 ms timeouts and repeat up to 1 second.
+ */
+#define TPMI_CONTROL_TIMEOUT_US		(10 * USEC_PER_MSEC)
+#define TPMI_CONTROL_TIMEOUT_MAX_US	USEC_PER_SEC
+
+#define TPMI_RB_TIMEOUT_US		(10 * USEC_PER_MSEC)
+#define TPMI_RB_TIMEOUT_MAX_US		USEC_PER_SEC
+
+#define TPMI_OWNER_NONE			0
+#define TPMI_OWNER_IN_BAND		1
+
+#define TPMI_GENMASK_OWNER	GENMASK_ULL(5, 4)
+#define TPMI_GENMASK_STATUS	GENMASK_ULL(15, 8)
+
+#define TPMI_GET_STATE_CMD		0x10
+#define TPMI_GET_STATE_CMD_DATA_OFFSET	8
+#define TPMI_CMD_DATA_OFFSET		32
+#define TPMI_CMD_PKT_LEN_OFFSET		16
+#define TPMI_CMD_PKT_LEN		2
+#define TPMI_CONTROL_RB_BIT		0
+#define TPMI_CONTROL_CPL_BIT		6
+#define TPMI_CMD_STATUS_SUCCESS		0x40
+#define TPMI_GET_STATUS_BIT_ENABLE	0
+#define TPMI_GET_STATUS_BIT_LOCKED	31
+
+/* Mutex to complete get feature status without interruption */
+static DEFINE_MUTEX(tpmi_dev_lock);
+
+static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
+{
+	u64 control;
+
+	return read_poll_timeout(readq, control, owner == FIELD_GET(TPMI_GENMASK_OWNER, control),
+				 TPMI_CONTROL_TIMEOUT_US, TPMI_CONTROL_TIMEOUT_MAX_US, false,
+				 tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+}
+
+static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int feature_id,
+				    int *locked, int *disabled)
+{
+	u64 control, data;
+	int ret;
+
+	if (!tpmi_info->tpmi_control_mem)
+		return -EFAULT;
+
+	mutex_lock(&tpmi_dev_lock);
+
+	ret = tpmi_wait_for_owner(tpmi_info, TPMI_OWNER_NONE);
+	if (ret)
+		goto err_unlock;
+
+	/* set command id to 0x10 for TPMI_GET_STATE */
+	data = TPMI_GET_STATE_CMD;
+	/* 32 bits for DATA offset and +8 for feature_id field */
+	data |= ((u64)feature_id << (TPMI_CMD_DATA_OFFSET + TPMI_GET_STATE_CMD_DATA_OFFSET));
+
+	/* Write at command offset for qword access */
+	writeq(data, tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
+
+	ret = tpmi_wait_for_owner(tpmi_info, TPMI_OWNER_IN_BAND);
+	if (ret)
+		goto err_unlock;
+
+	/* Set Run Busy and packet length of 2 dwords */
+	writeq(BIT_ULL(TPMI_CONTROL_RB_BIT) | (TPMI_CMD_PKT_LEN << TPMI_CMD_PKT_LEN_OFFSET),
+	       tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+
+	ret = read_poll_timeout(readq, control, !(control & BIT_ULL(TPMI_CONTROL_RB_BIT)),
+				TPMI_RB_TIMEOUT_US, TPMI_RB_TIMEOUT_MAX_US, false,
+				tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+	if (ret)
+		goto done_proc;
+
+	control = FIELD_GET(TPMI_GENMASK_STATUS, control);
+	if (control != TPMI_CMD_STATUS_SUCCESS) {
+		ret = -EBUSY;
+		goto done_proc;
+	}
+
+	data = readq(tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
+	data >>= TPMI_CMD_DATA_OFFSET; /* Upper 32 bits are for TPMI_DATA */
+
+	*disabled = 0;
+	*locked = 0;
+
+	if (!(data & BIT_ULL(TPMI_GET_STATUS_BIT_ENABLE)))
+		*disabled = 1;
+
+	if (data & BIT_ULL(TPMI_GET_STATUS_BIT_LOCKED))
+		*locked = 1;
+
+	ret = 0;
+
+done_proc:
+	/* SET CPL "completion"bit */
+	writeq(BIT_ULL(TPMI_CONTROL_CPL_BIT),
+	       tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+
+err_unlock:
+	mutex_unlock(&tpmi_dev_lock);
+
+	return ret;
+}
+
+int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
+			    int *locked, int *disabled)
+{
+	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
+	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
+
+	return tpmi_read_feature_status(tpmi_info, feature_id, locked, disabled);
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
+
+static void tpmi_set_control_base(struct auxiliary_device *auxdev,
+				  struct intel_tpmi_info *tpmi_info,
+				  struct intel_tpmi_pm_feature *pfs)
+{
+	void __iomem *mem;
+	u16 size;
+
+	size = pfs->pfs_header.num_entries * pfs->pfs_header.entry_size * 4;
+	mem = devm_ioremap(&auxdev->dev, pfs->vsec_offset, size);
+	if (!mem)
+		return;
+
+	/* mem is pointing to TPMI CONTROL base */
+	tpmi_info->tpmi_control_mem = mem;
+}
+
 static const char *intel_tpmi_name(enum intel_tpmi_id id)
 {
 	switch (id) {
@@ -367,6 +511,9 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		 */
 		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID)
 			tpmi_process_info(tpmi_info, pfs);
+
+		if (pfs->pfs_header.tpmi_id == TPMI_CONTROL_ID)
+			tpmi_set_control_base(auxdev, tpmi_info, pfs);
 	}
 
 	tpmi_info->pfs_start = pfs_start;
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index f505788c05da..04d937ad4dc4 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -27,4 +27,6 @@ struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *aux
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 
+int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, int *locked,
+			    int *disabled);
 #endif
-- 
2.38.1

