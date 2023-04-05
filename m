Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEC6D7D31
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbjDENAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbjDENAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:00:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEB565A8;
        Wed,  5 Apr 2023 05:59:37 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335BRa0w003307;
        Wed, 5 Apr 2023 12:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=pPOGvapzm5vDe+VfmOV1AwOUMHpi0SPNvmqHbiB2Sec=;
 b=fAl9aGjwIee5HoXy420pOrtlVUrbpOj0hCSesCAA+8eh8mebtVpzUMQV3FLj2qSAdaJT
 J/YLiRxmawrf/3BI4GKAQnhBCZEsRN9UcYBCncqhBU2ivYZzTrPim6S3yMAha3AYnhD4
 3YCTH0ZeMJl7e1is7WIAnb1WQT176o50lw4Wq6JCPk1LKK7WDFYxZW5Ec2U3wonJVllI
 70XX4fB0q5RfQMXOorp7LVqML5kljx9w00iX+/sPy9qT2rePnX6ohRHrhkC//1HEK0Df
 pIoSsO4tsP0RSPlFXNPEgHoMWVp8G2RfNpEXUd2eZWYGCufSN0zc56AyjpdF+vBbgcoc HA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prppujjbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 12:59:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 335Cwpim031042
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Apr 2023 12:58:51 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 5 Apr 2023 05:58:45 -0700
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
Subject: [PATCH v6 4/8] usb: dwc3: core: Refactor PHY logic to support Multiport Controller
Date:   Wed, 5 Apr 2023 18:27:55 +0530
Message-ID: <20230405125759.4201-5-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: aKnMDvc6k0Z8YgioKfcprY-CTwox5cUY
X-Proofpoint-ORIG-GUID: aKnMDvc6k0Z8YgioKfcprY-CTwox5cUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_08,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050118
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DWC3 driver supports only single port controller
which requires at most one HS and one SS PHY.

But the DWC3 USB controller can be connected to multiple ports and
each port can have their own PHYs. Each port of the multiport
controller can either be HS+SS capable or HS only capable
Proper quantification of them is required to modify GUSB2PHYCFG
and GUSB3PIPECTL registers appropriately.

Add support for detecting, obtaining and configuring phy's supported
by a multiport controller and limit the max number of ports
supported to 4.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Link to v5: https://lore.kernel.org/all/20230310163420.7582-5-quic_kriskura@quicinc.com/

 drivers/usb/dwc3/core.c | 286 +++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h |  11 +-
 drivers/usb/dwc3/drd.c  |  13 +-
 3 files changed, 225 insertions(+), 85 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2964bcaa0a27..cb27cf8ff432 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -121,6 +121,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
 	int ret;
+	int i;
 	u32 reg;
 	u32 desired_dr_role;
 
@@ -200,8 +201,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+			}
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
@@ -216,8 +219,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -659,22 +662,14 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 	return ret;
 }
 
-/**
- * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
- * @dwc: Pointer to our controller context structure
- *
- * Returns 0 on success. The USB PHY interfaces are configured but not
- * initialized. The PHY interfaces and the PHYs get initialized together with
- * the core in dwc3_core_init.
- */
-static int dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 {
 	unsigned int hw_mode;
 	u32 reg;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
 
 	/*
 	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
@@ -729,9 +724,19 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	return 0;
+}
+
+static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
+{
+	unsigned int hw_mode;
+	u32 reg;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
 
 	/* Select the HS PHY interface */
 	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
@@ -743,7 +748,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		} else if (dwc->hsphy_interface &&
 				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
 		} else {
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
@@ -800,7 +805,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
+
+	return 0;
+}
+
+/**
+ * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
+ * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
+ */
+static int dwc3_phy_setup(struct dwc3 *dwc)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < dwc->num_usb3_ports; i++) {
+		ret = dwc3_ss_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = dwc3_hs_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -839,6 +872,7 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
+	int		i;
 	unsigned int	hw_mode;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
@@ -847,13 +881,19 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_power_off(dwc->usb2_generic_phy[i]);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
@@ -1089,6 +1129,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	unsigned int		hw_mode;
 	u32			reg;
 	int			ret;
+	int			i, j;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
@@ -1123,14 +1164,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err0a;
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		goto err0a;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0) {
+			/* clean up prior initialized HS PHYs */
+			for (j = 0; j < i; j++)
+				phy_exit(dwc->usb2_generic_phy[j]);
+			goto err0a;
+		}
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_init(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			/* clean up prior initialized SS PHYs */
+			for (j = 0; j < i; j++)
+				phy_exit(dwc->usb3_generic_phy[j]);
+			for (j = 0; j < dwc->num_usb2_ports; j++)
+				phy_exit(dwc->usb2_generic_phy[j]);
+			goto err0a;
+		}
 	}
 
 	ret = dwc3_core_soft_reset(dwc);
@@ -1140,15 +1194,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
 		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+			for (i = 0; i < dwc->num_usb3_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+			}
 		}
 
 		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 		}
 	}
 
@@ -1172,13 +1230,24 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err2;
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err3;
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0) {
+			for (j = 0; j < i; j++)
+				phy_power_off(dwc->usb2_generic_phy[j]);
+			goto err2;
+		}
+	}
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		ret = phy_power_on(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			for (j = 0; j < i; j++)
+				phy_power_off(dwc->usb3_generic_phy[j]);
+			goto err3;
+		}
+	}
 
 	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
 		ret = dwc3_event_buffers_setup(dwc);
@@ -1303,10 +1372,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return 0;
 
 err4:
-	phy_power_off(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_power_off(dwc->usb3_generic_phy[i]);
 
 err3:
-	phy_power_off(dwc->usb2_generic_phy);
+	for (i = 0; i < dwc->num_usb2_ports; i++)
+		phy_power_off(dwc->usb2_generic_phy[i]);
 
 err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -1315,8 +1386,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 err1:
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 err0a:
 	dwc3_ulpi_exit(dwc);
@@ -1325,6 +1399,42 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return ret;
 }
 
+static int dwc3_get_multiport_phys(struct dwc3 *dwc)
+{
+	int ret;
+	struct device *dev = dwc->dev;
+	int i;
+	char phy_name[11];
+
+	/*
+	 * Each port is atleast HS capable. So loop over num_usb2_ports
+	 * to get available phy's.
+	 */
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		sprintf(phy_name, "usb2-port%d", i);
+		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb2_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb2_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret, "usb2 phy: %s not configured\n", phy_name);
+		}
+
+		sprintf(phy_name, "usb3-port%d", i);
+		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb3_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb3_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret, "usb3 phy: %s not configured\n", phy_name);
+		}
+	}
+
+	return 0;
+}
+
 static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
@@ -1355,20 +1465,24 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
+	if (dwc->num_usb2_ports > 1)
+		return dwc3_get_multiport_phys(dwc);
+
+
+	dwc->usb2_generic_phy[0] = devm_phy_get(dev, "usb2-phy");
+	if (IS_ERR(dwc->usb2_generic_phy[0])) {
+		ret = PTR_ERR(dwc->usb2_generic_phy[0]);
 		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb2_generic_phy = NULL;
+			dwc->usb2_generic_phy[0] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
 	}
 
-	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
-	if (IS_ERR(dwc->usb3_generic_phy)) {
-		ret = PTR_ERR(dwc->usb3_generic_phy);
+	dwc->usb3_generic_phy[0] = devm_phy_get(dev, "usb3-phy");
+	if (IS_ERR(dwc->usb3_generic_phy[0])) {
+		ret = PTR_ERR(dwc->usb3_generic_phy[0]);
 		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb3_generic_phy = NULL;
+			dwc->usb3_generic_phy[0] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
@@ -1380,6 +1494,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
 	int ret;
+	int i;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
@@ -1387,8 +1502,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -1399,8 +1514,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+		}
 
 		ret = dwc3_host_init(dwc);
 		if (ret)
@@ -1817,6 +1934,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct dwc3		*dwc;
 
 	int			ret;
+	int			i;
 	unsigned int		hw_mode;
 
 	void __iomem		*regs;
@@ -1943,7 +2061,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	/*
 	 * Currently DWC3 controllers that are host-only capable
-	 * support Multiport
+	 * support Multiport.
 	 */
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
@@ -2014,13 +2132,19 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_power_off(dwc->usb2_generic_phy[i]);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_usb2_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 	dwc3_ulpi_exit(dwc);
 
@@ -2102,6 +2226,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
+	int i;
 	unsigned long	flags;
 	u32 reg;
 
@@ -2122,17 +2247,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
 		    dwc->dis_enblslpm_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-				DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+					DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 
 			/* Give some time for USB2 PHY to suspend */
 			usleep_range(5000, 6000);
 		}
 
-		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -2161,6 +2290,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
+	int		i;
 	u32		reg;
 
 	switch (dwc->current_dr_role) {
@@ -2181,17 +2311,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (dwc->dis_u2_susphy_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+			if (dwc->dis_u2_susphy_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-		if (dwc->dis_enblslpm_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+			if (dwc->dis_enblslpm_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+		}
 
-		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_usb2_ports; i++) {
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 229b7da8c5bc..668ad30c151f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -35,6 +35,9 @@
 
 #define DWC3_MSG_MAX	500
 
+/* Numer of ports supported by a multiport controller */
+#define MAX_PORTS_SUPPORTED	4
+
 /* Define XHCI Extcap register offsets for getting multiport info */
 #define XHCI_HCC_PARAMS_OFFSET  0x10
 #define DWC3_XHCI_HCSPARAMS1   0x04
@@ -1038,8 +1041,8 @@ struct dwc3_scratchpad_array {
  *			controller.
  * @num_usb3_ports: Indicates the number of usb3 ports to be serviced by the
  *			controller.
- * @usb2_generic_phy: pointer to USB2 PHY
- * @usb3_generic_phy: pointer to USB3 PHY
+ * @usb2_generic_phy: pointer to array of USB2 PHY
+ * @usb3_generic_phy: pointer to array of USB3 PHY
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1175,8 +1178,8 @@ struct dwc3 {
 
 	u32			num_usb2_ports;
 	u32			num_usb3_ports;
-	struct phy		*usb2_generic_phy;
-	struct phy		*usb3_generic_phy;
+	struct phy		*usb2_generic_phy[MAX_PORTS_SUPPORTED];
+	struct phy		*usb3_generic_phy[MAX_PORTS_SUPPORTED];
 
 	bool			phys_ready;
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf241769a..0377295717ab 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -328,6 +328,7 @@ static void dwc3_otg_device_exit(struct dwc3 *dwc)
 void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 {
 	int ret;
+	int i;
 	u32 reg;
 	int id;
 	unsigned long flags;
@@ -386,9 +387,11 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy,
-					     PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_usb2_ports; i++) {
+				if (dwc->usb2_generic_phy[i])
+					phy_set_mode(dwc->usb2_generic_phy[i],
+						     PHY_MODE_USB_HOST);
+			}
 		}
 		break;
 	case DWC3_OTG_ROLE_DEVICE:
@@ -400,8 +403,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy,
+		if (dwc->usb2_generic_phy[0])
+			phy_set_mode(dwc->usb2_generic_phy[0],
 				     PHY_MODE_USB_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
-- 
2.40.0

