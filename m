Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD20B68C75F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBFUPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBFUPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:15:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADD820D26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:15:27 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so13389067plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQY/ewono7eyJVzIAIVhUKj+GHApr931zg2+4gRqdDM=;
        b=0EhBKOOJcz9jUXs2WdevqyEvuR6iVGwzmFgp1Hv7Tjj0tjWL8PWkEUtyU/ckx/rloA
         e4lIKA2K7ZHqKkz00PzOrQOfrugp7S21VPpdDzogAbbwgR9Dd8uebzGvsE8+6SDTVNFH
         /QeQ8J4euDm7tiLzDN4ly3jtKRQNRV0JvocmRuQsgLmYr2UrJTl/hDfUq0BkisMBl+lN
         10iBjLz9SQBvzfluNbZ4i8XHiAJ59p+fHX27Dj67ZYuYv3BLUkVU6KS1erw8uPELLWGA
         6Bie4cMfw75oQMjHK9RtXmBq6X9Liko/Hf6hWfuGx/iLye7L4qUprGtnHys66md5NHoX
         lu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQY/ewono7eyJVzIAIVhUKj+GHApr931zg2+4gRqdDM=;
        b=O8LKVPdGBA34cx5EGN1Oj2pKFGLnJGj9tUETYMxEM8Wq4xvFbcsRZtGsfWJeBBggPU
         34C6uJmWKitpLKpKaqcycfqQ9a0rm/IJKb1ywt/GGxF5RUHGD04SWZ4ISng2nwfAeaUW
         f/MXJBU8zbDXGohOYT7rditzWqPH5Jsbg7NAYXOCo2HTrDLTrf0a6D4WO8HBKvzYf0SN
         5SR3kVKEQZEdBP+mlNE2LQh2NsDl/NPOjFsAmkVRXiXiGUMEYPR9y0WdJS8y4QfVsYCB
         ivbFfb2hAvs47sBPk2QlGz+es4wazCm8lyBoUlXyIOV6FoWQRMaPwhvRuarhqimU6vb7
         O2gg==
X-Gm-Message-State: AO0yUKVt+tX5cLJgOlJUf5QVQ16yRkE4cx+U3I/RPKoS0EjH9edx7czq
        LGzK2tI62cw5TFTNQPN4PimXhw==
X-Google-Smtp-Source: AK7set99lLQ4BVN/k6fBT3UsGI+53df57kc0Bvwei0tHQPb8hAP+F7xZTmU66VcBztxtN+pWGQd9RQ==
X-Received: by 2002:a05:6a20:12c9:b0:af:98cd:7df1 with SMTP id v9-20020a056a2012c900b000af98cd7df1mr579279pzg.24.1675714526377;
        Mon, 06 Feb 2023 12:15:26 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ab4a000000b004df4fbb9823sm6425079pgp.68.2023.02.06.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:15:25 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor@kernel.org>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Date:   Mon,  6 Feb 2023 12:14:51 -0800
Message-Id: <20230206201455.1790329-3-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
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

We don't have enough space for these all in ELF_HWCAP{,2} and there's no
system call that quite does this, so let's just provide an arch-specific
one to probe for hardware capabilities.  This currently just provides
m{arch,imp,vendor}id, but with the key-value pairs we can pass more in
the future.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>

---

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
 Documentation/riscv/hwprobe.rst       |  37 +++++++
 Documentation/riscv/index.rst         |   1 +
 arch/riscv/include/asm/hwprobe.h      |  13 +++
 arch/riscv/include/asm/syscall.h      |   3 +
 arch/riscv/include/uapi/asm/hwprobe.h |  25 +++++
 arch/riscv/include/uapi/asm/unistd.h  |   8 ++
 arch/riscv/kernel/cpu.c               |   3 +-
 arch/riscv/kernel/sys_riscv.c         | 146 +++++++++++++++++++++++++-
 8 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/riscv/hwprobe.rst
 create mode 100644 arch/riscv/include/asm/hwprobe.h
 create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
new file mode 100644
index 000000000000..97771090e972
--- /dev/null
+++ b/Documentation/riscv/hwprobe.rst
@@ -0,0 +1,37 @@
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
+                           unsigned long flags);
+
+The arguments are split into three groups: an array of key-value pairs, a CPU
+set, and some flags.  The key-value pairs are supplied with a count.  Userspace
+must prepopulate the key field for each element, and the kernel will fill in the
+value if the key is recognized.  If a key is unknown to the kernel, its key
+field will be cleared to -1, and its value set to 0.  The CPU set is defined by
+CPU_SET(3), the indicated features will be supported on all CPUs in the set.
+Usermode can supply NULL for cpus and 0 for cpu_count as a shortcut for all
+online CPUs. There are currently no flags, this value must be zero for future
+compatibility.
+
+On success 0 is returned, on failure a negative error code is returned.
+
+The following keys are defined:
+
+* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, as per the
+  ISA specifications.
+* :RISCV_HWPROBE_KEY_MARCHID:: Contains the value of :marchid:, as per the ISA
+  specifications.
+* :RISCV_HWPROBE_KEY_MIMPLID:: Contains the value of :mimplid:, as per the ISA
+  specifications.
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
index 384a63b86420..78a6302ef711 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -75,4 +75,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 }
 
 asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
