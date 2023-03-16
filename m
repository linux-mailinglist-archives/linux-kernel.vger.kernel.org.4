Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89546BC93B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCPIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCPIda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:33:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4360432;
        Thu, 16 Mar 2023 01:33:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G7D1Vj031993;
        Thu, 16 Mar 2023 08:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=okuHmuDRoxgH78pBz+bK8iU6YeuBgRv0iFYAkXwrh4E=;
 b=IyGv2aYhF8aXuQ4H5EIj4JvR7Qzre4pWnfeQMLPc/jFLX70BYe7d28YVVVm4iU4MRHu5
 hj5TznEpxEl6eXKt9mg6YEUoMZXD+6xoVqCSHiWqE6j5+nj8LSfQ1ei9F2q3VVMbxPMc
 G69NBt5MtJwFOrVRoPIwYk6Z/Lrl/cNDdpiIgeW3b20PwQKV0DZG/Xd7EAARJQEopX+r
 GUlvT7sJuiKxFk6ezY75J+caliI5Q+9aJNZzgZ33jvUzrRuES4n3j4HAB4qbRTBVjW7v
 HPQ25+mkf3iV/jT74kXXUIZ8SPT9qV9yAzPre/l6C242D2E8HO1161lh21UaiWMUQQI1 8A== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpya1509-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:15:17 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G8FDKQ008640;
        Thu, 16 Mar 2023 08:15:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqks0hr-1;
        Thu, 16 Mar 2023 08:15:13 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G8FDoL008635;
        Thu, 16 Mar 2023 08:15:13 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32G8FDJB008634;
        Thu, 16 Mar 2023 08:15:13 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 8A57D900889; Thu, 16 Mar 2023 13:45:12 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/1] Fix for VP9 DRC and Decoder STOP issue.
Date:   Thu, 16 Mar 2023 13:45:08 +0530
Message-Id: <20230316081509.12201-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230202064712.5804-2-quic_vboma@quicinc.com>
References: <20230202064712.5804-2-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zg9nLEaivc4kwYk6dEF3Zw-8NGLjTgZm
X-Proofpoint-GUID: Zg9nLEaivc4kwYk6dEF3Zw-8NGLjTgZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=836 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160069
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Fixed indent comments, ensured rebase and checkpatch with --strict.
Tested the changes on v5.15 and v5.4 kernels .
For testing Chrome Utilities were used .

Viswanath Boma (1):
  venus: Enable sufficient sequence change support for sc7180 and fix
    for Decoder STOP command issue.

 drivers/media/platform/qcom/venus/core.h       | 18 ++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_cmds.c   |  1 +
 drivers/media/platform/qcom/venus/hfi_helper.h |  2 ++
 drivers/media/platform/qcom/venus/hfi_msgs.c   | 11 +++++++++--
 drivers/media/platform/qcom/venus/vdec.c       | 12 +++++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

-- 
2.17.1

