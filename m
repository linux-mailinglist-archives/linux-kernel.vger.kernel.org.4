Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBB694422
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBMLNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjBMLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:13:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178318B05;
        Mon, 13 Feb 2023 03:12:43 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DAmwTe008650;
        Mon, 13 Feb 2023 11:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=FI9pWqx/wksFLp55LbWyExjYvgbCxbDA+SayAaq4sV8=;
 b=GiF9YuZ+9MV0plhHsi3M0zDfdXvZ2OclTTqPYKM2k8/zDkyKpCpNo9RNqz5S2iinRWuu
 e6Kl8AcPInNRDejV12sIJ9gnOm2tfejHBk+iDuNxxPA/VjJfrZLZ4zA+RrquQANZk9VQ
 lxeKBb8afiYjqn5hrCzJlmGD+M0FaxhBI6iuHvW0i0iGJSmhUhy0cubIHRDE7xgDc+mU
 cKEAcOgPSQi3WsqxRDiIiFu1G+QReJDnSavAzWI+MIhFyLWl4wetCMTJfb7Mtklgpxsa
 hebnGkmvFs5aMQ7aUdfY+hMVXMPdjnzZFzPIKVENzwai1MIuPQ66DdZMkpqFNfVyuhdj BQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3deuyqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 11:11:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31DBBnCt018455;
        Mon, 13 Feb 2023 11:11:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3np43k9kt9-1;
        Mon, 13 Feb 2023 11:11:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DBBn4i018425;
        Mon, 13 Feb 2023 11:11:49 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 31DBBngq018422;
        Mon, 13 Feb 2023 11:11:49 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id ECDE24C09; Mon, 13 Feb 2023 03:11:47 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: [PATCH v4 0/4] Reserve DSPPs based on user request
Date:   Mon, 13 Feb 2023 03:11:40 -0800
Message-Id: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p5a0VV9ziUkaOJRyL_g5Wa4Wg0XUj5KT
X-Proofpoint-ORIG-GUID: p5a0VV9ziUkaOJRyL_g5Wa4Wg0XUj5KT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_06,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 adultscore=0 mlxlogscore=791 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130101
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series will enable color features on sc7280 target which has 
primary panel as eDP

The series removes DSPP allocation based on encoder type and allows 
the DSPP reservation based on user request via CTM.

The series will release/reserve the dpu resources whenever there is 
a CTM enable/disable change so that DSPPs are allocated appropriately.

Kalyan Thota (4):
  drm/msm/dpu: clear DSPP reservations in rm release
  drm/msm/dpu: add DSPPs into reservation upon a CTM request
  drm/msm/dpu: avoid unnecessary check in DPU reservations
  drm/msm/dpu: manage DPU resources if CTM is requested

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 38 ++++++++++++-----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 ++
 drivers/gpu/drm/msm/msm_atomic.c            | 18 ++++++++++++++
 drivers/gpu/drm/msm/msm_drv.c               |  2 +-
 drivers/gpu/drm/msm/msm_drv.h               |  1 +
 5 files changed, 38 insertions(+), 23 deletions(-)

-- 
2.7.4

