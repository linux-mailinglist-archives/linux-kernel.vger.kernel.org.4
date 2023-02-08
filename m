Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3368E791
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 06:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBHFeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 00:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHFeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 00:34:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08B25E18;
        Tue,  7 Feb 2023 21:34:21 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3185Y0L9018269;
        Wed, 8 Feb 2023 05:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=OvjVQPQcigxEIozH/JTu6OfAGT/nQbLlMSiDVbZhOWQ=;
 b=Lo4grIUnlQMHF2MTuFks44BmLrXW+wPeiUVScHHd5TJjbSGPRU0wDcKe0/s1CuKSSgYm
 7q8gydZXZfgJKmfHdaHhf8J4ZyuT+6w3XxmT3rTV9/vIOvdDn5IY2rRl2YRpryLoNxIE
 33otw2meJfp41FKnXd7sObyM+XqqpBS1HNqHyYzQvdsR7SVx0L4FH4y4tjoYln5oInoi
 MkjJ/jic8kXR834HQAC6xfg+BCbhssUKWpEWeQIXURxIzCKI+4igVujWveKk3bnPTG0s
 rw0gPS/bkIol9DhjgrfgLZZkrRG5yhtuugdyaUEMoVuosZYCYAOEp+DEqtE7ZC2H21OY 9w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf0h88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 05:34:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3185Xw0x018386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 05:33:58 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 21:33:48 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V3 0/5] Enable crashdump collection support for IPQ9574
Date:   Wed, 8 Feb 2023 11:03:27 +0530
Message-ID: <20230208053332.16537-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XYUo76ExZ5pxeUolcPFX1CnNe6gHr7Sz
X-Proofpoint-GUID: XYUo76ExZ5pxeUolcPFX1CnNe6gHr7Sz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_02,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=782 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crashdump collection is enabled based on the DLOAD bit in the TCSR register.
This bit is set during bootup and cleared during shutdown. During crash,
dload bit is not cleared, due to which uboot starts crashdump collection.

This patch series adds the support for crashdump collection.

DTS patch depends on the IPQ9574 baseport series
https://lore.kernel.org/linux-arm-msm/20230206103337.21000-1-quic_devipriy@quicinc.com/

V3:
	- change logs are added to the respective patches.

V2 can be found at 
https://lore.kernel.org/linux-arm-kernel/20230201090529.30446-1-quic_poovendh@quicinc.com/

Changes in V2:
	- rebased on linux-next/master
        - dropped co-developed by tag wherever applicable
	- V1 can be found at
	  https://lore.kernel.org/linux-arm-kernel/20230113160012.14893-1-quic_poovendh@quicinc.com/

Poovendhan Selvaraj (5):
  dt-bindings: scm: Add compatible for IPQ9574
  arm64: dts: qcom: Add support for Crashdump collection on IPQ9574
  firmware: scm: Modify only the DLOAD bit in TCSR register for download
    mode
  arm64: defconfig: Enable scm download mode config for IPQ Targets
  dt-bindings: mfd: Add the tcsr compatible for IPQ9574

 .../bindings/firmware/qcom,scm.yaml           |  1 +
 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 26 ++++++++++++++++++-
 arch/arm64/configs/defconfig                  |  1 +
 drivers/firmware/qcom_scm.c                   | 12 ++++++---
 5 files changed, 36 insertions(+), 5 deletions(-)


base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
-- 
2.17.1

