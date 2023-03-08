Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A10A6B1709
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCHX7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHX6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:58:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FCA7431D;
        Wed,  8 Mar 2023 15:58:28 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328JCXGw007062;
        Wed, 8 Mar 2023 23:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=AGKFpud5n9xb69lXZENMciCrjzh5duG5c70DDb9LKyg=;
 b=S+SH/jkQjvy3EFhXvw0Zh8r2iJ/BS5hjylc5SJkad4+Boc16wBbjbqBbDSN2IZoDyOvB
 iXvXLd9bk7RxY3HXsPiJUYN27Oiqdh97sj3g4iZfhhNUvjfqUlkDC04eqMFE4/EW7b/6
 1UGkpP0sdAJULZ0bm1r4Wk8CP2Vv+0SwQrfEkU5c3k3B7ZC3VJGeIjuyaBikD7h+GeOM
 jjchK671m+qWgSjYdfXD5fdJL2xB5yVBsioaxRR0iQqtyd46yEahgamLLXwa0MxZxeOV
 0yJLHhQnE7Gd3k2uCIPWMHwMXxbcFc3exWuXwEEWyoJKgSiV3wRsCye4BRdPwPArr+8/ pQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6vnah888-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:58:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Nw5OT016228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:58:05 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:58:04 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 01/28] xhci: Add support to allocate several interrupters
Date:   Wed, 8 Mar 2023 15:57:24 -0800
Message-ID: <20230308235751.495-2-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308235751.495-1-quic_wcheng@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MxOQSrorIh_IQUiIECCzaS5Ymllp8KAS
X-Proofpoint-ORIG-GUID: MxOQSrorIh_IQUiIECCzaS5Ymllp8KAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1011 mlxlogscore=708 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Introduce xHCI APIs to allow for clients to allocate and free
interrupters.  This allocates an array of interrupters, which is based on
the max_interrupters parameter.  The primary interrupter is set as the
first entry in the array, and secondary interrupters following after.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-debugfs.c |  2 +-
 drivers/usb/host/xhci-mem.c     | 97 +++++++++++++++++++++++++++++++--
 drivers/usb/host/xhci-ring.c    |  2 +-
 drivers/usb/host/xhci.c         | 51 +++++++++++------
 drivers/usb/host/xhci.h         |  2 +-
 include/linux/usb/xhci-intr.h   | 86 +++++++++++++++++++++++++++++
 6 files changed, 214 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/usb/xhci-intr.h

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 0bc7fe11f749..06a42b68446f 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -692,7 +692,7 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
 				     "command-ring",
 				     xhci->debugfs_root);
 
-	xhci_debugfs_create_ring_dir(xhci, &xhci->interrupter->event_ring,
+	xhci_debugfs_create_ring_dir(xhci, &xhci->interrupters[0]->event_ring,
 				     "event-ring",
 				     xhci->debugfs_root);
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d0a9467aa5fc..c303a8e1a33d 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1858,6 +1858,30 @@ xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	kfree(ir);
 }
 
+/*
+ * Free a secondary interrupter slot.  This will allow for other users to request for
+ * the secondary interrupter in the future.
+ */
+void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct xhci_interrupter *ir)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	unsigned int intr_num;
+	unsigned long flags;
+
+	if (!ir || !ir->intr_num || ir->intr_num > xhci->max_interrupters) {
+		xhci_dbg(xhci, "Invalid secondary interrupter, can't remove\n");
+		return;
+	}
+
+	/* fixme, shuld we check xhci->interrupter[intr_num] == ir */
+	intr_num = ir->intr_num;
+	xhci_free_interrupter(xhci, ir);
+	spin_lock_irqsave(&xhci->lock, flags);
+	xhci->interrupters[intr_num] = NULL;
+	spin_unlock_irqrestore(&xhci->lock, flags);
+}
+EXPORT_SYMBOL_GPL(xhci_remove_secondary_interrupter);
+
 void xhci_mem_cleanup(struct xhci_hcd *xhci)
 {
 	struct device	*dev = xhci_to_hcd(xhci)->self.sysdev;
@@ -1865,8 +1889,15 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 
 	cancel_delayed_work_sync(&xhci->cmd_timer);
 
-	xhci_free_interrupter(xhci, xhci->interrupter);
-	xhci->interrupter = NULL;
+	for (i = 1; i < xhci->max_interrupters; i++) {
+		if (xhci->interrupters[i])
+			xhci_remove_secondary_interrupter(xhci_to_hcd(xhci),
+							  xhci->interrupters[i]);
+	}
+
+	/* free the primary interrupter, interrupter number 0 */
+	xhci_free_interrupter(xhci, xhci->interrupters[0]);
+	xhci->interrupters[0] = NULL;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed primary event ring");
 
 	if (xhci->cmd_ring)
@@ -1937,6 +1968,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	for (i = 0; i < xhci->num_port_caps; i++)
 		kfree(xhci->port_caps[i].psi);
 	kfree(xhci->port_caps);
+	kfree(xhci->interrupters);
 	xhci->num_port_caps = 0;
 
 	xhci->usb2_rhub.ports = NULL;
@@ -1945,6 +1977,7 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	xhci->rh_bw = NULL;
 	xhci->ext_caps = NULL;
 	xhci->port_caps = NULL;
+	xhci->interrupters = NULL;
 
 	xhci->page_size = 0;
 	xhci->page_shift = 0;
@@ -2258,7 +2291,7 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int intr_num, gfp_t flags
 		return NULL;
 	}
 
