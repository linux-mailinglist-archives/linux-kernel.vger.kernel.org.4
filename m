Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30807631CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiKUJeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKUJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:34:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5327213CC5;
        Mon, 21 Nov 2022 01:34:43 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL8OfjJ020302;
        Mon, 21 Nov 2022 09:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=1g+/NvOojCm5ORZk0Of68tqHGjtQ7DzUQncn3xYRqdI=;
 b=kui3l0jVo0X27upPv3QGtfk3aM7nM1ncP/EkZBzRepxGyu6el0UfYu2up4eLFfUvhNCO
 O/pBHUk5pFeafYx0VjPrDG6/FJUCurorLRz9ayz2/OT3tnXzy9f5DjgaiYbY1r0krCyc
 Qu5qaNL92AV6M1UJiecL8yuA+xkDb6lg8h6Blet8ZTf1CIAK7ZCoENDPmTUTorwAXet3
 3fc0lTqa764pzUq6KrtCWmyrBlRlS6KY4Fo7ScUytxHM4rkUObgMBVI54NdngMlHpwWt
 8GSb8wgD7L39wuZQX7KiwiHiJV9BYqL2um74eVSbPxewQqUnJSCUMhdB2hS1JCx9W+Fj 8Q== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrfbv0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 09:34:31 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AL9YSIW014860;
        Mon, 21 Nov 2022 09:34:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3kxr7nebf7-1;
        Mon, 21 Nov 2022 09:34:28 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AL9YSFo014854;
        Mon, 21 Nov 2022 09:34:28 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 2AL9YRrW014851;
        Mon, 21 Nov 2022 09:34:28 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 531B23A3D; Mon, 21 Nov 2022 17:34:26 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v4] bus: mhi: host: Disable preemption while processing data events
Date:   Mon, 21 Nov 2022 17:34:24 +0800
Message-Id: <1669023264-84125-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ROqEnf6bKpIWBVofBuHScnuHzup_6-VB
X-Proofpoint-ORIG-GUID: ROqEnf6bKpIWBVofBuHScnuHzup_6-VB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=762 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210075
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If data processing of an event is scheduled out because core
is busy handling multiple irqs, this can starve the processing
of MHI M0 state change event on another core. Fix this issue by
disabling irq on the core processing data events.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v3->v4: modify the comment
v2->v3: modify the comment
v1->v2: add comments about why we disable local irq

 drivers/bus/mhi/host/main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..6c804c3 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1029,11 +1029,17 @@ void mhi_ev_task(unsigned long data)
 {
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
 	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+	unsigned long flags;
 
+	/*
+	 * When multiple IRQs arrive, the tasklet will be scheduled out with event ring lock
+	 * acquired, causing other high priority events like M0 state transition getting stuck
+	 * while trying to acquire the same event ring lock. Thus, let's disable local IRQs here.
+	 */
+	spin_lock_irqsave(&mhi_event->lock, flags);
 	/* process all pending events */
-	spin_lock_bh(&mhi_event->lock);
 	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-	spin_unlock_bh(&mhi_event->lock);
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
 }
 
 void mhi_ctrl_ev_task(unsigned long data)
-- 
2.7.4

