Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49E64A7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbiLLSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiLLSyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CF5E7D;
        Mon, 12 Dec 2022 10:54:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FAC0B80DF0;
        Mon, 12 Dec 2022 18:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65575C433D2;
        Mon, 12 Dec 2022 18:54:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EYfvpM2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670871255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQ6fF4G0/G4P2Bm/nkDe30Kazol5Bka51b1uyAQaFJA=;
        b=EYfvpM2Iymmsw7e/tFsnOFQcr4EKjmNam5QmPjB+8opTE1pMC5qNYh7JeoKw6WZuqgDbuH
        1LHm4quiiQ8rfer4+hyWmkDjxd0HOYpt6pa8bYYzzWGasogauCY0R2dbyhJ0sFPIV6AaOc
        wM/MoTI4AYaMS6ay3ObpQyXslTFvgTk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ce2cf42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 18:54:15 +0000 (UTC)
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
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v12 3/6] random: add vgetrandom_alloc() syscall
Date:   Mon, 12 Dec 2022 11:53:44 -0700
Message-Id: <20221212185347.1286824-4-Jason@zx2c4.com>
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

The vDSO getrandom() works over an opaque per-thread state of an
unexported size, which must be marked VM_WIPEONFORK, VM_DONTDUMP,
VM_NORESERVE, and VM_DROPPABLE for proper operation. Over time, the
nuances of these allocations may change or grow or even differ based on
architectural features.

The syscall has the signature:

  void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each,
                         unsigned long addr, unsigned int flags);

This takes a hinted number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread,
while ensuring that no single state straddles a page boundary. (The
`flags` and `addr` arguments, as well as the `*size_per_each` input
value, are reserved for the future and are forced to be zero zero for
now.)

Libc is expected to allocate a chunk of these on first use, and then
dole them out to threads as they're created, allocating more when
needed. The returned address of the first state may be passed to
munmap(2) with a length of `num * size_per_each`, in order to deallocate
the memory.

We very intentionally do *not* leave state allocation for vDSO
getrandom() up to userspace itself, but rather provide this new syscall
for such allocations. vDSO getrandom() must not store its state in just
any old memory address, but rather just ones that the kernel specially
allocates for it, leaving the particularities of those allocations up to
the kernel.

