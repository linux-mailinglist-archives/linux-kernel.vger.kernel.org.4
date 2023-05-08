Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5B6FAF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjEHL4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:55:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E1423B7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:54:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aad5245571so29603785ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546883; x=1686138883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWBNL8Yoxn6F5OA39mGQO+nKX7WWRbncPVBB9F2/Cag=;
        b=UTsXWuWmC1/7OSeoOkGn1KtYJ4R67wvdM1zq1WLN+1ByrSweQv67hbCW21chigqyUL
         RoLkjnU29qDA2eL1AmAYAKdZpKeOZFV2drbpvALpFYEos5q8DrWTc0KulaF49nmXAtxs
         T58TcPDImDQi7FarA7t1zpdQnq/s2chlB7/U1Ayte6Xky8oFb9z5l0IvWzkCp6PyAHpp
         XgNZKJkSZRvGaQCsPymV7tY68VEyhsqUsUTEJBSQF+t9coEokHQ2Ccp5AkD76Zz/V7Sq
         KoBHjvURG9QFm9hHkIcJ1XRk3wsGHhH2zQejXHjZKWxe/9ZDXgLZYHTgrRBDnFn+tXBS
         4Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546883; x=1686138883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWBNL8Yoxn6F5OA39mGQO+nKX7WWRbncPVBB9F2/Cag=;
        b=eMBH48UF67OeCTgpjyNNBaGJ79qf0Wu33exDwrk/KTTMkqdhpi1Lp3DAqDo6LywMq8
         7S85jApf+7MB4U3fkjlW0EIAOp30Gsunf7eHgxw9zmzVcNprG3NHmGxblaV+bY/mX2fb
         Hl9BmnYz+lN04Sri2daYiy0N1MPmr698rOiqDEly/MZ9AjmFQhJolsWRoLyV2mIa85cY
         iNpuQSMn3jtXuNFtX4yAQPR5V786j+rKiIjFgk8e4W6bkouPDhKQ1U2P0qWLet6XdT+Y
         795+SK+U98aJH8KU0jPJ5lPF5xdrBGEB/5HnULS4ZCNnONHlKstxRwL5UnwlHqlq7vCy
         bfXQ==
X-Gm-Message-State: AC+VfDwZVH5rGY5NtDpMKbOP1LvZiYli8oOGrx7lNp6VR8rSzvp7ZZ3Y
        CAXzmGFVeCfVNvfoMc7acic0Jg==
X-Google-Smtp-Source: ACHHUZ5fapwQi2xeO87i4COCX6B1jL+21dW5efwIR1o/iBifUL/k3oeJ8FMjBSZShytx/bDfbkIfDQ==
X-Received: by 2002:a17:902:aa47:b0:1a9:9c5d:9fac with SMTP id c7-20020a170902aa4700b001a99c5d9facmr8993592plr.33.1683546883069;
        Mon, 08 May 2023 04:54:43 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:42 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V5 13/21] RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
Date:   Mon,  8 May 2023 17:22:29 +0530
Message-Id: <20230508115237.216337-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
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

On ACPI based systems, the information about the hart
like ISA is provided by the RISC-V Hart Capabilities Table (RHCT).
Enable filling up hwcap structure based on the information in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpufeature.c | 41 +++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c607db2c842c..6ba8e20c5346 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/log2.h>
@@ -13,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <asm/acpi.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
@@ -100,6 +102,8 @@ void __init riscv_fill_hwcap(void)
 	char print_str[NUM_ALPHA_EXTS + 1];
 	int i, j, rc;
 	unsigned long isa2hwcap[26] = {0};
+	struct acpi_table_header *rhct;
+	acpi_status status;
 	unsigned int cpu;
 
 	isa2hwcap['i' - 'a'] = COMPAT_HWCAP_ISA_I;
@@ -113,22 +117,36 @@ void __init riscv_fill_hwcap(void)
 
 	bitmap_zero(riscv_isa, RISCV_ISA_EXT_MAX);
 
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		node = of_cpu_device_node_get(cpu);
-		if (!node) {
-			pr_warn("Unable to find cpu node\n");
-			continue;
-		}
+		if (acpi_disabled) {
+			node = of_cpu_device_node_get(cpu);
+			if (!node) {
+				pr_warn("Unable to find cpu node\n");
+				continue;
+			}
 
-		rc = of_property_read_string(node, "riscv,isa", &isa);
-		of_node_put(node);
-		if (rc) {
-			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-			continue;
+			rc = of_property_read_string(node, "riscv,isa", &isa);
+			of_node_put(node);
+			if (rc) {
+				pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+				continue;
+			}
+		} else {
+			rc = acpi_get_riscv_isa(rhct, cpu, &isa);
+			if (rc < 0) {
+				pr_warn("Unable to get ISA for the hart - %d\n", cpu);
+				continue;
+			}
 		}
 
 		temp = isa;
@@ -265,6 +283,9 @@ void __init riscv_fill_hwcap(void)
 			bitmap_and(riscv_isa, riscv_isa, this_isa, RISCV_ISA_EXT_MAX);
 	}
 
+	if (!acpi_disabled && rhct)
+		acpi_put_table((struct acpi_table_header *)rhct);
+
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.34.1

