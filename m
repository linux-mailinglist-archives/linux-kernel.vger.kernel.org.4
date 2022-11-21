Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC1632832
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiKUPai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbiKUPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:30:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73087CDFDE;
        Mon, 21 Nov 2022 07:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3D2FB810BD;
        Mon, 21 Nov 2022 15:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C44C433D6;
        Mon, 21 Nov 2022 15:29:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="TCq7za53"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669044561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6pfXxk1R5HZcT70fmvjGw8rCbaYrNrcgLTI5YfCNj44=;
        b=TCq7za532DNUP4uLI6+EosIR88ZQ39rWhpp8JkScr5OHUoL83IYTLkz9ZgR2ecP23xqEuR
        AqpPhJN89Caxoq3uANqEgc8La/iVfiK1A3/P2gmXtyfM6l1duDTBtpeV1HytwQ2QXZ44TU
        8gK4Nx1tgCAzsM9h6gUsMbEEmOjQ1Sc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d23c2dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Nov 2022 15:29:21 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: [PATCH v6 1/3] random: add vgetrandom_alloc() syscall
Date:   Mon, 21 Nov 2022 16:29:07 +0100
Message-Id: <20221121152909.3414096-2-Jason@zx2c4.com>
In-Reply-To: <20221121152909.3414096-1-Jason@zx2c4.com>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
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
 arch/x86/Kconfig                        |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
 arch/x86/include/asm/unistd.h           |  1 +
 drivers/char/random.c                   | 59 +++++++++++++++++++++++++
 include/uapi/asm-generic/unistd.h       |  7 ++-
 kernel/sys_ni.c                         |  3 ++
 lib/vdso/getrandom.h                    | 23 ++++++++++
 scripts/checksyscalls.sh                |  4 ++
 tools/include/uapi/asm-generic/unistd.h |  7 ++-
 10 files changed, 105 insertions(+), 2 deletions(-)
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..331e21ba961a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,7 @@ config X86
 	#
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
+	select ADVISE_SYSCALLS			if X86_64
 	select ARCH_32BIT_OFF_T			if X86_32
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
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
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 761173ccc33c..1bf509eaeff1 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -27,6 +27,7 @@
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64V2
+#  define __ARCH_WANT_VGETRANDOM_ALLOC
 #  define X32_NR_syscalls (__NR_x32_syscalls)
 #  define IA32_NR_syscalls (__NR_ia32_syscalls)
 
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 65ee69896967..9b64db52849f 100644
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
@@ -59,6 +61,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include "../../lib/vdso/getrandom.h"
 
 /*********************************************************************
  *
@@ -146,6 +149,62 @@ EXPORT_SYMBOL(wait_for_random_bytes);
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
+#ifdef __ARCH_WANT_VGETRANDOM_ALLOC
+/*
+ * The vgetrandom() function in userspace requires an opaque state, which this
+ * function provides to userspace, by mapping a certain number of special pages
+ * into the calling process. It takes a hint as to the number of opaque states
+ * desired, and returns the number of opaque states actually allocated, the
+ * size of each one in bytes, and the address of the first state.
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
+	num_states = clamp(num_states, 1UL, (SIZE_MAX & PAGE_MASK) / sizeof(struct vgetrandom_state));
+	alloc_size = PAGE_ALIGN(num_states * sizeof(struct vgetrandom_state));
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
diff --git a/lib/vdso/getrandom.h b/lib/vdso/getrandom.h
new file mode 100644
index 000000000000..c7f727db2aaa
--- /dev/null
+++ b/lib/vdso/getrandom.h
@@ -0,0 +1,23 @@
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
+	union {
+		struct {
+			u8 batch[CHACHA_BLOCK_SIZE * 3 / 2];
+			u32 key[CHACHA_KEY_SIZE / sizeof(u32)];
+		};
+		u8 batch_key[CHACHA_BLOCK_SIZE * 2];
+	};
+	unsigned long generation;
+	u8 pos;
+};
+
+#endif /* _VDSO_LIB_GETRANDOM_H */
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

