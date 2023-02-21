Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14A69E819
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBUTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjBUTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:09:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FF22A6E0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:38 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso5899475pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngg8NDFZzsFlILqqXwu8UXpBsOAV4Baprs2BRNqdLJ0=;
        b=FRaQAuEcLIi5R8B0k5soD4TzlqXCCD8xIpm8vDv1PejHFBAIH+x1Tn70DoKzgIdA29
         u1jhu2VwxdcVAhXFFoX/6TH7my+wq3hu7nU9QgtM6yw2HV0ZFaak+mABSNAIv2Nt9DcO
         uOH1qJ2tSXdTM6O7Y/ouRusJ8HdInJja7HVGua5j2lSuVPAedU9lCOL6WoWNzbiSah4R
         xYFmxAswhiNF1Zeqy/XjhCFRfl1N4PEpgeMLggVHFGWvU3NzVAGGO/XjdNzZcrM2wdYu
         Z6jp38wpp3OPylFbdSXC7mVj42OEJpVKBcWehrwWDIJYHmt02qObKqWwFTSEfpTEFvlu
         tMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ngg8NDFZzsFlILqqXwu8UXpBsOAV4Baprs2BRNqdLJ0=;
        b=p+/+GKvauQj/VjL1aw5ct/EkfYZIij2YERUIiCPiPwP/dFgTefcR0ME/QDm09GcJpj
         RwQd5jPCWakbYFnUpGS6P6UFl9fqpjgHwaFXfoyRJ3rf93e5rgSFD/ElDnDtJDMQJfhe
         VizWGkAeqjR2lb4EudJjqEa/0jci//ikOD1cWmhoEvs9lsiFSVpSVFH8YEh1kW4Pe0sl
         dCUA+vn5db4d0qvtJUIRh23uUNkMLv2LRfqGywEip/HmWtXqBi1Xtfm5lyf1qSJJt0Ax
         PxwEogKHLd1Y91TP6zV+kfOCDO2DaGDutOGB+mDJSG7Eo6JLI0HzhnN0JwhrOh/O3sh+
         NDzA==
X-Gm-Message-State: AO0yUKVstHdC8uOSR93S6rkZN5lzWZkLHRZkpf3EygFyCmt6JcBsOjzy
        gEgduED1KCxtQQaowzU38/+yYw==
X-Google-Smtp-Source: AK7set+9JyhPkEzwlrHweLrwuAKU/yz0dbdPwCbQGwgBKeOM2IKtDHtvgrtUF617GgoYGmIFS/kJLg==
X-Received: by 2002:a17:903:22c8:b0:199:12d5:5b97 with SMTP id y8-20020a17090322c800b0019912d55b97mr7589315plg.12.1677006577820;
        Tue, 21 Feb 2023 11:09:37 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id b16-20020a170902b61000b0019602b2c00csm1583863pls.175.2023.02.21.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:09:37 -0800 (PST)
From:   Evan Green <evan@rivosinc.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     heiko@sntech.de, Conor Dooley <conor@kernel.org>,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Evan Green <evan@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 5/7] RISC-V: hwprobe: Support probing of misaligned access performance
Date:   Tue, 21 Feb 2023 11:08:56 -0800
Message-Id: <20230221190858.3159617-6-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221190858.3159617-1-evan@rivosinc.com>
References: <20230221190858.3159617-1-evan@rivosinc.com>
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

This allows userspace to select various routines to use based on the
performance of misaligned access on the target hardware.

Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Evan Green <evan@rivosinc.com>

---

Changes in v3:
 - Have hwprobe_misaligned return int instead of long.
 - Constify cpumask pointer in hwprobe_misaligned()
 - Fix warnings in _PERF_O list documentation, use :c:macro:.
 - Move include cpufeature.h to misaligned patch.
 - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
 - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
 - Break early in misaligned access iteration (Conor)
 - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED future
   value (Conor)

Changes in v2:
 - Fixed logic error in if(of_property_read_string...) that caused crash
 - Include cpufeature.h in cpufeature.h to avoid undeclared variable
   warning.
 - Added a _MASK define
 - Fix random checkpatch complaints

 Documentation/riscv/hwprobe.rst       | 14 ++++++++++++
 arch/riscv/include/asm/cpufeature.h   |  2 ++
 arch/riscv/include/asm/hwprobe.h      |  2 +-
 arch/riscv/include/asm/smp.h          | 11 ++++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  6 ++++++
 arch/riscv/kernel/cpufeature.c        | 31 +++++++++++++++++++++++++--
 arch/riscv/kernel/sys_riscv.c         | 27 +++++++++++++++++++++++
 7 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index 9f2da414fbf8..ac6ded9eb0da 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -58,3 +58,17 @@ The following keys are defined:
     minimumNumber/maximumNumber, not minNum/maxNum") of the RISC-V ISA manual.
   * :c:macro:`RISCV_HWPROBE_IMA_C`: The C extension is supported, as defined
     by version 2.2 of the RISC-V ISA manual.
+* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
+  information about the selected set of processors.
+
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
+    accesses is unknown.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
+    emulated via software, either in or below the kernel.  These accesses are
+    always extremely slow.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are supported
+    in hardware, but are slower than the cooresponding aligned accesses
+    sequences.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are supported
+    in hardware and are faster than the cooresponding aligned accesses
+    sequences.
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 66ebaae449c8..808d5403f2ac 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -18,4 +18,6 @@ struct riscv_cpuinfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
+DECLARE_PER_CPU(long, misaligned_access_speed);
+
 #endif
diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
index 7e52f1e1fe10..4e45e33015bc 100644
--- a/arch/riscv/include/asm/hwprobe.h
+++ b/arch/riscv/include/asm/hwprobe.h
@@ -8,6 +8,6 @@
 
 #include <uapi/asm/hwprobe.h>
 
-#define RISCV_HWPROBE_MAX_KEY 4
+#define RISCV_HWPROBE_MAX_KEY 5
 
 #endif
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 3831b638ecab..4f77a64194e5 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -26,6 +26,17 @@ struct riscv_ipi_ops {
  */
 extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
 #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
+static inline long hartid_to_cpuid_map(unsigned long hartid)
+{
+	long i;
+
+	for_each_possible_cpu(i) {
+		if (cpuid_to_hartid_map(i) == hartid)
+			return i;
+	}
+
+	return -1;
+}
 
 /* print IPI stats */
 void show_ipi_stats(struct seq_file *p, int prec);
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index fc5665411782..93fde30fc4a8 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -25,6 +25,12 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
 #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
 #define		RISCV_HWPROBE_IMA_C		(1 << 1)
+#define RISCV_HWPROBE_KEY_CPUPERF_0	5
+#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_SLOW		(2 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_FAST		(3 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_MASK		(7 << 0)
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 93e45560af30..12af6f7a2f53 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -14,8 +14,10 @@
 #include <linux/of.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/errata_list.h>
 #include <asm/hwcap.h>
+#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
@@ -32,6 +34,9 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
 EXPORT_SYMBOL(riscv_isa_ext_keys);
 
+/* Performance information */
+DEFINE_PER_CPU(long, misaligned_access_speed);
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -89,11 +94,11 @@ static bool riscv_isa_extension_check(int id)
 void __init riscv_fill_hwcap(void)
 {
 	struct device_node *node;
-	const char *isa;
+	const char *isa, *misaligned;
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
-	unsigned long hartid;
+	unsigned long hartid, cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -246,6 +251,28 @@ void __init riscv_fill_hwcap(void)
 			bitmap_copy(riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 		else
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
+
+		/*
+		 * Check for the performance of misaligned accesses.
+		 */
+		cpu = hartid_to_cpuid_map(hartid);
+		if (cpu < 0)
+			continue;
+
+		if (!of_property_read_string(node, "riscv,misaligned-access-performance",
+					     &misaligned)) {
+			if (strcmp(misaligned, "emulated") == 0)
+				per_cpu(misaligned_access_speed, cpu) =
+					RISCV_HWPROBE_MISALIGNED_EMULATED;
+
+			if (strcmp(misaligned, "slow") == 0)
+				per_cpu(misaligned_access_speed, cpu) =
+					RISCV_HWPROBE_MISALIGNED_SLOW;
+
+			if (strcmp(misaligned, "fast") == 0)
+				per_cpu(misaligned_access_speed, cpu) =
+					RISCV_HWPROBE_MISALIGNED_FAST;
+		}
 	}
 
 	/* We don't support systems with F but without D, so mask those out
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index f2b224550923..afc1b96d5c1a 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -7,6 +7,7 @@
 
 #include <linux/syscalls.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
 #include <asm/sbi.h>
 #include <asm/switch_to.h>
@@ -116,6 +117,28 @@ static void hwprobe_arch_id(struct riscv_hwprobe *pair,
 	pair->value = id;
 }
 
+static int hwprobe_misaligned(const struct cpumask *cpus)
+{
+	int cpu, perf = -1;
+
+	for_each_cpu(cpu, cpus) {
+		int this_perf = per_cpu(misaligned_access_speed, cpu);
+
+		if (perf == -1)
+			perf = this_perf;
+
+		if (perf != this_perf) {
+			perf = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+			break;
+		}
+	}
+
+	if (perf == -1)
+		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+
+	return perf;
+}
+
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
 {
@@ -145,6 +168,10 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 
 		break;
 
+	case RISCV_HWPROBE_KEY_CPUPERF_0:
+		pair->value = hwprobe_misaligned(cpus);
+		break;
+
 	/*
 	 * For forward compatibility, unknown keys don't fail the whole
 	 * call, but get their element key set to -1 and value set to 0
-- 
2.25.1

