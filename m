Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD95F9775
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJJEl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiJJElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:41:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C3F19C35;
        Sun,  9 Oct 2022 21:41:23 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4aTT5029254;
        Mon, 10 Oct 2022 04:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=byN576BP+1YoaASgwBCSpB4lhIdxm4QzXqrB9+f/cAg=;
 b=CpRmrR2pqxC0qvcO1LMylIYLlzKhzlAFeCsNeYzxoYTV2Z/6fvNMXUbMeFYbq3bX+8Bp
 Wkt6vd4usCsQ+NarqL7XmJshLIzP2ka6p1alhpJLlo8hLGvHjV+5/f8POalZmKX1q7I8
 15XI7+y7ntIIqrOeA4YOW5otKtQXZt+T6J4TLGAT9drh1EdTDBJ8uXMSugMgTZlGiVt2
 yqByD12TWIxw2EOLyeImInbhlBHBu4UgI9eIfZ6BOgHPv4xjtUI4JpP4z/5wPeCPj2Ww
 dGdN8JFaPi+xURhlUFN35npy0JeQPV4yepAeNLg+r8YAp4zgNxj+GohohRSTbzSMi5xz VA== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k31ghaxpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 04:41:17 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 29A4fEDl002971;
        Mon, 10 Oct 2022 04:41:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3k3jmuugqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Oct 2022 04:41:14 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29A4fDCm002965;
        Mon, 10 Oct 2022 04:41:13 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 29A4fD0D002964;
        Mon, 10 Oct 2022 04:41:13 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 80C3C2DAA; Mon, 10 Oct 2022 12:41:12 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_hemantk@quicinc.com, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: host: Add session ID to MHI controller
Date:   Mon, 10 Oct 2022 12:41:10 +0800
Message-Id: <1665376870-60668-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ctdq4ZKKHK6ze6CkblyY5zW9dH0AT3OT
X-Proofpoint-ORIG-GUID: Ctdq4ZKKHK6ze6CkblyY5zW9dH0AT3OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210100027
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Session ID to be used during BHI transfers to recognize a
particular session are currently not being stored in the MHI
controller structure. Store them to allow for tracking and other
future usage.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/boot.c | 8 ++++----
 include/linux/mhi.h         | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index 26d0edd..5bed8b51 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -231,7 +231,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
 			   dma_addr_t dma_addr,
 			   size_t size)
 {
-	u32 tx_status, val, session_id;
+	u32 tx_status, val;
 	int i, ret;
 	void __iomem *base = mhi_cntrl->bhi;
 	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
@@ -253,16 +253,16 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

