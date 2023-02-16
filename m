Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D491B699C38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjBPSX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjBPSWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:40 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A55037C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:14 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id pg6-20020a17090b1e0600b002349579949aso2563058pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv/SJn971dfjdTrZfssRImVac3G99NBb7ONmt1Vsq2I=;
        b=myJLNPbRJLi/wYDYC+up98t51CDSvleQNl+jgG0GytS3WhARAlv6QffJ1MZuDRuhyU
         8nx+Iqk3/0KdzmA3KZj7nwInkmfGs4j8tDN+L8Vu+X478ausemy9Wu5+S7F96/g0/aP4
         6SJcqu0eqxByONPkPg6XnsFYBAkhdoWdSfHoNJetFsAg24XKyXXc6ALuunxuhMjGApeS
         3RJQ1bIyZZJRcBM/v640JXSPpA8mjzq5s2a72ChX7W0uTYD2fOAIchRGYp/4yOEjIl5D
         tDnC5SXkZ9P0rYtWqNgSCJ5fpvmDvMwd9aOziTUVR0hXElPSBVuov+zz6/eecwNO7wHJ
         xDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv/SJn971dfjdTrZfssRImVac3G99NBb7ONmt1Vsq2I=;
        b=AKlht4ssptjB88chfBl/l5Ab3B7q/QYGN8yoAQAVnPEGLA/ADZVNi02zalRIPZzdHV
         B+aAEz9YxzxRXtJUMGn8oc7NbVYbket/bYSvR/iZ4YQ2oO/d/hr/sjINpj+sQ+fW9adn
         QPupPDcHenY5El+lUnhL9vOVliyQh24Pkq0qciMzpPmb1bE8qnVh96R9MEyek1sWD3aR
         2Ed2FI3tUI/fyIjInXK+fH4ByCed4ycwOs2JlWJgcIxjypwnwjo8aQlQ7ldN8V+jGGz8
         Xi37taWVL1txeLKsGZhsrXxccq59Gpan2wbdZzOTNrlE+zjxx5oXCm10V/1OXw30m0+v
         yPng==
X-Gm-Message-State: AO0yUKWk85TMG6OnqdtGe/qoECCK7FXhhH4iZAV/uITYwCGGIuXH833c
        ANxKLlEheAj5Cr06ny4cg6Tlug==
X-Google-Smtp-Source: AK7set+NBRmM54Hgp3O9CpS/Jfakh9iB+b7vBRwhQtSjUmCXjPcQd5RBQeVnlUJ0IOn5iswQgx12sA==
X-Received: by 2002:a05:6a21:338c:b0:bc:b1ec:89f3 with SMTP id yy12-20020a056a21338c00b000bcb1ec89f3mr7638758pzb.50.1676571729309;
        Thu, 16 Feb 2023 10:22:09 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:22:08 -0800 (PST)
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
Subject: [PATCH V2 16/21] clocksource/timer-riscv: Add ACPI support
Date:   Thu, 16 Feb 2023 23:50:38 +0530
Message-Id: <20230216182043.1946553-17-sunilvl@ventanamicro.com>
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

Initialize the timer driver based on RHCT table on ACPI based
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/clocksource/timer-riscv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 2ae8e300d303..5fb0eac52bdd 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "riscv-timer: " fmt
 
+#include <linux/acpi.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -201,3 +202,13 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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

