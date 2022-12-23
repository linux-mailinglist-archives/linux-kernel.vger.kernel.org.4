Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB53A655620
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiLWXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiLWXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:33:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9A1115A;
        Fri, 23 Dec 2022 15:33:10 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNUDdg012233;
        Fri, 23 Dec 2022 23:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=56WFTD+OVqzfybR4pR6w1aeWgdTDhgfwDjMFpUXZHrI=;
 b=YGYBRoprujiYXVTaNei8YlrMZKgLecjBWGlprVLaQa7jwlH3Aqvcl9n3WYpBbB9a0YGd
 UKVgR3oVbN6nNe8jowyEGsqiTgQryQi6LXp5JyueKHbwcMBv9AGRkvpwzMeejBE9dMcW
 JqwDTwnKJyHi5CYtM4Wi0HLwFOuErQ2vTjsrj2YNlCBVlz49veaiIRR3HPEe6wzrWJ9f
 Luft1Y6Ymc4ZIMp+jcYfwSzpztmY5AGz/0nJm4ZF4aNyb3uhcKAMhN3r61+pSVKAC3jD
 xWI8XVXz3KrRtD0A9yTtDw3F5jMRtapYuIHKJNBzfNq2HpfOXZNt/Ib+IcAncSHr0d+S 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mn8701hmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWjEg001237
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:45 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:45 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter support
Date:   Fri, 23 Dec 2022 15:31:53 -0800
Message-ID: <20221223233200.26089-8-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qq_9BtlHD13X2wOhMQqOt9_8Z0XOV-Lp
X-Proofpoint-ORIG-GUID: qq_9BtlHD13X2wOhMQqOt9_8Z0XOV-Lp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2212230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the XHCI operations for allocating and requesting for a secondary
interrupter.  The secondary interrupter can allow for events for a
particular endpoint to be routed to a separate event ring.  The event
routing is defined when submitting a transfer descriptor to the USB HW.
There is a specific field which denotes which interrupter ring to route the
event to when the transfer is completed.

An example use case, such as audio packet offloading can utilize a separate
event ring, so that these events can be routed to a different processor
within the system.  The processor would be able to independently submit
transfers and handle its completions without intervention from the main
processor.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-mem.c  | 219 ++++++++++++++++++++++++++++-------
 drivers/usb/host/xhci-plat.c |   2 +
 drivers/usb/host/xhci.c      | 169 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |  15 +++
 4 files changed, 363 insertions(+), 42 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 81ca2bc1f0be..d5cb4b82ad3d 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1835,6 +1835,7 @@ void xhci_free_erst(struct xhci_hcd *xhci, struct xhci_erst *erst)
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_sec *sec, *tmp;
 	int i, j, num_ports;
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
@@ -1846,6 +1847,16 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci->event_ring = NULL;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed event ring");
 
+	list_for_each_entry_safe(sec, tmp, &xhci->xhci_sec_list, list) {
+		list_del(&sec->list);
+		if (sec->event_ring) {
+			xhci_ring_free(xhci, sec->event_ring);
+			xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+						"Freed secondary ring %d", sec->intr_num);
+		}
+		kfree(sec);
+	}
+
 	if (xhci->cmd_ring)
 		xhci_ring_free(xhci, xhci->cmd_ring);
 	xhci->cmd_ring = NULL;
@@ -2087,18 +2098,18 @@ static int xhci_check_trb_in_td_math(struct xhci_hcd *xhci)
 	return 0;
 }
 
