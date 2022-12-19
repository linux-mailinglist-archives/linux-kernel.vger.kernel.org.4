Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65DF650C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiLSNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiLSNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:06:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13A767F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 05:06:43 -0800 (PST)
X-UUID: 4980063cd4454255930fa8edf6b84290-20221219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ikaKrwmw8xN9OWLD05oD7ZpRGvbapfbACgas4hgn6uk=;
        b=m3zFGt+qnRHCYSF0awoNvEzriihmkrStrHLTg72Ty0bIPgwAqLfgsv+FTirMu5hz/5H8LOrHUxvEob0hq2LLTTd5ysw7oECfAKinqSnx+LErR8ebZ1ymYCkJDqoF4M4fSegrYtHccO+0dZImUhbbiPGPixKz2ZH2if2jFjesV9w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:c2f5140b-4c17-48bb-a81a-2689f46887f7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:c2f5140b-4c17-48bb-a81a-2689f46887f7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:27c0c889-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221219210639L6M3UGTT,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4980063cd4454255930fa8edf6b84290-20221219
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 681364499; Mon, 19 Dec 2022 21:06:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Dec 2022 21:06:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 19 Dec 2022 21:06:36 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <yj.chiang@mediatek.com>, <phil.chang@mediatek.com>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] irqdomain: Fix irqdomain->revmap race
Date:   Mon, 19 Dec 2022 21:06:15 +0800
Message-ID: <20221219130620.21092-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqdomain->revmap(_tree) of a shared irq can be race updated
as following, which result in an unexpected irq mapping:

---------------------------------------------------------------
(2 threads parse the same hwirq fwspec in the same time.)

Thread A 			Thread B
irq_create_fwspec_mapping
irq_find_mapping						Thread A: virq = 0, alloc a new irq_desc
				irq_create_fwspec_mapping
				irq_find_mapping		Thread B: virq = 0, alloc a new irq_desc
irq_domain_alloc_irqs
irq_domain_insert_irq						domain->revmap[hwirq] = irq_data(virq x)
				irq_domain_alloc_irqs
				irq_domain_insert_irq		domain->revmap[hwirq] = irq_data(virq x + 1)

virq = x			virq = x + 1
---------------------------------------------------------------

The virq x can't work because the revmap[hwirq] was
overridden by thread B.

It seems both hierarchy and non-hierarchy irq domain have the same
problem because the code from irq_find_mapping to revmap update are
not protected by a same lock.

Do you have any suggestion about how to fix it properly?

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 kernel/irq/irqdomain.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fe1da9614ee..21d317b26220 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -22,6 +22,7 @@
 
 static LIST_HEAD(irq_domain_list);
 static DEFINE_MUTEX(irq_domain_mutex);
+static DEFINE_MUTEX(irq_revmaps_mutex);
 
 static struct irq_domain *irq_default_domain;
 
@@ -793,6 +794,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	 * If we've already configured this interrupt,
 	 * don't do it again, or hell will break loose.
 	 */
+	mutex_lock(&irq_revmaps_mutex);
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
 		/*
@@ -801,7 +803,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 * interrupt number.
 		 */
 		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
-			return virq;
+			goto unlock;
 
 		/*
 		 * If the trigger type has not been set yet, then set
@@ -809,27 +811,32 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 		 */
 		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
 			irq_data = irq_get_irq_data(virq);
-			if (!irq_data)
-				return 0;
+			if (!irq_data) {
+				virq = 0;
+				goto unlock;
+			}
 
 			irqd_set_trigger_type(irq_data, type);
-			return virq;
+			goto unlock;
 		}
 
 		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
 			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
-		return 0;
+		virq = 0;
+		goto unlock;
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
 		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
-		if (virq <= 0)
-			return 0;
+		if (virq <= 0) {
+			virq = 0;
+			goto unlock;
+		}
 	} else {
 		/* Create mapping */
 		virq = irq_create_mapping(domain, hwirq);
 		if (!virq)
-			return virq;
+			goto unlock;
 	}
 
 	irq_data = irq_get_irq_data(virq);
@@ -838,12 +845,15 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 			irq_domain_free_irqs(virq, 1);
 		else
 			irq_dispose_mapping(virq);
-		return 0;
+		virq = 0;
+		goto unlock;
 	}
 
 	/* Store trigger type */
 	irqd_set_trigger_type(irq_data, type);
 
+unlock:
+	mutex_unlock(&irq_revmaps_mutex);
 	return virq;
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
-- 
2.18.0

