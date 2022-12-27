Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F407656D94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiL0Rpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 12:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiL0Rp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 12:45:29 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672E8FC9;
        Tue, 27 Dec 2022 09:45:27 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BREKhbG013874;
        Tue, 27 Dec 2022 17:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=iGoMfYwcrH+Jcp2jv5FIP/2WGmaaA59uhBPLBmwuRH4=;
 b=bFap5HINZ3a3/P3qHO2g2QiNWuk+OSIUoMp6w+1wrEOJKhiz9Fta9va48J/UHOvtIDtv
 igSrjonYzA174DBNyIzU4ysA2f9H8ojr73i8sdtj9Gc7jvSD/FjdZ0/vJsjaUqcNiO16
 7+hBfW6REyEb9Jzl4eRyZRsxQ6zQ0zD4UPZ5UlpuFCfCFELy+q4gScsltAez6WNUQC4P
 JjR3zC2OTlnKgRf9A6D1iEOgTBgeXCz+UapTZdCYf8YGpY6b47oDaVy4XW8r+eyQPpxq
 4CGjdNydUIyZVvqfdEoynLaz6TDRsGs6vish56IZDORtvBGqalAWPuDS7OK4PCUsMrbo OA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnreg5scd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 17:45:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRHjHBp008760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 17:45:17 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 27 Dec 2022 09:45:16 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v16 0/5] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Tue, 27 Dec 2022 09:44:58 -0800
Message-ID: <1672163103-31254-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q-0fHFYfu9EsSAzLjXccDkQExYE70H-4
X-Proofpoint-ORIG-GUID: q-0fHFYfu9EsSAzLjXccDkQExYE70H-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_13,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=938 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
functions to DP driver.

Kuogee Hsieh (5):
  arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
    endpoint
  dt-bindings: msm/dp: add data-lanes and link-frequencies property
  drm/msm/dp: parse data-lanes as property of dp_out endpoint
  Add capability to parser and retrieve max DP link supported rate from 
       link-frequencies property of dp_out endpoint.
  drm/msm/dp: add support of max dp link rate

 .../bindings/display/msm/dp-controller.yaml        | 25 ++++++++++-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  4 ++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |  4 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |  4 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  7 +--
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 | 50 ++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_parser.h                 |  2 +
 10 files changed, 87 insertions(+), 14 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

