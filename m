Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6596B9EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCNSen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCNSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:34:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908B769D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:33:52 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p6so17613455plf.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678818758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcmFf0A4Qs8AV2mYWu4nAZTRoGwpoQN38ASi1el4j1g=;
        b=NG91jaugy2VVTwA/f47s723t29ASCtpUInf9ILIhHoYmCxz7yVWpoOK1RW8A+bhVIk
         syGM8TndHkbxeZ33UFqZ/eq8em6AVd8xKXZlJjIxi1drDb3I6YljoHiDLmzmoVkVBnek
         pyp6/taiZw474WsFb1i/vQHmLYjJ5kr0O2y1t9E1DAFrSN9oCIvw4x0czZktJ09fR+PD
         iKRHUQK+h8QwujdqvDEaV4Y66FkTVs9e4eLEahJRemJGR+owe7JVBXAA2pSOsA9rMPCr
         V3Gs9U/7KFbw5nNY5P8uGOYGsGnVgeI7NrRNbLNLZReiknUGvBim4QoculpP9Em99IXu
         ePNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcmFf0A4Qs8AV2mYWu4nAZTRoGwpoQN38ASi1el4j1g=;
        b=i7OLDApf3qEOcrL9VFq9md2k1HKKLX22x84Pl+k31lEu2U4uJcMFybT8C1HXXjkWl1
         BkFJgCGgVbK2sJ/etJbXAzSYmWnj9lKiwiO5V/bh/Qpt0W+LhQIsSqI0E6BG+0S5o32d
         2aeb8BBWSCAZYnFPMruoUjvTW++p4MOLUZq/gkGESg5H1MT4Lp9WhHx8a8M076mHW7fO
         DYU2b0zx06Y6vPfqqt0WMyRBb9DkLoDYe4Nsuvu/Jppz9x5ONcXnUBP0RalMvRBZZwW6
         fMgH5TqNwMzDh2sXikEY5JUxSxQgm6O7/qI644+4YSnogDPb6Vhgjwa0RlI6eYjU6Ju9
         5dpw==
X-Gm-Message-State: AO0yUKUugMIqITwBwD+/XHORs6usu9W+DNRTBDefda8h9BWtsCowFulh
        uto7qv9zSWAbPj9josUsKbJqgg==
X-Google-Smtp-Source: AK7set8lOG/soxr3HbCDivUIzfs2ntoxWQ2RiARC8CqSbkFzXcbelJYmWHm/+gHYwFrVACKM+sJqqQ==
X-Received: by 2002:a17:902:d486:b0:19c:a866:6a76 with SMTP id c6-20020a170902d48600b0019ca8666a76mr346plg.42.1678818757848;
        Tue, 14 Mar 2023 11:32:37 -0700 (PDT)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id kn3-20020a170903078300b0019d397b0f18sm2072019plb.214.2023.03.14.11.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:32:37 -0700 (PDT)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     slewis@rivosinc.com, heiko@sntech.de,
        Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/6] RISC-V: Add a syscall for HW probing
Date:   Tue, 14 Mar 2023 11:32:16 -0700
Message-Id: <20230314183220.513101-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314183220.513101-1-evan@rivosinc.com>
References: <20230314183220.513101-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't have enough space for these all in ELF_HWCAP{,2} and there's no
system call that quite does this, so let's just provide an arch-specific
one to probe for hardware capabilities.  This currently just provides
m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
the future.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v4:
 - Used real types in syscall prototypes (Arnd)
 - Fixed static line break in do_riscv_hwprobe() (Conor)
 - Added newlines between documentation lists (Conor)
 - Crispen up size types to size_t, and cpu indices to int (Joe)
 - Fix copy_from_user() return logic bug (found via kselftests!)
 - Add __user to SYSCALL_DEFINE() to fix warning

Changes in v3:
 - Refactored functions so that kernel mode can query too, in
   preparation for the vDSO data population.
 - Changed the vendor/arch/imp IDs to return a value of -1 on mismatch
   rather than failing the whole call.
 - Const cpumask pointer in hwprobe_mid()
 - Embellished documentation WRT cpu_set and the returned values.
 - Renamed hwprobe_mid() to hwprobe_arch_id() (Conor)
 - Fixed machine ID doc warnings, changed elements to c:macro:.
 - Completed dangling unistd.h comment (Conor)
 - Fixed line breaks and minor logic optimization (Conor).
 - Use riscv_cached_mxxxid() (Conor)

