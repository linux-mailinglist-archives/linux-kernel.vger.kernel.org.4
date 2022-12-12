Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6C64A7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiLLS4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbiLLSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:54:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B63FE4;
        Mon, 12 Dec 2022 10:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40480B80DF2;
        Mon, 12 Dec 2022 18:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87745C433EF;
        Mon, 12 Dec 2022 18:54:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nVktbNJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670871262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pK5K/E/OTn0ccKL9CkNHCWqlTrJCO7F2tbML62/NB7I=;
        b=nVktbNJbuo+tAZCboLc020lwmBzQNO2INn7qtRpn28bSWfe01IzMSJzmq/HSnUjKM391nn
        P4cp+YX6UJwzBKoU2a5+beLEmkERSfeb0N/4d0dJNmcoNyz5rcFlAcn/PT/srBlxVpERSU
        GgTTDT4+OGmJuv8ohipHu6+4ix4SEGk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f343605e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Dec 2022 18:54:22 +0000 (UTC)
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
        Christian Brauner <brauner@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>
Subject: [PATCH v12 6/6] x86: vdso: Wire up getrandom() vDSO implementation
Date:   Mon, 12 Dec 2022 11:53:47 -0700
Message-Id: <20221212185347.1286824-7-Jason@zx2c4.com>
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

Hook up the generic vDSO implementation to the x86 vDSO data page. Since
the existing vDSO infrastructure is heavily based on the timekeeping
functionality, which works over arrays of bases, a new macro is
introduced for vvars that are not arrays.

The vDSO function requires a ChaCha20 implementation that does not write
to the stack, yet can still do an entire ChaCha20 permutation, so
provide this using SSE2, since this is userland code that must work on
all x86-64 processors. There's a simple test for this code as well.

Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S       | 177 ++++++++++++++++++
 arch/x86/entry/vdso/vgetrandom.c              |  17 ++
 arch/x86/include/asm/vdso/getrandom.h         |  55 ++++++
 arch/x86/include/asm/vdso/vsyscall.h          |   2 +
 arch/x86/include/asm/vvar.h                   |  16 ++
 tools/testing/selftests/vDSO/.gitignore       |   1 +
 tools/testing/selftests/vDSO/Makefile         |   9 +
 .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++++
 11 files changed, 325 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..357148c4a3a4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -269,6 +269,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3e88b9df8c8f..2de64e52236a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -27,7 +27,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o vgetrandom-chacha.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
@@ -104,6 +104,7 @@ CFLAGS_REMOVE_vclock_gettime.o = -pg
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
diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
new file mode 100644
index 000000000000..91fbb7ac7af4
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+.section	.rodata.cst16.CONSTANTS, "aM", @progbits, 16
+.align 16
+CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
+.text
+
+/*
+ * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
+ * of blocks of output with a nonce of 0, taking an input key and 8-byte
+ * counter. Importantly does not spill to the stack. Its arguments are:
+ *
+ *	rdi: output bytes
+ *	rsi: 32-byte key input
+ *	rdx: 8-byte counter input/output
+ *	rcx: number of 64-byte blocks to write to output
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+
+#define output  %rdi
+#define key     %rsi
+#define counter %rdx
+#define nblocks %rcx
+#define i       %al
+#define state0  %xmm0
+#define state1  %xmm1
+#define state2  %xmm2
+#define state3  %xmm3
+#define copy0   %xmm4
+#define copy1   %xmm5
+#define copy2   %xmm6
+#define copy3   %xmm7
+#define temp    %xmm8
+#define one     %xmm9
+
+	/* copy0 = "expand 32-byte k" */
+	movaps		CONSTANTS(%rip),copy0
+	/* copy1,copy2 = key */
+	movups		0x00(key),copy1
+	movups		0x10(key),copy2
+	/* copy3 = counter || zero nonce */
+	movq		0x00(counter),copy3
+	/* one = 1 || 0 */
+	movq		$1,%rax
+	movq		%rax,one
+
+.Lblock:
+	/* state0,state1,state2,state3 = copy0,copy1,copy2,copy3 */
+	movdqa		copy0,state0
+	movdqa		copy1,state1
+	movdqa		copy2,state2
+	movdqa		copy3,state3
+
+	movb		$10,i
+.Lpermute:
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] = state1[0,3,2,1] */
+	pshufd		$0x39,state1,state1
+	/* state2[0,1,2,3] = state2[1,0,3,2] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] = state3[2,1,0,3] */
+	pshufd		$0x93,state3,state3
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] = state1[2,1,0,3] */
+	pshufd		$0x93,state1,state1
+	/* state2[0,1,2,3] = state2[1,0,3,2] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] = state3[0,3,2,1] */
+	pshufd		$0x39,state3,state3
+
+	decb		i
+	jnz		.Lpermute
+
+	/* output0 = state0 + copy0 */
+	paddd		copy0,state0
+	movups		state0,0x00(output)
+	/* output1 = state1 + copy1 */
+	paddd		copy1,state1
+	movups		state1,0x10(output)
+	/* output2 = state2 + copy2 */
+	paddd		copy2,state2
+	movups		state2,0x20(output)
+	/* output3 = state3 + copy3 */
+	paddd		copy3,state3
+	movups		state3,0x30(output)
+
+	/* ++copy3.counter */
+	paddq		one,copy3
+
+	/* output += 64, --nblocks */
+	addq		$64,output
+	decq		nblocks
+	jnz		.Lblock
+
+	/* counter = copy3.counter */
+	movq		copy3,0x00(counter)
+
+	/* Zero out the potentially sensitive regs, in case nothing uses these again. */
+	pxor		state0,state0
+	pxor		state1,state1
+	pxor		state2,state2
+	pxor		state3,state3
+	pxor		copy1,copy1
+	pxor		copy2,copy2
+	pxor		temp,temp
+
+	ret
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
new file mode 100644
index 000000000000..6045ded5da90
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#include <linux/types.h>
+
+#include "../../../../lib/vdso/getrandom.c"
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *state);
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
index 000000000000..46f99d735ae6
--- /dev/null
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -0,0 +1,55 @@
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
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns the number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
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
+		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);
+	return &__vdso_rng_data;
+}
+
+/**
+ * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
+ * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
+ * @key:	32-byte input key.
+ * @counter:	8-byte counter, read on input and updated on return.
+ * @nblocks:	Number of blocks to generate.
+ *
+ * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
+ * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
+ * leaking into forked child processes.
+ */
+extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index be199a9b2676..71c56586a22f 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -11,6 +11,8 @@
 #include <asm/vvar.h>
 
 DEFINE_VVAR(struct vdso_data, _vdso_data);
+DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
+
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
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
diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 7dbfdec53f3d..30d5c8f0e5c7 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -7,3 +7,4 @@ vdso_test_gettimeofday
 vdso_test_getcpu
 vdso_standalone_test_x86
 vdso_test_getrandom
+vdso_test_chacha
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index a33b4d200a32..1b9057974693 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -3,6 +3,7 @@ include ../lib.mk
 
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
 
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
@@ -12,9 +13,15 @@ TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_getrandom
+ifeq ($(uname_M),x86_64)
+ifneq ($(SODIUM),)
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_chacha
+endif
+endif
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+CFLAGS_vdso_test_chacha := $(SODIUM) -idirafter $(top_srcdir)/include -idirafter $(top_srcdir)/arch/$(ARCH)/include -D__ASSEMBLY__ -Wa,--noexecstack
 LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
@@ -35,3 +42,5 @@ $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 		-o $@ \
 		$(LDFLAGS_vdso_test_correctness)
 $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
+$(OUTPUT)/vdso_test_chacha: CFLAGS += $(CFLAGS_vdso_test_chacha)
+$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/entry/vdso/vgetrandom-chacha.S
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
new file mode 100644
index 000000000000..bce7a7752b11
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <sodium/crypto_stream_chacha20.h>
+#include <sys/random.h>
+#include <string.h>
+#include <stdint.h>
+#include "../kselftest.h"
+
+extern void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint8_t *key, uint32_t *counter, size_t nblocks);
+
+int main(int argc, char *argv[])
+{
+	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
+	static const uint8_t nonce[8] = { 0 };
+	uint32_t counter[2];
+	uint8_t key[32];
+	uint8_t output1[BLOCK_SIZE * BLOCKS], output2[BLOCK_SIZE * BLOCKS];
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	for (unsigned int trial = 0; trial < TRIALS; ++trial) {
+		if (getrandom(key, sizeof(key), 0) != sizeof(key)) {
+			printf("getrandom() failed!\n");
+			return KSFT_SKIP;
+		}
+		crypto_stream_chacha20(output1, sizeof(output1), nonce, key);
+		for (unsigned int split = 0; split < BLOCKS; ++split) {
+			memset(output2, 'X', sizeof(output2));
+			memset(counter, 0, sizeof(counter));
+			if (split)
+				__arch_chacha20_blocks_nostack(output2, key, counter, split);
+			__arch_chacha20_blocks_nostack(output2 + split * BLOCK_SIZE, key, counter, BLOCKS - split);
+			if (memcmp(output1, output2, sizeof(output1)))
+				return KSFT_FAIL;
+		}
+	}
+	ksft_test_result_pass("chacha: PASS\n");
+	return KSFT_PASS;
+}
-- 
2.38.1

