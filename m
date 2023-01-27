Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FB67E14B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjA0KQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjA0KP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:15:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3885DBC9;
        Fri, 27 Jan 2023 02:15:56 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R92XQa030231;
        Fri, 27 Jan 2023 10:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=L9AIHrzPObiEg8iX+Q9mRhYtMsa2DNoNppfxH9yTVJE=;
 b=VZUUrRTONqm1XdeeGfm+p8MnvDZ86M0NzpPBjdrGJ3xOQSLK6oQcNSYRDL3VgiTVrvkz
 0OX3OJNIvfiTAhIkkvpYJI1at2kD8n7Wzjp6W6cazcEjiaad00TK+SgWK9jMaZyErlv/
 qKRZZM4sOgU1pgPyvSfHRPeO/ZuZcOKBv1D9pwqLQRxETE77XAeDRmyc+n8/rvRWQ+Gk
 vhrh7TSAYLfz5gzlN8ZaopRFhL3kL957E8UGBqMXTbH45nNQOGliEb0VrDN4Xue7+pYV
 QvtRY/INFS+U29Y4dTrmox47AeUAKiUGfnP6Mf9zU2CIhtcqHmE/1Wm4n78HdF4+QH7R dg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nbdnyb104-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 10:15:50 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 30RAFl1G002356;
        Fri, 27 Jan 2023 10:15:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3n894m35jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 27 Jan 2023 10:15:47 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RAFlPa002350;
        Fri, 27 Jan 2023 10:15:47 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 30RAFlFF002349;
        Fri, 27 Jan 2023 10:15:47 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 717144B77; Fri, 27 Jan 2023 02:15:46 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: [PATCH 0/3] Reserve dspps based on user request
Date:   Fri, 27 Jan 2023 02:15:42 -0800
Message-Id: <1674814545-9453-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lXsefe0fBkSBlRWxEMGEZGNxdCqs9qS0
X-Proofpoint-GUID: lXsefe0fBkSBlRWxEMGEZGNxdCqs9qS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_05,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxlogscore=704 phishscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270096
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will enable color features on sc7280 target which has primary panel as eDP

The series removes dspp allocation based on encoder type and allows the dspp reservation
based on user request via ctm.

The series will release/reserve the dpu resources when ever there is a topology change
to suit the new requirements.

Kalyan Thota (3):
  drm/msm/disp/dpu1: clear dspp reservations in rm release
  drm/msm/disp/dpu1: add dspps into reservation if there is a ctm
    request
  drm/msm/disp/dpu1: reserve the resources on topology change

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 54 +++++++++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  6 ++--
 5 files changed, 50 insertions(+), 17 deletions(-)

-- 
2.7.4

