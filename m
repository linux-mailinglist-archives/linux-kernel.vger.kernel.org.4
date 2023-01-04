Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68465D7AD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbjADP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjADP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:58:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5362AE9;
        Wed,  4 Jan 2023 07:58:38 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304Dac8R011623;
        Wed, 4 Jan 2023 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=lxbXq7tSXdc2NhdKJ648YCpDm7VY9JfrIMWfq28a2WE=;
 b=KlzRNdAdI5eozuAna1gLTiasOGbHIwJAmtZyUN3o9GOlH0XGANB4Sk7GAaZKhJzTVUfZ
 v6Pz1ABQS3eNSQUbUByVCXPsC2B7u1gA8mEKclrimOs2rmH8+kFl1e9tjpSKJXvpIFaT
 JG20X4xRN9Z+hEo0+wYNvx0fU41OaXr8aysA4XC9gQ6uLyxo499xeJeJ1LXigSVCL1ac
 AeETHDiBwh5qBDfCY7got0Yu0zw46vLTZq6dS79jl5e4M0JQl3QkGtA2B8LdndamoluC
 kXnwuqFZIgs87Xu4PjKJ1L3+Beget9936cCBMAfoC28UagrAnw4mFdtESEWsZUY2QLhU tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mvsvf24sa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 15:58:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 304FwUgn000716
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Jan 2023 15:58:30 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 4 Jan 2023 07:58:25 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [RESEND v3 0/4] Add resets for ADSP based audio clock controller driver
Date:   Wed, 4 Jan 2023 21:28:08 +0530
Message-ID: <1672847892-25154-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 90CwTaOiokZFtoPRuIlym-W2J9NszD0K
X-Proofpoint-GUID: 90CwTaOiokZFtoPRuIlym-W2J9NszD0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=729 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301040132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clcok controller for audioreach based platforms. 

Changes since v2:
    -- Revert removing qdsp6ss clock control.
    -- Add Conditional check for qdsp6ss clock registration.
Changes since v1:
    -- Update commit message.
    -- Remove qdsp6ss clock control.

Srinivasa Rao Mandadapu (4):
  dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode
    property
  dt-bindings: clock: qcom,sc7280-lpasscc: Add resets for audioreach
  clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
  clk: qcom: lpasscc-sc7280: Add resets for audioreach

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        | 19 ++++++++++--
 drivers/clk/qcom/lpasscc-sc7280.c                  | 35 ++++++++++++++++++----
 2 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.7.4

