Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691556A98A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjCCNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjCCNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:06 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1206262DB5
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:37:39 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so2289618pjz.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pi8xH0IxXrFGj4CxsC9boyEOiTx1Qa4CmKA7c/Mr88=;
        b=ospJEN1H+o62BETHuMHU/j9Q2xjVV+b+WkaZuGnP3T/+3pPt9ngIgnJeGsoBFW/TO0
         6hwXGOXmHiK6F4logs+p2Up85lMfjy7zUU7DDihJAoUad7IQ8acc6QgTZ/12/ZcvcMAx
         f2SRlvk4EDhFMhYjuxKm8I5zvoZOZVqOYZbmqZPXznA6rWLgNPg6XvSxRXLjp0yK4014
         4sgcyZrl7Os6aroKX6L/49uK+6PgZ6tA98MFBqPc9KNHk9nagm3iUiBc0pepZ+qfWSIl
         AMFj2DMCJZ82vffzVKpYynki1Q6XU9ob/ThV79YCGGgi8PFMsbu/YYP0ahJM7K1X6wjJ
         jDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pi8xH0IxXrFGj4CxsC9boyEOiTx1Qa4CmKA7c/Mr88=;
        b=jCfhTUsMoePYe6uFFsy6dWYglz+XBjb9h0bkYdNxFRscVaeScWNB7YjIJmL2ITvWy6
         DUtRnzyoJVF1tFIr6T335oOzGyJkAQcpCprbq+jORcWmItTDK+EOf93dW5hHE2WNfaqb
         giWriv63UvqxH2WQt8TjsZGGBmdGlg0jdRfusPr5jftwDwqiWXU8J8mzZFjDOD2T6biB
         Nnywx9AA0YWPvEL5eN8EWNobNYaC7s0ckIknIJfCM29pCHTjietmyT0XYpAUKNt70FPA
         QvLpe0qqFDJa+6aDRY1Ish/qdksw+zvNGL9IOLhRF0WbdDLa6LMRfduVSo8Bt1tveUxO
         r2JA==
X-Gm-Message-State: AO0yUKWqyH+WKJEFGH4rN+i+RPjdPp5pCm0A751JIJQKGb2cXugACDK6
        WOYSX0VoktJxOHK9O+MHQIuD/w==
X-Google-Smtp-Source: AK7set/n1ssQQjUjID0NxGei92GK70/GndvtpN5XR0Ch5wvj7TQe8/xVBnKzQ9qiTHpWUDkc1vrL3A==
X-Received: by 2002:a17:902:a9c6:b0:19e:7c33:3722 with SMTP id b6-20020a170902a9c600b0019e7c333722mr1673766plr.40.1677850658806;
        Fri, 03 Mar 2023 05:37:38 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:38 -0800 (PST)
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
Subject: [PATCH V3 09/20] RISC-V: smpboot: Create wrapper smp_setup()
Date:   Fri,  3 Mar 2023 19:06:36 +0530
Message-Id: <20230303133647.845095-10-sunilvl@ventanamicro.com>
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

smp_setup() currently assumes DT-based platforms. To enable ACPI,
first make this a wrapper function and move existing code to
a separate DT-specific function.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 00b53913d4c6..26214ddefaa4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void __init setup_smp(void)
+static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
 	unsigned long hart;
@@ -116,6 +116,11 @@ void __init setup_smp(void)
 	}
 }
 
+void __init setup_smp(void)
+{
+	of_parse_and_init_cpus();
+}
+
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
 	if (cpu_ops[cpu]->cpu_start)
-- 
2.34.1