-static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
+static void xhci_set_hc_event_deq(struct xhci_hcd *xhci, struct xhci_ring *er,
+				struct xhci_intr_reg __iomem *ir_set)
 {
 	u64 temp;
 	dma_addr_t deq;
 
-	deq = xhci_trb_virt_to_dma(xhci->event_ring->deq_seg,
-			xhci->event_ring->dequeue);
+	deq = xhci_trb_virt_to_dma(er->deq_seg, er->dequeue);
 	if (!deq)
 		xhci_warn(xhci, "WARN something wrong with SW event ring "
 				"dequeue ptr.\n");
 	/* Update HC event ring dequeue pointer */
-	temp = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
+	temp = xhci_read_64(xhci, &ir_set->erst_dequeue);
 	temp &= ERST_PTR_MASK;
 	/* Don't clear the EHB bit (which is RW1C) because
 	 * there might be more events to service.
@@ -2108,7 +2119,7 @@ static void xhci_set_hc_event_deq(struct xhci_hcd *xhci)
 			"// Write event ring dequeue pointer, "
 			"preserving EHB bit");
 	xhci_write_64(xhci, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
-			&xhci->ir_set->erst_dequeue);
+			&ir_set->erst_dequeue);
 }
 
 static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
@@ -2375,10 +2386,159 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 	return 0;
 }
 
+static void xhci_reset_evt_ring_base(struct xhci_hcd *xhci, struct xhci_ring *er,
+		struct xhci_erst *erst, struct xhci_intr_reg __iomem *ir_set)
+{
+	u64	val_64;
+
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Set ERST entries to point to event ring.");
+	/* set the segment table base address */
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Set ERST base address for ir_set 0 = 0x%llx",
+			(unsigned long long)erst->erst_dma_addr);
+	val_64 = xhci_read_64(xhci, &ir_set->erst_base);
+	val_64 &= ERST_PTR_MASK;
+	pr_err("after clearing ptr = 0x%llx\n", val_64);
+	val_64 |= (erst->erst_dma_addr & (u64) ~ERST_PTR_MASK);
+		pr_err("after clearing ptr = 0x%llx\n", val_64);
+
+	xhci_write_64(xhci, val_64, &ir_set->erst_base);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"done.");
+	/* Set the event ring dequeue address */
+	xhci_set_hc_event_deq(xhci, er, ir_set);
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"Wrote ERST address to ir_set 0.");
+}
+
+void xhci_handle_sec_intr_events(struct xhci_hcd *xhci, struct xhci_ring *ring,
+	struct xhci_intr_reg __iomem *ir_set, struct xhci_sec *sec)
+{
+	union xhci_trb *erdp_trb, *current_trb;
+	struct xhci_segment	*seg;
+	u64 erdp_reg;
+	u32 iman_reg;
+	dma_addr_t deq;
+	unsigned long segment_offset;
+	struct xhci_erst *erst = &sec->erst;
+
+	/* disable irq, ack pending interrupt and ack all pending events */
+
+	iman_reg = readl_relaxed(&ir_set->irq_pending);
+	iman_reg &= ~IMAN_IE;
+	writel_relaxed(iman_reg, &ir_set->irq_pending);
+	iman_reg = readl_relaxed(&ir_set->irq_pending);
+	if (iman_reg & IMAN_IP)
+		writel_relaxed(iman_reg, &ir_set->irq_pending);
+
+	/* last acked event trb is in erdp reg  */
+	erdp_reg = xhci_read_64(xhci, &ir_set->erst_dequeue);
+	deq = (dma_addr_t)(erdp_reg & ~ERST_PTR_MASK);
+	if (!deq) {
+		pr_debug("%s: event ring handling not required\n", __func__);
+		return;
+	}
+
+	seg = ring->first_seg;
+	segment_offset = deq - seg->dma;
+
+	/* find out virtual address of the last acked event trb */
+	erdp_trb = current_trb = &seg->trbs[0] +
+				(segment_offset/sizeof(*current_trb));
+
+	/* read cycle state of the last acked trb to find out CCS */
+	ring->cycle_state = le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE;
+
+	while (1) {
+		/* last trb of the event ring: toggle cycle state */
+		if (current_trb == &seg->trbs[TRBS_PER_SEGMENT - 1]) {
+			ring->cycle_state ^= 1;
+			current_trb = &seg->trbs[0];
+		} else {
+			current_trb++;
+		}
+
+		/* cycle state transition */
+		if ((le32_to_cpu(current_trb->event_cmd.flags) & TRB_CYCLE) !=
+		    ring->cycle_state)
+			break;
+	}
+
+	if (erdp_trb != current_trb) {
+		deq = xhci_trb_virt_to_dma(ring->deq_seg, current_trb);
+		if (deq == 0)
+			xhci_warn(xhci,
+				"WARN invalid SW event ring dequeue ptr.\n");
+		/* Update HC event ring dequeue pointer */
+		erdp_reg &= ERST_PTR_MASK;
+		erdp_reg |= ((u64) deq & (u64) ~ERST_PTR_MASK);
+	}
+
+	/* Clear the event handler busy flag (RW1C); event ring is empty. */
+	erdp_reg |= ERST_EHB;
+	xhci_write_64(xhci, erdp_reg, &ir_set->erst_dequeue);
+
+	xhci_reset_evt_ring_base(xhci, ring, erst, ir_set);
+}
+
+static int xhci_event_ring_setup(struct xhci_hcd *xhci, struct xhci_ring **er,
+	struct xhci_erst *erst,	struct xhci_intr_reg __iomem *ir_set,
+	unsigned int intr_num, gfp_t flags)
+{
+	int ret;
+	unsigned int	val;
+
+	/*
+	 * Event ring setup: Allocate a normal ring, but also setup
+	 * the event ring segment table (ERST).  Section 4.9.3.
+	 */
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Allocating event ring");
+	*er = xhci_ring_alloc(xhci, ERST_NUM_SEGS, 1, TYPE_EVENT,
+					0, flags);
+	if (!*er)
+		return -ENOMEM;
+
+	ret = xhci_alloc_erst(xhci, *er, erst, flags);
+	if (ret)
+		return ret;
+
+	/* set ERST count with the number of entries in the segment table */
+	val = readl(&ir_set->erst_size);
+	val &= ERST_SIZE_MASK;
+	val |= ERST_NUM_SEGS;
+	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
+			"// Write ERST size = %i to ir_set 0 (some bits preserved)",
+			val);
+	writel(val, &ir_set->erst_size);
+
+	xhci_reset_evt_ring_base(xhci, *er, erst, ir_set);
+
+	return 0;
+}
+
+int xhci_mem_sec_init(struct xhci_hcd *xhci, struct xhci_sec *sec)
+{
+	int ret;
+
+	sec->ir_set = &xhci->run_regs->ir_set[sec->intr_num];
+	ret = xhci_event_ring_setup(xhci, &sec->event_ring,
+				&sec->erst, sec->ir_set, sec->intr_num, GFP_KERNEL);
+	if (ret) {
+		xhci_err(xhci, "sec event ring setup failed inter#%d\n",
+			sec->intr_num);
+		return ret;
+	}
+	sec->xhci = 0;
+
+	return 0;
+}
+
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 {
 	dma_addr_t	dma;
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
+	struct xhci_sec *sec;
 	unsigned int	val, val2;
 	u64		val_64;
 	u32		page_size, temp;
@@ -2497,46 +2657,23 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	/* Set ir_set to interrupt register set 0 */
 	xhci->ir_set = &xhci->run_regs->ir_set[0];
 
-	/*
-	 * Event ring setup: Allocate a normal ring, but also setup
-	 * the event ring segment table (ERST).  Section 4.9.3.
-	 */
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "// Allocating event ring");
-	xhci->event_ring = xhci_ring_alloc(xhci, ERST_NUM_SEGS, 1, TYPE_EVENT,
-					0, flags);
-	if (!xhci->event_ring)
-		goto fail;
-	if (xhci_check_trb_in_td_math(xhci) < 0)
+	ret = xhci_event_ring_setup(xhci, &xhci->event_ring, &xhci->erst, xhci->ir_set, 0, flags);
+	if (ret < 0)
 		goto fail;
 
