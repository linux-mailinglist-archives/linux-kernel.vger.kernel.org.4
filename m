Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468E7228E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbjFEOf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjFEOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:35:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D483
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:35:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-256712e2be3so4164100a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685975725; x=1688567725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WhshXKr1H1IgI6UHBSQIBmTcD1tz7rfuPsSZ0ruzz8=;
        b=H7ntuHScdWoPUzoKwZRiZvqfG0awHlrUSSK1pAs+lyeqFTCIxUqklYXFE6dAzkkCBZ
         uCgLf76q03S709XNLv5k7Aow/J45iEBVaUcEhIKIkrhFaZkQaarHrSejsZFr8ZzJLbfD
         YSD1qJIncAISnp2zKZsfw7oNLb2W867w3mU3+2RBoJkzxD6PadpJqptPo4tMnaYlBD55
         6DZiEZ80LPwMv88d+hydYcCdPZKMzpbuaqK7MfRVO4nuu3nv9V+dEfqx9Or2N2mU/rYt
         DA0f6kwF8yS4K5wJWWbFpm67k5WE+l/oAKu3FnPizmpf4ENTAi1b28sbxMsVTCdhpNmE
         bl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975725; x=1688567725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WhshXKr1H1IgI6UHBSQIBmTcD1tz7rfuPsSZ0ruzz8=;
        b=dIlga4aEN60ywXlLSA8FDXmVhMhXBFpOAsJYxqmr9uM+vgKikDvtVJhfGn0UujVD68
         T8S7Gk8aRFepvIAknJmPlG/DywobvMb53WKHJtVRb+u2R/ttfrpFqZN+VdRlpNAdDX2z
         6jcd/w85dQjo/6/BiEcg7FE1BlCNqVEdhq9kkPqkpnFd8WG6Gy4xhLsTP+KTEntu08jW
         LOamLnIFsNh+yTp8lerF4t+lwHJB2F+isx+7R6byHvrua+hb/MCHb+0VjIdpoDy+G8E3
         OiwaKngRl4TsxLpP7m51X53DaqQb3Paz2xfyuiZh8EdeR3BTd0Z14NQ1oSzQfBwJvfN+
         LdXA==
X-Gm-Message-State: AC+VfDyAm01r0C/xWXJRn/KQNDQimdC4bUsl4UN04ZW21RII+otT8hOA
        PuCglaFkjisaZjSI8UwqEsp7ow==
X-Google-Smtp-Source: ACHHUZ4Ov2HL9q+WOUyTJWRvS+NleXOMHYl+52PubaZZyMSGeiU54ocyAhUOLpl4Mv27fCWN3q8bdw==
X-Received: by 2002:a17:90a:9201:b0:255:cddf:a0c8 with SMTP id m1-20020a17090a920100b00255cddfa0c8mr7068618pjo.41.1685975725413;
        Mon, 05 Jun 2023 07:35:25 -0700 (PDT)
Received: from kerodi.Dlink ([106.51.186.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a1fce00b00250334d97dasm8297069pjz.31.2023.06.05.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:35:25 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v1 -next 2/2] RISC-V/perf: Use standard interface to get INTC domain
Date:   Mon,  5 Jun 2023 20:05:12 +0530
Message-Id: <20230605143512.707533-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605143512.707533-1-sunilvl@ventanamicro.com>
References: <20230605143512.707533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

