Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6872D6C215D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjCTT2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCTT2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:28:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2A44DBCA;
        Mon, 20 Mar 2023 12:20:39 -0700 (PDT)
Received: from vm02.corp.microsoft.com (unknown [167.220.197.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13D3A20FAEFE;
        Mon, 20 Mar 2023 12:20:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13D3A20FAEFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679340024;
        bh=5BR0f6PrkO2ZuCv3kzx8IsqaHLeKQ2EwX1QEDZefxrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVBn9ynWsu5EEl41Ch9x59ghkmiYuQwTFGsIQTdRxgfKS6ybWbXZ10Wc4UTEgIdAw
         hqp1jpwGZ52hjOzpcsH9vswOMXbvqKyNemXqPOh2NpFLZsotXf5xF/46fmL6gPklwt
         bIqP+aDsurNEzApM1gjIab7W7hOz0OdU/xA9CM1E=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v3 2/8] ACPI: ASPT: Add helper to parse table
Date:   Mon, 20 Mar 2023 19:19:50 +0000
Message-Id: <20230320191956.1354602-3-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
References: <20230320191956.1354602-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASP table indicates the presence of a Platform Security Processor
with a register window and registers to configure interrupt delivery.
The helper checks for the presence of the table and returns a resource
and struct with register offsets.

Link: https://github.com/acpica/acpica/commit/15b939b034ab41a864b4e7647b8e2233780bb0c7
Link: https://www.amd.com/system/files/TechDocs/58028_1.00-PUB.pdf
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/aspt.c               | 104 ++++++++++++++++++++++++++++++
 include/linux/platform_data/psp.h |  32 +++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/acpi/aspt.c
 create mode 100644 include/linux/platform_data/psp.h

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index feb36c0b9446..831d7a12b522 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -57,6 +57,7 @@ acpi-y				+= evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
+acpi-$(CONFIG_X86)		+= aspt.o
 acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_X86)		+= x86/s2idle.o
