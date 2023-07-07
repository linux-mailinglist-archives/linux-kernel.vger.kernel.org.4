Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B5574A987
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 05:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGGD66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 23:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGGD6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 23:58:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6FE1FD8;
        Thu,  6 Jul 2023 20:58:54 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3673BxeF022462;
        Fri, 7 Jul 2023 03:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=ykw/5J1G41sJtF9h3i5KKBlxAwm6E2iNoi0rNzWZwVc=;
 b=Dq60AyVRChHgZsRX1+bYSu9vLvBmwkaxA+fsjlgV+3blQ+M581rvIJ6CyFxwhqBB1JC+
 KF39X4kAtkXgpRZqVHIvUFxW22tAV8MrEtxauO9cZcuUTFUD9LyJiPAKFGZutaFSoXWc
 GQpwbb55Xpa5GfgMLW6UIoqA0dYOIQ++zAtYF4KIKLcHW+Oq06klnphJoVy3qBymhyGX
 c9swSj944MIgAJD+eLmU2KCli67ZmDbRJ2z34qvi8j1/v3HgbkwxZ0fDvfHkxGrPKlF7
 m4Pe9aW2lSiCffaU9KH/w0VPiUdm6G0NfxPwWoGWB9lVMZj75v+QTCOh9jS4uBRKhj8s 7w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rp71y8cs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 03:58:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3673wlYr007139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 03:58:47 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 20:58:42 -0700
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V6 0/5] Add camera clock controller support for SM8550
Date:   Fri, 7 Jul 2023 09:27:39 +0530
Message-ID: <20230707035744.22245-1-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N0On_-0hIDR6XVpG_B5nVepQAvUXyUmV
X-Proofpoint-ORIG-GUID: N0On_-0hIDR6XVpG_B5nVepQAvUXyUmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_01,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070035
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings, driver and devicetree node for camera clock controller on
SM8550.

Changes in v6:
 - Updated parent map and frequency table of cam_cc_xo_clk_src to use
   active only source P_BI_TCXO_AO instead of P_BI_TCXO

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
 - Added 2 extra patches updating .l config value across chipsets to
   include CAL_L and RINGOSC_CAL_L fields and removed setting CAL_L
   field explicitly in clk_lucid_evo_pll_configure().

v1:
  - Initial CAMCC changes for SM8550

Previous series:
v5 - https://patchwork.kernel.org/project/linux-clk/list/?series=759863
v4 - https://patchwork.kernel.org/project/linux-clk/list/?series=755683 
v3 - https://patchwork.kernel.org/project/linux-clk/list/?series=753150
v2 - https://patchwork.kernel.org/project/linux-clk/list/?series=751058
v1 - https://patchwork.kernel.org/project/linux-clk/list/?series=749294

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
 drivers/clk/qcom/camcc-sm8550.c               | 3564 +++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c              |   29 +
 drivers/clk/qcom/clk-alpha-pll.h              |    2 +
 include/dt-bindings/clock/qcom,sm8550-camcc.h |  187 +
 8 files changed, 3811 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/qcom/camcc-sm8550.c
 create mode 100644 include/dt-bindings/clock/qcom,sm8550-camcc.h

-- 
2.40.1

