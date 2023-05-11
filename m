Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F876FE9DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEKCdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKCdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:33:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CA1136;
        Wed, 10 May 2023 19:33:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B2Helv012689;
        Thu, 11 May 2023 02:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=4AA3n98gc9v+2QvDZFHA07an/528pf8iT9/Hjg3vocs=;
 b=niFNWGRUI62FKX7ps1HYILcaVLoInC6Iqvh4ZJnknTs+MBmbZl9tt9bZQYqVYgEKg/8Y
 nuPjJhoBMVy6syOl2zzr1L1EZejEtUy3eLz6T0kOF9xvN4WmwC6zUFFDBYA2HFNbBE8M
 g0spYXzbV5UW15BDM9PcYYWP6XjytjTmEds6kY8lRZfRLAUHD2duJbyN4NUyr6aH3D9J
 0XXX9r+LtlMji9MFBYSJHxKI9ACa2Qpw8I45y0IjHK8PzW0Ku6ZsFKOdXliNEGNYu4bn
 fpusOXIc9u2ouWps5dXNZ+eyhqrEBbp6y9TC2b1qiQQTRzFkPst0wLygVzEZcY7TykIj Xw== 
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgett0ygd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 02:33:30 +0000
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34B2XRJV005797;
        Thu, 11 May 2023 02:33:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdfykpm2g-1;
        Thu, 11 May 2023 02:33:27 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34B2XRUw005792;
        Thu, 11 May 2023 02:33:27 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
        by APTAIPPMTA01.qualcomm.com (PPS) with ESMTP id 34B2XQsF005791;
        Thu, 11 May 2023 02:33:27 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
        id F16EA4639; Thu, 11 May 2023 10:33:25 +0800 (CST)
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     mani@kernel.org, quic_jhugo@quicinc.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2] bus: mhi: host: Skip MHI reset if device is in RDDM
Date:   Thu, 11 May 2023 10:33:24 +0800
Message-Id: <1683772404-13192-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S-Q3QvP_uH6CUecUqShdrrYw_48JD0xv
X-Proofpoint-GUID: S-Q3QvP_uH6CUecUqShdrrYw_48JD0xv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305110019
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RDDM EE, device can not process MHI reset issued by host. In case of MHI
power off, host is issuing MHI reset and polls for it to get cleared until
it times out. Since this timeout can not be avoided in case of RDDM, skip
the MHI reset in this scenarios.

Fixes: a0f5a630668c ("bus: mhi: Move host MHI code to "host" directory")
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: use ~75 columns in commit text,	add Fixes tag

 drivers/bus/mhi/host/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 0834590..8a4362d 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -470,6 +470,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 
 	/* Trigger MHI RESET so that the device will not access host memory */
 	if (!MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state)) {
+		/* Skip MHI RESET if in RDDM state */
+		if (mhi_cntrl->rddm_image && mhi_get_exec_env(mhi_cntrl) == MHI_EE_RDDM)
+			goto skip_mhi_reset;
+
 		dev_dbg(dev, "Triggering MHI Reset in device\n");
 		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
 
@@ -495,6 +499,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 		}
 	}
 
+skip_mhi_reset:
 	dev_dbg(dev,
 		 "Waiting for all pending event ring processing to complete\n");
 	mhi_event = mhi_cntrl->mhi_event;
-- 
2.7.4

