Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB06754E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjATMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjATMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:47:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06681BC2;
        Fri, 20 Jan 2023 04:47:12 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KCX71f029448;
        Fri, 20 Jan 2023 12:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JzX+rtg+HZuJiDwfuJ8Do11GcSMBCSLI9yEvqazh47E=;
 b=peQdyfjWJsnDOnoEnKOAwSo3cucozcJqsB947+rYRo5kwKfXCH7m0jhKNuQ5ez3QLIou
 6jwS9wJ3GfInPZacnPJpC9AvIK3eUi1TtEe++PpZVliPwGmdFA0rLTFO1C5lgdHjVaWX
 +YN5AZHXIf+Cy6YgZpqudok+C9aBj5eqfAU5mLm4jueUzfe8CIpUoHsriRmuMqzZ9Fnv
 BvCxET86NE5DPuCsyXPd2w+kEu7utm5yPer4TWu1UuO0H3EHZQzrPfb0L2FUXD1iR2Z2
 AFJooqNvKLOT0lqyNTepR7VuS5gfMSbMvczy31MmiFg/c05BLOLAEnx3XjCbUjcji8WU zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6wbsbxy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 12:47:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30KCl4Ke029528
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 12:47:04 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 20 Jan 2023 04:46:59 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/6] Add resets for ADSP based audio clock controller driver
Date:   Fri, 20 Jan 2023 18:16:40 +0530
Message-ID: <1674218806-7711-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GTXD0lSssPkQvaRwYHZe80-wcdkj5d1i
X-Proofpoint-GUID: GTXD0lSssPkQvaRwYHZe80-wcdkj5d1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_08,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=802 malwarescore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200120
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets and remove qdsp6ss clcok controller for audioreach based platforms. 

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

Srinivasa Rao Mandadapu (6):
  dt-bindings: clock: qcom,sc7280-lpasscc: Add qcom,adsp-pil-mode
    property
  dt-bindings: clock: lpassaudiocc-sc7280: Add binding headers for
    lpasscc
  clk: qcom: lpasscc-sc7280: Skip qdsp6ss clock registration
  clk: qcom: lpasscorecc-sc7280: Skip lpasscorecc registration
  clk: qcom: lpassaudiocc-sc7280: Merge lpasscc into lpass_aon
  clk: qcom: lpassaudiocc-sc7280: Skip lpass_aon_cc_pll config

 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml    |  7 +++++++
 drivers/clk/qcom/lpassaudiocc-sc7280.c                    | 15 ++++++++++-----
 drivers/clk/qcom/lpasscc-sc7280.c                         | 12 +++++++-----
 drivers/clk/qcom/lpasscorecc-sc7280.c                     |  3 +++
 include/dt-bindings/clock/qcom,lpassaudiocc-sc7280.h      |  2 ++
 5 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.7.4

