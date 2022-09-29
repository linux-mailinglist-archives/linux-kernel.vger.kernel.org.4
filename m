Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09B05EEBC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiI2CdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2CdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:33:11 -0400
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16E124766
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=15826; q=dns/txt;
  s=iport; t=1664418788; x=1665628388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wYmELVNw0Uln+5ah0jAmrFbrbW/CbqybKGRXKMlyH2A=;
  b=DfLRyjJQ+OjCacWg1NuDC6OcP1ZEcw+IPGgBxF7DLkh4FIskE2OKob01
   p+mE4BUxHfmbZHLex7bBtBMzC/2/9HBW48JkizYd7RXW+SGI3epN3k2Jh
   ZSI7yR2zo+8hDWA/v6kKsU11/iKrIOUazO9+1P8lPsLDce1CjAjbI/2kq
   U=;
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1063107593"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 29 Sep 2022 02:33:06 +0000
Received: from zorba.cisco.com ([10.25.129.98])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 28T2X1Yq007711;
        Thu, 29 Sep 2022 02:33:05 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Anderson <sean.anderson@seco.com>
Cc:     xe-linux-external@cisco.com, Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] CMDLINE: add generic builtin command line
Date:   Wed, 28 Sep 2022 19:32:47 -0700
Message-Id: <20220929023301.3344694-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929023301.3344694-1-danielwa@cisco.com>
References: <20220929023301.3344694-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.25.129.98, [10.25.129.98]
X-Outbound-Node: rcdn-core-8.cisco.com
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code allows architectures to use a generic builtin command line.
The state of the builtin command line options across architecture is
diverse. MIPS and X86 once has similar systems, then mips added some
options to allow extending the command line. Powerpc did something
simiar in adding the ability to extend. Even with mips and powerpc
enhancement the needs of Cisco are not met on these platforms.

The code in this commit unifies the code into a generic
header file under the CONFIG_GENERIC_CMDLINE option. When this
option is enabled the architecture can call the cmdline_add_builtin()
to add the builtin command line. The generic code provides both
append and/or prepend options and provides a way to redefine these
option after the kernel is compiled.

This code also includes test's which are meant to confirm
functionality.

