Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05AD6C51BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCVRDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCVRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:03:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E83E1BC;
        Wed, 22 Mar 2023 10:03:09 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pXETkdLCHeYpE9ioxjH0Vtx0mKb9a+Jg4JgMGtXT6/w=;
        b=kcQK2N7kHk4tOqI1jgfyj/pndo3e+39BKVvFXv8JR/ZGzRCACVbMaIEcCtt76r2lHlZOqQ
        dZ9TDrFq8htuBi9OIDstcoDOUAL6RlqOffu4TozDAin6bxLoAM7Gxrh4CRxDydPqUIQ3LG
        QQMe/j0UT/p6mvd+JwPdxA9vTLYQYh6ssulv4/NMPXiN11GqPbfh4HPMzOckPX9zEr4TUl
        pUqb3ymNCVs67izKTPdd7BVxsDve7hPYu4LVBIzs/a/w38VxlK2l0/vawFfIpTg59kwtkk
        73h2cAMBJ2WV3JvTRJyMcPCrGq9zt7p4PHyD/IYvqVAdLq+5uVA/nT55FowcOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pXETkdLCHeYpE9ioxjH0Vtx0mKb9a+Jg4JgMGtXT6/w=;
        b=wc1EZE3qjXtoFLN1DiDTRTqQUbiDTe+ZshYdVGNhE+iFIy6Ksuu3LaXLG/aP8TlAVuE+pP
        9MIt3Hb88xlzlbBQ==
From:   "tip-bot2 for Weihong Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases
 for linear-address masking
Cc:     Weihong Zhang <weihong.zhang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458444.5837.6104488815089043052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     34821473deb3a56adf5e989e8cefd8bfc60ed216
Gitweb:        https://git.kernel.org/tip/34821473deb3a56adf5e989e8cefd8bfc60ed216
Author:        Weihong Zhang <weihong.zhang@intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:11 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:40 -07:00

selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for linear-address masking

By default do not allow to enable both LAM and use SVA in the same
process.
The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.

Add new test cases for the new arch_prctl:
Before using ARCH_FORCE_TAGGED_SVA, should not allow to enable LAM/SVA
coexisting. the test cases should be negative.

The test depands on idxd driver and iommu. before test, need add
"intel_iommu=on,sm_on" in kernel command line and insmod idxd driver.

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230312112612.31869-17-kirill.shutemov%40linux.intel.com
---
 tools/testing/selftests/x86/lam.c | 237 ++++++++++++++++++++++++++++-
 1 file changed, 235 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index ebabd43..a8c9182 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -30,6 +30,7 @@
 #define ARCH_GET_UNTAG_MASK     0x4001
 #define ARCH_ENABLE_TAGGED_ADDR 0x4002
 #define ARCH_GET_MAX_TAG_BITS   0x4003
+#define ARCH_FORCE_TAGGED_SVA	0x4004
 
 /* Specified test function bits */
 #define FUNC_MALLOC             0x1
@@ -38,8 +39,9 @@
 #define FUNC_SYSCALL            0x8
 #define FUNC_URING              0x10
 #define FUNC_INHERITE           0x20
+#define FUNC_PASID              0x40
 
-#define TEST_MASK               0x3f
+#define TEST_MASK               0x7f
 
 #define LOW_ADDR                (0x1UL << 30)
 #define HIGH_ADDR               (0x3UL << 48)
@@ -55,11 +57,19 @@
 #define URING_QUEUE_SZ 1
 #define URING_BLOCK_SZ 2048
 
+/* Pasid test define */
+#define LAM_CMD_BIT 0x1
+#define PAS_CMD_BIT 0x2
+#define SVA_CMD_BIT 0x4
+
+#define PAS_CMD(cmd1, cmd2, cmd3) (((cmd3) << 8) | ((cmd2) << 4) | ((cmd1) << 0))
+
 struct testcases {
 	unsigned int later;
 	int expected; /* 2: SIGSEGV Error; 1: other errors */
 	unsigned long lam;
 	uint64_t addr;
+	uint64_t cmd;
 	int (*test_func)(struct testcases *test);
 	const char *msg;
 };
