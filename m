Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6661D667CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjALRqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbjALRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:44:59 -0500
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760644378;
        Thu, 12 Jan 2023 09:03:57 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:dc8b:b602:9bcd:3004])
        by smtp6-g21.free.fr (Postfix) with ESMTPS id 87B7078036C;
        Thu, 12 Jan 2023 18:03:39 +0100 (CET)
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
Subject: [RFC PATCH 2/4] random: introduce generic vDSO getrandom(,, GRND_TIMESTAMP) fast path
Date:   Thu, 12 Jan 2023 18:02:34 +0100
Message-Id: <dae48bf59df79657e2ec09cfa4a41bc05f1ce2a2.1673539719.git.ydroneaud@opteya.com>
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

Exports base_crng.generation to vDSO and adds getrandom() to the vDSO.

Based on Jason A. Donenfeld <Jason@zx2c4.com> patch [1]
"[PATCH v14 6/7] random: introduce generic vDSO getrandom() implementation",
but deal only with GRND_TIMESTAMP in vDSO: generating random stream
is left to the getrandom() syscall.

[1] https://lore.kernel.org/all/20230101162910.710293-7-Jason@zx2c4.com/

Link: https://lore.kernel.org/all/cover.1673539719.git.ydroneaud@opteya.com/
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 MAINTAINERS             |  1 +
 drivers/char/random.c   |  6 +++++
 include/vdso/datapage.h |  9 ++++++++
 lib/vdso/Kconfig        |  5 ++++
 lib/vdso/getrandom.c    | 51 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 72 insertions(+)
 create mode 100644 lib/vdso/getrandom.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..20e1fabcb2e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17521,6 +17521,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
 S:	Maintained
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
+F:	lib/vdso/getrandom.c
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 9e2a37e432c0..a60f50c95ab1 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -56,6 +56,9 @@
 #include <linux/sched/isolation.h>
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
+#ifdef CONFIG_VDSO_GETRANDOM
+#include <vdso/datapage.h>
+#endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>
 #include <asm/irq.h>
@@ -271,6 +274,9 @@ static void crng_reseed(struct work_struct *work)
 	if (next_gen == ULONG_MAX)
 		++next_gen;
 	WRITE_ONCE(base_crng.generation, next_gen);
+#ifdef CONFIG_VDSO_GETRANDOM
+	smp_store_release(&_vdso_rng_data.generation, next_gen);
+#endif
 	if (!static_branch_likely(&crng_is_ready))
 		crng_init = CRNG_READY;
 	spin_unlock_irqrestore(&base_crng.lock, flags);
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622e7663..7ae8e7ffe3ba 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -109,6 +109,14 @@ struct vdso_data {
 	struct arch_vdso_data	arch_data;
 };
 
+/**
+ * struct vdso_rng_data - vdso RNG state information
+ * @generation:	counter representing the number of RNG reseeds
+ */
+struct vdso_rng_data {
+	u64			generation;
+};
+
 /*
  * We use the hidden visibility to prevent the compiler from generating a GOT
  * relocation. Not only is going through a GOT useless (the entry couldn't and
@@ -120,6 +128,7 @@ struct vdso_data {
  */
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
 
 /*
  * The generic vDSO implementation requires that gettimeofday.h
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index d883ac299508..3b394fa83f65 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,3 +31,8 @@ config GENERIC_VDSO_TIME_NS
 	  VDSO
 
 endif
+
+config VDSO_GETRANDOM
+	bool
+	help
+	  Selected by architectures that support vDSO getrandom().
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
new file mode 100644
index 000000000000..827351a87002
--- /dev/null
+++ b/lib/vdso/getrandom.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/cache.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
+#include <vdso/datapage.h>
+#include <asm/vdso/getrandom.h>
+#include <asm/vdso/vsyscall.h>
+
+/**
+ * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
+ * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
+ * @buffer:		Input/Output buffer.
+ * @len:		Size of @buffer in bytes.
+ * @flags:		Zero or more GRND_* flags.
+ */
+static __always_inline ssize_t
+__cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
+		       unsigned int flags)
+{
+	if (flags != GRND_TIMESTAMP)
+		goto fallback;
+
+	if (unlikely(!buffer))
+		goto fallback;
+
+	/* want aligned access */
+	if (unlikely(!IS_ALIGNED((uintptr_t)buffer, __alignof__(u64))))
+		goto fallback;
+
+	if (unlikely(len != sizeof(u64)))
+		goto fallback;
+
+	if (!get_random_timestamp_update((u64 *)buffer,
+					 READ_ONCE(rng_info->generation)))
+		return 0;
+
+	return sizeof(u64);
+
+fallback:
+	return getrandom_syscall(buffer, len, flags);
+}
+
+static __always_inline ssize_t
+__cvdso_getrandom(void *buffer, size_t len, unsigned int flags)
+{
+	return __cvdso_getrandom_data(__arch_get_vdso_rng_data(), buffer, len, flags);
+}
-- 
2.37.2

