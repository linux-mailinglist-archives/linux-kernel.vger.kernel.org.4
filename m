Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82B56B1749
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjCHX75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCHX6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:58:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A38B99D42;
        Wed,  8 Mar 2023 15:58:34 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328NqAQQ025086;
        Wed, 8 Mar 2023 23:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=E+pqPAwcnkHfZYzuNYYRihd/aAHdVqQj3NDabKlQIYQ=;
 b=BfS1UIyGpvs7v0lSEV5SgOvDQcE3Y3y8ZyLE/lrzlj/F1vowMDFoH0mdIzaz7dg1Zfg2
 KRq8j91FzpPt7kCcCBti/vdpIKyHkNY4lL5o8cCfWGWvboQ2R5tBz16A77dmfiriaZAQ
 6NmS5g1JeOIrK5CS+YtrWCX7jUsqtjDhNGWT4xFjLt9MDs/snZSaYefSXo4vWrnr47Vd
 Gx/8A9wYC0J8SFHEMw8f0E6JA7vDy6w2auizPqPhHIVa2BQ3DqslcRknfB10f9odhr9o
 aSxDira3anTlQ2c/FtSO6qQmzvlCRV/SDswATuqnXGDRbnFcV55WaVd3l1Hk4xobNYeU 6g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p74drg06q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 23:58:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 328Nw53g016236
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 23:58:05 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:58:05 -0800
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
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v3 02/28] usb: xhci: Add XHCI APIs to support USB offloading
Date:   Wed, 8 Mar 2023 15:57:25 -0800
Message-ID: <20230308235751.495-3-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: Fvyfax3S9J9PSlw7nTzQ9gyTQZrFuzh9
X-Proofpoint-ORIG-GUID: Fvyfax3S9J9PSlw7nTzQ9gyTQZrFuzh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=972
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303080200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 88435b9cd66e..5c6b3d8f834c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1603,6 +1603,136 @@ static int xhci_check_args(struct usb_hcd *hcd, struct usb_device *udev,
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
