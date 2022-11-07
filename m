Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330C86202C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiKGWzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiKGWyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:54:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C717C2C136;
        Mon,  7 Nov 2022 14:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667861689; x=1699397689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rGty/ND0dwTw6DFxmOEmfdO/+IKOkgj7e852ob1OgrI=;
  b=HaaewNOQdV/N8xHGk+7tGAIZN+YMQdlsBkA9CVODvEuKnezTpyc1hbHC
   ycHrFcI0TcYxVbPDEQa6fRqOrL/1cEDKBQcEcIilfckWAAImoBU5NUsvl
   6sblGdi/PRO8ZUbwMv3KSqlroaHsS0rCga5RgEyA1loFykj9qkK2X8n30
   MkvBUJdA1SxTux0tenzyLDdnxZjRY2g3cbXhTPARVrnJsImqjotdl1JLO
   5tkaogUYHqTw1mM98YPpPJITbb0DtQSnLj7iJ4wmciSLr+gnRJBnErRPN
   3w/YIMpahBPFjqne7ClEhUiOFAHyPeLmi4fIsGs98cRehCTzfv/7TxABi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="293911840"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="293911840"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811012994"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811012994"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 14:54:48 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs entry
Date:   Mon,  7 Nov 2022 14:53:21 -0800
Message-Id: <20221107225323.2733518-13-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107225323.2733518-1-jithu.joseph@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
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

Initial implementation assumed a single IFS test image file with a
fixed name ff-mm-ss.scan. (where ff, mm, ss refers to family, model
and stepping  of the core)

Subsequently, it became evident that supporting more than one
test image file is needed to provide more comprehensive
test coverage. (Test coverage in this scenario refers to testing
more transistors in the core to identify faults)

The other alternative of increasing the size of a single scan test image
file would not work as the  upper bound is limited by the size of memory
area reserved by BIOS for loading IFS test image.

Introduce "current_batch" file which accepts a number. Writing a
number to the current_batch file would load the test image file by name
ff-mm-ss-<xy>.scan, where <xy> is the number written to the
"current_batch" file in hex. Range check of the input is done to verify
it not greater than 0xff.

For e.g if the scan test image comprises of 6 files, they would be named
as show below:
	06-8f-06-01.scan
	06-8f-06-02.scan
	06-8f-06-03.scan
	06-8f-06-04.scan
	06-8f-06-05.scan
	06-8f-06-06.scan

And writing 3 to current_batch would result in loading 06-8f-06-03.scan
in the above e.g. The file can also be read to know the currently loaded
file.

And testing a system looks like:
	for each scan file
	do
		load the IFS test image file (write to the batch file)
		for each core
		do
			test the core with this set of tests
		done
	done

Qualify few error messages with the test image file suffix to
provide better context.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     | 23 ++++++++++----
 drivers/platform/x86/intel/ifs/core.c    |  1 +
 drivers/platform/x86/intel/ifs/load.c    | 18 +++++++----
 drivers/platform/x86/intel/ifs/runtest.c | 10 ++++---
 drivers/platform/x86/intel/ifs/sysfs.c   | 38 ++++++++++++++++++++++++
 5 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 98ca91bdd5ca..390e508faf57 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -33,13 +33,23 @@
  * The driver loads the tests into memory reserved BIOS local to each CPU
  * socket in a two step process using writes to MSRs to first load the
  * SHA hashes for the test. Then the tests themselves. Status MSRs provide
- * feedback on the success/failure of these steps. When a new test file
- * is installed it can be loaded by writing to the driver reload file::
+ * feedback on the success/failure of these steps.
  *
- *   # echo 1 > /sys/devices/virtual/misc/intel_ifs_0/reload
+ * The test files are kept in a fixed location: /lib/firmware/intel/ifs_0/
+ * For e.g if there are 3 test files, they would be named in the following
+ * fashion:
+ * ff-mm-ss-01.scan
+ * ff-mm-ss-02.scan
+ * ff-mm-ss-03.scan
+ * (where ff refers to family, mm indicates model and ss indicates stepping)
  *
- * Similar to microcode, the current version of the scan tests is stored
- * in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
+ * A different testfile can be loaded by writing the numerical portion
+ * (e.g 1, 2 or 3 in the above scenario) into the curent_batch file.
+ * To load ff-mm-ss-02.scan, the following command can be used::
+ *
+ *   # echo 2 > /sys/devices/virtual/misc/intel_ifs_0/current_batch
+ *
+ * The above file can also be read to know the currently loaded image.
  *
  * Running tests
  * -------------
