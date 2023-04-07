Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3F76DA8EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 08:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbjDGG0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 02:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbjDGG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:26:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBBD9EE5;
        Thu,  6 Apr 2023 23:26:12 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3375kqrZ012832;
        Fri, 7 Apr 2023 06:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=XvsZKToWHHxcajhQsIn52m03LpgI9mW76ofF6MiWscU=;
 b=VEpYEpX83mh6FTDPP3vmJb3vkThLL/FiKz1P6ITVrqsyVGLZmGrMO2XJ5ysxUofqeDHR
 rNpZMuuHI9Ef3mGEhWaySqnxeGcB/3JK/qffBEb/Ko4LB0xcWY+We6tACY04ahoDph7+
 xBJzVegRQCL8NhWxDhgAnyPyVmCeE6y7w/kw7dyBlcb9WcMQsjrzknyzxPlmQ5XJwsLI
 5kW6EZDCtFZWATi7AyrXGWE24PF7duGxB7906MKs4o9gZcSdVVxsyEz3AKCGyfZE/F1R
 T16ep36QPsEJh8ofoimRfZCIUBT0Gy5A7D4R0/cmApfGUzgtBHgi6/edmv45fRMyT6j4 7A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pt5s9rvmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 06:26:08 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3376Q3x7014080;
        Fri, 7 Apr 2023 06:26:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ppdpm5y8j-1;
        Fri, 07 Apr 2023 06:26:03 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3376Q3r2014075;
        Fri, 7 Apr 2023 06:26:03 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3376Q3Vt014072;
        Fri, 07 Apr 2023 06:26:03 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id B43D81310; Fri,  7 Apr 2023 11:56:02 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 0/3] fix decoder issues with firmware version check
Date:   Fri,  7 Apr 2023 11:55:55 +0530
Message-Id: <1680848758-3947-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6HPN_x1U5gsTJzfXEBs3p5DXhRJGz8o-
X-Proofpoint-ORIG-GUID: 6HPN_x1U5gsTJzfXEBs3p5DXhRJGz8o-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=837 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070059
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

change since v1:
  addressed coding comments.

Dikshita Agarwal (3):
  venus: add firmware version based check
  venus: enable sufficient sequence change support for vp9
  venus: fix EOS handling in decoder stop command

 drivers/media/platform/qcom/venus/core.h       | 20 ++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 10 +++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.7.4

