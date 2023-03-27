Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB816CAAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjC0Qer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjC0Qcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:32:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39273A87
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so12324933pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679934756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Uj1wHCrEjaubFJIf/ukmoK8QYWtkDXIKavVvOr6CFo=;
        b=U/vXWoOY9zH2pdJUJfpkZRYRplwKQyRKiSjajenTVDvLGSgKyXVjKlhL1OTVj/82/5
         M3/HkVZ1lSlHXLkiw1+FQHhJXeObxVOHOHvtPx49lX8c6TncUYSYFZiJvSrlf5FcYS3P
         iq3cd9aZs0FEbAK9uSTf2YKiA9Fo/L2ALr5xQb9/I6P2Fx7f7zjpnGBeQYnJ/0O1zNtQ
         DgWuKvr0EeFOsnirjCIDWUOvu7/0tB3zd60SOvpITI9Te8iOU1/1mHt66EUpMVFMEaLm
         czysmWW/XwX1dRFRY/xebYzfUzmgT2onzta7TFTtyLbVVlms/hV/5A6eEagitoShhrqQ
         kt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679934756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Uj1wHCrEjaubFJIf/ukmoK8QYWtkDXIKavVvOr6CFo=;
        b=kklFqVW0SIVNra30SWBw0zaPX1OWm/wxFbvnGjXiV95fWOFw1NmIJXrlt3MK0QhgCQ
         cYjdShcTzAYYTdwKJEL/mmEZP7+Bi6Q1w3nZDMNrs3zgh1MOxfxPMUb5yKj+tmOVca0m
         ugMKPFc6JOVN3dE2rds0qzl/zjpNb72dIdFn57BPIe3XFPExm9WcwAUcWwFSOG74oWl6
         HaxaXI4eymVNSljuZ7RErK1cMDVsHEIEnwni4Tt5hnpUv2RGelnE/XvSfQtVAgjamp+l
         QfNn29FQ+fwPoJ+VbEEiWxx3f4KUpsZ0X4G7rJAv+sawfAIt3ckSMtW7hRtQV8/127Wd
         0sow==
X-Gm-Message-State: AAQBX9c3LUFNQtzs0U/HYzlVWaQPCuNHQyYrLnf+nQd0HTZkr86kbDmn
        QlKd1OCABux58LxW0LjfTRWw1A==
X-Google-Smtp-Source: AKy350bBvWXBPzyfvzs5lOxafwN9mpAUlPpzle3RaEY6sKVDGAeBPX77LeTT5wRTpPHcOJ2msZnnWg==
X-Received: by 2002:a17:90b:1e01:b0:23f:b35b:7789 with SMTP id pg1-20020a17090b1e0100b0023fb35b7789mr13666266pjb.28.1679934756417;
        Mon, 27 Mar 2023 09:32:36 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b001a1faeac240sm8963524plb.186.2023.03.27.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 09:32:36 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, vineetg@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jann Horn <jannh@google.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 6/6] RISC-V: Add hwprobe vDSO function and data
Date:   Mon, 27 Mar 2023 09:32:03 -0700
Message-Id: <20230327163203.2918455-7-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327163203.2918455-1-evan@rivosinc.com>
References: <20230327163203.2918455-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

Changes in v5:
 - Fixed compat vdso compilation failure (lkp).

Changes in v4:
 - Added a prototype to fix -Wmissing-prototype warning (lkp@intel.com)
 - Fixed rv32 build failure (lkp@intel.com)
 - Make vdso prototype match syscall types update

Changes in v3:
 - Introduced vDSO function


One aspect of this that's less than perfect is that there are two copies
of the arch_vdso_data in the data page. This stems from the fact that
vdso_data is arrayed by CS_BASES. Since we're very far away from filling
up the page, and this is not ABI, I left it for now. If things get full
we can move this data out to its own page, or refactor vdso_data
tree-wide to allow for non-arrayed data.

