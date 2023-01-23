Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDF6784C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjAWSZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjAWSYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:24:54 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946E6A53;
        Mon, 23 Jan 2023 10:24:51 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NEtQpm005519;
        Mon, 23 Jan 2023 18:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kSfNNiHT00vyAOram/Y4YENiP2iFE4XTnxa6Id7L2ic=;
 b=TLFFFCBeOQNW+5rXD3zA049uNuUIs0Iwm4I7XlzA1v6l/dbV5YO0yWOACNDQmR3jLH+5
 1aXvejDjmyMdFGYcobh9nI790nyHf1A1paLcZHmbdghGRllIZVrX8DpNlfmDJ07CV2CG
 AgLTMa9gYo9bhtKzEfFtoutDQMP5j1NUiAhZyYotBYu23gWreajRGtv/7HTwy5SRUbFM
 TyYSXxJwg6qdUsEFIjlC9+4ncobwc407YyHg1x5JHGslFbY/dAr4FMVkL3fUsz+EAVVF
 WRUYf9hr5oqxjQsgIjocj3VJGHil/JiueyUjeCxq2SZTVDX4HBc++jLSYGWIXcWeK3nF Ew== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89htuhk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 18:24:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NIOi5L012268
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 18:24:44 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 23 Jan 2023 10:24:43 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <andersson@kernel.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/14] add display port DSC feature
Date:   Mon, 23 Jan 2023 10:24:20 -0800
Message-ID: <1674498274-6010-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rz7CgAjxnVIXZyHbYXMsk0FD0W4nsuND
X-Proofpoint-GUID: Rz7CgAjxnVIXZyHbYXMsk0FD0W4nsuND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=946 suspectscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230177
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add DSC related supporting functions into to both dp controller and dpu enccoder

Kuogee Hsieh (14):
  drm/msm/dp: add dpcd read of both dsc and fec capability
  drm/msm/dp: add dsc factor into calculation of supported bpp
  drm/msm/dp: add configure mainlink_levels base on lane number
  drm/msm/dp: correct configure Colorimetry Indicator Field at MISC0
  drm/msm/dp: upgrade tu calculation base on newest algorithm
  drm/msm/dp: add display compression related struct
  drm/msm/dp: add dsc helper functions
  drm/msm/dp: add dsc supporting functions to DP controller
  drm/msm/dsi: export struct msm_compression_info to dpu encoder
  drm/msm/disp/dpu: add supports of DSC encoder v1.2 engine
  drm/msm/disp/dpu1: add supports of new flush mechanism
  drm/msm/disp/dpu1: revise timing engine programming to work for DSC
  drm/msm/disp/dpu1: add dsc supporting functions to dpu encoder
  drm/msm/disp/dpu1: add sc7280 dsc block and sub block

 drivers/gpu/drm/msm/Makefile                       |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c     | 537 +++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h     |  25 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 341 +++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   7 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  43 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  50 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  74 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  43 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  21 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  23 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  23 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 371 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 132 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |   6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  10 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c                | 176 ++++-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |  97 ++-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 839 ++++++++++++++-------
 drivers/gpu/drm/msm/dp/dp_display.c                |  61 +-
 drivers/gpu/drm/msm/dp/dp_link.c                   |  29 +-
 drivers/gpu/drm/msm/dp/dp_panel.c                  | 749 +++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  67 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |  40 +-
 drivers/gpu/drm/msm/dsi/dsi.c                      |   3 +-
 drivers/gpu/drm/msm/dsi/dsi.h                      |   3 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  14 +-
 drivers/gpu/drm/msm/msm_drv.h                      | 113 ++-
 32 files changed, 3429 insertions(+), 497 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.c
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_dsc_helper.h
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