This unified implementation offers the same functionality needed by
Cisco on all platform which we enable it on.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Bilovol <rbilovol@cisco.com>
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 include/linux/cmdline.h | 106 ++++++++++++++++++++++++++++++
 init/Kconfig            |  78 ++++++++++++++++++++++
 lib/Kconfig             |   4 ++
 lib/Makefile            |   3 +
 lib/generic_cmdline.S   |  53 +++++++++++++++
 lib/test_cmdline1.c     | 139 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 383 insertions(+)
 create mode 100644 include/linux/cmdline.h
 create mode 100644 lib/generic_cmdline.S
 create mode 100644 lib/test_cmdline1.c

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
new file mode 100644
index 000000000000..a94758a0f257
--- /dev/null
+++ b/include/linux/cmdline.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CMDLINE_H
+#define _LINUX_CMDLINE_H
+/*
+ *
+ * Copyright (C) 2006,2021. Cisco Systems, Inc.
+ *
+ * Generic Append/Prepend cmdline support.
+ */
+
+
+#include <linux/ctype.h>
+#include <linux/cache.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_CMDLINE_BOOL
+extern char cmdline_prepend[];
+extern char cmdline_append[];
+extern char cmdline_tmp[];
+#define CMDLINE_PREPEND cmdline_prepend
+#define CMDLINE_APPEND cmdline_append
+#define CMDLINE_TMP cmdline_tmp
+#define CMDLINE_STATIC_PREPEND CONFIG_CMDLINE_PREPEND
+#define CMDLINE_STATIC_APPEND CONFIG_CMDLINE_APPEND
+#else
+#define CMDLINE_PREPEND ""
+#define CMDLINE_APPEND ""
+#define CMDLINE_TMP ""
+#define CMDLINE_STATIC_PREPEND ""
+#define CMDLINE_STATIC_APPEND ""
+#endif
+
+#ifndef CMDLINE_STRLCAT
+#define CMDLINE_STRLCAT strlcat
+#endif
+
+#ifndef CMDLINE_STRLEN
+#define CMDLINE_STRLEN strlen
+#endif
+
+/*
+ * This function will append or prepend a builtin command line to the command
+ * line provided by the bootloader. Kconfig options can be used to alter
+ * the behavior of this builtin command line.
+ * @dest: The destination of the final appended/prepended string
+ * @tmp: temporary space used for prepending
+ * @prepend: string to prepend to @dest
+ * @append: string to append to @dest
+ * @length: the maximum length of the strings above.
+ * @cmdline_strlen: point to a compatible strlen
+ * @cmdline_strlcat: point to a compatible strlcat
+ * This function returns true when the builtin command line was copied successfully
+ * and false when there was not enough room to copy all parts of the command line.
+ */
+static inline bool
+__cmdline_add_builtin(
+		char *dest,
+		char *tmp,
+		char *prepend,
+		char *append,
+		unsigned long length,
+		size_t (*cmdline_strlen)(const char *s),
+		size_t (*cmdline_strlcat)(char *dest, const char *src, size_t count))
+{
+	size_t total_length = 0, tmp_length;
+
+	if (!IS_ENABLED(CONFIG_GENERIC_CMDLINE))
+		return true;
+
+	if (!IS_ENABLED(CONFIG_CMDLINE_BOOL))
+		return true;
+
+	if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
+		dest[0] = '\0';
+	else
+		total_length += cmdline_strlen(dest);
+
+	tmp_length = cmdline_strlen(append);
+	if (tmp_length > 0) {
+		cmdline_strlcat(dest, append, length);
+		total_length += tmp_length;
+	}
+
+	tmp_length = cmdline_strlen(prepend);
+	if (tmp_length > 0) {
+		cmdline_strlcat(tmp, prepend, length);
+		cmdline_strlcat(tmp, dest, length);
+		dest[0] = '\0';
+		cmdline_strlcat(dest, tmp, length);
+		total_length += tmp_length;
+	}
+
+	tmp[0] = '\0';
+
+	if (total_length > length)
+		return false;
+
+	return true;
+}
+
+#define cmdline_add_builtin(dest) \
+	__cmdline_add_builtin(dest, CMDLINE_TMP, CMDLINE_PREPEND, CMDLINE_APPEND, COMMAND_LINE_SIZE, CMDLINE_STRLEN, CMDLINE_STRLCAT)
+
+#define cmdline_get_static_builtin(dest) \
+	(CMDLINE_STATIC_PREPEND CMDLINE_STATIC_APPEND)
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..941d8fe097ee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1906,6 +1906,84 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
+config GENERIC_CMDLINE
+	bool
+
+if GENERIC_CMDLINE
+
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	help
+	  Allow for specifying boot arguments to the kernel at
+	  build time.  On some systems (e.g. embedded ones), it is
+	  necessary or convenient to provide some or all of the
+	  kernel boot arguments with the kernel itself (that is,
+	  to not rely on the boot loader to provide them.)
+
+	  To compile command line arguments into the kernel,
+	  set this option to 'Y', then fill in the
+	  the boot arguments in CONFIG_CMDLINE.
+
+	  Systems with fully functional boot loaders (i.e. non-embedded)
+	  should leave this option set to 'N'.
+
+config CMDLINE_APPEND
+	string "Built-in kernel command string append"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is appended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_PREPEND
+	string "Built-in kernel command string prepend"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, this string is prepended to it to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config CMDLINE_EXTRA
+	bool "Reserve more space for inserting prepend and append without recompiling"
+	depends on CMDLINE_BOOL
+	help
+	  If set, space for an append and prepend will be reserved in the kernel
+	  image. This allows updating or changing the append and prepend to a large
+	  string then the kernel was compiled for without recompiling the kernel.
+
+	  The maximum size is the command line size for each prepend and append.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides boot loader arguments"
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the boot loader
+	  command line, and use ONLY the built-in command line. In this case
+	  append and prepend strings are concatenated to form the full
+	  command line.
+
+	  This is used to work around broken boot loaders.  This should
+	  be set to 'N' under normal conditions.
+endif
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/lib/Kconfig b/lib/Kconfig
index dc1ab2ed1dc6..82da453238c2 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -706,6 +706,10 @@ config PARMAN
 config OBJAGG
 	tristate "objagg" if COMPILE_TEST
 
+config TEST_CMDLINE
+	depends on CMDLINE_BOOL && !CMDLINE_OVERRIDE
+	tristate "Test generic command line handling"
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index ffabc30a27d4..7626821dc046 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -416,3 +416,6 @@ $(obj)/$(TEST_FORTIFY_LOG): $(addprefix $(obj)/, $(TEST_FORTIFY_LOGS)) FORCE
 ifeq ($(CONFIG_FORTIFY_SOURCE),y)
 $(obj)/string.o: $(obj)/$(TEST_FORTIFY_LOG)
 endif
