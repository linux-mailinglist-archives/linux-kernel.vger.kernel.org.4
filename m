Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE9699C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBPSW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBPSWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0B552B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:51 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ja21so2898894plb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVlhq9jJF5fkqCwNhAPs1olNplFdF6B5WclRLPqFQkc=;
        b=Ih5cdvHUc+6binLwjpr9QH0EbQBhTLyXOn/RYXvnmLofBP2hcHPkdG0+7hRgOIc02B
         5GjCVp29i00cLIPLwY831s+ehgLGUY5ccr/5K8Ey+Q9UIFlTzXxleMG/mmV+zz0rmfxx
         EeCcij3QYpom+JUlpOhqSPVU14ZW5Q01dfQ9xD0heAmdGyuYsIbPcwN2dc6YsfWyPYvh
         liTNxl3kFNv75Su6bUJ37zkzS0WxwE7ZOgsJ4PWqf/bMl4qPijkYC+2QM6Y2e1gJ/1DG
         szGLGMguiud/r0MyWRTMx0xryUd8EIMUNOEcamcLUNJP+REakrD9PxQOyILiHtEZ2zJ+
         im/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVlhq9jJF5fkqCwNhAPs1olNplFdF6B5WclRLPqFQkc=;
        b=FJBTkwJo2jJdK/TQh5Uguo198HTMd8W0sJrKNjdwn22CMm0Ep8SoIC4ZAGo1j6sKPG
         GfXIkXHxDXst1LXj6fYQnFrFAjB2h9B5k3rNFKO7Ot3RzOUU0zScr+OnWqX9Qggop3Br
         KWI/taMAmID/0d2NP/79Nq24QaJw+WOszZO8tChS2PVqaDicwxmpG2x0MZ8EruoQD24A
         IN7+yV2PY/c/SwYxY2Y+dlFnhYZYrpUDKkDg2SQaLOwxy5y7XcVUjKArcckrqqQtc3Di
         F3D0UGsinCQK9Msb4cnClviKgUl3h86pSRekPF0mRiaoGfIRPvQiU+9iJ1gZNQocBwOS
         WCMw==
X-Gm-Message-State: AO0yUKVtP9EvdHX8yLJtE4XJWTDN37DMkI+nAWuv2BD9QQSyt8MpQRNI
        oWLvvaouqUam1psblSMbOQvEWA==
X-Google-Smtp-Source: AK7set+h7vf0LoZNkAGb2ghe6awEhCUdpqK+4V6FZ+wNFpKTON2Ckkza6yhNBDRyc7g3pDb0ZFspUg==
X-Received: by 2002:a05:6a21:7899:b0:c7:6664:1e07 with SMTP id bf25-20020a056a21789900b000c766641e07mr202270pzc.28.1676571710197;
        Thu, 16 Feb 2023 10:21:50 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:49 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 12/21] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
Date:   Thu, 16 Feb 2023 23:50:34 +0530
Message-Id: <20230216182043.1946553-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

On ACPI based systems, the information about the hart
like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
Enable filling up hwcap structure based on the information in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 93e45560af30..cb67d3fcbb56 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -6,12 +6,15 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/errata_list.h>
@@ -93,7 +96,10 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
+	struct acpi_table_header *rhct;
+	acpi_status status;
 	unsigned long hartid;
+	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m' - 'a'] = COMPAT_HWCAP_ISA_M;
@@ -106,18 +112,36 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
-	for_each_of_cpu_node(node) {
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
+
+	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		rc = riscv_of_processor_hartid(node, &hartid);
-		if (rc < 0)
-			continue;
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (node) {
+				rc = riscv_of_processor_hartid(node, &hartid);
+				if (rc < 0)
+					continue;
 
-		if (of_property_read_string(node, "riscv,isa", &isa)) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-			continue;
+				if (of_property_read_string(node, "riscv,isa", &isa)) {
+					pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+					continue;
+				}
+				of_node_put(node);
+			}
+		} else {
+			rc = acpi_get_riscv_isa(rhct, get_acpi_id_for_cpu(cpu), &isa);
+			if (rc < 0) {
+				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
+				continue;
+			}
 		}
 
 		temp = isa;
@@ -248,6 +272,9 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+	if (!acpi_disabled)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.34.1

