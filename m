Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042526CA88F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjC0PFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC0PFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:05:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199F1BFC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:05:13 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4d6h115290;
        Mon, 27 Mar 2023 10:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679929479;
        bh=Cw06P9AajAXATMgtc//ViwtgcNs8f9GRHO6S7gEbNT0=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=Ztwo2kHXoYa39d7Tj92759MM6PB/oLTpNX8IDHSgAxHqfCu4u9oWv7u7HkzaVxKt9
         vaefXQBOdSWqdWuRncrlfacHlHB2UMo192EFUmfeIQmB52vE861NpoQwdJHakZZvli
         WLvrot1n3NoY6sW7zyvy4P2Lx0UKeNXValfrw4UE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32RF4dqr010456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Mar 2023 10:04:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 27
 Mar 2023 10:04:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 27 Mar 2023 10:04:39 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32RF4VTl080647;
        Mon, 27 Mar 2023 10:04:37 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Date:   Mon, 27 Mar 2023 20:34:27 +0530
Subject: [PATCH RFC v2 2/2] irqchip: irq-ti-sci-inta: Add direct mapped
 interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230327-irq-affinity-upstream-v2-2-1474e518f1cb@ti.com>
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

Certain high throughput peripherals such as ethernet etc may need
dedicated IRQ lines so the IRQ load can be balanced across cores using
IRQ affinity controls. Current driver aggregates multiple events/IRQ to
single wired IRQ line/VINT thus making it impossible to migrate events
selectively.
In order to overcome this limitation, reserve a set of VINTs as direct
interrupts and map them to events that are known to generate high IRQ
load. Use SoC specific table to determine such events.

This allows affinity management at parent irqchip level (GIC or
ti-sci-intr + GIC).

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 149 +++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index a3a22edbe0f0..db098bd95edc 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -21,6 +21,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/sys_soc.h>
 #include <asm-generic/msi.h>
 
 #define TI_SCI_DEV_ID_MASK	0xffff
@@ -40,6 +41,20 @@
 #define VINT_STATUS_OFFSET	0x18
 #define VINT_STATUS_MASKED_OFFSET	0x20
 
+#define DEV_DMASS0_INTAGGR_0 28
+#define DEV_DMASS0_PKTDMA_0 30
+
+/**
+ * struct ti_sci_inta_soc_data - Description of SoC specific data
+ * @events_list:		Pointer to array of events requiring direct IRQ
+ *                              mapping
+ * @events_list_size:		size of event_list array
+ */
+struct ti_sci_inta_soc_data {
+	unsigned int *events_list;
+	int events_list_size;
+};
+
 /**
  * struct ti_sci_inta_event_desc - Description of an event coming to
  *				   Interrupt Aggregator. This serves
@@ -64,6 +79,7 @@ struct ti_sci_inta_event_desc {
  * @events:		Array of event descriptors assigned to this vint.
  * @parent_virq:	Linux IRQ number that gets attached to parent
  * @vint_id:		TISCI vint ID
+ * @reserved:		Indicate if this VINT is reserved for direct mapping
  */
 struct ti_sci_inta_vint_desc {
 	struct irq_domain *domain;
@@ -72,6 +88,7 @@ struct ti_sci_inta_vint_desc {
 	struct ti_sci_inta_event_desc events[MAX_EVENTS_PER_VINT];
 	unsigned int parent_virq;
 	u16 vint_id;
+	bool reserved;
 };
 
 /**
@@ -81,6 +98,8 @@ struct ti_sci_inta_vint_desc {
  * @vint:		TISCI resource pointer representing IA interrupts.
  * @global_event:	TISCI resource pointer representing global events.
  * @vint_list:		List of the vints active in the system
+ * @resv_vint_list:	List of the direct vints active in the system.
+ * @resv_events:	Pointer to list of direct events
  * @vint_mutex:		Mutex to protect vint_list
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
@@ -97,12 +116,15 @@ struct ti_sci_inta_vint_desc {
  *			identifier to let sysfw know where it has to program the
  *			Global Event number.
  * @num_vints:		Number of VINT lines allocated to this IA.
+ * @num_resv_vints:	Number of VINT lines reserved for direct mapping.
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
 	struct ti_sci_resource *vint;
 	struct ti_sci_resource *global_event;
 	struct list_head vint_list;
+	struct list_head resv_vint_list;
+	unsigned int *resv_events;
 	/* Mutex to protect vint list */
 	struct mutex vint_mutex;
 	void __iomem *base;
@@ -112,6 +134,7 @@ struct ti_sci_inta_irq_domain {
 	int unmapped_cnt;
 	u16 *unmapped_dev_ids;
 	int num_vints;
+	int num_resv_vints;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
@@ -265,7 +288,11 @@ static int ti_sci_inta_alloc_parent_irqs(struct irq_domain *domain)
 		}
 		vint_desc->parent_virq = parent_virq;
 
-		list_add_tail(&vint_desc->list, &inta->vint_list);
+		if (i < inta->num_resv_vints)
+			list_add_tail(&vint_desc->list, &inta->resv_vint_list);
+		else
+			list_add_tail(&vint_desc->list, &inta->vint_list);
+
 		irq_set_chained_handler_and_data(vint_desc->parent_virq,
 						 ti_sci_inta_irq_handler, vint_desc);
 	}
@@ -390,8 +417,58 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 	ti_sci_release_resource(inta->global_event, event_desc->global_event);
 	event_desc->global_event = TI_SCI_RESOURCE_NULL;
 	event_desc->hwirq = 0;
