Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4971F8B6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 05:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjFBDHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 23:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFBDHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 23:07:37 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E21018C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 20:07:34 -0700 (PDT)
Received: from loongson.cn (unknown [10.2.9.158])
        by gateway (Coremail) with SMTP id _____8AxhPD1XHlkvH4DAA--.7574S3;
        Fri, 02 Jun 2023 11:07:33 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxfTv0XHlk3jaFAA--.19342S2;
        Fri, 02 Jun 2023 11:07:32 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Align pci memory base address with page size
Date:   Fri,  2 Jun 2023 11:07:32 +0800
Message-Id: <20230602030732.1047696-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfTv0XHlk3jaFAA--.19342S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uw1UWFyrGryDtryUCFW7urg_yoW8Aw1rpF
        yxAa9xAFs5KrnIqwsxtw1DZFnYga92ka13JrWfAr9xGanxZ34xZrn3AryUZFW8Ar4kGFW0
        qF4Yyr4UWFyUAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LoongArch linux kernel uses 16K page size by default, some pci devices have
only 4K memory size, it is normal in general architectures. However memory
space of different pci devices will share one physical page address space.
This is not safe for mmu protection, also UIO and VFIO requires base
address of pci memory space page aligned.

This patch adds check with function pcibios_align_resource, and set base
address of resource page aligned.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/pci/pci.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
index 2726639150bc..1380f3672ba2 100644
--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -83,6 +83,29 @@ int pcibios_alloc_irq(struct pci_dev *dev)
 	return acpi_pci_irq_enable(dev);
 }
 
+/*
+ * memory space size of some pci cards is 4K, it is separated with
+ * different pages for generic architectures, so that mmu protection can
+ * work with different pci cards. However page size for LoongArch system
+ * is 16K, memory space of different pci cards may share the same page
+ * on LoongArch, it is not safe here.
+ * Also uio drivers and vfio drivers sugguests that base address of memory
+ * space should page aligned. This function aligns base address with page size
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+		resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_MEM) {
+		if (align & (PAGE_SIZE - 1)) {
+			align = PAGE_SIZE;
+			start = ALIGN(start, align);
+		}
+	}
+	return start;
+}
+
 static void pci_fixup_vgadev(struct pci_dev *pdev)
 {
 	struct pci_dev *devp = NULL;
-- 
2.27.0

