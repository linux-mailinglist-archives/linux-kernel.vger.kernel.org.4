Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331A6F3205
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjEAOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:35:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C7134;
        Mon,  1 May 2023 07:35:35 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341ELZnA000325;
        Mon, 1 May 2023 14:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=E6TfuQFI0dUkNEIv9TZPGXgZ2terHGZLiSlaLnzVKf8=;
 b=oDh+u3TGzoxD6+/gvJ2Q46HBcWW/oRQEfUwujfHAKo/L6lJfdS3t9Md1RkoK7Q3fgrRK
 vM641RH6XmjJ49IVCFO7/k8qydKScibMdEab8A8nXAv2kpnksaOfxxgCdGjU9GmaAmXA
 PuPiJX4qjVPyzCzwk1pHdNVCd/xKNF79GdPrNBTnfsFMMr2HwOTVw24nu+29l8ulOmGb
 b1bAjwlj/qxny3ufEYiTyjOl9VsFaVNwFUS9PWAazP+HhxSE+kL+et5WqKNfwQeFTTT0
 S6s/vFeei/vJHLCVlRKiBs9OHbI4ykp8UBdmCunNHVNv+5w91MOMGNa3LzURBdfq3pO5 7g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q8t8ubrqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 May 2023 14:35:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341EZ0oP015266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 May 2023 14:35:01 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 May 2023 07:34:54 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v7 0/9] Add multiport support for DWC3 controllers
Date:   Mon, 1 May 2023 20:04:36 +0530
Message-ID: <20230501143445.3851-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S5s6Cq-jGvbWsMG8EwsTwojfy0D8Ktg1
X-Proofpoint-GUID: S5s6Cq-jGvbWsMG8EwsTwojfy0D8Ktg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v7:
Added power event irq's for Multiport controller.
Udpated commit text for patch-9 (adding DT changes for enabling first
port of multiport controller on sa8540-ride).
Fixed check-patch warnings for driver code.
Fixed DT binding errors for changes in snps,dwc3.yaml
Reabsed code on top of usb-next

Changes in v6:
Updated comments in code after.
Updated variables names appropriately as per review comments.
Updated commit text in patch-2 and added additional info as per review
comments.
The patch header in v5 doesn't have "PATHCH v5" notation present. Corrected
it in this version.

Changes in v5:
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

Link to v6: https://lore.kernel.org/all/20230405125759.4201-1-quic_kriskura@quicinc.com/
Link to v5: https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/
Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r

Test results:

Bus 3/4 represent multiport controller having 4 HS ports and 2 SS ports.

/ # dmesg |grep hub
[    0.029029] usbcore: registered new interface driver hub
[    1.372812] hub 1-0:1.0: USB hub found
[    1.389142] hub 1-0:1.0: 1 port detected
[    1.414721] hub 2-0:1.0: USB hub found
[    1.427669] hub 2-0:1.0: 1 port detected
[    2.931465] hub 3-0:1.0: USB hub found
[    2.935340] hub 3-0:1.0: 4 ports detected
[    2.948721] hub 4-0:1.0: USB hub found
[    2.952604] hub 4-0:1.0: 2 ports detected
/ #
/ # lsusb
Bus 003 Device 001: ID 1d6b:0002
Bus 001 Device 001: ID 1d6b:0002
Bus 003 Device 005: ID 0b0e:0300
Bus 003 Device 002: ID 046d:c077
Bus 004 Device 001: ID 1d6b:0003
Bus 002 Device 001: ID 1d6b:0003
Bus 003 Device 004: ID 03f0:0024
Bus 003 Device 003: ID 046d:c016


Krishna Kurapati (9):
  dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
  dt-bindings: usb: Add bindings for multiport properties on DWC3
    controller
  usb: dwc3: core: Access XHCI address space temporarily to read port
    info
  usb: dwc3: core: Skip setting event buffers for host only controllers
  usb: dwc3: core: Refactor PHY logic to support Multiport Controller
  usb: dwc3: qcom: Add multiport controller support for qcom wrapper
  arm64: dts: qcom: sc8280xp: Add multiport controller node for SC8280
  arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
    ports
  arm64: dts: qcom: sa8540-ride: Enable first port of tertiary usb
    controller

 .../devicetree/bindings/usb/qcom,dwc3.yaml    |  21 ++
 .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      |  47 +++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  22 ++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  64 ++++
 drivers/usb/dwc3/core.c                       | 352 ++++++++++++++----
 drivers/usb/dwc3/core.h                       |  68 +++-
 drivers/usb/dwc3/drd.c                        |  13 +-
 drivers/usb/dwc3/dwc3-qcom.c                  |  28 +-
 9 files changed, 533 insertions(+), 95 deletions(-)

-- 
2.40.0