diff --git a/drivers/acpi/aspt.c b/drivers/acpi/aspt.c
new file mode 100644
index 000000000000..cf629db35036
--- /dev/null
+++ b/drivers/acpi/aspt.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "ACPI: ASPT: " fmt
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/platform_data/psp.h>
+
+static int __init psp_validate_regs(const struct acpi_aspt_global_regs *gregs,
+	const struct acpi_aspt_sev_mbox_regs *sevregs,
+	const struct acpi_aspt_acpi_mbox_regs *acpiregs)
+{
+	u64 pfn;
+	int idx;
+	u64 regs[] = {
+		gregs->feature_reg_addr,
+		gregs->irq_en_reg_addr,
+		gregs->irq_st_reg_addr,
+		sevregs->cmd_resp_reg_addr,
+		sevregs->cmd_buf_lo_reg_addr,
+		sevregs->cmd_buf_hi_reg_addr,
+		acpiregs->cmd_resp_reg_addr
+	};
+	pfn = regs[0] >> PAGE_SHIFT;
+	for (idx = 1; idx < ARRAY_SIZE(regs); idx++) {
+		if (regs[idx] >> PAGE_SHIFT != pfn)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/**
+ * acpi_parse_aspt - Parse ASPT table and return contained information
+ * @res: will be filled with the address and size of the ASP register window
+ * @pdata: will be filled with the register offsets parsed from the ASPT table
+ */
+int __init acpi_parse_aspt(struct resource *res, struct psp_platform_data *pdata)
+{
+	struct acpi_aspt_acpi_mbox_regs acpiregs = {};
+	struct acpi_aspt_sev_mbox_regs sevregs = {};
+	struct acpi_aspt_global_regs gregs = {};
+	struct acpi_aspt_header *entry, *end;
+	struct acpi_table_aspt *aspt;
+	unsigned long base;
+	acpi_status status;
+	int err = 0;
+
+	status = acpi_get_table(ACPI_SIG_ASPT, 0, (struct acpi_table_header **)&aspt);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	if (aspt->header.revision != ASPT_REVISION_ID) {
+		pr_err("unsupported table revision: %d\n", (int)aspt->header.revision);
+		err = -ENODEV;
+		goto exit;
+	}
+	entry = (struct acpi_aspt_header *)(aspt + 1);
+	end = (struct acpi_aspt_header *)((void *)aspt + aspt->header.length);
+	while (entry < end) {
+		if (((void *)entry + entry->length) > (void *)end) {
+			pr_err("error during parsing\n");
+			err = -EINVAL;
+			goto exit;
+		}
+		switch (entry->type) {
+		case ACPI_ASPT_TYPE_GLOBAL_REGS:
+			memcpy(&gregs, entry, entry->length);
+			break;
+		case ACPI_ASPT_TYPE_SEV_MBOX_REGS:
+			memcpy(&sevregs, entry, entry->length);
+			break;
+		case ACPI_ASPT_TYPE_ACPI_MBOX_REGS:
+			memcpy(&acpiregs, entry, entry->length);
+			break;
+		}
+		entry = (struct acpi_aspt_header *)((void *)entry + entry->length);
+	}
+	if (!gregs.header.length || !sevregs.header.length || !acpiregs.header.length) {
+		pr_err("missing ASPT table entry: %u %u %u\n", gregs.header.length,
+			sevregs.header.length,
+			acpiregs.header.length);
+		err = -EINVAL;
+		goto exit;
+	}
+	/* All registers are expected to be within the same page */
+	err = psp_validate_regs(&gregs, &sevregs, &acpiregs);
+	if (err) {
+		pr_err("ASPT registers span multiple pages\n");
+		goto exit;
+	}
+
+	base = ALIGN_DOWN(gregs.feature_reg_addr, PAGE_SIZE);
+	*res = (struct resource)DEFINE_RES_MEM(base, PAGE_SIZE);
+
+	pdata->sev_cmd_resp_reg = sevregs.cmd_resp_reg_addr & ~PAGE_MASK;
+	pdata->sev_cmd_buf_lo_reg = sevregs.cmd_buf_lo_reg_addr & ~PAGE_MASK;
+	pdata->sev_cmd_buf_hi_reg = sevregs.cmd_buf_hi_reg_addr & ~PAGE_MASK;
+	pdata->feature_reg = gregs.feature_reg_addr & ~PAGE_MASK;
+	pdata->irq_en_reg = gregs.irq_en_reg_addr & ~PAGE_MASK;
+	pdata->irq_st_reg = gregs.irq_st_reg_addr & ~PAGE_MASK;
+	pdata->mbox_irq_id = sevregs.mbox_irq_id;
+	pdata->acpi_cmd_resp_reg = acpiregs.cmd_resp_reg_addr & ~PAGE_MASK;
+
+exit:
+	acpi_put_table((struct acpi_table_header *)aspt);
+	return err;
+}
diff --git a/include/linux/platform_data/psp.h b/include/linux/platform_data/psp.h
new file mode 100644
index 000000000000..b761f72168d6
--- /dev/null
+++ b/include/linux/platform_data/psp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * psp.h - PSP register offsets parsed from ASPT ACPI table
+ */
+
+#ifndef __LINUX_PSP_H
+#define __LINUX_PSP_H
+
+#include <linux/types.h>
+#include <linux/ioport.h>
+
+struct psp_platform_data {
+	int sev_cmd_resp_reg;
+	int sev_cmd_buf_lo_reg;
+	int sev_cmd_buf_hi_reg;
+	int feature_reg;
+	int irq_en_reg;
+	int irq_st_reg;
+	int mbox_irq_id;
+	int acpi_cmd_resp_reg;
+};
+
+#if IS_ENABLED(CONFIG_ACPI)
+int acpi_parse_aspt(struct resource *res, struct psp_platform_data *pdata);
+#else
+static inline acpi_parse_aspt(struct resource *res, struct psp_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __LINUX_PSP_H */
-- 
2.34.1

