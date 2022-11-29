Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5B63C91D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiK2UQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiK2UQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:16:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97A5FB96;
        Tue, 29 Nov 2022 12:16:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F17AAB81902;
        Tue, 29 Nov 2022 20:16:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70515C433B5;
        Tue, 29 Nov 2022 20:16:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="p59WQLeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669752974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNiuwmSJOw6Ap+zxCQGqOrHjw6UOb8uPbeHwYkOyWQY=;
        b=p59WQLeFWhEF469M7kRt/CQUhB8t4nB3VMr6hXhxXnKe5dNpz1TWbn7w972scZAUsx69jr
        J8N8J5HsSoWwbY0GUq6cBr9pQplhaMSeHxmlqWpwNEvXT2wAvNMGsrbNcWOPO0+1kDLfIv
        dycsCzDdrzrXdqCxeXfNNGeMcWRqHuM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3163369 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Nov 2022 20:16:14 +0000 (UTC)
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
Subject: [PATCH v9 2/3] random: introduce generic vDSO getrandom() implementation
Date:   Tue, 29 Nov 2022 21:15:58 +0100
Message-Id: <20221129201559.39449-3-Jason@zx2c4.com>
In-Reply-To: <20221129201559.39449-1-Jason@zx2c4.com>
References: <20221129201559.39449-1-Jason@zx2c4.com>
MIME-Version: 1.0
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

vgetrandom_alloc() and vDSO getrandom() together provide the ability for
userspace to generate random bytes quickly and safely, and is intended
to be integrated into libc's thread management. As an illustrative
example, the following code might be used to do the same outside of
libc. All of the static functions are to be considered implementation
private, including the vgetrandom_alloc() syscall wrapper, which
generally shouldn't be exposed outside of libc, with the non-static
vgetrandom() function at the end being the exported interface. The
various pthread-isms are expected to be elided into libc internals. This
per-thread allocation scheme is very naive and does not shrink; other
implementations may choose to be more complex.

  static void *vgetrandom_alloc(unsigned int *num, unsigned int *size_per_each, unsigned int flags)
  {
    long ret = syscall(__NR_vgetrandom_alloc, &num, &size_per_each, flags);
    return ret == -1 ? NULL : (void *)ret;
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
      unsigned int size_per_each, num = 16; /* Just a hint. Could also be nr_cpus. */
      void *new_block = vgetrandom_alloc(&num, &size_per_each, 0), *new_states;

      if (!new_block)
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
    grnd_ctx.fn = __vdsosym("LINUX_2.6", "__vdso_getrandom");
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
 MAINTAINERS             |   1 +
 drivers/char/random.c   |   9 ++
 include/vdso/datapage.h |  11 +++
 lib/vdso/Kconfig        |   7 +-
 lib/vdso/getrandom.c    | 204 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100644 lib/vdso/getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3894f947a507..70dff39fcff9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17288,6 +17288,7 @@ S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 F:	include/vdso/getrandom.h
+F:	lib/vdso/getrandom.c
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index b81d67f3ebab..b37a3f9367a9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -60,6 +60,9 @@
 #ifdef CONFIG_VGETRANDOM_ALLOC_SYSCALL
 #include <vdso/getrandom.h>
 #endif
+#ifdef CONFIG_VDSO_GETRANDOM
+#include <vdso/datapage.h>
+#endif
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
@@ -344,6 +347,9 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+#ifdef CONFIG_VDSO_GETRANDOM
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+#endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -794,6 +800,9 @@ static void __cold _credit_init_bits(size_t bits)
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
index 73eb622e7663..9ae4d76b36c7 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -109,6 +109,16 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+/**
+ * struct vdso_rng_data - vdso RNG state information
+ * @generation:	a counter representing the number of RNG reseeds
+ * @is_ready:	whether the RNG is initialized
+ */
+struct vdso_rng_data {
+	unsigned long	generation;
+	bool		is_ready;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -120,6 +130,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index b22584f8da03..f12b76642921 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -29,7 +29,6 @@ config GENERIC_VDSO_TIME_NS
 	help
 	  Selected by architectures which support time namespaces in the
 	  VDSO
-
 endif
 
 config VGETRANDOM_ALLOC_SYSCALL
@@ -38,3 +37,9 @@ config VGETRANDOM_ALLOC_SYSCALL
 	help
 	  Selected by the getrandom() vDSO function, which requires this
 	  for state allocation.
+
+config VDSO_GETRANDOM
+	bool
+	select VGETRANDOM_ALLOC_SYSCALL
+	help
+	  Selected by architectures that support vDSO getrandom().
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..1c51e24a7f24
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,204 @@
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
+#define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do { \
+	while (len >= sizeof(type)) { \
+		__put_unaligned_t(type, __get_unaligned_t(type, src), dst); \
+		__put_unaligned_t(type, 0, src); \
+		dst += sizeof(type); \
+		src += sizeof(type); \
+		len -= sizeof(type); \
+	} \
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
+ * __cvdso_getrandom_data - generic vDSO implementation of getrandom() syscall
+ * @rng_info:		describes state of kernel RNG, memory shared with kernel
+ * @buffer:		destination buffer to fill with random bytes
+ * @len:		size of @buffer in bytes
+ * @flags:		zero or more GRND_* flags
+ * @opaque_state:	a pointer to an opaque state area
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
+	bool in_use;
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
+		/*
+		 * Since @rng_info->generation will never be 0, re-read @state->generation, rather
+		 * than using the local current_generation variable, to learn whether a fork
+		 * occurred. Primarily, though, this indicates whether the kernel's RNG has
+		 * reseeded, in which case generate a new key and start over.
+		 */
+		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
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
-- 
2.38.1

