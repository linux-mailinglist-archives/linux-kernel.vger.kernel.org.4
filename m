Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C06A98B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjCCNjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCCNif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:35 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC61448D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:38:01 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y11so2702553plg.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcUANUnPmLAEK+XIpTGTIqkpKyb9BeUNqm/80XJY5vg=;
        b=XkUA56V6OSWXY471GkW4kVLn1PNkoP0yegLGy0Ue3fMxWyv3Opt/TrgEQ89v+uhM5l
         xzycoQ6aJh4rQndCAbi5StOxCsNhC1uLkGzrJVH8fQPAEE+dgI/RtCyFiTGLib8ygx8w
         me0SrFzXYuI3HmvPpXntl50OPSz36mtIOsoJdtYLB/bNvK8pCgnri3yMkGigOjoGdQta
         AuHx3b9azP0+z8OziaCUVR/bKUnsoshjlUEK/fsjgkv9UMbuuqzHJQDaSVb1wd59ogKx
         rGOlklA8Z5aWjEue6ZiIAkU6tT/BVcFOCZVMlp01uiSnAg/H8H06icOR3G0H8dgPPdTK
         ogmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcUANUnPmLAEK+XIpTGTIqkpKyb9BeUNqm/80XJY5vg=;
        b=QW4O4JQL2RPC34A/T/PidQP9xyBUl13YeDHopIwHmdlcoroxvpCKfnivdTrROFoGED
         NObf2w5oZ5h6kSX4xNyi0wcNSztVQ6jVIvmcwur/7YV2TnHjQAcMSXKYwN7T83CG+WGa
         3PcY5atH4Xutc1tKM4amO2Khi6B9+57eNRuaXXdi9EAdwtULZGFq/FSSBTpsVNzFWrc8
         6HnlpwXidSjzHxQoS2i2zYHclbCOqKXod4QcLgcCIcJ/zKYGlQd6UK0OJe1C1tjHzVhM
         RYADLCDZRNLbrMYRfDzKVlly+o83qtuY+BAD/bOaxP2vjhJFboEhSGkG0ofULjA9ntK9
         AbVA==
X-Gm-Message-State: AO0yUKXqhH9mU17ZWozmCVStfRwcLXgqcRRcS4hd5z/et1H7RNWm0Se8
        kikA3EIll8MbjgNCEzsb3GfAwg==
X-Google-Smtp-Source: AK7set8dJdlMTzofbwwc2OpZqHZJ+omJqGrix56MsJz7IW6hYJ/YKtw8q16TCcLJYH60qn735r1Dgw==
X-Received: by 2002:a17:903:8cb:b0:19e:8e73:e977 with SMTP id lk11-20020a17090308cb00b0019e8e73e977mr2051813plb.67.1677850677984;
        Fri, 03 Mar 2023 05:37:57 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:57 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V3 13/20] RISC-V: cpu: Enable cpuinfo for ACPI systems
Date:   Fri,  3 Mar 2023 19:06:40 +0530
Message-Id: <20230303133647.845095-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303133647.845095-1-sunilvl@ventanamicro.com>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
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

On ACPI based platforms, few details like ISA need to be read
from the ACPI table. Enable cpuinfo on ACPI based systems.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/kernel/cpu.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 8400f0cc9704..80101bf77dab 100644
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
@@ -283,23 +285,32 @@ static void c_stop(struct seq_file *m, void *v)
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
+		print_mmu(m);
+		if (!of_property_read_string(node, "compatible", &compat) &&
+		    strcmp(compat, "riscv"))
+			seq_printf(m, "uarch\t\t: %s\n", compat);
+		of_node_put(node);
+	} else {
+		if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu_id), &isa))
+			print_isa(m, isa);
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

