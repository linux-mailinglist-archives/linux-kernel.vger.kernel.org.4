Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0A66AC40E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCFOzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCFOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:54:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9FB206BA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678114385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJ+e8RQw0LRjpZu8Y7BGJtcItMGFr3Edq82YojT+bYo=;
        b=c4L4yuz+aD/WM/4cVBXmtwrVz/BDLdQWJNqryhNOkhVzn4AnWdh5PPBSBpWBixGSqalIZo
        Klj5muBG+SqloUbRNScCPGYpvNr/CddcByHFs8c5VwMFtNygPgGv3yqvpQmO+D1YOZ+8rM
        xk7+b7YIwyplj69uG05ovtFQ+ZjPwRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-sBpGNHCVMHK3OOb0tiRtig-1; Mon, 06 Mar 2023 09:08:29 -0500
X-MC-Unique: sBpGNHCVMHK3OOb0tiRtig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22E22802D2F;
        Mon,  6 Mar 2023 14:08:29 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.17.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C172B40C10FA;
        Mon,  6 Mar 2023 14:08:28 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v7 06/10] livepatch/selftests: add klp-convert
Date:   Mon,  6 Mar 2023 09:08:20 -0500
Message-Id: <20230306140824.3858543-7-joe.lawrence@redhat.com>
In-Reply-To: <20230306140824.3858543-1-joe.lawrence@redhat.com>
References: <20230306140824.3858543-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a simple klp-convert livepatch selftest that exercises various
symbol homonym sympos scenarios.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 lib/livepatch/Makefile                        |   7 +
 lib/livepatch/test_klp_convert.h              |  14 ++
 lib/livepatch/test_klp_convert1.c             | 113 +++++++++++++++
 lib/livepatch/test_klp_convert2.c             | 110 ++++++++++++++
 lib/livepatch/test_klp_convert_mod_a.c        |  25 ++++
 lib/livepatch/test_klp_convert_mod_b.c        |  13 ++
 .../selftests/livepatch/test-livepatch.sh     | 134 ++++++++++++++++++
 7 files changed, 416 insertions(+)
 create mode 100644 lib/livepatch/test_klp_convert.h
 create mode 100644 lib/livepatch/test_klp_convert1.c
 create mode 100644 lib/livepatch/test_klp_convert2.c
 create mode 100644 lib/livepatch/test_klp_convert_mod_a.c
 create mode 100644 lib/livepatch/test_klp_convert_mod_b.c

diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
index dcc912b3478f..ced00515ff84 100644
--- a/lib/livepatch/Makefile
+++ b/lib/livepatch/Makefile
@@ -7,8 +7,15 @@ obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
 				test_klp_callbacks_demo2.o \
 				test_klp_callbacks_busy.o \
 				test_klp_callbacks_mod.o \
+				test_klp_convert1.o \
+				test_klp_convert2.o \
+				test_klp_convert_mod.o \
 				test_klp_livepatch.o \
 				test_klp_shadow_vars.o \
 				test_klp_state.o \
 				test_klp_state2.o \
 				test_klp_state3.o
