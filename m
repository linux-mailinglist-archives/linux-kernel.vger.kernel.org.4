Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1D6671430
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjARGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjARGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:22:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EFB4E506;
        Tue, 17 Jan 2023 22:11:28 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30I53UC8015717;
        Wed, 18 Jan 2023 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=t3m47uvq+CqvvF8pstMZiVfGvV0dkV3Mb/lcW53rAF8=;
 b=LNSI0OdxhRjA8IXpaYyPRiRO9rFY4rKNCW+DBx4DFT2l2fSBoKtb3a5/5oqDIb04jpkf
 uTQs0kz+//dDOc26woT4KQvLpB8e0x8yb9QbrvW/KpKY4wt2xQDjN5x4jKaslntZcP+9
 9jEzHZmwzhA4ZTFC8OrQkGyuRkUFAC8uNJeYCOG0tQgsbcN/Cd+Z+NHCCKvWxFAZc2TC
 6tu9pif/ct7JxKQLS+w2PKiazMI/bOCQpINFAL+qXHXWA9thCP8u2JcWuMFMus43ePa9
 e6g5SqEN79YbkcCvrk5/fg/b2Hv3VOiZjAmNeYbgJU/a/ob1mVltwuSlGpNsqC9AwlD/ ZQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n6a9ph6x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:19 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30HAxqLW003649;
        Wed, 18 Jan 2023 06:11:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3n3m16bh27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 06:11:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30I6BFti14942544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 06:11:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3687920040;
        Wed, 18 Jan 2023 06:11:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40E0320043;
        Wed, 18 Jan 2023 06:11:14 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Jan 2023 06:11:14 +0000 (GMT)
Received: from jarvis-ozlabs-ibm-com.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 991FB609C1;
        Wed, 18 Jan 2023 17:11:08 +1100 (AEDT)
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ruscur@russell.cc, zohar@linux.ibm.com, mpe@ellerman.id.au,
        gjoyce@linux.ibm.com, sudhakar@linux.ibm.com, bgray@linux.ibm.com,
        erichte@linux.ibm.com
Subject: [PATCH v3 22/24] powerpc/pseries: Implement secvars for dynamic secure boot
Date:   Wed, 18 Jan 2023 17:10:47 +1100
Message-Id: <20230118061049.1006141-23-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061049.1006141-1-ajd@linux.ibm.com>
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HuvbMilrSmSURaMwbqLUS6W3yvHLdxFl
X-Proofpoint-ORIG-GUID: HuvbMilrSmSURaMwbqLUS6W3yvHLdxFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_01,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301180051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell Currey <ruscur@russell.cc>

The pseries platform can support dynamic secure boot (i.e. secure boot
using user-defined keys) using variables contained with the PowerVM LPAR
Platform KeyStore (PLPKS).  Using the powerpc secvar API, expose the
relevant variables for pseries dynamic secure boot through the existing
secvar filesystem layout.

The relevant variables for dynamic secure boot are signed in the
keystore, and can only be modified using the H_PKS_SIGNED_UPDATE hcall.
Object labels in the keystore are encoded using ucs2 format.  With our
fixed variable names we don't have to care about encoding outside of the
necessary byte padding.

When a user writes to a variable, the first 8 bytes of data must contain
the signed update flags as defined by the hypervisor.

When a user reads a variable, the first 4 bytes of data contain the
policies defined for the object.

Limitations exist due to the underlying implementation of sysfs binary
attributes, as is the case for the OPAL secvar implementation -
partial writes are unsupported and writes cannot be larger than PAGE_SIZE.

Co-developed-by: Nayna Jain <nayna@linux.ibm.com>
Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Russell Currey <ruscur@russell.cc>

---

v2: Remove unnecessary config vars from sysfs and document the others,
    thanks to review from Greg.  If we end up needing to expose more, we
    can add them later and update the docs.

    Use sysfs_emit() instead of sprintf(), thanks to Greg.

    Change the size of the sysfs binary attributes to include the 8-byte
    flags header, preventing truncation of large writes.

