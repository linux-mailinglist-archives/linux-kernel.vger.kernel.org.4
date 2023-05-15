Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B8703FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbjEOVZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244559AbjEOVZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:25:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D4593;
        Mon, 15 May 2023 14:25:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FLA5ja027126;
        Mon, 15 May 2023 21:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PMiLOG4MeCP8Bz96BxDjIQDAUxT9VyO5t7Ppp7xVfLA=;
 b=DfPyzmybJMrmfiAMPCH9CqWv5l28ENrPAzzHPVysR+lbgn5NnYdCygCca3RQK6B+vyO/
 frupdr0qhTsKJ+9xe82Ufqg9+u/1saPW4jCM2q4tgBrJ5/SR6Th+fTCRhOQqGGEXptqf
 iHAK2lHFSQHEVV4vmeUpRv34T2NsVXRmmsxKcEus6Yx1w0bpAYIik8lz2uGjHAgh8Vh7
 F6MULkx5CKBojZweR1mxg4jnmfjCLq2NLXChYBPQvy0l0A4cW1iIwOi2asf92evhpmGs
 vbcnyaCa3Rm4v7j4x2vGrv/Lria7in/Z0QMBppDQeJFnGwgAJMRS8RcQJhumU5jzNqI3 cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkkde1hdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 21:25:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FLPieN005366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 21:25:44 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 14:25:43 -0700
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
Subject: [PATCH v9 0/8] add DSC 1.2 dpu supports
Date:   Mon, 15 May 2023 14:25:20 -0700
Message-ID: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kz9OZdmNEIBMg37y3yt6ShF0oTs8O831
X-Proofpoint-ORIG-GUID: kz9OZdmNEIBMg37y3yt6ShF0oTs8O831
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150176
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the DPU side changes to support DSC 1.2 encoder. This
was validated with both DSI DSC 1.2 panel and DP DSC 1.2 monitor.
The DSI and DP parts will be pushed later on top of this change.
This seriel is rebase on [1], [2] and catalog fixes from rev-4 of [3].

[1]: https://patchwork.freedesktop.org/series/116851/
[2]: https://patchwork.freedesktop.org/series/116615/
[3]: https://patchwork.freedesktop.org/series/112332/

Abhinav Kumar (2):
  drm/msm/dpu: add dsc blocks to the catalog of MSM8998 and SC8180X
  drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets

Kuogee Hsieh (6):
  drm/msm/dpu: add DPU_PINGPONG_DSC feature bit for DPU < 7.0.0
  drm/msm/dpu: test DPU_PINGPONG_DSC bit before assign DSC ops to
    PINGPONG
  drm/msm/dpu: Introduce PINGPONG_NONE to disconnect DSC from PINGPONG
  drm/msm/dpu: add support for DSC encoder v1.2 engine
  drm/msm/dpu: separate DSC flush update out of interface
  drm/msm/dpu: tear down DSC data path when DSC disabled

 drivers/gpu/drm/msm/Makefile                       |   1 +
 .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    |   7 +
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |  11 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  14 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   7 +
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  16 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  14 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  14 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  59 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  29 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  35 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  29 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 386 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
 19 files changed, 651 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c

-- 
2.7.4

