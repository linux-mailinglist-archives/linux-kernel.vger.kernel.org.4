Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AB16B77BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjCMMlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCMMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:41:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA454509BF;
        Mon, 13 Mar 2023 05:41:17 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBd9TY032724;
        Mon, 13 Mar 2023 12:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=N0KRWluhS5L5mRO1L3dHloPuatYaKu3pUrdYL6ml5KY=;
 b=U8YggESD22Yx9mA99+rIC4SYLKI2crWA89MUfVOHlFEg7xvdYtfmQdo6VIYl/HzPG1vp
 0WkEDAIFhZvBSS43qfvj8brVzC4LjYNUXIPBXrEqloBb8f3XBnG+pJhHPJEnnq5b2EXv
 AKGCq9YaqxGevxBONV75O+MquvBGmQPLH2w5nJyvZPiZCpxUy5W+GGGrA+SIFgLIB04n
 cHtbKdjbO4KAxYGX5SVwfH1LkZcaVRT2e/rxvLJH7jFakH9yXr92QZT9vp13UWJr5bvv
 GYj80fsYtEafvu0OAk9GUgeGnyhLmcyE0Ex+AZQIJ1N/+AA4agt/g4rQ5b8W3HXyYcfN UQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa1qgrcax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:40:49 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32DCejMT022371;
        Mon, 13 Mar 2023 12:40:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqkn9ys-1;
        Mon, 13 Mar 2023 12:40:45 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCejah022366;
        Mon, 13 Mar 2023 12:40:45 GMT
Received: from kbajaj-linux.qualcomm.com (kbajaj-linux.qualcomm.com [10.214.66.129])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32DCeiGf022364;
        Mon, 13 Mar 2023 12:40:45 +0000
Received: from kbajaj-linux.qualcomm.com (localhost [127.0.0.1])
        by kbajaj-linux.qualcomm.com (Postfix) with ESMTP id 17BC52A3;
        Mon, 13 Mar 2023 18:10:44 +0530 (IST)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/5] soc: qcom: llcc: Add support for QDU1000/QRU1000
Date:   Mon, 13 Mar 2023 18:10:35 +0530
Message-Id: <20230313124040.9463-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sR1O2FPlf1C4ySeNFKILJt8TXod9Pv7C
X-Proofpoint-GUID: sR1O2FPlf1C4ySeNFKILJt8TXod9Pv7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=869 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303130102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset refactor LLCC driver and adds LLCC support for the
Qualcomm QDU1000 and QRU1000 SoCs. Since QDU1000/QRU1000 supports
multi channel DDR, add support for multi channel DDR configuration
in LLCC.

Changes in v2:
  - Rebased on top of 6.3-rc2

Komal Bajaj (5):
  soc: qcom: llcc: Refactor llcc driver to support multiple
    configuration
  dt-bindings: arm: msm: Add bindings for multi channel DDR in LLCC
  dt-bindings: arm: msm: Add LLCC compatible for QDU1000/QRU1000
  soc: qcom: Add LLCC support for multi channel DDR
  soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support

 .../bindings/arm/msm/qcom,llcc.yaml           |  10 +
 drivers/soc/qcom/llcc-qcom.c                  | 308 +++++++++++++-----
 include/linux/soc/qcom/llcc-qcom.h            |   4 +-
 3 files changed, 240 insertions(+), 82 deletions(-)

-- 
2.39.1

