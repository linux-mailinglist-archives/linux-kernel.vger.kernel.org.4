Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562306D7D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbjDEM66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjDEM65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:58:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537185B9D;
        Wed,  5 Apr 2023 05:58:48 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CT5C4022333;
        Wed, 5 Apr 2023 12:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9KdPXmq9kA9RtOtLA/bOSFo6AIujo5akpbqbGsbKHqw=;
 b=KizBBytH4hgYeGBMoG9R6pzNwkMdMvfFvdm2qvI4/duH/wQNTJI/mO67RQdqcsScUK97
 jmpSgVpfHw32Y3dduzq3/nUa+OzlqeDCcx4GVl8JfyVx5BEugmfP1ot2RRMYBape97E+
 FMEOBx158h5nBjASDBa+fvOWGG5TOVWrVx9GeriHj9jaF/ksdhuVcpgg/dSSlimCbtUw
 RxT64FWzXcgm0s9H29C5fh14sStMG2Nt5rCQ0+vrvRW2zUmQtGiN5km6zGdzVsHrAv84
 mkkZ0zmR+Cq6h74SKeuNlucOEufBF8K2xanHUWrM7mYrt+4Pr2raZCPYXH3jHnzo5nxO rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prmkmu1p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 12:58:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335Cwbr6016436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 12:58:37 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 05:58:31 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v6 2/8] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date:   Wed, 5 Apr 2023 18:27:53 +0530
Message-ID: <20230405125759.4201-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405125759.4201-1-quic_kriskura@quicinc.com>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kh_h45vc-9MSE9lB8iwX9AVOLClBamdx
X-Proofpoint-ORIG-GUID: kh_h45vc-9MSE9lB8iwX9AVOLClBamdx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_07,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050115
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently host-only capable DWC3 controllers support Multiport. Temporarily
map XHCI address space for host-only controllers and parse XHCI Extended
Capabilities registers to read number of usb2 ports and usb3 ports present on
multiport controller. Each USB Port is atleast HS capable.

The port info for usb2 and usb3 phy are identified as num_usb2_ports and
num_usb3_ports. The intention is as follows:

Wherever we need to perform phy operations like:

LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
{
	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
}

If number of usb2 ports is 3, loop can go from index 0-2 for usb2_generic_phy.
If number of usb3-ports is 2, we don't know for sure, if the first 2 ports are
SS capable or some other ports like (2 and 3) are SS capable. So instead,
num_usb2_ports is used to loop around all phy's (both hs and ss) for
performing phy operations. If any usb3_generic_phy turns out to be NULL, phy
operation just bails out.

num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
phy's as we need to know how many SS capable ports are there for this.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v5: https://lore.kernel.org/all/20230310163420.7582-3-quic_kriskura@quicinc.com/

 drivers/usb/dwc3/core.c | 69 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..567ae79389a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1750,6 +1750,60 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	return edev;
 }
 
+static int dwc3_read_port_info(struct dwc3 *dwc)
+{
+	void __iomem		*regs;
+	u32			offset;
+	u32			temp;
+	u8			major_revision;
+	int			ret = 0;
+
+	/*
+	 * Remap xHCI address space to access XHCI ext cap regs,
+	 * since it is needed to get port info.
+	 */
+	regs = ioremap(dwc->xhci_resources[0].start,
+				resource_size(&dwc->xhci_resources[0]));
+	if (IS_ERR(regs)) {
+		return PTR_ERR(regs);
+	}
+
+	offset = dwc3_xhci_find_next_ext_cap(regs, 0,
+					XHCI_EXT_CAPS_PROTOCOL);
+	while (offset) {
+		temp = readl(regs + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(temp);;
+
+		temp = readl(regs + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
+		} else {
+			dev_err(dwc->dev, "port revision seems wrong\n");
+			ret = -EINVAL;
+			goto unmap_reg;
+		}
+
+		offset = dwc3_xhci_find_next_ext_cap(regs, offset,
+						XHCI_EXT_CAPS_PROTOCOL);
+	}
+
+	temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
+	if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + dwc->num_usb2_ports)) {
+		dev_err(dwc->dev, "inconsistency in port info\n");
+		ret = -EINVAL;
+		goto unmap_reg;
+	}
+
+	dev_dbg(dwc->dev,
+		"hs-ports: %d ss-ports: %d\n", dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+unmap_reg:
+	iounmap(regs);
+	return ret;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1757,6 +1811,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct dwc3		*dwc;
 
 	int			ret;
+	unsigned int		hw_mode;
 
 	void __iomem		*regs;
 
@@ -1880,6 +1935,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto disable_clks;
 	}
 
+	/*
+	 * Currently DWC3 controllers that are host-only capable
+	 * support Multiport
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_read_port_info(dwc);
+		if (ret)
+			goto disable_clks;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4743e918dcaf..229b7da8c5bc 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -35,6 +35,17 @@
 
 #define DWC3_MSG_MAX	500
 
+/* Define XHCI Extcap register offsets for getting multiport info */
+#define XHCI_HCC_PARAMS_OFFSET  0x10
+#define DWC3_XHCI_HCSPARAMS1   0x04
+#define XHCI_EXT_CAPS_PROTOCOL  2
+#define XHCI_HCC_EXT_CAPS(p)    (((p)>>16)&0xffff)
+#define XHCI_EXT_CAPS_ID(p)     (((p)>>0)&0xff)
+#define XHCI_EXT_CAPS_NEXT(p)   (((p)>>8)&0xff)
+#define XHCI_EXT_PORT_MAJOR(x)  (((x) >> 24) & 0xff)
+#define XHCI_EXT_PORT_COUNT(x)  (((x) >> 8) & 0xff)
+#define HCS_MAX_PORTS(p)        (((p) >> 24) & 0x7f)
+
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
 #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
@@ -1023,6 +1034,10 @@ struct dwc3_scratchpad_array {
  * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
+ * @num_usb2_ports: Indicates the number of usb2 ports to be serviced by the
+ *			controller.
+ * @num_usb3_ports: Indicates the number of usb3 ports to be serviced by the
+ *			controller.
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
  * @phys_ready: flag to indicate that PHYs are ready
@@ -1158,6 +1173,8 @@ struct dwc3 {
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
+	u32			num_usb2_ports;
+	u32			num_usb3_ports;
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
@@ -1645,4 +1662,47 @@ static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
 { }
 #endif
 
+/**
+ * Find the offset of the extended capabilities with capability ID id.
+ *
+ * @base	PCI MMIO registers base address.
+ * @start	address at which to start looking, (0 or HCC_PARAMS to start at
+ *		beginning of list)
+ * @id		Extended capability ID to search for, or 0 for the next
+ *		capability
+ *
+ * Returns the offset of the next matching extended capability structure.
+ * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
+ * and this provides a way to find them all.
+ */
+
+static inline int dwc3_xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
+{
+	u32 val;
+	u32 next;
+	u32 offset;
+
+	offset = start;
+	if (!start || start == XHCI_HCC_PARAMS_OFFSET) {
+		val = readl(base + XHCI_HCC_PARAMS_OFFSET);
+		if (val == ~0)
+			return 0;
+		offset = XHCI_HCC_EXT_CAPS(val) << 2;
+		if (!offset)
+			return 0;
+	}
+	do {
+		val = readl(base + offset);
+		if (val == ~0)
+			return 0;
+		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
+			return offset;
+
+		next = XHCI_EXT_CAPS_NEXT(val);
+		offset += next << 2;
+	} while (next);
+
+	return 0;
+}
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
-- 
2.40.0

