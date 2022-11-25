Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B586388A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKYLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKYLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:21:45 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B86286D1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q71so3704669pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1ogE3iUjoMSXzLx1NgTul4M3E0f5R6SeuN3d1g+xHg=;
        b=dnGJBUNJQl0wlLkoDF9rV+Fk3ir0Zo+py6y4hjjjRZOAZtMja3aUacpgOypb2+kVaV
         vWx9m4ZldeFz7buRLSRXiO6zWXZHVO7qb/W3+16VJYNsrHugMitE3+gm2kfEYXOgPHbU
         ha8hl0o+yScSTJMIzLFEiSyQxYkm3nGkb0XxrAFOMnKQCoiliUYCmd55WEB1JOQncxyD
         zbKbRaXkmOgPTlan7WsKeVocPRH3frnEaCQour6xMZkDnmUo2qtI/c540HD6YkmKIrcI
         5TsL8g+hAUgRELJp7kqSgLCFEobVRwZEM4QCbadzTFtfcA775XB3Ov3JZlFI9W2NtpXi
         6Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1ogE3iUjoMSXzLx1NgTul4M3E0f5R6SeuN3d1g+xHg=;
        b=mcrYDA4XRdFrzJ4jLcw8JhW5WoQkQ6S/jT/PBKwR8LX3ERF8TxqUp2841aSXY4awQz
         HLwTRLW/ycigHd6umTl8Z5euH0tArbhweCO6Yq6/9sEB2IatEBhF9LjecBLXqAzE1jrA
         7WGJ4D84gSljsZ/RPuh7GvP0sICmPWuKeF/AYVitsmQ9A4N922qEKYgt4rQE2nM1V7Wl
         3xu8wub3IQiaqjFVQ4tDmq3lLYDT7bb/Ntck5++mBqzwHhauOlvQnwD1MNV9CZWTeErp
         SFAdNRkMINs611eLGgyKwwK4ZZn1ZQhfjq6vQ//qL+dconIwchQmEDNoZl2AxF+D9FKc
         MyFQ==
X-Gm-Message-State: ANoB5pnD8FkgLtS9iab/Xhqe5SSYPzLVvSsSs7UFxT+18KqAVavYVcc7
        /uSO0eOstWgdqas+Xaey5BoAqw==
X-Google-Smtp-Source: AA0mqf50JFV3DpRNLPvltimF6u0clZODoD326IHS8ZXlmnfKizp7cVe3f93LKwRBF7JH++67Ge7yEQ==
X-Received: by 2002:a63:dc45:0:b0:44e:46f9:7eeb with SMTP id f5-20020a63dc45000000b0044e46f97eebmr16133001pgj.3.1669375304115;
        Fri, 25 Nov 2022 03:21:44 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id e66-20020a621e45000000b0057488230704sm2834335pfe.219.2022.11.25.03.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:21:43 -0800 (PST)
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
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
Date:   Fri, 25 Nov 2022 16:51:05 +0530
Message-Id: <20221125112105.427045-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125112105.427045-1-apatel@ventanamicro.com>
References: <20221125112105.427045-1-apatel@ventanamicro.com>
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
 drivers/clocksource/timer-riscv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a0d66fabf073..0c8bdd168a45 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -28,6 +28,7 @@
 #include <asm/timex.h>
 
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+static bool riscv_timer_cant_wake_cpu;
 
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
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

