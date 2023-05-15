Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB270311E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbjEOPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240266AbjEOPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:09:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175598E;
        Mon, 15 May 2023 08:09:28 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FEeO1r032689;
        Mon, 15 May 2023 15:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=InBVIMlnkWofTp5S12812/pi37LoP7ZSBEY0f7hfpI8=;
 b=ow+63MYSKRFuFmT8JPk9rS7Ogqw7gYhqiKaOG7ROcJKxZJXcBPyN7Vfc6mWha5g/NqO5
 VEdIjjZH59HY8W7APndved9qKdmB65mSKyazB02QKKY4n3W7wuLcIO2tdHqDcLYHw5n3
 y3gVJIPFB2NyGjnxyU2CdIq7fXnCWETbcfCA/zjxbAj0vnUxYcwhxVtAlEUFJ98Cxb3N
 JQoCNfnQ+DSXsNcaqxf2pHWhRh6eqKUvafih4n6T+tmZqgXHWwL1UeOB/w4wA/yEXJFR
 p4hoiHINCB57aWWPiw7Ypa3Efem0omVpOwQGQYyk/FRTdp5+zbbNOh4kJ8vZFfCcIPeW Ig== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjk18xma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FF89OZ010704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:09 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 08:08:01 -0700
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
Subject: [PATCH V2 0/4] Enable crypto for ipq9574
Date:   Mon, 15 May 2023 20:37:18 +0530
Message-ID: <20230515150722.12196-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R1223cSTB4yABx8GC3xOjvuVjKdCwKzU
X-Proofpoint-ORIG-GUID: R1223cSTB4yABx8GC3xOjvuVjKdCwKzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=806 clxscore=1011 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC driver to include clocks required for crypto.
Enable crypto nodes in ipq9574.

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-1-quic_kathirav@quicinc.com/

Changes in V2:
	Detailed change logs are added to the respective patches.

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

