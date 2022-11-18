Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B942062FBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiKRRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiKRRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:32:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280108B13D;
        Fri, 18 Nov 2022 09:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59A46268B;
        Fri, 18 Nov 2022 17:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267DBC433D7;
        Fri, 18 Nov 2022 17:32:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CA4UvkNZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668792720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9p1UIdcHRziM7m9qcPYp6vWPtjBY0MybeVn0TVZVSIU=;
        b=CA4UvkNZOFiaNqpDzRS53bJWuvypQSw1i9RuqmYM4MNPUbZy5P0j0bfJZxeE9eSLg4IaZM
        /62QGDuhxJy+hPb0XOCQ6zLTo6xgvYw+pY1OBrKOVzavS1vVDVkK1D7At0IlZmtWxL+82D
        SN5HA8YTwsOblwTRcmy4jgr8rZjWmlA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ec53f12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 18 Nov 2022 17:31:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: [PATCH v4 2/3] random: introduce generic vDSO getrandom() implementation
Date:   Fri, 18 Nov 2022 18:28:38 +0100
Message-Id: <20221118172839.2653829-3-Jason@zx2c4.com>
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

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS             |   1 +
 drivers/char/random.c   |   5 ++
 include/vdso/datapage.h |   6 +++
 lib/crypto/chacha.c     |   4 ++
 lib/vdso/Kconfig        |   5 ++
 lib/vdso/getrandom.c    | 109 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+)
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
index b83481eb00a9..a62255d852f9 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -61,6 +61,7 @@
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/io.h>
+#include <vdso/datapage.h>
 #include "../../lib/vdso/getrandom.h"
 
 /*********************************************************************
@@ -305,6 +306,8 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+	if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
+		smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
@@ -754,6 +757,8 @@ static void __cold _credit_init_bits(size_t bits)
 		crng_reseed(NULL); /* Sets crng_init to CRNG_READY under base_crng.lock. */
 		if (static_key_initialized)
 			execute_in_process_context(crng_set_ready, &set_ready);
+		if (IS_ENABLED(CONFIG_HAVE_VDSO_GETRANDOM))
+			smp_store_release(&_vdso_rng_data.is_ready, true);
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
index 000000000000..b253e9247706
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,109 @@
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
+	u32 chacha_state[CHACHA_STATE_WORDS];
+	ssize_t ret = min_t(size_t, MAX_RW_COUNT, len);
+	unsigned long current_generation;
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
+	current_generation = READ_ONCE(rng_info->generation);
+	if (unlikely(state->generation != current_generation)) {
+		if (getrandom_syscall(state->key, sizeof(state->key), 0) != sizeof(state->key))
+			return getrandom_syscall(buffer, len, flags);
+		state->generation = current_generation;
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
+		if (unlikely(current_generation != READ_ONCE(rng_info->generation)))
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
-- 
2.38.1

