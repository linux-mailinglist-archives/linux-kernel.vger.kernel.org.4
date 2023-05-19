Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999A70A1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjESVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjESVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:37:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621A1B0;
        Fri, 19 May 2023 14:37:45 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JLC3wr006345;
        Fri, 19 May 2023 21:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Acuo//OEBaHHc79dMa8wykfivPvrN1jyzUIJNRNq+rs=;
 b=oT2squvbvbdJJeKESoYcUS+cfAm0Ai1KWtUeFqiToz+J3bdu8DVdIr6TwWrETO16nvHD
 yJaQVZ2V97hfPOxGBpmkgpZqbyPCrX0fA3zYBOv2A573+ZA/epB4ldSoe4T8cQXpIBP8
 c/tNtvs4N6rSm/Fq94s/Ez7HHsKIxRnXgIcGds7Ndl9yaWARr73L8M1EEr5mAMb8DH+I
 G2IHgMSnh9JoWGJXJBCXqQCeqJfcXxlLGB8eX56DoIIs/qmEeEYbZk7Sl7ftkfqtq6oj
 qCloN4F7AU7yiN8MsoLZODx3R3MwGGNwqdezpQIYnNXL1oBXOrPUF3/tgOR4omE+GqGP Xw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4nt9xhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:37:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JLbeEs024058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 21:37:40 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 14:37:35 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
Subject: [PATCH 0/3] Add graphics clock controller support for SM8550
Date:   Sat, 20 May 2023 03:06:53 +0530
Message-ID: <20230519213656.26089-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m6or0cwevYGrGhfeWG4Yg2VG7RSVT40i
X-Proofpoint-GUID: m6or0cwevYGrGhfeWG4Yg2VG7RSVT40i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_16,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=963 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for graphics clock controller on SM8550.

Depends on [1] for lucid ole pll ops definition
[1] https://patchwork.kernel.org/project/linux-clk/list/?series=746186&state=%2A&archive=both

Jagadeesh Kona (3):
  dt-bindings: clock: qcom: Add SM8550 graphics clock controller
  clk: qcom: gpucc-sm8550: Add support for graphics clock controller
  arm64: dts: qcom: sm8550: Add graphics clock controller

 .../bindings/clock/qcom,sm8550-gpucc.yaml     |  67 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  12 +
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/gpucc-sm8550.c               | 609 ++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-gpucc.h |  48 ++
 6 files changed, 745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-gpucc.yaml
 create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-gpucc.h

-- 
2.40.1

