Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DBB6478DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLHWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHWhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:37:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D18110D;
        Thu,  8 Dec 2022 14:37:32 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MRbV7005509;
        Thu, 8 Dec 2022 22:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=c/iQBf4lD2XGR39TCYiej/9tbgFPMIHjR3VhOtVSKtU=;
 b=AQEyQzkSgkGN9kwiJLXYFKfrUBiCY0RenVjTWXgr6nWh9q+K9xzGYYad2R5LyMZ46yGY
 LjHyl+BfrWbEGRhEAWvfaoq14UU07DtZ3IRMIO6OnlQw2p3uWGi159yMqpVQn/S8sV6Y
 5eS7Kk36xkdSGzjQRVmkGWInl7etkXlXCfyJyXDwER/iz1jrj9VQdq+fgpvA1oYI5OSD
 7u6iPStzVteRLHFVZHT0YkPWG0XDpLrXj3P2K5qMNV7knpPmh/+1Zi64ik4actQPvbPi
 U9cv24nRkWKTlUt2mJERnOW6l42Yqoi0zWa0SePP85emvdzH3uyLFZCvD9Pip5HJtHIO kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mbbfmacy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 22:37:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8MbFTd014043
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 22:37:15 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 8 Dec 2022 14:37:14 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 0/5] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Thu, 8 Dec 2022 14:36:50 -0800
Message-ID: <1670539015-11808-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BPJB2MXy2EWYlrZsV7pGCKo6CMloDX-d
X-Proofpoint-ORIG-GUID: BPJB2MXy2EWYlrZsV7pGCKo6CMloDX-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=861 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080186
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  drm/msm/dp: parser data-lanes as property of dp_out endpoint
  drm/msm/dp: parser link-frequencies as property of dp_out endpoint
  drm/msm/dp: add support of max dp link rate

 .../bindings/display/msm/dp-controller.yaml        | 27 +++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  6 ++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi     |  6 ++-
 drivers/gpu/drm/msm/dp/dp_display.c                |  4 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  7 +--
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 | 52 ++++++++++++++++++----
 drivers/gpu/drm/msm/dp/dp_parser.h                 |  2 +
 8 files changed, 92 insertions(+), 13 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

