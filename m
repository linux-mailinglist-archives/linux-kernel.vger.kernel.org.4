Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331AB733990
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346063AbjFPTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjFPTRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9D83AB2;
        Fri, 16 Jun 2023 12:17:03 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHVdTSaVdMapWJkyBap1QgqznetP5zCVCT8vVK0NQUQ=;
        b=Tt2zlIxha+9ezDbLv98AgE4JPq0j2+HKdG67XRa7saKjJX3VySO60Fg6xP78C/Q6L0JfTQ
        Y5mji+2razBLEiWHa8D+bwUYiEisEa4ZwF1acNH6Bf8EWfIMjaE+uFFkeNfbheXyJcPYK8
        TRfn8lzenTQpVQ/HdvkSm4U6jHLudJUl+L2ICmNrGUleFn2uZV1vvXm6WgUYbC0IgRRQ5N
        tuROmIyV7I4zVINwZgzy4zls5KxPH98J19cJFXMmrWAKsGIkmD5lpyJYcCf8ti0EbugmcM
        r/ASzYQSVitOHU8fQtjIHrB/nzig6MT5NlqDoQeDo8zSc8pJbPj9Jpj76OlHBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tHVdTSaVdMapWJkyBap1QgqznetP5zCVCT8vVK0NQUQ=;
        b=NJrhgqdx9w3BrgvZWNhdjMxjk89j91xb99wZIro+jS0o9Tld9aUKLCsyDtJc4reZYQEGLn
        tbz4ZxEFYQoQuMBg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Add guard pages around a shadow stack.
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302138.404.11297284047431641937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     663a99a7976ee9718c596ea6c632c8c95e779519
Gitweb:        https://git.kernel.org/tip/663a99a7976ee9718c596ea6c632c8c95e779519
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:42 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:33 -07:00

mm: Add guard pages around a shadow stack.

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

The architecture of shadow stack constrains the ability of userspace to
move the shadow stack pointer (SSP) in order to prevent corrupting or
switching to other shadow stacks. The RSTORSSP instruction can move the
SSP to different shadow stacks, but it requires a specially placed token
in order to do this. However, the architecture does not prevent
incrementing the stack pointer to wander onto an adjacent shadow stack. To
prevent this in software, enforce guard pages at the beginning of shadow
stack VMAs, such that there will always be a gap between adjacent shadow
stacks.

Make the gap big enough so that no userspace SSP changing operations
(besides RSTORSSP), can move the SSP from one stack to the next. The
SSP can be incremented or decremented by CALL, RET  and INCSSP. CALL and
RET can move the SSP by a maximum of 8 bytes, at which point the shadow
stack would be accessed.

The INCSSP instruction can also increment the shadow stack pointer. It
is the shadow stack analog of an instruction like:

        addq    $0x80, %rsp

However, there is one important difference between an ADD on %rsp and
INCSSP. In addition to modifying SSP, INCSSP also reads from the memory
of the first and last elements that were "popped". It can be thought of
as acting like this:

READ_ONCE(ssp);       // read+discard top element on stack
ssp += nr_to_pop * 8; // move the shadow stack
READ_ONCE(ssp-8);     // read+discard last popped stack element

The maximum distance INCSSP can move the SSP is 2040 bytes, before it
would read the memory. Therefore, a single page gap will be enough to
prevent any operation from shifting the SSP to an adjacent stack, since
it would have to land in the gap at least once, causing a fault.

This could be accomplished by using VM_GROWSDOWN, but this has a
downside. The behavior would allow shadow stacks to grow, which is
unneeded and adds a strange difference to how most regular stacks work.

In the maple tree code, there is some logic for retrying the unmapped
area search if a guard gap is violated. This retry should happen for
shadow stack guard gap violations as well. This logic currently only
checks for VM_GROWSDOWN for start gaps. Since shadow stacks also have
a start gap as well, create an new define VM_STARTGAP_FLAGS to hold
all the VM flag bits that have start gaps, and make mmap use it.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-17-rick.p.edgecombe%40intel.com
---
 include/linux/mm.h | 54 ++++++++++++++++++++++++++++++++++++++++-----
 mm/mmap.c          |  4 +--
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index fb17cbd..535c58d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -342,7 +342,36 @@ extern unsigned int kobjsize(const void *objp);
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
-# define VM_SHADOW_STACK	VM_HIGH_ARCH_5 /* Should not be set with VM_SHARED */
+/*
+ * This flag should not be set with VM_SHARED because of lack of support
+ * core mm. It will also get a guard page. This helps userspace protect
+ * itself from attacks. The reasoning is as follows:
+ *
+ * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
+ * INCSSP instruction can increment the shadow stack pointer. It is the
+ * shadow stack analog of an instruction like:
+ *
+ *   addq $0x80, %rsp
+ *
+ * However, there is one important difference between an ADD on %rsp
+ * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
+ * memory of the first and last elements that were "popped". It can be
+ * thought of as acting like this:
+ *
+ * READ_ONCE(ssp);       // read+discard top element on stack
+ * ssp += nr_to_pop * 8; // move the shadow stack
+ * READ_ONCE(ssp-8);     // read+discard last popped stack element
+ *
+ * The maximum distance INCSSP can move the SSP is 2040 bytes, before
+ * it would read the memory. Therefore a single page gap will be enough
+ * to prevent any operation from shifting the SSP to an adjacent stack,
+ * since it would have to land in the gap at least once, causing a
+ * fault.
+ *
+ * Prevent using INCSSP to move the SSP between shadow stacks by
+ * having a PAGE_SIZE guard gap.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
 #else
 # define VM_SHADOW_STACK	VM_NONE
 #endif
@@ -405,6 +434,8 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
 #endif
 
+#define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
+
 #ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK	VM_GROWSUP
 #else
@@ -3235,15 +3266,26 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
 	return mtree_load(&mm->mm_mt, addr);
 }
 
+static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & VM_GROWSDOWN)
+		return stack_guard_gap;
+
+	/* See reasoning around the VM_SHADOW_STACK definition */
+	if (vma->vm_flags & VM_SHADOW_STACK)
+		return PAGE_SIZE;
+
+	return 0;
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
+	unsigned long gap = stack_guard_start_gap(vma);
 	unsigned long vm_start = vma->vm_start;
 
-	if (vma->vm_flags & VM_GROWSDOWN) {
-		vm_start -= stack_guard_gap;
-		if (vm_start > vma->vm_start)
-			vm_start = 0;
-	}
+	vm_start -= gap;
+	if (vm_start > vma->vm_start)
+		vm_start = 0;
 	return vm_start;
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index afdf5f7..d479360 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1570,7 +1570,7 @@ retry:
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
 	tmp = mas_next(&mas, ULONG_MAX);
-	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
 		if (vm_start_gap(tmp) < gap + length - 1) {
 			low_limit = tmp->vm_end;
 			mas_reset(&mas);
@@ -1622,7 +1622,7 @@ retry:
 	gap -= (gap - info->align_offset) & info->align_mask;
 	gap_end = mas.last;
 	tmp = mas_next(&mas, ULONG_MAX);
-	if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) { /* Avoid prev check if possible */
+	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
 		if (vm_start_gap(tmp) <= gap_end) {
 			high_limit = vm_start_gap(tmp);
 			mas_reset(&mas);