+
+test_klp_convert_mod-y := \
+	test_klp_convert_mod_a.o \
+	test_klp_convert_mod_b.o
diff --git a/lib/livepatch/test_klp_convert.h b/lib/livepatch/test_klp_convert.h
new file mode 100644
index 000000000000..5d97bc546d6e
--- /dev/null
+++ b/lib/livepatch/test_klp_convert.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _TEST_KLP_CONVERT_
+#define _TEST_KLP_CONVERT_
+
+/* klp-convert symbols - vmlinux */
+extern char *saved_command_line;
+/* klp-convert symbols - test_klp_convert_mod.ko */
+extern char driver_name[];
+extern char homonym_string[];
+extern const char *get_homonym_string(void);
+extern const char *test_klp_get_driver_name(void);
+
+#endif
diff --git a/lib/livepatch/test_klp_convert1.c b/lib/livepatch/test_klp_convert1.c
new file mode 100644
index 000000000000..d4e1163c01cc
--- /dev/null
+++ b/lib/livepatch/test_klp_convert1.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+#include "test_klp_convert.h"
+
+static noinline void print_saved_command_line(void)
+{
+	pr_info("saved_command_line, 0: %s\n", saved_command_line);
+}
+
+static noinline void print_driver_name(void)
+{
+	pr_info("driver_name, 0: %s\n", driver_name);
+	pr_info("test_klp_get_driver_name(), 0: %s\n", test_klp_get_driver_name());
+}
+
+static noinline void print_homonym_string(void)
+{
+	pr_info("homonym_string, 1: %s\n", homonym_string);
+	pr_info("get_homonym_string(), 1: %s\n", get_homonym_string());
+}
+
+/* provide a sysfs handle to invoke debug functions */
+static int print_debug;
+static int print_debug_set(const char *val, const struct kernel_param *kp)
+{
+	print_saved_command_line();
+	print_driver_name();
+	print_homonym_string();
+
+	return 0;
+}
+static const struct kernel_param_ops print_debug_ops = {
+	.set = print_debug_set,
+	.get = param_get_int,
+};
+module_param_cb(print_debug, &print_debug_ops, &print_debug, 0200);
+MODULE_PARM_DESC(print_debug, "print klp-convert debugging info");
+
+/*
+ * saved_command_line is a unique symbol, so the sympos annotation is
+ * optional.  Provide to test that sympos=0 works correctly.
+ */
+KLP_MODULE_RELOC(vmlinux) vmlinux_relocs[] = {
+	KLP_SYMPOS(saved_command_line, 0)
+};
+
+/*
+ * driver_name symbols can be found in vmlinux (multiple) and also
+ * test_klp_convert_mod, therefore the annotation is required to
+ * clarify that we want the one from test_klp_convert_mod.
+ *
+ * test_klp_convert_mod contains multiple homonym_string and
+ * get_homonym_string symbols, test resolving the first set here and
+ *  the others in test_klp_convert2.c
+ *
+ * test_klp_get_driver_name is a uniquely named symbol, test that sympos=0
+ * work correctly.
+ */
+KLP_MODULE_RELOC(test_klp_convert_mod) test_klp_convert_mod_relocs_a[] = {
+	KLP_SYMPOS(driver_name, 0),
+	KLP_SYMPOS(homonym_string, 1),
+	KLP_SYMPOS(get_homonym_string, 1),
+	KLP_SYMPOS(test_klp_get_driver_name, 0),
+};
+
+static struct klp_func funcs[] = {
+	{
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	},
+	{
+		.name = "test_klp_convert_mod",
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_convert_init(void)
+{
+	int ret;
+
+	ret = klp_enable_patch(&patch);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void test_klp_convert_exit(void)
+{
+}
+
+module_init(test_klp_convert_init);
+module_exit(test_klp_convert_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: klp-convert1");
+MODULE_INFO(livepatch, "Y");
diff --git a/lib/livepatch/test_klp_convert2.c b/lib/livepatch/test_klp_convert2.c
new file mode 100644
index 000000000000..2a2a153aa0b9
--- /dev/null
+++ b/lib/livepatch/test_klp_convert2.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/livepatch.h>
+#include "test_klp_convert.h"
+
+static noinline void print_saved_command_line(void)
+{
+	pr_info("saved_command_line (auto): %s\n", saved_command_line);
+}
+
+static noinline void print_driver_name(void)
+{
+	pr_info("driver_name, 0: %s\n", driver_name);
+	pr_info("test_klp_get_driver_name(), (auto): %s\n", test_klp_get_driver_name());
+}
+
+static noinline void print_homonym_string(void)
+{
+	pr_info("homonym_string, 2: %s\n", homonym_string);
+	pr_info("get_homonym_string(), 2: %s\n", get_homonym_string());
+}
+
+/* provide a sysfs handle to invoke debug functions */
+static int print_debug;
+static int print_debug_set(const char *val, const struct kernel_param *kp)
+{
+	print_saved_command_line();
+	print_driver_name();
+	print_homonym_string();
+
+	return 0;
+}
+static const struct kernel_param_ops print_debug_ops = {
+	.set = print_debug_set,
+	.get = param_get_int,
+};
+module_param_cb(print_debug, &print_debug_ops, &print_debug, 0200);
+MODULE_PARM_DESC(print_debug, "print klp-convert debugging info");
+
+/*
+ * saved_command_line is a uniquely named symbol, so the sympos
+ * annotation is optional.  Skip it and test that klp-convert can
+ * resolve the symbol on its own.
+ */
+
+/*
+ * driver_name symbols can be found in vmlinux (multiple) and also
+ * test_klp_convert_mod, therefore the annotation is required to
+ * clarify that we want the one from test_klp_convert_mod.
+ *
+ * test_klp_convert_mod contains multiple homonym_string symbols,
+ * test_klp_convert1.c resolved to the first one, resolve to the
+ * second one here.
+ *
+ * test_klp_get_driver_name is a uniquely named symbol, test klp-convert can
+ * resolve it automatically.
+ */
+KLP_MODULE_RELOC(test_klp_convert_mod) test_klp_convert_mod_relocs_a[] = {
+	KLP_SYMPOS(driver_name, 0),
+	KLP_SYMPOS(homonym_string, 2),
+	KLP_SYMPOS(get_homonym_string, 2),
+};
+
+static struct klp_func funcs[] = {
+	{
+	}, { }
+};
+
+static struct klp_object objs[] = {
+	{
+		/* name being NULL means vmlinux */
+		.funcs = funcs,
+	},
+	{
+		.name = "test_klp_convert_mod",
+		.funcs = funcs,
+	}, { }
+};
+
+static struct klp_patch patch = {
+	.mod = THIS_MODULE,
+	.objs = objs,
+};
+
+static int test_klp_convert_init(void)
+{
+	int ret;
+
+	ret = klp_enable_patch(&patch);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void test_klp_convert_exit(void)
+{
+}
+
+module_init(test_klp_convert_init);
+module_exit(test_klp_convert_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: klp-convert2");
+MODULE_INFO(livepatch, "Y");
diff --git a/lib/livepatch/test_klp_convert_mod_a.c b/lib/livepatch/test_klp_convert_mod_a.c
new file mode 100644
index 000000000000..ae5e911fbb9b
--- /dev/null
+++ b/lib/livepatch/test_klp_convert_mod_a.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/* Unique symbols that don't need sympos annotation */
+static const char driver_name[] = KBUILD_MODNAME;
+__used static const char *test_klp_get_driver_name(void)
+{
+	return driver_name;
+}
+
+/* Common symbol names that need sympos */
+static const char homonym_string[] = "homonym string A";
+__used static const char *get_homonym_string(void)
+{
+	return homonym_string;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joe Lawrence <joe.lawrence@redhat.com>");
+MODULE_DESCRIPTION("Livepatch test: klp-convert module");
diff --git a/lib/livepatch/test_klp_convert_mod_b.c b/lib/livepatch/test_klp_convert_mod_b.c
new file mode 100644
index 000000000000..5eca8a4cae38
--- /dev/null
+++ b/lib/livepatch/test_klp_convert_mod_b.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+/*
+ * A second compilation unit to provide another set of similarly named
+ * symbols, forcing a livepatch to use sympos annotations.
+ */
+
+static const char homonym_string[] = "homonym string B";
+__used static const char *get_homonym_string(void)
+{
+	return homonym_string;
+}
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index 5fe79ac34be1..25c21ddf30f0 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -6,6 +6,10 @@
 
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_REPLACE=test_klp_atomic_replace
+MOD_KLP_CONVERT_MOD=test_klp_convert_mod
+MOD_KLP_CONVERT1=test_klp_convert1
+MOD_KLP_CONVERT2=test_klp_convert2
+MOD_KLP_CONVERT_SECTIONS=test_klp_convert_sections
 
 setup_config
 
@@ -159,4 +163,134 @@ livepatch: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE"
 
 
+# TEST: klp-convert symbols
+# - load a livepatch that modifies the output from /proc/cmdline
+#   including a reference to vmlinux-local symbol that klp-convert
+#   will process
+# - verify correct behavior
+# - unload the livepatch and make sure the patch was removed
+
+start_test "klp-convert symbols"
+
+saved_cmdline=$(cat /proc/cmdline)
+
+load_mod $MOD_KLP_CONVERT_MOD
+
+load_lp $MOD_KLP_CONVERT1
+echo 1 > /sys/module/$MOD_KLP_CONVERT1/parameters/print_debug
+disable_lp $MOD_KLP_CONVERT1
+unload_lp $MOD_KLP_CONVERT1
+
+load_lp $MOD_KLP_CONVERT2
+echo 1 > /sys/module/$MOD_KLP_CONVERT2/parameters/print_debug
+disable_lp $MOD_KLP_CONVERT2
+unload_lp $MOD_KLP_CONVERT2
+
+unload_mod $MOD_KLP_CONVERT_MOD
+
+check_result "% modprobe $MOD_KLP_CONVERT_MOD
+% modprobe $MOD_KLP_CONVERT1
+livepatch: enabling patch '$MOD_KLP_CONVERT1'
+livepatch: '$MOD_KLP_CONVERT1': initializing patching transition
+livepatch: '$MOD_KLP_CONVERT1': starting patching transition
+livepatch: '$MOD_KLP_CONVERT1': completing patching transition
+livepatch: '$MOD_KLP_CONVERT1': patching complete
+$MOD_KLP_CONVERT1: saved_command_line, 0: $saved_cmdline
+$MOD_KLP_CONVERT1: driver_name, 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT1: test_klp_get_driver_name(), 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT1: homonym_string, 1: homonym string A
+$MOD_KLP_CONVERT1: get_homonym_string(), 1: homonym string A
+% echo 0 > /sys/kernel/livepatch/$MOD_KLP_CONVERT1/enabled
+livepatch: '$MOD_KLP_CONVERT1': initializing unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': starting unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': completing unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': unpatching complete
+% rmmod $MOD_KLP_CONVERT1
+% modprobe $MOD_KLP_CONVERT2
+livepatch: enabling patch '$MOD_KLP_CONVERT2'
+livepatch: '$MOD_KLP_CONVERT2': initializing patching transition
+livepatch: '$MOD_KLP_CONVERT2': starting patching transition
+livepatch: '$MOD_KLP_CONVERT2': completing patching transition
+livepatch: '$MOD_KLP_CONVERT2': patching complete
+$MOD_KLP_CONVERT2: saved_command_line (auto): $saved_cmdline
+$MOD_KLP_CONVERT2: driver_name, 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT2: test_klp_get_driver_name(), (auto): $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT2: homonym_string, 2: homonym string B
+$MOD_KLP_CONVERT2: get_homonym_string(), 2: homonym string B
+% echo 0 > /sys/kernel/livepatch/$MOD_KLP_CONVERT2/enabled
+livepatch: '$MOD_KLP_CONVERT2': initializing unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': starting unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': completing unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': unpatching complete
+% rmmod $MOD_KLP_CONVERT2
+% rmmod $MOD_KLP_CONVERT_MOD"
+
+
+# TEST: klp-convert symbols (late module patching)
+# - load a livepatch that modifies the output from /proc/cmdline
+#   including a reference to vmlinux-local symbol that klp-convert
+#   will process
+# - load target module
+# - verify correct behavior
+# - unload the livepatch
+
+start_test "klp-convert symbols (late module patching)"
+
+saved_cmdline=$(cat /proc/cmdline)
+
+load_lp $MOD_KLP_CONVERT1
+load_mod $MOD_KLP_CONVERT_MOD
+echo 1 > /sys/module/$MOD_KLP_CONVERT1/parameters/print_debug
+disable_lp $MOD_KLP_CONVERT1
+unload_lp $MOD_KLP_CONVERT1
+unload_mod $MOD_KLP_CONVERT_MOD
+
+load_lp $MOD_KLP_CONVERT2
+load_mod $MOD_KLP_CONVERT_MOD
+echo 1 > /sys/module/$MOD_KLP_CONVERT2/parameters/print_debug
+disable_lp $MOD_KLP_CONVERT2
+unload_lp $MOD_KLP_CONVERT2
+unload_mod $MOD_KLP_CONVERT_MOD
+
+check_result "% modprobe $MOD_KLP_CONVERT1
+livepatch: enabling patch '$MOD_KLP_CONVERT1'
+livepatch: '$MOD_KLP_CONVERT1': initializing patching transition
+livepatch: '$MOD_KLP_CONVERT1': starting patching transition
+livepatch: '$MOD_KLP_CONVERT1': completing patching transition
+livepatch: '$MOD_KLP_CONVERT1': patching complete
+% modprobe $MOD_KLP_CONVERT_MOD
+livepatch: applying patch '$MOD_KLP_CONVERT1' to loading module '$MOD_KLP_CONVERT_MOD'
+$MOD_KLP_CONVERT1: saved_command_line, 0: $saved_cmdline
+$MOD_KLP_CONVERT1: driver_name, 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT1: test_klp_get_driver_name(), 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT1: homonym_string, 1: homonym string A
+$MOD_KLP_CONVERT1: get_homonym_string(), 1: homonym string A
+% echo 0 > /sys/kernel/livepatch/$MOD_KLP_CONVERT1/enabled
+livepatch: '$MOD_KLP_CONVERT1': initializing unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': starting unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': completing unpatching transition
+livepatch: '$MOD_KLP_CONVERT1': unpatching complete
+% rmmod $MOD_KLP_CONVERT1
+% rmmod $MOD_KLP_CONVERT_MOD
+% modprobe $MOD_KLP_CONVERT2
+livepatch: enabling patch '$MOD_KLP_CONVERT2'
+livepatch: '$MOD_KLP_CONVERT2': initializing patching transition
+livepatch: '$MOD_KLP_CONVERT2': starting patching transition
+livepatch: '$MOD_KLP_CONVERT2': completing patching transition
+livepatch: '$MOD_KLP_CONVERT2': patching complete
+% modprobe $MOD_KLP_CONVERT_MOD
+livepatch: applying patch '$MOD_KLP_CONVERT2' to loading module '$MOD_KLP_CONVERT_MOD'
+$MOD_KLP_CONVERT2: saved_command_line (auto): $saved_cmdline
+$MOD_KLP_CONVERT2: driver_name, 0: $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT2: test_klp_get_driver_name(), (auto): $MOD_KLP_CONVERT_MOD
+$MOD_KLP_CONVERT2: homonym_string, 2: homonym string B
+$MOD_KLP_CONVERT2: get_homonym_string(), 2: homonym string B
+% echo 0 > /sys/kernel/livepatch/$MOD_KLP_CONVERT2/enabled
+livepatch: '$MOD_KLP_CONVERT2': initializing unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': starting unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': completing unpatching transition
+livepatch: '$MOD_KLP_CONVERT2': unpatching complete
+% rmmod $MOD_KLP_CONVERT2
+% rmmod $MOD_KLP_CONVERT_MOD"
+
 exit 0
-- 
2.39.2

