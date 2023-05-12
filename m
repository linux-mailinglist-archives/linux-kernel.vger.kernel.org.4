Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43881700E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbjELSBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjELSAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 14:00:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A1E180;
        Fri, 12 May 2023 11:00:44 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEeFnm005466;
        Fri, 12 May 2023 18:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=v0CLabRK40BP/swV4W/xCl+v3Mz6OFvMsNI7TIoKhes=;
 b=cgdgh02ivWhwMFGF5tgZ9B6f1GVGmjg27L2vkNmyEc4hgFqrv3iS01U5vlxuNhCLZrxU
 9dLYxH/d6xyTd4Lr5bHa2aZpgcTPbJMZB6LUdToMmOdmA4BNBcJ4I1PQhJUXkKhV37dq
 LWHTAK/olbe61C4lZGXPqjtDeAczmXHpKEcj3IHoOwVmQbsWdzgjdB5tWBFovZ1FvCZe
 0kclsjDDvx8j+V2WrD1DU/7YQg0D3vLr8PTl8hlPUvL0wvYKdqVNhrwaAv+OdwiT1tWK
 E6Nqt1Mbt4mxbk43d6o8ZP9WA73AzPrxXMryJI0CKLe2U/jmkWe/V/wgz791tOCTrvIp hA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qh5g9anxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:00:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CI0W1d002584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 18:00:32 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 12 May 2023 11:00:31 -0700
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
Subject: [PATCH v8 0/8] add DSC 1.2 dpu supports
Date:   Fri, 12 May 2023 11:00:15 -0700
Message-ID: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CMJGFZGKj_UqpuC3zzVzyHZZuecPr_vz
X-Proofpoint-ORIG-GUID: CMJGFZGKj_UqpuC3zzVzyHZZuecPr_vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
  drm/msm/dpu: add dsc blocks for remaining chipsets in catalog
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  31 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  36 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |  29 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |  10 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c         |  14 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h         |  15 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c     | 382 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |   7 +-
 19 files changed, 649 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc_1_2.c

-- 
2.7.4

