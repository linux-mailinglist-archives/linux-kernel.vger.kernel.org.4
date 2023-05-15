Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBCC7023DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjEOFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjEOFyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:54:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5814205
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:51:35 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aad55244b7so93709445ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129893; x=1686721893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS1GWILYl7Q6QsdApEh939z6h09NwhOHpvU6XTgdfRk=;
        b=csvVea0/Upvs+e/kvOVx0v5vn2HOJORQbM6M+e03WFd3D+jy/1h0Jc4uWPHETq7pAi
         B2oxN+0/NcooJYNHOQK6y8pTg2ObPZr1tTH7inBU+XHT6em5CA9TUr/0eC7DErUXZPjJ
         mTEVurLQslXQBtarT2oOyzq/yvIZe0/k/gXwbWXt2bNeLsM3uUwJJ7OXM7DFBREwFdpy
         Spcr/xd6W2ShZz9ZW66OO+BhLP/ouyjgjSeHqhszfiVrK1dz2JaSLRg8V8x3VDtUgWkt
         IisUCX07oJ+0INM7uMStg3kzoXfhqM+EiG4lFoF199+PXntlyPkl4XG0PAnHWf2JhW+U
         p6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129893; x=1686721893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS1GWILYl7Q6QsdApEh939z6h09NwhOHpvU6XTgdfRk=;
        b=EiuJkFUVHy4Qk+dInzS/ljbPLLgzpBYXiHDI+Sur9oHSiSfadTQGwUf2ICp3HXhdSZ
         s4QETW37cHTDdEu567iQR+S/6gNrmsPS7sO7F/n5Y5A5xPnEdBCQQ80FJmzvDj/KPnK7
         oLYL2NXX60t8xRSqmV0wejrQ4qMLsPVcwOUnPLzDwjwbXDpHsK76NRDi5QMAJrps2P3h
         3ZFtlnW8Vf79S+u9dt8xst0P+9TFrqk5r//r5jkZE1ojl0bE6R5rWg6U7mg+2HmSiodq
         Ck60AXA3ea5b93w+96w1Hxsik4WHeWjQ6XDZTZaT0M+bghOEZJfLqAn4NxDdQmfZckwG
         acLA==
X-Gm-Message-State: AC+VfDzZkdzvbQWd906yglP12THdirSqewl8Mpp8rMU/CxBbJVk9Wxvy
        jZaCy86deIw+mf7DqIfyPQuoqA==
X-Google-Smtp-Source: ACHHUZ7buSle7e6BYrW3/obLZDohFRy8Vxc6R0Jdryndp9BmcFr7gna75GEfGN/V2L/t/8Mcx129kg==
X-Received: by 2002:a17:902:ee89:b0:1a6:74f6:fa92 with SMTP id a9-20020a170902ee8900b001a674f6fa92mr35025309pld.19.1684129893096;
        Sun, 14 May 2023 22:51:33 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:51:32 -0700 (PDT)
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
        Anup Patel <apatel@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V6 17/21] clocksource/timer-riscv: Refactor riscv_timer_init_dt()
Date:   Mon, 15 May 2023 11:19:24 +0530
Message-Id: <20230515054928.2079268-18-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the timer init function such that few things can be
shared by both DT and ACPI based platforms.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/clocksource/timer-riscv.c | 81 +++++++++++++++----------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 5f0f10c7e222..cecc4662293b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -124,61 +124,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init riscv_timer_init_dt(struct device_node *n)
+static int __init riscv_timer_init_common(void)
 {
-	int cpuid, error;
-	unsigned long hartid;
-	struct device_node *child;
+	int error;
 	struct irq_domain *domain;
+	struct fwnode_handle *intc_fwnode = riscv_get_intc_hwnode();
 
-	error = riscv_of_processor_hartid(n, &hartid);
-	if (error < 0) {
-		pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
-			n, hartid);
-		return error;
-	}
-
-	cpuid = riscv_hartid_to_cpuid(hartid);
-	if (cpuid < 0) {
-		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
-		return cpuid;
-	}
-
-	if (cpuid != smp_processor_id())
-		return 0;
-
-	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
-	if (child) {
-		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
-					"riscv,timer-cannot-wake-cpu");
-		of_node_put(child);
-	}
-
-	domain = NULL;
-	child = of_get_compatible_child(n, "riscv,cpu-intc");
-	if (!child) {
-		pr_err("Failed to find INTC node [%pOF]\n", n);
-		return -ENODEV;
-	}
-	domain = irq_find_host(child);
-	of_node_put(child);
+	domain = irq_find_matching_fwnode(intc_fwnode, DOMAIN_BUS_ANY);
 	if (!domain) {
-		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
+		pr_err("Failed to find irq_domain for INTC node [%pfwP]\n",
+		       intc_fwnode);
 		return -ENODEV;
 	}
 
 	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
 	if (!riscv_clock_event_irq) {
-		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
+		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode);
 		return -ENODEV;
 	}
 
-	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
-	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("RISCV timer registration failed [%d]\n", error);
 		return error;
 	}
 
@@ -207,4 +174,36 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	return error;
 }
 
+static int __init riscv_timer_init_dt(struct device_node *n)
+{
+	int cpuid, error;
+	unsigned long hartid;
+	struct device_node *child;
+
+	error = riscv_of_processor_hartid(n, &hartid);
+	if (error < 0) {
+		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n",
+			n, hartid);
+		return error;
+	}
+
+	cpuid = riscv_hartid_to_cpuid(hartid);
+	if (cpuid < 0) {
+		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
+		return cpuid;
+	}
+
+	if (cpuid != smp_processor_id())
+		return 0;
+
+	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
+	if (child) {
+		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
+					"riscv,timer-cannot-wake-cpu");
+		of_node_put(child);
+	}
+
+	return riscv_timer_init_common();
+}
+
 TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
-- 
2.34.1

