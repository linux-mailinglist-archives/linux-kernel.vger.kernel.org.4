Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8347297EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbjFILNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbjFILNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:13:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083F2113
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:13:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19A471FDF2;
        Fri,  9 Jun 2023 11:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686309196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Bsnn3ZvwL3jkB5fYcFeMyxQu6CGb7wI0Eum5AnPafo=;
        b=OX/qyPwNWV6gO9OKITAPQ6wDiGhtagZFt2q2cnd2SnjCyQCU9/Mvy8PtfVp24tPkRlgJyl
        hFx+AWKfEROmKYu+Fxsa9plDRjd+O6JGg6bX/ZWk/FGek0TVSAhezsY+V+dvu2kyQuLoqe
        U0Qgt4ywpIUxQgS06NbhNoCWHV6kMJo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7508139C8;
        Fri,  9 Jun 2023 11:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GHgTKksJg2ReIwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 09 Jun 2023 11:13:15 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 3/4] x86/entry: Disable IA32 syscall if ia32_disabled is true
Date:   Fri,  9 Jun 2023 14:13:10 +0300
Message-Id: <20230609111311.4110901-4-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609111311.4110901-1-nik.borisov@suse.com>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
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
entry points. Legacy int 0x80 vector is disabled by zeroing out its gate
descriptor in the idt and the sysenter vector is disabled by re-using
the existing code in case IA32_EMULATION is disabled.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/desc.h  |  1 +
 arch/x86/kernel/cpu/common.c | 37 ++++++++++++++++++------------------
 arch/x86/kernel/idt.c        |  7 +++++++
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22ac04a..1182a5b10be9 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -8,6 +8,7 @@
 #include <asm/fixmap.h>
 #include <asm/irq_vectors.h>
 #include <asm/cpu_entry_area.h>
+#include <asm/traps.h>
 
 #include <linux/debug_locks.h>
 #include <linux/smp.h>
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b20774181e1a..3c4055184d0f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2053,24 +2053,25 @@ void syscall_init(void)
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
+	if ((IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) ||
+	    !IS_ENABLED(CONFIG_IA32_EMULATION)) {
+		wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
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
 
 	/*
 	 * Flags to clear on syscall; clear as much as possible
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..d1f388ef2e66 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -226,6 +226,13 @@ void __init idt_setup_early_traps(void)
 void __init idt_setup_traps(void)
 {
 	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
+
+	if (IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) {
+		gate_desc null_desc = {};
+		write_idt_entry(idt_table, IA32_SYSCALL_VECTOR, &null_desc);
+		clear_bit(IA32_SYSCALL_VECTOR, system_vectors);
+	}
+
 }
 
 #ifdef CONFIG_X86_64
-- 
2.34.1

