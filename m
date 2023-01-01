Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F6565AAA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjAAQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjAAQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 11:30:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E654270F;
        Sun,  1 Jan 2023 08:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F6C0CE0966;
        Sun,  1 Jan 2023 16:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E963C433D2;
        Sun,  1 Jan 2023 16:29:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ReEeb4ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672590575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=prx2b8vq1vkRmhJLnOKcfpUoc8vEOF/dFXHF/w6dCUo=;
        b=ReEeb4obRrwZgwLoMAIItqvr7E+P4kIpJ6LURzHodHR9RwDo/58Lb8zfIgNh6uEWRC605B
        QieYF8qiOLAEvF+Fi6XtRFhDdQoV1N71l9K/VTNT2B9xl55fvUCuWrXB1TtiI5OtDcYC2y
        5/y+JPlmJBKW4RxoM8V+RXzzxS7PGe8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 02dba2a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 1 Jan 2023 16:29:35 +0000 (UTC)
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
Subject: [PATCH v14 6/7] random: introduce generic vDSO getrandom() implementation
Date:   Sun,  1 Jan 2023 17:29:09 +0100
Message-Id: <20230101162910.710293-7-Jason@zx2c4.com>
In-Reply-To: <20230101162910.710293-1-Jason@zx2c4.com>
References: <20230101162910.710293-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a generic C vDSO getrandom() implementation, which operates on
an opaque state returned by vgetrandom_alloc() and produces random bytes
the same way as getrandom(). This has a the API signature:

  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);

The return value and the first 3 arguments are the same as ordinary
getrandom(), while the last argument is a pointer to the opaque
allocated state. Were all four arguments passed to the getrandom()
syscall, nothing different would happen, and the functions would have
the exact same behavior.

The actual vDSO RNG algorithm implemented is the same one implemented by
drivers/char/random.c, using the same fast-erasure techniques as that.
Should the in-kernel implementation change, so too will the vDSO one.

It requires an implementation of ChaCha20 that does not use any stack,
in order to maintain forward secrecy if a multi-threaded program forks
(though this does not account for a similar issue with SA_SIGINFO
copying registers to the stack), so this is left as an
architecture-specific fill-in. Stack-less ChaCha20 is an easy algorithm
to implement on a variety of architectures, so this shouldn't be too
onerous.

Initially, the state is keyless, and so the first call makes a
getrandom() syscall to generate that key, and then uses it for
subsequent calls. By keeping track of a generation counter, it knows
when its key is invalidated and it should fetch a new one using the
syscall. Later, more than just a generation counter might be used.

Since MADV_WIPEONFORK is set on the opaque state, the key and related
state is wiped during a fork(), so secrets don't roll over into new
processes, and the same state doesn't accidentally generate the same
random stream. The generation counter, as well, is always >0, so that
the 0 counter is a useful indication of a fork() or otherwise
uninitialized state.

If the kernel RNG is not yet initialized, then the vDSO always calls the
syscall, because that behavior cannot be emulated in userspace, but
fortunately that state is short lived and only during early boot. If it
has been initialized, then there is no need to inspect the `flags`
argument, because the behavior does not change post-initialization
regardless of the `flags` value.

Since the opaque state passed to it is mutated, vDSO getrandom() is not
reentrant, when used with the same opaque state, which libc should be
mindful of.

