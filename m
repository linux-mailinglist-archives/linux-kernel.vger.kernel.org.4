Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70D676B91
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAVIRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAVIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:17:27 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3EB222F7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:17:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30M8GrJx068237;
        Sun, 22 Jan 2023 02:16:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674375413;
        bh=mv0hV8ewp95lt3yVu41QLxHIs0FJ5UPFOndlM24JKb4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SSGGTw0deoid9ImgiWTAVwv4gbqrtM6vqV8AoM/DF+UJpBDOkpm3DKu4YlJDuTdz/
         6bQCWKmmJI4W3MhPwLM+T21SFYkvcqH2hTb8KAeuzrzlTTVy+Tj+EAx/411dCm61Xw
         bdic81Na1034MgYhcny1zEz+msgsalRjbhq/UC2U=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30M8Grmt074821
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Jan 2023 02:16:53 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 22
 Jan 2023 02:16:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 22 Jan 2023 02:16:53 -0600
Received: from ula0132425.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30M8GjId079831;
        Sun, 22 Jan 2023 02:16:50 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RFC PATCH 1/2] irqchip: irq-ti-sci-inta: Don't aggregate MSI events until necessary
Date:   Sun, 22 Jan 2023 13:46:06 +0530
Message-ID: <20230122081607.959474-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230122081607.959474-1-vigneshr@ti.com>
References: <20230122081607.959474-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INTA on K3 SoCs convert DMA global events (MSI) to wired interrupts
(VINT). Currently driver maps multiple events to single wired interrupt
lines.  This makes setting IRQ affinity impossible as migrating wired
interrupt to different core will end up migrating all events to that
core.

Allocate a dedicated VINT for each DMA event request until there are no
more VINTs. This creates a 1:1 DMA event to VINT mapping and thus
provides unique IRQ line. This will help allocate dedicated IRQs for
high performance DMA channels which can thus be mapped to particular
CPUs using IRQ affinity.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 45 +++++++++++++++++--------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index a6ecc53d055c..f1419d24568e 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -202,7 +202,8 @@ static int ti_sci_inta_xlate_irq(struct ti_sci_inta_irq_domain *inta,
  *
  * Return 0 if all went well else corresponding error value.
  */
-static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_domain *domain)
+static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_domain *domain,
+								  u16 vint_id)
 {
 	struct ti_sci_inta_irq_domain *inta = domain->host_data;
 	struct ti_sci_inta_vint_desc *vint_desc;
@@ -210,11 +211,6 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct device_node *parent_node;
 	unsigned int parent_virq;
 	int p_hwirq, ret;
-	u16 vint_id;
-
-	vint_id = ti_sci_get_free_resource(inta->vint);
-	if (vint_id == TI_SCI_RESOURCE_NULL)
-		return ERR_PTR(-EINVAL);
 
 	p_hwirq = ti_sci_inta_xlate_irq(inta, vint_id);
 	if (p_hwirq < 0) {
@@ -328,29 +324,38 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *d
 	struct ti_sci_inta_vint_desc *vint_desc = NULL;
 	struct ti_sci_inta_event_desc *event_desc;
 	u16 free_bit;
+	u16 vint_id;
 
 	mutex_lock(&inta->vint_mutex);
-	list_for_each_entry(vint_desc, &inta->vint_list, list) {
+	/*
+	 * Allocate new VINT each time until we runout, then start
+	 * aggregating
+	 */
+	vint_id = ti_sci_get_free_resource(inta->vint);
+	if (vint_id == TI_SCI_RESOURCE_NULL) {
+		list_for_each_entry(vint_desc, &inta->vint_list, list) {
+			free_bit = find_first_zero_bit(vint_desc->event_map,
+						       MAX_EVENTS_PER_VINT);
+			if (free_bit != MAX_EVENTS_PER_VINT)
+				set_bit(free_bit, vint_desc->event_map);
+		}
+	} else  {
+		vint_desc = ti_sci_inta_alloc_parent_irq(domain, vint_id);
+		if (IS_ERR(vint_desc)) {
+			event_desc = ERR_CAST(vint_desc);
+			goto unlock;
+		}
+
 		free_bit = find_first_zero_bit(vint_desc->event_map,
 					       MAX_EVENTS_PER_VINT);
-		if (free_bit != MAX_EVENTS_PER_VINT) {
-			set_bit(free_bit, vint_desc->event_map);
-			goto alloc_event;
-		}
+		set_bit(free_bit, vint_desc->event_map);
 	}
 
-	/* No free bits available. Allocate a new vint */
-	vint_desc = ti_sci_inta_alloc_parent_irq(domain);
-	if (IS_ERR(vint_desc)) {
-		event_desc = ERR_CAST(vint_desc);
+	if (free_bit == MAX_EVENTS_PER_VINT) {
+		event_desc = ERR_PTR(-EINVAL);
 		goto unlock;
 	}
 
-	free_bit = find_first_zero_bit(vint_desc->event_map,
-				       MAX_EVENTS_PER_VINT);
-	set_bit(free_bit, vint_desc->event_map);
-
-alloc_event:
 	event_desc = ti_sci_inta_alloc_event(vint_desc, free_bit, hwirq);
 	if (IS_ERR(event_desc))
 		clear_bit(free_bit, vint_desc->event_map);
-- 
2.39.0

