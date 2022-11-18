Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D910A62FBB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiKRRcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiKRRb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:31:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B592093;
        Fri, 18 Nov 2022 09:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74F34626B5;
        Fri, 18 Nov 2022 17:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71F4C433C1;
        Fri, 18 Nov 2022 17:31:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SUnZUV4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668792716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T6L3jtW2SoWaDL/fJUN0DeobDZjSMEBLN32jobVlzYg=;
        b=SUnZUV4tCzfyqJ5Ujl3gQLBqgYbONv32LXgkKjFgokeZQ8I9ZovXyhM4BorxGHmLcWu4XK
        ATkD0NnG1qQqNJ8xqW2ojeYjzt6LKUf1i38U4xtWYCcY6Jcr5gnuPjYXQmCSIfLYmcbSM3
        Rgj+DcrYPVguSTID1t1Lr18fEZFpGoI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a931288d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 17:31:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: [PATCH v4 1/3] random: add vgetrandom_alloc() syscall
Date:   Fri, 18 Nov 2022 18:28:37 +0100
Message-Id: <20221118172839.2653829-2-Jason@zx2c4.com>
In-Reply-To: <20221118172839.2653829-1-Jason@zx2c4.com>
References: <20221118172839.2653829-1-Jason@zx2c4.com>
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

The vDSO getrandom() works over an opaque per-thread state of an
unexported size, which must be marked as MADV_WIPEONFORK and be
mlock()'d for proper operation. Over time, the nuances of these
allocations may change or grow or even differ based on architectural
features.

The syscall has the signature:

  void *vgetrandom_alloc([inout] size_t *num, [out] size_t *size_per_each, unsigned int flags);

This takes the desired number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` argument is always zero for now.) Libc is expected to allocate a
chunk of these on first use, and then dole them out to threads as
they're created, allocating more when needed.

We very intentionally do *not* leave state allocation for vDSO
getrandom() up to userspace itself, but rather provide this new syscall
for such allocations. vDSO getrandom() must not store its state in just
any old memory address, but rather just ones that the kernel specially
allocates for it, leaving the particularities of those allocations up to
the kernel.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                            |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 drivers/char/random.c                  | 57 ++++++++++++++++++++++++++
 lib/vdso/getrandom.h                   | 25 +++++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 lib/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 256f03904987..843dd6a49538 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17287,6 +17287,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	lib/vdso/getrandom.h
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..ea0fbc2ded5e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	vgetrandom_alloc	sys_vgetrandom_alloc
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..0186f173f0e8 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	vgetrandom_alloc	sys_vgetrandom_alloc
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 65ee69896967..b83481eb00a9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -8,6 +8,7 @@
  * into roughly six sections, each with a section header:
  *
  *   - Initialization and readiness waiting.
+ *   - VDSO support helpers.
  *   - Fast key erasure RNG, the "crng".
  *   - Entropy accumulation and extraction routines.
  *   - Entropy collection routines.
@@ -39,6 +40,7 @@
 #include <linux/blkdev.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
 #include <linux/nodemask.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
@@ -59,6 +61,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include "../../lib/vdso/getrandom.h"
 
 /*********************************************************************
  *
@@ -146,6 +149,60 @@ EXPORT_SYMBOL(wait_for_random_bytes);
 				__func__, (void *)_RET_IP_, crng_init)
 
 
+
+/********************************************************************
+ *
+ * VDSO support helpers.
+ *
+ * The actual vDSO function is defined over in lib/vdso/getrandom.c,
+ * but this section contains the kernel-mode helpers to support that.
+ *
+ ********************************************************************/
+
+/*
+ * The vgetrandom() function in userspace requires an opaque state, which this
+ * function provides to userspace. The result is that it maps a certain
+ * number of special pages into the calling process and returns the address.
+ */
+SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
+		unsigned long __user *, size_per_each, unsigned int, flags)
+{
+	unsigned long alloc_size;
+	unsigned long num_states;
+	unsigned long pages_addr;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(num_states, num))
+		return -EFAULT;
+
+	alloc_size = size_mul(num_states, sizeof(struct vgetrandom_state));
+	if (alloc_size == SIZE_MAX)
+		return -EOVERFLOW;
+	alloc_size = roundup(alloc_size, PAGE_SIZE);
+
+	if (put_user(alloc_size / sizeof(struct vgetrandom_state), num) ||
+	    put_user(sizeof(struct vgetrandom_state), size_per_each))
+		return -EFAULT;
+
+	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);
+	if (IS_ERR_VALUE(pages_addr))
+		return pages_addr;
+
+	ret = do_madvise(current->mm, pages_addr, alloc_size, MADV_WIPEONFORK);
+	if (ret < 0)
+		goto err_unmap;
+
+	return pages_addr;
+
+err_unmap:
+	vm_munmap(pages_addr, alloc_size);
+	return ret;
+}
+
 /*********************************************************************
  *
  * Fast key erasure RNG, the "crng".
diff --git a/lib/vdso/getrandom.h b/lib/vdso/getrandom.h
new file mode 100644
index 000000000000..fef7c0261e2b
--- /dev/null
+++ b/lib/vdso/getrandom.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _VDSO_LIB_GETRANDOM_H
+#define _VDSO_LIB_GETRANDOM_H
+
+#include <crypto/chacha.h>
+
+struct vgetrandom_state {
+	u64 last_reseed;
+	unsigned long generation;
+	union {
+		struct {
+			u8 key[CHACHA_KEY_SIZE];
+			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
+		};
+		u8 key_batch[CHACHA_BLOCK_SIZE * 2];
+	};
+	u8 pos;
+	bool not_forked;
+};
+
+#endif /* _VDSO_LIB_GETRANDOM_H */
-- 
2.38.1