-	ret = xhci_alloc_erst(xhci, xhci->event_ring, &xhci->erst, flags);
-	if (ret)
+	if (xhci_check_trb_in_td_math(xhci) < 0)
 		goto fail;
 
-	/* set ERST count with the number of entries in the segment table */
-	val = readl(&xhci->ir_set->erst_size);
-	val &= ERST_SIZE_MASK;
-	val |= ERST_NUM_SEGS;
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Write ERST size = %i to ir_set 0 (some bits preserved)",
-			val);
-	writel(val, &xhci->ir_set->erst_size);
-
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Set ERST entries to point to event ring.");
-	/* set the segment table base address */
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Set ERST base address for ir_set 0 = 0x%llx",
-			(unsigned long long)xhci->erst.erst_dma_addr);
-	val_64 = xhci_read_64(xhci, &xhci->ir_set->erst_base);
-	val_64 &= ERST_PTR_MASK;
-	val_64 |= (xhci->erst.erst_dma_addr & (u64) ~ERST_PTR_MASK);
-	xhci_write_64(xhci, val_64, &xhci->ir_set->erst_base);
-
-	/* Set the event ring dequeue address */
-	xhci_set_hc_event_deq(xhci);
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"Wrote ERST address to ir_set 0.");
+	/* Setup secondary interrupters (if any) */
+	INIT_LIST_HEAD(&xhci->xhci_sec_list);
+	for (i = 0; i < xhci->max_interrupters; i++) {
+		sec = kzalloc(sizeof(struct xhci_sec), GFP_KERNEL);
+		if (sec) {
+			sec->intr_num = i + 1;
+			xhci_mem_sec_init(xhci, sec);
+			list_add_tail(&sec->list, &xhci->xhci_sec_list);
+		}
+	}
 
 	xhci->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 5fb55bf19493..a1b6c17ecf74 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -303,6 +303,8 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
