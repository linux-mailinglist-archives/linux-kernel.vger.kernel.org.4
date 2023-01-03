Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4265C19D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbjACOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbjACOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:11:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5010B67
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:11:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so31203028pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVqqR8oYcz8ddBS+TT8ZlpXaMsGagFVr9rYdfxP/rIg=;
        b=kW8IcmMw6snEgGMOnD3J92gTuk6kXiuNTjEsajrxn76hj89qmb0gT/j1/qFeeaZcTK
         J7LFnoEKURv0KZL/X29slpZTSrySPN5sRBqG+GbClcwUnXFtzoS6NbTHnUJ8vGga4irf
         9lxRXfjRRUsTze6dbDeO3NxWQPkVIvEoltyCBU1H9fZNrbEqGBmVyV/XBJpp3FSgVUTH
         Yil5BTK+LuQ0bQZ80GE9sQ//XmF1G1yIs+uwTCzAZyhAXRaLkvK+gWt2lO/sVASuB8KD
         qTS7RFi9IQW6i5O1skxC9zShTpxzBKgZj+Y6P81xB5o6I+lZJxTCH2jgccHosXEmTglz
         TJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVqqR8oYcz8ddBS+TT8ZlpXaMsGagFVr9rYdfxP/rIg=;
        b=WLwO1GJRkrjKifikYdcIQayUSOEpwTvXqVAasGiMAK0rn8jf0vhkL6/XPvLrFIyUq7
         +vX81tqiR52P8Eq2pCxlCk0haEkkUQdrrTpaE+JpD6J+P6ri0koajTJf3FYZZJyg1NRu
         wEMVcNnAfW+h/eH3EowCBNlhR2mC5U/l4bm/sAKCmnrUMprJ65Wl8LSRgqC0iHw0EJ9w
         2Bd4DFp/NehA/hG7odMuhj0IcDDnMRa564NGtNe8hqIiG4AOKwSQ+YKy4hQL6HrM5T3L
         0z6h2XnmX7+YfqpHUokL2kixb/ft6ZGNOLX1c3s0Ut3Md+NjmlxGIAgY+Ky0dSVltKXp
         D1BA==
X-Gm-Message-State: AFqh2kqJr7RS3dEpxPdfyGkYwwZV1x3elQ47F2NiTdIAjq2iSQ6xeGjq
        XTZUyJjo+2TDOQMVvCMMw0MOI/YcNB92298K
X-Google-Smtp-Source: AMrXdXvHiZ2mubjd6ktVYDES2Wzs1jni6FSXsvkL3Z/HXI4YqE6gXpPnnbII14HUfEZDsTFUbo5JNw==
X-Received: by 2002:a17:902:7610:b0:192:751d:b2e4 with SMTP id k16-20020a170902761000b00192751db2e4mr28680533pll.48.1672755088680;
        Tue, 03 Jan 2023 06:11:28 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.241])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00192bf7eaf28sm6146117plc.286.2023.01.03.06.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:11:28 -0800 (PST)
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
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v6 3/3] clocksource: timer-riscv: Set CLOCK_EVT_FEAT_C3STOP based on DT
Date:   Tue,  3 Jan 2023 19:41:02 +0530
Message-Id: <20230103141102.772228-4-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103141102.772228-1-apatel@ventanamicro.com>
References: <20230103141102.772228-1-apatel@ventanamicro.com>
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
when riscv,timer-cannot-wake-cpu DT property is present in the RISC-V
timer DT node.

This way CLOCK_EVT_FEAT_C3STOP feature is set for clock_event_device
based on RISC-V platform capabilities rather than having it set for
all RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 drivers/clocksource/timer-riscv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a0d66fabf073..1b4b36df5484 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -28,6 +28,7 @@
 #include <asm/timex.h>
 
 static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
+static bool riscv_timer_cannot_wake_cpu;
 
 static int riscv_clock_next_event(unsigned long delta,
 		struct clock_event_device *ce)
@@ -85,6 +86,8 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
+	if (riscv_timer_cannot_wake_cpu)
+		ce->features |= CLOCK_EVT_FEAT_C3STOP;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
 	enable_percpu_irq(riscv_clock_event_irq,
@@ -139,6 +142,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
+	if (child) {
+		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
+					"riscv,timer-cannot-wake-cpu");
+		of_node_put(child);
+	}
+
 	domain = NULL;
 	child = of_get_compatible_child(n, "riscv,cpu-intc");
 	if (!child) {
-- 
2.34.1

