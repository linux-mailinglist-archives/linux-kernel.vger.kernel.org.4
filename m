Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17AB69E81C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjBUTKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBUTKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:10:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5951F305C8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:45 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so2718673pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbdXcY/cyfsn3vuj+G9y8VbBmqDYFOwE9fF3Bt0phIY=;
        b=csHRX7enYMnjCMTP6woBc7E2NOR8kXQNGrxRlxwRA8LYFRm+dEXDW8b5XJRYkt2T2i
         Ahe5pRPhESqNItcsWgXWfbKdy+PLMavIffxoF9BJBL/P2snpZ3JDeACBsw5ajcZKn+ac
         78mpOZYXwyOEEQxOJrhICXEKjksghXtqu8vtE5kq2ubGy9KRD/HNngW+RedQK7TS43Z4
         i8Q1lrLQhnDsHVqQvyOtaCFPL+PBFup/ns3XMrGJYw84HO49GX1ZI5I9tglYnSfoj2HF
         WzKyhZK2MY4ut9Nxd1bPPkfXLI0Sm1k/aBGYKAfqaS7ZhYgK7U+D4M1x3szK7S6lD3q3
         0Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbdXcY/cyfsn3vuj+G9y8VbBmqDYFOwE9fF3Bt0phIY=;
        b=JnlJn7+5jCBZVowHKW5UD8ZW5vzE93vQywY7hBuvyeNbT3qS+eTdZ52bj1qNtK8hzA
         h2li2954gCvUWhe0DYOKKWhYpREC9WrDhoJhA8BtnOduDVaNU4pW+2nsu4F7GLGBwqlJ
         /SSC61G1gnUIKpO7pi5/e5Tq+Dhtk6Vbl9kFCuhYRa+KWcqGzk2yVYYnUvHU2NTyVNP5
         6uKQ+RKaG+WilPvmFowCK48l9fUdbsE+f5mn80einMJwsNR/o59Jij6yPcf/l57m/MQf
         pPltKrHIoDlMjI074jNYd616Y2F1+bWqhgdgzmBBD7EzE+G2nwk6B45Z2aODVkHql1uz
         Xj0Q==
X-Gm-Message-State: AO0yUKXukwrMQc+9ltf9eJJbrFhnxJIAN66Zv+n/rR5I7zGj9zcOII9J
        416OEajIxCal/GIX+UF66Y97vQ==
X-Google-Smtp-Source: AK7set+CUfGR7RzYMxrKACaqDuulcLWJqPhKwae9FboX5nBwOxKMOGYrVNogiJZ/96Az5zrb0+nl3g==
X-Received: by 2002:a17:903:24e:b0:198:b99c:f6ee with SMTP id j14-20020a170903024e00b00198b99cf6eemr8941360plh.65.1677006584803;
        Tue, 21 Feb 2023 11:09:44 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0019602b2c00csm1583863pls.175.2023.02.21.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:09:44 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v3 7/7] RISC-V: Add hwprobe vDSO function and data
Date:   Tue, 21 Feb 2023 11:08:58 -0800
Message-Id: <20230221190858.3159617-8-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221190858.3159617-1-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vDSO function __vdso_riscv_hwprobe, which can sit in front of the
riscv_hwprobe syscall and answer common queries. We stash a copy of
static answers for the "all CPUs" case in the vDSO data page. This data
is private to the vDSO, so we can decide later to change what's stored
there or under what conditions we defer to the syscall. Currently all
data can be discovered at boot, so the vDSO function answers all queries
when the cpumask is set to the "all CPUs" hint.

There's also a boolean in the data that lets the vDSO function know that
all CPUs are the same. In that case, the vDSO will also answer queries
for arbitrary CPU masks in addition to the "all CPUs" hint.

Signed-off-by: Evan Green <evan@rivosinc.com>
---

Changes in v3:
 - Introduced vDSO function


One aspect of this that's less than perfect is that there are two copies
of the arch_vdso_data in the data page. This stems from the fact that
vdso_data is arrayed by CS_BASES. Since we're very far away from filling
up the page, and this is not ABI, I left it for now. If things get full
we can move this data out to its own page, or refactor vdso_data
tree-wide to allow for non-arrayed data.

---
 arch/riscv/Kconfig                   |  1 +
 arch/riscv/include/asm/vdso/data.h   | 17 ++++++++++
 arch/riscv/kernel/sys_riscv.c        | 41 ++++++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile      |  2 ++
 arch/riscv/kernel/vdso/hwprobe.c     | 47 ++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso/sys_hwprobe.S | 15 +++++++++
 arch/riscv/kernel/vdso/vdso.lds.S    |  1 +
 7 files changed, 124 insertions(+)
 create mode 100644 arch/riscv/include/asm/vdso/data.h
 create mode 100644 arch/riscv/kernel/vdso/hwprobe.c
 create mode 100644 arch/riscv/kernel/vdso/sys_hwprobe.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..218e75975a15 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_DATA
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/include/asm/vdso/data.h b/arch/riscv/include/asm/vdso/data.h
new file mode 100644
index 000000000000..dc2f76f58b76
--- /dev/null
+++ b/arch/riscv/include/asm/vdso/data.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RISCV_ASM_VDSO_DATA_H
+#define __RISCV_ASM_VDSO_DATA_H
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <asm/hwprobe.h>
+
+struct arch_vdso_data {
+	/* Stash static answers to the hwprobe queries when all CPUs are selected. */
+	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
+
+	/* Boolean indicating all CPUs have the same static hwprobe values. */
+	__u8 homogeneous_cpus;
+};
+
+#endif /* __RISCV_ASM_VDSO_DATA_H */
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index afc1b96d5c1a..113b3d97c8cc 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -14,6 +14,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
+#include <vdso/vsyscall.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -242,6 +243,46 @@ int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
 
 }
 
