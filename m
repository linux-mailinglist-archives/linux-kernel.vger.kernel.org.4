Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB37023AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjEOFxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEOFwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:52:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BAA3AA6
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf21bb427so87339955ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129838; x=1686721838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v2bs5xTQyOuSGvIvmLXVuNSftw7ZeZMht4+ShyVipQ=;
        b=RmaB51MYWIpBQA9mV7M5FUd4YH/0UJaKlKCItuTXiTL5VeyNVqOvTaTWlOWnjARNp2
         LQ4dkHBB+AbxDs6LRKiAm9mhsP/s1fUelzbMpB0vY45D0FWIEdeNffHHtJRm3MfdYbXr
         EDe1K0YRtLY2d+yUk5W13m/bj+EkrGrW4KIuaH7q0koJQh2GacV+2HzlZBFCVGIsIGje
         1z7VIAXxRNhYX76BX2LRGp1g+qFEins09NK/j4rIQy0qMFwUrYeTKmgfgamGmZnE6YSp
         8Q+NNIpN6w9s/SMsvLqsbNn23he6cHTE6ip1X60ON/CcMxEaUiCabT2aEtA2Uk0wgN45
         mhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129838; x=1686721838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v2bs5xTQyOuSGvIvmLXVuNSftw7ZeZMht4+ShyVipQ=;
        b=Sdtexrlu6qievy6MyVK5AuxNbItoNTXOdI+Vqf9GWj+nvx0+YuAJYQlUT7eyRYnwHT
         kO8ODX+3D2OYVzgU5cU6kv4GlDGzxmJbyzB/dobImL/7sLgQdn+Iba0TAt9OMcRZotM1
         JcLiTNmEXskEkM5onnAUyjIGVoDN545s6l1vEvbumEq3AqRuiU5isuY+GsV3d8FWoWVs
         nnj3kmajXg/GmwhvxEoqjBh3ugadGC2slLD3oI0A6Fsfki85HjSgn7/mVnEXOcKqW+aH
         UmfmzEKP70HcMK6dC7kfOjgXthvBb59di3ZpcBifZj8vxhIDASFAJF4IGjjdpm54a/bZ
         Rzjw==
X-Gm-Message-State: AC+VfDx+negrinIii+7bh5cuMvGulmL0qjQmen5EN2SylAtw0GB0iOx/
        COkog5ZKn0ROwgEVaJQ8t/lhow==
X-Google-Smtp-Source: ACHHUZ4FCJbXEF7jGJtfVFATqqrI7NRHNm2vMCppVSOYxho2mMsZFQvzi5wvH17RLX0iWlIACxrEWw==
X-Received: by 2002:a17:903:32c7:b0:1ac:820e:c348 with SMTP id i7-20020a17090332c700b001ac820ec348mr34619195plr.0.1684129837705;
        Sun, 14 May 2023 22:50:37 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:50:37 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V6 09/21] RISC-V: ACPI: Cache and retrieve the RINTC structure
Date:   Mon, 15 May 2023 11:19:16 +0530
Message-Id: <20230515054928.2079268-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RINTC structures in the MADT provide mapping between the hartid
and the CPU. This is required many times even at run time like
cpuinfo. So, instead of parsing the ACPI table every time, cache
the RINTC structures and provide a function to get the correct
RINTC structure for a given cpu.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/include/asm/acpi.h | 10 ++++++++
 arch/riscv/kernel/acpi.c      | 45 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/setup.c     |  4 ++++
 3 files changed, 59 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 9be52b6ffae1..6519529c8bdf 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -59,6 +59,16 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
+void acpi_init_rintc_map(void);
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
+u32 get_acpi_id_for_cpu(int cpu);
+#else
+static inline void acpi_init_rintc_map(void) { }
+static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 7c080c8cbccf..df5a45a2eb93 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -29,6 +29,8 @@ static bool param_acpi_off __initdata;
 static bool param_acpi_on __initdata;
 static bool param_acpi_force __initdata;
 
+static struct acpi_madt_rintc cpu_madt_rintc[NR_CPUS];
+
 static int __init parse_acpi(char *arg)
 {
 	if (!arg)
@@ -150,6 +152,49 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
+static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
+	int cpuid;
+
+	if (!(rintc->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	cpuid = riscv_hartid_to_cpuid(rintc->hart_id);
+	/*
+	 * When CONFIG_SMP is disabled, mapping won't be created for
+	 * all cpus.
+	 * CPUs more than num_possible_cpus, will be ignored.
+	 */
+	if (cpuid >= 0 && cpuid < num_possible_cpus())
+		cpu_madt_rintc[cpuid] = *rintc;
+
+	return 0;
+}
+
+/*
+ * Instead of parsing (and freeing) the ACPI table, cache
+ * the RINTC structures since they are frequently used
+ * like in  cpuinfo.
+ */
+void __init acpi_init_rintc_map(void)
+{
+	if (acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, acpi_parse_madt_rintc, 0) <= 0) {
+		pr_err("No valid RINTC entries exist\n");
+		BUG();
+	}
+}
+
+struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
+{
+	return &cpu_madt_rintc[cpu];
+}
+
+u32 get_acpi_id_for_cpu(int cpu)
+{
+	return acpi_cpu_get_madt_rintc(cpu)->uid;
+}
+
 /*
  * __acpi_map_table() will be called before paging_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 45df7cc88b19..2ab4cdaa2e68 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/efi.h>
 #include <linux/crash_dump.h>
 
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -298,6 +299,9 @@ void __init setup_arch(char **cmdline_p)
 	setup_smp();
 #endif
 
+	if (!acpi_disabled)
+		acpi_init_rintc_map();
+
 	riscv_init_cbo_blocksizes();
 	riscv_fill_hwcap();
 	apply_boot_alternatives();
-- 
2.34.1