+
+obj-$(CONFIG_TEST_CMDLINE) += test_cmdline1.o
+obj-$(CONFIG_CMDLINE_BOOL)     += generic_cmdline.o
diff --git a/lib/generic_cmdline.S b/lib/generic_cmdline.S
new file mode 100644
index 000000000000..223763f9eeb6
--- /dev/null
+++ b/lib/generic_cmdline.S
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
+#include <linux/init.h>
+
+#include <asm/setup.h>
+
+        __INITDATA
+
+       .align 8
+       .global cmdline_prepend
+cmdline_prepend:
+       .ifnc CONFIG_CMDLINE_PREPEND,""
+       .ascii CONFIG_CMDLINE_PREPEND
+       .string " "
+       .else
+       .byte 0x0
+       .endif
+#ifdef CONFIG_CMDLINE_EXTRA
+       .space COMMAND_LINE_SIZE - (.-cmdline_prepend)
+       .size cmdline_prepend, COMMAND_LINE_SIZE
+#endif /* CONFIG_CMDLINE_EXTRA */
+
+cmdline_prepend_end:
+       .size cmdline_prepend, (cmdline_prepend_end - cmdline_prepend)
+
+       .align 8
+       .global cmdline_tmp
+cmdline_tmp:
+       .ifnc CONFIG_CMDLINE_PREPEND,""
+       .size cmdline_tmp, COMMAND_LINE_SIZE
+       .space COMMAND_LINE_SIZE
+       .else
+       .byte 0x0
+       .endif
+cmdline_tmp_end:
+       .size cmdline_tmp, (cmdline_tmp_end - cmdline_tmp)
+
+       .align 8
+       .global cmdline_append
+       .size cmdline_append, COMMAND_LINE_SIZE
+cmdline_append:
+       .ifnc CONFIG_CMDLINE_APPEND,""
+       .ascii " "
+       .string CONFIG_CMDLINE_APPEND
+       .else
+       .byte 0x0
+       .endif
+#ifdef CONFIG_CMDLINE_EXTRA
+       .space COMMAND_LINE_SIZE - (.-cmdline_append)
+#endif /* CONFIG_CMDLINE_EXTRA */
+cmdline_append_end:
+       .size cmdline_append, (cmdline_append_end - cmdline_append)
+
diff --git a/lib/test_cmdline1.c b/lib/test_cmdline1.c
new file mode 100644
index 000000000000..ae03cf198165
--- /dev/null
+++ b/lib/test_cmdline1.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/bitmap.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/cmdline.h>
+#include <linux/uaccess.h>
+
+#include "../tools/testing/selftests/kselftest_module.h"
+
+KSTM_MODULE_GLOBALS();
+
+char test1_prepend[] = "prepend ";
+char test1_append[] = " append";
+char test1_bootloader_args[] = "console=ttyS0 log_level=3";
+char test1_result[] = "prepend console=ttyS0 log_level=3 append";
+
+char test2_append[] = " append";
+char test2_bootloader_args[] = "console=ttyS0 log_level=3";
+char test2_result[] = "console=ttyS0 log_level=3 append";
+
+char test3_prepend[] = "prepend ";
+char test3_bootloader_args[] = "console=ttyS0 log_level=3";
+char test3_result[] = "prepend console=ttyS0 log_level=3";
+
+char test4_bootloader_args[] = "console=ttyS0 log_level=3";
+char test4_result[] = "console=ttyS0 log_level=3";
+
+char test5_prepend[] = "prepend ";
+char test5_append[] = " append";
+static char test5_bootloader_args[] =
+"00000000000000 011111111111111 0222222222222222 033333333333333 "
+"10000000000000 111111111111111 1222222222222222 133333333333333 "
+"20000000000000 211111111111111 2222222222222222 233333333333333 "
+"30000000000000 311111111111111 3222222222222222 333333333333333 "
+"40000000000000 411111111111111 4222222222222222 433333333333333 "
+"50000000000000 511111111111111 5222222222222222 533333333333333 "
+"60000000000000 611111111111111 6222222222222222 633333333333333 "
+"70000000000000 711111111111111 7222222222222222 733333333333333";
+static char test5_result[] =
+"prepend 00000000000000 011111111111111 0222222222222222 033333333333333 "
+"10000000000000 111111111111111 1222222222222222 133333333333333 "
+"20000000000000 211111111111111 2222222222222222 233333333333333 "
+"30000000000000 311111111111111 3222222222222222 333333333333333 "
+"40000000000000 411111111111111 4222222222222222 433333333333333 "
+"50000000000000 511111111111111 5222222222222222 533333333333333 "
+"60000000000000 611111111111111 6222222222222222 633333333333333 "
+"70000000000000 711111111111111 7222222222222222 7333333";
+
+char test5_boot_command_line[512];
+
+char test_tmp[COMMAND_LINE_SIZE];
+
+char test_boot_command_line[COMMAND_LINE_SIZE];
+
+static void __init selftest(void)
+{
+	bool result;
+
+	/* Normal operation */
+	strcpy(test_boot_command_line, test1_bootloader_args);
+	test_tmp[0] = '\0';
+	result = __cmdline_add_builtin(test_boot_command_line, test_tmp, test1_prepend, test1_append, COMMAND_LINE_SIZE, CMDLINE_STRLEN, CMDLINE_STRLCAT);
+
+	if (result == true && !strncmp(test_boot_command_line, test1_result, COMMAND_LINE_SIZE)) {
+		pr_info("test1 success.\n");
+	} else {
+		pr_info("test1 failed. OUTPUT BELOW:\n");
+		pr_info("\"%s\"\n", test_boot_command_line);
+		failed_tests++;
+	}
+	total_tests++;
+
+	/* Missing prepend */
+	strcpy(test_boot_command_line, test2_bootloader_args);
+	test_tmp[0] = '\0';
+	result = __cmdline_add_builtin(test_boot_command_line, test_tmp, "", test2_append, COMMAND_LINE_SIZE, CMDLINE_STRLEN, CMDLINE_STRLCAT);
+
+	if (result == true && !strncmp(test_boot_command_line, test2_result, COMMAND_LINE_SIZE)) {
+		pr_info("test2 success.\n");
+	} else {
+		pr_info("test2 failed. OUTPUT BELOW:\n");
+		pr_info("\"%s\"\n", test_boot_command_line);
+		failed_tests++;
+	}
+	total_tests++;
+
+	/* Missing append */
+	strcpy(test_boot_command_line, test3_bootloader_args);
+	test_tmp[0] = '\0';
+	result = __cmdline_add_builtin(test_boot_command_line, test_tmp, test3_prepend, "", COMMAND_LINE_SIZE, CMDLINE_STRLEN, CMDLINE_STRLCAT);
+
+	if (result == true && !strncmp(test_boot_command_line, test3_result, COMMAND_LINE_SIZE)) {
+		pr_info("test3 success.\n");
+	} else {
+		pr_info("test3 failed. OUTPUT BELOW:\n");
+		pr_info("\"%s\"\n", test_boot_command_line);
+		failed_tests++;
+	}
+	total_tests++;
+
+	/* Missing append and prepend */
+	strcpy(test_boot_command_line, test4_bootloader_args);
+	test_tmp[0] = '\0';
+	result = __cmdline_add_builtin(test_boot_command_line, test_tmp, "", "", COMMAND_LINE_SIZE, CMDLINE_STRLEN, CMDLINE_STRLCAT);
+
+	if (result == true && !strncmp(test_boot_command_line, test4_result, COMMAND_LINE_SIZE)) {
+		pr_info("test4 success.\n");
+	} else {
+		pr_info("test4 failed. OUTPUT BELOW:\n");
+		pr_info("\"%s\"\n", test_boot_command_line);
+		failed_tests++;
+	}
+	total_tests++;
+
+	/* Already full boot arguments */
+	strcpy(test5_boot_command_line, test5_bootloader_args);
+	test_tmp[0] = '\0';
+	result = __cmdline_add_builtin(test5_boot_command_line, test_tmp, test5_prepend, test5_append, 512, CMDLINE_STRLEN, CMDLINE_STRLCAT);
+
+	if (result == false && !strncmp(test5_boot_command_line, test5_result, COMMAND_LINE_SIZE)) {
+		pr_info("test5 success.\n");
+	} else {
+		pr_info("test5 failed. OUTPUT BELOW:\n");
+		pr_info("\"%s\"\n", test5_boot_command_line);
+		failed_tests++;
+	}
+	total_tests++;
+}
+
+KSTM_MODULE_LOADERS(cmdline_test);
+MODULE_AUTHOR("Daniel Walker <danielwa@cisco.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

