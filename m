Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F526C1C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjCTQsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCTQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:47:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB8324BDB;
        Mon, 20 Mar 2023 09:41:05 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EMwbo40mW6Kw2OsQxhtv2HNQPJG0eaKiagWQexNa5M0=;
        b=1xN1mYsQ1DKWETMG2e8BP2Hl7ssNllOaWPyMcjmz2ai2VynAAKCGeCYRlye7tMaIltcK1Q
        edA9ktPm1O/8oi8UcAbfVh/7xbWeTi0HGoxGs5GMpBdnLkVNYIHuCM5TEErekTmthWSY9a
        qhoWRXWy4QToZFm0HM9LkuR7BQCf4dooF49qNJti5vDtFAJSHpb9tWtTlYEhdrFHBqzOwY
        vHvjRYqCWsVVJENECwlDjLM857BDtu+x9P1UXAx0D4RNQ1FZxRMe2Vo/5SuwYnkOEXq53A
        6oJ+hvvbKC3aHf90HQJ2k+p2R8R+ZK6PeodxHciE46sdZdtKrjLc2D0c4wu1Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EMwbo40mW6Kw2OsQxhtv2HNQPJG0eaKiagWQexNa5M0=;
        b=xtMJosj5pl5W/0D2JhR059e0doICXN3cR6c+qsiYjOeACD3EBDJx0wmG+EfIv5I3+2nRlf
        hRfzfqc8SyQMF7Aw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/mm: Check shadow stack page fault errors
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036601.5837.16483332538845960484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     3020efc57c33abbbae472514b22edc3ac76ad46e
Gitweb:        https://git.kernel.org/tip/3020efc57c33abbbae472514b22edc3ac76ad46e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:14 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:10 -07:00

x86/mm: Check shadow stack page fault errors

The CPU performs "shadow stack accesses" when it expects to encounter
shadow stack mappings. These accesses can be implicit (via CALL/RET
instructions) or explicit (instructions like WRSS).

Shadow stack accesses to shadow-stack mappings can result in faults in
normal, valid operation just like regular accesses to regular mappings.
Shadow stacks need some of the same features like delayed allocation, swap
and copy-on-write. The kernel needs to use faults to implement those
features.

The architecture has concepts of both shadow stack reads and shadow stack
writes. Any shadow stack access to non-shadow stack memory will generate
a fault with the shadow stack error code bit set.

This means that, unlike normal write protection, the fault handler needs
to create a type of memory that can be written to (with instructions that
generate shadow stack writes), even to fulfill a read access. So in the
case of COW memory, the COW needs to take place even with a shadow stack
read. Otherwise the page will be left (shadow stack) writable in
userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
for shadow stack accesses, even if the access was a shadow stack read.

For the purpose of making this clearer, consider the following example.
If a process has a shadow stack, and forks, the shadow stack PTEs will
become read-only due to COW. If the CPU in one process performs a shadow
stack read access to the shadow stack, for example executing a RET and
causing the CPU to read the shadow stack copy of the return address, then
in order for the fault to be resolved the PTE will need to be set with
shadow stack permissions. But then the memory would be changeable from
userspace (from CALL, RET, WRSS, etc). So this scenario needs to trigger
COW, otherwise the shared page would be changeable from both processes.

Shadow stack accesses can also result in errors, such as when a shadow
stack overflows, or if a shadow stack access occurs to a non-shadow-stack
mapping. Also, generate the errors for invalid shadow stack accesses.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230319001535.23210-20-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/trap_pf.h |  2 ++
 arch/x86/mm/fault.c            | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/trap_pf.h b/arch/x86/include/asm/trap_pf.h
index 10b1de5..afa5243 100644
--- a/arch/x86/include/asm/trap_pf.h
+++ b/arch/x86/include/asm/trap_pf.h
@@ -11,6 +11,7 @@
  *   bit 3 ==				1: use of reserved bit detected
  *   bit 4 ==				1: fault was an instruction fetch
  *   bit 5 ==				1: protection keys block access
+ *   bit 6 ==				1: shadow stack access fault
  *   bit 15 ==				1: SGX MMU page-fault
  */
 enum x86_pf_error_code {
@@ -20,6 +21,7 @@ enum x86_pf_error_code {
 	X86_PF_RSVD	=		1 << 3,
 	X86_PF_INSTR	=		1 << 4,
 	X86_PF_PK	=		1 << 5,
+	X86_PF_SHSTK	=		1 << 6,
 	X86_PF_SGX	=		1 << 15,
 };
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a498ae1..7beb0ba 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1117,8 +1117,22 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
+	/*
+	 * Shadow stack accesses (PF_SHSTK=1) are only permitted to
+	 * shadow stack VMAs. All other accesses result in an error.
+	 */
+	if (error_code & X86_PF_SHSTK) {
+		if (unlikely(!(vma->vm_flags & VM_SHADOW_STACK)))
+			return 1;
+		if (unlikely(!(vma->vm_flags & VM_WRITE)))
+			return 1;
+		return 0;
+	}
+
 	if (error_code & X86_PF_WRITE) {
 		/* write, present and write, not present: */
+		if (unlikely(vma->vm_flags & VM_SHADOW_STACK))
+			return 1;
 		if (unlikely(!(vma->vm_flags & VM_WRITE)))
 			return 1;
 		return 0;
@@ -1310,6 +1324,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
+	/*
+	 * Read-only permissions can not be expressed in shadow stack PTEs.
+	 * Treat all shadow stack accesses as WRITE faults. This ensures
+	 * that the MM will prepare everything (e.g., break COW) such that
+	 * maybe_mkwrite() can create a proper shadow stack PTE.
+	 */
+	if (error_code & X86_PF_SHSTK)
+		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
 	if (error_code & X86_PF_INSTR)
