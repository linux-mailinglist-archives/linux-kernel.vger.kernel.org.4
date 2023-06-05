Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013F72288D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjFEOPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjFEOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:14:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE0E5E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:13:52 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89EF01EC0645;
        Mon,  5 Jun 2023 16:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685974420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhyAZLEUyE1A2LYVBDZDDCS94zaRZtJ6Q0ck7+veq5o=;
        b=M8os/lB5hFhUZ2O2UhLjGnoWNWEBICJ6j2vNJRaPePD5/W9t25vOSNShyhTbZ/bHpp/kDx
        AjzE7ykhqBpUsXIVQrGwy0CwDbd76L2oV3Te26dSreWiitqXonu7nKTTOJgXqU8XNkDOyc
        Jy+qIgZPX5yebRA8B3Uh8m7ppvwxsWE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Date:   Mon,  5 Jun 2023 16:13:32 +0200
Message-Id: <20230605141332.25948-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230605141332.25948-1-bp@alien8.de>
References: <20230605141332.25948-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

It will be used to control microcode loader behavior. Add the first
chicken bit: to control whether the AMD side should load microcode late
on all logical SMT threads.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 arch/x86/kernel/cpu/microcode/amd.c           |  5 ++-
 arch/x86/kernel/cpu/microcode/core.c          | 44 +++++++++++++++++++
 arch/x86/kernel/cpu/microcode/internal.h      | 16 +++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/microcode/internal.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..b88ff022402c 100644
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
index 87208e46f7ed..76b530697951 100644
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
index 3afcf3de0dd4..5f3185d2814c 100644
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
index 000000000000..5e3c5fc3851f
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
-- 
2.35.1

