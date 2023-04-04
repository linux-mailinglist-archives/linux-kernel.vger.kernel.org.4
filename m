Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966016D6BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbjDDSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjDDSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:23:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A86A77
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:22:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so31492040pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu/Iz4Gys9b28icQ+yc3gYklUvfwHJ9XRG8B+aoThpM=;
        b=JAHpEivL9I/hqCw5D7j0mXEZAxKh4ujny1mEGmpBbRIxybrn39V0gQUlAcsalhKo0j
         DmCiPnahoqflsNeHLjt954DEvkZLVEOyUaETUrUGy7Apz4Pmy5mnBKd5Q2Td+oduXEUW
         gm5C1C7yfD7vKtL5v7JIUvvBYBF1Y9x5eucLKrwtXh+kjVtvr3NG7LSkgfJ1JBT4OQyZ
         82Ua9PZK4uDHx6vGaE++tMWrsovOH9XjleEqS/+sTt4DY+KzbPfySBA4hMLzhMvwoRm8
         0qE/qIk54OKw04ln/sEiBsJsENPa0WtwYQcYi5x8G0lAtBo6gQQt67n8mmeK7/W+hA6b
         C2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu/Iz4Gys9b28icQ+yc3gYklUvfwHJ9XRG8B+aoThpM=;
        b=Z+5TpY5TkfyXJWdKvyEyeax2MMqdPvr9sNKgEZyOaEzNFSyxn/xM0nK8lqeRyRtXiC
         DoqtiMbd28+9fiteFHeqxmoLjqYNhcPJ+03hQT2jVEwV/QfTT0wuQNgvQnVKSt8KjQPu
         ZwhANdPVxQA+Th3FlftkFajqEFmA8E74dTee+w9zpC5jkaXQc/ZUdmiXMvfccOdvTXE9
         33Hvj7d2rvFHITTCv88fWTt/Tl77rdW3LyBJdcyt9DDtSYFfCIha+Swt+X8o2Gr/CTiY
         pq5WQtN7fnhvzfFzF5aqWk0HkLAb0WwVS3eg1neyxWHa6F6eU8rFyaea/IUk3+1r4jHo
         Xgvw==
X-Gm-Message-State: AAQBX9fa8IZbWWdz7b6L3sW9fyWb8j8PyoVbLdcZPQpMt7/AN4fk97yC
        RCExs6hKCqnF188TvP6ANYl1rQ==
X-Google-Smtp-Source: AKy350ai86QCaCGu2BbzypKJEBx56cY68XZbz28SLHOgdOP1xWWX1b7FVutDsrQKF4LV/W9w+3Grqw==
X-Received: by 2002:a05:6a20:6d2f:b0:da:db55:4a35 with SMTP id fv47-20020a056a206d2f00b000dadb554a35mr148628pzb.4.1680632544910;
        Tue, 04 Apr 2023 11:22:24 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:22:24 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 14/23] RISC-V: cpu: Enable cpuinfo for ACPI systems
Date:   Tue,  4 Apr 2023 23:50:28 +0530
Message-Id: <20230404182037.863533-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ACPI based platforms, few details like ISA need to be read
from the ACPI table. Enable cpuinfo on ACPI based systems.

ACPI has nothing similar to DT compatible property for each CPU.
SBI calls must be used to get vendor/arch/imp ID for any errata.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/cpu.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 8400f0cc9704..ace4752516d8 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -3,10 +3,12 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
 #include <asm/sbi.h>
@@ -283,23 +285,35 @@ static void c_stop(struct seq_file *m, void *v)
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
 	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+	struct device_node *node;
 	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
-	if (!of_property_read_string(node, "riscv,isa", &isa))
-		print_isa(m, isa);
-	print_mmu(m);
-	if (!of_property_read_string(node, "compatible", &compat)
-	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t\t: %s\n", compat);
+
+	if (acpi_disabled) {
+		node = of_get_cpu_node(cpu_id, NULL);
+		if (!of_property_read_string(node, "riscv,isa", &isa))
+			print_isa(m, isa);
+
+		print_mmu(m);
+		if (!of_property_read_string(node, "compatible", &compat) &&
+		    strcmp(compat, "riscv"))
+			seq_printf(m, "uarch\t\t: %s\n", compat);
+
+		of_node_put(node);
+	} else {
+		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
+			print_isa(m, isa);
+
+		print_mmu(m);
+	}
+
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 	seq_puts(m, "\n");
-	of_node_put(node);
 
 	return 0;
 }
-- 
2.34.1

