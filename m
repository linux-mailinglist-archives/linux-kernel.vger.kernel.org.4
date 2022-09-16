Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2535BADC1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiIPNBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiIPNBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E8A99F5;
        Fri, 16 Sep 2022 06:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64E8BB826AA;
        Fri, 16 Sep 2022 13:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEA9C433D6;
        Fri, 16 Sep 2022 13:01:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BJz5rI41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663333278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OTZmhESLo7eY54tTFJjp6Lh4xtmQB3xhxxdCYM5gUb4=;
        b=BJz5rI41Meqzivc7m773U0Pc0IFIrwKYxs1YegaAWMAYADGTQ41RtzH5BRb9BlviGLe27a
        kbUDalKD+irlXPUDJ8KUclSI0u9yZJ7ts6w5oLZ5VPvRrGUt904LdTl+tvY1NvePjEhhQI
        SOg+v2k2RLoGbF+4NG4fq6FyCXuX1VY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e432ba52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 16 Sep 2022 13:01:17 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: [PATCH RFC v3] random: implement getrandom() in vDSO
Date:   Fri, 16 Sep 2022 13:59:16 +0100
Message-Id: <20220916125916.652546-1-Jason@zx2c4.com>
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

Changes v2->v3:
--------------

Big changes:

Thomas' previous objection was two-fold: 1) vgetrandom
should really have the same function signature as getrandom, in
addition to all of the same behavior, and 2) having vgetrandom_alloc
be a vDSO function doesn't make sense, because it doesn't actually
need anything from the VDSO data page and it doesn't correspond to an
existing syscall.

After a discussion at Plumbers this last week, we devised the following
ways to fix these: 1) we make the opque state argument be the last
argument of vgetrandom, rather than the first one, since the real
syscall ignores the additional argument, and that way all the registers
are the same, and no behavior changes; and 2) we make vgetrandom_alloc a
syscall, rather than a vDSO function, which also gives it added
flexibility for the future, which is good.

Making those changes also reduced the size of this patch a bit.

Smaller changes:
- Properly add buffer offset position.
- Don't EXPORT_SYMBOL for vDSO code.
- Account for timens and vvar being in swapped pages.

--------------

Two statements:

  1) Userspace wants faster cryptographically secure random numbers of
     arbitrary size, big or small.

  2) Userspace is currently unable to safely roll its own RNG with the
     same security profile as getrandom().

Statement (1) has been debated for years, with arguments ranging from
"we need faster cryptographically secure card shuffling!" to "the only
things that actually need good randomness are keys, which are few and
far between" to "actually, TLS CBC nonces are frequent" and so on. I
don't intend to wade into that debate substantially, except to note that
recently glibc added arc4random(), whose goal is to return a
cryptographically secure uint32_t, and there are real user reports of it
being too slow. So here we are.

Statement (2) is more interesting. The kernel is the nexus of all
entropic inputs that influence the RNG. It is in the best position, and
probably the only position, to decide anything at all about the current
state of the RNG and of its entropy. One of the things it uniquely knows
about is when reseeding is necessary.

For example, when a virtual machine is forked, restored, or duplicated,
it's imparative that the RNG doesn't generate the same outputs. For this
reason, there's a small protocol between hypervisors and the kernel that
indicates this has happened, alongside some ID, which the RNG uses to
immediately reseed, so as not to return the same numbers. Were userspace
to expand a getrandom() seed from time T1 for the next hour, and at some
point T2 < hour, the virtual machine forked, userspace would continue to
provide the same numbers to two (or more) different virtual machines,
resulting in potential cryptographic catastrophe. Something similar
happens on resuming from hibernation (or even suspend), with various
compromise scenarios there in mind.

