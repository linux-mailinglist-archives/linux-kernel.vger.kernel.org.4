Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355770B4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEVGDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjEVGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:03:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1093FF;
        Sun, 21 May 2023 23:03:05 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5S3Ge021961;
        Mon, 22 May 2023 06:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=sN0Gaby648b2sjqaoHFHk8KlSoaWNOt9AxJuRmL1Mo0=;
 b=eeQURXfaPADJyYep8Dgt5xM/aR73v14V60s7MYDWcoklXo71mnFvLZVaqX90Lm67gWOn
 ENE2k/IH4S/Xdb6TAG0TCmk5tx5bM9/NDFz4ExwC0+3GswbchDQQek1uJOE81Zbl9NE6
 AitJbxJBJe2VPxFUhPbeMFWEnT5Jc6v7PQQ1sOlLYzWWtJES5r4l1Dzn6HjgZK+Pf8xG
 eqGuMM6oU33PGUSIub9qML9VP+DQ6HfJroo6CM96jWCoi+Uxc9/yEthBF3PVc32cdcHw
 neeDPt4MMsudqkkPEm8ERSCs/VxnxQobiM80qP+xAIfTpX76p5xiOs9JyUGABm72htE8 QA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmtyb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:03:00 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M62u87032292;
        Mon, 22 May 2023 06:02:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9keeqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:02:56 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M62uIs032151;
        Mon, 22 May 2023 06:02:56 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M62tsb032093;
        Mon, 22 May 2023 06:02:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 1255E33B6; Mon, 22 May 2023 11:32:55 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v4 0/3] fix decoder issues with firmware version check
Date:   Mon, 22 May 2023 11:32:49 +0530
Message-Id: <1684735372-10075-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KOlKLH5r-olYjjQpZ2_Zb3t8suSXz2Ko
X-Proofpoint-ORIG-GUID: KOlKLH5r-olYjjQpZ2_Zb3t8suSXz2Ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=936 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220050
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
  - add firmware version based check to enable/disable some feature.
  - add support of new HFI to notify sequence change event to
    driver during resolution change at interframe.
  - use firmware version based check to fix EOS handling for different
    firmware versions.

With this series, divided the previous version [1] into
multiple patches as suggested in review comments.

[1] https://patchwork.kernel.org/project/linux-media/list/?series=733169

changes since v3:
  Improved design for reading firmware version for all supported
  firmwares (Konrad)

change since v2:
  added firmware version based check for all supported firmwares.
  added return value check of scanf. 
  addressed other review comments.

change since v1:
  addressed coding comments.

Dikshita Agarwal (3):
  venus: add firmware version based check
  venus: enable sufficient sequence change support for vp9
  venus: fix EOS handling in decoder stop command

 drivers/media/platform/qcom/venus/core.h       | 20 +++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 30 +++++++++++++++++++++++---
 drivers/media/platform/qcom/venus/vdec.c       | 10 ++++++++-
 5 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.7.4

