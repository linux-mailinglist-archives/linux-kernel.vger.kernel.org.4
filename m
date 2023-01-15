Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C966B0C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjAOLmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjAOLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:42:35 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D554E12597;
        Sun, 15 Jan 2023 03:42:25 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30FBdVt9024509;
        Sun, 15 Jan 2023 11:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=b8Rs0AZPza881UAy4dCegR1Xzly6y9sIzDudrW+ZrWw=;
 b=dbQQ340YguH+Nc5gP3dQM9qmCeCrA9yPV2VM/kGQdn96kG9Zn2BwI1VvROlon6yMgW1q
 v9MZm9cuvh1gFptaCK8N8ZL0gNy2coa+4Hl9Yw2/xtQuhICwWJIiLsfdKRhPL882wmIc
 vpd9ui78JkUR9pAZRU9chkTE6P7gLFdf4tV6e++7ikRe6WXTwz6ibVhoORH3YdxI2MGV
 qoEJHate1ILZ+aenQ+tQOgRN81lqesOcHiVOYdy/mv/LgZc5T1uXQ/Jmex3PUm7naB92
 flgCGHLa6sEfpuKq1rMhTGDLh7rAlHIUCLfzTruZechIMxZ3Io7YDb4Vvw8Z17fM5THt hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3npg9jrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30FBgE7C017984
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Jan 2023 11:42:14 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 03:42:07 -0800
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_harshq@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support Multiport Controller
Date:   Sun, 15 Jan 2023 17:11:43 +0530
Message-ID: <20230115114146.12628-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230115114146.12628-1-quic_kriskura@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 12Sg8NdVYC1WfFRcrLq7_EkDfCEC0P0k
X-Proofpoint-ORIG-GUID: 12Sg8NdVYC1WfFRcrLq7_EkDfCEC0P0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-15_07,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=958 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301150089
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/usb/dwc3/core.c | 304 +++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h |  15 +-
 drivers/usb/dwc3/drd.c  |  14 +-
 3 files changed, 244 insertions(+), 89 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 476b63618511..7e0a9a598dfd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -120,7 +120,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
-	int ret;
+	int ret, i;
 	u32 reg;
 	u32 desired_dr_role;
 
@@ -200,8 +200,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_ports; i++) {
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+			}
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
@@ -216,8 +218,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -659,22 +661,14 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
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
@@ -729,9 +723,19 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
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
@@ -743,7 +747,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		} else if (dwc->hsphy_interface &&
 				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
 		} else {
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
@@ -800,7 +804,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
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
+	for (i = 0; i < dwc->num_ss_ports; i++) {
+		ret = dwc3_ss_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		ret = dwc3_hs_phy_setup(dwc, i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -839,17 +871,25 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
+	int i;
+
 	dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		phy_power_off(dwc->usb2_generic_phy[i]);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
@@ -1085,6 +1125,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	unsigned int		hw_mode;
 	u32			reg;
 	int			ret;
+	int			i, j;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
@@ -1119,14 +1160,27 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err0a;
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		goto err0a;
+	for (i = 0; i < dwc->num_ports; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0) {
+			/* clean up prior initialized HS PHYs */
+			for (j = 0; j < i; j++)
+				phy_exit(dwc->usb2_generic_phy[j]);
+			goto err0a;
+		}
+	}
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		ret = phy_init(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			/* clean up prior initialized SS PHYs */
+			for (j = 0; j < i; j++)
+				phy_exit(dwc->usb3_generic_phy[j]);
+			for (j = 0; j < dwc->num_ports; j++)
+				phy_exit(dwc->usb2_generic_phy[j]);
+			goto err0a;
+		}
 	}
 
 	ret = dwc3_core_soft_reset(dwc);
@@ -1136,15 +1190,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
 		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+			for (i = 0; i < dwc->num_ss_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+			}
 		}
 
 		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_ports; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 		}
 	}
 
@@ -1168,13 +1226,25 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err2;
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err3;
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0) {
+			for (j = 0; j < i; j++)
+				phy_power_off(dwc->usb2_generic_phy[j]);
+			goto err2;
+		}
+	}
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		ret = phy_power_on(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			for (j = 0; j < i; j++)
+				phy_power_off(dwc->usb3_generic_phy[j]);
+			goto err3;
+		}
+	}
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
@@ -1297,10 +1367,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return 0;
 
 err4:
-	phy_power_off(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_ports; i++)
+		phy_power_off(dwc->usb3_generic_phy[i]);
 
 err3:
-	phy_power_off(dwc->usb2_generic_phy);
+	for (i = 0; i < dwc->num_ports; i++)
+		phy_power_off(dwc->usb2_generic_phy[i]);
 
 err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
@@ -1309,8 +1381,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 err1:
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 err0a:
 	dwc3_ulpi_exit(dwc);
