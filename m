Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7236B4D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCJQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjCJQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:37:03 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279491717B;
        Fri, 10 Mar 2023 08:34:56 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ADvGtE007100;
        Fri, 10 Mar 2023 16:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=uOn43gIsWl62UJjej198pBalt9A+O9beKIfPPNQpx5I=;
 b=GXMrBW8xz77UpAvNjlMGDf57badQYp9wLqxGM/wfmXBKsMhl89v49/xUM47Soe2VwcT2
 eCWmnKOYUpqBxTPPgHBikNw4DWMhjdo19OOJaipyrrAWF7BUgzOcltmITuIFSSxNzR38
 GbfkvZ2Zu7TmZWh4M04PtPMIFaLakG6fVLNBbeR70avehwZFy8cEorY43O56r7/cAFy4
 3sIgKbJBBsTBWKY8bG/M/WG4M10gxzQ6rOEH9RvdpUCHWwDZAqnwrzYuMCgZGG180Flv
 fkM3D90LodUgtdMi1mO1gtVIu/4psi/P9ZVLn+/0PimhRObSHqOxxCFbA/KL4xF5KA18 oQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7pm12g1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:34:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32AGYapx032506
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 16:34:36 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 10 Mar 2023 08:34:30 -0800
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
Subject: [PATCH 0/8] Add multiport support for DWC3 controllers
Date:   Fri, 10 Mar 2023 22:04:12 +0530
Message-ID: <20230310163420.7582-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HGRe_uMATpJ7ommhisvDHhM44GsAjm-U
X-Proofpoint-ORIG-GUID: HGRe_uMATpJ7ommhisvDHhM44GsAjm-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_07,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 mlxlogscore=676 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DWC3 driver supports only single port controller which
requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
DWC3 controller with multiple ports that can operate in host mode.
Some of the port supports both SS+HS and other port supports only HS
mode.

This change primarily refactors the Phy logic in core driver to allow
multiport support with Generic Phy's.

Chananges have been tested on  QCOM SoC SA8295P which has 4 ports (2
are HS+SS capable and 2 are HS only capable).

Changes in current version:
Added DT support for first port of Teritiary USB controller on SA8540-Ride
Added support for reading port info from XHCI Extended Params registers.

Changes in RFC v4:
Added DT support for SA8295p.

Changes in RFC v3:
Incase any PHY init fails, then clear/exit the PHYs that
are already initialized.

Changes in RFC v2:
Changed dwc3_count_phys to return the number of PHY Phandles in the node.
This will be used now in dwc3_extract_num_phys to increment num_usb2_phy 
and num_usb3_phy.

Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
structure such that the first half is for HS-PHY and second half is for
SS-PHY.

In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
present, pass proper SS_IDX else pass -1.

Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r

Krishna Kurapati (8):
  dt-bindings: usb: Add bindings for multiport properties on DWC3
    controller
  usb: dwc3: core: Access XHCI address space temporarily to read port
    info
  usb: dwc3: core: Skip setting event buffers for host only controllers
  usb: dwc3: core: Refactor PHY logic to support Multiport Controller
  usb: dwc3: qcom: Add multiport controller support for qcom wrapper
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable teritiary controller and its 4 USB
    ports
  arm64: dts: qcom: sa8540-ride: Enable first port of teritiary usb
    controller

 .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  47 +++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  22 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  58 +++
 drivers/usb/dwc3/core.c                       | 374 ++++++++++++++----
 drivers/usb/dwc3/core.h                       |  20 +-
 drivers/usb/dwc3/drd.c                        |  13 +-
 drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
 8 files changed, 473 insertions(+), 102 deletions(-)

-- 
2.39.0

