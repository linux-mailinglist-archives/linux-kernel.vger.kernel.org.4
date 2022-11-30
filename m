Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA1D63E5C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiK3XwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiK3XwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:52:14 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEB2769D3;
        Wed, 30 Nov 2022 15:52:13 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUMj5WW008816;
        Wed, 30 Nov 2022 23:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=TKrokgYR6zCLb/xcAvOFDEnqeMsrWHZalBHPISQ6+0s=;
 b=UGPVpntRZo0V0Jq+9mmY7lnKq59YP/+KzvRROYr+F1D1/5FVmSK9gUxYVqoz/12wbNNB
 PISMVYej+pmRJGg2nG/6O+6CL83eQz9sg586Mtctz33OqVKUL3ufElX5dAmdSsIRryZk
 EjSOxRiBU8ye5jJ+wolHBsJ6xRmsK0Yfwgbgy8DMrhhOzGwuxCeaJjY6sXaThPPHFi+y
 b7DoMiWDckp9q80p05JD4RaUQnG7zlqUA9tXi1j2nQlz8H2BO9ydg4DR50M283aM5Uqa
 FqR/aOKWfV8FNW3Qb3ArX6WKFY80jE7cX1acPFBf7QXKiw8vEnXXVgsxafQynjSvvQxU iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m61crkkm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 23:52:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AUNq5jR022053
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 23:52:05 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 15:52:04 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/4] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Wed, 30 Nov 2022 15:51:46 -0800
Message-ID: <1669852310-22360-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DR8IKVgDBt3FDquntsxS2clWemSGhQ_x
X-Proofpoint-ORIG-GUID: DR8IKVgDBt3FDquntsxS2clWemSGhQ_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=852
 mlxscore=0 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
functions to DP driver.

Kuogee Hsieh (4):
  arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
    endpoint
  drm/msm/dp: parser data-lanes as property of dp_out endpoint
  drm/msm/dp: parser link-frequencies as property of dp_out endpoint
  drm/msm/dp: add support of max dp link rate

 .../bindings/display/msm/dp-controller.yaml        | 17 ++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  6 ++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |  6 ++-
 drivers/gpu/drm/msm/dp/dp_display.c                |  4 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  7 ++--
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 | 46 ++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_parser.h                 |  2 +
 8 files changed, 77 insertions(+), 12 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

