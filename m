Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C474FAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjGKWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGKWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:10:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117A170C;
        Tue, 11 Jul 2023 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689113402; x=1720649402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oVVY4tkhB4+/XYKjLG9Q1dSJgTuON5egCghoBYC94rM=;
  b=mePjasp/q8DqyttXIQuXSs4x18LTpk0kmKftxA2/Rzi/V9eq79mJ/SPi
   c/aYKk8K8Kkkmu2qNIpgf3zIPGQkmg6LGbSNbU3ngG1PNOcMgjJCZqFWy
   yIyWuUL7eKssL+h3j9Pl2cgebOrSMwmCLIWVZ6rSUqNgmv2TVoz260gzC
   mym8KpEUK8jES/uxDU7m/vdz6c8g/zRRfiG1XtezJWfGkG+1LKw5etj0P
   THq/atPIWrjXBbPn5BC3sO5yFR57CAfGOgbZ6wNBbiOvlWCBw4ZorTPbx
   /T2cxMy6mtiSn3ouvvpzqVy187FovIPMs8OKxS4fpjyWf7KwDVh/bT+ye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345058982"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="345058982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:10:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786795077"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="786795077"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 15:10:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/3] platform/x86/intel/tpmi: Read feature control status
Date:   Tue, 11 Jul 2023 15:09:47 -0700
Message-Id: <20230711220949.71881-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---
The external interface will be used by all feature drivers, will
submit patch for that.

v2
- Renaming of register names as suggested by llpo
- cosmetic changes as suggested by llpo
- size change to u32 for checking with max 4K size

v1
This has all changes suggested by Andi

 drivers/platform/x86/intel/tpmi.c | 178 ++++++++++++++++++++++++++++++
 include/linux/intel_tpmi.h        |   2 +
 2 files changed, 180 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index d1fd6e69401c..024e7671687a 100644
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
@@ -139,9 +144,16 @@ enum intel_tpmi_id {
 	TPMI_ID_PEM = 1, /* Power and Perf excursion Monitor */
 	TPMI_ID_UNCORE = 2, /* Uncore Frequency Scaling */
 	TPMI_ID_SST = 5, /* Speed Select Technology */
+	TPMI_CONTROL_ID = 0x80, /* Special ID for getting feature status */
 	TPMI_INFO_ID = 0x81, /* Special ID for PCI BDF and Package ID information */
 };
 
+/*
+ * TPMI PFS and per feature memory size can't exceed 4K.
+ * Also PFS start and feature memory is 4K aligned.
+ */
+#define TPMI_MAX_BUFFER_SIZE    (4 * 1024)
+
 /* Used during auxbus device creation */
 static DEFINE_IDA(intel_vsec_tpmi_ida);
 
@@ -175,6 +187,169 @@ struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 
+/* TPMI Control Interface */
+
+#define TPMI_CONTROL_STATUS_OFFSET	0x00
+#define TPMI_COMMAND_OFFSET		0x08
+
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
+/* TPMI Control status register defines */
+
+#define TPMI_CONTROL_STATUS_RB		BIT_ULL(0)
+
+#define TPMI_CONTROL_STATUS_OWNER	GENMASK_ULL(5, 4)
+#define TPMI_OWNER_NONE			0
+#define TPMI_OWNER_IN_BAND		1
+
+#define TPMI_CONTROL_STATUS_CPL		BIT_ULL(6)
+#define TPMI_CONTROL_STATUS_RESULT	GENMASK_ULL(15, 8)
+#define TPMI_CONTROL_STATUS_LEN		GENMASK_ULL(31, 16)
+
+#define TPMI_CMD_PKT_LEN		2
+#define TPMI_CMD_STATUS_SUCCESS		0x40
+
+/* TPMI command data registers */
+#define TMPI_CONTROL_DATA_CMD		GENMASK_ULL(7, 0)
+#define TMPI_CONTROL_DATA_VAL		GENMASK_ULL(63, 32)
+#define TPMI_CONTROL_DATA_VAL_FEATURE	GENMASK_ULL(48, 40)
+
+/* Command to send via control interface */
+#define TPMI_CONTROL_GET_STATE_CMD	0x10
+
+#define TPMI_CONTROL_CMD_MASK		GENMASK_ULL(48, 40)
+
+#define TPMI_CMD_LEN_MASK		GENMASK_ULL(18, 16)
+
+#define TPMI_STATE_DISABLED		BIT_ULL(0)
+#define TPMI_STATE_LOCKED		BIT_ULL(31)
+
+/* Mutex to complete get feature status without interruption */
+static DEFINE_MUTEX(tpmi_dev_lock);
+
+static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
+{
+	u64 control;
+
+	return read_poll_timeout(readq, control,
+				 owner == FIELD_GET(TPMI_CONTROL_STATUS_OWNER, control),
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
+	/* Wait for owner bit set to 0 (none) */
+	ret = tpmi_wait_for_owner(tpmi_info, TPMI_OWNER_NONE);
+	if (ret)
+		goto err_unlock;
+
+	/* set command id to 0x10 for TPMI_GET_STATE */
+	data = FIELD_PREP(TMPI_CONTROL_DATA_CMD, TPMI_CONTROL_GET_STATE_CMD);
+
+	/* 32 bits for DATA offset and +8 for feature_id field */
+	data |= FIELD_PREP(TPMI_CONTROL_DATA_VAL_FEATURE, feature_id);
+
+	/* Write at command offset for qword access */
+	writeq(data, tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
+
+	/* Wait for owner bit set to in-band */
+	ret = tpmi_wait_for_owner(tpmi_info, TPMI_OWNER_IN_BAND);
+	if (ret)
+		goto err_unlock;
+
+	/* Set Run Busy and packet length of 2 dwords */
+	control = TPMI_CONTROL_STATUS_RB;
+	control |= FIELD_PREP(TPMI_CONTROL_STATUS_LEN, TPMI_CMD_PKT_LEN);
+
+	/* Write at status offset for qword access */
+	writeq(control, tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+
+	/* Wait for Run Busy clear */
+	ret = read_poll_timeout(readq, control, !(control & TPMI_CONTROL_STATUS_RB),
+				TPMI_RB_TIMEOUT_US, TPMI_RB_TIMEOUT_MAX_US, false,
+				tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
+	if (ret)
+		goto done_proc;
+
+	control = FIELD_GET(TPMI_CONTROL_STATUS_RESULT, control);
+	if (control != TPMI_CMD_STATUS_SUCCESS) {
+		ret = -EBUSY;
+		goto done_proc;
+	}
+
+	/* Response is ready */
+	data = readq(tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
+	data = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
+
+	*disabled = 0;
+	*locked = 0;
+
+	if (!(data & TPMI_STATE_DISABLED))
+		*disabled = 1;
+
+	if (data & TPMI_STATE_LOCKED)
+		*locked = 1;
+
+	ret = 0;
+
+done_proc:
+	/* Set CPL "completion" bit */
+	writeq(TPMI_CONTROL_STATUS_CPL, tpmi_info->tpmi_control_mem + TPMI_CONTROL_STATUS_OFFSET);
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
+	u32 size;
+
+	size = pfs->pfs_header.num_entries * pfs->pfs_header.entry_size * sizeof(u32);
+	/* This size is coming from trusted hardware, but verify anyway */
+	if (size > TPMI_MAX_BUFFER_SIZE)
+		return;
+
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
@@ -367,6 +542,9 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
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
2.40.1

