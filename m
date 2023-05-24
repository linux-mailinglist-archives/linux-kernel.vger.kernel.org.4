Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA670F845
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjEXOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjEXOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:07:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E96A12F;
        Wed, 24 May 2023 07:07:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ODSH4m017742;
        Wed, 24 May 2023 14:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=wWxZuTEU79yc4Hjrga9jnv6GGG/FJXNpjv60di4DHZs=;
 b=aejLyROnyCW59DemdTYLs5LBWehiztDhb02XhfPbjdDz3xS8MsHIPH+mmViLNQUxMh2k
 aFgzqBNlydiC5JlFz+3We13e3hpmsEQS26JqYoKR5Df8cmqBpYRNVJNxBr2a+91Dytsz
 wbU6O9zsZ9SmfToxJa3WJm0FvpEdk03lpQ4DoZN9JwL7zYjuTgyJPr3au5zUzDjBrzIG
 XG6CzA9DiiTWmYarxuXDJYZ3A6ZjzoW5SBvW39D+ydCvi0wC39xr4U38iGf+bdcGoDw3
 0Fyw+FHd7aJBXgQkPxsI5loAkd0sHDi1mbiQRFzbTSgc7xQqSyG9y95nJ6s2XkEzzXnA ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qscpms1ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:07:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OE7Dmt016874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:07:13 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 07:07:08 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, <quic_jkona@quicinc.com>,
        <quic_imrashai@quicinc.com>, <quic_ajipan@quicinc.com>
Subject: [PATCH V5 0/3] Add video clock controller driver for SM8450
Date:   Wed, 24 May 2023 19:36:53 +0530
Message-ID: <20230524140656.7076-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9HzUGtSCpC3pHF13V_Zy5gp40WETk1Zq
X-Proofpoint-GUID: 9HzUGtSCpC3pHF13V_Zy5gp40WETk1Zq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=709 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305240115
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

 .../bindings/clock/qcom,sm8450-videocc.yaml   |  77 +++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  13 +
 drivers/clk/qcom/Kconfig                      |   9 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/videocc-sm8450.c             | 463 ++++++++++++++++++
 .../dt-bindings/clock/qcom,sm8450-videocc.h   |  38 ++
 6 files changed, 601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
 create mode 100644 drivers/clk/qcom/videocc-sm8450.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h

--
2.17.1

