Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0954C667CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjALRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjALRpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:45:22 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199448CD8;
        Thu, 12 Jan 2023 09:04:16 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 90EBF780357;
        Thu, 12 Jan 2023 18:03:58 +0100 (CET)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: [RFC PATCH 3/4] x86: vdso: Wire up getrandom() vDSO implementation.
Date:   Thu, 12 Jan 2023 18:02:35 +0100
Message-Id: <c85e9dabec96577783a9b4053e11a4bb0bceb6c3.1673539719.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1673539719.git.ydroneaud@opteya.com>
References: <cover.1673539719.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

Hook up the generic vDSO implementation to the x86 vDSO data page.
Since the existing vDSO infrastructure is heavily based on the
timekeeping functionality, which works over arrays of bases,
a new macro is introduced for vvars that are not arrays.

Based on Jason A. Donenfeld patch [1]
"[PATCH v14 7/7] x86: vdso: Wire up getrandom() vDSO implementation"
removing the ChaCha20 implementation and opaque state argument
from vDSO getrandom().

[1] https://lore.kernel.org/all/20230101162910.710293-8-Jason@zx2c4.com/

Link: https://lore.kernel.org/all/cover.1673539719.git.ydroneaud@opteya.com/
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 arch/x86/Kconfig                      |  1 +
 arch/x86/entry/vdso/Makefile          |  3 +-
 arch/x86/entry/vdso/vdso.lds.S        |  2 ++
 arch/x86/entry/vdso/vgetrandom.c      | 17 +++++++++++
 arch/x86/include/asm/vdso/getrandom.h | 42 +++++++++++++++++++++++++++
 arch/x86/include/asm/vdso/vsyscall.h  |  2 ++
 arch/x86/include/asm/vvar.h           | 16 ++++++++++
 7 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..df48387f019f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -272,6 +272,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 838613ac15b8..2565c4702f54 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -27,7 +27,7 @@ VDSO32-$(CONFIG_X86_32)		:= y
 VDSO32-$(CONFIG_IA32_EMULATION)	:= y
 
 # files to link into the vdso
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
@@ -105,6 +105,7 @@ CFLAGS_REMOVE_vclock_gettime.o = -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
 CFLAGS_REMOVE_vsgx.o = -pg
+CFLAGS_REMOVE_vgetrandom.o = -pg
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index e8c60ae7a7c8..0bab5f4af6d1 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -30,6 +30,8 @@ VERSION {
 #ifdef CONFIG_X86_SGX
 		__vdso_sgx_enter_enclave;
 #endif
+		getrandom;
+		__vdso_getrandom;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
new file mode 100644
index 000000000000..157a6f7dbc44
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
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags);
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags)
+{
+	return __cvdso_getrandom(buffer, len, flags);
+}
+
+ssize_t getrandom(void *, size_t, unsigned int)
+	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..14247ddc431a
--- /dev/null
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -0,0 +1,42 @@
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
+ * @buffer:	Input/Output buffer.
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
-- 
2.37.2

