Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2A68DBA4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjBGOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjBGOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:32:58 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117F3E63F;
        Tue,  7 Feb 2023 06:30:12 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317Dd3g7008345;
        Tue, 7 Feb 2023 14:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=YZUwC0dxpG/VIE2VkXsrq1umcPm7PSqfjIOEWLiXebI=;
 b=cxgDn2hQeX2y0Db8oLJBMwhtdIKEdCus4ac8F/mOoIKwtQBBftIHR9Vzqtf1MvYtBPHh
 Lm0DrhntbiGZhGe9NBprDXIs9W743H7joND9RvLDnnKE2lJFAdAYrQCtZ7Z/8YM3n9ge
 sy5nki6hEfmK9I1suJeFOqXJL2k+BYPjYZg7vBHtutpIpZEgotwSCieL7CA6WgHoEKHv
 pRpNVNavfJeWjBfF6PwCNShHknKkmDussaYwacU7CuH0FCBtSSF0cxcX+zbDdp4fXVkS
 Gtfp3Wh+pAj5WBtjk4XrhOMU64bLlnZQSrP68vORjEOx3OzAwBvt93/4g/3pjgAUukNS jA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkd8m1fsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:30:05 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 317EU01w002878;
        Tue, 7 Feb 2023 14:30:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3nhgeke6cv-1;
        Tue, 07 Feb 2023 14:30:00 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317EU07k002873;
        Tue, 7 Feb 2023 14:30:00 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 317EU05v002871;
        Tue, 07 Feb 2023 14:30:00 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id DF4094BDD; Tue,  7 Feb 2023 06:29:58 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: [PATCH v2 0/4] Reserve DSPPs based on user request
Date:   Tue,  7 Feb 2023 06:29:52 -0800
Message-Id: <1675780196-3076-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BDoxkUabuyKDX4YyJu2ZBjV27KnT-vb6
X-Proofpoint-ORIG-GUID: BDoxkUabuyKDX4YyJu2ZBjV27KnT-vb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_06,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=669
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070129
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will enable color features on sc7280 target which has 
primary panel as eDP

The series removes DSPP allocation based on encoder type and allows 
the DSPP reservation based on user request via CTM.

The series will release/reserve the dpu resources when ever there is 
a topology change to suit the new requirements.

Kalyan Thota (4):
  drm/msm/dpu: clear DSPP reservations in rm release
  drm/msm/dpu: add DSPPs into reservation upon a CTM request
  drm/msm/dpu: avoid unnecessary check in DPU reservations
  drm/msm/dpu: reserve the resources on topology change

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 61 +++++++++++++++++------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 +
 3 files changed, 40 insertions(+), 25 deletions(-)

-- 
2.7.4