v3: plpks_set_variable(): pass var to plpks_signed_update_var() as a
    pointer (mpe)

    Update copyright date (ajd)

    Consistent comment style (ajd)

    Change device_initcall() to machine_arch_initcall(pseries...) so we
    don't try to load on powernv and kill the machine (mpe)

    Add config attributes into plpks_secvar_ops (mpe)

    Get rid of PLPKS_SECVAR_COUNT macro (mpe)

    Reworded descriptions in ABI documentation (mpe)

    Switch to using secvar_ops->var_names rather than
    secvar_ops->get_next() (ajd/mpe)

    Optimise allocation/copying of buffers (mpe)

    Elaborate the comment documenting the "format" string (mpe)

    Return -EIO on errors in the read case (mpe)

    Add "grubdbx" variable (Sudhakar Kuppusamy)

    Use utf8s_to_utf16s() rather than our own "UCS-2" conversion code (mpe)

    Change uint64_t to u64 (mpe)

    Fix SB_VERSION data length (ruscur)

    Stop prepending policy data on read (ruscur)

    Enforce max format length on format string (not strictly needed, but
    makes the length limit clear) (ajd)

    Update include of plpks.h to reflect new path (ruscur)

    Consistent constant naming scheme (ruscur)
---
 Documentation/ABI/testing/sysfs-secvar        |  75 +++++-
 arch/powerpc/platforms/pseries/Makefile       |   4 +-
 arch/powerpc/platforms/pseries/plpks-secvar.c | 214 ++++++++++++++++++
 3 files changed, 290 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-secvar.c

diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
index feebb8c57294..a19f4d5fcec6 100644
--- a/Documentation/ABI/testing/sysfs-secvar
+++ b/Documentation/ABI/testing/sysfs-secvar
@@ -18,6 +18,14 @@ Description:	A string indicating which backend is in use by the firmware.
 		This determines the format of the variable and the accepted
 		format of variable updates.
 
+		On powernv/OPAL, this value is provided by the OPAL firmware
+		and is expected to be "ibm,edk2-compat-v1".
+
+		On pseries/PLPKS, this is generated by the kernel based on the
+		version number in the SB_VERSION variable in the keystore, and
+		has the form "ibm,plpks-sb-v<version>", or
+		"ibm,plpks-sb-unknown" if there is no SB_VERSION variable.
+
 What:		/sys/firmware/secvar/vars/<variable name>
 Date:		August 2019
 Contact:	Nayna Jain <nayna@linux.ibm.com>
@@ -34,7 +42,7 @@ Description:	An integer representation of the size of the content of the
 
 What:		/sys/firmware/secvar/vars/<variable_name>/data
 Date:		August 2019
-Contact:	Nayna Jain h<nayna@linux.ibm.com>
+Contact:	Nayna Jain <nayna@linux.ibm.com>
 Description:	A read-only file containing the value of the variable. The size
 		of the file represents the maximum size of the variable data.
 
@@ -44,3 +52,68 @@ Contact:	Nayna Jain <nayna@linux.ibm.com>
 Description:	A write-only file that is used to submit the new value for the
 		variable. The size of the file represents the maximum size of
 		the variable data that can be written.
+
+What:		/sys/firmware/secvar/config
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	This optional directory contains read-only config attributes as
+		defined by the secure variable implementation.  All data is in
+		ASCII format. The directory is only created if the backing
+		implementation provides variables to populate it, which at
+		present is only PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/version
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Config version as reported by the hypervisor in ASCII decimal
+		format.
+
+		Currently only provided by PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/max_object_size
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Maximum allowed size of	objects in the keystore in bytes,
+		represented in ASCII decimal format.
+
+		This is not necessarily the same as the max size that can be
+		written to an update file as writes can contain more than
+		object data, you should use the size of the update file for
+		that purpose.
+
+		Currently only provided by PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/total_size
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Total size of the PLPKS in bytes, represented in ASCII decimal
+		format.
+
+		Currently only provided by PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/used_space
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Current space consumed by the key store, in bytes, represented
+		in ASCII decimal format.
+
+		Currently only provided by PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/supported_policies
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Bitmask of supported policy flags by the hypervisor,
+		represented as an 8 byte hexadecimal ASCII string. Consult the
+		hypervisor documentation for what these flags are.
+
+		Currently only provided by PLPKS on the pseries platform.
+
+What:		/sys/firmware/secvar/config/signed_update_algorithms
+Date:		December 2022
+Contact:	Nayna Jain <nayna@linux.ibm.com>
+Description:	Bitmask of flags indicating which algorithms the hypervisor
+		supports for signed update of objects, represented as a 16 byte
+		hexadecimal ASCII string. Consult the hypervisor documentation
+		for what these flags mean.
+
+		Currently only provided by PLPKS on the pseries platform.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 92310202bdd7..d52b7ec1a678 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -27,8 +27,8 @@ obj-$(CONFIG_PAPR_SCM)		+= papr_scm.o
 obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_SVM)		+= svm.o
 obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
-obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
-
+obj-$(CONFIG_PSERIES_PLPKS)	+= plpks.o
+obj-$(CONFIG_PPC_SECVAR_SYSFS)	+= plpks-secvar.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
 
diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
new file mode 100644
index 000000000000..35f33c4509f5
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+// Secure variable implementation using the PowerVM LPAR Platform KeyStore (PLPKS)
+//
+// Copyright 2022, 2023 IBM Corporation
+// Authors: Russell Currey
+//          Andrew Donnellan
+//          Nayna Jain
+
+#define pr_fmt(fmt) "secvar: "fmt
+
+#include <linux/printk.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/kobject.h>
+#include <linux/nls.h>
+#include <asm/machdep.h>
+#include <asm/secvar.h>
+#include <asm/plpks.h>
+
+// Config attributes for sysfs
+#define PLPKS_CONFIG_ATTR(name, fmt, func)			\
+	static ssize_t name##_show(struct kobject *kobj,	\
+				   struct kobj_attribute *attr,	\
+				   char *buf)			\
+	{							\
+		return sysfs_emit(buf, fmt, func());		\
+	}							\
+	static struct kobj_attribute attr_##name = __ATTR_RO(name)
+
+PLPKS_CONFIG_ATTR(version, "%u\n", plpks_get_version);
+PLPKS_CONFIG_ATTR(max_object_size, "%u\n", plpks_get_maxobjectsize);
+PLPKS_CONFIG_ATTR(total_size, "%u\n", plpks_get_totalsize);
+PLPKS_CONFIG_ATTR(used_space, "%u\n", plpks_get_usedspace);
+PLPKS_CONFIG_ATTR(supported_policies, "%08x\n", plpks_get_supportedpolicies);
+PLPKS_CONFIG_ATTR(signed_update_algorithms, "%016llx\n", plpks_get_signedupdatealgorithms);
+
+static const struct attribute *config_attrs[] = {
+	&attr_version.attr,
+	&attr_max_object_size.attr,
+	&attr_total_size.attr,
+	&attr_used_space.attr,
+	&attr_supported_policies.attr,
+	&attr_signed_update_algorithms.attr,
+	NULL,
+};
+
+static u32 get_policy(const char *name)
+{
+	if ((strcmp(name, "db") == 0) ||
+	    (strcmp(name, "dbx") == 0) ||
+	    (strcmp(name, "grubdb") == 0) ||
+	    (strcmp(name, "grubdbx") == 0) ||
+	    (strcmp(name, "sbat") == 0))
+		return (PLPKS_WORLDREADABLE | PLPKS_SIGNEDUPDATE);
+	else
+		return PLPKS_SIGNEDUPDATE;
+}
+
+static const char * const plpks_var_names[] = {
+	"PK",
+	"KEK",
+	"db",
+	"dbx",
+	"grubdb",
+	"grubdbx",
+	"sbat",
+	"moduledb",
+	"trustedcadb",
+	NULL,
+};
+
+static int plpks_get_variable(const char *key, u64 key_len, u8 *data,
+			      u64 *data_size)
+{
+	struct plpks_var var = {0};
+	int rc = 0;
+
+	var.name = kcalloc(key_len - 1, sizeof(wchar_t), GFP_KERNEL);
+	if (!var.name)
+		return -ENOMEM;
+	rc = utf8s_to_utf16s(key, key_len - 1, UTF16_LITTLE_ENDIAN, (wchar_t *)var.name,
+			     key_len - 1);
+	if (rc < 0)
+		goto err;
+	var.namelen = rc * 2;
+
+	var.os = PLPKS_VAR_LINUX;
+	if (data) {
+		var.data = data;
+		var.datalen = *data_size;
+	}
+	rc = plpks_read_os_var(&var);
+
+	if (rc)
+		goto err;
+
+	*data_size = var.datalen;
+
+err:
+	kfree(var.name);
+	if (rc && rc != -ENOENT) {
+		pr_err("Failed to read variable '%s': %d\n", key, rc);
+		// Return -EIO since userspace probably doesn't care about the
+		// specific error
+		rc = -EIO;
+	}
+	return rc;
+}
+
+static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
+			      u64 data_size)
+{
+	struct plpks_var var = {0};
+	int rc = 0;
+	u64 flags;
+
+	// Secure variables need to be prefixed with 8 bytes of flags.
+	// We only want to perform the write if we have at least one byte of data.
+	if (data_size <= sizeof(flags))
+		return -EINVAL;
+
+	var.name = kcalloc(key_len - 1, sizeof(wchar_t), GFP_KERNEL);
+	if (!var.name)
+		return -ENOMEM;
+	rc = utf8s_to_utf16s(key, key_len - 1, UTF16_LITTLE_ENDIAN, (wchar_t *)var.name,
+			     key_len - 1);
+	if (rc < 0)
+		goto err;
+	var.namelen = rc * 2;
+
+	memcpy(&flags, data, sizeof(flags));
+
+	var.datalen = data_size - sizeof(flags);
+	var.data = data + sizeof(flags);
+	var.os = PLPKS_VAR_LINUX;
+	var.policy = get_policy(key);
+
+	// Unlike in the read case, the plpks error code can be useful to
+	// userspace on write, so we return it rather than just -EIO
+	rc = plpks_signed_update_var(&var, flags);
+
+err:
+	kfree(var.name);
+	return rc;
+}
+
+// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
+// Instead, report the format using the SB_VERSION variable in the keystore.
+static ssize_t plpks_secvar_format(char *buf)
+{
+	struct plpks_var var = {0};
+	ssize_t ret;
+
+	var.component = NULL;
+	// Only the signed variables have null bytes in their names, this one doesn't
+	var.name = "SB_VERSION";
+	var.namelen = 10;
+	var.datalen = 1;
+	var.data = kzalloc(1, GFP_KERNEL);
+
+	// Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
+	ret = plpks_read_fw_var(&var);
+	if (ret) {
+		if (ret == -ENOENT) {
+			ret = snprintf(buf, SECVAR_MAX_FORMAT_LEN, "ibm,plpks-sb-unknown");
+		} else {
+			pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
+			ret = -EIO;
+		}
+		goto err;
+	}
+
+	// This string is made up by us - the hypervisor doesn't provide us
+	// with a format string in the way that OPAL firmware does. Hypervisor
+	// defines SB_VERSION as a "1 byte unsigned integer value".
+	ret = snprintf(buf, SECVAR_MAX_FORMAT_LEN, "ibm,plpks-sb-v%hhu", var.data[0]);
+
+err:
+	kfree(var.data);
+	return ret;
+}
+
+static int plpks_max_size(u64 *max_size)
+{
+	// The max object size reported by the hypervisor is accurate for the
+	// object itself, but we use the first 8 bytes of data on write as the
+	// signed update flags, so the max size a user can write is larger.
+	*max_size = (u64)plpks_get_maxobjectsize() + 8;
+
+	return 0;
+}
+
+
+static const struct secvar_operations plpks_secvar_ops = {
+	.get = plpks_get_variable,
+	.set = plpks_set_variable,
+	.format = plpks_secvar_format,
+	.max_size = plpks_max_size,
+	.config_attrs = config_attrs,
+	.var_names = plpks_var_names,
+};
+
+static int plpks_secvar_init(void)
+{
+	if (!plpks_is_available())
+		return -ENODEV;
+
+	set_secvar_ops(&plpks_secvar_ops);
+	return 0;
+}
+machine_device_initcall(pseries, plpks_secvar_init);
-- 
2.39.0