@@ -556,7 +566,7 @@ int do_uring(unsigned long lam)
 	struct file_io *fi;
 	struct stat st;
 	int ret = 1;
-	char path[PATH_MAX];
+	char path[PATH_MAX] = {0};
 
 	/* get current process path */
 	if (readlink("/proc/self/exe", path, PATH_MAX) <= 0)
@@ -852,6 +862,226 @@ static void cmd_help(void)
 	printf("\t-h: help\n");
 }
 
+/* Check for file existence */
+uint8_t file_Exists(const char *fileName)
+{
+	struct stat buffer;
+
+	uint8_t ret = (stat(fileName, &buffer) == 0);
+
+	return ret;
+}
+
+/* Sysfs idxd files */
+const char *dsa_configs[] = {
+	"echo 1 > /sys/bus/dsa/devices/dsa0/wq0.1/group_id",
+	"echo shared > /sys/bus/dsa/devices/dsa0/wq0.1/mode",
+	"echo 10 > /sys/bus/dsa/devices/dsa0/wq0.1/priority",
+	"echo 16 > /sys/bus/dsa/devices/dsa0/wq0.1/size",
+	"echo 15 > /sys/bus/dsa/devices/dsa0/wq0.1/threshold",
+	"echo user > /sys/bus/dsa/devices/dsa0/wq0.1/type",
+	"echo MyApp1 > /sys/bus/dsa/devices/dsa0/wq0.1/name",
+	"echo 1 > /sys/bus/dsa/devices/dsa0/engine0.1/group_id",
+	"echo dsa0 > /sys/bus/dsa/drivers/idxd/bind",
+	/* bind files and devices, generated a device file in /dev */
+	"echo wq0.1 > /sys/bus/dsa/drivers/user/bind",
+};
+
+/* DSA device file */
+const char *dsaDeviceFile = "/dev/dsa/wq0.1";
+/* file for io*/
+const char *dsaPasidEnable = "/sys/bus/dsa/devices/dsa0/pasid_enabled";
+
+/*
+ * DSA depends on kernel cmdline "intel_iommu=on,sm_on"
+ * return pasid_enabled (0: disable 1:enable)
+ */
+int Check_DSA_Kernel_Setting(void)
+{
+	char command[256] = "";
+	char buf[256] = "";
+	char *ptr;
+	int rv = -1;
+
+	snprintf(command, sizeof(command) - 1, "cat %s", dsaPasidEnable);
+
+	FILE *cmd = popen(command, "r");
+
+	if (cmd) {
+		while (fgets(buf, sizeof(buf) - 1, cmd) != NULL);
+
+		pclose(cmd);
+		rv = strtol(buf, &ptr, 16);
+	}
+
+	return rv;
+}
+
+/*
+ * Config DSA's sysfs files as shared DSA's WQ.
+ * Generated a device file /dev/dsa/wq0.1
+ * Return:  0 OK; 1 Failed; 3 Skip(SVA disabled).
+ */
+int Dsa_Init_Sysfs(void)
+{
+	uint len = ARRAY_SIZE(dsa_configs);
+	const char **p = dsa_configs;
+
+	if (file_Exists(dsaDeviceFile) == 1)
+		return 0;
+
+	/* check the idxd driver */
+	if (file_Exists(dsaPasidEnable) != 1) {
+		printf("Please make sure idxd driver was loaded\n");
+		return 3;
+	}
+
+	/* Check SVA feature */
+	if (Check_DSA_Kernel_Setting() != 1) {
+		printf("Please enable SVA.(Add intel_iommu=on,sm_on in kernel cmdline)\n");
+		return 3;
+	}
+
+	/* Check the idxd device file on /dev/dsa/ */
+	for (int i = 0; i < len; i++) {
+		if (system(p[i]))
+			return 1;
+	}
+
+	/* After config, /dev/dsa/wq0.1 should be generated */
+	return (file_Exists(dsaDeviceFile) != 1);
+}
+
+/*
+ * Open DSA device file, triger API: iommu_sva_alloc_pasid
+ */
+void *allocate_dsa_pasid(void)
+{
+	int fd;
+	void *wq;
+
+	fd = open(dsaDeviceFile, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		return MAP_FAILED;
+	}
+
+	wq = mmap(NULL, 0x1000, PROT_WRITE,
+			   MAP_SHARED | MAP_POPULATE, fd, 0);
+	if (wq == MAP_FAILED)
+		perror("mmap");
+
+	return wq;
+}
+
+int set_force_svm(void)
+{
+	int ret = 0;
+
+	ret = syscall(SYS_arch_prctl, ARCH_FORCE_TAGGED_SVA);
+
+	return ret;
+}
+
+int handle_pasid(struct testcases *test)
+{
+	uint tmp = test->cmd;
+	uint runed = 0x0;
+	int ret = 0;
+	void *wq = NULL;
+
+	ret = Dsa_Init_Sysfs();
+	if (ret != 0)
+		return ret;
+
+	for (int i = 0; i < 3; i++) {
+		int err = 0;
+
+		if (tmp & 0x1) {
+			/* run set lam mode*/
+			if ((runed & 0x1) == 0)	{
+				err = set_lam(LAM_U57_BITS);
+				runed = runed | 0x1;
+			} else
+				err = 1;
+		} else if (tmp & 0x4) {
+			/* run force svm */
+			if ((runed & 0x4) == 0)	{
+				err = set_force_svm();
+				runed = runed | 0x4;
+			} else
+				err = 1;
+		} else if (tmp & 0x2) {
+			/* run allocate pasid */
+			if ((runed & 0x2) == 0) {
+				runed = runed | 0x2;
+				wq = allocate_dsa_pasid();
+				if (wq == MAP_FAILED)
+					err = 1;
+			} else
+				err = 1;
+		}
+
+		ret = ret + err;
+		if (ret > 0)
+			break;
+
+		tmp = tmp >> 4;
+	}
+
+	if (wq != MAP_FAILED && wq != NULL)
+		if (munmap(wq, 0x1000))
+			printf("munmap failed %d\n", errno);
+
+	if (runed != 0x7)
+		ret = 1;
+
+	return (ret != 0);
+}
+
+/*
+ * Pasid test depends on idxd and SVA, kernel should enable iommu and sm.
+ * command line(intel_iommu=on,sm_on)
+ */
+static struct testcases pasid_cases[] = {
+	{
+		.expected = 1,
+		.cmd = PAS_CMD(LAM_CMD_BIT, PAS_CMD_BIT, SVA_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: [Negative] Execute LAM, PASID, SVA in sequence\n",
+	},
+	{
+		.expected = 0,
+		.cmd = PAS_CMD(LAM_CMD_BIT, SVA_CMD_BIT, PAS_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: Execute LAM, SVA, PASID in sequence\n",
+	},
+	{
+		.expected = 1,
+		.cmd = PAS_CMD(PAS_CMD_BIT, LAM_CMD_BIT, SVA_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: [Negative] Execute PASID, LAM, SVA in sequence\n",
+	},
+	{
+		.expected = 0,
+		.cmd = PAS_CMD(PAS_CMD_BIT, SVA_CMD_BIT, LAM_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: Execute PASID, SVA, LAM in sequence\n",
+	},
+	{
+		.expected = 0,
+		.cmd = PAS_CMD(SVA_CMD_BIT, LAM_CMD_BIT, PAS_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: Execute SVA, LAM, PASID in sequence\n",
+	},
+	{
+		.expected = 0,
+		.cmd = PAS_CMD(SVA_CMD_BIT, PAS_CMD_BIT, LAM_CMD_BIT),
+		.test_func = handle_pasid,
+		.msg = "PASID: Execute SVA, PASID, LAM in sequence\n",
+	},
+};
+
 int main(int argc, char **argv)
 {
 	int c = 0;
@@ -910,6 +1140,9 @@ int main(int argc, char **argv)
 	if (tests & FUNC_INHERITE)
 		run_test(inheritance_cases, ARRAY_SIZE(inheritance_cases));
 
+	if (tests & FUNC_PASID)
+		run_test(pasid_cases, ARRAY_SIZE(pasid_cases));
+
 	ksft_set_plan(tests_cnt);
 
 	return ksft_exit_pass();
