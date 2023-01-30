Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181CD6818F0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbjA3SZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbjA3SZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:25:10 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8246D45
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p24so12520572plw.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjibFpTqTShjczIJbVTkz5RGTuyNmy3y1G35vLo3EEc=;
        b=JIG4KdNIJo8a8e5DcMOlWOMk+SMYfFyg3Sc1+T9cyo/r6KA/knBlxhzkv6TiGdCEFh
         QjO2PFJXsESo+8PMKJwelpLyT4Vo86Khy7c6Z7o6X6a33TuC+f+kT9LsGwllBf2XqEK5
         IEDoGCJNFCrY9/SkFjrWHgpKsYV1CNUXGhJ9Yn8evGLV6bv8sgnDZ0PIaPdedoyRjbLR
         ap7ZG6XW24t+kvvZedK4Buw158HCC84yxTP3DRLno7tqS/f+CTP6IZBNL1IIp28NwGhD
         sUunUcy8sZSCp8pqwKkOULMjeoXPWWA/ga6VwWeMZvqz37Xp18dsvJX+07/zKlwpRN5R
         uRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjibFpTqTShjczIJbVTkz5RGTuyNmy3y1G35vLo3EEc=;
        b=b7WEYfnYDeudT0DFTWM0Xu88K62V6ZUtyQw57NuOgpTdjttEd72VdkgNJQgLcjJzTB
         5JPy9bPaQvFrPD5dhOF/2YO2JlQlE8CV+YAneJkg6EDXvEtD6MYFkykZ2kFmBSZbUkZT
         IaI2x+kfjfb/UuPFAoxGjWNSXrWQYUQUBOZzqB4zFMtLP3B4RNqqGoIPj7rHrHxHqtvN
         b6Ft/v338P3IEmog1YCkIY1/oKQCQA/fCjmGWrdO/nqtCAE1/G2YzY6QYv9gS4ViRcER
         gGstBrCV5S5886lYHI/dhTt9Bl10JIciyMKEssd38Mh88nz+/4J3jY/g5LupvElcNPeY
         Rb6A==
X-Gm-Message-State: AFqh2kqsk5CLfd7oguPt0KH1u7dH8fjk/fq42KKudoohUuFtvxJyS6vA
        09/WQAhxP6Td/2IvsYKEM/KWtg==
X-Google-Smtp-Source: AMrXdXtiX8G638QNxJdbmXV10F7Qf0CdgmUoIWBv0Ar85IkvXkqVVNNpBrhVhN1ABIlikG/btEedJg==
X-Received: by 2002:a05:6a20:c706:b0:b6:c018:7fd8 with SMTP id hi6-20020a056a20c70600b000b6c0187fd8mr52692395pzb.11.1675103036632;
        Mon, 30 Jan 2023 10:23:56 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:56 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 18/24] RISC-V: ACPI: time.c: Add ACPI support for time_init()
Date:   Mon, 30 Jan 2023 23:52:19 +0530
Message-Id: <20230130182225.2471414-19-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
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

On ACPI based platforms, timer related information is
available in RHCT. Add ACPI based probe support to the
timer initialization.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/time.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1cf21db4fcc7..e49b897fc657 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#include <linux/acpi.h>
 #include <linux/of_clk.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
@@ -18,17 +19,29 @@ EXPORT_SYMBOL_GPL(riscv_timebase);
 void __init time_init(void)
 {
 	struct device_node *cpu;
+	struct acpi_table_rhct *rhct;
+	acpi_status status;
 	u32 prop;
 
-	cpu = of_find_node_by_path("/cpus");
-	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
-		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
-	of_node_put(cpu);
-	riscv_timebase = prop;
+	if (acpi_disabled) {
+		cpu = of_find_node_by_path("/cpus");
+		if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
+			panic("RISC-V system with no 'timebase-frequency' in DTS\n");
+		of_node_put(cpu);
+		riscv_timebase = prop;
+	} else {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, (struct acpi_table_header **)&rhct);
+		if (ACPI_FAILURE(status))
+			panic("RISC-V ACPI system with no RHCT table\n");
+		riscv_timebase = rhct->time_base_freq;
+		acpi_put_table((struct acpi_table_header *)rhct);
+	}
 
 	lpj_fine = riscv_timebase / HZ;
 
-	of_clk_init(NULL);
+	if (acpi_disabled)
+		of_clk_init(NULL);
+
 	timer_probe();
 
 	tick_setup_hrtimer_broadcast();
-- 
2.38.0