+		device_property_read_u8(tmpdev, "num-hc-interrupters",
+					 &xhci->max_interrupters);
 	}
 
 	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 79d7931c048a..353b06df2000 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2101,6 +2101,64 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 }
 EXPORT_SYMBOL_GPL(xhci_add_endpoint);
 
+static int xhci_stop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+						struct usb_host_endpoint *ep)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	unsigned int ep_index;
+	struct xhci_virt_device *virt_dev;
+	struct xhci_command *cmd;
+	unsigned long flags;
+	int ret = 0;
+
+	ret = xhci_check_args(hcd, udev, ep, 1, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	cmd = xhci_alloc_command(xhci, true, GFP_NOIO);
+	if (!cmd)
+		return -ENOMEM;
+
+	spin_lock_irqsave(&xhci->lock, flags);
+	virt_dev = xhci->devs[udev->slot_id];
+	if (!virt_dev) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ep_index = xhci_get_endpoint_index(&ep->desc);
+	if (virt_dev->eps[ep_index].ring &&
+			virt_dev->eps[ep_index].ring->dequeue) {
+		ret = xhci_queue_stop_endpoint(xhci, cmd, udev->slot_id,
+				ep_index, 0);
+		if (ret)
+			goto err;
+
+		xhci_ring_cmd_db(xhci);
+		spin_unlock_irqrestore(&xhci->lock, flags);
+
+		/* Wait for stop endpoint command to finish */
+		wait_for_completion(cmd->completion);
+
+		if (cmd->status == COMP_COMMAND_ABORTED ||
+				cmd->status == COMP_STOPPED) {
+			xhci_warn(xhci,
+				"stop endpoint command timeout for ep%d%s\n",
+				usb_endpoint_num(&ep->desc),
+				usb_endpoint_dir_in(&ep->desc) ? "in" : "out");
+			ret = -ETIME;
+				}
+		goto free_cmd;
+	}
+
+err:
+	spin_unlock_irqrestore(&xhci->lock, flags);
+free_cmd:
+	xhci_free_command(xhci, cmd);
+
+	return ret;
+}
+
 static void xhci_zero_in_ctx(struct xhci_hcd *xhci, struct xhci_virt_device *virt_dev)
 {
 	struct xhci_input_control_ctx *ctrl_ctx;
@@ -5278,6 +5336,110 @@ static void xhci_hcd_init_usb3_data(struct xhci_hcd *xhci, struct usb_hcd *hcd)
 	xhci->usb3_rhub.hcd = hcd;
 }
 
