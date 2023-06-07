Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8335F725D00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbjFGLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjFGLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:24:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FA110DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:24:31 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b01d3bb571so31194175ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1686137071; x=1688729071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKUAIZ0nFHOgAYGnbeK6iIGxT+kuJpEiGpjsvdtXi+U=;
        b=PApebzMKCyqeqXPvbn9sAWGMu9YTfuYS1wTr4s7XojjK/1/8qH0LdaYZ3piwvnIIQr
         LGaZGt6kN5ptNt6YkYXgEfms51C0lWvb4hy/7KMpH6JJNfVF9tuXDP4KPF81cV4uc/2u
         tBH5nf8dSv3mWC38EwFDMdWkkCq/cAGDoDgHuQCDo2Mb8plFlvkLVRCDxKmzHVNBUWjY
         NwRsL6ac/88EiMnZOCnd2l/NbV+HhcHyHbB4RUXMPiP2GcsJ++76oDehR7ppMoluV37J
         fDqEOH0awHQvjzGk7DCl900Kbp7do5DuU9krb1YPvAcI8FaqAnmar4vdEN8ogPgFxEob
         Kryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686137071; x=1688729071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKUAIZ0nFHOgAYGnbeK6iIGxT+kuJpEiGpjsvdtXi+U=;
        b=BbP2dg0FYZ8YmDDQ5a+oiOYfGw1yfbyHsYuABxmfozcoJu8zvRtNTAbmlMKzbZKJDg
         yycb+fmNSa6cYT3Ile/jDNeR3FiLTyFKwPYqALNlEMHqGcDC0GvmUEzKFVOhM0SXka3N
         UlTqctwrjepo9ng+UOxYAYa90Xbh/C6Hv1S2Nq8vsp9/hWvyL9im2YXSW2JuLxxVxWCF
         L/WEeKYyXTb/urkoJKU+1nWGhsWEjzPyxRaWe2LGCNiILY2viC6BMMVclTQRDbqR72pu
         bIYDlH9WVninz6H1i8vb7gqH5kCnuCdhQP6w8ZTIaIHXKf/p4uJetHC74ZSQCf4eDeDv
         kAyQ==
X-Gm-Message-State: AC+VfDxIJEMq2XDrxBbm7uIEbW6Jt8YbSaCtRaZx52ZtT9dnp2YcDHCw
        evKfdz/aQvBzAaZH1ViyV/xcDA==
X-Google-Smtp-Source: ACHHUZ4t9BGyHEKPtBUNtotOJXdVGN9mEB3zaIkJB+YNFGcAMkMgyLneHkxAZFJZFz3IbJdEsSVI1g==
X-Received: by 2002:a17:902:cec4:b0:1b1:dfbd:a192 with SMTP id d4-20020a170902cec400b001b1dfbda192mr2072940plg.57.1686137070768;
        Wed, 07 Jun 2023 04:24:30 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709026b0a00b001b2069072ccsm6228322plk.18.2023.06.07.04.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 04:24:30 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 -next 2/2] RISC-V/perf: Use standard interface to get INTC domain
Date:   Wed,  7 Jun 2023 16:54:17 +0530
Message-Id: <20230607112417.782085-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607112417.782085-1-sunilvl@ventanamicro.com>
References: <20230607112417.782085-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PMU driver is using DT based lookup to
find the INTC node for sscofpmf extension. This will not work
for ACPI based systems causing the driver to fail to register
the PMU overflow interrupt handler.

Hence, change the code to use the standard interface to find
the INTC node which works irrespective of DT or ACPI.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/perf/riscv_pmu_sbi.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 4f3ac296b3e2..0bc491252a44 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -739,7 +739,6 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 {
 	int ret;
 	struct cpu_hw_events __percpu *hw_events = pmu->hw_events;
-	struct device_node *cpu, *child;
 	struct irq_domain *domain = NULL;
 
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
@@ -756,20 +755,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	if (!riscv_pmu_use_irq)
 		return -EOPNOTSUPP;
 
-	for_each_of_cpu_node(cpu) {
-		child = of_get_compatible_child(cpu, "riscv,cpu-intc");
-		if (!child) {
-			pr_err("Failed to find INTC node\n");
-			of_node_put(cpu);
-			return -ENODEV;
-		}
-		domain = irq_find_host(child);
-		of_node_put(child);
-		if (domain) {
-			of_node_put(cpu);
-			break;
-		}
-	}
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
 	if (!domain) {
 		pr_err("Failed to find INTC IRQ root domain\n");
 		return -ENODEV;
-- 
2.34.1

