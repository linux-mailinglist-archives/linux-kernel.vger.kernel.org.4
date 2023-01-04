Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E791665D44C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 14:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjADNcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 08:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjADNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:31:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862866586;
        Wed,  4 Jan 2023 05:29:40 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304C2SSX031851;
        Wed, 4 Jan 2023 13:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=fUw5rIZT+w0OaKCTkpkfHTn9ZdkIHNTL3qKKX182P/U=;
 b=IBDvQlm0JNzBPu+Zz1ZW8nAbLzmRcZOaGWXCKR1AKGgPgTzG/1TCtp/cs0TqrXnDB/2A
 B5IpTEZER/KNGY7Y+usbZcam29cKDVGiIsxERuK8qHqcQsqcDAH2ifWzJCTLWDV6bwDN
 sguJCngVMyzJtQbPZ5jbkEuYCWKsysGpdomv1JvDusjXoVZf0PE6F9yABN1cq27g4OOb
 ay01klX6ZLGk5Jh1Daou+7ah6Dtwl++bIpQeDnl0hTI4C+574Md6yLTjJQWMoM66GT9s
 g+dLiL9ItHaXYiLikO3ThuV1dT+PjwP/JCAIFM2k+ACmZyA02eI/5N52vvM6+a/FkCkk Xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvva0hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 13:29:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304DTVaj006473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 13:29:31 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 05:29:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 0/4] Add resets for ADSP based audio clock controller driver.
Date:   Wed, 4 Jan 2023 18:59:11 +0530
Message-ID: <1672838955-7759-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8CKuKcmpTFeTP3ljGXgEbwlEVXgIRLut
X-Proofpoint-GUID: 8CKuKcmpTFeTP3ljGXgEbwlEVXgIRLut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=706
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301040113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clcok controller for audioreach based platforms. 

Changes since v2:
    -- Avoid Removing qdsp6ss clock control by conditional check.
Changes since v1:
    -- Update commit message.
    -- Remove qdsp6ss clock control.

Srinivasa Rao Mandadapu (4):
  dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode
    property
  dt-bindings: clock: qcom,sc7280-lpasscc: Add resets for audioreach
  clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
  clk: qcom: lpasscc-sc7280: Add resets for audioreach

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        | 19 +++++++++++--
 drivers/clk/qcom/lpasscc-sc7280.c                  | 33 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.7.4

