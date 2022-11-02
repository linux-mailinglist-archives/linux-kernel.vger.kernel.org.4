Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4361601C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKBJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiKBJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:42:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368E122BDC;
        Wed,  2 Nov 2022 02:42:06 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A29Ivv7010134;
        Wed, 2 Nov 2022 09:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=/QZZc3grguwORo1yJe+PG5HwABOwaG+12JG/N0MDOc4=;
 b=MdsR+E7VHLfs0sumt1hUK6gVYgfwgsS89uX0HMSy8n/K87FXAWReDQOmMw3NLbdspaB0
 onJ2YrMa6Cp+qJjbx5oewlcYzyYyff/SsN/tm0VvRWV0jtZJYvvE6Jq9OHCBsucKAuiE
 ZU6K7+47kvGKWdqA+kJCNiaiVLnzU75xunIbsENru+0u/LZyArwEyXyb0SCPmyRq127r
 T/x3no2uVE7ChAIUlFZU9W7yCPnnHeOgf4pXJMhHpS/wmDfHv9kOBZm74Iw6dsYf/Pvh
 3j4ekeWg319bJdIm6LYueGN2yiKYWdKRbVdGwZLnSriNd87Lo6p/Ye8YSKKuPfGWvb+R ow== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkja3ggk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 09:41:55 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A29fqgd026445;
        Wed, 2 Nov 2022 09:41:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3khdq7sex1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Nov 2022 09:41:52 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A29fp2u026440;
        Wed, 2 Nov 2022 09:41:51 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 2A29fpLI026439;
        Wed, 02 Nov 2022 09:41:51 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id C20ED36CB; Wed,  2 Nov 2022 17:41:49 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2] bus: mhi: host: Add session ID to MHI controller
Date:   Wed,  2 Nov 2022 17:41:47 +0800
Message-Id: <1667382107-14306-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2ow7Dv-jBa3d3Ro5nMJVrfijwG-et0e-
X-Proofpoint-GUID: 2ow7Dv-jBa3d3Ro5nMJVrfijwG-et0e-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 clxscore=1011 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020058
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Session ID to be used during BHI transfers to recognize a
particular session are currently not being stored in the MHI
controller structure. Store them to allow for debug enhancement
described below.

Sometimes, we may find some error logs and want to see what
happens on device side when host is printing these error logs.
Session id can help us find the logs we want on device side
quickly, especially when we are faced with a huge amount of logs.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: modify commit message.

 drivers/bus/mhi/host/boot.c | 8 ++++----
 include/linux/mhi.h         | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 1c69fee..79a0eec 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -229,7 +229,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
 			   dma_addr_t dma_addr,
 			   size_t size)
 {
-	u32 tx_status, val, session_id;
+	u32 tx_status, val;
 	int i, ret;
 	void __iomem *base = mhi_cntrl->bhi;
 	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
@@ -251,16 +251,16 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
 		goto invalid_pm_state;
 	}
 
-	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
+	mhi_cntrl->session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
 	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
-		session_id);
+		mhi_cntrl->session_id);
 	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
 		      upper_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
 		      lower_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
-	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
+	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
 	read_unlock_bh(pm_lock);
 
 	/* Wait for the image download to complete */
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index a5441ad..8b3c934 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -405,6 +405,7 @@ struct mhi_controller {
 	u32 minor_version;
 	u32 serial_number;
 	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
+	u32 session_id;
 
 	struct mhi_event *mhi_event;
 	struct mhi_cmd *mhi_cmd;
-- 
2.7.4