+/*
+ * Free a XHCI interrupter that was previously allocated.  Ensure that the
+ * event ring which was used is reset to the proper state, and recycle the
+ * interrupter for next use by clearing the XHCI reference.
+ */
+static int xhci_free_interrupter(struct usb_hcd *hcd, int intr_num)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_sec *sec;
+
+	mutex_lock(&xhci->mutex);
+	list_for_each_entry(sec, &xhci->xhci_sec_list, list) {
+		if (sec->intr_num == intr_num) {
+			xhci_handle_sec_intr_events(xhci, sec->event_ring, sec->ir_set, sec);
+			sec->xhci = 0;
+		}
+	}
+	mutex_unlock(&xhci->mutex);
+
+	return 0;
+}
+
+/*
+ * Reserve a XHCI interrupter, and pass the base address of the event ring for
+ * this pariticular interrupter back to the client.
+ */
+static phys_addr_t xhci_update_interrupter(struct usb_hcd *hcd, int intr_num,
+								dma_addr_t *dma)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct device *dev = hcd->self.sysdev;
+	struct sg_table sgt;
+	phys_addr_t pa;
+	struct xhci_sec *sec;
+
+	if (!HCD_RH_RUNNING(hcd) ||
+			(xhci->xhc_state & XHCI_STATE_HALTED))
+		return 0;
+
+	mutex_lock(&xhci->mutex);
+	list_for_each_entry(sec, &xhci->xhci_sec_list, list) {
+		if (sec->intr_num == intr_num) {
+			dma_get_sgtable(dev, &sgt, sec->event_ring->first_seg->trbs,
+				sec->event_ring->first_seg->dma, TRB_SEGMENT_SIZE);
+
+			*dma = sec->event_ring->first_seg->dma;
+
+			pa = page_to_phys(sg_page(sgt.sgl));
+			sg_free_table(&sgt);
+			sec->xhci = xhci;
+			mutex_unlock(&xhci->mutex);
+
+			return pa;
+		}
+	}
+	mutex_unlock(&xhci->mutex);
+
+	return 0;
+}
+
+/* Retrieve the transfer ring base address for a specific endpoint. */
+static phys_addr_t xhci_get_xfer_resource(struct usb_device *udev,
+					struct usb_host_endpoint *ep, dma_addr_t *dma)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct device *dev = hcd->self.sysdev;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct sg_table sgt;
+	phys_addr_t pa;
+	int ret;
+	unsigned int ep_index;
+	struct xhci_virt_device *virt_dev;
+
+	if (!HCD_RH_RUNNING(hcd))
+		return 0;
+
+	ret = xhci_check_args(hcd, udev, ep, 1, true, __func__);
+	if (ret <= 0) {
+		xhci_err(xhci, "%s: invalid args\n", __func__);
+		return 0;
+	}
+
+	virt_dev = xhci->devs[udev->slot_id];
+	ep_index = xhci_get_endpoint_index(&ep->desc);
+
+	if (virt_dev->eps[ep_index].ring &&
+		virt_dev->eps[ep_index].ring->first_seg) {
+
+		dma_get_sgtable(dev, &sgt,
+			virt_dev->eps[ep_index].ring->first_seg->trbs,
+			virt_dev->eps[ep_index].ring->first_seg->dma,
+			TRB_SEGMENT_SIZE);
+
+		*dma = virt_dev->eps[ep_index].ring->first_seg->dma;
+
+		pa = page_to_phys(sg_page(sgt.sgl));
+		sg_free_table(&sgt);
+
+		return pa;
+	}
+
+	return 0;
+}
+
 int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 {
 	struct xhci_hcd		*xhci;
@@ -5321,6 +5483,8 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
 
 	xhci->quirks |= quirks;
+	xhci->max_interrupters = min_t(u32, HCS_MAX_INTRS(xhci->hcs_params1),
+		      xhci->max_interrupters);
 
 	get_quirks(dev, xhci);
 
@@ -5454,7 +5618,10 @@ static const struct hc_driver xhci_hc_driver = {
 	.enable_device =	xhci_enable_device,
 	.update_hub_device =	xhci_update_hub_device,
 	.reset_device =		xhci_discover_or_reset_device,
-
+	.update_interrupter =	xhci_update_interrupter,
+	.free_interrupter =	xhci_free_interrupter,
+	.get_transfer_resource =	xhci_get_xfer_resource,
+	.stop_endpoint =	xhci_stop_endpoint,
 	/*
 	 * scheduling support
 	 */
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c9f06c5e4e9d..2e694686c849 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1926,6 +1926,7 @@ struct xhci_hcd {
 	struct dentry		*debugfs_root;
 	struct dentry		*debugfs_slots;
 	struct list_head	regset_list;
+	struct list_head	xhci_sec_list;
 
 	void			*dbc;
 	/* platform-specific data -- must come last */
@@ -1945,6 +1946,17 @@ struct xhci_driver_overrides {
 	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
 };
 
+struct xhci_sec {
+	struct xhci_ring	*event_ring;
+	struct xhci_erst	erst;
+	/* secondary interrupter */
+	struct xhci_intr_reg __iomem *ir_set;
+	struct xhci_hcd		*xhci;
+	int			intr_num;
+
+	struct list_head	list;
+};
+
 #define	XHCI_CFC_DELAY		10
 
 /* convert between an HCD pointer and the corresponding EHCI_HCD */
@@ -2034,6 +2046,9 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
+void xhci_handle_sec_intr_events(struct xhci_hcd *xhci,
+		struct xhci_ring *ring, struct xhci_intr_reg __iomem *ir_set, struct xhci_sec *sec);
+int xhci_mem_sec_init(struct xhci_hcd *xhci, struct xhci_sec *sec);
 void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
