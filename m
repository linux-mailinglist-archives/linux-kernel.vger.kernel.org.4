Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BF06D5C44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjDDJp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjDDJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:45:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43B2D51;
        Tue,  4 Apr 2023 02:45:37 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3345U3wu019939;
        Tue, 4 Apr 2023 09:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=cdAMDMFLcupSroYCFsLTabB4tFiVlD0GTOdgv18U0AA=;
 b=Na30ydGLtmWetacXYUImr8M7JTlUCAFOylp0zJf4Kyd/tJNibPJ9HNxvsbY5YrbPUnt+
 tSeMVrD4Jc/UaWSoVH/Aai0WjIPsHjZioroACrgQiDjBg8VE/Ypd7XRtxiwhvs5EJkMZ
 +kcwKQiwy/1wZKv4wIby6e3Jm8R6mPN9c0mFI6kVwBbh0YZIyU7uaGG71H5KAywxNZ1p
 mWu98vvLcF71JpXd9z8Nn+hQPv6xb+OnKXJSNR8B7VTpaeWwLBUzEYtmx6n3dwFn41FV
 LNtil5gb8Wh4TjUx60rchLGiwsdW+fj4ZYVAQy34eDAKLoefzkCnHxjsp1MtsewVXF73 LQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pr4jm9nuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 09:44:28 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3349iLko029614;
        Tue, 4 Apr 2023 09:44:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3ppdpkjnuy-1;
        Tue, 04 Apr 2023 09:44:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3349iLYi029607;
        Tue, 4 Apr 2023 09:44:21 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-vpernami-hyd.qualcomm.com [10.213.107.240])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3349iKdN029605;
        Tue, 04 Apr 2023 09:44:21 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 2370923)
        id 34B2939CE; Tue,  4 Apr 2023 15:14:20 +0530 (+0530)
From:   Vivek Pernamitta <quic_vpernami@quicinc.com>
To:     mhi@lists.linux.dev
Cc:     quic_qianyu@quicinc.com, manivannan.sadhasivam@linaro.org,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_skananth@quicinc.com,
        Vivek Pernamitta <quic_vpernami@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:MHI BUS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V6] bus: mhi: host: Avoid ringing EV DB if there is no elements to process
Date:   Tue,  4 Apr 2023 15:14:16 +0530
Message-Id: <1680601458-9105-1-git-send-email-quic_vpernami@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3gDYPN6RF6hlM7Gy9l_1ZRh1xvylnQSw
X-Proofpoint-GUID: 3gDYPN6RF6hlM7Gy9l_1ZRh1xvylnQSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_02,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=832 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040090
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently mhi_process_data_event_ring()/mhi_process_ctrl_ev_ring()
will ring DB even if there no ring elements to process.
This could cause doorbell event to be processed by MHI device
to check for any ring elements even it is none.
So ring event DB only if any event ring elements are processed.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
changes since v6:
	updating the commit text.
changes since v5:
	updating the commit text.
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