There's a more general reason why userspace rolling its own RNG from a
getrandom() seed is fraught. There's a lot of attention paid to this
particular Linuxism we have of the RNG being initialized and thus
non-blocking or uninitialized and thus blocking until it is initialized.
These are our Two Big States that many hold to be the holy
differentiating factor between safe and not safe, between
cryptographically secure and garbage. The fact is, however, that the
distinction between these two states is a hand-wavy wishy-washy inexact
approximation. Outside of a few exceptional cases (e.g. a HW RNG is
available), we actually don't really ever know with any rigor at all
when the RNG is safe and ready (nor when it's compromised). We do the
best we can to "estimate" it, but entropy estimation is fundamentally
impossible in the general case. So really, we're just doing guess work,
and hoping it's good and conservative enough. Let's then assume that
there's always some potential error involved in this differentiator.

In fact, under the surface, the RNG is engineered around a different
principal, and that is trying to *use* new entropic inputs regularly and
at the right specific moments in time. For example, close to boot time,
the RNG reseeds itself more often than later. At certain events, like VM
fork, the RNG reseeds itself immediately. The various heuristics for
when the RNG will use new entropy and how often is really a core aspect
of what the RNG has some potential to do decently enough (and something
that will probably continue to improve in the future from random.c's
present set of algorithms). So in your mind, put away the metal
attachment to the Two Big States, which represent an approximation with
a potential margin of error. Instead keep in mind that the RNG's primary
operating heuristic is how often and exactly when it's going to reseed.

So, if userspace takes a seed from getrandom() at point T1, and uses it
for the next hour (or N megabytes or some other meaningless metric),
during that time, potential errors in the Two Big States approximation
are amplified. During that time potential reseeds are being lost,
forgotten, not reflected in the output stream. That's not good.

The simplest statement you could make is that userspace RNGs that expand
a getrandom() seed at some point T1 are nearly always *worse*, in some
way, than just calling getrandom() every time a random number is
desired.

For those reasons, after some discussion on libc-alpha, glibc's
arc4random() now just calls getrandom() on each invocation. That's
trivially safe, and gives us latitude to then make the safe thing faster
without becoming unsafe at our leasure. Card shuffling isn't
particularly fast, however.

How do we rectify this? By putting a safe implementation of getrandom()
in the vDSO, which has access to whatever information a
particular iteration of random.c is using to make its decisions. I use
that careful language of "particular iteration of random.c", because the
set of things that a vDSO getrandom() implementation might need for making
decisions as good as the kernel's will likely change over time. This
isn't just a matter of exporting certain *data* to userspace. We're not
going to commit to a "data API" where the various heuristics used are
exposed, locking in how the kernel works for decades to come, and then
leave it to various userspaces to roll something on top and shoot
themselves in the foot and have all sorts of complexity disasters.
Rather, vDSO getrandom() is supposed to be the *same exact algorithm*
that runs in the kernel, except it's been hoisted into userspace as
much as possible. And so vDSO getrandom() and kernel getrandom() will
always mirror each other hermetically.

API-wise, the vDSO gains this function:

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);

The return value and the first 3 arguments are the same as ordinary
getrandom(), while the last argument is a pointer to some state
allocated with vgetrandom_alloc(), explained below. Were all four
arguments passed to the getrandom syscall, nothing different would
happen, and the functions would have the exact same behavior.

Then, we introduce a new syscall:

  void *vgetrandom_alloc([inout] size_t *num, [out] size_t *size_per_each, unsigned int flags);

This takes the desired number of opaque states in `num`, and returns a
pointer to an array of opaque states, the number actually allocated back
in `num`, and the size in bytes of each one in `size_per_each`, enabling
a libc to slice up the returned array into a state per each thread. (The
`flags` argument is always zero for now.) We very intentionally do *not*
leave state allocation up to the caller of vgetrandom, but provide
vgetrandom_alloc for that allocation. There are too many weird things
that can go wrong, and it's important that vDSO does not provide too
generic of a mechanism. It's not going to store its state in just any
old memory address. It'll do it only in ones it allocates.

