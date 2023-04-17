Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357506E4278
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDQIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDQIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:22:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1626B2;
        Mon, 17 Apr 2023 01:22:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H8E0pc025933;
        Mon, 17 Apr 2023 08:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=2z3lDab7wSaYmLD4EKf2LqwTGMMqhl1sykbi65azdkQ=;
 b=iCN7pP+KlVp/nx90F+nsRgJT+8//G1uScza1/s/G72CstVXFCP69oESeb8TFf7A05+87
 oAWJD0rHdiQJH5LpcI3FR846jCi2fviX3lPlpa36Qq6N3JoMx/MyaAcOF6oEraELCbhe
 QMy0UWOza0COC+Zbv8L2ktYg33PfSEXEFFPEiqAkJl6npHaqqZuZ+OLsqPYz5EYH2DGl
 GDpRcYjNEp9sYFQjJGETdZLsZQboz9Sk7caCJDBe5/SBx9zWavS05T/0aTTG7DrZMNW0
 RUS+B/JdV/Ev0Yw7ldVwiERh02c29AQiUepMpgpYA/3BgdAdq87lOT5CC2cVN5v/IPQc 9Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn3tjv9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 08:22:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H8MM8x024127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 08:22:22 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 01:22:17 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmitry.baryshkov@linaro.org>, <quic_skakitap@quicinc.com>,
        <quic_jkona@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH V2 0/3] Add video clock controller driver for SM8450
Date:   Mon, 17 Apr 2023 13:51:24 +0530
Message-ID: <20230417082127.11681-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6MWsRA9rXtZjoQ9vYpT-5BE9HDwKxH7d
X-Proofpoint-ORIG-GUID: 6MWsRA9rXtZjoQ9vYpT-5BE9HDwKxH7d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=620 adultscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and DT node for video clock controller on SM8450.

Taniya Das (3):
  dt-bindings: clock: qcom: Add SM8450 video clock controller
  clk: qcom: videocc-sm8450: Add video clock controller driver for
    SM8450
  arm64: dts: qcom: sm8450: Add video clock controller

 .../bindings/clock/qcom,sm8450-videocc.yaml   |  84 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  13 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/videocc-sm8450.c             | 459 ++++++++++++++++++
 .../dt-bindings/clock/qcom,videocc-sm8450.h   |  38 ++
 6 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 drivers/clk/qcom/videocc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8450.h

--
2.25.1

