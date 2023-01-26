Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4C67C316
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjAZDOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjAZDOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:14:43 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D7F64D88;
        Wed, 25 Jan 2023 19:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1674702882; x=1706238882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=F8qLeDa97kg2MOUQG0PUj/xnkvDv+6xRtHu1IQh2yrk=;
  b=wgQlATlJEuujq7MbnbfECyFhsRzkzQHCkRBTrYPSPCY46VCT4aN5LXhl
   KLQiDXha8lUhL+u4vFQZOtLRwYbHg5YDExIJ/OmHfFHAA9H9JNm5sHr3P
   Y6LCSNlzb44TyYMAN1DkeLzxkwuhNJLWilDzFRNu89I8Ih6Z3WnKOFvix
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Jan 2023 19:14:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 19:14:41 -0800
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 19:14:40 -0800
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [RFC PATCH v2 05/22] usb: xhci: Add XHCI APIs to support USB offloading
Date:   Wed, 25 Jan 2023 19:14:07 -0800
Message-ID: <20230126031424.14582-6-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126031424.14582-1-quic_wcheng@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some use cases, such as USB audio offloading, will allow for a DSP to take
over issuing USB transfers to the host controller.  In order for the DSP to
submit transfers for a particular endpoint, and to handle its events, the
client driver will need to query for some parameters allocated by XHCI.

- XHCI secondary interrupter event ring address
- XHCI transfer ring address (for a particular EP)
- Stop endpoint command API

Once the resources are handed off to the DSP, the offload begins, and the
main processor can enter idle.  When stopped, since there are no URBs
submitted from the main processor, the client will just issue a stop
endpoint command to halt any pending transfers.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci.c       | 130 ++++++++++++++++++++++++++++++++++
 include/linux/usb/xhci-intr.h |   8 +++
 2 files changed, 138 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 003c6cc2fb55..36d81ecdb890 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1580,6 +1580,136 @@ static int xhci_check_args(struct usb_hcd *hcd, struct usb_device *udev,
 	return 1;
 }
 
+int xhci_stop_endpoint(struct usb_device *udev,
+			struct usb_host_endpoint *ep)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
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
+EXPORT_SYMBOL_GPL(xhci_stop_endpoint);
+
+/* Retrieve the transfer ring base address for a specific endpoint. */
+phys_addr_t xhci_get_xfer_resource(struct usb_device *udev,
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
+	unsigned long flags;
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
+	spin_lock_irqsave(&xhci->lock, flags);
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
+		spin_unlock_irqrestore(&xhci->lock, flags);
+
+		return pa;
+	}
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_get_xfer_resource);
+
+phys_addr_t xhci_get_ir_resource(struct usb_device *udev, struct xhci_interrupter *ir)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	struct device *dev = hcd->self.sysdev;
+	struct sg_table sgt;
+	phys_addr_t pa;
+
+	if (!ir)
+		return 0;
+
+	dma_get_sgtable(dev, &sgt, ir->event_ring->first_seg->trbs,
+		ir->event_ring->first_seg->dma, TRB_SEGMENT_SIZE);
+
+	pa = page_to_phys(sg_page(sgt.sgl));
+	sg_free_table(&sgt);
+
+	return pa;
+}
+EXPORT_SYMBOL_GPL(xhci_get_ir_resource);
+
 static int xhci_configure_endpoint(struct xhci_hcd *xhci,
 		struct usb_device *udev, struct xhci_command *command,
 		bool ctx_change, bool must_succeed);
diff --git a/include/linux/usb/xhci-intr.h b/include/linux/usb/xhci-intr.h
index 738b0f0481a6..d42cc9a1e698 100644
--- a/include/linux/usb/xhci-intr.h
+++ b/include/linux/usb/xhci-intr.h
@@ -80,7 +80,15 @@ struct xhci_interrupter {
 	u64	s3_erst_dequeue;
 };
 
+/* Secondary interrupter */
 struct xhci_interrupter *
 xhci_create_secondary_interrupter(struct usb_hcd *hcd, int intr_num);
 void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct xhci_interrupter *ir);
+
+/* Offload */
+int xhci_stop_endpoint(struct usb_device *udev,
+			struct usb_host_endpoint *ep);
+phys_addr_t xhci_get_xfer_resource(struct usb_device *udev,
+					struct usb_host_endpoint *ep, dma_addr_t *dma);
+phys_addr_t xhci_get_ir_resource(struct usb_device *udev, struct xhci_interrupter *ir);
 #endif
