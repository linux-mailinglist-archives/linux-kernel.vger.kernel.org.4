Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3B699C30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBPSXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjBPSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:31 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE415035B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id bx22so2712865pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/B7oU0oZMzvSlnZ6Slk2M4LeGqm6SOf/DwHx2JHpN8=;
        b=JhzKrMk2y0c0UJJY9R3LAeDqup2Vy26n7fKJF2EJ8p9IKFWGnI1YedBoBhqO8F3LkM
         tVZ+fGNaffll2OfDmYRq+19mu8tuigJ54kj92JxCQHc1ux9gKkHGlD6/60HYZK/ZNGTo
         M3kerTUxSK6phuUl/DKNjGQyHWtPG5QMv4mHhe3+juD7WJQynDSgsNO+hKRxoKLPXcyg
         fk5/451Gdasyf10nauCTje7081IndfdWP2CXIZbgriIouer1UlPFOB6pBqXuYsTQcSO9
         xbPXfLEPHK2SFHFpnQZA7O6nt+QPejZjwMal7uNgk+Hakcw4VJJ7MArqKBxLJzJHHUF0
         L2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/B7oU0oZMzvSlnZ6Slk2M4LeGqm6SOf/DwHx2JHpN8=;
        b=bk679GfmW5My1KhqVzOLsPM5VAeBzIKbdWCj+5sjUX9Jgk3xVcj3v1i32dVGobhh1H
         BVUJgETque/FUBoEUwzRMh+/yP07JnMj+wQRL9Z/K3+smkxs3+LvZfSeBE+wrylEWOZr
         /ibaOqrYf98nlyBzrOH0MhsgdZbeOOuFddpYBn6+lfzqidEXDT6wszPtWmU8PvXmHVW5
         xJxogTgRNQlnsCxr9JJAMbj/Uh/VgUqfvr6WcxEFH5TKhnI72nqNr0gQi4viYlCI9P9Y
         evEugvdvfHpCmsBer/JlLV8WZ1P1JWVSADylPZCdsqXHZ/eFElO89IIhkwXcCI2Sb6iv
         ZNLw==
X-Gm-Message-State: AO0yUKX1dpjmkZOSa7RN3WpiGC8r2qaGrl5DmK0x8l/LeE0GX2E30nDi
        ODNmp3NRkYVnjH5f+vfLoX9dNQ==
X-Google-Smtp-Source: AK7set+UGGwky0KcCyPjol1FGoQkgy43ytFVLWD+NpcOvsVqZI0SmSkUdXxAOwokXN5tYcdCUF81Bw==
X-Received: by 2002:a05:6a20:8e16:b0:c6:dfe3:8663 with SMTP id y22-20020a056a208e1600b000c6dfe38663mr6729908pzj.9.1676571715195;
        Thu, 16 Feb 2023 10:21:55 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:54 -0800 (PST)
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
Subject: [PATCH V2 13/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
Date:   Thu, 16 Feb 2023 23:50:35 +0530
Message-Id: <20230216182043.1946553-14-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ACPI based platforms, few details like ISA need to be read
from the ACPI table. Enable cpuinfo on ACPI based systems.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/kernel/cpu.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..a227c0661b19 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -3,10 +3,12 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
 #include <asm/sbi.h>
@@ -256,26 +258,41 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
+static void acpi_print_hart_info(struct seq_file *m, unsigned long cpu)
+{
+	const char *isa;
+
+	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
+		print_isa(m, isa);
+}
+
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
 	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+	struct device_node *node;
 	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
-	if (!of_property_read_string(node, "riscv,isa", &isa))
-		print_isa(m, isa);
+
+	if (acpi_disabled) {
+		node = of_get_cpu_node(cpu_id, NULL);
+		if (!of_property_read_string(node, "riscv,isa", &isa))
+			print_isa(m, isa);
+		if (!of_property_read_string(node, "compatible", &compat) &&
+		    strcmp(compat, "riscv"))
+			seq_printf(m, "uarch\t\t: %s\n", compat);
+		of_node_put(node);
+	} else {
+		acpi_print_hart_info(m, cpu_id);
+	}
+
 	print_mmu(m);
-	if (!of_property_read_string(node, "compatible", &compat)
-	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t\t: %s\n", compat);
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 	seq_puts(m, "\n");
-	of_node_put(node);
 
 	return 0;
 }
-- 
2.34.1

