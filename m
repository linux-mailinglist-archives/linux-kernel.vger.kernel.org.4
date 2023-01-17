Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F50466D8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjAQJAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbjAQI7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FED01814D;
        Tue, 17 Jan 2023 00:59:19 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H8HJKt017245;
        Tue, 17 Jan 2023 08:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=P/am4zhMSVczKChKFHudBA/YOPhcB9emvw0DPfGFrGs=;
 b=p5psJ6WukZc8ynnvMXtRhqugXXIYkfyz0FD+pZhTAeyZQjd0UF8jLVbqbRJrnrwM1kE5
 5EiCrxaxIF7tfikfQ9FbQTMm2Hb4UC1jk9Ur8wPJfzwbYL1rA3M7vdyk3MDSK/6+7IwC
 1llknOPKco0D2YXbKBmI/o6x+roPPuw35b26AQbO0G1+s5o+hrwiCMXXT/MCCovrBAxs
 CsKBBxUYRcAwlUziev+1nuQHkd2xJS4shuHWoggUV2oA+hTt4XU7wz/2HCY17u+KsQXS
 9oeg1JAmRo31sV7QPa6l/gPSFekNgkEfiFyn2t5i8r4sqZGIfPx6VT4Dd8cYllZfrgkH ZA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n3kqsw5uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8x4Mg027863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:04 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:58:56 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 00/11] Fix XPU violation during modem metadata authentication
Date:   Tue, 17 Jan 2023 14:28:29 +0530
Message-ID: <20230117085840.32356-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Os2LjKjpmffLWIRXYk9H2PLc7XOVOVHn
X-Proofpoint-ORIG-GUID: Os2LjKjpmffLWIRXYk9H2PLc7XOVOVHn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170074
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

V4:
 * Pickup Christoph's revert [Mani]
 * Use size/alloc-ranges instead of a specific address [Bjorn]
 * Include size checks
 * Pickup R-b

V3:
 * remove double space [Krzysztof]
 * Pickup R-bs
 * yaml description rewrite [Krzysztof]
 * fix compatible property [Krzysztof]
 * add blank lines and additionalProperties: false to mba/mpss
   objects
 * add blank lines and additionalProperties: false to mdata
   objects [Krzysztof]
 * Drop revert no_kernel_mapping since it's already on the list [Mani]
 * kfree metadata from the branch for parity

V2:
 * Convert legacy bindings to yaml
 * Revert no_kernel_mapping [Mani/Robin]
 * Pad commit message to explain bindings break [Krzysztof]
 * Split dt/bindings per SoC [Krzysztof]

Christoph Hellwig (1):
  Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata region
    before/after use"

Sibi Sankar (10):
  dt-bindings: remoteproc: qcom,q6v5: Move MSM8996 to schema
  dt-bindings: remoteproc: qcom,msm8996-mss-pil: Update memory region
  dt-bindings: remoteproc: qcom,sc7180-mss-pil: Update memory-region
  dt-bindings: remoteproc: qcom,sc7280-mss-pil: Update memory-region
  remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
    headers
  arm64: dts: qcom: msm8996: Add a carveout for modem metadata
  arm64: dts: qcom: msm8998: Add a carveout for modem metadata
  arm64: dts: qcom: sdm845: Add a carveout for modem metadata
  arm64: dts: qcom: sc7180: Add a carveout for modem metadata
  arm64: dts: qcom: sc7280: Add a carveout for modem metadata

 .../remoteproc/qcom,msm8996-mss-pil.yaml      | 393 ++++++++++++++++++
 .../bindings/remoteproc/qcom,q6v5.txt         | 137 +-----
 .../remoteproc/qcom,sc7180-mss-pil.yaml       |   3 +-
 .../remoteproc/qcom,sc7280-mss-pil.yaml       |   3 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  10 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  10 +
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   8 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   8 +-
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |   8 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  10 +
 drivers/remoteproc/qcom_q6v5_mss.c            |  87 ++--
 11 files changed, 507 insertions(+), 170 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

-- 
2.17.1

