Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08116598EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiL3NoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbiL3NoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:44:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A61F1903D;
        Fri, 30 Dec 2022 05:44:01 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUDh2NO013467;
        Fri, 30 Dec 2022 13:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=8ehgi7oC/NPIxjgcdrjik7M50UxwoL2gHYwPbhnQ2oI=;
 b=GWVDeTuqSKnPyzkK1QWE4N+nTm/T0Q7l6L8xnxCNFqG4RB6/7YDVq2C1mzyajqnWv1Tr
 0KcS2hMxCFw82hJCQ5ol4KnVDfYKPYuB17dCkU1YTnCg0NLEj+XlbtJDY3pLwRJVaCxl
 6UW6NV3NmQ1LBYpyaOykXpOOyZd7XXN92vSWZKaO1H4dJrlTAYBHkC2r2OPmKnqZx/fj
 eMPJP9Os3ILAV2RIQiQgY+mjKtA0s96WqxdKgWKYFp0m+l41Evl3VHDJp4YBexl1YWFB
 fn0TcfiiMw4pw6eQvHhPM05bTilgD6eSmorcJ8oSY9FXvPylnRHza7NPmR+wZjAhNNO0 fQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mswk8raxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:43:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BUDhklY005504
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 13:43:46 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 30 Dec 2022 05:43:41 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 0/4] Add resets for ADSP based audio clock controller driver.
Date:   Fri, 30 Dec 2022 19:13:15 +0530
Message-ID: <1672407799-13768-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zMH91jDL3-ZHBjCNDxHU1-R5TSlNOT9u
X-Proofpoint-GUID: zMH91jDL3-ZHBjCNDxHU1-R5TSlNOT9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_08,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=826
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clcok controller for audioreach based platforms. 

Chnges since v1:
    -- Update commit message.
    -- Remove qdsp6ss clock control.

Srinivasa Rao Mandadapu (4):
  dt-bindings: clock: qcom,sc7280-lpasscc: Remove qdsp6ss reg property
  dt-bindings: clock: qcom,sc7280-lpasscc: Add resets for audioreach
  clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock control
  clk: qcom: lpasscc-sc7280: Add resets for audioreach

 .../bindings/clock/qcom,sc7280-lpasscc.yaml        | 14 +++--
 drivers/clk/qcom/lpasscc-sc7280.c                  | 66 +++++-----------------
 2 files changed, 22 insertions(+), 58 deletions(-)

-- 
2.7.4

