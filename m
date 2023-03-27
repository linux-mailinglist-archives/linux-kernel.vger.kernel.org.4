Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2756CA88E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC0PFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjC0PFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:05:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C0B1B0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:05:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4afY068463;
        Mon, 27 Mar 2023 10:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679929476;
        bh=bYvDC0LkZ7byc6AJsJjUZacTMv84gCVdtic17FdtJLk=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=bONDLQ5vxkqW8qD9KfddYzwG+WqVzydZ6SvIcGJCc6tls12OyStB4tR/phH+xsy9O
         BtdDvM6Ee9iq9musliiT5Qhw/TVzZoFVpzAF+flselaSxIUnfpZpEHq8/LQKAGbu7v
         e9uozgoU7kk6VmSsy+7NFZ5OCtdl7HRM+AhIkuv8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RF4ax1010429
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:04:36 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:04:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:04:36 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4VTk080647;
        Mon, 27 Mar 2023 10:04:34 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Date:   Mon, 27 Mar 2023 20:34:26 +0530
Subject: [PATCH RFC v2 1/2] irqchip: irq-ti-sci-inta: Allocates VINTs at
 probe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230327-irq-affinity-upstream-v2-1-1474e518f1cb@ti.com>
References: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
In-Reply-To: <20230327-irq-affinity-upstream-v2-0-1474e518f1cb@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
X-Mailer: b4 0.12.2
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify driver by allocating all VINTs at probe instead of
allocating on IRQ request. This will allow dedicating few VINTs as
direct IRQs without aggregation in future.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 144 +++++-----
 1 file changed, 67 insertions(+), 77 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index a6ecc53d055c..a3a22edbe0f0 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -96,6 +96,7 @@ struct ti_sci_inta_vint_desc {
  *			device identifier in place of the source device
  *			identifier to let sysfw know where it has to program the
  *			Global Event number.
+ * @num_vints:		Number of VINT lines allocated to this IA.
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -110,6 +111,7 @@ struct ti_sci_inta_irq_domain {
 
 	int unmapped_cnt;
 	u16 *unmapped_dev_ids;
+	int num_vints;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
@@ -197,12 +199,12 @@ static int ti_sci_inta_xlate_irq(struct ti_sci_inta_irq_domain *inta,
 }
 
 /**
- * ti_sci_inta_alloc_parent_irq() - Allocate parent irq to Interrupt aggregator
+ * ti_sci_inta_alloc_parent_irqs() - Allocate parent irqs to Interrupt aggregator
  * @domain:	IRQ domain corresponding to Interrupt Aggregator
  *
  * Return 0 if all went well else corresponding error value.
  */
-static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_domain *domain)
+static int ti_sci_inta_alloc_parent_irqs(struct irq_domain *domain)
 {
 	struct ti_sci_inta_irq_domain *inta = domain->host_data;
 	struct ti_sci_inta_vint_desc *vint_desc;
@@ -211,61 +213,69 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	unsigned int parent_virq;
 	int p_hwirq, ret;
 	u16 vint_id;
+	int i;
 
-	vint_id = ti_sci_get_free_resource(inta->vint);
-	if (vint_id == TI_SCI_RESOURCE_NULL)
-		return ERR_PTR(-EINVAL);
-
-	p_hwirq = ti_sci_inta_xlate_irq(inta, vint_id);
-	if (p_hwirq < 0) {
-		ret = p_hwirq;
-		goto free_vint;
-	}
+	parent_node = of_irq_find_parent(dev_of_node(&inta->pdev->dev));
+	parent_fwspec.fwnode = of_node_to_fwnode(parent_node);
 
-	vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
-	if (!vint_desc) {
-		ret = -ENOMEM;
-		goto free_vint;
-	}
+	for (i = 0; i < inta->num_vints; i++) {
+		vint_id = ti_sci_get_free_resource(inta->vint);
+		if (vint_id == TI_SCI_RESOURCE_NULL)
+			break;
 
-	vint_desc->domain = domain;
-	vint_desc->vint_id = vint_id;
-	INIT_LIST_HEAD(&vint_desc->list);
+		p_hwirq = ti_sci_inta_xlate_irq(inta, vint_id);
+		if (p_hwirq < 0) {
+			ret = p_hwirq;
+			goto free_vint;
+		}
 
-	parent_node = of_irq_find_parent(dev_of_node(&inta->pdev->dev));
-	parent_fwspec.fwnode = of_node_to_fwnode(parent_node);
+		vint_desc = kzalloc(sizeof(*vint_desc), GFP_KERNEL);
+		if (!vint_desc) {
+			ret = -ENOMEM;
+			goto free_vint;
+		}
 
-	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
-		/* Parent is GIC */
-		parent_fwspec.param_count = 3;
-		parent_fwspec.param[0] = 0;
-		parent_fwspec.param[1] = p_hwirq - 32;
-		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
-	} else {
-		/* Parent is Interrupt Router */
-		parent_fwspec.param_count = 1;
-		parent_fwspec.param[0] = p_hwirq;
-	}
+		INIT_LIST_HEAD(&vint_desc->list);
+		vint_desc->domain = domain;
+		vint_desc->vint_id = vint_id;
+
+		if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
+			/* Parent is GIC */
+			parent_fwspec.param_count = 3;
+			parent_fwspec.param[0] = 0;
+			parent_fwspec.param[1] = p_hwirq - 32;
+			parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+		} else {
+			/* Parent is Interrupt Router */
+			parent_fwspec.param_count = 1;
+			parent_fwspec.param[0] = p_hwirq;
+		}
 
-	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
-	if (parent_virq == 0) {
-		dev_err(&inta->pdev->dev, "Parent IRQ allocation failed\n");
-		ret = -EINVAL;
-		goto free_vint_desc;
+		parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
+		if (parent_virq == 0) {
+			dev_dbg(&inta->pdev->dev, "Parent IRQ allocation failed\n");
+			/*
+			 * Certain versions of firmwares don't have
+			 * enough INTR lines allocated to match number
+			 * of VINTs, hence don't error out to maintain
+			 * backward compatibility.
+			 */
+			ret = 0;
+			goto free_vint_desc;
+		}
+		vint_desc->parent_virq = parent_virq;
 
+		list_add_tail(&vint_desc->list, &inta->vint_list);
+		irq_set_chained_handler_and_data(vint_desc->parent_virq,
+						 ti_sci_inta_irq_handler, vint_desc);
 	}
-	vint_desc->parent_virq = parent_virq;
 
-	list_add_tail(&vint_desc->list, &inta->vint_list);
-	irq_set_chained_handler_and_data(vint_desc->parent_virq,
-					 ti_sci_inta_irq_handler, vint_desc);
-
-	return vint_desc;
+	return 0;
 free_vint_desc:
 	kfree(vint_desc);
 free_vint:
 	ti_sci_release_resource(inta->vint, vint_id);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /**
@@ -335,22 +345,14 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *d
 					       MAX_EVENTS_PER_VINT);
 		if (free_bit != MAX_EVENTS_PER_VINT) {
 			set_bit(free_bit, vint_desc->event_map);
-			goto alloc_event;
+			break;
 		}
 	}
-
-	/* No free bits available. Allocate a new vint */
-	vint_desc = ti_sci_inta_alloc_parent_irq(domain);
-	if (IS_ERR(vint_desc)) {
-		event_desc = ERR_CAST(vint_desc);
+	if (free_bit == MAX_EVENTS_PER_VINT) {
+		event_desc = NULL;
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
@@ -360,22 +362,6 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_irq(struct irq_domain *d
 	return event_desc;
 }
 
-/**
- * ti_sci_inta_free_parent_irq() - Free a parent irq to INTA
- * @inta:	Pointer to inta domain.
- * @vint_desc:	Pointer to vint_desc that needs to be freed.
- */
-static void ti_sci_inta_free_parent_irq(struct ti_sci_inta_irq_domain *inta,
-					struct ti_sci_inta_vint_desc *vint_desc)
-{
-	if (find_first_bit(vint_desc->event_map, MAX_EVENTS_PER_VINT) == MAX_EVENTS_PER_VINT) {
-		list_del(&vint_desc->list);
-		ti_sci_release_resource(inta->vint, vint_desc->vint_id);
-		irq_dispose_mapping(vint_desc->parent_virq);
-		kfree(vint_desc);
-	}
-}
-
 /**
  * ti_sci_inta_free_irq() - Free an IRQ within INTA domain
  * @event_desc:	Pointer to event_desc that needs to be freed.
@@ -405,7 +391,6 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 	event_desc->global_event = TI_SCI_RESOURCE_NULL;
 	event_desc->hwirq = 0;
 
-	ti_sci_inta_free_parent_irq(inta, vint_desc);
 	mutex_unlock(&inta->vint_mutex);
 }
 
@@ -414,8 +399,7 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
  * @data: Pointer to corresponding irq_data
  *
  * Note: This is the core api where the actual allocation happens for input
- *	 hwirq. This allocation involves creating a parent irq for vint.
- *	 If this is done in irq_domain_ops.alloc() then a deadlock is reached
+ *	 hwirq. If this is done in irq_domain_ops.alloc() then a deadlock is reached
  *	 for allocation. So this allocation is being done in request_resources()
  *
  * Return: 0 if all went well else corresponding error.
@@ -437,8 +421,7 @@ static int ti_sci_inta_request_resources(struct irq_data *data)
  * ti_sci_inta_release_resources - Release resources for input irq
  * @data: Pointer to corresponding irq_data
  *
- * Note: Corresponding to request_resources(), all the unmapping and deletion
- *	 of parent vint irqs happens in this api.
+ * Note: Corresponding to request_resources(), release event mapping
  */
 static void ti_sci_inta_release_resources(struct irq_data *data)
 {
@@ -701,8 +684,9 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	inta->num_vints = ti_sci_get_num_resources(inta->vint);
 	domain = irq_domain_add_linear(dev_of_node(dev),
-				       ti_sci_get_num_resources(inta->vint),
+				       inta->num_vints,
 				       &ti_sci_inta_irq_domain_ops, inta);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
@@ -721,6 +705,12 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&inta->vint_list);
 	mutex_init(&inta->vint_mutex);
 
+	ret = ti_sci_inta_alloc_parent_irqs(domain);
+	if (ret) {
+		irq_domain_remove(msi_domain);
+		irq_domain_remove(domain);
+	}
+
 	dev_info(dev, "Interrupt Aggregator domain %d created\n", inta->ti_sci_id);
 
 	return 0;

-- 
2.40.0