+
+asmlinkage long sys_riscv_hwprobe(uintptr_t, uintptr_t, uintptr_t, uintptr_t,
+				  uintptr_t, uintptr_t);
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
index 73d7cdd2ec49..37d47302322a 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -43,3 +43,11 @@
 #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
 #endif
 __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
+
+/*
+ * Allows userspace to probe
+ */
+#ifndef __NR_riscv_hwprobe
+#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
+#endif
+__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 684e5419d37d..d0fb3567cc3d 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -4,15 +4,16 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
 #include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
+#include <asm/pgtable.h>
 #include <asm/sbi.h>
 #include <asm/smp.h>
-#include <asm/pgtable.h>
 
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 5d3f2fbeb33c..868a12384f5a 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -6,8 +6,11 @@
  */
 
 #include <linux/syscalls.h>
-#include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 #include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
@@ -69,3 +72,144 @@ SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
 
 	return 0;
 }
+
+/*
+ * The hwprobe interface, for allowing userspace to probe to see which features
+ * are supported by the hardware.  See Documentation/riscv/hwprobe.rst for more
+ * details.
+ */
+static int set_hwprobe(struct riscv_hwprobe __user *pair, u64 val)
+{
+	long ret;
+
+	ret = put_user(val, &pair->value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static long hwprobe_mid(struct riscv_hwprobe __user *pair, size_t key,
+			cpumask_t *cpus)
+{
+	long cpu, id;
+	bool first, valid;
+
+	first = true;
+	valid = false;
+	for_each_cpu(cpu, cpus) {
+		struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu);
+		long cpu_id;
+
+		switch (key) {
+		case RISCV_HWPROBE_KEY_MVENDORID:
+			cpu_id = ci->mvendorid;
+			break;
+		case RISCV_HWPROBE_KEY_MIMPID:
+			cpu_id = ci->mimpid;
+			break;
+		case RISCV_HWPROBE_KEY_MARCHID:
+			cpu_id = ci->marchid;
+			break;
+		}
+
+		if (first) {
+			id = cpu_id;
+			valid = true;
+		}
+
+		if (id != cpu_id)
+			valid = false;
+	}
+
+	/*
+	 * put_user() returns 0 on success, so use 1 to indicate it wasn't
+	 * called and we should skip having incremented the output.
+	 */
+	if (!valid)
+		return 1;
+
+	return set_hwprobe(pair, id);
+}
+
+static
+long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
+		      long cpu_count, unsigned long __user *cpus_user,
+		      unsigned long flags)
+{
+	size_t out;
+	s64 key;
+	long ret;
+	struct cpumask cpus;
+
+	/* Check the reserved flags. */
+	if (flags != 0)
+		return -EINVAL;
+
+	/*
+	 * The only supported values must be the same on all CPUs. Allow
+	 * userspace to specify NULL and 0 as a shortcut to all online CPUs.
+	 */
+	cpumask_clear(&cpus);
+	if ((cpu_count == 0) && (cpus_user == NULL)) {
+		cpumask_copy(&cpus, cpu_online_mask);
+	} else {
+		if (cpu_count > cpumask_size())
+			cpu_count = cpumask_size();
+		ret = copy_from_user(&cpus, cpus_user, cpu_count);
+		if (!ret)
+			return -EFAULT;
+
+		/*
+		 * Userspace must provide at least one online CPU, without that there's
+		 * no way to define what is supported.
+		 */
+		cpumask_and(&cpus, &cpus, cpu_online_mask);
+		if (cpumask_empty(&cpus))
+			return -EINVAL;
+	}
+
+	for (out = 0; out < pair_count; out++, pairs++) {
+		long ret;
+
+		if (get_user(key, &pairs->key))
+			return -EFAULT;
+
+		switch (key) {
+		case RISCV_HWPROBE_KEY_MVENDORID:
+		case RISCV_HWPROBE_KEY_MARCHID:
+		case RISCV_HWPROBE_KEY_MIMPID:
+			ret = hwprobe_mid(pairs, key, &cpus);
+			break;
+
+		/*
+		 * For forward compatibility, unknown keys don't fail the whole
+		 * call, but get their element key set to -1 and value set to 0
+		 * indicating they're unrecognized.
+		 */
+		default:
+			ret = put_user(-1, &pairs->key);
+			if (ret < 0)
+				return ret;
+
+			ret = set_hwprobe(pairs, 0);
+			if (ret)
+				return ret;
+
+			break;
+		}
+
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+
+}
+
+SYSCALL_DEFINE5(riscv_hwprobe, uintptr_t, pairs, uintptr_t, pair_count,
+		uintptr_t, cpu_count, uintptr_t, cpus, uintptr_t, flags)
+{
+	return do_riscv_hwprobe((void __user *)pairs, pair_count, cpu_count,
+				(void __user *)cpus, flags);
+}
-- 
2.25.1

