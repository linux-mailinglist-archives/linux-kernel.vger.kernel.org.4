Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0168C768
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBFUP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBFUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:15:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E136B298D8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 12:15:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u9so9137194plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NHVkmDL1+Nl1bWyENrxaEG8nDhTyqPy5db4QyUwgAo=;
        b=e8e+hue89xD8AFuDM03gwXKPLXaajuv/b6VKDvoCoBf/iT/zGbXP5ooZz6ZYbxq6Ol
         pRMgq09e2uQzEmi3gW2ANefxMoKxdin+1LUdy2mn4NylyIUDGaTWDxyjf1oczOmGaopv
         ndd3dltEwWjxIEDp1GgserBBoHjJv3C9Pc6EWZJRz/RZNmqctSUvEAebndq63RXZ+k7V
         /m63PZ0vyxSC7rZCehQpF0Svw1z8LboRIPAztWTftiwt30MEirNTJr2AMxI+5Tj7uC5w
         Tl2CfBrbUBvVi8ZqW29uwBXyWdzGmZ0ZA5goqX/HCZIg74rzSCOVCE2WwS2IAOgVugOP
         uEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NHVkmDL1+Nl1bWyENrxaEG8nDhTyqPy5db4QyUwgAo=;
        b=2hLXDrW7KqByb277sfCdJGDwKy0rxjgbwDXY2tB8MOZtA+cEzkffmHe4uR1POo9qBW
         UXEq/xGPyiblHov/jqxL/rg7g7FXiyUEKIyJp10ZsdrYXSw6dolcpUjAngr8fVJFhRlo
         zBu6rgRRo7FROVoUCEK5y7c4mzppSrpquKFZeK8fROX61wIESStNK3CPw70ghH4VII9i
         3B9g5p3HDVEb9Fb/x+u1oNsRwzQa3g0bBQtWKrKPrqL9KjiStpD2TKiDdtxWryMJgf3m
         veXFLFT7wOL9teFhNCiZfp67nHO5b0YiU/DCharw7/5D819hWv65uFhIyWaqK7tszC7B
         eiuw==
X-Gm-Message-State: AO0yUKWPnKoiL0pClI2t6q32FCeUnSrusXL+KzqF0pbBONCZ6XtsEKCt
        1ZuW3gTVaYfldN4YVggA4cYyDg==
X-Google-Smtp-Source: AK7set+JVHNnFfvIUBCDQKktjW0TUQczLdFGPbSNh2d9L/P8+GzUJBG4uu0TKecEvC/h+y8Fy8TFlQ==
X-Received: by 2002:a17:90b:3ecc:b0:22b:fff0:f80c with SMTP id rm12-20020a17090b3ecc00b0022bfff0f80cmr1033780pjb.1.1675714538280;
        Mon, 06 Feb 2023 12:15:38 -0800 (PST)
Received: from evan.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id k10-20020a63ab4a000000b004df4fbb9823sm6425079pgp.68.2023.02.06.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 12:15:37 -0800 (PST)
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
        Celeste Liu <coelacanthus@outlook.com>,
        Guo Ren <guoren@kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 5/6] RISC-V: hwprobe: Support probing of misaligned access performance
Date:   Mon,  6 Feb 2023 12:14:54 -0800
Message-Id: <20230206201455.1790329-6-evan@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206201455.1790329-1-evan@rivosinc.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
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

Changes in v2:
 - Fixed logic error in if(of_property_read_string...) that caused crash
 - Include cpufeature.h in cpufeature.h to avoid undeclared variable
   warning.
 - Added a _MASK define
 - Fix random checkpatch complaints

 Documentation/riscv/hwprobe.rst       | 13 +++++++++++
 arch/riscv/include/asm/cpufeature.h   |  2 ++
 arch/riscv/include/asm/hwprobe.h      |  2 +-
 arch/riscv/include/asm/smp.h          |  9 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h |  6 ++++++
 arch/riscv/kernel/cpufeature.c        | 31 +++++++++++++++++++++++++--
 arch/riscv/kernel/sys_riscv.c         | 23 ++++++++++++++++++++
 7 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/riscv/hwprobe.rst b/Documentation/riscv/hwprobe.rst
index ce186967861f..0dc75e83e127 100644
--- a/Documentation/riscv/hwprobe.rst
+++ b/Documentation/riscv/hwprobe.rst
@@ -51,3 +51,16 @@ The following keys are defined:
       not minNum/maxNum") of the RISC-V ISA manual.
     * :RISCV_HWPROBE_IMA_C:: The C extension is supported, as defined by
       version 2.2 of the RISC-V ISA manual.
+* :RISCV_HWPROBE_KEY_PERF_0:: A bitmask that contains performance information
+  about the selected set of processors.
+    * :RISCV_HWPROBE_MISALIGNED_UNKNOWN:: The performance of misaligned
+      accesses is unknown.
+    * :RISCV_HWPROBE_MISALIGNED_EMULATED:: Misaligned accesses are emulated via
+      software, either in or below the kernel.  These accesses are always
+      extremely slow.
+    * :RISCV_HWPROBE_MISALIGNED_SLOW:: Misaligned accesses are supported in
+      hardware, but are slower than the cooresponding aligned accesses
+      sequences.
+    * :RISCV_HWPROBE_MISALIGNED_FAST:: Misaligned accesses are supported in
+      hardware and are faster than the cooresponding aligned accesses
+      sequences.
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 66c251d98290..ac51a9e6387a 100644
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
index 3831b638ecab..6c1759091e44 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -26,6 +26,15 @@ struct riscv_ipi_ops {
  */
 extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
 #define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
+static inline long hartid_to_cpuid_map(unsigned long hartid)
+{
+	long i;
+
+	for (i = 0; i < NR_CPUS; ++i)
+		if (cpuid_to_hartid_map(i) == hartid)
+			return i;
+	return -1;
+}
 
 /* print IPI stats */
 void show_ipi_stats(struct seq_file *p, int prec);
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index ce39d6e74103..5d55e2da2b1f 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -25,5 +25,11 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
 #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
 #define		RISCV_HWPROBE_IMA_C		(1 << 1)
+#define RISCV_HWPROBE_KEY_CPUPERF_0	5
+#define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_SLOW		(2 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_FAST		(3 << 0)
+#define		RISCV_HWPROBE_MISALIGNED_MASK		(3 << 0)
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
index 74e0d72c877d..73d937c54f4e 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -133,6 +133,25 @@ static long hwprobe_mid(struct riscv_hwprobe __user *pair, size_t key,
 	return set_hwprobe(pair, id);
 }
 
+static long hwprobe_misaligned(cpumask_t *cpus)
+{
+	long cpu, perf = -1;
+
+	for_each_cpu(cpu, cpus) {
+		long this_perf = per_cpu(misaligned_access_speed, cpu);
+
+		if (perf == -1)
+			perf = this_perf;
+
+		if (perf != this_perf)
+			perf = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+	}
+
+	if (perf == -1)
+		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+	return perf;
+}
+
 static
 long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
 		      long cpu_count, unsigned long __user *cpus_user,
@@ -205,6 +224,10 @@ long do_riscv_hwprobe(struct riscv_hwprobe __user *pairs, long pair_count,
 			}
 			break;
 
+		case RISCV_HWPROBE_KEY_CPUPERF_0:
+			ret = set_hwprobe(pairs, hwprobe_misaligned(&cpus));
+			break;
+
 		/*
 		 * For forward compatibility, unknown keys don't fail the whole
 		 * call, but get their element key set to -1 and value set to 0
-- 
2.25.1

