Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714C77297EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbjFILNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjFILNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:13:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417E210E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:13:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A476721A1B;
        Fri,  9 Jun 2023 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686309195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7GTMhjbKkfMR0diFswT0M7pEjVhfOQYpv6YQslqR+6M=;
        b=kymnpBYGPFy89uI8Qf3O6etFmzQJob7m/mV8aFmzGVcrsZAQssq6bP9WrHbkxiiCsoQwXi
        GUvUOJ8cwgSvtfHH19j1APshDMvhRQwh1Veog34mfb7RWL2tTNZnwjAMe2xQ99/zw+1zCe
        loCXjPEuk8NJJIf2FxZJjMOZp6c3Yro=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC41139C8;
        Fri,  9 Jun 2023 11:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qDiMEEsJg2ReIwAAMHmgww
        (envelope-from <nik.borisov@suse.com>); Fri, 09 Jun 2023 11:13:15 +0000
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 2/4] x86/entry: Rename ignore_sysret and compile it unconditionally
Date:   Fri,  9 Jun 2023 14:13:09 +0300
Message-Id: <20230609111311.4110901-3-nik.borisov@suse.com>
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

Give ignore_sysret a more descriptive name as it's actually used to make
32bit syscalls a noop and return ENOSYS, rather than doing anything
special to sysret. While at it also compile the function unconditinally
as this is going to be used in the patch disabling ia32 syscalls due to
'ia32_disabled' parameter.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/entry_64.S        | 6 ++----
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/common.c     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f31e286c2977..7068af44008a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1514,18 +1514,16 @@ SYM_CODE_START(asm_exc_nmi)
 	iretq
 SYM_CODE_END(asm_exc_nmi)
 
-#ifndef CONFIG_IA32_EMULATION
 /*
  * This handles SYSCALL from 32-bit code.  There is no way to program
  * MSRs to fully disable 32-bit SYSCALL.
  */
-SYM_CODE_START(ignore_sysret)
+SYM_CODE_START(entry_SYSCALL32_ignore)
 	UNWIND_HINT_END_OF_STACK
 	ENDBR
 	mov	$-ENOSYS, %eax
 	sysretl
-SYM_CODE_END(ignore_sysret)
-#endif
+SYM_CODE_END(entry_SYSCALL32_ignore)
 
 .pushsection .text, "ax"
 	__FUNC_ALIGN
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a1e4fa58b357..61c10b4e3e35 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -399,7 +399,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-extern asmlinkage void ignore_sysret(void);
+extern asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 80710a68ef7d..b20774181e1a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2066,7 +2066,7 @@ void syscall_init(void)
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
-	wrmsrl_cstar((unsigned long)ignore_sysret);
+	wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
-- 
2.34.1

