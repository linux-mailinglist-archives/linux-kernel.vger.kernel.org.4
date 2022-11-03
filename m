Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C674461781E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiKCH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiKCH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:56:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BA2733;
        Thu,  3 Nov 2022 00:55:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A3597J0021633;
        Thu, 3 Nov 2022 07:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+wzkJVLIOkoBK9Vz/nKnFDV5e28DxONxhT48KGJaUR0=;
 b=S4nrabBmU3oM+sLTsUd1Fxub+4NqRz7qGMmr78Yw3GXPJ0puIvz8/XU7NgRX30bW9eVr
 WakPtXqvDZ+K/GWugOnOkzfZLzq2XuSOOeK0I0XNekJjm/BU1HzW3GjHdYyttOCqgmKD
 4G5MqIOwQpef1arCjJxupeHRql/8OVuA6edxZrnIqAPIGVOqAvDjOwLerGdXLUT07ZEg
 8sMCRDpC36OmOHW328B5WY0YmRvNPII2SWCJYG6Hnvd6+iZisSEyHqP2Mztwodtp9Fag
 zw0OyGZNSGS9mqKtrum02frEPJIBYOI4o4BzXPJJqfODiXFyNjz8J6eXcpirxAxzHDjH xw== 
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km6wj0p01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 07:55:18 +0000
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A37tFu3012235;
        Thu, 3 Nov 2022 07:55:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 3khdm1m235-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 03 Nov 2022 07:55:15 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A37tFkQ012229;
        Thu, 3 Nov 2022 07:55:15 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 2A37tEJ5012226;
        Thu, 03 Nov 2022 07:55:15 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id E8BC936E0; Thu,  3 Nov 2022 15:55:12 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, loic.poulain@linaro.org
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: host: Disable preemption while processing data events
Date:   Thu,  3 Nov 2022 15:55:11 +0800
Message-Id: <1667462111-55496-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WKP4IfvNt9itNbE4Tv1EtCcPdrJq3BYn
X-Proofpoint-GUID: WKP4IfvNt9itNbE4Tv1EtCcPdrJq3BYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=684 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030055
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
is busy handling multiple irqs, this can starves the processing
of MHI M0 state change event on another core. Fix this issue by
disabling irq on the core processing data events.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index f3aef77a..b58698d 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1027,13 +1027,14 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 
 void mhi_ev_task(unsigned long data)
 {
+	unsigned long flags;
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
 	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
 
 	/* process all pending events */
-	spin_lock_bh(&mhi_event->lock);
+	spin_lock_irqsave(&mhi_event->lock, flags);
 	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
-	spin_unlock_bh(&mhi_event->lock);
+	spin_unlock_irqrestore(&mhi_event->lock, flags);
 }
 
 void mhi_ctrl_ev_task(unsigned long data)
-- 
2.7.4