vgetrandom_alloc() and vDSO getrandom() provide the ability for
userspace to generate random bytes quickly and safely, and are intended
to be integrated into libc's thread management. As an illustrative
example, together with the example code from "random: add
vgetrandom_alloc() syscall", the following code might be used to do the
same outside of libc. In a libc, only the non-static vgetrandom()
function at the end would be exported as part of a getrandom()
implementations, and the various pthread-isms are expected to be elided
into libc internals.

  static struct {
    ssize_t(*fn)(void *buf, size_t len, unsigned long flags, void *state);
    pthread_key_t key;
    pthread_once_t initialized;
  } grnd_ctx = {
    .initialized = PTHREAD_ONCE_INIT
  };

  static void vgetrandom_init(void)
  {
    if (pthread_key_create(&grnd_ctx.key, vgetrandom_put_state) != 0)
      return;
    grnd_ctx.fn = vdso_sym("LINUX_2.6", "__vdso_getrandom");
  }

  ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
  {
    void *state;

    pthread_once(&grnd_ctx.initialized, vgetrandom_init);
    if (!grnd_ctx.fn)
      return getrandom(buf, len, flags);
    state = pthread_getspecific(grnd_ctx.key);
    if (!state) {
      state = vgetrandom_get_state();
      if (pthread_setspecific(grnd_ctx.key, state) != 0) {
        vgetrandom_put_state(state);
        state = NULL;
      }
      if (!state)
        return getrandom(buf, len, flags);
    }
    return grnd_ctx.fn(buf, len, flags, state);
  }

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                                   |   1 +
 drivers/char/random.c                         |  11 +
 include/vdso/datapage.h                       |  12 +
 include/vdso/getrandom.h                      |  32 +-
 include/vdso/types.h                          |  35 +++
 lib/vdso/getrandom.c                          | 224 ++++++++++++++
 tools/testing/selftests/vDSO/.gitignore       |   1 +
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_test_getrandom.c      | 283 ++++++++++++++++++
 9 files changed, 599 insertions(+), 2 deletions(-)
 create mode 100644 include/vdso/types.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e2a1c0b26fc8..045232eba6ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17522,6 +17522,7 @@ S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 F:	include/vdso/getrandom.h
+F:	lib/vdso/getrandom.c
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6425f5f838e0..f3a45711166c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -60,6 +60,7 @@
 #include <crypto/blake2s.h>
 #ifdef CONFIG_VDSO_GETRANDOM
 #include <vdso/getrandom.h>
+#include <vdso/datapage.h>
 #endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
@@ -407,6 +408,13 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+#ifdef CONFIG_VDSO_GETRANDOM
+	/* base_crng.generation's invalid value is ULONG_MAX, while
+	 * _vdso_rng_data.generation's invalid value is 0, so add one to the
+	 * former to arrive at the latter.
+	 */
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+#endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -857,6 +865,9 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
+#ifdef CONFIG_VDSO_GETRANDOM
+		smp_store_release(&_vdso_rng_data.is_ready, true);
+#endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..d1f800c1c718 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -18,6 +18,7 @@
 #include <vdso/time.h>
 #include <vdso/time32.h>
 #include <vdso/time64.h>
