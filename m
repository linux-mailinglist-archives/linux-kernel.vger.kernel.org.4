Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D063CC5E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 01:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiK3AM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 19:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiK3AMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 19:12:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1A20359;
        Tue, 29 Nov 2022 16:12:52 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATNivMd019810;
        Wed, 30 Nov 2022 00:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Hss2amxlNuhEV3jJSRwIasi9hBqMCUBlg9lfs19LDto=;
 b=S8AGF/UrequVHxARU7ifo1FoH7aouPTzvD5GL9RjRSqlsE9QY2Hn4ez7HK2JAKo+XDaJ
 jSHinh6coRxG0puZLcmnqBkcSVk+Z1p2er1ywAkHrtTslJd1N9s8nDN5fWEa18WeHV2l
 sko6Ci8Dm88+6QfzMABWhGdCv2ra8qUbRSDbHc40V+NxI185s4sK4j6OCnS5ju+UgD/X
 hsMIDITU9v0nqWHqpp7sfvJFYAdhbRYjIVREnwoPhjt+mX1T7x3Sf/0Z2F1IGMbJiM8T
 sEl1GVM5RjShHRkI2PghTPQ9LIJbLztzB3kqq/AjEmvdeuO+TnbK/VnPWyxbvGhN4z/d 6A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5n1rs8j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 00:12:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AU0Ce3V015464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 00:12:40 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 29 Nov 2022 16:12:39 -0800
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
Subject: [PATCH v5 0/3] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Tue, 29 Nov 2022 16:12:08 -0800
Message-ID: <1669767131-13854-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cY29xPUdZhATBML7H8yC8ItTAKlGFUE0
X-Proofpoint-ORIG-GUID: cY29xPUdZhATBML7H8yC8ItTAKlGFUE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_13,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=772 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290146
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

Kuogee Hsieh (3):
  arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
    endpoint
  drm/msm/dp: parser data-lanes and link-frequencies from endpoint node
  drm/msm/dp: add support of max dp link rate

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   |  6 ++++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  6 ++++-
 drivers/gpu/drm/msm/dp/dp_display.c            |  4 +++
 drivers/gpu/drm/msm/dp/dp_panel.c              |  7 +++---
 drivers/gpu/drm/msm/dp/dp_panel.h              |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c             | 34 ++++++++++++++++++++------
 drivers/gpu/drm/msm/dp/dp_parser.h             |  2 ++
 7 files changed, 47 insertions(+), 13 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

