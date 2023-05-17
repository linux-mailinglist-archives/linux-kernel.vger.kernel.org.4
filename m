Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9668D70724C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEQTgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEQTgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:36:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CBE67;
        Wed, 17 May 2023 12:36:20 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HJCGbC018403;
        Wed, 17 May 2023 19:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=j930xg/tW06teteipzHcEeODQmzb/AF/2fAgbxRqYxU=;
 b=JtdKC1i0VC3cG8yA6kmz2dUsUoYBqj8srTjaO3fE2QJbXt9RxGCzFZzDJOVliYyjnK0L
 yC/dvKrDyhaNI9vu0QSWpeA+Z5rw27WODDU535x7vET91tCcC9y1QeKd8cNtWeC9Zf7T
 n/KD5K0rrXb1uNTl06m2o1A64JloCp92X612A9EaxHQKYoxuG6scfOpTFmtcuh0TtJGf
 iJnZ9q4exETSa4RJ/emICn2wOqR4960Y4N1SQPfFYYJ6cpApzXAA6Sovv/9PUzmGb2Jj
 wGcLVFVo7TplH2OMPFmvLbDw8nbKAMJ65ZTV4zZjOCz/efvrrw4tMPBPbaBQMr1DPNEv 1Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmnypj5u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 19:36:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HJa9kk001806
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 19:36:09 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 12:36:08 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <ogabbay@kernel.org>, <jacek.lawrynowicz@linux.intel.com>,
        <quic_pkanojiy@quicinc.com>, <stanislaw.gruszka@linux.intel.com>,
        <quic_carlv@quicinc.com>, <quic_ajitpals@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 3/5] accel/qaic: Flush the transfer list again
Date:   Wed, 17 May 2023 13:35:38 -0600
Message-ID: <20230517193540.14323-4-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517193540.14323-1-quic_jhugo@quicinc.com>
References: <20230517193540.14323-1-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kN7K8LoaZn5DNR9BQEiAe7gqlQSTNeRA
X-Proofpoint-ORIG-GUID: kN7K8LoaZn5DNR9BQEiAe7gqlQSTNeRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

Before calling synchronize_srcu() we clear the transfer list, this is to
allow all the QAIC_WAIT_BO callers to exit otherwise the system could
deadlock. There could be a corner case where more elements get added to
transfer list after we have flushed it. Re-flush the transfer list once
all the holders of dbc->ch_lock have completed execution i.e.
synchronize_srcu() is complete.

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 drivers/accel/qaic/qaic_data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 1285c3dc9aef..8603e99a2a61 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1845,6 +1845,11 @@ void wakeup_dbc(struct qaic_device *qdev, u32 dbc_id)
 	dbc->usr = NULL;
 	empty_xfer_list(qdev, dbc);
 	synchronize_srcu(&dbc->ch_lock);
+	/*
+	 * Threads holding channel lock, may add more elements in the xfer_list.
+	 * Flush out these elements from xfer_list.
+	 */
+	empty_xfer_list(qdev, dbc);
 }
 
 void release_dbc(struct qaic_device *qdev, u32 dbc_id)
-- 
2.40.1

