Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F957157E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjE3IFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjE3IFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:05:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85435A0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:05:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so4451023e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685433935; x=1688025935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE2V4w60Dr4KmhFU+zZAwNVp1NcYAQGXzbYjl1GCUek=;
        b=keNryjCZTZ+P0D96maQFGaRLcSCRBFFxPHnEhjqLpCh7+4kizGYxuGYQZnwqlfazRo
         rRBh2+OrKdMSdqiBCBElVDaVyE4lw5GHC3/zCDICzkuAGTbkIf+saAuVY0bQIJXuQUgv
         9mehGHJKI/7Igd4ZY8dPdKvObfGKnGtLCUItGKjrfJ0oml17bbTGhl3PxCbEQ4I0MYe+
         2s/4BCmvmvwKtZ7y7BspsViyniky0xWxTXy278AOjU0ncyJLd7e3lKoWAKekHWGwrPOD
         1/xjIlyPK8KBVBrs1+keBLKqdKb2gHXeambE9hZ/jRvIAStc6A2pzQlyBaqSJeDpIiwZ
         s6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433935; x=1688025935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE2V4w60Dr4KmhFU+zZAwNVp1NcYAQGXzbYjl1GCUek=;
        b=hOPB3tyKfQyW9GV5vs7qB9S11mvkrsMoHmd9X55a+EVJQdJFPg7JMjQoT10uRctdTH
         wQjCJRZLSEwsytnkAGURP2cT7kGclXLcSkYyuvzzBYJMgS/mMFcp5rA3puAzmR3RpjYq
         SMPChwoqcwMgLWMd/OlvUQXH76GxSz2x6VBkGA78uud5EutZLkRh+uFvq0AhYpEpX6wf
         6eFDJcHoBnbkn7sIrVJdwNhu7EGFYVSljM0nLPfYc9dTBI8F+avHYKeVFnsejHXUlHtl
         ZAS7aeO6o3bOXd/ZI+YHxSGdY1BEzqWKorganBpPaZgVapE5TFbB99t0cT/fxiBYNXTS
         N2LQ==
X-Gm-Message-State: AC+VfDzBTGjevMEIYepQTr0Qh7UamTXmKnrT1qskA9i5qIkWXDQHN6qH
        dZoamFLtBh31ANz3yjpyp6W5sg==
X-Google-Smtp-Source: ACHHUZ6FZUGXMLScHcwke2B9uBZnDkB6vzPJlFOBVa3kFIacWRhIPLdZVZkw0IyBdZ03ROfGk7u0IA==
X-Received: by 2002:a19:f502:0:b0:4f4:db63:239f with SMTP id j2-20020a19f502000000b004f4db63239fmr388689lfb.24.1685433934690;
        Tue, 30 May 2023 01:05:34 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c294400b003f3157988f8sm16296889wmd.26.2023.05.30.01.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:05:34 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [RFC PATCH 1/1] fdt: Mark "/reserved-memory" nodes as nosave if !reusable
Date:   Tue, 30 May 2023 10:04:25 +0200
Message-Id: <20230530080425.18612-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530080425.18612-1-alexghiti@rivosinc.com>
References: <20230530080425.18612-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hibernation process will access those reserved memory regions if
they are part of the linear mapping, but as described in
devicetree/bindings/reserved-memory/reserved-memory.yaml,
"/reserved-memory" nodes should not be used as normal memory, unless they
are marked as reusable which means the kernel can access it at some point.

Otherwise those regions are only used by drivers which should do what's
necessary when the hibernation process is started, or they can contain
the firmware reserved memory regions which should not be accessed at all.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c |  2 +
 drivers/of/fdt.c          | 77 +++++++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h    |  1 +
 3 files changed, 80 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..642f1035b5ce 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -299,6 +299,8 @@ void __init setup_arch(char **cmdline_p)
 	if (IS_ENABLED(CONFIG_RISCV_ISA_ZICBOM) &&
 	    riscv_isa_extension_available(NULL, ZICBOM))
 		riscv_noncoherent_supported();
+
+	early_init_fdt_nosave_reserved_mem();
 }
 
 static int __init topology_init(void)
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..863de7e6b10c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -26,6 +26,7 @@
 #include <linux/serial_core.h>
 #include <linux/sysfs.h>
 #include <linux/random.h>
+#include <linux/suspend.h>
 
 #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
 #include <asm/page.h>
@@ -494,6 +495,43 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 	return memblock_reserve(base, size);
 }
 
+/*
+ * __reserved_mem_nosave_reg() - Make all memory described in 'reg' property as
+ * nosave, unless it is "reusable".
+ */
+static void __init __reserved_mem_nosave_reg(unsigned long node,
+					     const char *uname)
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	phys_addr_t base, size;
+	int len;
+	const __be32 *prop;
+	bool reusable;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop)
+		return;
+
+	if (len && len % t_len != 0) {
+		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+		       uname);
+		return;
+	}
+
+	reusable = of_get_flat_dt_prop(node, "reusable", NULL) != NULL;
+
+	while (len >= t_len) {
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size && !reusable)
+			register_nosave_region(phys_to_pfn(base),
+					       phys_to_pfn(base + size));
+
+		len -= t_len;
+	}
+}
+
 /*
  * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
@@ -596,6 +634,38 @@ static int __init fdt_scan_reserved_mem(void)
 	return 0;
 }
 
+/*
+ * fdt_nosave_reserved_mem() - scan a single FDT node to mark reserved memory
+ * as nosave.
+ */
+static int __init fdt_nosave_reserved_mem(void)
+{
+	int node, child;
+	const void *fdt = initial_boot_params;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0)
+		return -ENODEV;
+
+	if (__reserved_mem_check_root(node) != 0) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return -EINVAL;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+
+		__reserved_mem_nosave_reg(child, uname);
+	}
+
+	return 0;
+}
+
 /*
  * fdt_reserve_elfcorehdr() - reserves memory for elf core header
  *
@@ -649,6 +719,13 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	fdt_init_reserved_mem();
 }
 
+void __init early_init_fdt_nosave_reserved_mem(void)
+{
+#ifdef CONFIG_HIBERNATION
+	fdt_nosave_reserved_mem();
+#endif
+}
+
 /**
  * early_init_fdt_reserve_self() - reserve the memory used by the FDT blob
  */
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..55eb5a0f7305 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -63,6 +63,7 @@ extern int early_init_dt_scan_memory(void);
 extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
+extern void early_init_fdt_nosave_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
-- 
2.39.2