-	if (xhci->interrupter) {
+	if (xhci->interrupters[intr_num]) {
 		xhci_warn(xhci, "Can't allocate already set up interrupter %d\n", intr_num);
 		return NULL;
 	}
@@ -2305,6 +2338,56 @@ xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int intr_num, gfp_t flags
 	return NULL;
 }
 
+/*
+ * Allocate a XHCI secondary interrupter slot.  If the user requests a specific intr
+ * number, then check if the slot is available.  Otherwise, fetch the first available
+ * entry within the interrupter array.
+ */
+struct xhci_interrupter *
+xhci_create_secondary_interrupter(struct usb_hcd *hcd, int intr_num)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_interrupter *ir;
+	unsigned int i;
+	unsigned int idx = 0;
+	unsigned long flags;
+
+	if (!xhci->interrupters || intr_num > xhci->max_interrupters)
+		return NULL;
+
+	spin_lock_irqsave(&xhci->lock, flags);
+	/* find available secondary interrupter, interrupter 0 is reserved for primary */
+	if (intr_num > 0) {
+		idx = intr_num;
+	} else {
+		for (i = 1; i < xhci->max_interrupters; i++) {
+			if (xhci->interrupters[i] == NULL) {
+				idx = i;
+				break;
+			}
+		}
+	}
+
+	if (idx > 0) {
+		ir = xhci_alloc_interrupter(xhci, idx, GFP_KERNEL);
+		if (!ir) {
+			spin_unlock_irqrestore(&xhci->lock, flags);
+			return NULL;
+		}
+		ir->intr_num = idx;
+		xhci->interrupters[idx] = ir;
+		spin_unlock_irqrestore(&xhci->lock, flags);
+
+		return ir;
+	}
+	spin_unlock_irqrestore(&xhci->lock, flags);
+	xhci_warn(xhci, "Can't add new secondary interrupter, max interrupters %d\n",
+		  xhci->max_interrupters);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(xhci_create_secondary_interrupter);
+
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 {
 	dma_addr_t	dma;
@@ -2429,8 +2512,12 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	/* allocate and set up primary interrupter with an event ring. */
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 		       "Allocating primary event ring");
-	xhci->interrupter = xhci_alloc_interrupter(xhci, 0, flags);
-	if (!xhci->interrupter)
+
+	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
+					  flags, dev_to_node(dev));
+
+	xhci->interrupters[0] = xhci_alloc_interrupter(xhci, 0, flags);
+	if (!xhci->interrupters[0])
 		goto fail;
 
 	xhci->isoc_bei_interval = AVOID_BEI_INTERVAL_MAX;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index eb788c60c1c0..445a79f36a60 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3054,7 +3054,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	writel(status, &xhci->op_regs->status);
 
 	/* This is the handler of the primary interrupter */