+	vint_desc->reserved = false;
+}
+
+/**
+ * ti_sci_inta_alloc_direct_irq - Allocate non-aggregated events/IRQs
+ * @data: Pointer to corresponding irq_data
+ *
+ * Returns allocated event_desc, ERR_PTR otherwise.
+ */
+static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_direct_irq(struct irq_data *data)
+{
+	struct ti_sci_inta_irq_domain *inta = data->domain->host_data;
+	struct ti_sci_inta_event_desc *event_desc = NULL;
+	struct ti_sci_inta_vint_desc *vint_desc;
+
+	mutex_lock(&inta->vint_mutex);
+	list_for_each_entry(vint_desc, &inta->resv_vint_list, list) {
+		if (vint_desc->reserved)
+			continue;
+
+		vint_desc->reserved = true;
+		event_desc = ti_sci_inta_alloc_event(vint_desc, 0, data->hwirq);
+		if (IS_ERR(event_desc))
+			goto unlock;
 
+		data->parent_data = irq_get_irq_data(vint_desc->parent_virq);
+		break;
+	}
+unlock:
 	mutex_unlock(&inta->vint_mutex);
+
+	return event_desc;
+}
+
+/**
+ * ti_sci_inta_direct_irq - Allocate non-aggregated events/IRQs
+ * @data: Pointer to corresponding irq_data
+ *
+ * Returns true if this IRQ is to be direct mapped on given platform,
+ * false otherwise.
+ */
+static bool ti_sci_inta_direct_irq(struct irq_data *data)
+{
+	struct ti_sci_inta_irq_domain *inta = data->domain->host_data;
+	int i;
+
+	for (i = 0; i < inta->num_resv_vints; i++) {
+		if (data->hwirq == inta->resv_events[i])
+			return true;
+	}
+
+	return false;
 }
 
 /**
@@ -408,7 +485,11 @@ static int ti_sci_inta_request_resources(struct irq_data *data)
 {
 	struct ti_sci_inta_event_desc *event_desc;
 
-	event_desc = ti_sci_inta_alloc_irq(data->domain, data->hwirq);
+	if (ti_sci_inta_direct_irq(data))
+		event_desc = ti_sci_inta_alloc_direct_irq(data);
+	else
+		event_desc = ti_sci_inta_alloc_irq(data->domain, data->hwirq);
+
 	if (IS_ERR(event_desc))
 		return PTR_ERR(event_desc);
 
@@ -485,6 +566,15 @@ static void ti_sci_inta_ack_irq(struct irq_data *data)
 static int ti_sci_inta_set_affinity(struct irq_data *d,
 				    const struct cpumask *mask_val, bool force)
 {
+	int ret;
+
+	if (d->parent_data) {
+		ret =  irq_chip_set_affinity_parent(d, mask_val, force);
+		irq_data_update_effective_affinity(d, mask_val);
+
+		return ret;
+	}
+
 	return -EINVAL;
 }
 
@@ -627,9 +717,54 @@ static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_domain *inta)
 	return 0;
 }
 
+static unsigned int ti_sci_inta_direct_events_am62x[] = {
+	/* CPSW etherenti DMA events */
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4627),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4635),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4643),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4651),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4659),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4667),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4675),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4683),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 5651),
+};
+
+static struct ti_sci_inta_soc_data soc_data_am62x = {
+	.events_list = ti_sci_inta_direct_events_am62x,
+	.events_list_size = ARRAY_SIZE(ti_sci_inta_direct_events_am62x),
+};
+
+static unsigned int ti_sci_inta_direct_events_am64x[] = {
+	/* CPSW etherenti DMA events */
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4624),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4632),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4640),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4648),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4656),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4664),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4672),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 4680),
+	TO_HWIRQ(DEV_DMASS0_PKTDMA_0, 5648),
+};
+
+static struct ti_sci_inta_soc_data soc_data_am64x = {
+	.events_list = ti_sci_inta_direct_events_am64x,
+	.events_list_size = ARRAY_SIZE(ti_sci_inta_direct_events_am64x),
+};
+
+static const struct soc_device_attribute k3_soc_devices[] = {
+	{ .family = "AM64X", .data = &soc_data_am64x },
+	{ .family = "AM62X", .data = &soc_data_am62x },
+	{ .family = "AM62AX", .data = &soc_data_am62x },
+	{ /* sentinel */ }
+};
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain, *msi_domain;
+	const struct ti_sci_inta_soc_data *soc_data;
+	const struct soc_device_attribute *soc;
 	struct device_node *parent_node, *node;
 	struct ti_sci_inta_irq_domain *inta;
 	struct device *dev = &pdev->dev;
@@ -703,8 +838,18 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	}
 
 	INIT_LIST_HEAD(&inta->vint_list);
+	INIT_LIST_HEAD(&inta->resv_vint_list);
 	mutex_init(&inta->vint_mutex);
 
+	soc = soc_device_match(k3_soc_devices);
+	if (soc) {
+		soc_data = soc->data;
+		if (inta->num_vints > soc_data->events_list_size) {
+			inta->num_resv_vints = soc_data->events_list_size;
+			inta->resv_events = soc_data->events_list;
+		}
+	}
+
 	ret = ti_sci_inta_alloc_parent_irqs(domain);
 	if (ret) {
 		irq_domain_remove(msi_domain);

-- 
2.40.0

