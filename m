Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038FE6D6BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjDDSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbjDDSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:22:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF74C17
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 11:21:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id cm5so16217241pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RenGaqLG2E6+auHKmyF3E2Rjbj5BNhOsGGRACP9B8RM=;
        b=TuA3n41rWKIn+1w0F07Xg/33CGu819heRvJl0tJHNjZBNPvekJAYrjvZmlARrstVNS
         9JiAecUe0diJ7nehf0NDIl0xCr8gxtk0bRHYbTXJ9E079tIxWGcaIICIDEuMftov4wc0
         NYCPeaipVjFiGbgXQpftzSHOO8V1unZABt7Tmz2X0AV4jnjXoBJz0GPBn+SfrQWmpupa
         wo4wLY5P4R9OUhWbBQ0jWJtmFC8HkWlU+b8UKVvhfeEFAHZRYoThs4z9oTh+sSi1KMZw
         gCijmsosS1DO93uDQdPk1SqrnBAa5CtHcA6FQyMYFSoFLnEDQixAHvRyRb9iIx7qTvUe
         Drng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RenGaqLG2E6+auHKmyF3E2Rjbj5BNhOsGGRACP9B8RM=;
        b=T/kbJuRKs01QZb5yWBUIvCtwIPS5r9TtGX2QmMwDF0bFiEXOFY5PcuusfkG4OOOl7f
         uyDik9Lz61ECq6bS2H6dqYbpZoR77TSfDF7/Khc8Svps2k5tirueSRZQMFqLiULn89sw
         CUCcvz7uj38P3dYdASx6uEppL12a7yfMlUNZwN2IzAlHCFuo2Tij7Q1ErJpKDqpi0CYM
         NvNQ26bWRBNIJn/jvKMQi5KILWacS/r/TvljLyh8WTbD4S1OOUxmszNTLesKp4TZlq6L
         AY7uzdgNByE0QY3JoHok6xCeQUkoTl1k+8P8GIhTIjy7QQL19rV8Wxtztdopr/QJhdzJ
         P2HQ==
X-Gm-Message-State: AAQBX9eyti/H8nBBvgGBjWuqR3ZH8Z7R4gqzGub3HayDVokrKrz82W4+
        uWb/1wkhS0Wiu2JWKZpB7IZZEQ==
X-Google-Smtp-Source: AKy350YVkjcmOvkdjrEBigr7bqKPZTIUrjorvgx+5YWJ46o5RnMoxyjt69Ybu6TkskScsRRg1xKfPg==
X-Received: by 2002:a62:cfc1:0:b0:625:ebc3:b26c with SMTP id b184-20020a62cfc1000000b00625ebc3b26cmr3089010pfg.22.1680632510428;
        Tue, 04 Apr 2023 11:21:50 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:21:49 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 09/23] drivers/acpi: RISC-V: Add RHCT related code
Date:   Tue,  4 Apr 2023 23:50:23 +0530
Message-Id: <20230404182037.863533-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/acpi/riscv/rhct.c     | 83 +++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 1606dce8992e..2b3e78d5a13b 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -61,6 +61,15 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 
 struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
 u32 get_acpi_id_for_cpu(int cpu);
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
index 000000000000..ea78d906a0fe
--- /dev/null
+++ b/drivers/acpi/riscv/rhct.c
@@ -0,0 +1,83 @@
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
+int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const char **isa)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_isa_string *isa_node;
+	struct acpi_table_rhct *rhct;
+	u32 *hart_info_node_offset;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
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

