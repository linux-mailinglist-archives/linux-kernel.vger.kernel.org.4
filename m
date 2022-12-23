Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6065560D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLWXdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiLWXdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:33:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015510FE1;
        Fri, 23 Dec 2022 15:33:10 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BNNVeMA006265;
        Fri, 23 Dec 2022 23:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=fkNAURL5gttqswe5kK5CQ4y4LJGceGJEIBEg9TOK9Gg=;
 b=kly7uSxnaWatqqC/1AdLckQHMBdWUfA67P+qCNK1u1coCyrZ9Z/gDJLV2gKX2Mz9YC4Q
 T/LOiwMEcOpjyntnRvcS8P9i60d2HBmxuvmOIXts1PrGRGvD7DeU+TS68c5xEU/NgGdZ
 DxUqgqFsIKFQy2Wd5D6g0q+ji2MquD10OVPi7vMlz1jdEpj2eZ2DQubW6zqF1x+SL/69
 iX7VSn/4R4chGRSz7G6lWy8MIwYM7fR/KQGL0Bp0C5mvZLsonmK9V5wEsS6S/pY7NrdW
 hxEjQmns5XJ3Z45bwemnpHutOdIrFwtF0z0U0dyEM6nx5gHTcr1OSlpqqSK4skmPMzqf IQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm3cjx2m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:46 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWjsh009844
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Dec 2022 23:32:45 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:44 -0800
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
Subject: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for interrupter management
Date:   Fri, 23 Dec 2022 15:31:52 -0800
Message-ID: <20221223233200.26089-7-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: Tn96v1UrYOBAhISXPCFgbKG2XHIA2fSb
X-Proofpoint-ORIG-GUID: Tn96v1UrYOBAhISXPCFgbKG2XHIA2fSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=906
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For USB HCDs that can support multiple USB interrupters, expose functions
that class drivers can utilize for setting up secondary interrupters.
Class drivers can pass this information to its respective clients, i.e.
a dedicated DSP.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/core/hcd.c  | 86 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h     |  7 ++++
 include/linux/usb/hcd.h | 16 +++++++-
 3 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 8300baedafd2..90ead90faf1d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1579,6 +1579,92 @@ int usb_hcd_submit_urb (struct urb *urb, gfp_t mem_flags)
 	return status;
 }
 
+/**
+ * usb_free_interrupter - free an interrupter
+ * @udev: usb device which requested the interrupter
+ * @intr_num: interrupter number to free
+ *
+ * Release the USB HCD interrupter that was reserved by a USB class driver.
+ **/
+int usb_free_interrupter(struct usb_device *udev, int intr_num)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int ret = 0;
+
+	if (hcd->driver->free_interrupter)
+		ret = hcd->driver->free_interrupter(hcd, intr_num);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_free_interrupter);
+
+/**
+ * usb_set_interruper - Reserve an interrupter
+ * @udev: usb device which requested the interrupter
+ * @intr_num: interrupter number to reserve
+ * @dma: iova address to event ring
+ *
+ * Request for a specific interrupter to be reserved for a USB class driver.
+ * This will return the base address to the event ring that was allocated to
+ * the specific interrupter.
+ **/
+phys_addr_t usb_set_interruper(struct usb_device *udev, int intr_num,
+							dma_addr_t *dma)
+{
+	struct usb_hcd *hcd;
+	phys_addr_t pa = 0;
+
+	hcd = bus_to_hcd(udev->bus);
+	if (hcd->driver->update_interrupter)
+		pa = hcd->driver->update_interrupter(hcd, intr_num, dma);
+
+	return pa;
+}
+EXPORT_SYMBOL_GPL(usb_set_interruper);
+
+/**
+ * usb_hcd_get_transfer_resource - Retrieve USB EP resource information
+ * @udev: usb device
+ * @ep: usb ep to retrieve resource information
+ * @dma: iova address to transfer resource
+ *
+ * Request for USB EP transfer resource which is used for submitting
+ * transfers to the USB HCD.
+ **/
+phys_addr_t usb_hcd_get_transfer_resource(struct usb_device *udev,
+				struct usb_host_endpoint *ep, dma_addr_t *dma)
+{
+	struct usb_hcd *hcd;
+	phys_addr_t pa = 0;
+
+	hcd = bus_to_hcd(udev->bus);
+	if (hcd->driver->get_transfer_resource)
+		pa = hcd->driver->get_transfer_resource(udev, ep, dma);
+
+	return pa;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_get_transfer_resource);
+
+/**
+ * usb_hcd_stop_endpoint - Halt USB EP transfers
+ * @udev: usb device
+ * @ep: usb ep to stop
+ *
+ * Stop pending transfers on a specific USB endpoint.
+ **/
+int usb_hcd_stop_endpoint(struct usb_device *udev,
+					struct usb_host_endpoint *ep)
+{
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int ret = 0;
+
+	if (hcd->driver->stop_endpoint)
+		ret = hcd->driver->stop_endpoint(hcd, udev, ep);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_hcd_stop_endpoint);
+
 /*-------------------------------------------------------------------------*/
 
 /* this makes the hcd giveback() the urb more quickly, by kicking it
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d4afeeec1e1a..2f71cd4fb6e0 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1724,6 +1724,13 @@ static inline void usb_fill_int_urb(struct urb *urb,
 	urb->start_frame = -1;
 }
 
+extern int usb_free_interrupter(struct usb_device *udev, int intr_num);
+extern phys_addr_t usb_set_interruper(struct usb_device *udev,
+						int intr_num, dma_addr_t *dma);
+extern int usb_hcd_stop_endpoint(struct usb_device *udev,
+						struct usb_host_endpoint *ep);
+extern phys_addr_t usb_hcd_get_transfer_resource(struct usb_device *udev,
+						struct usb_host_endpoint *ep, dma_addr_t *dma);
 extern void usb_init_urb(struct urb *urb);
 extern struct urb *usb_alloc_urb(int iso_packets, gfp_t mem_flags);
 extern void usb_free_urb(struct urb *urb);
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index b51c07111729..f5bce80b2e40 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -343,7 +343,21 @@ struct hc_driver {
 	int	(*free_streams)(struct usb_hcd *hcd, struct usb_device *udev,
 		struct usb_host_endpoint **eps, unsigned int num_eps,
 		gfp_t mem_flags);
-
+	/* Frees an interrupter from the current client, and makes it available
+	 * for use.
+	 */
+	int (*free_interrupter)(struct usb_hcd *hcd, int intr_num);
+	/* Request an interrupter from the current allocated pool.  Will provide
+	 * the address to the allocated ring.
+	 */
+	phys_addr_t (*update_interrupter)(struct usb_hcd *hcd, int intr_num,
+		dma_addr_t *dma);
+	/* Fetch transfer/ep ring address */
+	phys_addr_t (*get_transfer_resource)(struct usb_device *udev,
+		struct usb_host_endpoint *ep, dma_addr_t *dma);
+	/* Stop transfers on a particular endpoint */
+	int	(*stop_endpoint)(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep);
 	/* Bandwidth computation functions */
 	/* Note that add_endpoint() can only be called once per endpoint before
 	 * check_bandwidth() or reset_bandwidth() must be called.
