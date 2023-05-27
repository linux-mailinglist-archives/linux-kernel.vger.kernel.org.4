Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480197132A8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 07:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjE0Fr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 01:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjE0Fr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 01:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB2114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 22:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0D560F27
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57772C433D2;
        Sat, 27 May 2023 05:47:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>
Subject: [PATCH 2/2] irqchip/loongson-pch-msi: Add machanism to limit msi allocation
Date:   Sat, 27 May 2023 13:46:33 +0800
Message-Id: <20230527054633.704916-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230527054633.704916-1-chenhuacai@loongson.cn>
References: <20230527054633.704916-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson machines can have as many as 256 logical cpus, but the maximum
of msi vectors in one irqchip is also 256 (practically that is less than
256, because pch-pic consumes some of them). Even on a 64-core machine,
256 irqs can be easily exhausted if there are several NICs (NICs usually
allocate msi irqs depending on the number of online cpus). So we want to
limit the msi allocation.

In this patch we add a machanism to limit msi allocation:
1, Modify input "nvec" by overriding the msi_domain_ops::msi_prepare();
2, The default limit is 256, which is compatible with the old behavior;
3, Add a cmdline parameter "loongson_msi_limit=xxx" to control the limit.

Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 6e1e1f011bb2..85e2e3468b8c 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -85,9 +85,36 @@ static void pch_msi_compose_msi_msg(struct irq_data *data,
 	msg->data = data->hwirq;
 }
 
+#define DEFAULT_MSI_LIMITS 256
+
+static int pch_msi_limits = DEFAULT_MSI_LIMITS;
+
+static int __init pch_msi_limit(char *str)
+{
+	get_option(&str, &pch_msi_limits);
+
+	if (pch_msi_limits <= 0)
+		pch_msi_limits = DEFAULT_MSI_LIMITS;
+
+	return 0;
+}
+
+early_param("loongson_msi_limit", pch_msi_limit);
+
+static int pch_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec, msi_alloc_info_t *arg)
+{
+	memset(arg, 0, sizeof(*arg));
+	return clamp_val(nvec, 0, pch_msi_limits);
+}
+
+static struct msi_domain_ops pch_msi_ops = {
+	.msi_prepare	= pch_msi_prepare,
+};
+
 static struct msi_domain_info pch_msi_domain_info = {
 	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+	.ops	= &pch_msi_ops,
 	.chip	= &pch_msi_irq_chip,
 };
 
-- 
2.39.1

