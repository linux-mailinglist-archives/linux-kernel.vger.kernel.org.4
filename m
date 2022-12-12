Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A019C64A7B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiLLSzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiLLSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BABABF72;
        Mon, 12 Dec 2022 10:54:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B465F611C6;
        Mon, 12 Dec 2022 18:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CBDC433F0;
        Mon, 12 Dec 2022 18:54:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kOiSXGdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670871253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDnIaEdxmFpwDp34HQjcaj4AkiYeEvsGKnBz84Pn62I=;
        b=kOiSXGdKAuVtQwPSnP+N4oa+AsFI5Vcf7q+FQraZSoGQa1/SmvKpJgbOdOi+DN39qNoy9l
        FreY9SMWteCbSsG8y/mam6UYgbtM+LthUwnRVRY3IL1FMiy+zIr24cFzt4OrFnp3cpihxT
        N+TcMfOBgYggh3tDP9wY6rW6z7O8JsI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4335dacd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 18:54:13 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: [PATCH RFC v12 2/6] x86: mm: Skip faulting instruction for VM_DROPPABLE faults
Date:   Mon, 12 Dec 2022 11:53:43 -0700
Message-Id: <20221212185347.1286824-3-Jason@zx2c4.com>
In-Reply-To: <20221212185347.1286824-1-Jason@zx2c4.com>
References: <20221212185347.1286824-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prior commit introduced VM_DROPPABLE, but in a limited form where
the faulting instruction was retried instead of skipped. Finish that up
with the platform-specific aspect of skipping the actual instruction.

This works by copying userspace's %rip to a stack buffer of size
MAX_INSN_SIZE, decoding it, and then adding the length of the decoded
instruction to userspace's %rip. In the event any of these fail, just
fallback to not advancing %rip and trying again.

Cc: linux-mm@kvack.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/mm/fault.c      | 19 +++++++++++++++++++
 include/linux/mm_types.h |  5 ++++-
 mm/memory.c              |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7b0d4ab894c8..e5328073f8e0 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -33,6 +33,8 @@
 #include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
 #include <asm/vdso.h>			/* fixup_vdso_exception()	*/
 #include <asm/irq_stack.h>
+#include <asm/insn.h>			/* insn_decode()		*/
+#include <asm/compat.h>			/* in_32bit_syscall()		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -1454,6 +1456,23 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 
 	mmap_read_unlock(mm);
+
+	if (fault & VM_FAULT_SKIP_INSN) {
+		u8 insn_buf[MAX_INSN_SIZE];
+		struct insn insn;
+		size_t len;
+
+		len = sizeof(insn_buf) - copy_from_user(insn_buf, (void *)regs->ip, sizeof(insn_buf));
+		if (!len)
+			return;
+
+		if (insn_decode(&insn, insn_buf, len, in_32bit_syscall() ? INSN_MODE_32 : INSN_MODE_64) < 0)
+			return;
+
+		regs->ip += insn.length;
+		return;
+	}
+
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..4def1051499b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -861,6 +861,7 @@ typedef __bitwise unsigned int vm_fault_t;
  *				fsync() to complete (for synchronous page faults
  *				in DAX)
  * @VM_FAULT_COMPLETED:		->fault completed, meanwhile mmap lock released
+ * @VM_FAULT_SKIP_INSN:		->handle the fault by skipping faulting instruction
  * @VM_FAULT_HINDEX_MASK:	mask HINDEX value
  *
  */
@@ -879,6 +880,7 @@ enum vm_fault_reason {
 	VM_FAULT_DONE_COW       = (__force vm_fault_t)0x001000,
 	VM_FAULT_NEEDDSYNC      = (__force vm_fault_t)0x002000,
 	VM_FAULT_COMPLETED      = (__force vm_fault_t)0x004000,
+	VM_FAULT_SKIP_INSN      = (__force vm_fault_t)0x008000,
 	VM_FAULT_HINDEX_MASK    = (__force vm_fault_t)0x0f0000,
 };
 
@@ -903,7 +905,8 @@ enum vm_fault_reason {
 	{ VM_FAULT_RETRY,               "RETRY" },	\
 	{ VM_FAULT_FALLBACK,            "FALLBACK" },	\
 	{ VM_FAULT_DONE_COW,            "DONE_COW" },	\
-	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" }
+	{ VM_FAULT_NEEDDSYNC,           "NEEDDSYNC" },	\
+	{ VM_FAULT_SKIP_INSN,		"SKIP_INSN" }
 
 struct vm_special_mapping {
 	const char *name;	/* The name, e.g. "[vdso]". */
diff --git a/mm/memory.c b/mm/memory.c
index 72403585e1a5..8834a7c1580f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5220,8 +5220,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	lru_gen_exit_fault();
 
 	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
-	if (vma->vm_flags & VM_DROPPABLE)
+	if ((ret & VM_FAULT_OOM) && (vma->vm_flags & VM_DROPPABLE)) {
 		ret &= ~VM_FAULT_OOM;
+		ret |= VM_FAULT_SKIP_INSN;
+	}
 
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
-- 
2.38.1

