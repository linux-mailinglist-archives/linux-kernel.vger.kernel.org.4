Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FAB6A226A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBXTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBXTlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:41:11 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728C96BF7D;
        Fri, 24 Feb 2023 11:41:10 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OCFsmW012080;
        Fri, 24 Feb 2023 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1/xZYLzZkKV71m5tuEXBSFv1AN1uGrOiIeqJd3h6c7s=;
 b=ZV0GQG7dzziMnfXdqwkxY3dZiUZyXI6tC1Ko+Y9kg+nmMSXzAall0K6vZIQQnzY4kUXO
 8l3t72PKFm7ZfChaeG3rWefc1hBN7ZjVrhXuqxlsOtWisiJ2FP1OJOSYSpghWLnO1Wup
 T44l+lGYoBY3q5ay3SJuDk4KsTtpIc0oK1gVW7J3AaFcgPzBdXgLtMRAdiX1N1fDKf8j
 JGukc6vCsET5nkl13tpSUpzxlURpjGX3mtcZAoC54m8QTvJeq3vMaua1OADXrTxVbllJ
 YXTlIsQSxtvD24xJIXpxmWu2nffEVkfhpZ5xVPOqCa7OW/kdXX6GGalLmCqRzJOpgIqe Dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxw3d9bu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:40:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OJewtf026631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 19:40:58 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 24 Feb 2023 11:40:58 -0800
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
Subject: [RFC PATCH 0/2] Add DPU DSC helper module
Date:   Fri, 24 Feb 2023 11:40:45 -0800
Message-ID: <1677267647-28672-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xu4bIPo9NZHu0qa3TEETfVVUy-P3Bv1D
X-Proofpoint-ORIG-GUID: xu4bIPo9NZHu0qa3TEETfVVUy-P3Bv1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lots of duplicate calculation for DSC encoder between DSI and DP.
Also, with more DSC version it is easier to have a common helper module which 
handle all the DPU DSC encoder math.

This series has only been compile test because there is no DSI DSC V1.1 panel
to test it as DSC V1.2 panel is yet to be brough it up. In preparation to post
DSC V1.2 over DP, let's handle all common DSI and DP DSC parameters calculation
in this new module.

Kuogee Hsieh (2):
  drm/msm/dpu: add dsc helper functions
  drm/msm/dsi: use new dpu_dsc_populate_dsc_config()

 drivers/gpu/drm/msm/Makefile                   |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c | 209 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h |  34 ++++
 drivers/gpu/drm/msm/dsi/dsi_host.c             |  78 ++-------
 4 files changed, 256 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

