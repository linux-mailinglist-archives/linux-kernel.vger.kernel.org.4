Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FC69FA47
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjBVRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVRio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:38:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DC028213;
        Wed, 22 Feb 2023 09:38:39 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31MAxwtO017419;
        Wed, 22 Feb 2023 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0P+R+juQHlHNSwC5b6RqqeVMFPtdxal5F6AkMRzCLp8=;
 b=T0JMim8zUGsXQd+reBxoHnWgO/c6+JdbtwUp35P2lR18iAxowlOgrq2eECOw1Y5Sw6Q/
 1I2Dd9zIKm4fz6zYRSs2cZpI7A8m8vRCb69BRswDJfHC5Xd7MXHPIE1d1U+G9zCg4kJt
 XTfcZ+022rYM525QK46TjoPTEhkmJzhNVPaBBl1ox7vmyQ5z6YXSLeygRQsZg3lRTpef
 YxykI+ZViUKlLj3GM9bdXzKKiFYuKagqrxLPl9tl8Xt5Qtj2x6lzzU+VIn5fk62IDN59
 OW+O8BOK/B1CtZbA1V4dTwZIvhV/QEp1Spp/HqutXVYhwErlfR+6C7ba6YGFUuw7/dum 2Q== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nw8gntbkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 17:37:59 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31MHbtdf021923;
        Wed, 22 Feb 2023 17:37:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3ntqrkxfsa-1;
        Wed, 22 Feb 2023 17:37:55 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31MHbt27021918;
        Wed, 22 Feb 2023 17:37:55 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vpernami-hyd.qualcomm.com [10.213.107.240])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 31MHbslX021916;
        Wed, 22 Feb 2023 17:37:55 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2370923)
        id 0FE3A157C; Wed, 22 Feb 2023 23:07:54 +0530 (+0530)
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
To:     mhi@lists.linux.dev
Cc:     quic_qianyu@quicinc.com, manivannan.sadhasivam@linaro.org,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_skananth@quicinc.com, mrana@quicinc.com,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:MHI BUS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] bus: mhi: host: Avoid ringing EV DB if there is no elements to process
Date:   Wed, 22 Feb 2023 23:07:48 +0530
Message-Id: <1677087470-7004-1-git-send-email-quic_vpernami@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jqmkLrMG69aIoaxkjaEBeR2sWAHnU43p
X-Proofpoint-GUID: jqmkLrMG69aIoaxkjaEBeR2sWAHnU43p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_06,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220154
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mhi_poll function can be called by mhi client drivers
which will call process_event, which will ring DB even if
there no ring elements to process. This could cause
doorbell event to be processed by MHI device to check for
any ring elements even it is none and also it will occupy
lot of bandwidth on peripheral when mhi_poll() is called in
aggressive loop.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

---
changes since v4:
	updating the commit text with more information.
changes since v3:
	- Updating commit text for multiple versions of patches.
changes since v2:
	- Updated comments in code.
changes since v1:
	- Add an check to avoid ringing EV DB in mhi_process_ctrl_ev_ring().
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