@@ -207,6 +217,7 @@ struct ifs_data {
 	int	status;
 	u64	scan_details;
 	int	cur_batch;
+	int	test_num;
 };
 
 struct ifs_work {
@@ -227,7 +238,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
-void ifs_load_firmware(struct device *dev);
+int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 5fb7f655c291..1f040837e8eb 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -22,6 +22,7 @@ MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 static struct ifs_device ifs_device = {
 	.data = {
 		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+		.test_num = 0,
 	},
 	.misc = {
 		.name = "intel_ifs_0",
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index f361fd42a320..c6414958a691 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -256,17 +256,18 @@ static int ifs_image_sanity_check(struct device *dev, const struct microcode_hea
 
 /*
  * Load ifs image. Before loading ifs module, the ifs image must be located
- * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
+ * in /lib/firmware/intel/ifs_x/ and named as family-model-stepping-02x.{testname}.
  */
-void ifs_load_firmware(struct device *dev)
+int ifs_load_firmware(struct device *dev)
 {
 	struct ifs_data *ifsd = ifs_get_data(dev);
 	const struct firmware *fw;
-	char scan_path[32];
-	int ret;
+	char scan_path[64];
+	int ret = -EINVAL;
 
-	snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
-		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
+	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
+		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
 	if (ret) {
@@ -282,8 +283,13 @@ void ifs_load_firmware(struct device *dev)
 	ifs_hash_ptr = (u64)(ifs_header_ptr + 1);
 
 	ret = scan_chunks_sanity_check(dev);
+	if (ret)
+		dev_err(dev, "Load failure for batch: %02x\n", ifsd->cur_batch);
+
 release:
 	release_firmware(fw);
 done:
 	ifsd->loaded = (ret == 0);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index b2ca2bb4501f..0bfd8fcdd7e8 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -78,14 +78,16 @@ static void message_not_tested(struct device *dev, int cpu, union ifs_status sta
 
 static void message_fail(struct device *dev, int cpu, union ifs_status status)
 {
+	struct ifs_data *ifsd = ifs_get_data(dev);
+
 	/*
 	 * control_error is set when the microcode runs into a problem
 	 * loading the image from the reserved BIOS memory, or it has
 	 * been corrupted. Reloading the image may fix this issue.
 	 */
 	if (status.control_error) {
-		dev_err(dev, "CPU(s) %*pbl: could not execute from loaded scan image\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)));
+		dev_err(dev, "CPU(s) %*pbl: could not execute from loaded scan image. Batch: %02x version: 0x%x\n",
+			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
 	}
 
 	/*
@@ -96,8 +98,8 @@ static void message_fail(struct device *dev, int cpu, union ifs_status status)
 	 * the core being tested.
 	 */
 	if (status.signature_error) {
-		dev_err(dev, "CPU(s) %*pbl: test signature incorrect.\n",
-			cpumask_pr_args(cpu_smt_mask(cpu)));
+		dev_err(dev, "CPU(s) %*pbl: test signature incorrect. Batch: %02x version: 0x%x\n",
+			cpumask_pr_args(cpu_smt_mask(cpu)), ifsd->cur_batch, ifsd->loaded_version);
 	}
 }
 
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index e077910c5d28..d2eeeb04d760 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -87,6 +87,43 @@ static ssize_t run_test_store(struct device *dev,
 
 static DEVICE_ATTR_WO(run_test);
 
+static ssize_t current_batch_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	int cur_batch;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &cur_batch);
+	if (rc < 0 || cur_batch > 0xff)
+		return -EINVAL;
+
+	if (down_interruptible(&ifs_sem))
+		return -EINTR;
+
+	ifsd->cur_batch = cur_batch;
+
+	rc = ifs_load_firmware(dev);
+
+	up(&ifs_sem);
+
+	return (rc == 0) ? count : rc;
+}
+
+static ssize_t current_batch_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+
+	if (!ifsd->loaded)
+		return sysfs_emit(buf, "none\n");
+	else
+		return sysfs_emit(buf, "0x%02x\n", ifsd->cur_batch);
+}
+
+static DEVICE_ATTR_RW(current_batch);
+
 /*
  * Display currently loaded IFS image version.
  */
@@ -108,6 +145,7 @@ static struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
 	&dev_attr_status.attr,
 	&dev_attr_run_test.attr,
+	&dev_attr_current_batch.attr,
 	&dev_attr_image_version.attr,
 	NULL
 };
-- 
2.25.1

