Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7635F70B4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjEVGDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjEVGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:03:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DFFE;
        Sun, 21 May 2023 23:03:05 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5Fa0w023085;
        Mon, 22 May 2023 06:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9Rpfvi2imEznh7+DvUUNzkzDufqKjlVr6K7nCgU9kaM=;
 b=TbOnYP+cDcqTYDSw7VGq2q2sbtvU7NttaWD9bq+jkhRdXkSy2eQwdzivYzPsf2U1grwg
 /McMsxDHeO4VOFk1TYgt7CUIfl8IIg/7lqd8Sv1ZUMpqLghEpypkQP/cA8l3KOWcJx4r
 P3X7YZsN4Jngb4d7J4Nvz9eBsryvoZoliAeV1b2CY34hLo5t5V4uJ2Tao40rFNEyAyLn
 JC9J42rNjgLN/sgLy1BKeYap8F4j9p9e9hBYkfDhHrN46FfWVX57yadqZTUCmRhdnf50
 I2ERTS7o71odL0yEfZfZigqph/HtSurvd7RC69bwLwUce1SFepSvXZUDO5Mo6MaxBrHe /w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqgf2q43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:03:02 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M62w1D032334;
        Mon, 22 May 2023 06:02:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9keer2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 06:02:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M62vc6032318;
        Mon, 22 May 2023 06:02:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34M62vOs032308;
        Mon, 22 May 2023 06:02:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 8C69C3F5E; Mon, 22 May 2023 11:32:57 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH v4 3/3] venus: fix EOS handling in decoder stop command
Date:   Mon, 22 May 2023 11:32:52 +0530
Message-Id: <1684735372-10075-4-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1684735372-10075-1-git-send-email-quic_dikshita@quicinc.com>
References: <1684735372-10075-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GN2mtvPvhQtfjUzwlMCWzB9ZAQmZ8j6b
X-Proofpoint-GUID: GN2mtvPvhQtfjUzwlMCWzB9ZAQmZ8j6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_03,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Use firmware version based check to assign correct
device address for EOS buffer to fix the EOS handling
with different firmware version.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Nathan Hebert <nhebert@chromium.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index f0394b9..c59b34f 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -545,7 +545,7 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 
 		fdata.buffer_type = HFI_BUFFER_INPUT;
 		fdata.flags |= HFI_BUFFERFLAG_EOS;
-		if (IS_V6(inst->core))
+		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
 			fdata.device_addr = 0;
 		else
 			fdata.device_addr = 0xdeadb000;
-- 
2.7.4

