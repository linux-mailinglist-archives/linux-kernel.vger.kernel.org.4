Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F86A98C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCCNjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCCNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:50 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149B5B5CC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:38:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso6125936pjr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMb23HWhySGYdHuXuceG1Hdu0cCgMlhnof5Rv5oG2UE=;
        b=YaLquxhCPRvn9XYOirByRSWmifW1Bn1w1P/4+23IN1f/6lO49egVrOidPasa7r+JPF
         WDNTXFtu6MYTmoqMyF7YnSg7ucqRtv3EKeD+Ugsew+MmlsK/sVg7aPZEfcC7fLlBZCH9
         5k9eNzA9Ou6s9mb3gODhGum/QIUctlbY3rJtJz2yfiJCN6aVLuoU+SrNdOuWZ57pJx/2
         OJ3JIi1t9OhDZg8c4RghkZVsvZ3MfSGFEFKnU7m1zh7fjPkHn5OZ736VSBWTSyb3qYL5
         443k5gbPfEP521j4jODRVWWcX2m68/1WuaK3r2I2hWcdxtB0Sb6rYRhztyht9vmkA2sA
         xz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMb23HWhySGYdHuXuceG1Hdu0cCgMlhnof5Rv5oG2UE=;
        b=dr9gKN0vXwFidQOY4SK2u3jDYO/FuCVetvxsz5blu44GGXbV8CRQ1hBcj5TGjTG+tw
         P5B2Vh1D5NwQIEdzs6Gn/wq0/ga+AN0LFI9Dxu34NWcn0Oc+aGLniDwiPSVxlciJ7A40
         WZNjFu1kyGgdBvzdF/IBDlmJGUKm+V456504yUegP6hY78g+NAz7/Pk0Gq+rkZO6EVcP
         GWUaKsA/DpF/gpFEK1OtEdp5+18AREIJ/+z+xzPz/hK897phtqUua/btcaEe0P4VYZML
         JVLeMmDBzVqWsrNACxz0rxHz0hNB+g2rREQJ9TrAaLG4wUiYSKutQS6X/z2HjGxVUczS
         3GFw==
X-Gm-Message-State: AO0yUKV8rtZ3YnDkv9FsfQrUcrA7iakJM7HggXf+q0rgnI4bOGpnRd8K
        wyb+XykR7TlKJg5yxhOyPWOiKA==
X-Google-Smtp-Source: AK7set+tm8aOgYZk9xBaZnStYA78ITXnao6Ey/Ao6F5/PsR7mqEz365HsV945p8qDb1vjZKOvue9gw==
X-Received: by 2002:a17:902:ec8d:b0:19a:a9dd:ed3f with SMTP id x13-20020a170902ec8d00b0019aa9dded3fmr2238776plg.49.1677850692265;
        Fri, 03 Mar 2023 05:38:12 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:38:12 -0800 (PST)
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
Subject: [PATCH V3 16/20] clocksource/timer-riscv: Add ACPI support
Date:   Fri,  3 Mar 2023 19:06:43 +0530
Message-Id: <20230303133647.845095-17-sunilvl@ventanamicro.com>
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

Initialize the timer driver based on RHCT table on ACPI based
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index cecc4662293b..da3071b387eb 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "riscv-timer: " fmt
 
+#include <linux/acpi.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -207,3 +208,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 }
 
 TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
+
+#ifdef CONFIG_ACPI
+static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
+{
+	return riscv_timer_init_common();
+}
+
+TIMER_ACPI_DECLARE(aclint_mtimer, ACPI_SIG_RHCT, riscv_timer_acpi_init);
+
+#endif
-- 
2.34.1

