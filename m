Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B46BC7F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCPH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjCPH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:57:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100D425E17;
        Thu, 16 Mar 2023 00:57:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G3n29U023112;
        Thu, 16 Mar 2023 07:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=vYf7MJVBmEbDDRGmEYOio2EVZ5KVHxsGoNLgaqNTQgc=;
 b=EtvG7dYUJPe5bF9HC5rPhYJ+GvQ0x6o138sS37DGHr86Qs9Ya9K6kodkdiz25gMA9w9s
 4JZumogcVj4CWKFOGdErJjS+xpbHY1UvzpzWmiuNfCeRIcyhUIZInJm9mxbMTwQF+5vs
 zz4S5NFcGNlgqhtGKPJBZoFqsgK+/WXEx6TAR5J9cmsfKtLo4DtNs925w+zQ1eqpF72O
 FiHzU2dzrS/+CJ25rLYxr8Y5TKpE/UdUlsr4P8zkZsZm9Pc9qTu1tXRixOaDzMd4vOMm
 ZE92qCh051U/HuOJInW+cirvhNfhOGb6bdM3yT/qKtpKAwI1o3t/PMkgwtlXqBoH8e8A lw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy8h4te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 07:57:44 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G7vfrc025640;
        Thu, 16 Mar 2023 07:57:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3p8jqkry4v-1;
        Thu, 16 Mar 2023 07:57:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G7vfDn025629;
        Thu, 16 Mar 2023 07:57:41 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 32G7vfqE025627;
        Thu, 16 Mar 2023 07:57:41 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 3F739900889; Thu, 16 Mar 2023 13:27:40 +0530 (IST)
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
Cc:     Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: [PATCH] venus : Fix for H265 decoding failure.
Date:   Thu, 16 Mar 2023 13:27:29 +0530
Message-Id: <20230316075729.4052-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230316075729.4052-1-quic_vboma@quicinc.com>
References: <20221115121004.28197-2-quic_vboma@quicinc.com>
 <20230316075729.4052-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 32iuyrYL35o00lNz8QHay3mMN3RUo6b9
X-Proofpoint-ORIG-GUID: 32iuyrYL35o00lNz8QHay3mMN3RUo6b9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_05,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160066
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Aligned the mismatch of persist1 and scratch1 buffer calculation,
as per the firmware requirements .

Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Tested-by: Nathan Hebert <nhebert@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
index ea25c451222b..a9be31ec6927 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
@@ -93,7 +93,7 @@
 #define LCU_MIN_SIZE_PELS		16
 #define SIZE_SEI_USERDATA		4096
 
-#define H265D_MAX_SLICE			600
+#define H265D_MAX_SLICE			3600
 #define SIZE_H265D_HW_PIC_T		SIZE_H264D_HW_PIC_T
 #define SIZE_H265D_BSE_CMD_PER_BUF	(16 * sizeof(u32))
 #define SIZE_H265D_VPP_CMD_PER_BUF	256
@@ -1021,7 +1021,7 @@ static u32 h264d_persist1_size(void)
 static u32 h265d_persist1_size(void)
 {
 	return ALIGN((SIZE_SLIST_BUF_H265 * NUM_SLIST_BUF_H265 + H265_NUM_TILE
-			* sizeof(u32)), HFI_DMA_ALIGNMENT);
+			* sizeof(u32) + NUM_HW_PIC_BUF * SIZE_SEI_USERDATA), HFI_DMA_ALIGNMENT);
 }
 
 static u32 vp8d_persist1_size(void)
-- 
2.17.1

