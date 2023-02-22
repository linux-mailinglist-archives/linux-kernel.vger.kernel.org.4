Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0265369F314
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjBVLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjBVLAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:00:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602238674;
        Wed, 22 Feb 2023 03:00:38 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8QXrv018379;
        Wed, 22 Feb 2023 11:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=HrAdPS2hbPfvxU+D8cFrXLx1Vpaf35aF7GfPxRjpgcg=;
 b=QSP1PlwQBxdcQ6JUbkmquibeMCwtSYmyeG694iQU+UeSiMwLKlxvWqCiV8YQ7Qfe+12u
 7khWh8VIePh/Ri2co1vL+qpZaKRO2lrlaHokg/5KHlVYOJKQmjpUqPfHQZicnKPNQPRf
 IyBlyWhfJN0e2iiEV5Njt0HADr9OL1Z1D881cnTumhxTJHXXCUA/5h6PbXpepgt0C2JE
 TgozdZGg65rRfuBdBLfZ0g776Dqne9o1HqE97wpjFgwg5d47EIL4u1akijJA8eqc0A3S
 fkhhoXOaRCfSbfGZHfegj+z1Dl8Yr1kesvuUi2jwWr+KrHnNvRLvEu00A2dU1LyZ+DFu Mg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvtmm3bdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 11:00:08 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31MAuge5005892;
        Wed, 22 Feb 2023 11:00:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ntqrkw690-1;
        Wed, 22 Feb 2023 11:00:04 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MB041c010132;
        Wed, 22 Feb 2023 11:00:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vpernami-hyd.qualcomm.com [10.213.107.240])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 31MB04me010128;
        Wed, 22 Feb 2023 11:00:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2370923)
        id 713CB157C; Wed, 22 Feb 2023 16:30:03 +0530 (+0530)
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
To:     mhi@lists.linux.dev
Cc:     quic_qianyu@quicinc.com, manivannan.sadhasivam@linaro.org,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_skananth@quicinc.com,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@linaro.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        linux-arm-msm@vger.kernel.org (open list:MHI BUS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3] bus: mhi: host: Avoid ringing EV DB if there is no elements to process
Date:   Wed, 22 Feb 2023 16:29:59 +0530
Message-Id: <1677063601-28083-1-git-send-email-quic_vpernami@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pnc6uFGpCPominf0cN5sLPfydgXGhCmX
X-Proofpoint-ORIG-GUID: pnc6uFGpCPominf0cN5sLPfydgXGhCmX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=518 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220097
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid ringing Event DB if there is no elements to process.
As mhi_poll function can be called by mhi client drivers
which will call process_event, which will ring DB even if
there no ring elements to process.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index df0fbfe..1bbdb75 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -961,7 +961,9 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 	}
 
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+
+	/* Ring EV DB only if there is any pending element to process */
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)) && count)
 		mhi_ring_er_db(mhi_event);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
@@ -1031,7 +1033,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 		count++;
 	}
 	read_lock_bh(&mhi_cntrl->pm_lock);
-	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)))
+
+	/* Ring EV DB only if there is any pending element to process */
+	if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)) && count)
 		mhi_ring_er_db(mhi_event);
 	read_unlock_bh(&mhi_cntrl->pm_lock);
 
-- 
2.7.4

