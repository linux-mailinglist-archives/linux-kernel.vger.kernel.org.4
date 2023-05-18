Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239EA7083A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjEROMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjEROMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:12:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3861B5;
        Thu, 18 May 2023 07:12:16 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8wZFR022296;
        Thu, 18 May 2023 14:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=LkrMDDc9iBtZ45s6C+tsBpRL5jdn9d9RJXAXRCAhMq0=;
 b=kFMyIXWqsYH0na5EBHXYeDWyaJT0PE+JAJ2rXS66MTBhClH36CE8ON+vmHrh/2dC7BqK
 EXgqRfi8Xi1Z4HdirHstBq9hiWbld4Ej+29WdPHrEA5sLaTHK9xN+/YQNf4pM2+nwCBO
 x+e98exOtSrD/rsnIJCU7FGYVzAaEiKMUchRGj5wrFIrg0DyQ/FDgWLPykiZ676pa1mv
 /iK3DR3ewK+YTDRdMv7ildwvfa10FWlN5CJ846VQGzA8l7dU4BmDi94H8+UoT+1XM5s8
 P3FDVJ9J5BJwGDgb4ihwlt+N4M/N0JfsVdnk/kF0iaR/dYhA267gD9lMTE1pTKMqhsQU QA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmxyp2wnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IEC2uw010622
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:02 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 07:11:56 -0700
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
Subject: [PATCH V3 0/4] Enable crypto for ipq9574
Date:   Thu, 18 May 2023 19:41:01 +0530
Message-ID: <20230518141105.24741-1-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kcZfL1pMlsxlAmOt-lKVjsZzpqWdx1pV
X-Proofpoint-GUID: kcZfL1pMlsxlAmOt-lKVjsZzpqWdx1pV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=807
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC driver to include clocks required for crypto.
Enable crypto nodes in ipq9574.

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-msm/20230517072806.13170-1-quic_kathirav@quicinc.com/

Changes in V3:
	Detailed change logs are added to the respective patches.

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