+#include <vdso/types.h>
 
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
@@ -109,6 +110,16 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+/**
+ * struct vdso_rng_data - vdso RNG state information
+ * @generation:	counter representing the number of RNG reseeds
+ * @is_ready:	boolean signaling whether the RNG is initialized
+ */
+struct vdso_rng_data {
+	vdso_kernel_ulong	generation;
+	u8			is_ready;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -120,6 +131,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
index e3ceb1976386..7dc93d5f72dc 100644
--- a/include/vdso/getrandom.h
+++ b/include/vdso/getrandom.h
@@ -6,11 +6,39 @@
 #ifndef _VDSO_GETRANDOM_H
 #define _VDSO_GETRANDOM_H
 
+#include <crypto/chacha.h>
+#include <vdso/types.h>
+
 /**
  * struct vgetrandom_state - State used by vDSO getrandom() and allocated by vgetrandom_alloc().
  *
- * Currently empty, as the vDSO getrandom() function has not yet been implemented.
+ * @batch:	One and a half ChaCha20 blocks of buffered RNG output.
+ *
+ * @key:	Key to be used for generating next batch.
+ *
+ * @batch_key:	Union of the prior two members, which is exactly two full
+ * 		ChaCha20 blocks in size, so that @batch and @key can be filled
+ * 		together.
+ *
+ * @generation:	Snapshot of @rng_info->generation in the vDSO data page at
+ *		the time @key was generated.
+ *
+ * @pos:	Offset into @batch of the next available random byte.
+ *
+ * @in_use:	Reentrancy guard for reusing a state within the same thread
+ *		due to signal handlers.
  */
-struct vgetrandom_state { int placeholder; };
+struct vgetrandom_state {
+	union {
+		struct {
+			u8	batch[CHACHA_BLOCK_SIZE * 3 / 2];
+			u32	key[CHACHA_KEY_SIZE / sizeof(u32)];
+		};
+		u8		batch_key[CHACHA_BLOCK_SIZE * 2];
+	};
+	vdso_kernel_ulong	generation;
+	u8			pos;
+	bool 			in_use;
+};
 
 #endif /* _VDSO_GETRANDOM_H */
diff --git a/include/vdso/types.h b/include/vdso/types.h
new file mode 100644
index 000000000000..ce131463aeff
--- /dev/null
+++ b/include/vdso/types.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#ifndef __VDSO_TYPES_H
+#define __VDSO_TYPES_H
+
+#include <linux/types.h>
+
+/**
+ * type vdso_kernel_ulong - unsigned long type that matches kernel's unsigned long
+ *
+ * Data shared between userspace and the kernel must operate the same way in both 64-bit code and in
+ * 32-bit compat code, over the same potentially 64-bit kernel. This type represents the size of an
+ * unsigned long as used by kernel code. This isn't necessarily the same as an unsigned long as used
+ * by userspace, however.
+ *
+ *                 +-------------------+-------------------+------------------+-------------------+
+ *                 | 32-bit userspace  | 32-bit userspace  | 64-bit userspace | 64-bit userspace  |
+ *                 | unsigned long     | vdso_kernel_ulong | unsigned long    | vdso_kernel_ulong |
+ * +---------------+-------------------+-------------------+------------------+-------------------+
+ * | 32-bit kernel | ✓ same size       | ✓ same size       |
+ * | unsigned long |                   |                   |
+ * +---------------+-------------------+-------------------+------------------+-------------------+
+ * | 64-bit kernel | ✘ different size! | ✓ same size       | ✓ same size      | ✓ same size       |
+ * | unsigned long |                   |                   |                  |                   |
+ * +---------------+-------------------+-------------------+------------------+-------------------+
+ */
+#ifdef CONFIG_64BIT
+typedef u64 vdso_kernel_ulong;
+#else
+typedef u32 vdso_kernel_ulong;
+#endif
+
+#endif /* __VDSO_TYPES_H */
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..64ab28913a23
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <vdso/datapage.h>
+#include <vdso/getrandom.h>
+#include <asm/vdso/getrandom.h>
+#include <asm/vdso/vsyscall.h>
+
+#define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
+	while (len >= sizeof(type)) {						\
+		__put_unaligned_t(type, __get_unaligned_t(type, src), dst);	\
+		__put_unaligned_t(type, 0, src);				\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}									\
+} while (0)
+
+static void memcpy_and_zero_src(void *dst, void *src, size_t len)
+{
+	if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
+		if (IS_ENABLED(CONFIG_64BIT))
+			MEMCPY_AND_ZERO_SRC(u64, dst, src, len);
+		MEMCPY_AND_ZERO_SRC(u32, dst, src, len);
+		MEMCPY_AND_ZERO_SRC(u16, dst, src, len);
+	}
+	MEMCPY_AND_ZERO_SRC(u8, dst, src, len);
+}
+
+/**
+ * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
+ * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
+ * @buffer:		Destination buffer to fill with random bytes.
+ * @len:		Size of @buffer in bytes.
+ * @flags:		Zero or more GRND_* flags.
+ * @opaque_state:	Pointer to an opaque state area.
+ *
+ * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
+ * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
+ * schedule that the kernel's RNG is reseeded. If the kernel's RNG is not ready, then this always
+ * calls into the syscall.
+ *
+ * @opaque_state *must* be allocated using the vgetrandom_alloc() syscall.  Unless external locking
+ * is used, one state must be allocated per thread, as it is not safe to call this function
+ * concurrently with the same @opaque_state. However, it is safe to call this using the same
+ * @opaque_state that is shared between main code and signal handling code, within the same thread.
+ *
+ * Returns the number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t
+__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
+		       unsigned int flags, void *opaque_state)
+{
+	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
+	struct vgetrandom_state *state = opaque_state;
+	size_t batch_len, nblocks, orig_len = len;
+	unsigned long current_generation;
+	void *orig_buffer = buffer;
+	u32 counter[2] = { 0 };
+	bool in_use, have_retried = false;
+
+	/* The state must not straddle a page, since pages can be zeroed at any time. */
+	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
+		goto fallback_syscall;
+
+	/*
+	 * If the kernel's RNG is not yet ready, then it's not possible to provide random bytes from
+	 * userspace, because A) the various @flags require this to block, or not, depending on
+	 * various factors unavailable to userspace, and B) the kernel's behavior before the RNG is
+	 * ready is to reseed from the entropy pool at every invocation.
+	 */
+	if (unlikely(!READ_ONCE(rng_info->is_ready)))
+		goto fallback_syscall;
+
+	/*
+	 * This condition is checked after @rng_info->is_ready, because before the kernel's RNG is
+	 * initialized, the @flags parameter may require this to block or return an error, even when
+	 * len is zero.
+	 */
+	if (unlikely(!len))
+		return 0;
+
+	/*
+	 * @state->in_use is basic reentrancy protection against this running in a signal handler
+	 * with the same @opaque_state, but obviously not atomic wrt multiple CPUs or more than one
+	 * level of reentrancy. If a signal interrupts this after reading @state->in_use, but before
+	 * writing @state->in_use, there is still no race, because the signal handler will run to
+	 * its completion before returning execution.
+	 */
+	in_use = READ_ONCE(state->in_use);
+	if (unlikely(in_use))
+		goto fallback_syscall;
+	WRITE_ONCE(state->in_use, true);
+
+retry_generation:
+	/*
+	 * @rng_info->generation must always be read here, as it serializes @state->key with the
+	 * kernel's RNG reseeding schedule.
+	 */
+	current_generation = READ_ONCE(rng_info->generation);
+
+	/*
+	 * If @state->generation doesn't match the kernel RNG's generation, then it means the
+	 * kernel's RNG has reseeded, and so @state->key is reseeded as well.
+	 */
+	if (unlikely(state->generation != current_generation)) {
+		/*
+		 * Write the generation before filling the key, in case of fork. If there is a fork
+		 * just after this line, the two forks will get different random bytes from the
+		 * syscall, which is good. However, were this line to occur after the getrandom
+		 * syscall, then both child and parent could have the same bytes and the same
+		 * generation counter, so the fork would not be detected. Therefore, write
+		 * @state->generation before the call to the getrandom syscall.
+		 */
+		WRITE_ONCE(state->generation, current_generation);
+
+		/* Prevent the syscall from being reordered wrt current_generation. */
+		barrier();
+
+		/* Reseed @state->key using fresh bytes from the kernel. */
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key)) {
+			/*
+			 * If the syscall failed to refresh the key, then @state->key is now
+			 * invalid, so invalidate the generation so that it is not used again, and
+			 * fallback to using the syscall entirely.
+			 */
+			WRITE_ONCE(state->generation, 0);
+
+			/*
+			 * Set @state->in_use to false only after the last write to @state in the
+			 * line above.
+			 */
+			WRITE_ONCE(state->in_use, false);
+
+			goto fallback_syscall;
+		}
+
+		/*
+		 * Set @state->pos to beyond the end of the batch, so that the batch is refilled
+		 * using the new key.
+		 */
+		state->pos = sizeof(state->batch);
+	}
+
+	/* Set len to the total amount of bytes that this function is allowed to read, ret. */
+	len = ret;
+more_batch:
+	/*
+	 * First use bytes out of @state->batch, which may have been filled by the last call to this
+	 * function.
+	 */
+	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
+	if (batch_len) {
+		/* Zeroing at the same time as memcpying helps preserve forward secrecy. */
+		memcpy_and_zero_src(buffer, state->batch + state->pos, batch_len);
+		state->pos += batch_len;
+		buffer += batch_len;
+		len -= batch_len;
+	}
+
+	if (!len) {
+		/* Prevent the loop from being reordered wrt ->generation. */
+		barrier();
+
+		/*
+		 * Since @rng_info->generation will never be 0, re-read @state->generation, rather
+		 * than using the local current_generation variable, to learn whether a fork
+		 * occurred or if @state was zeroed due to memory pressure. Primarily, though, this
+		 * indicates whether the kernel's RNG has reseeded, in which case generate a new key
+		 * and start over.
+		 */
+		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
+			/*
+			 * Prevent this from looping forever in case of low memory or racing with a
+			 * user force-reseeding the kernel's RNG using the ioctl.
+			 */
+			if (have_retried)
+				goto fallback_syscall;
+
+			have_retried = true;
+			buffer = orig_buffer;
+			goto retry_generation;
+		}
+
+		/*
+		 * Set @state->in_use to false only when there will be no more reads or writes of
+		 * @state.
+		 */
+		WRITE_ONCE(state->in_use, false);
+		return ret;
+	}
+
+	/* Generate blocks of RNG output directly into @buffer while there's enough room left. */
+	nblocks = len / CHACHA_BLOCK_SIZE;
+	if (nblocks) {
+		__arch_chacha20_blocks_nostack(buffer, state->key, counter, nblocks);
+		buffer += nblocks * CHACHA_BLOCK_SIZE;
+		len -= nblocks * CHACHA_BLOCK_SIZE;
+	}
+
+	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE != 0);
+
+	/* Refill the batch and then overwrite the key, in order to preserve forward secrecy. */
+	__arch_chacha20_blocks_nostack(state->batch_key, state->key, counter,
+				       sizeof(state->batch_key) / CHACHA_BLOCK_SIZE);
+
+	/* Since the batch was just refilled, set the position back to 0 to indicate a full batch. */
+	state->pos = 0;
+	goto more_batch;
+
+fallback_syscall:
+	return getrandom_syscall(orig_buffer, orig_len, flags);
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+{
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state);
+}
diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index a8dc51af5a9c..7dbfdec53f3d 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -6,3 +6,4 @@ vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
 vdso_standalone_test_x86
