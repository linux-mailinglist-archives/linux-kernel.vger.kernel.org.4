Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF566665A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjAKLp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjAKLp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:45:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32C559A;
        Wed, 11 Jan 2023 03:44:13 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BA3Emn011352;
        Wed, 11 Jan 2023 11:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Pf8uSiZqQXfQ69hfqvBwH35xGsTTEHCOviTzh/nfQ8A=;
 b=hu2hdmR/HdqiipapA3PsGXHwavSBg/D63Hx5RGt8guGd4DgOd0R7j9/i2geZDg7ebytQ
 48TV5Mz7YfzsXdQFPIkLQDLZL9OiwnaxDlObhVX5rV72qEdthvS0TGMH1lIKUuCdgxKu
 eIVN5U15+fgEbXEEhh/+BGmCZTITOPJiNapzA0EA/nzY78gSU7YOTuzIeTd97yHKh+lD
 7JDaVayrBg8HCT6m7NqtsDDtbqQ6U41+4GC6srSZaQ3mnG/+nsuOko2cFOZW56p+2hwP
 9N0GGwh4maPwNJkJquLmBcXnloxXVmOKKJYJOrx0Xm5IQafM1jNBLXe4EUrxHmdfOsI8 XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k9j16sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 11:43:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BBhvig002389
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 11:43:57 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 03:43:53 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <konrad.dybcio@somainline.org>,
        <amit.pundir@linaro.org>, <regressions@leemhuis.info>,
        <sumit.semwal@linaro.org>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V3 00/10] Fix XPU violation during modem metadata authentication
Date:   Wed, 11 Jan 2023 17:13:27 +0530
Message-ID: <20230111114337.24782-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _9t-nuSSbI3o5s1ZbBm7hh28PWcrcRsp
X-Proofpoint-ORIG-GUID: _9t-nuSSbI3o5s1ZbBm7hh28PWcrcRsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_05,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301110086
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Depends on:
[revert no_kernel_mapping]: https://lore.kernel.org/linux-arm-msm/20221223092703.61927-2-hch@lst.de/

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
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |   6 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   9 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |   9 +
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |   7 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |   7 +-
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |   7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   9 +
 drivers/remoteproc/qcom_q6v5_mss.c            |  48 ++-
 12 files changed, 495 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

-- 
2.17.1

