Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C34676B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 09:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAVIRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 03:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAVIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 03:17:18 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805A222D2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 00:17:16 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30M8Gvci039901;
        Sun, 22 Jan 2023 02:16:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674375417;
        bh=jJajb1VP2PjMo6TmRNZ2Wj2zpHQ05oS+g9eclveVChc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zEKXzQnf6mJkyA0cR3OwS+ShNgOm3gMfT/Sa9PDlXNS5taSHFytuFIbxzPvy0jbQF
         kXYQ/VbJ8pVkiRzbn9c3ucy+my1RY71hDN0Vi9/gKqkRfsTZMiGhCJg/ubcu4cTjh7
         f81+FBew0wXGawyDXqQf2qUxlx+xovneCTuYoHwI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30M8Guq7064961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 22 Jan 2023 02:16:57 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 22
 Jan 2023 02:16:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 22 Jan 2023 02:16:56 -0600
Received: from ula0132425.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30M8GjIe079831;
        Sun, 22 Jan 2023 02:16:53 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [RFC PATCH 2/2] irqchip: irq-ti-sci-inta: Introduce IRQ affinity support
Date:   Sun, 22 Jan 2023 13:46:07 +0530
Message-ID: <20230122081607.959474-3-vigneshr@ti.com>
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

Add support for setting IRQ affinity for VINTs which have only one event
mapped to them. This just involves changing the parent IRQs affinity
(GIC/INTR). Flag VINTs which have affinity configured so as to not
aggregate/map more events to such VINTs.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 39 +++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index f1419d24568e..237cb4707cb8 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -64,6 +64,7 @@ struct ti_sci_inta_event_desc {
  * @events:		Array of event descriptors assigned to this vint.
  * @parent_virq:	Linux IRQ number that gets attached to parent
  * @vint_id:		TISCI vint ID
+ * @affinity_managed	flag to indicate VINT affinity is managed
  */
 struct ti_sci_inta_vint_desc {
 	struct irq_domain *domain;
@@ -72,6 +73,7 @@ struct ti_sci_inta_vint_desc {
 	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
 	unsigned int parent_virq;
 	u16 vint_id;
+	bool affinity_managed;
 };
 
 /**
@@ -334,6 +336,8 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *d
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL) {
 		list_for_each_entry(vint_desc, &inta->vint_list, list) {
+			if (vint_desc->affinity_managed)
+				continue;
 			free_bit = find_first_zero_bit(vint_desc->event_map,
 						       MAX_EVENTS_PER_VINT);
 			if (free_bit != MAX_EVENTS_PER_VINT)
@@ -434,6 +438,7 @@ static int ti_sci_inta_request_resources(struct irq_data *data)
 		return PTR_ERR(event_desc);
 
 	data->chip_data = event_desc;
+	irq_data_update_effective_affinity(data, cpu_online_mask);
 
 	return 0;
 }
@@ -504,11 +509,45 @@ static void ti_sci_inta_ack_irq(struct irq_data *data)
 		ti_sci_inta_manage_event(data, VINT_STATUS_OFFSET);
 }
 
+#ifdef CONFIG_SMP
+static int ti_sci_inta_set_affinity(struct irq_data *d,
+				    const struct cpumask *mask_val, bool force)
+{
+	struct ti_sci_inta_event_desc *event_desc;
+	struct ti_sci_inta_vint_desc *vint_desc;
+	struct irq_data *parent_irq_data;
+
+	if (cpumask_equal(irq_data_get_effective_affinity_mask(d), mask_val))
+		return 0;
+
+	event_desc = irq_data_get_irq_chip_data(d);
+	if (event_desc) {
+		vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
+
+		/*
+		 * Cannot set affinity if there is more than one event
+		 * mapped to same VINT
+		 */
+		if (bitmap_weight(vint_desc->event_map, MAX_EVENTS_PER_VINT) > 1)
+			return -EINVAL;
+
+		vint_desc->affinity_managed = true;
+
+		irq_data_update_effective_affinity(d, mask_val);
+		parent_irq_data = irq_get_irq_data(vint_desc->parent_virq);
+		if (parent_irq_data->chip->irq_set_affinity)
+			return parent_irq_data->chip->irq_set_affinity(parent_irq_data, mask_val, force);
+	}
+
+	return -EINVAL;
+}
+#else
 static int ti_sci_inta_set_affinity(struct irq_data *d,
 				    const struct cpumask *mask_val, bool force)
 {
 	return -EINVAL;
 }
+#endif
 
 /**
  * ti_sci_inta_set_type() - Update the trigger type of the irq.
-- 
2.39.0

