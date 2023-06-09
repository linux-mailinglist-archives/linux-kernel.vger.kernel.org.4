Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583FA7298A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbjFILwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjFILvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:51:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7A1A2;
        Fri,  9 Jun 2023 04:51:26 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359B0683010213;
        Fri, 9 Jun 2023 11:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6cgGnHRKv+6/MYXYjEBobhWbvjL83DTMvCKRv9xXq9I=;
 b=Ptqle11p39TRfuAAuNhRMoxAKABDDmaEVtQg78O6jk21dXVG5TzfAaptkyaNDp40Di1j
 4AHok6spGRXGadqmvliZjNb19isYL4cb+bfKj5M+fSLaXbTcQDwT8RnwKlnSjfdFx0nQ
 KrzmMDbl+BjlNaYa8zDKDL4t3zxoF6lmPrivbrEnaYT6gL8TmVB92E9fvJYfoPW4BZDO
 pAA2yfaclEt9l9EpTVXAbSwxTe4Q1RzVzk8jBA7dx6Dbx+H2mnNm1S0x0vgm+ebApjne
 N61FPCTWQb0w/79HwV4d8FDb8sw28Dl5Mg9Q0UbqfUlYfQWp4XMaLLySWNdisDkQdxTl Kg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3nwesd35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:51:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359BpL9L018729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 11:51:21 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 9 Jun 2023 04:51:16 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>
Subject: [PATCH V4 0/4] Add camera clock controller support for SM8550
Date:   Fri, 9 Jun 2023 17:20:54 +0530
Message-ID: <20230609115058.9059-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FBiQkUJfck_KqJt-psMpUb6QfuSjew3r
X-Proofpoint-ORIG-GUID: FBiQkUJfck_KqJt-psMpUb6QfuSjew3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=798 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 spamscore=0 adultscore=2 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for camera clock controller on
SM8550.

Jagadeesh Kona (4):
  dt-bindings: clock: qcom: Add SM8550 camera clock controller
  clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
  clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
  arm64: dts: qcom: sm8550: Add camera clock controller

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8550.c               | 3585 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
 6 files changed, 3801 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

-- 
2.40.1

