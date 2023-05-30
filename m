Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BE7169A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjE3QdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjE3QdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:33:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC8A7;
        Tue, 30 May 2023 09:32:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDoQlI021768;
        Tue, 30 May 2023 16:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=VgULDJ4g9Rw2XA8HlFN+0FoiO2CCHSmsLNoBrduxrbE=;
 b=kOsijd+67ljkB+L0tsHbURn4Z+ov0qJ6ICYaah4XmBgXBCaTr/PAqTLSYCJaSrfOkBKq
 k293bPOxEd8ctlp0Zlamz3LpD96oE4q1mXvJjxv9X5/rT3EBGrNSqiZBeRvmvqa3iQgP
 e91NHnBhQzGqX0xRuG6ux+y7/fPgV+M/KMkX11+x4e6BGJiXUOzg3Xy3IjKNgYr3cW4I
 HP6C/anLP6rNzttrdrUylAy0awSr7op92xTVpSLdSD8y8uSgIq72GHb8S/+LCWMejv6F
 MjmLXFyhCD2GuugYkvxZT9RKWRpFlpGMVfNG+uoVzI2ZR9bvDR8EHLpnczBklE8bhIMQ WQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qw03q26ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 16:32:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UGW9u7021654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 16:32:09 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 09:32:09 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] retrieve DSI DSC through DRM bridge
Date:   Tue, 30 May 2023 09:31:55 -0700
Message-ID: <1685464318-25031-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aMkSgeOlFJDKIve6hlzUyUXjJRKvBe1U
X-Proofpoint-ORIG-GUID: aMkSgeOlFJDKIve6hlzUyUXjJRKvBe1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=787 adultscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add msm_dsi_bridge_get_dsc_config() to retrieve DSI DSC through drm bridge. 
After that remove msm_dsi_get_dsc_config().

Kuogee Hsieh (3):
  drm/msm/dsi: add msm_dsi_bridge_get_dsc_config()
  drm/msm/dpu: retrieve DSI DSC struct at atomic_check()
  drm/msm/dpu: remove msm_dsi_get_dsc_config()

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 17 ++++++++++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 --
 drivers/gpu/drm/msm/dsi/dsi.c               |  5 ++++-
 drivers/gpu/drm/msm/dsi/dsi.h               |  2 ++
 drivers/gpu/drm/msm/dsi/dsi_manager.c       |  4 ++--
 drivers/gpu/drm/msm/msm_drv.h               |  4 ++--
 7 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.7.4

