Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6D63A712
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiK1LUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiK1LUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:20:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A0D1CB0B;
        Mon, 28 Nov 2022 03:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E518D61118;
        Mon, 28 Nov 2022 11:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED6DC433C1;
        Mon, 28 Nov 2022 11:18:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ckVqQGGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669634333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6bKCdbJI8caGV86jHwYqsJ4Ef3NCBwwd7g33zRLmuo=;
        b=ckVqQGGQeuga74ChPjFfsMQUB4b1SV3DbIz3y7zKQls1AxbW45vAtZKY4GsrlwkQo7orHE
        M1BCPnt7iiGc58J/ZnpgyOE0MVMout30lEX3znJOM3ALwiLlS4kHDuYXJn4+x/FdzmwOQO
        5Y2WlvM1Sx868PXTMWOFuk5a1BfGaEc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dc600f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Nov 2022 11:18:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 1/3] random: add vgetrandom_alloc() syscall
Date:   Mon, 28 Nov 2022 12:18:27 +0100
Message-Id: <20221128111829.2477505-2-Jason@zx2c4.com>
In-Reply-To: <20221128111829.2477505-1-Jason@zx2c4.com>
References: <20221128111829.2477505-1-Jason@zx2c4.com>
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

  void *vgetrandom_alloc([inout] unsigned int *num,
                         [out] unsigned int *size_per_each,
                         unsigned int flags);

This takes the desired number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` argument is always zero for now.) Libc is expected to allocate a
chunk of these on first use, and then dole them out to threads as
they're created, allocating more when needed. The following commit shows
an example of this, being used in conjunction with the getrandom() vDSO
function.

We very intentionally do *not* leave state allocation for vDSO
getrandom() up to userspace itself, but rather provide this new syscall
for such allocations. vDSO getrandom() must not store its state in just
any old memory address, but rather just ones that the kernel specially
allocates for it, leaving the particularities of those allocations up to
the kernel.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                             |  1 +
 drivers/char/random.c                   | 75 +++++++++++++++++++++++++
 include/uapi/asm-generic/unistd.h       |  7 ++-
 include/vdso/getrandom.h                | 24 ++++++++
 kernel/sys_ni.c                         |  3 +
 lib/vdso/Kconfig                        |  7 +++
 scripts/checksyscalls.sh                |  4 ++
 tools/include/uapi/asm-generic/unistd.h |  7 ++-
 8 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 include/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 256f03904987..3894f947a507 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17287,6 +17287,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	include/vdso/getrandom.h
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index a2a18bd3d7d7..16e9edce771f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -8,6 +8,7 @@
  * into roughly six sections, each with a section header:
  *
  *   - Initialization and readiness waiting.
+ *   - vDSO support helpers.
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
@@ -55,6 +57,9 @@
 #include <linux/siphash.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
+#include <vdso/getrandom.h>
+#endif
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
@@ -167,6 +172,76 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
 				__func__, (void *)_RET_IP_, crng_init)
 
 
+
+/********************************************************************
+ *
+ * vDSO support helpers.
+ *
+ * The actual vDSO function is defined over in lib/vdso/getrandom.c,
+ * but this section contains the kernel-mode helpers to support that.
+ *
+ ********************************************************************/
+
+#ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
+/**
+ * vgetrandom_alloc - allocate opaque states for use with vDSO getrandom().
+ *
+ * @num: on input, a pointer to a suggested hint of how many states to
+ * allocate, and on output the number of states actually allocated.
+ *
+ * @size_per_each: the size of each state allocated, so that the caller can
+ * split up the returned allocation into individual states.
+ *
+ * @flags: currently always zero.
+ *
+ * The getrandom() vDSO function in userspace requires an opaque state, which
+ * this function allocates by mapping a certain number of special pages into
+ * the calling process. It takes a hint as to the number of opaque states
+ * desired, and provides the caller with the number of opaque states actually
+ * allocated, the size of each one in bytes, and the address of the first
+ * state.
+
+ * Returns a pointer to the first state in the allocation.
+ *
+ */
+SYSCALL_DEFINE3(vgetrandom_alloc, unsigned int __user *, num,
+		unsigned int __user *, size_per_each, unsigned int, flags)
+{
+	const size_t state_size = sizeof(struct vgetrandom_state);
+	size_t alloc_size, num_states;
+	unsigned long pages_addr;
+	unsigned int num_hint;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (get_user(num_hint, num))
+		return -EFAULT;
+
+	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
+	alloc_size = PAGE_ALIGN(num_states * state_size);
+
+	if (put_user(alloc_size / state_size, num) || put_user(state_size, size_per_each))
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
+#endif
+
 /*********************************************************************
  *
  * Fast key erasure RNG, the "crng".
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..77b6debe7e18 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,13 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#ifdef __ARCH_WANT_VGETRANDOM_ALLOC
+#define __NR_vgetrandom_alloc 451
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
new file mode 100644
index 000000000000..5f04c8bf4bd4
--- /dev/null
+++ b/include/vdso/getrandom.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _VDSO_GETRANDOM_H
+#define _VDSO_GETRANDOM_H
+
+#include <crypto/chacha.h>
+
+struct vgetrandom_state {
+	union {
+		struct {
+			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
+			u32 key[CHACHA_KEY_SIZE / sizeof(u32)];
+		};
+		u8 batch_key[CHACHA_BLOCK_SIZE * 2];
+	};
+	unsigned long generation;
+	u8 pos;
+	bool in_use;
+};
+
+#endif /* _VDSO_GETRANDOM_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..f28196cb919b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -360,6 +360,9 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* random */
+COND_SYSCALL(vgetrandom_alloc);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..b22584f8da03 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,3 +31,10 @@ config GENERIC_VDSO_TIME_NS
 	  VDSO
 
 endif
+
+config VGETRANDOM_ALLOC_SYSCALL
+	bool
+	select ADVISE_SYSCALLS
+	help
+	  Selected by the getrandom() vDSO function, which requires this
+	  for state allocation.
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index f33e61aca93d..7f7928c6487f 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -44,6 +44,10 @@ cat << EOF
 #define __IGNORE_memfd_secret
 #endif
 
+#ifndef __ARCH_WANT_VGETRANDOM_ALLOC
+#define __IGNORE_vgetrandom_alloc
+#endif
+
 /* Missing flags argument */
 #define __IGNORE_renameat	/* renameat2 */
 
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..77b6debe7e18 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -886,8 +886,13 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 #define __NR_set_mempolicy_home_node 450
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
+#ifdef __ARCH_WANT_VGETRANDOM_ALLOC
+#define __NR_vgetrandom_alloc 451
+__SYSCALL(__NR_vgetrandom_alloc, sys_vgetrandom_alloc)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
-- 
2.38.1

