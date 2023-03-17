Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE06BE5FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCQJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCQJxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:53:31 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2346D44A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679046810; x=1710582810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SRoBsf0DBlijqQReE0yd93kjz2dNVXaOIMZ+MtfqJ3U=;
  b=qBUBi1eqvtJh/RXcDjubKzOsLmSiR7fOW3eCoqIzLTpj33/0fu5/zF/6
   CFXGAAC01bGs6ZA490ASECiWKaBT1tkS1W+M7Mau+sbUk7aSs7HUS4lsG
   LiSxiJ+/5YrifxOY08H+In+kSTsJ6pBSufBud+cM7ddR9XSNaWMBbFrPA
   k=;
X-IronPort-AV: E=Sophos;i="5.98,268,1673913600"; 
   d="scan'208";a="194436520"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 09:53:27 +0000
Received: from EX19D014EUC004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-93c3b254.us-east-1.amazon.com (Postfix) with ESMTPS id 0C7F3E6BD3;
        Fri, 17 Mar 2023 09:53:24 +0000 (UTC)
Received: from u5d18b891348c5b.ant.amazon.com (172.31.190.49) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Fri, 17 Mar 2023 09:53:20 +0000
From:   James Gowans <jgowans@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, James Gowans <jgowans@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>,
        KarimAllah Raslan <karahmed@amazon.com>
Subject: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
Date:   Fri, 17 Mar 2023 11:53:00 +0200
Message-ID: <20230317095300.4076497-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.31.190.49]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the generic handle_fasteoi_irq to cater for the case when the
next interrupt comes in while the previous handler is still running.
Currently when that happens the irq_may_run() early out causes the next
IRQ to be lost. Change the behaviour to mark the interrupt as pending
and re-run the handler when handle_fasteoi_irq sees that the pending
flag has been set again. This is largely inspired by handle_edge_irq.

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

There are a few uncertainties about this implementation compared to the
prior art in handle_edge_irq:

1. Do we need to mask the IRQ and then unmask it later? I don't think so
but it's not entirely clear why handle_edge_irq does this anyway; it's
an edge IRQ so not sure why it needs to be masked.

2. Should the EOI delivery be inside the do loop after every handler
run? I think outside the loops is best; only inform the chip to deliver
more IRQs once all pending runs have been finished.

3. Do we need to check that desc->action is still set? I don't know if
it can be un-set while the IRQ is still enabled.

4. There is now more overlap with the handle_edge_eoi_irq handler;
should we try to unify these?

Signed-off-by: James Gowans <jgowans@amazon.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: KarimAllah Raslan <karahmed@amazon.com>
---
 Documentation/core-api/genericirq.rst | 9 ++++++++-
 kernel/irq/chip.c                     | 9 +++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index f959c9b53f61..b54485eca8b5 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -240,7 +240,14 @@ which only need an EOI at the end of the handler.
 
 The following control flow is implemented (simplified excerpt)::
 
-    handle_irq_event(desc->action);
+    if (desc->status & running) {
+        desc->status |= pending;
+        return;
+    }
+    do {
+        desc->status &= ~pending;
+        handle_irq_event(desc->action);
+    } while (status & pending);
     desc->irq_data.chip->irq_eoi();
 
 
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 49e7bc871fec..4e5fc2b7e8a9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -692,8 +692,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_may_run(desc)) {
+		desc->istate |= IRQS_PENDING;
 		goto out;
+	}
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
@@ -711,7 +713,10 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	handle_irq_event(desc);
+	do {
+		handle_irq_event(desc);
+	} while (unlikely((desc->istate & IRQS_PENDING) &&
+			!irqd_irq_disabled(&desc->irq_data)));
 
 	cond_unmask_eoi_irq(desc, chip);
 
-- 
2.25.1