Changes in v2:
 - Changed the interface to look more like poll(). Rather than supplying
   key_offset and getting back an array of values with numerically
   contiguous keys, have the user pre-fill the key members of the array,
   and the kernel will fill in the corresponding values. For any key it
   doesn't recognize, it will set the key of that element to -1. This
   allows usermode to quickly ask for exactly the elements it cares
   about, and not get bogged down in a back and forth about newer keys
   that older kernels might not recognize. In other words, the kernel
   can communicate that it doesn't recognize some of the keys while
   still providing the data for the keys it does know.
 - Added a shortcut to the cpuset parameters that if a size of 0 and
   NULL is provided for the CPU set, the kernel will use a cpu mask of
   all online CPUs. This is convenient because I suspect most callers
   will only want to act on a feature if it's supported on all CPUs, and
   it's a headache to dynamically allocate an array of all 1s, not to
   mention a waste to have the kernel loop over all of the offline bits.


---
 Documentation/riscv/hwprobe.rst       |  41 ++++++++
 Documentation/riscv/index.rst         |   1 +
 arch/riscv/include/asm/hwprobe.h      |  13 +++
 arch/riscv/include/asm/syscall.h      |   4 +
 arch/riscv/include/uapi/asm/hwprobe.h |  25 +++++
 arch/riscv/include/uapi/asm/unistd.h  |   9 ++
 arch/riscv/kernel/sys_riscv.c         | 136 +++++++++++++++++++++++++-
 7 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/riscv/hwprobe.rst
 create mode 100644 arch/riscv/include/asm/hwprobe.h
 create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
