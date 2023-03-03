Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638FA6A98A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCCNij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCCNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:38:07 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C9062D9A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:37:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ky4so2691680plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opcZr20KXnvjkMyYCnmLSprA9lMTCGLgPDByb/r4X5s=;
        b=mtzaNcwoSWZ2THe7xcnYYt5QhCkxYSo4IxDPTx+lG0bTgHRFtucUZNL51ojDh9AWu9
         vEcId8l/V/zh4jvkNUvpbgqoOjOsPbfdKImES2Go/YeBLVrpG5oYeQ/lQCZkEF2uXK2c
         MjqPdiE0kPZTnU9tUxmo4telqISKQlR7XnnEeKiGwRqOWBMJg6uiaHJ/ENIpzDtIS6PO
         t6QqvyuBVKc86/DZJyUpqaVcojXTvgFIOToasxlqS3jo1j+tLlof5fBo2mr1FZh50u+x
         pX8+7mWVclwO/7i8jtSR3mRPGEuSIiwdFsFkKRiLwYpPYEp02IU2KZTwyzo4I+xf6hsr
         UKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opcZr20KXnvjkMyYCnmLSprA9lMTCGLgPDByb/r4X5s=;
        b=UvBWk3qmhvJ042ol4fFD2yZ5GWp2mRDQbGVhUkiYcRpwaZg5nDe55DYMAmDuFA7hHo
         udoz8pQ3LzP8yK1jLGNIFEvqwdCM0EjqekrdJdaHeZ22MXF+ZBADypLYOWBzWVLlVt+K
         ccfi25gbJFZglEiMrCVMw8zrSFjIFjv2Ls+hiLIaiZakjLsNWmhRDHmiCLMDqPJBapx1
         ACXINdfimt1FhR8DWKs3Mf8lCLXV43vpMDu5g/EL5XMe+k/zzLIruHUH7Mot8sDHeIdO
         LUKZhcraK8HJYh834p/2PqpWZJZvDMc07WnZJlLj+5Q+Hg4mSBG05mnwmvgWCFTqk7Tb
         2Lag==
X-Gm-Message-State: AO0yUKUBWnLMmfN8J1Wru2U5sxkYhGYAtdHXGil6DyNslfZ8mdnFvb0o
        33lVPj5ciRugFRlAB7x/i7H6Bw==
X-Google-Smtp-Source: AK7set+1HrloMyO8BRm2y/LxLgXwnKeSr9YjJYgH6JZlVLfiI+fDzQ/yDPXEdZKuYrmB6Wl8jmxtjw==
X-Received: by 2002:a17:903:492:b0:19e:700c:b6e0 with SMTP id jj18-20020a170903049200b0019e700cb6e0mr1771788plb.35.1677850654089;
        Fri, 03 Mar 2023 05:37:34 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:37:33 -0800 (PST)
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
Subject: [PATCH V3 08/20] drivers/acpi: RISC-V: Add RHCT related code
Date:   Fri,  3 Mar 2023 19:06:35 +0530
Message-Id: <20230303133647.845095-9-sunilvl@ventanamicro.com>
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

RHCT is a new table defined for RISC-V to communicate the
features of the CPU to the OS. Create a new architecture folder
in drivers/acpi and add RHCT parsing code.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  9 ++++
 drivers/acpi/Makefile         |  2 +
 drivers/acpi/riscv/Makefile   |  2 +
 drivers/acpi/riscv/rhct.c     | 82 +++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 7671c401f4ec..111a8ed10af1 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -59,6 +59,15 @@ static inline bool acpi_has_cpu_in_madt(void)
 
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
index 000000000000..2e2aeb7cae49
--- /dev/null
+++ b/drivers/acpi/riscv/rhct.c
@@ -0,0 +1,82 @@
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
+		if (ACPI_FAILURE(status)) {
+			pr_warn_once("No RHCT table found\n");
+			return NULL;
+		}
+	}
+
+	return rhct;
+}
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, NULL may be passed in order to use the cached table.
+ */
+int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int acpi_cpu_id, const char **isa)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_isa_string *isa_node;
+	struct acpi_table_rhct *rhct;
+	u32 *hart_info_node_offset;
+
+	BUG_ON(acpi_disabled);
+
+	if (!table) {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return -ENOENT;
+	} else {
+		rhct = (struct acpi_table_rhct *)table;
+	}
+
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (acpi_cpu_id != hart_info->uid)
+				continue;
+
+			for (int i = 0; i < hart_info->num_offsets; i++) {
+				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+							rhct, hart_info_node_offset[i]);
+				if (ref_node->type == ACPI_RHCT_NODE_TYPE_ISA_STRING) {
+					isa_node = ACPI_ADD_PTR(struct acpi_rhct_isa_string,
+								ref_node, size_hdr);
+					*isa = isa_node->isa;
+					return 0;
+				}
+			}
+		}
+	}
+
+	return -1;
+}
-- 
2.34.1

