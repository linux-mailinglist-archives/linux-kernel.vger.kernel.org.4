Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5612C62A1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKOS7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiKOS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:59:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562C2FFC0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:59:25 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7da329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7da:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9AC311EC02F2;
        Tue, 15 Nov 2022 19:59:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668538763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IacwkbhdN/LhGPPvjCLN9M6FMDSFf7smFpXaP7guy/E=;
        b=mMb3jQQSCPq20fDxuJTXD4V7A/6mR05h77TJ1TQ5CY7/pZtf0amuHu/am0U4dRP5QcoXST
        PKfabjyuHoPlBYxbDCL6IqjzKuGTfxF+kbombXJrEYxTFy+OFlgBzwxkr19AMf2NlN/+hh
        PAnR5nVvK+ExS1sShzUacpbPD4nvkik=
Date:   Tue, 15 Nov 2022 19:59:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 1/2] x86/boot: Add a function for kernel command line
 preparation
Message-ID: <Y3Phi9mO2KSA0AkM@zn.tnic>
References: <cover.1668082601.git.baskov@ispras.ru>
 <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
 <Y3JQpxi6XDkPViBr@zn.tnic>
 <Y3PhYRx9aAYsdvMQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3PhYRx9aAYsdvMQ@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Date: Mon, 14 Nov 2022 15:31:59 +0100

Since both the compressed kernel and kernel proper need to deal with the
command line, add a common helper which abstracts away all the details.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/shared/cmdline.h | 34 +++++++++++++++++++++++++++
 arch/x86/kernel/setup.c               | 21 +++--------------
 2 files changed, 37 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/cmdline.h

diff --git a/arch/x86/include/asm/shared/cmdline.h b/arch/x86/include/asm/shared/cmdline.h
new file mode 100644
index 000000000000..e09c06338567
--- /dev/null
+++ b/arch/x86/include/asm/shared/cmdline.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SHARED_CMDLINE_H
+#define _ASM_X86_SHARED_CMDLINE_H
+
+#ifdef CONFIG_CMDLINE_BOOL
+#define BUILTIN_CMDLINE CONFIG_CMDLINE
+#else
+#define BUILTIN_CMDLINE ""
+#endif
+
+static inline void cmdline_prepare(char *dst,
+                                   const char *builtin_cmdline,
+                                   char *boot_command_line)
+{
+	/* Depends on CONFIG_CMDLINE_BOOL, overwrite with builtin cmdline */
+	if (IS_ENABLED(CONFIG_CMDLINE_OVERRIDE))
+		strscpy(dst, builtin_cmdline, COMMAND_LINE_SIZE);
+	else if (IS_ENABLED(CONFIG_CMDLINE_BOOL)) {
+		if (builtin_cmdline[0]) {
+			/* Add builtin cmdline */
+			strlcat(dst, builtin_cmdline, COMMAND_LINE_SIZE);
+			strlcat(dst, " ", COMMAND_LINE_SIZE);
+			/* Add boot cmdline */
+			strlcat(dst, boot_command_line, COMMAND_LINE_SIZE);
+		}
+	} else {
+		strscpy(dst, boot_command_line, COMMAND_LINE_SIZE);
+	}
+
+	/* Copy back into boot command line, see setup_command_line() */
+	strscpy(boot_command_line, dst, COMMAND_LINE_SIZE);
+}
+
+#endif /* _ASM_X86_SHARED_CMDLINE_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index aacaa96f0195..c506807142a7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -25,6 +25,7 @@
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
 #include <linux/random.h>
+#include <linux/vmalloc.h>
 
 #include <uapi/linux/mount.h>
 
@@ -50,10 +51,10 @@
 #include <asm/pci-direct.h>
 #include <asm/prom.h>
 #include <asm/proto.h>
+#include <asm/shared/cmdline.h>
 #include <asm/thermal.h>
 #include <asm/unwind.h>
 #include <asm/vsyscall.h>
-#include <linux/vmalloc.h>
 
 /*
  * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
@@ -168,9 +169,6 @@ unsigned long saved_video_mode;
 #define RAMDISK_LOAD_FLAG		0x4000
 
 static char __initdata command_line[COMMAND_LINE_SIZE];
-#ifdef CONFIG_CMDLINE_BOOL
-static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
-#endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 struct edd edd;
@@ -970,20 +968,7 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = __pa_symbol(__bss_start);
 	bss_resource.end = __pa_symbol(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_BOOL
-#ifdef CONFIG_CMDLINE_OVERRIDE
-	strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-#else
-	if (builtin_cmdline[0]) {
-		/* append boot loader cmdline to builtin */
-		strlcat(builtin_cmdline, " ", COMMAND_LINE_SIZE);
-		strlcat(builtin_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-		strscpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
-	}
-#endif
-#endif
-
-	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+	cmdline_prepare(command_line, BUILTIN_CMDLINE, boot_command_line);
 	*cmdline_p = command_line;
 
 	/*
-- 
2.35.1


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
