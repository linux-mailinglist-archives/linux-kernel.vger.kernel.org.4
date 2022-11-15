Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C81B629836
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiKOMKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiKOMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:10:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE0A617D;
        Tue, 15 Nov 2022 04:10:29 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFBW9Za011842;
        Tue, 15 Nov 2022 12:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=13aTr5W1hrLWidkIIRnwMFFQfeg8MMVS86ZgHfjzB80=;
 b=LcWGgU+XTa02yvjj8hg5oXRJ7Lfb7ZFLBJ79+xEnCsv/WVXhAXoqbIVpw27ISN4R9Q2e
 Ev5SQ9WPyxN2WhYY3cM2WBxyS14LVmqxA3YXh/U6dm31ur73A31kLlDDusbLKODNxQe9
 g9fqh/SlQc9md/NYVxF2faSYwcZS04xwmRgbr8FQbrTW4M11KkvFsdHuFaHPzjJugwI6
 0U0e3dLjlIysmeBOsMT4N0vtsM2NQJl3p5CkZ8FHkFEQ1UceHnPKQsiqCDRsf/3r1xRb
 dbQGFq+mcQLu0w6SkKrQELR/8+ILVwNf3BVduOw1ISRmsxMikYb2tiXrNd9zGG/Y5vVU vQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kv55e92rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 12:10:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFCAKIb024640;
        Tue, 15 Nov 2022 12:10:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3kt4jkds7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Nov 2022 12:10:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AFCAJ4s024630;
        Tue, 15 Nov 2022 12:10:19 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2AFCAJkU024629;
        Tue, 15 Nov 2022 12:10:19 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id BD01B900889; Tue, 15 Nov 2022 17:40:18 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <vgarodia@qti.qualcomm.com>
Subject: [PATCH 1/1] venus : Fix for H265 decoding failure.
Date:   Tue, 15 Nov 2022 17:40:04 +0530
Message-Id: <20221115121004.28197-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221115121004.28197-1-quic_vboma@quicinc.com>
References: <20221115121004.28197-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZntJmUTquvo2wvWwIfz9I5LEaV4aJpJb
X-Proofpoint-ORIG-GUID: ZntJmUTquvo2wvWwIfz9I5LEaV4aJpJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=974 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150083
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