Right now this means it's a mlock'd page with WIPEONFORK set. In the
future maybe there will be other interesting page flags or
anti-heartbleed measures, or other platform-specific kernel-specific
things that can be set from the syscall. Again, it's important that the
kernel has a say in how this works rather than agreeing to operate on
any old address; memory isn't neutral.

The syscall currently accomplishes this with a call to vm_mmap() and
then a call to do_madvise(). It'd be nice to do this all at once, but
I'm not sure that a helper function exists for that now, and it seems a
bit premature to add one, at least for now.

The interesting meat of the implementation is in lib/vdso/getrandom.c,
as generic C code, and it aims to mainly follow random.c's buffered fast
key erasure logic. Before the RNG is initialized, it falls back to the
syscall. Right now it uses a simple generation counter and a timestamp
to make its decisions on reseeding; this covers many cases, but not all,
so this RFC still has a little bit of improvement work to do. But it
should give you the general idea.

The actual place that has the most work to do is in all of the other
files. Most of the vDSO shared page infrastructure is centered around
gettimeofday, and so the main structs are all in arrays for different
timestamp types, and attached to time namespaces, and so forth. I've
done the best I could to add onto this in an unintrusive way, but you'll
notice almost immediately from glancing at the code that it still needs
some untangling work. This also only works on x86 at the moment. I could
certainly use a hand with this part.

So far in my test results, performance is pretty stellar (around 15x for
uint32_t generation), and it seems to be working. There are a couple
TODO bits with the actual random.c lifetime integration, but as an early
patchset, this at least introduces the intended interface.

Cc: linux-crypto@vger.kernel.org
Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                            |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/entry/vdso/Makefile           |   3 +-
 arch/x86/entry/vdso/vdso.lds.S         |   2 +
 arch/x86/entry/vdso/vgetrandom.c       |  16 ++++
 arch/x86/include/asm/vdso/getrandom.h  |  37 ++++++++
 arch/x86/include/asm/vvar.h            |  16 ++++
 drivers/char/random.c                  |  64 ++++++++++++++
 include/vdso/datapage.h                |   6 ++
 lib/crypto/chacha.c                    |   4 +
 lib/vdso/getrandom.c                   | 117 +++++++++++++++++++++++++
 lib/vdso/getrandom.h                   |  25 ++++++
 13 files changed, 293 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 lib/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f1390b8270b2..cc9a2257105d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17098,6 +17098,8 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	lib/vdso/getrandom.c
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
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 12f6c4d714cd..558f09c2a6c2 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -24,7 +24,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
@@ -101,6 +101,7 @@ CFLAGS_REMOVE_vclock_gettime.o = -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
 CFLAGS_REMOVE_vsgx.o = -pg
+CFLAGS_REMOVE_vgetrandom.o = -pg
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf48462fca7..1919cc39277e 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -28,6 +28,8 @@ VERSION {
 		clock_getres;
 		__vdso_clock_getres;
 		__vdso_sgx_enter_enclave;
+		getrandom;
+		__vdso_getrandom;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
new file mode 100644
index 000000000000..0a0c0ad93cd0
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "../../../../lib/vdso/getrandom.c"
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state)
+{
+	return __cvdso_getrandom(buffer, len, flags, state);
+}
+
+ssize_t getrandom(void *, size_t, unsigned int, void *)
+	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..c414043e975d
--- /dev/null
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#ifndef __ASM_VDSO_GETRANDOM_H
+#define __ASM_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <asm/vvar.h>
+
+static __always_inline ssize_t
+getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_getrandom), "D" (buffer), "S" (len), "d" (flags) :
+	     "rcx", "r11", "memory");
+
+	return ret;
+}
+
+#define __vdso_rng_data (VVAR(_vdso_rng_data))
+
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		return (void *)&__vdso_rng_data +
+		       ((void *)&__timens_vdso_data - (void *)&__vdso_data);
+	return &__vdso_rng_data;
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 183e98e49ab9..9d9af37f7cab 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -26,6 +26,8 @@
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
+#define DECLARE_VVAR_SINGLE(offset, type, name) \
+	EMIT_VVAR(name, offset)
 
 #else
 
