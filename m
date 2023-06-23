Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F408973B5E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFWLOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFWLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:14:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B310A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:14:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DEB8A1F460;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687518855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aLQna3YJFjX1iJFd+SNHQelZENitCxnrAQsbOG2qcHg=;
        b=u7iPIm86sgf6oSpl6ZWKQB17ZciWaoZGOhEehOF/CjUorTnknsj2+Hs77nHqnF23PvNjO3
        +EuvqLgbfH5xFjccrouWQcgTrxeYK2y9K9jwUSvVLWZUHOs0A+Oy42tMBhgIDUZtX/JZbS
        voyvodtBDl5QUT6m1cxI0FN4zIjUNrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 887BF1331F;
        Fri, 23 Jun 2023 11:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EP+fHod+lWTcFAAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 23 Jun 2023 11:14:15 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mohocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v4 5/6] x86/entry: Make IA32 syscalls' availability depend on ia32_enabled()
Date:   Fri, 23 Jun 2023 14:14:08 +0300
Message-Id: <20230623111409.3047467-6-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623111409.3047467-1-nik.borisov@suse.com>
References: <20230623111409.3047467-1-nik.borisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another major aspect of supporting running of 32bit processes is the
ability to access 32bit syscalls. Such syscalls can be invoked by
using the legacy int 0x80 handler and  sysenter/syscall instructions.

If IA32 emulation is disabled ensure that each of those 3 distinct
mechanisms are also disabled. For int 0x80 a #GP exception would be
generated since the respective descriptor is not going to be loaded at
all. Invoking sysenter will also result in a #GP since IA32_SYSENTER_CS
contains an invalid segment. Finally, syscall instruction cannot really
be disabled so it's configured to execute a minimal handler.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/proto.h |  3 +++
 arch/x86/kernel/cpu/common.c | 37 ++++++++++++++++++------------------
 arch/x86/kernel/idt.c        |  7 +++++++
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 12ef86b19910..4d84122bd643 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -36,6 +36,9 @@ void entry_INT80_compat(void);
 #ifdef CONFIG_XEN_PV
 void xen_entry_INT80_compat(void);
 #endif
+#else /* !CONFIG_IA32_EMULATION */
+#define entry_SYSCALL_compat NULL
+#define entry_SYSENTER_compat NULL
 #endif
 
 void x86_configure_nx(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b20774181e1a..aafb83d1b3a7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -59,6 +59,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/ia32.h>
 #include <asm/sigframe.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
@@ -2053,24 +2054,24 @@ void syscall_init(void)
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
-#ifdef CONFIG_IA32_EMULATION
-	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
-	/*
-	 * This only works on Intel CPUs.
-	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
-	 * This does not cause SYSENTER to jump to the wrong location, because
-	 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
-	 */
-	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
-		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
-	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
-#else
-	wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
-	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
-	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
-#endif
+	if (ia32_enabled()) {
+		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
+		/*
+		 * This only works on Intel CPUs.
+		 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
+		 * This does not cause SYSENTER to jump to the wrong location, because
+		 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
+		 */
+		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
+		wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
+			    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
+		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
+	} else {
+		wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
+		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
+		wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
+		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
+	}
 
 	/*
 	 * Flags to clear on syscall; clear as much as possible
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..41f88da58502 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -10,6 +10,7 @@
 #include <asm/proto.h>
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 
 #define DPL0		0x0
@@ -116,6 +117,9 @@ static const __initconst struct idt_data def_idts[] = {
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
+};
+
+static const struct idt_data ia32_idt[] __initconst = {
 #if defined(CONFIG_IA32_EMULATION)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
 #elif defined(CONFIG_X86_32)
@@ -226,6 +230,9 @@ void __init idt_setup_early_traps(void)
 void __init idt_setup_traps(void)
 {
 	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
+
+	if (ia32_enabled())
+		idt_setup_from_table(idt_table, ia32_idt, ARRAY_SIZE(ia32_idt), true);
 }
 
 #ifdef CONFIG_X86_64
-- 
2.34.1

