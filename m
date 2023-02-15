Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F0697F36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBOPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBOPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:14:49 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8F83F7;
        Wed, 15 Feb 2023 07:14:48 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FF7JSU009096;
        Wed, 15 Feb 2023 15:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=og6EfHPhWk0c/cGRG5aYCGGmctUJxAFh5Ec+L4vdgdo=;
 b=plLaL8/lIvbwd9rS1DNyP37C4aFfLUSYsdAnhUiR+Ko2gtpTbAk4EJ/w18vlbyO7FPmy
 4gfVjH8yQ180W/IHqf+czl1Muqw0rVzDUd5V38NID0X05onDcxI22Klrrot2fJ+ES6rB
 gakkMdPeqgkU/6BJPGws07cU7OJ64s0fxSWiuYExxAsjn52LuuezUcxYi+Enka1TnsRE
 Ho+TQkeaOi+FLPRvO5m3Dag7bPh8a65e2XX0eVnloAhv/uH6YfmrYU+ayX/JyB7DYFaJ
 vMK/sDEZqhKOvKoWipr8aGHdWKEAITAgq+qUgUWgk97/hHq6kFscWrbi0W0IsYNgsWG8 Kw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrtmuh54a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:14:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FFEd4j003134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:14:39 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 15 Feb 2023 07:14:34 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [RESEND v8 0/5] Add resets for ADSP based audio clock controller driver
Date:   Wed, 15 Feb 2023 20:43:25 +0530
Message-ID: <20230215151330.539885-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p2pEsP-j0QBYFu_47Pb64Cg1EjITvJQj
X-Proofpoint-GUID: p2pEsP-j0QBYFu_47Pb64Cg1EjITvJQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=652 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clcok controller for audioreach based platforms. 
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

Srinivasa Rao Mandadapu (5):
  dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode
    property
  dt-bindings: clock: lpassaudiocc-sc7280: Add binding headers for
    lpasscc
  clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
  clk: qcom: lpassaudiocc-sc7280: Merge AHB clocks into lpass_aon
  clk: qcom: lpassaudiocc-sc7280: Skip lpass_aon_cc_pll config

 .../bindings/clock/qcom,sc7280-lpasscc.yaml       |  7 +++++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c            | 15 ++++++++++++---
 drivers/clk/qcom/lpasscc-sc7280.c                 | 12 +++++++-----
 .../dt-bindings/clock/qcom,lpassaudiocc-sc7280.h  |  2 ++
 4 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.25.1