---
 arch/riscv/Kconfig                         |  1 +
 arch/riscv/include/asm/vdso/data.h         | 17 +++++++
 arch/riscv/include/asm/vdso/gettimeofday.h |  8 ++++
 arch/riscv/kernel/compat_vdso/Makefile     |  2 +-
 arch/riscv/kernel/sys_riscv.c              | 41 +++++++++++++++++
 arch/riscv/kernel/vdso.c                   |  6 ---
 arch/riscv/kernel/vdso/Makefile            |  4 ++
 arch/riscv/kernel/vdso/hwprobe.c           | 52 ++++++++++++++++++++++
 arch/riscv/kernel/vdso/sys_hwprobe.S       | 15 +++++++
 arch/riscv/kernel/vdso/vdso.lds.S          |  3 ++
 10 files changed, 142 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/include/asm/vdso/data.h
 create mode 100644 arch/riscv/kernel/vdso/hwprobe.c
 create mode 100644 arch/riscv/kernel/vdso/sys_hwprobe.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..a20e105efa4e 100644
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
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/asm/vdso/gettimeofday.h
index 77d9c2f721c4..ba3283cf7acc 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -9,6 +9,12 @@
 #include <asm/csr.h>
 #include <uapi/linux/time.h>
 
+/*
+ * 32-bit land is lacking generic time vsyscalls as well as the legacy 32-bit
+ * time syscalls like gettimeofday. Skip these definitions since on 32-bit.
+ */
+#ifdef CONFIG_GENERIC_TIME_VSYSCALL
+
 #define VDSO_HAS_CLOCK_GETRES	1
 
 static __always_inline
@@ -60,6 +66,8 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	return ret;
 }
 
+#endif /* CONFIG_GENERIC_TIME_VSYSCALL */
+
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
 						 const struct vdso_data *vd)
 {
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
index 260daf3236d3..91a3431ae1fe 100644
--- a/arch/riscv/kernel/compat_vdso/Makefile
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -22,7 +22,7 @@ targets := $(obj-compat_vdso) compat_vdso.so compat_vdso.so.dbg compat_vdso.lds
 obj-compat_vdso := $(addprefix $(obj)/, $(obj-compat_vdso))
 
 obj-y += compat_vdso.o
-CPPFLAGS_compat_vdso.lds += -P -C -U$(ARCH)
+CPPFLAGS_compat_vdso.lds += -P -C -DCOMPAT_VDSO -U$(ARCH)
 
 # Disable profiling and instrumentation for VDSO code
 GCOV_PROFILE := n
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 19a6def6bb00..096fee3b2f8c 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -14,6 +14,7 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
+#include <vdso/vsyscall.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -244,6 +245,46 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
 
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
 SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
 		size_t, pair_count, size_t, cpu_count, unsigned long __user *,
 		cpus, unsigned int, flags)
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index cc2d1e8c8736..9a68e7eaae4d 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -14,13 +14,7 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <linux/time_namespace.h>
-
-#ifdef CONFIG_GENERIC_TIME_VSYSCALL
 #include <vdso/datapage.h>
-#else
-struct vdso_data {
-};
-#endif
 
 enum vvar_pages {
 	VVAR_DATA_PAGE_OFFSET,
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27f3bcc..022258426050 100644
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
@@ -23,6 +25,8 @@ ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
 endif
 
+CFLAGS_hwprobe.o += -fPIC
+
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.lds
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
new file mode 100644
index 000000000000..d40bec6ac078
--- /dev/null
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Rivos, Inc
+ */
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+
+extern int riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
+			 size_t cpu_count, unsigned long *cpus,
+			 unsigned int flags);
+
+/* Add a prototype to avoid -Wmissing-prototypes warning. */
+int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
+			 size_t cpu_count, unsigned long *cpus,
+			 unsigned int flags);
+
+int __vdso_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
+			 size_t cpu_count, unsigned long *cpus,
+			 unsigned int flags)
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
index 4a0606633290..82ce64900f3d 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -82,6 +82,9 @@ VERSION
 #endif
 		__vdso_getcpu;
 		__vdso_flush_icache;
+#ifndef COMPAT_VDSO
+		__vdso_riscv_hwprobe;
+#endif
 	local: *;
 	};
 }
-- 
2.25.1

