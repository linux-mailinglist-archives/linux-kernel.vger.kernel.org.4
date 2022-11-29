Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D363CA09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbiK2VHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbiK2VHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:07:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD455AA2;
        Tue, 29 Nov 2022 13:07:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A69CDB818F8;
        Tue, 29 Nov 2022 21:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E06C433C1;
        Tue, 29 Nov 2022 21:06:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZHeiSt3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669756018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekTebUCCQZdS8e07OVCXF5NAVOVibmeuVYtHJZRoP6Q=;
        b=ZHeiSt3VZzOI3NCXiDIok8fxv6OSildMJCOGWp6jIxkIGHhBgdA2ZNKV5f+yq1Ur1KZK/9
        dsRFyh2wdv+Q5i6zZDDLsegOyO0FPq6q1aaStg4xUgI1z7EEm61QZVsfO0Ic1eTd2mT+Sg
        GlIoyAs17RAeOi2lzx0uWRylC15nsBc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e6178847 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Nov 2022 21:06:58 +0000 (UTC)
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
Subject: [PATCH v10 1/4] random: add vgetrandom_alloc() syscall
Date:   Tue, 29 Nov 2022 22:06:36 +0100
Message-Id: <20221129210639.42233-2-Jason@zx2c4.com>
In-Reply-To: <20221129210639.42233-1-Jason@zx2c4.com>
References: <20221129210639.42233-1-Jason@zx2c4.com>
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
 MAINTAINERS              |  1 +
 drivers/char/random.c    | 75 ++++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h |  3 ++
 include/vdso/getrandom.h | 24 +++++++++++++
 kernel/sys_ni.c          |  3 ++
 lib/vdso/Kconfig         |  7 ++++
 6 files changed, 113 insertions(+)
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
index 67558b95d531..b81d67f3ebab 100644
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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..7741dc94f10c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1006,6 +1006,9 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
+asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
+				     unsigned int __user *size_per_each,
+				     unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
 asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
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
-- 
2.38.1

