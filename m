Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD89727F97
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjFHMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbjFHMEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:04:05 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFB02136
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686225844; x=1717761844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vKyX2e3xjjf80UVNk4kdfkLWpJ45nfqrK+CtzrXfKM=;
  b=PopBWgFuaBzdC5rWY4/6cbyvIctpDes6ky3K1vt++6XZ9aVH3CKAWjru
   K0SasxLgNEj77ERIVAa2dad1sYlNQu4qos67is1pMYl7NfSNyZ6n9XoTz
   yj+t6bN6xFirLWOY2Sgnaofowj9dPp3zQBnsqGFuTJPxEhVcjru5OvIUq
   s=;
X-IronPort-AV: E=Sophos;i="6.00,226,1681171200"; 
   d="scan'208";a="337716486"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 12:03:58 +0000
Received: from EX19D014EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 61C28A7B21;
        Thu,  8 Jun 2023 12:03:56 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.221) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 12:03:50 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>, <liaochang1@huawei.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
Subject: [PATCH 3/3] irqchip/gic-v3-its: Enable RESEND_WHEN_IN_PROGRESS for LPIs
Date:   Thu, 8 Jun 2023 14:00:21 +0200
Message-ID: <20230608120021.3273400-4-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608120021.3273400-1-jgowans@amazon.com>
References: <20230608120021.3273400-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.221]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC-v3 LPIs are impacted by an architectural design issue: they do not
have a global active state and as such the next LPI can be delivered to
a new CPU after an affinity change while the previous LPI handler has
not yet returned on the original CPU. If LPIs had an active state, then
an LPI would not be able to be retriggered until the first CPU had
issued a deactivation. As is, it is necessary to cater for this case in
software by enabling the IRQD_RESEND_WHEN_IN_PROGRESS flag for GIC-v3
interrupts. Setting this flag mitigates the issue by getting the
original CPU to resend the interrupt after the handler completed.

This RESEND_WHEN_INPROGRESS enablement is done for vanilla GIC-v3
interrupts allocated from its_irq_domain_alloc as well as directly
injected vLPIs for vPEs provided by GIC-v4 features, which still uses
the GIC-v3 code.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Zhang Jianhua <chris.zjh@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0ec2b1e1df75..1994541eaef8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3585,6 +3585,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		irqd = irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
+		irqd_set_resend_when_in_progress(irqd);
 		pr_debug("ID:%d pID:%d vID:%d\n",
 			 (int)(hwirq + i - its_dev->event_map.lpi_base),
 			 (int)(hwirq + i), virq + i);
@@ -4523,6 +4524,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
 					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
+		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
 	if (err) {
-- 
2.25.1