@@ -37,6 +39,10 @@ extern char __vvar_page;
 	extern type timens_ ## name[CS_BASES]				\
 	__attribute__((visibility("hidden")));				\
 
+#define DECLARE_VVAR_SINGLE(offset, type, name)				\
+	extern type vvar_ ## name					\
+	__attribute__((visibility("hidden")));				\
+
 #define VVAR(name) (vvar_ ## name)
 #define TIMENS(name) (timens_ ## name)
 
@@ -44,12 +50,22 @@ extern char __vvar_page;
 	type name[CS_BASES]						\
 	__attribute__((section(".vvar_" #name), aligned(16))) __visible
 
+#define DEFINE_VVAR_SINGLE(type, name)					\
+	type name							\
+	__attribute__((section(".vvar_" #name), aligned(16))) __visible
+
 #endif
 
 /* DECLARE_VVAR(offset, type, name) */
 
 DECLARE_VVAR(128, struct vdso_data, _vdso_data)
 
+#if !defined(_SINGLE_DATA)
+#define _SINGLE_DATA
+DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+#endif
+
 #undef DECLARE_VVAR
+#undef DECLARE_VVAR_SINGLE
 
 #endif
diff --git a/drivers/char/random.c b/drivers/char/random.c
index c8cc23515568..814bc11325be 100644
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
@@ -59,6 +61,8 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include <vdso/datapage.h>
+#include "../../lib/vdso/getrandom.h"
 
 /*********************************************************************
  *
@@ -146,6 +150,63 @@ EXPORT_SYMBOL(wait_for_random_bytes);
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
+/* The shared data page. */
+DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
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
@@ -221,6 +282,7 @@ static void crng_reseed(void)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
 	WRITE_ONCE(base_crng.birth, jiffies);
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -660,6 +722,7 @@ static void __cold _credit_init_bits(size_t bits)
 		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
+		smp_store_release(&_vdso_rng_data.is_ready, true);
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
@@ -1585,4 +1648,5 @@ static int __init random_sysctls_init(void)
 	return 0;
 }
 device_initcall(random_sysctls_init);
+
 #endif
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..cbacfd923a5c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -109,6 +109,11 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+struct vdso_rng_data {
+	unsigned long generation;
+	bool is_ready;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -120,6 +125,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
diff --git a/lib/crypto/chacha.c b/lib/crypto/chacha.c
index b748fd3d256e..944991bb36c7 100644
--- a/lib/crypto/chacha.c
+++ b/lib/crypto/chacha.c
@@ -17,8 +17,10 @@ static void chacha_permute(u32 *x, int nrounds)
 {
 	int i;
 
+#ifndef CHACHA_FOR_VDSO_INCLUDE
 	/* whitelist the allowed round counts */
 	WARN_ON_ONCE(nrounds != 20 && nrounds != 12);
+#endif
 
 	for (i = 0; i < nrounds; i += 2) {
 		x[0]  += x[4];    x[12] = rol32(x[12] ^ x[0],  16);
@@ -87,6 +89,7 @@ void chacha_block_generic(u32 *state, u8 *stream, int nrounds)
 
 	state[12]++;
 }
+#ifndef CHACHA_FOR_VDSO_INCLUDE
 EXPORT_SYMBOL(chacha_block_generic);
 
 /**
@@ -112,3 +115,4 @@ void hchacha_block_generic(const u32 *state, u32 *stream, int nrounds)
 	memcpy(&stream[4], &x[12], 16);
 }
 EXPORT_SYMBOL(hchacha_block_generic);
+#endif
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..8cef87793017
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/atomic.h>
+#include <linux/fs.h>
+#include <vdso/datapage.h>
+#include <asm/vdso/getrandom.h>
+#include <asm/vdso/vsyscall.h>
+#include "getrandom.h"
+
+#undef memcpy
+#define memcpy(d,s,l) __builtin_memcpy(d,s,l)
+#undef memset
+#define memset(d,c,l) __builtin_memset(d,c,l)
+
+#define CHACHA_FOR_VDSO_INCLUDE
+#include "../crypto/chacha.c"
+
+static void memcpy_and_zero(void *dst, void *src, size_t len)
+{
+#define CASCADE(type) \
+	while (len >= sizeof(type)) { \
+		*(type *)dst = *(type *)src; \
+		*(type *)src = 0; \
+		dst += sizeof(type); \
+		src += sizeof(type); \
+		len -= sizeof(type); \
+	}
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#if BITS_PER_LONG == 64
+	CASCADE(u64);
+#endif
+	CASCADE(u32);
+	CASCADE(u16);
+#endif
+	CASCADE(u8);
+#undef CASCADE
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+{
+	struct vgetrandom_state *state = opaque_state;
+	const struct vdso_rng_data *rng_info = __arch_get_vdso_rng_data();
+	const struct vdso_data *timebase = &__arch_get_vdso_data()[CS_HRES_COARSE];
+	const struct vdso_timestamp *course_mono = &timebase->basetime[CLOCK_MONOTONIC_COARSE];
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
+	size_t batch_len;
+
+	if (unlikely(!rng_info->is_ready))
+		return getrandom_syscall(buffer, len, flags);
+
+	if (unlikely(!len))
+		return 0;
+
+	if (unlikely(!READ_ONCE(state->not_forked)))
+		state->not_forked = true;
+
+retry_generation:
+	if (unlikely(state->generation != READ_ONCE(rng_info->generation) ||
+		     /* 15 sec is crude approximation of crng_has_old_seed(). In the future,
+		      * export this in rng_info->expiration, or similar. Needs improvement. */
+		     READ_ONCE(course_mono->sec) - state->last_reseed > 15)) {
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
+			return getrandom_syscall(buffer, len, flags);
+		/* We shouldn't be reading rng_info->generation afterwards, as technically it could
+		 * be bumped in between these two lines. Instead this should be set to the value
+		 * read in the `if ()` above. But in fact, the lazy semantics of generation bumping
+		 * always make this happen. So live with this for now. Needs improvement. */
+		state->generation = READ_ONCE(rng_info->generation);
+		state->last_reseed = READ_ONCE(course_mono->sec);
+		state->pos = sizeof(state->batch);
+	}
+
+	len = ret;
+more_batch:
+	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
+	if (batch_len) {
+		memcpy_and_zero(buffer, state->batch + state->pos, batch_len);
+		state->pos += batch_len;
+		buffer += batch_len;
+		len -= batch_len;
+	}
+	if (!len) {
+		if (unlikely(state->generation != READ_ONCE(rng_info->generation)))
+			goto retry_generation;
+		if (unlikely(!READ_ONCE(state->not_forked))) {
+			state->not_forked = true;
+			goto retry_generation;
+		}
+		return ret;
+	}
+
+	chacha_init_consts(chacha_state);
+	memcpy(&chacha_state[4], state->key, CHACHA_KEY_SIZE);
+	memset(&chacha_state[12], 0, sizeof(u32) * 4);
+
+	while (len >= CHACHA_BLOCK_SIZE) {
+		chacha20_block(chacha_state, buffer);
+		if (unlikely(chacha_state[12] == 0))
+			++chacha_state[13];
+		buffer += CHACHA_BLOCK_SIZE;
+		len -= CHACHA_BLOCK_SIZE;
+	}
+
+	chacha20_block(chacha_state, state->key_batch);
+	if (unlikely(chacha_state[12] == 0))
+		++chacha_state[13];
+	chacha20_block(chacha_state, state->key_batch + CHACHA_BLOCK_SIZE);
+	state->pos = 0;
+	memzero_explicit(chacha_state, sizeof(chacha_state));
+	goto more_batch;
+}
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
2.37.3

