Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E408672BC46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjFLJ1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjFLJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:26:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7644B7;
        Mon, 12 Jun 2023 02:20:32 -0700 (PDT)
Date:   Mon, 12 Jun 2023 09:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686561630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KgXB4wJLlgssofluB7u2dvkHMqsZiOXCz9D9xcZ48=;
        b=RMjP6Qmzg52VUlHvm4UA6ucKB/GD/YAfMUf8MPEZudYERla/vK4DEoeiZTf1P0cR/PHC4H
        FA17avXC9ijcmKnqViwhrv2WTcvGSb84eG0ZYdq3Mw/nUT0fvZBd/BJJG98Q+2IaUQXb+r
        gddr4ybTjKBxwQhMYbH71zfWLZs3X9CEYcC6sy3CGjDUcU1BkrebI1jBs/yDAFLCavvPbc
        0WXyO+5uVLR3F34R9YD55QXmXZqKYNUnZkapNu05VT2mIhRzKgsD7NUBNadFj31KnDXB7i
        rb3NoreGuA8djDnOPZcQ4mxOyvIWRPVrTfyyKe4NioNwjOsMMRG1IpDa5+Hrzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686561630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I5KgXB4wJLlgssofluB7u2dvkHMqsZiOXCz9D9xcZ48=;
        b=h8VjlF5aQ29oldHSUKV3lvM21tViNK4aRrvL6LjEXkitW+hdoMvBcapC6os5c+mby9qjwV
        yMbdDKW/0Zd86xBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add a "microcode=" command line option
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230605141332.25948-2-bp@alien8.de>
References: <20230605141332.25948-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <168656162970.404.6477920187705031691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4a7349239418d78193e8d328f5eebd14a3f77bcd
Gitweb:        https://git.kernel.org/tip/4a7349239418d78193e8d328f5eebd14a3f77bcd
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 18 May 2023 03:02:29 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jun 2023 11:02:52 +02:00

x86/microcode: Add a "microcode=" command line option

It will be used to control microcode loader behavior. Add the first
chicken bit: to control whether the AMD side should load microcode late
on all logical SMT threads.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230605141332.25948-2-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++-
 arch/x86/kernel/cpu/microcode/amd.c             |  5 +-
 arch/x86/kernel/cpu/microcode/core.c            | 44 ++++++++++++++++-
 arch/x86/kernel/cpu/microcode/internal.h        | 16 ++++++-
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/internal.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab2..b88ff02 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3228,6 +3228,13 @@
 
 	mga=		[HW,DRM]
 
+	microcode=	[X86] Control the behavior of the microcode
+			loader. Available options:
+
+			no_late_all - do not load on all SMT threads on
+			AMD. Loading on all logical threads is enabled by
+			default.
+
 	min_addr=nn[KMG]	[KNL,BOOT,IA-64] All physical memory below this
 			physical address is ignored.
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 87208e4..76b5306 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -36,6 +36,8 @@
 #include <asm/cpu.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 static struct equiv_cpu_table {
 	unsigned int num_entries;
 	struct equiv_cpu_entry *entry;
@@ -700,7 +702,8 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev > mc_amd->hdr.patch_id) {
+	if ((rev > mc_amd->hdr.patch_id) ||
+	    (rev == mc_amd->hdr.patch_id && !(control & LATE_ALL_THREADS))) {
 		ret = UCODE_OK;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3d..5f3185d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -40,11 +40,15 @@
 #include <asm/cmdline.h>
 #include <asm/setup.h>
 
+#include "internal.h"
+
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
 static bool dis_ucode_ldr = true;
 
+unsigned long control = LATE_ALL_THREADS;
+
 bool initrd_gone;
 
 LIST_HEAD(microcode_cache);
@@ -522,8 +526,32 @@ static ssize_t processor_flags_show(struct device *dev,
 	return sprintf(buf, "0x%x\n", uci->cpu_sig.pf);
 }
 
+static ssize_t control_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%lx\n", control);
+}
+
+static ssize_t control_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) < 0)
+		return -ERANGE;
+
+	if (val & CONTROL_FLAGS_MASK)
+		return -EINVAL;
+
+	control = val;
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(processor_flags);
+static DEVICE_ATTR_ADMIN_RW(control);
 
 static struct attribute *mc_default_attrs[] = {
 	&dev_attr_version.attr,
@@ -622,6 +650,7 @@ static struct attribute *cpu_root_microcode_attrs[] = {
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 	&dev_attr_reload.attr,
 #endif
+	&dev_attr_control.attr,
 	NULL
 };
 
@@ -683,3 +712,18 @@ static int __init microcode_init(void)
 }
 fs_initcall(save_microcode_in_initrd);
 late_initcall(microcode_init);
+
+static int __init parse_cmdline_param(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (*str == '=')
+		str++;
+
+	if (!strcmp(str, "no_late_all"))
+		control &= ~LATE_ALL_THREADS;
+
+        return 1;
+}
+__setup("microcode", parse_cmdline_param);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
new file mode 100644
index 0000000..5e3c5fc
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_MICROCODE_INTERNAL_H__
+#define __X86_MICROCODE_INTERNAL_H__
+
+extern unsigned long control;
+
+/* Loader control flags. */
+enum control_flags {
+	__LATE_ALL_THREADS = 0,
+	__CONTROL_FLAGS_NUM,
+};
+
+#define LATE_ALL_THREADS	BIT_ULL(__LATE_ALL_THREADS)
+#define CONTROL_FLAGS_MASK	~(BIT_ULL(__CONTROL_FLAGS_NUM) - 1)
+
+#endif /* __X86_MICROCODE_INTERNAL_H__ */
