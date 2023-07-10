Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608AE74CD09
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGJGd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGJGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:33:52 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 961A512A;
        Sun,  9 Jul 2023 23:33:45 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8BxY_BFpqtkavkCAA--.8714S3;
        Mon, 10 Jul 2023 14:33:41 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uREpqtk9NkmAA--.45300S2;
        Mon, 10 Jul 2023 14:33:40 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: processor_core: LoongArch: Get physical id from MADT table
Date:   Mon, 10 Jul 2023 14:33:40 +0800
Message-Id: <20230710063340.1716007-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax8uREpqtk9NkmAA--.45300S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1DZr47Jw45XryktrWUGFX_yoW8uryfpF
        y8K345K3WUWFnIq3WfJayrJFWYq3y8ua4SgFZ3C3sxtF4rGr1rZFW8JFyagFyDCF48K3y7
        Zr48tay8Gay8ZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
        r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
        IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With ACPI Spec 6.5 physical id can be parsed from MADT table for
LoongArch system, also it can be used in MAT table for cpu hotplug
stage. This patch adds physical id parsing for LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/processor_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index d6606a9f2da6..51239cd2a485 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -132,6 +132,26 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
 	return -EINVAL;
 }
 
+/*
+ * Retrieve LoongArch CPU physical id
+ */
+static int map_core_pic_id(struct acpi_subtable_header *entry,
+		int device_declaration, u32 acpi_id, phys_cpuid_t *apic_id)
+{
+	struct acpi_madt_core_pic *core_pic =
+		container_of(entry, struct acpi_madt_core_pic, header);
+
+	if (!(core_pic->flags & ACPI_MADT_ENABLED))
+		return -ENODEV;
+
+	if (device_declaration && (core_pic->processor_id == acpi_id)) {
+		*apic_id = core_pic->core_id;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 				   int type, u32 acpi_id)
 {
@@ -165,6 +185,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
 		} else if (header->type == ACPI_MADT_TYPE_RINTC) {
 			if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
 				break;
+		} else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
+			if (!map_core_pic_id(header, type, acpi_id, &phys_id))
+				break;
 		}
 		entry += header->length;
 	}
@@ -216,6 +239,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
 		map_x2apic_id(header, type, acpi_id, &phys_id);
 	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
 		map_gicc_mpidr(header, type, acpi_id, &phys_id);
+	else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
+		map_core_pic_id(header, type, acpi_id, &phys_id);
 
 exit:
 	kfree(buffer.pointer);
-- 
2.27.0

