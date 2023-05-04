Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC796F686E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEDJjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEDJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:39:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBE46BF;
        Thu,  4 May 2023 02:39:32 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3447Y0kk019661;
        Thu, 4 May 2023 09:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=bfjr312VruXMUFzyFs48bfe9zvLy7jOHbUKWetzUKbw=;
 b=Y5EiSDXc3cq0OpiKv20xVhTGoSEuH0xiNG7bqvmmt8jNiqq3e8sN8C0uHtJl6NZDPfCB
 FgwChOoziKfrVVGmZhPCaaM3uE7dyQjtQXkzqExihQ5jwJ19FzqAbjvmozLUgMwvuilz
 vCFr294g19Fc8XfWf9Bi4WOYZWLeR/647Mmth4NHmyg/Rm+u/CpZQIf+xZ36dM8ZB5vZ
 /NUPHEnzOlUbU8FrOESpK/vrR7089qrQ+5OYSKsWUhqB00VErreJopZtylLv/IstZL9k
 pgEA05eHDU+g+H81yfkHKZqyHXUegli8fCRclCNuWksr58aPDOkJlrscBmc7vPywIXPr Nw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qc5bn0k7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:39:28 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3449dNo3014252;
        Thu, 4 May 2023 09:39:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vaksvqw-1;
        Thu, 04 May 2023 09:39:23 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3449dNIO014247;
        Thu, 4 May 2023 09:39:23 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3449dNpd014245;
        Thu, 04 May 2023 09:39:23 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 7CBB736CA; Thu,  4 May 2023 15:09:22 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v3 0/3] fix decoder issues with firmware version check
Date:   Thu,  4 May 2023 15:09:09 +0530
Message-Id: <1683193152-5808-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: znXAmEr3Ci5T44U2Hh1Filp-QpuJBzpq
X-Proofpoint-GUID: znXAmEr3Ci5T44U2Hh1Filp-QpuJBzpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=913 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040079
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/media/platform/qcom/venus/core.h       | 20 +++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 27 ++++++++++++++++++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 10 +++++++++-
 5 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.7.4

