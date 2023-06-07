Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D27255CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjFGHgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbjFGHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:34:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B4B1BE6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:29:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50D1F1FDAB;
        Wed,  7 Jun 2023 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686122982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fgln+qtfcOS9OaYmx79Yvw6h1nzJ4Orl6OHLx73NA9A=;
        b=QLIX0oZ2VqwvpnaHV3gS3aOGFzS/bYa/3bWLdKLxrfCbtNFSX6BA72rcW/4uanPoHK5DWL
        pIsghoCb+dq8MSnnEjb/LRbiCSVFXRTrs/SouG6t9hwtOgje6kOn9cIr7qJ+Nd6zd/Ctqq
        L8HY0N7nrYcsReRVMz1Xn65wbOFm/4U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0168413776;
        Wed,  7 Jun 2023 07:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AF1QOeUxgGSUIQAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Wed, 07 Jun 2023 07:29:41 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 2/3] x86/entry: Disable IA32 syscalls in the presence of ia32_disabled
Date:   Wed,  7 Jun 2023 10:29:35 +0300
Message-Id: <20230607072936.3766231-3-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607072936.3766231-1-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
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

First stage of disabling ia32 compat layer is to disable 32bit syscall
entry points. Legacy int 0x80 vector is disabled by setting its gate
descriptor to "not present" and the sysenter vector is disabled by
re-using the existing code in case IA32_EMULATION is disabled.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/entry_64.S    |  2 --
 arch/x86/include/asm/desc.h  |  5 +++++
 arch/x86/kernel/cpu/common.c | 29 ++++++++++++++++++-----------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f31e286c2977..5e0e8a5e05ca 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1514,7 +1514,6 @@ SYM_CODE_START(asm_exc_nmi)
 	iretq
 SYM_CODE_END(asm_exc_nmi)
 
-#ifndef CONFIG_IA32_EMULATION
 /*
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
@@ -1525,7 +1524,6 @@ SYM_CODE_START(ignore_sysret)
 	mov	$-ENOSYS, %eax
 	sysretl
 SYM_CODE_END(ignore_sysret)
-#endif
 
 .pushsection .text, "ax"
 	__FUNC_ALIGN
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22ac04a..618b428586d1 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -8,6 +8,7 @@
 #include <asm/fixmap.h>
 #include <asm/irq_vectors.h>
 #include <asm/cpu_entry_area.h>
+#include <asm/traps.h>
 
 #include <linux/debug_locks.h>
 #include <linux/smp.h>
@@ -429,6 +430,10 @@ static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
 	gate->offset_high	= (u32) (addr >> 32);
 	gate->reserved		= 0;
 #endif
+#ifdef CONFIG_IA32_EMULATION
+	if (ia32_disabled && d->vector == IA32_SYSCALL_VECTOR)
+		gate->bits.p = 0;
+#endif
 }
 
 extern unsigned long system_vectors[];
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a68ef7d..71f8b55f70c9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2054,17 +2054,24 @@ void syscall_init(void)
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 #ifdef CONFIG_IA32_EMULATION
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
+	if (ia32_disabled) {
+		wrmsrl_cstar((unsigned long)ignore_sysret);
+		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
+		wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
+		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
+	} else {
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
+	}
 #else
 	wrmsrl_cstar((unsigned long)ignore_sysret);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
-- 
2.34.1