The allocation of states is intended to be integrated into libc's thread
management. As an illustrative example, the following code might be used
to do the same outside of libc. Though, vgetrandom_alloc() is not
expected to be exposed outside of libc, and the pthread usage here is
expected to be elided into libc internals. This allocation scheme is
very naive and does not shrink; other implementations may choose to be
more complex.

  static void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each)
  {
    *size_per_each = 0; /* Must be zero on input. */
    return (void *)syscall(__NR_vgetrandom_alloc, &num, &size_per_each,
                           0 /* reserved @addr */, 0 /* reserved @flags */);
  }

  static struct {
    pthread_mutex_t lock;
    void **states;
    size_t len, cap;
  } grnd_allocator = {
    .lock = PTHREAD_MUTEX_INITIALIZER
  };

  static void *vgetrandom_get_state(void)
  {
    void *state = NULL;

    pthread_mutex_lock(&grnd_allocator.lock);
    if (!grnd_allocator.len) {
      size_t new_cap;
      size_t page_size = getpagesize();
      unsigned int num = sysconf(_SC_NPROCESSORS_ONLN); /* Could be arbitrary, just a hint. */
      unsigned int size_per_each;
      void *new_block = vgetrandom_alloc(&num, &size_per_each);
      void *new_states;

      if (new_block == MAP_FAILED)
        goto out;
      new_cap = grnd_allocator.cap + num;
      new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
      if (!new_states) {
        munmap(new_block, num * size_per_each);
        goto out;
      }
      grnd_allocator.cap = new_cap;
      grnd_allocator.states = new_states;

      for (size_t i = 0; i < num; ++i) {
        grnd_allocator.states[i] = new_block;
        if (((uintptr_t)new_block & (page_size - 1)) + size_per_each > page_size)
          new_block = (void *)(((uintptr_t)new_block + page_size) & (page_size - 1));
        else
          new_block += size_per_each;
      }
      grnd_allocator.len = num;
    }
    state = grnd_allocator.states[--grnd_allocator.len];

  out:
    pthread_mutex_unlock(&grnd_allocator.lock);
    return state;
  }

  static void vgetrandom_put_state(void *state)
  {
    if (!state)
      return;
    pthread_mutex_lock(&grnd_allocator.lock);
    grnd_allocator.states[grnd_allocator.len++] = state;
    pthread_mutex_unlock(&grnd_allocator.lock);
  }

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS              |   1 +
 drivers/char/random.c    | 136 +++++++++++++++++++++++++++++++++++++++
 include/linux/syscalls.h |   3 +
 include/vdso/getrandom.h |  16 +++++
 kernel/sys_ni.c          |   3 +
 lib/vdso/Kconfig         |   6 ++
 6 files changed, 165 insertions(+)
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
index e872acc1238f..dff1cf250104 100644
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
@@ -56,6 +58,9 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#ifdef CONFIG_VDSO_GETRANDOM
+#include <vdso/getrandom.h>
+#endif
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
@@ -168,6 +173,137 @@ int __cold execute_with_initialized_rng(struct notifier_block *nb)
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
+#ifdef CONFIG_VDSO_GETRANDOM
+/**
+ * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
+ *
+ * @num:	   On input, a pointer to a suggested hint of how many states to
+ * 		   allocate, and on return the number of states actually allocated.
+ *
+ * @size_per_each: On input, must be zero. On return, the size of each state allocated,
+ * 		   so that the caller can split up the returned allocation into
+ * 		   individual states.
+ *
+ * @addr:	   Reserved, must be zero.
+ *
+ * @flags:	   Reserved, must be zero.
+ *
+ * The getrandom() vDSO function in userspace requires an opaque state, which
+ * this function allocates by mapping a certain number of special pages into
+ * the calling process. It takes a hint as to the number of opaque states
+ * desired, and provides the caller with the number of opaque states actually
+ * allocated, the size of each one in bytes, and the address of the first
+ * state, which may be split up into @num states of @size_per_each bytes each,
+ * by adding @size_per_each to the returned first state @num times, while
+ * ensuring that no single state straddles a page boundary.
+ *
+ * Returns the address of the first state in the allocation on success, or a
+ * negative error value on failure.
+ *
+ * The returned address of the first state may be passed to munmap(2) with a
+ * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
+ * memory, after which it is invalid to pass it to vDSO getrandom().
+ *
+ * States allocated by this function must not be dereferenced, written, read,
+ * or otherwise manipulated. The *only* supported operations are:
+ *   - Splitting up the states in intervals of @size_per_each, no more than
+ *     @num times from the first state, while ensuring that no single state
+ *     straddles a page boundary.
+ *   - Passing a state to the getrandom() vDSO function's @opaque_state
+ *     parameter, but not passing the same state at the same time to two such
+ *     calls.
+ *   - Passing the first state and the total length to munmap(2), as described
+ *     above.
+ * All other uses are undefined behavior, which is subject to change or removal.
+ */
+SYSCALL_DEFINE4(vgetrandom_alloc, unsigned int __user *, num,
+		unsigned int __user *, size_per_each, unsigned long, addr,
+		unsigned int, flags)
+{
+	struct mm_struct *mm = current->mm;
+	size_t state_size, alloc_size, num_states;
+	unsigned long pages_addr, populate, mm_flags;
+	unsigned int num_hint;
+	int ret;
+
+	/*
+	 * @flags and @addr are currently unused, so in order to reserve them
+	 * for the future, force them to be set to zero by current callers.
+	 */
+	if (flags || addr)
+		return -EINVAL;
+
+	/*
+	 * Also enforce that *size_per_each is zero on input, in case this becomes
+	 * useful later on.
+	 */
+	if (get_user(num_hint, size_per_each))
+		return -EFAULT;
+	if (num_hint)
+		return -EINVAL;
+
+	if (get_user(num_hint, num))
+		return -EFAULT;
+
+	state_size = sizeof(struct vgetrandom_state);
+	num_states = clamp_t(size_t, num_hint, 1, (SIZE_MAX & PAGE_MASK) / state_size);
+	alloc_size = PAGE_ALIGN(num_states * state_size);
+	/*
+	 * States cannot straddle page boundaries, so calculate the number of
+	 * states that can fit inside of a page without being split, and then
+	 * multiply that out by the number of pages allocated.
+	 */
+	num_states = (PAGE_SIZE / state_size) * (alloc_size / PAGE_SIZE);
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+	mm_flags = mm->def_flags;
+
+	mm->def_flags |=
+		/*
+		 * Don't allow state to be written to swap, to preserve forward secrecy.
+		 * But also don't mlock it or pre-reserve it, and allow it to
+		 * be discarded under memory pressure. If no memory is available, returns
+		 * zeros rather than segfaulting.
+		 */
+		VM_DROPPABLE | VM_NORESERVE |
+
+		/* Don't allow the state to survive forks, to prevent random number re-use. */
+		VM_WIPEONFORK |
+
+		/* Don't write random state into coredumps. */
+		VM_DONTDUMP;
+
+	pages_addr = do_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, 0, &populate, NULL);
+
+	mm->def_flags = mm_flags;
+	mmap_write_unlock(mm);
+	if (IS_ERR_VALUE(pages_addr))
+		return pages_addr;
+
+	ret = -EFAULT;
+	if (put_user(num_states, num) || put_user(state_size, size_per_each))
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
index a34b0f9a9972..dc13b0715836 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1006,6 +1006,9 @@ asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
 			    void __user *uargs);
 asmlinkage long sys_getrandom(char __user *buf, size_t count,
 			      unsigned int flags);
+asmlinkage long sys_vgetrandom_alloc(unsigned int __user *num,
+				     unsigned int __user *size_per_each,
+				     unsigned long addr, unsigned int flags);
 asmlinkage long sys_memfd_create(const char __user *uname_ptr, unsigned int flags);
 asmlinkage long sys_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 asmlinkage long sys_execveat(int dfd, const char __user *filename,
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
new file mode 100644
index 000000000000..e3ceb1976386
--- /dev/null
+++ b/include/vdso/getrandom.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef _VDSO_GETRANDOM_H
+#define _VDSO_GETRANDOM_H
+
+/**
+ * struct vgetrandom_state - State used by vDSO getrandom() and allocated by vgetrandom_alloc().
+ *
+ * Currently empty, as the vDSO getrandom() function has not yet been implemented.
+ */
+struct vgetrandom_state { int placeholder; };
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
index d883ac299508..f88580960182 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,3 +31,9 @@ config GENERIC_VDSO_TIME_NS
 	  VDSO
 
 endif
+
+config VDSO_GETRANDOM
+	bool
+	select NEED_VM_DROPPABLE
+	help
+	  Selected by architectures that support vDSO getrandom().
-- 
2.38.1

