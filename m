Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8DE64B6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiLMOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiLMOIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:01 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC58A64F2;
        Tue, 13 Dec 2022 06:08:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDC88KY002290;
        Tue, 13 Dec 2022 14:07:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TXeBUCe1HPp5AFy0SHk2Z8LYe3WueSsP5aUxykmgGys=;
 b=M1mIggLGGs5ajdHY0YnTISt3w2uy5J78KW8Ba1gHRppFoldJnrLFFy6v0uWBBA5yB/4B
 XjGmQ55YZAolmViVDZUDgJDF4SNBj+5A5z35edrzYjiOLYK9415kZFFvIbEVheEAwu+j
 ZRIBeQvl7NDtitMUt9LMqhU/z1UyHPKMCcFq2vYIYnCNQeU47kktfr6DEbsJK9w9wR+/
 SKl7irJEr2+qVh0l+IGSkHmNclepTDTY93Do+Dg7NYJeOaE9i+Mo2rRugRhW4iyNyfND
 gX8FC6L/VrzaHfBM9PpMyt5E8jykrbUlCvcW5+6E93a53SbDLIIdlRO5wY8pQA85OQcJ Ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mes4a8ase-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE7lJK019330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:47 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:07:42 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 0/4] Fix XPU violation during modem metadata authentication
Date:   Tue, 13 Dec 2022 19:37:20 +0530
Message-ID: <20221213140724.8612-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ZhKLx68d2VmJOkH8wyqo3hRnDOh2C00
X-Proofpoint-ORIG-GUID: 7ZhKLx68d2VmJOkH8wyqo3hRnDOh2C00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Relevant discussions on the mailing list:
https://lore.kernel.org/lkml/20221114110329.68413-1-manivannan.sadhasivam@linaro.org/

Depends on:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20221124184333.133911-1-krzysztof.kozlowski@linaro.org/

Reported-by: Amit Pundir <amit.pundir@linaro.org>
https://people.linaro.org/~amit.pundir/linaro-sid-developer-dragonboard-845c-569/6.1-rc4_defconfig
Reproduced with ^^ defconfig SDM845 SoCs

Sibi Sankar (4):
  arm64: dts: qcom: Introduce a carveout for modem metadata
  dt-bindings: remoteproc: qcom: sc7180: Update memory-region
    requirements
  dt-bindings: remoteproc: qcom: q6v5: Update memory region requirements
  remoteproc: qcom_q6v5_mss: Use a carveout to authenticate modem
    headers

 .../bindings/remoteproc/qcom,q6v5.txt         | 29 ++++++-
 .../remoteproc/qcom,sc7180-mss-pil.yaml       |  3 +-
 .../remoteproc/qcom,sc7280-mss-pil.yaml       |  3 +-
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  |  6 ++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  9 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  9 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts       |  7 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  |  7 +-
 .../dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  7 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  9 ++
 drivers/remoteproc/qcom_q6v5_mss.c            | 85 +++++++++++++------
 11 files changed, 142 insertions(+), 32 deletions(-)

-- 
2.17.1

