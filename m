Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC67F70B56A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjEVGww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjEVGwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:52:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA6E58;
        Sun, 21 May 2023 23:49:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M6MW9X017124;
        Mon, 22 May 2023 06:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=1Xrs/pI4MGAifMblWOX6mXJsnliCzV8yWMHq63+BS7g=;
 b=XTZvLM8krj1fgHwhtlCCmhZE74elQzmORhI2JiQTjFecNyC4QRU7tIW81pFt7PPOd4ht
 3vk2xfRyxvhzbfWffaBYD6AY558+M4DWoL24wK+jzKr6EUUYYTdQDNDguCO1ApHdUCIW
 4ix2NZlCPhTG66dkhqVYARqQY/aSJpCE5BeH6ptTSsCC23ZI3xx78Af2Dm/uCk831zwb
 F8sG3lzlqNnk93qMDdxnX84OtS7jGsjGNWwG14Gc6TiA8Vs8Vm9fo4kujIMdGldzUpEG
 NbwoUcVx0kKSSips0z9MZkLbAjlxY0V7a5ZbxcwXp/JuUAZxlKiJLrHdqHepzVQ4qxIY cQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmu1gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:48:25 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M6mKHY009736;
        Mon, 22 May 2023 06:48:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kehym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:48:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M6mKVM009728;
        Mon, 22 May 2023 06:48:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M6mK5T009726;
        Mon, 22 May 2023 06:48:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 9D21E3F5C; Mon, 22 May 2023 12:18:19 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 0/4] venus: add support for 10 bit decoding
Date:   Mon, 22 May 2023 12:18:14 +0530
Message-Id: <1684738098-17372-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _6pb9a_PcieKEx7Uy7J-LbDYf0pghpRV
X-Proofpoint-ORIG-GUID: _6pb9a_PcieKEx7Uy7J-LbDYf0pghpRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=881 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220057
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the changes to
  - add V4L2_PIX_FMT_P010 as supported decoder format.
  - consider dpb color format while calculating buffer
    size for dpb buffers.
  - update dpb and opb color format when bit depth
    changes is detected, also update preferred color
    format to P010 in this case.

With this series, divided the previous version [1] into
multiple patches as suggested in review comments.

This series depends on [2] which replaces the array index with enums.

changes since v1:
  use enums to assign formats in place of array index (konrad)

[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=10376
[2] https://patchwork.linuxtv.org/project/linux-media/list/?series=10502

Dikshita Agarwal (4):
  venus: add support for V4L2_PIX_FMT_P010 color format
  venus: update calculation for dpb buffers
  venus: add handling of bit depth change from firmwar
  venus: return P010 as preferred format for 10 bit decode

 drivers/media/platform/qcom/venus/core.h           | 21 +++++++++++----------
 drivers/media/platform/qcom/venus/helpers.c        | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 11 ++++++++---
 drivers/media/platform/qcom/venus/vdec.c           | 17 +++++++++++++++--
 5 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.7.4

