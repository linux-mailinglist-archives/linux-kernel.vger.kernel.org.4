Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3416F4E88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjECBUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjECBTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:19:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4B2D69;
        Tue,  2 May 2023 18:19:44 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343115rD001844;
        Wed, 3 May 2023 01:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=rKP4YVtHkxJqxSOqGp+MkG6/BHs2hqGdO5ozyHsKlpw=;
 b=GL1G6dmt1PJ0LsM6Z8zFFKvD9hqCKNHQUm/+jytJMAsC3C1YVXyuyBYd8HaiOE1KQSrW
 vjFK2+GSoPvk8X1baR3OvBFbwxSmgXBCByqSs4fmYa72Op/MKHANJr8XnxmIBWvKdg8V
 UoOpxDRJj2w9dDJwpowaI9Dd6UuDQ+mZa0FIxdEF8HHH3+Gm/pfuJCTcBUFDPwtM4LvF
 AN+HbQiQy4DpdqulOjLXfFWj1MxICUQwXt5r5lkEAmMvEk4FSwIz3B/gCioxNWeZLh5J
 WyIjjgczl1eWJ+mcId3zd22Ic6k6MZXiQotJFQZhengVODSM+AHs2kfL/BWVFnwUDNKb 1g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawcta91t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 01:19:37 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3431JaLv031340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 01:19:36 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 2 May 2023 18:19:36 -0700
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: [PATCH 0/4] Add DSC v1.2 Support for DSI
Date:   Tue, 2 May 2023 18:19:11 -0700
Message-ID: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+2UWQC/x2NQQqDMBAAvyJ77kKiKbT9Sulhk6x1D8awa4sg/
 r2xx2EYZgdjFTZ4dDsof8VkKQ38pYM0UXkzSm4MvesHF9wVKWfMltA+tS664sh+cJHC/RY8tCq
 SMUalkqazm23Gwtt6qqo8yvafPV/H8QPpET2hfAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1683076775; l=1613;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=PFFcQW6FTUXHIiVB7iLGZXdzML2G70MnT3tS7Jf4MOs=;
 b=xvSfOsQs9d3kDGc+arl6THVhp9DuNnU0HYusnr8S65iUl6v+/QBVZAKNGh1Y0p5b2NSZfTL/Z
 Pzv9/nfq842DCcT4V2Bx710V/LTEg0fP8FqTI/gxGqlUKWJAAuMSK9C
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pbAhUElu8_n0hA7eH1jv6HxoXm669A69
X-Proofpoint-GUID: pbAhUElu8_n0hA7eH1jv6HxoXm669A69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030009
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of changes for DSI to enable support for DSC v1.2.

This includes:

1) Dividing the pclk_rate by the compression ratio when DSC is enabled
2) Fixing the word count calculation for DSC
3) Setting the DATA_COMPRESS bit when DSC is enabled

With these changes (and the dependency below), DSC v1.2 should work over
DSI.

Depends-on: "add DSC 1.2 dpu supports" [1]

[1] https://patchwork.freedesktop.org/series/116789/

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
Jessica Zhang (4):
      drm/msm/dsi: Adjust pclk rate for compression
      drm/msm/dsi: Fix compressed word count calculation
      drm/msm/dpu: Add has_data_compress to dpu_caps
      drm/msm/dpu: Enable compression for command mode

 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  1 +
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |  1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h |  1 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  4 ++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  7 +++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  2 ++
 drivers/gpu/drm/msm/dsi/dsi_host.c                 | 23 +++++++++++++++++-----
 10 files changed, 38 insertions(+), 5 deletions(-)
---
base-commit: a4e4b4826fe482d5f63a0232bc6588da2edfa45b
change-id: 20230405-add-dsc-support-fe130ba49841

Best regards,
-- 
Jessica Zhang <quic_jesszhan@quicinc.com>

