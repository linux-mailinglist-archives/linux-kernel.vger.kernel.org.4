Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B481E71F5A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjFAWJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFAWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:09:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A0132;
        Thu,  1 Jun 2023 15:09:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Lq0th007693;
        Thu, 1 Jun 2023 22:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=imJcHdUPlXDBoCqG9a/BhfyE1Qcc+zecm0QutRPyjO0=;
 b=kJXrovA3w65mGpM7Ulx7lhLM+6Wwv+WTasX6k0ae5YSRjaoTfggvfTkLrGqyusOicnEh
 im0Gh1mv32lTRYUEIp0027DnUA+zQGRJGG7xmupWRfZzsBTip9HTdxKhXY9x8CNs0Qs0
 iJypXXT5tEpADMhngy+xfu3rbbG6YPFYPsiBmJIzrH8JFH/0LiM1iBeCnzWd49SOuFMr
 uE+Q28N2rUD9gyuhDUpMGiW73YNcD8Btwsreozuirn4GcOPP5vlHduVZyj2Jd1vS/1ey
 SYEBL6IzjNrEajvvKXtYBH8HwqUAQ2r45CbTbJNQyiD9DHnJFFz2BwDr/Yki3CntyT7S hA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy1bcg8e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 22:09:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351M90vL023502
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 22:09:00 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 15:08:59 -0700
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
Subject: [PATCH v2 0/2] retrieve DSI DSC through DRM bridge
Date:   Thu, 1 Jun 2023 15:08:49 -0700
Message-ID: <1685657331-23280-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: azCt6zEaKs_4PlDP8-uOhAbHMoq4b0kY
X-Proofpoint-GUID: azCt6zEaKs_4PlDP8-uOhAbHMoq4b0kY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=907 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010191
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move retrieving DSC from setup_display to atomic_check() and delete struct drm_dsc_config
from struct msm_display_info.

Kuogee Hsieh (2):
  drm/msm/dpu: retrieve DSI DSC struct at atomic_check()
  drm/msm/dpu: remove struct drm_dsc_config from struct msm_display_info

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 18 +++++++++++++-----
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 --
 3 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.7.4

