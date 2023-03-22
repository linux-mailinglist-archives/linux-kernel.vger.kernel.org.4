Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A075E6C51E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjCVRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCVREt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF9664C1;
        Wed, 22 Mar 2023 10:04:01 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pr1emCY0QATpNZW2xfHtncUuLHRp40r3mqoT3B56WhI=;
        b=1Og4YKI9KdUOl/x+FdtpEARyno1MugJHoj8VVs1M3C5Xfq2jFdLZ6Zv1pIwN5jkpmbACSK
        dnyBUNzlVzwVxYpwrpQQcI+d6vwxtDDPH5CfCtM76uHDHaPE7HdNe4yx58+yVlSivQNnnT
        b/s4zJAF4xTn98uDEuhp3qzxbKGW8GRnVFIVBGR4Cc7cx2WTl+sxBrw3rVfNF1e7FvVH39
        w3DXVA+7Ver0o5VZ1mTEY+V1FMaoNnD9yW5Dy1lQSMD+Mfn2d4axmwjTvZLDPTG/RZ8/cb
        1RRP0Q+vsQVGVj2HwuU6tC7GqramEDUVGemv2tHqD7LZBiWPuqYyG7LsPySabg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pr1emCY0QATpNZW2xfHtncUuLHRp40r3mqoT3B56WhI=;
        b=XF22txeVufV7LoP+SN+QLacx1ZkW6i5bNaK/NgGQEuCxnaqk0pdnP8ZiIzKgnDEdPGqALG
        58P47G9sHDE8GuCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86: Allow atomic MM_CONTEXT flags setting
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458866.5837.13516431668563411441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5ef495e55f07aa117fdd8e187c9901cefc02fe0a
Gitweb:        https://git.kernel.org/tip/5ef495e55f07aa117fdd8e187c9901cefc02fe0a
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:25:57 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:39 -07:00

x86: Allow atomic MM_CONTEXT flags setting

So far there's no need in atomic setting of MM context flags in
mm_context_t::flags. The flags set early in exec and never change
after that.

LAM enabling requires atomic flag setting. The upcoming flag
MM_CONTEXT_FORCE_TAGGED_SVA can be set much later in the process
lifetime where multiple threads exist.

Convert the field to unsigned long and do MM_CONTEXT_* accesses with
__set_bit() and test_bit().

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230312112612.31869-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 2 +-
 arch/x86/include/asm/mmu.h            | 6 +++---
 arch/x86/include/asm/mmu_context.h    | 2 +-
 arch/x86/kernel/process_64.c          | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index d234ca7..e0ca812 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -317,7 +317,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
+	if (!mm || !test_bit(MM_CONTEXT_HAS_VSYSCALL, &mm->context.flags))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d74946..efa3eae 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -9,9 +9,9 @@
 #include <linux/bits.h>
 
 /* Uprobes on this MM assume 32-bit code */
-#define MM_CONTEXT_UPROBE_IA32	BIT(0)
+#define MM_CONTEXT_UPROBE_IA32		0
 /* vsyscall page is accessible on this MM */
-#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
+#define MM_CONTEXT_HAS_VSYSCALL		1
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -39,7 +39,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	unsigned short flags;
+	unsigned long flags;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index e01aa74..b4e4a0c 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -182,7 +182,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
+		!test_bit(MM_CONTEXT_UPROBE_IA32, &mm->context.flags);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bb65a68..cd34bcf 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -671,7 +671,7 @@ void set_personality_64bit(void)
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
 	if (current->mm)
-		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
+		__set_bit(MM_CONTEXT_HAS_VSYSCALL, &current->mm->context.flags);
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -708,7 +708,7 @@ static void __set_personality_ia32(void)
 		 * uprobes applied to this MM need to know this and
 		 * cannot use user_64bit_mode() at that time.
 		 */
-		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+		__set_bit(MM_CONTEXT_UPROBE_IA32, &current->mm->context.flags);
 	}
 
 	current->personality |= force_personality32;
