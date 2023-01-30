Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176368190A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjA3S0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjA3SYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:24:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90576BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:37 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k13so12602797plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tmqm1KrH8Rx3qerFslFMAYGwIdVV+GEj7SnscFfXmQ0=;
        b=cPqIpB8prS7hDFjj+h2EyPJYy7PzmnnK7RExz1Ok8dR7rRKT+hcVUGsFGHWUlBqJwN
         7TFI8iyfHhoGD4a989XpaHBs/LV8kw/QUgsWAYRqlX1j2J426hfu4JuvWvWp2Ur+aJva
         bIvHdZ3mMBp4tBmotAyHnxK+PkLaI1ltXKPKRM3DZCEAeySNiyDpT3o7bmmnIzIHMSvv
         NHmf9xDgFjhefd/ngOEANI2MN4vf8CxitwuTZvXZT7ThVciVKtcZRlVErvkJjCEEW2sn
         WchYKaK4+/IvPJhKS+PXyhvjlMpYJw11G5D54C68fDhwazqvPkacu5QTTU7uvSoVkfjg
         zARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tmqm1KrH8Rx3qerFslFMAYGwIdVV+GEj7SnscFfXmQ0=;
        b=CTcP2L4CMV9399isJncM25v891Vdp+M8vkx8fLmxy8H/5Zbfsr4Mxrl9UyZmsLL7M4
         ev3Ll5rmtwHRti0swqo1y9xHJ3XE4wyXdWT6q1wCgDy987Nr7uMeBRcAMNjHAvi6CMyv
         W3ZAClustUC5ViBtT3wW33nwgCLZBxXKwvBgC3zy4Gwvtda6/b2+2YaLX6VUxsZoMp5t
         ukQS/1x7FVfmdChLq9twuD2zD1RnVTMEAvvt+wfdQeMDcP2TjFSwem337zjesB84rnlg
         THBdINMYxBZk7r7Ceu2D4YYuEuKqXYXhjcMVq8akMeH7Qc7UZfneUOvneFk6z1gO+Fpw
         DUYg==
X-Gm-Message-State: AO0yUKV24JIqIaaqJpTfZxj+3BPbhHEV8KEIpUWGjgt9S/wxNuBAfBxE
        8fXjtnKpLprZe5n81vuxZZRpDA==
X-Google-Smtp-Source: AK7set8mUQ/h8KMYQ2zVbbHUXRL1WVlOMXJhgdTYz7w1If9zAbycA9u/XMnVWA+UBeINzP9AUSP2wA==
X-Received: by 2002:a17:903:190:b0:196:869c:8c5c with SMTP id z16-20020a170903019000b00196869c8c5cmr5258522plg.51.1675103013599;
        Mon, 30 Jan 2023 10:23:33 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:33 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 13/24] RISC-V: ACPI: smpboot: Add ACPI support in smp_setup()
Date:   Mon, 30 Jan 2023 23:52:14 +0530
Message-Id: <20230130182225.2471414-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function to parse the RINTC structure in
the MADT table and create the required initializations to
enable SMP boot on ACPI based platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  7 ++++
 arch/riscv/kernel/smpboot.c   | 73 ++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index c5cb9f96d404..d1f1e53ec657 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -58,6 +58,13 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
+
+#ifdef CONFIG_ACPI_NUMA
+int acpi_numa_get_nid(unsigned int cpu);
+#else
+static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+#endif /* CONFIG_ACPI_NUMA */
+
 #endif
 
 #endif /*_ASM_ACPI_H*/
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 26214ddefaa4..e48cf88d0bc1 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/arch_topology.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -70,6 +71,73 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
+#ifdef CONFIG_ACPI
+static unsigned int cpu_count = 1;
+
+static int __init
+acpi_parse_rintc(union acpi_subtable_headers *header,
+			     const unsigned long end)
+{
+	unsigned long hart;
+	bool found_boot_cpu = false;
+
+	struct acpi_madt_rintc *processor;
+
+	processor = (struct acpi_madt_rintc *)header;
+
+	/* RINTC entry which has !ACPI_MADT_ENABLED is not enabled so skip */
+	if (!(processor->flags & ACPI_MADT_ENABLED))
+		return 0;
+
+	hart = processor->hart_id;
+	if (hart < 0)
+		return 0;
+	if (hart == cpuid_to_hartid_map(0)) {
+		BUG_ON(found_boot_cpu);
+		found_boot_cpu = 1;
+		early_map_cpu_to_node(0, acpi_numa_get_nid(cpu_count));
+		return 0;
+	}
+	if (cpu_count >= NR_CPUS) {
+		pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
+			cpu_count, hart);
+		return 0;
+	}
+
+	cpuid_to_hartid_map(cpu_count) = hart;
+	early_map_cpu_to_node(cpu_count, acpi_numa_get_nid(cpu_count));
+	cpu_count++;
+	return 0;
+}
+
+static void __init acpi_parse_and_init_cpus(void)
+{
+	int cpuid;
+
+	cpu_set_ops(0);
+	/*
+	 * do a walk of MADT to determine how many CPUs
+	 * we have including disabled CPUs, and get information
+	 * we need for SMP init.
+	 */
+	acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC,
+				      acpi_parse_rintc, 0);
+
+	/*
+	 * NUMA - TODO
+	 */
+
+	for (cpuid = 1; cpuid < nr_cpu_ids; cpuid++) {
+		if (cpuid_to_hartid_map(cpuid) != INVALID_HARTID) {
+			cpu_set_ops(cpuid);
+			set_cpu_possible(cpuid, true);
+		}
+	}
+}
+#else
+#define acpi_parse_and_init_cpus(...)	do { } while (0)
+#endif
+
 static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
@@ -118,7 +186,10 @@ static void __init of_parse_and_init_cpus(void)
 
 void __init setup_smp(void)
 {
-	of_parse_and_init_cpus();
+	if (acpi_disabled)
+		of_parse_and_init_cpus();
+	else
+		acpi_parse_and_init_cpus();
 }
 
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
-- 
2.38.0