+vdso_test_getrandom
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d53a4d8008f9..a33b4d200a32 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -11,6 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_getrandom
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
@@ -33,3 +34,4 @@ $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 		vdso_test_correctness.c \
 		-o $@ \
 		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_getrandom: parse_vdso.c
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
new file mode 100644
index 000000000000..7184e633cec7
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <assert.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/random.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+#include "../kselftest.h"
+#include "parse_vdso.h"
+
+#ifndef timespecsub
+#define	timespecsub(tsp, usp, vsp)					\
+	do {								\
+		(vsp)->tv_sec = (tsp)->tv_sec - (usp)->tv_sec;		\
+		(vsp)->tv_nsec = (tsp)->tv_nsec - (usp)->tv_nsec;	\
+		if ((vsp)->tv_nsec < 0) {				\
+			(vsp)->tv_sec--;				\
+			(vsp)->tv_nsec += 1000000000L;			\
+		}							\
+	} while (0)
+#endif
+
+static void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each)
+{
+	enum { __NR_vgetrandom_alloc = 451 };
+	*size_per_each = 0;
+	return (void *)syscall(__NR_vgetrandom_alloc, num, size_per_each, 0, 0);
+}
+
+static struct {
+	pthread_mutex_t lock;
+	void **states;
+	size_t len, cap;
+} grnd_allocator = {
+	.lock = PTHREAD_MUTEX_INITIALIZER
+};
+
+static void *vgetrandom_get_state(void)
+{
+	void *state = NULL;
+
+	pthread_mutex_lock(&grnd_allocator.lock);
+	if (!grnd_allocator.len) {
+		size_t new_cap;
+		size_t page_size = getpagesize();
+		unsigned int num = sysconf(_SC_NPROCESSORS_ONLN); /* Could be arbitrary, just a hint. */
+		unsigned int size_per_each;
+		void *new_block = vgetrandom_alloc(&num, &size_per_each);
+		void *new_states;
+
+		if (new_block == MAP_FAILED)
+			goto out;
+		new_cap = grnd_allocator.cap + num;
+		new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
+		if (!new_states) {
+			munmap(new_block, num * size_per_each);
+			goto out;
+		}
+		grnd_allocator.cap = new_cap;
+		grnd_allocator.states = new_states;
+
+		for (size_t i = 0; i < num; ++i) {
+			grnd_allocator.states[i] = new_block;
+			if (((uintptr_t)new_block & (page_size - 1)) + size_per_each > page_size)
+				new_block = (void *)(((uintptr_t)new_block + page_size) & (page_size - 1));
+			else
+				new_block += size_per_each;
+		}
+		grnd_allocator.len = num;
+	}
+	state = grnd_allocator.states[--grnd_allocator.len];
+
+out:
+	pthread_mutex_unlock(&grnd_allocator.lock);
+	return state;
+}
+
+static void vgetrandom_put_state(void *state)
+{
+	if (!state)
+		return;
+	pthread_mutex_lock(&grnd_allocator.lock);
+	grnd_allocator.states[grnd_allocator.len++] = state;
+	pthread_mutex_unlock(&grnd_allocator.lock);
+}
+
+static struct {
+	ssize_t(*fn)(void *buf, size_t len, unsigned long flags, void *state);
+	pthread_key_t key;
+	pthread_once_t initialized;
+} grnd_ctx = {
+	.initialized = PTHREAD_ONCE_INIT
+};
+
+static void vgetrandom_init(void)
+{
+	if (pthread_key_create(&grnd_ctx.key, vgetrandom_put_state) != 0)
+		return;
+	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		exit(KSFT_SKIP);
+	}
+	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
+	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
+	if (!grnd_ctx.fn) {
+		printf("__vdso_getrandom is missing!\n");
+		exit(KSFT_FAIL);
+	}
+}
+
+static ssize_t vgetrandom(void *buf, size_t len, unsigned long flags)
+{
+	void *state;
+
+	pthread_once(&grnd_ctx.initialized, vgetrandom_init);
+	state = pthread_getspecific(grnd_ctx.key);
+	if (!state) {
+		state = vgetrandom_get_state();
+		if (pthread_setspecific(grnd_ctx.key, state) != 0) {
+			vgetrandom_put_state(state);
+			state = NULL;
+		}
+		if (!state) {
+			printf("vgetrandom_get_state failed!\n");
+			exit(KSFT_FAIL);
+		}
+	}
+	return grnd_ctx.fn(buf, len, flags, state);
+}
+
+enum { TRIALS = 25000000, THREADS = 256 };
+
+static void *test_vdso_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = vgetrandom(&val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void *test_libc_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = getrandom(&val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void *test_syscall_getrandom(void *)
+{
+	for (size_t i = 0; i < TRIALS; ++i) {
+		unsigned int val;
+		ssize_t ret = syscall(SYS_getrandom, &val, sizeof(val), 0);
+		assert(ret == sizeof(val));
+	}
+	return NULL;
+}
+
+static void bench_single(void)
+{
+	struct timespec start, end, diff;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_vdso_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   vdso: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_libc_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   libc: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	test_syscall_getrandom(NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("syscall: %u times in %lu.%09lu seconds\n", TRIALS, diff.tv_sec, diff.tv_nsec);
+}
+
+static void bench_multi(void)
+{
+	struct timespec start, end, diff;
+	pthread_t threads[THREADS];
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_vdso_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   vdso: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_libc_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   libc: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (size_t i = 0; i < THREADS; ++i)
+		assert(pthread_create(&threads[i], NULL, test_syscall_getrandom, NULL) == 0);
+	for (size_t i = 0; i < THREADS; ++i)
+		pthread_join(threads[i], NULL);
+	clock_gettime(CLOCK_MONOTONIC, &end);
+	timespecsub(&end, &start, &diff);
+	printf("   syscall: %u x %u times in %lu.%09lu seconds\n", TRIALS, THREADS, diff.tv_sec, diff.tv_nsec);
+}
+
+static void fill(void)
+{
+	uint8_t weird_size[323929];
+	for (;;)
+		vgetrandom(weird_size, sizeof(weird_size), 0);
+}
+
+static void kselftest(void)
+{
+	uint8_t weird_size[1263];
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	for (size_t i = 0; i < 1000; ++i) {
+		ssize_t ret = vgetrandom(weird_size, sizeof(weird_size), 0);
+		if (ret != sizeof(weird_size))
+			exit(KSFT_FAIL);
+	}
+
+	ksft_test_result_pass("getrandom: PASS\n");
+	exit(KSFT_PASS);
+}
+
+static void usage(const char *argv0)
+{
+	fprintf(stderr, "Usage: %s [bench-single|bench-multi|fill]\n", argv0);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc == 1) {
+		kselftest();
+		return 0;
+	}
+
+	if (argc != 2) {
+		usage(argv[0]);
+		return 1;
+	}
+	if (!strcmp(argv[1], "bench-single"))
+		bench_single();
+	else if (!strcmp(argv[1], "bench-multi"))
+		bench_multi();
+	else if (!strcmp(argv[1], "fill"))
+		fill();
+	else {
+		usage(argv[0]);
+		return 1;
+	}
+	return 0;
+}
-- 
2.39.0

