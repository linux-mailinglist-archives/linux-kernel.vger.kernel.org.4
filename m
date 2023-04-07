Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1926DAACA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbjDGJXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbjDGJXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:23:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9166283C0;
        Fri,  7 Apr 2023 02:23:43 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377ME9R028672;
        Fri, 7 Apr 2023 09:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=cuzmSQCjSKwcDD9KbSa3FwHIeHuBiI4YqOnU2J0y1c4=;
 b=YR0TzhrJc47dYMcGAJhiXrId7RM/nZCW/vNJqoEQEW+valhgk7vOUVj6TatJ05G5wwyY
 O4XAT/eX27QFloRwbekHIwNF7Yy1O9Ft148aPpfUyYzGfYo5KUugQUGWk2k53zLtT4c1
 Ipsrb96g5tVw0VBXV3j/vv3TB16OEzNXKAeGkltl6T3JRUmHFaZ2MYk3t/T2QN/V/ZmE
 Ws4Zcaz40YjyJZ2JhXzfnrBXPN/KGZ/WCXUrlqCoqCQWmilPmuVcjWRSItfRjV73Esxi
 vzyScTX57/4FC9J3Bv0LQZ5oWZ74EYDisCIegkhHKdEFBQ9QivI8r5Bye6pClbMSJoYb ZA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptcrn0dn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:23:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3379NRi6009216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 09:23:27 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 02:23:22 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v11 0/3] Add resets for ADSP based audio clock controller driver
Date:   Fri, 7 Apr 2023 14:52:52 +0530
Message-ID: <20230407092255.119690-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vXCWGOL1dPv692pcAyJBUB1cYjleCJXg
X-Proofpoint-GUID: vXCWGOL1dPv692pcAyJBUB1cYjleCJXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=974 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070086
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clock controller for audioreach based platforms.

Changes since v10:
    -- drop #define macro for max_register.
    -- Add max_register value for top_cc register.
Changes since v9:
    -- Drop "clk: qcom: lpassaudiocc-sc7280: Modify qcom_cc_probe" patch.
    -- Update Fixes tag in Add the required gdsc's in lpass_cc_sc7280_desc patch.
    -- Add the max_register value in Skip qdsp6ss clock registration patch.
Changes since v8:
    -- Add the required gdsc's in lpass_cc_sc7280_desc structure.
    -- Modify qcom_cc_probe to qcom_cc_probe_by_index.
    -- Update the commit message for v8,4/5 patch, which is not required for new logic.
    -- Drop "Add binding headers for lpasscc" patch.
    -- Drop "Skip lpass_aon_cc_pll config" patch.
Changes since v7:
    -- Modiy AHB clock probing method in "Merge lpasscc into lpass_aon patch".
    -- Fix Typo errors in "Merge lpasscc into lpass_aon patch".
    -- Update commit message in "Merge lpasscc into lpass_aon patch"
Changes since v6:
    -- Update commit message in "Merge lpasscc into lpass_aon patch" patch.
    -- Drop "Skip lpasscorecc registration" patch.
    -- Add comment in the code in "Skip lpass_aon_cc_pll config" patch.
Changes since v5:
    -- Fix compilation issue.
Changes since v4:
    -- Update Fixes tag in Merge lpasscc into lpass_aon patch.
    -- Revert removal of clk_regmap structure in Merge lpasscc into lpass_aon patch.
Changes since v3:
    -- Remove duplicate clock resets patch.
    -- Add binding headers for q6 clocks.
    -- Create new patch for merging lpasscc q6 clocks into lpass_aon.
    -- Create new patches for handling conflicts of ADSP and bypass solution.
Changes since v2:
    -- Revert removing qdsp6ss clock control.
    -- Add Conditional check for qdsp6ss clock registration.
Changes since v1:
    -- Update commit message.
    -- Remove qdsp6ss clock control.

Mohammad Rafi Shaik (1):
  clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in
    lpass_cc_sc7280_desc

Srinivasa Rao Mandadapu (2):
  dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode
    property
  clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration

 .../bindings/clock/qcom,sc7280-lpasscc.yaml      |  7 +++++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c           |  2 ++
 drivers/clk/qcom/lpasscc-sc7280.c                | 16 ++++++++++------
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.25.1

