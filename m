Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD662F46B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiKRMRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiKRMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:16:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B448433E;
        Fri, 18 Nov 2022 04:16:59 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIAYkrp013554;
        Fri, 18 Nov 2022 12:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=wZ96chG7Wo93NJeauknEUqyBoeHewSTyupy5drDPKAM=;
 b=YR1PgFjdaXuUoSbvxsR7+XPqY8H8EscZphtasw94Q8+xIAAGZUw5t2JF1nld8jS5c+I0
 aSMlIDChGBEa9cW4A82F/3k9TdADw6/KZIIVUoqCRUe7EMpPTRAncqtDL3wHfph0vFEm
 OWysrqH2N7aK5kCJxgPHFI24TNX/UINjxMEt0CRghV3nnUXT+NPnk4yQH7ALOSWg5PLR
 gMhrPSvi0eQcHQvskHXZQbQ4EqgU2KHokVt4S1+ERXg4x1enEaLHagFgbDxUedDXsmSt
 ppyPgcDHS/TnVwByZMHo2XHWLkhUtlG1oUl1kqWWvFdVoAHqyhdVhvlRCvYyQu6VO0zr bg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0ra9kkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 12:16:54 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AICGoCP013688;
        Fri, 18 Nov 2022 12:16:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kt4jkkc6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Nov 2022 12:16:50 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AICGoK8013682;
        Fri, 18 Nov 2022 12:16:50 GMT
Received: from kalyant-linux.qualcomm.com (kalyant-linux.qualcomm.com [10.204.66.210])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AICGnSl013681;
        Fri, 18 Nov 2022 12:16:50 +0000
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id CC86C2EA0; Fri, 18 Nov 2022 04:16:48 -0800 (PST)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [PATCH v3 0/3] add color management support for the crtc
Date:   Fri, 18 Nov 2022 04:16:44 -0800
Message-Id: <1668773807-19598-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ifIyFrQ0aCSEfxkrQ7YbVvvNCwBk5O9y
X-Proofpoint-GUID: ifIyFrQ0aCSEfxkrQ7YbVvvNCwBk5O9y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=560
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180073
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add color management support for the crtc provided there are
enough dspps that can be allocated from the catalog

Kalyan Thota (3):
  drm/msm/disp/dpu1: pin 1 crtc to 1 encoder
  drm/msm/disp/dpu1: add helper to know if display is builtin
  drm/msm/disp/dpu1: add color management support for the crtc

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  5 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h    |  6 +++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 34 +++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 24 +++++++++++++-------
 5 files changed, 61 insertions(+), 14 deletions(-)

-- 
2.7.4

