Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A85F9768
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJJEci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJJEcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:32:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962103204F;
        Sun,  9 Oct 2022 21:32:34 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4WB0i003167;
        Mon, 10 Oct 2022 04:32:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=l3EF25iL6q7Gc1Qj9bnMwNqlO/3nKJvzpT2gVx/6Wf4=;
 b=HN+DIXSUoNNynV1oo9cgvQWMyWH0YdARQ0VC2vM/Xs5djKz6FfONJnFptoxNiY9EyBj+
 Dpx/2xktZX/N658beZEVnt0hEKSRQGv9xv2QDycnY0+LZYoM0En0mxsbJg+bE+0fa4fV
 WE8kG/rvvmN58MPWt9U9CHI9penEtixCQnWvfzFi6YVSzESKExCB5zsDa9PaSmUKa1AQ
 TcLL27rlW8fYwp4JoxLoPvRS9EcZ1REPwb4SYcY3gtazNrRPHriLJLDza+lQOAiK78dS
 e/TS6OmWklUMj7xoR0IzO7Y1AUD9/uIXNC9MpZG6WKQe1VdmSYw3nkvd8O2f8lTHNFXY Fw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31j3tvjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 04:32:17 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4WEZF002707;
        Mon, 10 Oct 2022 04:32:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3k3jr33fma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 04:32:14 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29A4WE72002686;
        Mon, 10 Oct 2022 04:32:14 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 29A4WDL6002685;
        Mon, 10 Oct 2022 04:32:14 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 76C053494; Mon, 10 Oct 2022 12:32:11 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: host: Use mhi_soc_reset() API in place of register write
Date:   Mon, 10 Oct 2022 12:32:04 +0800
Message-Id: <1665376324-34258-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X1_msNQ-_7QvX_2PlVE-yQj8MgK0uPmg
X-Proofpoint-ORIG-GUID: X1_msNQ-_7QvX_2PlVE-yQj8MgK0uPmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 mlxlogscore=862 mlxscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100026
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a direct register write is used when ramdump collection
in panic path occurs. Replace that with new mhi_soc_reset() API
such that a controller defined reset() function is exercised if
one is present and the regular SOC reset is done if it is not.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 26d0edd..1c69fee 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -118,9 +118,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
 			/* Hardware reset so force device to enter RDDM */
 			dev_dbg(dev,
 				"Did not enter RDDM, do a host req reset\n");
-			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
-				      MHI_SOC_RESET_REQ_OFFSET,
-				      MHI_SOC_RESET_REQ);
+			mhi_soc_reset(mhi_cntrl);
 			udelay(delayus);
 		}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

