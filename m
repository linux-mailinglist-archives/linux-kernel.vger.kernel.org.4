Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1673BCFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjFWQsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjFWQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:47:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF71C2735;
        Fri, 23 Jun 2023 09:47:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NGhGPO016936;
        Fri, 23 Jun 2023 16:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Z6+SB4ohsS49JKH4HQU+4u1O4VMhQYGbD+UgaCnfiv4=;
 b=kkEtQsVsXhPzxpPBNhrrxhJpnY3whe317zluFqIlaM0B80fAb14n4rLhyF/RHf2rmETf
 gVbm/m0lJgKas6RhrXgpk7O72ZlsH7yEM3UkibTAVhAlRGwu6yV2c8IIXSTg0E0g8OyA
 Q68aFTf7B7vUhuTkRJbkKvo79zHnc1T6CuzDb4jqG1N3z/RNJtMjcOW1pFXYw+ck4yOh
 rw5/cXwGBpNOKNOmFh1AuRY3cLloBLkgr9N2cOywbffdmUhd+z1cJA2awcyKjy8E4KF2
 eEG35gvgr3fsq95fDSWE3IcxGaCtJ43N8IVTnGVPOr6/Y/uSYJVxttJP+1tapzGvNEYB 7A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcj6nc3hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:47:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NGleSL029227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:47:40 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 23 Jun 2023 09:47:35 -0700
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
Subject: [PATCH V5 0/5] Add camera clock controller support for SM8550
Date:   Fri, 23 Jun 2023 22:16:14 +0530
Message-ID: <20230623164619.11464-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LKUYSrflC1fFTa2WkpASDOxbwLvFd96b
X-Proofpoint-ORIG-GUID: LKUYSrflC1fFTa2WkpASDOxbwLvFd96b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230150
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

Changes in v5:
 - Added clk_lucid_ole_pll_configure() to configure lucid ole PLL's
 - Used module_platform_driver() instead of subsys_initcall()
 - Fixed overloading .l config with CAL_L and RINGOSC_CAL_L fields

Changes in v4:
 - Dropped the extra patches added in v2, since the review comments on
   v3 recommended an alternate solution

Changes in v3:
 - Squashed 2 extra patches added in v2 into single patch as per review
   comments

Changes in v2:
 - Took care of review comments from v1 
     + Removed new YAML file and reused SM8450 CAMCC YAML file for SM8550
     + Sorted the PLL names in proper order
     + Updated all PLL configurations to lower case hex
     + Reused evo ops instead of adding new ops for ole pll
     + Moved few clocks to separate patch to fix patch too long error
     + Padded non-zero address part to 8 hex digits in DT change
 - Added 2 extra patches updating .l config value across chipsets to include
   CAL_L and RINGOSC_CAL_L fields and removed setting CAL_L field explicitly
   in clk_lucid_evo_pll_configure().

v1:
  - Initial CAMCC changes for SM8550

Previous series:
v4: https://patchwork.kernel.org/project/linux-clk/list/?series=755683 
v3: https://patchwork.kernel.org/project/linux-clk/list/?series=753150
v2: https://patchwork.kernel.org/project/linux-clk/list/?series=751058
v1: https://patchwork.kernel.org/project/linux-clk/list/?series=749294

Jagadeesh Kona (5):
  dt-bindings: clock: qcom: Add SM8550 camera clock controller
  clk: qcom: clk-alpha-pll: Add support for lucid ole pll configure
  clk: qcom: camcc-sm8550: Add camera clock controller driver for SM8550
  clk: qcom: camcc-sm8550: Add support for qdss, sleep and xo clocks
  arm64: dts: qcom: sm8550: Add camera clock controller

 .../bindings/clock/qcom,sm8450-camcc.yaml     |    8 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |   15 +
 drivers/clk/qcom/Kconfig                      |    7 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/camcc-sm8550.c               | 3563 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |   29 +
 drivers/clk/qcom/clk-alpha-pll.h              |    2 +
 include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
 8 files changed, 3810 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

-- 
2.40.1