-	ir = xhci->interrupter;
+	ir = xhci->interrupters[0];
 	if (!hcd->msi_enabled) {
 		u32 irq_pending;
 		irq_pending = readl(&ir->ir_set->irq_pending);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6183ce8574b1..88435b9cd66e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -638,7 +638,7 @@ static int xhci_init(struct usb_hcd *hcd)
 
 static int xhci_run_finished(struct xhci_hcd *xhci)
 {
-	struct xhci_interrupter *ir = xhci->interrupter;
+	struct xhci_interrupter *ir = xhci->interrupters[0];
 	unsigned long	flags;
 	u32		temp;
 
@@ -690,7 +690,7 @@ int xhci_run(struct usb_hcd *hcd)
 	u64 temp_64;
 	int ret;
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct xhci_interrupter *ir = xhci->interrupter;
+	struct xhci_interrupter *ir = xhci->interrupters[0];
 	/* Start the xHCI host controller running only after the USB 2.0 roothub
 	 * is setup.
 	 */
@@ -758,7 +758,7 @@ static void xhci_stop(struct usb_hcd *hcd)
 {
 	u32 temp;
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct xhci_interrupter *ir = xhci->interrupter;
+	struct xhci_interrupter *ir = xhci->interrupters[0];
 
 	mutex_lock(&xhci->mutex);
 
@@ -857,36 +857,51 @@ EXPORT_SYMBOL_GPL(xhci_shutdown);
 #ifdef CONFIG_PM
 static void xhci_save_registers(struct xhci_hcd *xhci)
 {
-	struct xhci_interrupter *ir = xhci->interrupter;
+	struct xhci_interrupter *ir;
+	unsigned int i;
 
 	xhci->s3.command = readl(&xhci->op_regs->command);
 	xhci->s3.dev_nt = readl(&xhci->op_regs->dev_notification);
 	xhci->s3.dcbaa_ptr = xhci_read_64(xhci, &xhci->op_regs->dcbaa_ptr);
 	xhci->s3.config_reg = readl(&xhci->op_regs->config_reg);
 
-	if (!ir)
-		return;
+	/* save both primary and all secondary interrupters */
+	/* fixme, shold we lock  to prevent race with remove secondary interrupter? */
+	for (i = 0; i < xhci->max_interrupters; i++) {
+		ir = xhci->interrupters[i];
+		if (!ir)
+			continue;
 
-	ir->s3_erst_size = readl(&ir->ir_set->erst_size);
-	ir->s3_erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
-	ir->s3_erst_dequeue = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
-	ir->s3_irq_pending = readl(&ir->ir_set->irq_pending);
-	ir->s3_irq_control = readl(&ir->ir_set->irq_control);
+		ir->s3_erst_size = readl(&ir->ir_set->erst_size);
+		ir->s3_erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
+		ir->s3_erst_dequeue = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
+		ir->s3_irq_pending = readl(&ir->ir_set->irq_pending);
+		ir->s3_irq_control = readl(&ir->ir_set->irq_control);
+	}
 }
 
 static void xhci_restore_registers(struct xhci_hcd *xhci)
 {
-	struct xhci_interrupter *ir = xhci->interrupter;
+	struct xhci_interrupter *ir;
+	unsigned int i;
 
 	writel(xhci->s3.command, &xhci->op_regs->command);
 	writel(xhci->s3.dev_nt, &xhci->op_regs->dev_notification);
 	xhci_write_64(xhci, xhci->s3.dcbaa_ptr, &xhci->op_regs->dcbaa_ptr);
 	writel(xhci->s3.config_reg, &xhci->op_regs->config_reg);
-	writel(ir->s3_erst_size, &ir->ir_set->erst_size);
-	xhci_write_64(xhci, ir->s3_erst_base, &ir->ir_set->erst_base);
-	xhci_write_64(xhci, ir->s3_erst_dequeue, &ir->ir_set->erst_dequeue);
-	writel(ir->s3_irq_pending, &ir->ir_set->irq_pending);
-	writel(ir->s3_irq_control, &ir->ir_set->irq_control);
+
+	/* FIXME should we lock to protect against freeing of interrupters */
+	for (i = 0; i < xhci->max_interrupters; i++) {
+		ir = xhci->interrupters[i];
+		if (!ir)
+			continue;
+
+		writel(ir->s3_erst_size, &ir->ir_set->erst_size);
+		xhci_write_64(xhci, ir->s3_erst_base, &ir->ir_set->erst_base);
+		xhci_write_64(xhci, ir->s3_erst_dequeue, &ir->ir_set->erst_dequeue);
+		writel(ir->s3_irq_pending, &ir->ir_set->irq_pending);
+		writel(ir->s3_irq_control, &ir->ir_set->irq_control);
+	}
 }
 
 static void xhci_set_cmd_ring_deq(struct xhci_hcd *xhci)
@@ -1251,7 +1266,7 @@ int xhci_resume(struct xhci_hcd *xhci, bool hibernated)
 		xhci_dbg(xhci, "// Disabling event ring interrupts\n");
 		temp = readl(&xhci->op_regs->status);
 		writel((temp & ~0x1fff) | STS_EINT, &xhci->op_regs->status);
-		xhci_disable_interrupter(xhci->interrupter);
+		xhci_disable_interrupter(xhci->interrupters[0]);
 
 		xhci_dbg(xhci, "cleaning up memory\n");
 		xhci_mem_cleanup(xhci);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 786002bb35db..43118ce83cca 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1800,7 +1800,7 @@ struct xhci_hcd {
 	struct reset_control *reset;
 	/* data structures */
 	struct xhci_device_context_array *dcbaa;
-	struct xhci_interrupter *interrupter;
+	struct xhci_interrupter **interrupters;
 	struct xhci_ring	*cmd_ring;
 	unsigned int            cmd_ring_state;
 #define CMD_RING_STATE_RUNNING         (1 << 0)
diff --git a/include/linux/usb/xhci-intr.h b/include/linux/usb/xhci-intr.h
new file mode 100644
index 000000000000..738b0f0481a6
--- /dev/null
+++ b/include/linux/usb/xhci-intr.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_XHCI_INTR_H
+#define __LINUX_XHCI_INTR_H
+
+#include <linux/kernel.h>
+
+struct xhci_erst_entry {
+	/* 64-bit event ring segment address */
+	__le64	seg_addr;
+	__le32	seg_size;
+	/* Set to zero */
+	__le32	rsvd;
+};
+
+enum xhci_ring_type {
+	TYPE_CTRL = 0,
+	TYPE_ISOC,
+	TYPE_BULK,
+	TYPE_INTR,
+	TYPE_STREAM,
+	TYPE_COMMAND,
+	TYPE_EVENT,
+};
+
+struct xhci_erst {
+	struct xhci_erst_entry	*entries;
+	unsigned int		num_entries;
+	/* xhci->event_ring keeps track of segment dma addresses */
+	dma_addr_t		erst_dma_addr;
+	/* Num entries the ERST can contain */
+	unsigned int		erst_size;
+};
+
+struct xhci_segment {
+	union xhci_trb		*trbs;
+	/* private to HCD */
+	struct xhci_segment	*next;
+	dma_addr_t		dma;
+	/* Max packet sized bounce buffer for td-fragmant alignment */
+	dma_addr_t		bounce_dma;
+	void			*bounce_buf;
+	unsigned int		bounce_offs;
+	unsigned int		bounce_len;
+};
+
+struct xhci_ring {
+	struct xhci_segment	*first_seg;
+	struct xhci_segment	*last_seg;
+	union  xhci_trb		*enqueue;
+	struct xhci_segment	*enq_seg;
+	union  xhci_trb		*dequeue;
+	struct xhci_segment	*deq_seg;
+	struct list_head	td_list;
+	/*
+	 * Write the cycle state into the TRB cycle field to give ownership of
+	 * the TRB to the host controller (if we are the producer), or to check
+	 * if we own the TRB (if we are the consumer).  See section 4.9.1.
+	 */
+	u32			cycle_state;
+	unsigned int		stream_id;
+	unsigned int		num_segs;
+	unsigned int		num_trbs_free;
+	unsigned int		num_trbs_free_temp;
+	unsigned int		bounce_buf_len;
+	enum xhci_ring_type	type;
+	bool			last_td_was_short;
+	struct radix_tree_root	*trb_address_map;
+};
+
+struct xhci_interrupter {
+	struct xhci_ring	*event_ring;
+	struct xhci_erst	erst;
+	struct xhci_intr_reg __iomem *ir_set;
+	unsigned int		intr_num;
+	/* For interrupter registers save and restore over suspend/resume */
+	u32	s3_irq_pending;
+	u32	s3_irq_control;
+	u32	s3_erst_size;
+	u64	s3_erst_base;
+	u64	s3_erst_dequeue;
+};
+
+struct xhci_interrupter *
+xhci_create_secondary_interrupter(struct usb_hcd *hcd, int intr_num);
+void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct xhci_interrupter *ir);
+#endif
