Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8982630F6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 17:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiKSQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKSQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 11:24:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A541631ED8;
        Sat, 19 Nov 2022 08:24:02 -0800 (PST)
Date:   Sat, 19 Nov 2022 16:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668875041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdkuzBC3y9bN9MyqhSeFy9PKPvzJRASK2oD17S0RtlY=;
        b=I4svtIO/E/m41bhifzhjHUtc5xR2OyExpuF1OflSsr46F5ulVn6pdpnB9FDRh1EFvsawMf
        ozHDfUQYhmaybofIFEtfIksvLrnPROaxRE5vHZYX3F6hN/Z9kRzGqbCRllVOKwF949rjoO
        WrSR6KoeP1894LsNguTRMFlX+ZI5eQEKOtcNTfvRMb4huMpNXJOpSFDMYryU1ffiUGyNJk
        AUXXwz4dLfwORzObX5plLfTEBnu/8bB868blzyJq2gE9OMX7qHyGrn0SrT97ASL2HJPBTe
        YFGtoeobh3NJdcUukkCQNjjgh6n5nEWwdno1M/uNIvhq9roz2mKy+dt9RQNbww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668875041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OdkuzBC3y9bN9MyqhSeFy9PKPvzJRASK2oD17S0RtlY=;
        b=qt2FMWEKA5H7onmG/7owYcSxJobg8dFmBBk4Uq+Vor/yK6XmXQmsX8qN+Sf5HoQxosaloj
        PeAyiCfXdbOMJuCQ==
From:   "tip-bot2 for Jithu Joseph" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] platform/x86/intel/ifs: Add current_batch sysfs entry
Cc:     Jithu Joseph <jithu.joseph@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221107225323.2733518-13-jithu.joseph@intel.com>
References: <20221107225323.2733518-13-jithu.joseph@intel.com>
MIME-Version: 1.0
Message-ID: <166887504002.4906.17697807138560696911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_PHOTO_EDITING_DIRECT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4fb858f3dcd25cf568e35ff53ce8fa8a660fc372
Gitweb:        https://git.kernel.org/tip/4fb858f3dcd25cf568e35ff53ce8fa8a660fc372
Author:        Jithu Joseph <jithu.joseph@intel.com>
AuthorDate:    Wed, 16 Nov 2022 19:59:33 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 19 Nov 2022 11:29:00 +01:00

platform/x86/intel/ifs: Add current_batch sysfs entry

Initial implementation assumed a single IFS test image file with a
fixed name ff-mm-ss.scan. (where ff, mm, ss refers to family, model and
stepping of the core).

Subsequently, it became evident that supporting more than one test
image file is needed to provide more comprehensive test coverage. (Test
coverage in this scenario refers to testing more transistors in the core
to identify faults).

The other alternative of increasing the size of a single scan test image
file would not work as the  upper bound is limited by the size of memory
area reserved by BIOS for loading IFS test image.

Introduce "current_batch" file which accepts a number. Writing a
number to the current_batch file would load the test image file by
name ff-mm-ss-<xy>.scan, where <xy> is the number written to the
"current_batch" file in hex. Range check of the input is done to verify
it not greater than 0xff.

For e.g if the scan test image comprises of 6 files, they would be named:

  06-8f-06-01.scan
  06-8f-06-02.scan
  06-8f-06-03.scan
  06-8f-06-04.scan
  06-8f-06-05.scan
  06-8f-06-06.scan

And writing 3 to current_batch would result in loading 06-8f-06-03.scan
above. The file can also be read to know the currently loaded file.

And testing a system looks like:

  for each scan file
  do
  	load the IFS test image file (write to the batch file)
  	for each core
  	do
  		test the core with this set of tests
  	done
  done

Qualify few error messages with the test image file suffix to provide
better context.

  [ bp: Massage commit message. Add link to the discussion. ]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20221107225323.2733518-13-jithu.joseph@intel.com
---
 drivers/platform/x86/intel/ifs/core.c    |  1 +-
 drivers/platform/x86/intel/ifs/ifs.h     | 23 ++++++++++----
 drivers/platform/x86/intel/ifs/load.c    | 18 +++++++----
 drivers/platform/x86/intel/ifs/runtest.c | 10 +++---
 drivers/platform/x86/intel/ifs/sysfs.c   | 38 +++++++++++++++++++++++-
 5 files changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 943eb2a..206a617 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -23,6 +23,7 @@ MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 static struct ifs_device ifs_device = {
 	.data = {
 		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+		.test_num = 0,
 	},
 	.misc = {
 		.name = "intel_ifs_0",
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 74c051c..da1474e 100644
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
+ * A different test file can be loaded by writing the numerical portion
+ * (e.g 1, 2 or 3 in the above scenario) into the curent_batch file.
+ * To load ff-mm-ss-02.scan, the following command can be used::
+ *
+ *   # echo 2 > /sys/devices/virtual/misc/intel_ifs_0/current_batch
+ *
+ * The above file can also be read to know the currently loaded image.
  *
  * Running tests
  * -------------
@@ -209,6 +219,7 @@ struct ifs_data {
 	int	status;
 	u64	scan_details;
 	u32	cur_batch;
+	int	test_num;
 };
 
 struct ifs_work {
@@ -229,7 +240,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
-void ifs_load_firmware(struct device *dev);
+int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index edc7baa..c5c24e6 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -253,17 +253,18 @@ static int image_sanity_check(struct device *dev, const struct microcode_header_
 
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
@@ -279,8 +280,13 @@ void ifs_load_firmware(struct device *dev)
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
index b2ca2bb..0bfd8fc 100644
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
index e077910..ee636a7 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -87,6 +87,43 @@ static ssize_t run_test_store(struct device *dev,
 
 static DEVICE_ATTR_WO(run_test);
 
+static ssize_t current_batch_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ifs_data *ifsd = ifs_get_data(dev);
+	unsigned int cur_batch;
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
