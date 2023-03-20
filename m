Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2414E6C1CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjCTQuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCTQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:49:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF9BFF0F;
        Mon, 20 Mar 2023 09:41:55 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tpyZsIq9SZQi89gEpV2Me6ofOXRaOfIhZIQD0jYJpAM=;
        b=beZfSDhtu+luBq9TYu2wYfi//SrhoQmDQkFrbbh2wW6vkL2nxCtER2RAKjvwN1w9NznAW1
        DwYiepiFSL/RCdC7S7bO4IxcHsK8TQ73gN70MfdiO1G11S7FDrJIxry1qEX9EDWZ6HSWTP
        KvW5FbsHqI5y0NINyPO/HGI+Kj4zvydQFmp9bj53voXIai1mkYmUcgCyC3wnOa73bY5PLH
        2JYsIoLlk5GwuC/oHgfSG9PcYPGAdhM57A38IBnY023PwIQfks3+ICvuTnw+awd+aWD3xx
        8lvH02T4PBPSmdJv4tiECZ9uc9tF41ZLqKBiEkZ9dFejJYVBDNTmjZduI5GyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tpyZsIq9SZQi89gEpV2Me6ofOXRaOfIhZIQD0jYJpAM=;
        b=sWTV/BvOZEDvhPQBmj5mhv/MQPwjKLfX3qBcFDYEFSIZvKHqAjljLS3jkxdsl7rVYv8s9d
        gWcg6yRNkDcpV7DA==
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
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036554.5837.4712461537546656961.tip-bot2@tip-bot2>
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

Commit-ID:     2d4ef66720386d567e64e95008d4bdd0812bcbd2
Gitweb:        https://git.kernel.org/tip/2d4ef66720386d567e64e95008d4bdd0812bcbd2
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:16 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:10 -07:00

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
Link: https://lore.kernel.org/all/20230319001535.23210-22-rick.p.edgecombe%40intel.com
---
 include/linux/mm.h | 52 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 097544a..d09fbe9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -349,7 +349,36 @@ extern unsigned int kobjsize(const void *objp);
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
@@ -3107,15 +3136,26 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
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
 
