Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16124637DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKXQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKXQ43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:56:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A47617A509;
        Thu, 24 Nov 2022 08:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA65FB82899;
        Thu, 24 Nov 2022 16:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18165C433C1;
        Thu, 24 Nov 2022 16:56:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IuPHJ85H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1669308968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgRJ5rn5AVu2P+Egwx8pzLTAsbm29wfp/I0VqWSPpYA=;
        b=IuPHJ85HPz8JbCNDkMGw1FRI9GjHN8MSUyEwr+PvmjYd6tcbduvcfmOYq+xSCeqz5PtT16
        25JPmbEupJCq2o235nWgwit0AKRiTKZi29kql8wZFu0l+21x5HqO60J8ArKzl36MKmzwY5
        L4NMnrOnnHglIIPIO5hxiX0LkvFj0sY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70b2281a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 24 Nov 2022 16:56:08 +0000 (UTC)
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
Subject: [PATCH v7 2/3] random: introduce generic vDSO getrandom() implementation
Date:   Thu, 24 Nov 2022 17:55:35 +0100
Message-Id: <20221124165536.1631325-3-Jason@zx2c4.com>
In-Reply-To: <20221124165536.1631325-1-Jason@zx2c4.com>
References: <20221124165536.1631325-1-Jason@zx2c4.com>
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
in order to maintain forward secrecy, so this is left as an
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

Together with the previous commit that introduces vgetrandom_alloc(),
this functionality is intended to be integrated into libc's thread
management. As an illustrative example, the following code might be used
to do the same outside of libc. All of the static functions are to be
considered implementation private, including the vgetrandom_alloc()
syscall wrapper, which generally shouldn't be exposed outside of libc,
with the non-static vgetrandom() function at the end being the exported
interface. The various pthread-isms are expected to be elided into libc
internals. This per-thread allocation scheme is very naive and does not
shrink; other implementations may choose to be more complex.

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
 drivers/char/random.c   |   9 ++++
 include/vdso/datapage.h |   6 +++
 lib/vdso/Kconfig        |   5 ++
 lib/vdso/getrandom.c    | 114 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+)
 create mode 100644 lib/vdso/getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 843dd6a49538..e0aa33f54c57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17287,6 +17287,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	lib/vdso/getrandom.c
 F:	lib/vdso/getrandom.h
 
 RAPIDIO SUBSYSTEM
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 71db7b787a60..35ac2d4d0726 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -61,6 +61,9 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#ifdef CONFIG_HAVE_VDSO_GETRANDOM
+#include <vdso/datapage.h>
+#endif
 #include "../../lib/vdso/getrandom.h"
 
 /*********************************************************************
@@ -328,6 +331,9 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+#ifdef CONFIG_HAVE_VDSO_GETRANDOM
+	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
+#endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -778,6 +784,9 @@ static void __cold _credit_init_bits(size_t bits)
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
 		atomic_notifier_call_chain(&random_ready_notifier, 0, NULL);
+#ifdef CONFIG_HAVE_VDSO_GETRANDOM
+		smp_store_release(&_vdso_rng_data.is_ready, true);
+#endif
 		wake_up_interruptible(&crng_init_wait);
 		kill_fasync(&fasync, SIGIO, POLL_IN);
 		pr_notice("crng init done\n");
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
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..c35fac664574 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -30,4 +30,9 @@ config GENERIC_VDSO_TIME_NS
 	  Selected by architectures which support time namespaces in the
 	  VDSO
 
+config HAVE_VDSO_GETRANDOM
+	bool
+	help
+	  Selected by architectures that support vDSO getrandom().
+
 endif
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..2c4ef5ef212c
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,114 @@
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
+static void memcpy_and_zero(void *dst, void *src, size_t len)
+{
+#define CASCADE(type) \
+	while (len >= sizeof(type)) { \
+		__put_unaligned_t(type, __get_unaligned_t(type, src), dst); \
+		__put_unaligned_t(type, 0, src); \
+		dst += sizeof(type); \
+		src += sizeof(type); \
+		len -= sizeof(type); \
+	}
+#if IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
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
+__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
+		       unsigned int flags, void *opaque_state)
+{
+	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
+	struct vgetrandom_state *state = opaque_state;
+	size_t batch_len, nblocks, orig_len = len;
+	unsigned long current_generation;
+	void *orig_buffer = buffer;
+	u32 counter[2] = { 0 };
+
+	/*
+	 * If the kernel isn't yet initialized, then the various flags might have some effect
+	 * that we can't emulate in userspace, so use the syscall.  Otherwise, the flags have
+	 * no effect, and can continue.
+	 */
+	if (unlikely(!rng_info->is_ready))
+		return getrandom_syscall(orig_buffer, orig_len, flags);
+
+	if (unlikely(!len))
+		return 0;
+
+retry_generation:
+	current_generation = READ_ONCE(rng_info->generation);
+	if (unlikely(state->generation != current_generation)) {
+		/* Write the generation before filling the key, in case there's a fork before. */
+		WRITE_ONCE(state->generation, current_generation);
+		/* If the generation is wrong, the kernel has reseeded, so we should too. */
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
+			return getrandom_syscall(orig_buffer, orig_len, flags);
+		/* Set state->pos so that the batch is considered emptied. */
+		state->pos = sizeof(state->batch);
+	}
+
+	len = ret;
+more_batch:
+	/* First use whatever is left from the last call. */
+	batch_len = min_t(size_t, sizeof(state->batch) - state->pos, len);
+	if (batch_len) {
+		/* Zero out bytes as they're copied out, to preserve forward secrecy. */
+		memcpy_and_zero(buffer, state->batch + state->pos, batch_len);
+		state->pos += batch_len;
+		buffer += batch_len;
+		len -= batch_len;
+	}
+	if (!len) {
+		/*
+		 * Since rng_info->generation will never be 0, we re-read state->generation,
+		 * rather than using the local current_generation variable, to learn whether
+		 * we forked. Primarily, though, this indicates whether the rng itself has
+		 * reseeded, in which case we should generate a new key and start over.
+		 */
+		if (unlikely(READ_ONCE(state->generation) != READ_ONCE(rng_info->generation))) {
+			buffer = orig_buffer;
+			goto retry_generation;
+		}
+		return ret;
+	}
+
+	/* Generate blocks of rng output directly into the buffer while there's enough left. */
+	nblocks = len / CHACHA_BLOCK_SIZE;
+	if (nblocks) {
+		__arch_chacha20_blocks_nostack(buffer, state->key, counter, nblocks);
+		buffer += nblocks * CHACHA_BLOCK_SIZE;
+		len -= nblocks * CHACHA_BLOCK_SIZE;
+	}
+
+	/* Refill the batch and then overwrite the key, in order to preserve forward secrecy. */
+	BUILD_BUG_ON(sizeof(state->batch_key) % CHACHA_BLOCK_SIZE != 0);
+	__arch_chacha20_blocks_nostack(state->batch_key, state->key, counter,
+				       sizeof(state->batch_key) / CHACHA_BLOCK_SIZE);
+	state->pos = 0;
+	goto more_batch;
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state)
+{
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags, opaque_state);
+}
-- 
2.38.1

