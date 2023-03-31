Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3560F6D23F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjCaP2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjCaP2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:28:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B891BF54;
        Fri, 31 Mar 2023 08:28:40 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V9XJKc020114;
        Fri, 31 Mar 2023 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=6qcypVzMNkLWeZ9yXHpWDaOXDE2ERBXhQP32pFnzclw=;
 b=CXow/l59loWE6/v1jTeziB1HFfRrDIjiFyG/Prx/HN6/lHWk1WOgSMhn2/UlSe61TMCJ
 oUYoX0u7cUkDMYnC3/7OlsZ2KaTXPo8lgzOV6c13pM4KfkYCFqeRMl+lyl4Vh35KMlBK
 MqRBIxf3seR5cOWCJvkrsjbIBEjFyJOQ+7zpeL7naH/62e21toMIrpHqrI7noXqoSHQO
 tkSf0PwbddLURVc/yOpCM9U/iwtOwwSdvJOwKvnnc7wlsA9sGIPWyV/Br5GAj32jiUdY
 /QU7rdLFZNmU6gxKx8jOE5B4HIPxkRsRBL7xkgAUCuOuwP8rbGgLttAVo009QnJSQruQ Ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pnvyuh807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:33 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32VFSVAE014668
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 15:28:31 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 31 Mar 2023 08:28:27 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v10 0/3] Add resets for ADSP based audio clock controller driver
Date:   Fri, 31 Mar 2023 20:58:02 +0530
Message-ID: <20230331152805.3199968-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QZkWOzbuG4h9BA9kZSO4GgG9gOGvFzEO
X-Proofpoint-ORIG-GUID: QZkWOzbuG4h9BA9kZSO4GgG9gOGvFzEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxlogscore=923 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303310122
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clock controller for audioreach based platforms.

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

 .../bindings/clock/qcom,sc7280-lpasscc.yaml       |  7 +++++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c            |  2 ++
 drivers/clk/qcom/lpasscc-sc7280.c                 | 15 ++++++++++-----
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.25.1

