Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D62B699C21
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBPSWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 13:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBPSWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 13:22:09 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52746144
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o8so2906777pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbqUdM0Np7Pk7D6Eh4B7c+w7Zw8p8e1vDp1GKV/olkQ=;
        b=Cxq4zjw6jiDo0nQwfwBieSzkX5YKjnoBEYHQiqtfjZyMdT4h+ntnTqUCdo5Wqdqta0
         ioZNZDx7RU8k2x6nUSYhWooOIkqR54fOtPJeGxRsVBAa2ZZhRP7TZhrr9owiZz2GGBHB
         WAJQzXBVDEFvJeqrn3TzwwT/s+EK3ralTgIMJ0mUMgjQLJLLfRkOGru9dJWPcJltXLjk
         LEOXzMqeDhuBiJAagG3w6+jB/nEB0QtgvXnzpPFKnRGFFfuF3aUeByZJIwKRfL+S7u02
         /+D1ANFIH2qVAGIRGe1SiPpvpVsX95nacHF8qpOzjqVvk+TuwDzE2mPhUyhw7eSnGm6q
         UGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbqUdM0Np7Pk7D6Eh4B7c+w7Zw8p8e1vDp1GKV/olkQ=;
        b=zvKZdfJYkGfZK+AlHCd7lVwQuxPouaeUSghd2c1huuJ0RPGI8Z9zAcwmrPmJR/dU5i
         6eWNaSEcwbdnLELejV+U9wGbyATj0ojnmASfc7sjKJSkt+lvogJs2kr90CRIjdPUSUvA
         FGPqzqCxh7tVXJyCxxkoxuRZtjwkC4No5Wl+oHTeIKeze11RvLglMYec9rEioYv44KxZ
         AoC2nsJD3+aELbohuGRjHoY0nUcWmpxNqUertYNva5i5tXQZI3UVxanWuOcccSdcj0qi
         mhUBwzAnVuhWiXB6omh7ZarDWypv8JJ0Vd6QJhgdkRsbPBHsx2pklB1YHYW62Hx1RRrz
         CW1A==
X-Gm-Message-State: AO0yUKUy62m50UYH/RRG9CYgptFVat+Ydu/W9kLldNqQGWkXiKULPXZJ
        s+6sXOuY5OWmVyYiq2S29Qg27A==
X-Google-Smtp-Source: AK7set92zVfUHWrg1/Q0sW3fQ8AVEVUXiUYMgvdI1LbFQ5T6RfJCH71VvejNUnOObpioR2uotsiGjw==
X-Received: by 2002:a05:6a20:4287:b0:c6:d742:681d with SMTP id o7-20020a056a20428700b000c6d742681dmr3527284pzj.12.1676571691092;
        Thu, 16 Feb 2023 10:21:31 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:30 -0800 (PST)
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
Subject: [PATCH V2 08/21] drivers/acpi: RISC-V: Add RHCT related code
Date:   Thu, 16 Feb 2023 23:50:30 +0530
Message-Id: <20230216182043.1946553-9-sunilvl@ventanamicro.com>
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

RHCT is a new table defined for RISC-V to communicate the
features of the CPU to the OS. Create a new architecture folder
in drivers/acpi and add RHCT parsing code.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/riscv/include/asm/acpi.h |  9 ++++
 drivers/acpi/Makefile         |  2 +
 drivers/acpi/riscv/Makefile   |  2 +
 drivers/acpi/riscv/rhct.c     | 92 +++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 4a3622b38159..7bc49f65c86b 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -58,6 +58,15 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
+int acpi_get_riscv_isa(struct acpi_table_header *table,
+		       unsigned int cpu, const char **isa);
+#else
+static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
+				     unsigned int cpu, const char **isa)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index feb36c0b9446..3fc5a0d54f6e 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -131,3 +131,5 @@ obj-y				+= dptf/
 obj-$(CONFIG_ARM64)		+= arm64/
 
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
+
+obj-$(CONFIG_RISCV)		+= riscv/
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
new file mode 100644
index 000000000000..8b3b126e0b94
--- /dev/null
+++ b/drivers/acpi/riscv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y 	+= rhct.o
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
new file mode 100644
index 000000000000..5bafc236d627
--- /dev/null
+++ b/drivers/acpi/riscv/rhct.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2023, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI: RHCT: " fmt
+
+#include <linux/acpi.h>
+
+static void acpi_rhct_warn_missing(void)
+{
+	pr_warn_once("No RHCT table found\n");
+}
+
+static struct acpi_table_header *acpi_get_rhct(void)
+{
+	static struct acpi_table_header *rhct;
+	acpi_status status;
+
+	/*
+	 * RHCT will be used at runtime on every CPU, so we
+	 * don't need to call acpi_put_table() to release the table mapping.
+	 */
+	if (!rhct) {
+		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
+		if (ACPI_FAILURE(status))
+			acpi_rhct_warn_missing();
+	}
+
+	return rhct;
+}
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory
+ */
+int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int acpi_cpu_id, const char **isa)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	struct acpi_table_rhct *rhct;
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_isa_string *isa_node;
+	u32 *hart_info_node_offset;
+	int i, j;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+
+	if (acpi_disabled) {
+		pr_debug("%s: acpi is disabled\n", __func__);
+		return -1;
+	}
+
+	if (!table) {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return -ENOENT;
+	} else {
+		rhct = (struct acpi_table_rhct *)table;
+	}
+
+	node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+
+	for (i = 0; i < rhct->node_count; i++) {
+		if (node >= end)
+			break;
+		switch (node->type) {
+		case ACPI_RHCT_NODE_TYPE_HART_INFO:
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (acpi_cpu_id != hart_info->uid)
+				break;
+			for (j = 0; j < hart_info->num_offsets; j++) {
+				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+							rhct, hart_info_node_offset[j]);
+				if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+					isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
+								ref_node, size_hdr);
+					*isa = isa_node->isa;
+					return 0;
+				}
+			}
+			break;
+		}
+		node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length);
+	}
+
+	return -1;
+}
-- 
2.34.1