new file mode 100644
index 000000000000..211828f706e3
--- /dev/null
+++ b/Documentation/riscv/hwprobe.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+RISC-V Hardware Probing Interface
+---------------------------------
+
+The RISC-V hardware probing interface is based around a single syscall, which
+is defined in <asm/hwprobe.h>::
+
+    struct riscv_hwprobe {
+        __s64 key;
+        __u64 value;
+    };
+
+    long sys_riscv_hwprobe(struct riscv_hwprobe *pairs, size_t pair_count,
+                           size_t cpu_count, cpu_set_t *cpus,
+                           unsigned int flags);
+
+The arguments are split into three groups: an array of key-value pairs, a CPU
+set, and some flags. The key-value pairs are supplied with a count. Userspace
+must prepopulate the key field for each element, and the kernel will fill in the
+value if the key is recognized. If a key is unknown to the kernel, its key field
+will be cleared to -1, and its value set to 0. The CPU set is defined by
+CPU_SET(3). For value-like keys (eg. vendor/arch/impl), the returned value will
+be only be valid if all CPUs in the given set have the same value. Otherwise -1
+will be returned. For boolean-like keys, the value returned will be a logical
+AND of the values for the specified CPUs. Usermode can supply NULL for cpus and
+0 for cpu_count as a shortcut for all online CPUs. There are currently no flags,
+this value must be zero for future compatibility.
+
+On success 0 is returned, on failure a negative error code is returned.
+
+The following keys are defined:
+
+* :c:macro:`RISCV_HWPROBE_KEY_MVENDORID`: Contains the value of ``mvendorid``,
+  as defined by the RISC-V privileged architecture specification.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MARCHID`: Contains the value of ``marchid``, as
+  defined by the RISC-V privileged architecture specification.
+
+* :c:macro:`RISCV_HWPROBE_KEY_MIMPLID`: Contains the value of ``mimplid``, as
+  defined by the RISC-V privileged architecture specification.
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index 2e5b18fbb145..175a91db0200 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -7,6 +7,7 @@ RISC-V architecture
 
     boot-image-header
     vm-layout
+    hwprobe
     patch-acceptance
     uabi
 
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
new file mode 100644
index 000000000000..08d1c3bdd78a
--- /dev/null
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright 2022 Rivos, Inc
+ */
+
+#ifndef _ASM_HWPROBE_H
+#define _ASM_HWPROBE_H
+
+#include <uapi/asm/hwprobe.h>
+
+#define RISCV_HWPROBE_MAX_KEY 2
+
+#endif
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 384a63b86420..3b5a667928bf 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_RISCV_SYSCALL_H
 #define _ASM_RISCV_SYSCALL_H
 
+#include <asm/hwprobe.h>
 #include <uapi/linux/audit.h>
 #include <linux/sched.h>
 #include <linux/err.h>
@@ -75,4 +76,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 }
 
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+
+asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_t,
+				  unsigned long *, unsigned int);
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
new file mode 100644
index 000000000000..591802047460
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright 2022 Rivos, Inc
+ */
+
+#ifndef _UAPI_ASM_HWPROBE_H
+#define _UAPI_ASM_HWPROBE_H
+
+#include <linux/types.h>
+
+/*
+ * Interface for probing hardware capabilities from userspace, see
+ * Documentation/riscv/hwprobe.rst for more information.
+ */
+struct riscv_hwprobe {
+	__s64 key;
+	__u64 value;
+};
+
+#define RISCV_HWPROBE_KEY_MVENDORID	0
+#define RISCV_HWPROBE_KEY_MARCHID	1
+#define RISCV_HWPROBE_KEY_MIMPID	2
+/* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
+
+#endif
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 73d7cdd2ec49..950ab3fd4409 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -43,3 +43,12 @@
 #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
 #endif
 __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
+
+/*
+ * Allows userspace to query the kernel for CPU architecture and
+ * microarchitecture details across a given set of CPUs.
+ */
+#ifndef __NR_riscv_hwprobe
+#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
+#endif
+__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 5d3f2fbeb33c..981d23457f13 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -6,8 +6,11 @@
  */
 
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/hwprobe.h>
+#include <asm/sbi.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
@@ -69,3 +72,134 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
 
 	return 0;
 }
+
+/*
+ * The hwprobe interface, for allowing userspace to probe to see which features
+ * are supported by the hardware.  See Documentation/riscv/hwprobe.rst for more
+ * details.
+ */
+static void hwprobe_arch_id(struct riscv_hwprobe *pair,
+			    const struct cpumask *cpus)
+{
+	u64 id = -1ULL;
+	bool first = true;
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		u64 cpu_id;
+
+		switch (pair->key) {
+		case RISCV_HWPROBE_KEY_MVENDORID:
+			cpu_id = riscv_cached_mvendorid(cpu);
+			break;
+		case RISCV_HWPROBE_KEY_MIMPID:
+			cpu_id = riscv_cached_mimpid(cpu);
+			break;
+		case RISCV_HWPROBE_KEY_MARCHID:
+			cpu_id = riscv_cached_marchid(cpu);
+			break;
+		}
+
+		if (first)
+			id = cpu_id;
+
+		/*
+		 * If there's a mismatch for the given set, return -1 in the
+		 * value.
+		 */
+		if (id != cpu_id) {
+			id = -1ULL;
+			break;
+		}
+	}
+
+	pair->value = id;
+}
+
+static void hwprobe_one_pair(struct riscv_hwprobe *pair,
+			     const struct cpumask *cpus)
+{
+	switch (pair->key) {
+	case RISCV_HWPROBE_KEY_MVENDORID:
+	case RISCV_HWPROBE_KEY_MARCHID:
+	case RISCV_HWPROBE_KEY_MIMPID:
+		hwprobe_arch_id(pair, cpus);
+		break;
+
+	/*
+	 * For forward compatibility, unknown keys don't fail the whole
+	 * call, but get their element key set to -1 and value set to 0
+	 * indicating they're unrecognized.
+	 */
+	default:
+		pair->key = -1;
+		pair->value = 0;
+		break;
+	}
+}
+
+static int do_riscv_hwprobe(struct riscv_hwprobe __user *pairs,
+			    size_t pair_count, size_t cpu_count,
+			    unsigned long __user *cpus_user,
+			    unsigned int flags)
+{
+	size_t out;
+	int ret;
+	cpumask_t cpus;
+
+	/* Check the reserved flags. */
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * The interface supports taking in a CPU mask, and returns values that
+	 * are consistent across that mask. Allow userspace to specify NULL and
+	 * 0 as a shortcut to all online CPUs.
+	 */
+	cpumask_clear(&cpus);
+	if (!cpu_count && !cpus_user) {
+		cpumask_copy(&cpus, cpu_online_mask);
+	} else {
+		if (cpu_count > cpumask_size())
+			cpu_count = cpumask_size();
+
+		ret = copy_from_user(&cpus, cpus_user, cpu_count);
+		if (ret)
+			return -EFAULT;
+
+		/*
+		 * Userspace must provide at least one online CPU, without that
+		 * there's no way to define what is supported.
+		 */
+		cpumask_and(&cpus, &cpus, cpu_online_mask);
+		if (cpumask_empty(&cpus))
+			return -EINVAL;
+	}
+
+	for (out = 0; out < pair_count; out++, pairs++) {
+		struct riscv_hwprobe pair;
+
+		if (get_user(pair.key, &pairs->key))
+			return -EFAULT;
+
+		pair.value = 0;
+		hwprobe_one_pair(&pair, &cpus);
+		ret = put_user(pair.key, &pairs->key);
+		if (ret == 0)
+			ret = put_user(pair.value, &pairs->value);
+
+		if (ret)
+			return -EFAULT;
+	}
+
+	return 0;
+
+}
+
+SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
+		size_t, pair_count, size_t, cpu_count, unsigned long __user *,
+		cpus, unsigned int, flags)
+{
+	return do_riscv_hwprobe(pairs, pair_count, cpu_count,
+				cpus, flags);
+}
-- 
2.25.1

