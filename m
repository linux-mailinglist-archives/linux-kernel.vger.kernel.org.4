Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DC9712A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjEZQMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjEZQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:12:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E11194;
        Fri, 26 May 2023 09:12:07 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QC0bAA005049;
        Fri, 26 May 2023 16:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5f8QxYH454fr/3MxMEIQ6nF2pEfAdcsobX+bKB2IjKg=;
 b=T1G1FjYpoa9v6lUKqxeqXD627zCd9BFxShXF6nuGEVF+Pp32FbEUcfd17Wi9jrRYqBHf
 q2/4COpaB9ahmZA7+R66GUmK35/4pZSgoTVVmYArZdjzlZ23k1mHsj2z6uG7B61nAdl4
 oX50lh9jAtmzVZMlb9YWFashWE3n+SzP9SxwmMcegKlDHy9KtMCeGBtnDRIvTV0r48xb
 8gpoflNRJTTUkyZUXmQUfdEyIsjATjH48jDDG8VnOfXn5P8JR3/W8u775pECRWO44y9/
 yZ10pBLSbtq1mqPgSYqUt7t6XexFJ29DK99aANlAejGxuZIrBz1anmMMpBPWvgCR5eDS iQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtq28h7cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:11:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QGBswW007244
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:11:54 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 09:11:47 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V4 0/4] Enable crypto for ipq9574
Date:   Fri, 26 May 2023 21:41:25 +0530
Message-ID: <20230526161129.1454-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9zOKCWi4Men4E7VMFGjcRvDElveEPond
X-Proofpoint-ORIG-GUID: 9zOKCWi4Men4E7VMFGjcRvDElveEPond
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=797 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260137
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC driver to include clocks required for crypto.
Enable crypto nodes in ipq9574.

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-msm/20230517072806.13170-1-quic_kathirav@quicinc.com/

Changes in V4:
	Detailed change logs are added to the respective patches.

V3 can be found at:
https://lore.kernel.org/linux-arm-msm/20230518141105.24741-1-quic_anusha@quicinc.com/

V2 can be found at:
https://lore.kernel.org/linux-arm-msm/20230515150722.12196-1-quic_anusha@quicinc.com/

V1 can be found at
https://lore.kernel.org/linux-arm-msm/20230512090134.9811-1-quic_anusha@quicinc.com/

Anusha Rao (4):
  dt-bindings: clock: Add crypto clock and reset definitions
  clk: qcom: gcc-ipq9574: Enable crypto clocks
  dt-bindings: qcom-qce: add SoC compatible string for ipq9574
  arm64: dts: qcom: ipq9574: Enable crypto nodes

 .../devicetree/bindings/crypto/qcom-qce.yaml  |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 20 ++++++
 drivers/clk/qcom/gcc-ipq9574.c                | 72 +++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq9574-gcc.h  |  4 ++
 include/dt-bindings/reset/qcom,ipq9574-gcc.h  |  1 +
 5 files changed, 98 insertions(+)


base-commit: aabe491169befbe5481144acf575a0260939764a
-- 
2.17.1

