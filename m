Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055116B4D42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCJQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCJQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:37:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD494B826;
        Fri, 10 Mar 2023 08:35:18 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32AFl3vZ027552;
        Fri, 10 Mar 2023 16:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=9C4DYWplhgjPBnAXY668/L2h51S0yRoFzMkgqWjFhQQ=;
 b=DdHSb6ECMWDqCwuWQVnXfRpVapipHjn2nXvLcoBS5QskgA3ZrI3Jhg5gGW2P9ibYk1dA
 lu+dtAjIw6TVP9t3P0iM8jl5h5S3L8oWbocqw8vo0PHh3hT0Ua2IO4L1htrHq72Q9+CH
 DE8arcjH053AI1WqKby72kXNUkbAVeRZLqYYGCfw3XlZuHhSs+VgwaNzFsl8H5+zgP3h
 AY8Xrc1nKd9Xeklz5KXehASHQ7xd+cZ0ovgYO/4U0/DnheLruM01ZW95k8sOrtG7WJcn
 aJjr2SfriuGOHmL0EPJsbjVo66rnplce0W0lecEtZvT3y/vUYcJ3U5MSqvC45CFALHO/ Gw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7rqgt5r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:34:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32AGYtnB032555
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:34:55 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 10 Mar 2023 08:34:49 -0800
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
        <quic_harshq@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 3/8] usb: dwc3: core: Skip setting event buffers for host only controllers
Date:   Fri, 10 Mar 2023 22:04:15 +0530
Message-ID: <20230310163420.7582-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230310163420.7582-1-quic_kriskura@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nG66TYP_EWdY1M39YHfzlw7-LTM9SCcw
X-Proofpoint-GUID: nG66TYP_EWdY1M39YHfzlw7-LTM9SCcw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_07,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 mlxlogscore=831 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoC's like SA8295P where the teritiary controller is host-only
capable, GEVTADDRHI/LO, GEVTSIZ, GEVTCOUNT registers are not accessible.
Trying to setup them up during core_init leads to a crash.

For DRD/Peripheral supported controllers, event buffer setup is done
again in gadget_pullup. Skip setup or cleanup of event buffers if
controller is host-only capable.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 076c0f8a4441..1ca9fa40a66e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -840,7 +840,11 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
-	dwc3_event_buffers_cleanup(dwc);
+	unsigned int	hw_mode;
+
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
+		dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
@@ -1177,10 +1181,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret < 0)
 		goto err3;
 
-	ret = dwc3_event_buffers_setup(dwc);
-	if (ret) {
-		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err4;
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_event_buffers_setup(dwc);
+		if (ret) {
+			dev_err(dwc->dev, "failed to setup event buffers\n");
+			goto err4;
+		}
 	}
 
 	/*
@@ -2008,7 +2014,9 @@ static int dwc3_probe(struct platform_device *pdev)
 
 err5:
 	dwc3_debugfs_exit(dwc);
-	dwc3_event_buffers_cleanup(dwc);
+
+	if (hw_mode != DWC3_GHWPARAMS0_MODE_HOST)
+		dwc3_event_buffers_cleanup(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-- 
2.39.0