@@ -1319,6 +1394,38 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return ret;
 }
 
+static int dwc3_get_multiport_phys(struct dwc3 *dwc)
+{
+	int ret;
+	struct device *dev = dwc->dev;
+	int i;
+	char phy_name[15];
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		sprintf(phy_name, "usb2-phy_port%d", i);
+		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
+		if (IS_ERR(dwc->usb2_generic_phy[i])) {
+			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb2_generic_phy[i] = NULL;
+			else
+				return dev_err_probe(dev, ret, "usb2 phy: %s not configured\n", phy_name);
+		}
+
+		sprintf(phy_name, "usb3-phy_port%d", i);
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
@@ -1349,31 +1456,37 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
+	if (dwc->num_ports > 1)
+		goto get_multiport_phys;
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
 
 	return 0;
+
+get_multiport_phys:
+	return dwc3_get_multiport_phys(dwc);
 }
 
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
-	int ret;
+	int ret, i;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
@@ -1381,8 +1494,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -1393,8 +1506,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_ports; i++) {
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
+		}
 
 		ret = dwc3_host_init(dwc);
 		if (ret)
@@ -1575,6 +1690,21 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+
+	/*
+	 * If no mulitport properties are defined, default
+	 * the port count to '1'.
+	 */
+	ret = device_property_read_u32(dev, "num-ports",
+				&dwc->num_ports);
+	if (ret)
+		dwc->num_ports = 1;
+
+	ret = device_property_read_u32(dev, "num-ss-ports",
+				&dwc->num_ss_ports);
+	if (ret)
+		dwc->num_ss_ports = 1;
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1755,8 +1885,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
-
-	int			ret;
+	int			ret, i;
 
 	void __iomem		*regs;
 
@@ -1933,17 +2062,24 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err5:
 	dwc3_debugfs_exit(dwc);
+
 	dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		phy_power_off(dwc->usb2_generic_phy[i]);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
 	usb_phy_shutdown(dwc->usb2_phy);
 	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+
+	for (i = 0; i < dwc->num_ports; i++) {
+		phy_exit(dwc->usb2_generic_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 	dwc3_ulpi_exit(dwc);
 
@@ -2025,6 +2161,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
+	int i;
 	unsigned long	flags;
 	u32 reg;
 
@@ -2045,17 +2182,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
 		    dwc->dis_enblslpm_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-				DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_ports; i++) {
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
+		for (i = 0; i < dwc->num_ports; i++) {
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -2084,6 +2225,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
 	int		ret;
+	int		i;
 	u32		reg;
 
 	switch (dwc->current_dr_role) {
@@ -2104,17 +2246,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (dwc->dis_u2_susphy_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		for (i = 0; i < dwc->num_ports; i++) {
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
+		for (i = 0; i < dwc->num_ports; i++) {
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..2f82eda9d44f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -35,6 +35,9 @@
 
 #define DWC3_MSG_MAX	500
 
+/* Number of ports supported by a multiport controller */
+#define MAX_PORTS_SUPPORTED	4
+
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
 #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
@@ -1023,8 +1026,10 @@ struct dwc3_scratchpad_array {
  * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
- * @usb2_generic_phy: pointer to USB2 PHY
- * @usb3_generic_phy: pointer to USB3 PHY
+ * @num_ports: Indicates number of usb ports supported by the controller.
+ * @num_ss_ports: Indicates number of ss capable ports supported by controller
+ * @usb2_generic_phy: pointer to array of USB2 PHY's
+ * @usb3_generic_phy: pointer to array of USB3 PHY's
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1157,8 +1162,10 @@ struct dwc3 {
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
 
-	struct phy		*usb2_generic_phy;
-	struct phy		*usb3_generic_phy;
+	u32			num_ports;
+	u32			num_ss_ports;
+	struct phy		*usb2_generic_phy[MAX_PORTS_SUPPORTED];
+	struct phy		*usb3_generic_phy[MAX_PORTS_SUPPORTED];
 
 	bool			phys_ready;
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf241769a..ea86ff01433b 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -327,7 +327,7 @@ static void dwc3_otg_device_exit(struct dwc3 *dwc)
 
 void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 {
-	int ret;
+	int ret, i;
 	u32 reg;
 	int id;
 	unsigned long flags;
@@ -386,9 +386,11 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		} else {
 			if (dwc->usb2_phy)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy,
-					     PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_ports; i++) {
+				if (dwc->usb2_generic_phy[i])
+					phy_set_mode(dwc->usb2_generic_phy[i],
+						     PHY_MODE_USB_HOST);
+			}
 		}
 		break;
 	case DWC3_OTG_ROLE_DEVICE:
@@ -400,8 +402,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 
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
2.39.0