+static int __init init_hwprobe_vdso_data(void)
+{
+	struct vdso_data *vd = __arch_get_k_vdso_data();
+	struct arch_vdso_data *avd = &vd->arch_data;
+	u64 id_bitsmash = 0;
+	struct riscv_hwprobe pair;
+	int key;
+
+	/*
+	 * Initialize vDSO data with the answers for the "all CPUs" case, to
+	 * save a syscall in the common case.
+	 */
+	for (key = 0; key <= RISCV_HWPROBE_MAX_KEY; key++) {
+		pair.key = key;
+		hwprobe_one_pair(&pair, cpu_online_mask);
+
+		WARN_ON_ONCE(pair.key < 0);
+
+		avd->all_cpu_hwprobe_values[key] = pair.value;
+		/*
+		 * Smash together the vendor, arch, and impl IDs to see if
+		 * they're all 0 or any negative.
+		 */
+		if (key <= RISCV_HWPROBE_KEY_MIMPID)
+			id_bitsmash |= pair.value;
+	}
+
+	/*
+	 * If the arch, vendor, and implementation ID are all the same across
+	 * all harts, then assume all CPUs are the same, and allow the vDSO to
+	 * answer queries for arbitrary masks. However if all values are 0 (not
+	 * populated) or any value returns -1 (varies across CPUs), then the
+	 * vDSO should defer to the kernel for exotic cpu masks.
+	 */
+	avd->homogeneous_cpus = (id_bitsmash > 0);
+	return 0;
+}
+
+arch_initcall_sync(init_hwprobe_vdso_data);
+
 SYSCALL_DEFINE5(riscv_hwprobe, uintptr_t, pairs, uintptr_t, pair_count,
 		uintptr_t, cpu_count, uintptr_t, cpus, uintptr_t, flags)
 {
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27f3bcc..107fd2162cdf 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -12,6 +12,8 @@ vdso-syms += vgettimeofday
 endif
 vdso-syms += getcpu
 vdso-syms += flush_icache
+vdso-syms += hwprobe
+vdso-syms += sys_hwprobe
 
 # Files to link into the vdso
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
new file mode 100644
index 000000000000..1792d6c30c97
--- /dev/null
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Rivos, Inc
+ */
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+
+extern int riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
+			 long cpu_count, unsigned long *cpus,
+			 unsigned long flags);
+
+int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, long pair_count,
+			 long cpu_count, unsigned long *cpus,
+			 unsigned long flags)
+{
+	const struct vdso_data *vd = __arch_get_vdso_data();
+	const struct arch_vdso_data *avd = &vd->arch_data;
+	bool all_cpus = !cpu_count && !cpus;
+	struct riscv_hwprobe *p = pairs;
+	struct riscv_hwprobe *end = pairs + pair_count;
+
+	/*
+	 * Defer to the syscall for exotic requests. The vdso has answers
+	 * stashed away only for the "all cpus" case. If all CPUs are
+	 * homogeneous, then this function can handle requests for arbitrary
+	 * masks.
+	 */
+	if ((flags != 0) || (!all_cpus && !avd->homogeneous_cpus))
+		return riscv_hwprobe(pairs, pair_count, cpu_count, cpus, flags);
+
+	/* This is something we can handle, fill out the pairs. */
+	while (p < end) {
+		if (p->key <= RISCV_HWPROBE_MAX_KEY) {
+			p->value = avd->all_cpu_hwprobe_values[p->key];
+
+		} else {
+			p->key = -1;
+			p->value = 0;
+		}
+
+		p++;
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vdso/sys_hwprobe.S
new file mode 100644
index 000000000000..2511c8ba8f86
--- /dev/null
+++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2022 Rivos, Inc */
+
+#include <linux/linkage.h>
+#include <asm/unistd.h>
+
+.text
+ENTRY(riscv_hwprobe)
+	.cfi_startproc
+	li a7, __NR_riscv_hwprobe
+	ecall
+	ret
+
+	.cfi_endproc
+ENDPROC(riscv_hwprobe)
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 150b1a572e61..dfe63fb71041 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -75,6 +75,7 @@ VERSION
 #endif
 		__vdso_getcpu;
 		__vdso_flush_icache;
+		__vdso_riscv_hwprobe;
 	local: *;
 	};
 }
-- 
2.25.1

