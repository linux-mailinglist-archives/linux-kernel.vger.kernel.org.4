Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8068EFFE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjBHNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:42:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765592CFFC;
        Wed,  8 Feb 2023 05:42:20 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318BDHPZ001389;
        Wed, 8 Feb 2023 13:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=NkCxbS78vLly3nZijdZogjZfs3u+YMXxzwdQ7R3OUzQ=;
 b=EMDg5q7XXXgWFAqDVeHA9O4iiVRb6lFHeH/fgACLcu1iZJNRde5OnAkDjIxqF+g6qABH
 27oGZ5gxdDGtPDQNg3O4nN2+StTRh5l59Aq8xdrDEqi9xh0dlPdZqq8pM3jcjtN/DwUm
 Lb3Y6vqNRpERndC22dCje2OHTeHQa8p8Do5mbOKmfY3GygYggesMaTKLwHW3qERKhGUT
 GHk33k7bOO18SFETkWeMNRJ/odA1VLN+WGNY4fGwAGlh/Gr49l3Lo3h8Zk5dyKzD6CBd
 cPoQzWCXRlICou9ZlqzOpNMtmcnSVtS8gSV4Xga2EFiN2eksILUdc2SZmS6aoBBCnhpI mg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf1gt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 13:42:14 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 318DgArt025358;
        Wed, 8 Feb 2023 13:42:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3nhgekjeqn-1;
        Wed, 08 Feb 2023 13:42:10 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 318DgAkL025338;
        Wed, 8 Feb 2023 13:42:10 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 318Dg9Rq025333;
        Wed, 08 Feb 2023 13:42:10 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 4B7614BE0; Wed,  8 Feb 2023 05:42:09 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com, marijn.suijten@somainline.org
Subject: [PATCH v3 0/4] Reserve DSPPs based on user request
Date:   Wed,  8 Feb 2023 05:42:00 -0800
Message-Id: <1675863724-28412-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d6N19kcpsjKIYG4VmY40cCy2Xg6iyyVG
X-Proofpoint-GUID: d6N19kcpsjKIYG4VmY40cCy2Xg6iyyVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_05,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 mlxlogscore=693 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080120
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

The series will release/reserve the dpu resources when ever there is 
a topology change to suit the new requirements.

Kalyan Thota (4):
  drm/msm/dpu: clear DSPP reservations in rm release
  drm/msm/dpu: add DSPPs into reservation upon a CTM request
  drm/msm/dpu: avoid unnecessary check in DPU reservations
  drm/msm/dpu: reserve the resources on topology change

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 58 ++++++++++++++++-------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      |  2 +
 3 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.7.4

