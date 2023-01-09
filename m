Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0260661CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjAIDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbjAIDua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CEB1F3;
        Sun,  8 Jan 2023 19:50:28 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093Cf3A004859;
        Mon, 9 Jan 2023 03:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5Y+xlhwayWmZ5koqedxSuXf7/vlQbYv6y4WCErg8OG4=;
 b=RV3g6WPvZc5cu5dXaH7vDi9wl00s1Gbsmix48npJ+z2x2Vx1vxiB7twldoCEJz0s8ln/
 j8x13lDTBqhn8Ubx4Odl1+cc+Yu+wL3TpGrqm7KQ3/dtomRBLOPM3t6Hi3bMQQqqQFzV
 X5I5anUQPodEq1oiCsS9EfsiuOU7b4yNF1MWQDx9RvYtmYfODRcGERrM95bKS4XfOY8L
 hz5H63JlUOV0FfvANIcIxg/vM4W7Mbl8DlZWWvZFxj9DP/CZjeT81JI/DWQ81WTUkeQN
 LSqv0eOHP/Gov8NiOtWgD4MRcFuUU4FdJuSHfEmgRdi3moYa3XChKlUrvhwO9i6PG4++ 5Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my21ft65j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093o6p4030780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:06 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:01 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 00/11] Fix XPU violation during modem metadata authentication
Date:   Mon, 9 Jan 2023 09:18:32 +0530
Message-ID: <20230109034843.23759-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2Ppn45XVWOL_h-2HFQmVh1Qu--vMLaDK
X-Proofpoint-GUID: 2Ppn45XVWOL_h-2HFQmVh1Qu--vMLaDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090025
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory region allocated using dma_alloc_attr with no kernel mapping
attribute set would still be a part of the linear kernel map. Any access
to this region by the application processor after assigning it to the
remote Q6 will result in a XPU violation. Fix this by replacing the
dynamically allocated memory region with a no-map carveout and unmap the
modem metadata memory region before passing control to the remote Q6.
The addition of the carveout and memunmap is required only on SoCs that
mandate memory protection before transferring control to Q6, hence the
driver falls back to dynamic memory allocation in the absence of the
modem metadata carveout.

V2:
 * Convert legacy bindings to yaml
 * Revert no_kernel_mapping [Mani/Robin]
 * Pad commit message to explain bindings break [Krzysztof]
 * Split dt/bindings per SoC  [Krzysztof] 

Sibi Sankar (11):
  dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema
  dt-bindings: remoteproc: qcom,msm8996-mss-pil: Update memory region
  dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
  dt-bindings: remoteproc: qcom,sc7280-mss-pil: Update memory-region
  remoteproc: qcom_q6v5_mss: revert "map/unmap metadata region
    before/after use"
  remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
    headers
  arm64: dts: qcom: msm8996: Add a carveout for modem metadata
  arm64: dts: qcom: msm8998: Add a carveout for modem metadata
  arm64: dts: qcom: sdm845: Add a carveout for modem metadata
  arm64: dts: qcom: sc7180: Add a carveout for modem metadata
  arm64: dts: qcom: sc7280: Add a carveout for modem metadata

 .../remoteproc/qcom,msm8996-mss-pil.yaml      | 382 ++++++++++++++++++
 .../bindings/remoteproc/qcom,q6v5.txt         | 137 +------
 .../remoteproc/qcom,sc7180-mss-pil.yaml       |   3 +-
 .../remoteproc/qcom,sc7280-mss-pil.yaml       |   3 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   6 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   9 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   9 +
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   7 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   7 +-
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   9 +
 drivers/remoteproc/qcom_q6v5_mss.c            |  78 ++--
 12 files changed, 486 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

-- 
2.17.1

