Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667463C1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbiK2OED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiK2ODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:03:41 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650624B76D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:39 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 9so13765031pfx.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNSMrXgsDIBPEX+PmJvz8brS+pMGDNnHF9xsxir/K4U=;
        b=Cb46EIpE/tkYJPACGyaHcw2+ptUE7exJNbHGl27WcXfyM1EOc3nGk+CObprwdy27ef
         U+aVJETgJ2CYDsbQ8m6siWEqZVs4s/BB0joVRVjic6sTEoRdIxqgxCXGSajLDpC/Va04
         U/46K57G2DuhVpWHU7fxamK+YHIK8zGlTJJFxCDJGaohPBIXrs2HJgQ6QF1ggb9zg/RR
         QbUXw/KPKcohgvAhol2crhcSwNF9rNlz5u5qw6V6Kw2e21MNpjs/Ftyd/7nwhS32s1cP
         NQhHUkDvzoe7X7oLw5eB7NdmVcIV3z1KScqsgrqNpHUu+j4UCPDnoUNK5Q44ftKyqiaO
         mlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNSMrXgsDIBPEX+PmJvz8brS+pMGDNnHF9xsxir/K4U=;
        b=d6MqZo5eXXJTlnQbIDSolWZpiAn/XjbEsg87WUVh+PbjjImK8ULGUDufQ4EQwHTVWc
         JnHJp9Besy2/MEIH5um0l/dRVjK4S/HFJn7y6lEf0TSlk09AS+AsF4Gy6yySvzGZUoXl
         nhEB7KhmWU2UzhZwnEuWPRo70UKallraf3l8X0vrmRSl7hOKsp2gblYzS9+1S8AeBB/8
         AZgug5nJ2E/DLJ783SE8bc10Yhrjdw1Mtz/VfkadOWVAlCyVZssLhIIg+p00JE9ksoB/
         ORKbas/vTNW4ypJmz4a69EIXJn6Xoh422p2srgE+Fkd6aoGyo9tIbZh2biONCTGUhafj
         n6DQ==
X-Gm-Message-State: ANoB5pmgZn8ZL1xjzXOxy8fTuauit3gBwYd+bTdbRrVPvpoEdHWceJ+j
        itNjPGkXrv/ZGZRZgkdbbips0Q==
X-Google-Smtp-Source: AA0mqf6wA1xMMJ+XGdsKXVP6/5eeQ/x+7jlt4ea0RqVH9dsfvmiqVWh5efps+XVqeEBt3lBauTHsUg==
X-Received: by 2002:a05:6a00:4c0b:b0:562:ebc8:6195 with SMTP id ea11-20020a056a004c0b00b00562ebc86195mr37357270pfb.38.1669730618613;
        Tue, 29 Nov 2022 06:03:38 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.98])
        by smtp.gmail.com with ESMTPSA id k30-20020aa79d1e000000b00574f83c5d51sm6013747pfp.198.2022.11.29.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:03:38 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
Date:   Tue, 29 Nov 2022 19:33:13 +0530
Message-Id: <20221129140313.886192-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129140313.886192-1-apatel@ventanamicro.com>
References: <20221129140313.886192-1-apatel@ventanamicro.com>
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

We should set CLOCK_EVT_FEAT_C3STOP for a clock_event_device only
when riscv,timer-cant-wake-up DT property is present in the RISC-V
timer DT node.

This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
based on RISC-V platform capabilities rather than having it set for
all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 969a552da8d2..0c8bdd168a45 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -28,6 +28,7 @@
 #include <asm/timex.h>
 
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+static bool riscv_timer_cant_wake_cpu;
 
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
@@ -51,7 +52,7 @@ static int riscv_clock_next_event(unsigned long delta,
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 };
@@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
+	if (riscv_timer_cant_wake_cpu)
+		ce->features |= CLOCK_EVT_FEAT_C3STOP;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
 	enable_percpu_irq(riscv_clock_event_irq,
@@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
+	if (child) {
+		riscv_timer_cant_wake_cpu = of_property_read_bool(child,
+						"riscv,timer-cant-wake-cpu");
+		of_node_put(child);
+	}
+
 	domain = NULL;
 	child = of_get_compatible_child(n, "riscv,cpu-intc");
 	if (!child) {
-- 
2.34.1

