Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FDA6FCADB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjEIQNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEIQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:13:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179062127;
        Tue,  9 May 2023 09:13:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3499fM1H000749;
        Tue, 9 May 2023 16:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Zz2N2vjsVNBXoJHbJxbRu49xaoPrGAB9qN3fJeEIAHU=;
 b=dIzGhzc9J1D9eOOjrtjEpbLQQiJAvh+bJWkdVOv8KSwQEG8F8Hj09cfaAG1cXNf3VyDz
 ab3IjSGZumr/pjquS/oWLl2V0wqjgi0gsDhS8skh3WzxM5WlQeePJz63u1AtyTSbmyZH
 REyUHjECNnDd1HpQWodKcC+BUPv2vgqQpLUZyZAcXvK+7531SlxkWPzKzWwPOPNSrORL
 AYWBO8WY6/K1jlI/+0d6VF04eT2izXcCZVTq2RdudpRbUUrzy8SWU1AWLw1ax2gdLvOV
 Uieif09NfrUvkMuKoQxGGV7I+BaTSvPlXNOHYhrYdHNli7mWxx45DmA4d2CafurmcYPe Gg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77j2ab4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 16:13:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349GD629015822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 16:13:06 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 9 May 2023 09:13:01 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Taniya Das" <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Add Video Clock Controller driver for SM8550
Date:   Tue, 9 May 2023 21:42:14 +0530
Message-ID: <20230509161218.11979-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nbWSh9eWkMkrPD_dMWVwtpz5RAfvrbMW
X-Proofpoint-GUID: nbWSh9eWkMkrPD_dMWVwtpz5RAfvrbMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_09,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=685 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305090133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and DT node for video clock controller on SM8550.
Also, add support for lucid ole pll ops.

Jagadeesh Kona (3):
  dt-bindings: clock: qcom: Add SM8550 video clock controller
  clk: qcom: videocc-sm8550: Add video clock controller driver for
    SM8550
  arm64: dts: qcom: sm8550: Add video clock controller

Taniya Das (1):
  clk: qcom: clk-alpha-pll: Add support for lucid ole pll ops

 .../bindings/clock/qcom,sm8550-videocc.yaml   |  77 +++
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  12 +
 drivers/clk/qcom/Kconfig                      |  10 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clk-alpha-pll.c              |   2 +
 drivers/clk/qcom/clk-alpha-pll.h              |   4 +
 drivers/clk/qcom/videocc-sm8550.c             | 468 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sm8550-videocc.h   |  38 ++
 8 files changed, 612 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8550-videocc.yaml
 create mode 100644 drivers/clk/qcom/videocc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-videocc.h

-- 
2.25.1

