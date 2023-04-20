Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A196E9FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjDTXZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjDTXZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:25:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82D1BCE;
        Thu, 20 Apr 2023 16:25:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33KNGG7L018531;
        Thu, 20 Apr 2023 23:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bqyIiOM3AUOZ4NlVLIvAr5Lx6WPoUK/ksmtacLUtSOk=;
 b=QIu8O6OPc4ophw+/L1AJFtblSuTnEO8oOP1mrCTFqHV8dasSE0JOSdsNoeWl+PNOm0vA
 MPtq3sEBhhOPD/DYNlSjWQ0f4vSpKj+Mz5G2vEXee0BLw/IhAEisNy5BuSYomtGqv5GM
 si9maCKpAahqn9Ga/KPj85RYT4eCeTU4x3FLg0S7jsChsBU9oHmZFT2tKUB55Q/CjqwI
 Pt3gn+kOLmmAEOG9ooGeb9/BGJTFsMDrvS/LcZnsASAemRE6xSl/ix4PPUOlwvnzQOJ9
 x2CqSrbZpeZNjuPCrm6rKCwBr2LH6E/lNQiOfi4nyCEeLuG5sbN+2MV6NeCgBnUnXaJS yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q3ewh00ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 23:25:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KNPPLu016009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 23:25:25 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 20 Apr 2023 16:25:24 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/5] add DSC 1.2 dpu supports
Date:   Thu, 20 Apr 2023 16:25:09 -0700
Message-ID: <1682033114-28483-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pMoIG1cosU4Sgqaujka7xby1FRImX-Ax
X-Proofpoint-GUID: pMoIG1cosU4Sgqaujka7xby1FRImX-Ax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_15,2023-04-20_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=918 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304200199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the DPU side changes to support DSC 1.2 encoder. This
was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
The DSI and DP parts will be pushed later on top of this change.

Abhinav Kumar (1):
  drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets

Kuogee Hsieh (4):
  drm/msm/dpu: add support for DSC encoder v1.2 engine
  drm/msm/dpu: separate DSC flush update out of interface
  drm/msm/dpu: save dpu topology configuration
  drm/msm/dpu: calculate DSC encoder parameters dynamically

 drivers/gpu/drm/msm/Makefile                       |   1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  19 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  11 +
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  21 ++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  19 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  19 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 102 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  38 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  22 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  17 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 388 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
 14 files changed, 629 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

