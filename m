Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A8F716FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjE3Vk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjE3Vkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:40:55 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10010C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685482852; x=1717018852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftAFphcVxzGLv+67SdqYllEq9CFHtOpGNV+NWTrOO9Q=;
  b=DDNdBLRgJzaPoErfqin5SGMhzFDSwD+2MB8hNx1YgxNJ1/oK6l3sS1Ej
   S4IgTPlH/sX2skAwsh92cI/IDdbt5Iz+nUNLBpmR82AORjY7bpMz1oiTz
   b13PQ0dgPfe4NPJ4qZRf5r9mFKgIzcSnFeC9uwfVZ6iiQp15VL6IADnVH
   c=;
X-IronPort-AV: E=Sophos;i="6.00,205,1681171200"; 
   d="scan'208";a="1134593118"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 21:40:46 +0000
Received: from EX19D014EUC004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 67B53A0B09;
        Tue, 30 May 2023 21:40:44 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.226) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 21:40:39 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
        Liao Chang <liaochang1@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        KarimAllah Raslan <karahmed@amazon.com>,
        Yipeng Zou <zouyipeng@huawei.com>,
        Zhang Jianhua <chris.zjh@huawei.com>
Subject: [PATCH 2/2] genirq: fasteoi resends interrupt on concurrent invoke
Date:   Tue, 30 May 2023 23:38:48 +0200
Message-ID: <20230530213848.3273006-2-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530213848.3273006-1-jgowans@amazon.com>
References: <20230530213848.3273006-1-jgowans@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.146.13.226]
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the generic handle_fasteoi_irq to cater for the case when the
next interrupt comes in while the previous handler is still running.
Currently when that happens the irq_may_run() early out causes the next
IRQ to be lost. Change the behaviour to mark the interrupt as pending
and re-send the interrupt when handle_fasteoi_irq sees that the pending
flag has been set. This is largely inspired by handle_edge_irq.

Generally it should not be possible for the next interrupt to arrive
while the previous handler is still running: the next interrupt should
only arrive after the EOI message has been sent and the previous handler
has returned. However, there is a race where if the interrupt affinity
is changed while the previous handler is running, then the next
interrupt can arrive at a different CPU while the previous handler is
still running. In that case there will be a concurrent invoke and the
early out will be taken.

For example:

           CPU 0             |          CPU 1
-----------------------------|-----------------------------
interrupt start              |
  handle_fasteoi_irq         | set_affinity(CPU 1)
    handler                  |
    ...                      | interrupt start
    ...                      |   handle_fasteoi_irq -> early out
  handle_fasteoi_irq return  | interrupt end
interrupt end                |

This issue was observed specifically on an arm64 system with a GIC-v3
handling MSIs; GIC-v3 uses the handle_fasteoi_irq handler. The issue is
that the global ITS is responsible for affinity but does not know
whether interrupts are pending/running, only the CPU-local redistributor
handles the EOI. Hence when the affinity is changed in the ITS, the new
CPU's redistributor does not know that the original CPU is still running
the handler.

Implementation notes:

It is believed that it's NOT necessary to mask the interrupt in
handle_fasteoi_irq() the way that handle_edge_irq() does. This is
because handle_edge_irq() caters for controllers which are too simple to
gate interrupts from the same source, so the kernel explicitly masks the
interrupt if it re-occurs [0].

[0] https://lore.kernel.org/all/bf94a380-fadd-8c38-cc51-4b54711d84b3@huawei.com/

Suggested-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
Cc: Yipeng Zou <zouyipeng@huawei.com>
Cc: Zhang Jianhua <chris.zjh@huawei.com>
---
 kernel/irq/chip.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..42f33e77c16b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -692,8 +692,15 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	/*
+	 * When an affinity change races with IRQ delivery, the next interrupt
+	 * can arrive on the new CPU before the original CPU has completed
+	 * handling the previous one. Mark it as pending and return EOI.
+	 */
+	if (!irq_may_run(desc)) {
+		desc->istate |= IRQS_PENDING;
 		goto out;
+	}
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
@@ -715,6 +722,12 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	cond_unmask_eoi_irq(desc, chip);
 
+	/*
+	 * When the race descibed above happens, this will resend the interrupt.
+	 */
+	if (unlikely(desc->istate & IRQS_PENDING))
+		check_irq_resend(desc, false);
+
 	raw_spin_unlock(&desc->lock);
 	return;
 out:
-- 
2.25.1

