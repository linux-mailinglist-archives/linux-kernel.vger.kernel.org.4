Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6B6279E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiKNKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiKNKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:01:18 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EBA1FCEC;
        Mon, 14 Nov 2022 01:59:01 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE9BFMK000999;
        Mon, 14 Nov 2022 09:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=gGPlH0J0ZgP0fl1WELCt3mZvXB6Imkjsv9bFWRfwdkI=;
 b=brObxU1LSSsqKjtU0MJAllt3s9y9WnJxFyDOnc1i1XnTjooLc+bGLqMNkmldwmMdY/g2
 UCDvSWklOoAAl6DUgobJ1h/NValQiqB6c1tSaUTYckpMPxlADRw704t+CVMts4k8A+kS
 uoXltxXzMRNa20jBCei67XYunQ8FLjIgX5I1oTyUo5wxe76Ja0wUM0zzzrvawOqrRsuW
 TP4sUhSHerS19Gfa02pRSEMMz8ens7BqzUJ1IMZtpmm+DRF+y+s+3x2/GJ51YrprwH5P
 sgdcCOfbg7yRhGuxZWaJSBmfC9oh9r/q48ZWcTKTPXpj0+1IZqjTo0Aj2ftOFJqGIS0y aA== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kug3hghjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 09:58:50 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AE9wm9J015080;
        Mon, 14 Nov 2022 09:58:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 3kt4jp62k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Nov 2022 09:58:48 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AE9wmj2015017;
        Mon, 14 Nov 2022 09:58:48 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 2AE9wlB2014930;
        Mon, 14 Nov 2022 09:58:47 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id 1A21F2A97; Mon, 14 Nov 2022 17:58:46 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2] bus: mhi: host: Disable preemption while processing data events
Date:   Mon, 14 Nov 2022 17:58:43 +0800
Message-Id: <1668419923-20292-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TSLA5vhrL16Q6X0EnwBuYprbX9H-76Qr
X-Proofpoint-ORIG-GUID: TSLA5vhrL16Q6X0EnwBuYprbX9H-76Qr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_07,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 mlxlogscore=734 impostorscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140073
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
v1->v2: add comments about why we disable local irq

 drivers/bus/mhi/host/main.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..fcb2586 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1027,13 +1027,20 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 
 void mhi_ev_task(unsigned long data)
 {
+	unsigned long flags;
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
 	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
 
 	/* process all pending events */
-	spin_lock_bh(&mhi_event->lock);
+	spin_lock_irqsave(&mhi_event->lock, flags);
+	/*
+	 * When muiltiple IRQs come, the tasklet will be scheduled out with event ring lock
+	 * remaining acquired, causing M0 event process on another core gets stuck when it
+	 * tries to acquire the same event ring lock. Thus let's disable local IRQs here.
+	 */
+
 	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-	spin_unlock_bh(&mhi_event->lock);
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
 }
 
 void mhi_ctrl_ev_task(unsigned long data)
-- 
2.7.4

