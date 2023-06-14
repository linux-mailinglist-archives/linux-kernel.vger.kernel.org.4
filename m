Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7072F249
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241658AbjFNB5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbjFNB5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:57:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EB9E79;
        Tue, 13 Jun 2023 18:57:39 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E1tvfC017191;
        Wed, 14 Jun 2023 01:57:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=aB6qq9NAlAoe3i7ogsj2FwxbUnF/Z84IWK9KM6MeDQc=;
 b=RvRb1IlEjePtIbOz7LESDmdNs3le9ZIX0t9+xKfR/2eAHnHDMtzBoRYaACSgK4pxmyDj
 VcOlUWJBw7xinomf7zDP5RhalusNngUZLRXrkURq0KfSrUzMmv4l6JP5NaIyu+FUmVWQ
 kohFNasZ2smj8iQ96R/U0B6pFv4xZC7mg7r2GX+ZTD0rrvZyg4kgfZPUYP/tjFJ6BvqN
 4HH7yt/mBYqKXibifBiLtVF9jw1m/yUx3coaUPvT+AqJZCcfGDuTlA2+H/3C7adQJ1hI
 mtRf0H7IVab6qHXAHsD5GNVREAgjio4mi4hbMty7mGpxKb2daOj0pAZcc5wsMkeIv0G1 Uw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r71tvr707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 01:57:31 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35E1vUlj030068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 01:57:30 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 13 Jun 2023 18:57:30 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add support for databus widen mode
Date:   Tue, 13 Jun 2023 18:57:10 -0700
Message-ID: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686707625; l=1659; i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id; bh=Yse1fODJx1zUr/BvNeAxSEDHdQVKnBYqwbDO7X9/hOE=; b=eEaCNrWNisgPCcT+qTo9wYkKBL1lj4GQFzahBU0SSUxvGv2XO/8U/4JuP9IFWftbenBm2dzTk ZC2yrySLhV+BzMwZL1rG+dgEll7pyrifyFbMzWWnYCGZDV7bOXY9dAM
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519; pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1Rozn0QoesLu5m3RuSCKXusycWHEtQc7
X-Proofpoint-ORIG-GUID: 1Rozn0QoesLu5m3RuSCKXusycWHEtQc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=811 bulkscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140012
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DPU 5.x+ and DSI 6G 2.5.x+ support a databus-widen mode that allows for
more compressed data to be transferred per pclk.

This series adds support for enabling this feature for both DPU and DSI
by doing the following:

1. Add a DPU_INTF_DATABUS_WIDEN feature flag
2. Add a DPU INTF op to set the DATABUS_WIDEN register
3. Set the DATABUS_WIDEN register and do the proper hdisplay
   calculations in DSI when applicable

Note: This series will only enable the databus-widen mode for command
mode as we are currently unable to validate it on video mode.

Depends on: "Add DSC v1.2 Support for DSI" [1]

[1] https://patchwork.freedesktop.org/series/117219/

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
Jessica Zhang (3):
      drm/msm/dpu: Add DPU_INTF_DATABUS_WIDEN feature flag for DPU >= 5.0
      drm/msm/dpu: Set DATABUS_WIDEN on command mode encoders
      drm/msm/dsi: Enable DATABUS_WIDEN for DSI command mode

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c       |  3 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h       |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 12 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
 drivers/gpu/drm/msm/dsi/dsi.xml.h                    |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                   | 19 ++++++++++++++++++-
 7 files changed, 41 insertions(+), 2 deletions(-)
---
base-commit: 1981c2c0c05f5d7fe4d4552d4f352cb46840e51e
change-id: 20230525-add-widebus-support-f785546ee751

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>

