Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587986AFDB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 05:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCHEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 23:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCHEDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 23:03:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C8D57082;
        Tue,  7 Mar 2023 20:03:26 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3283REkQ006180;
        Wed, 8 Mar 2023 04:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vLG0cuvGWwomiGvEcNdnNA1lLH0Ww/GRLBlWnGtv8oc=;
 b=p3z819SSSwbS3+sd9NRZXFFYvwmpK29dfSgicdxNoN7YYmlryROLsYa5jz8ZUvx2bqOt
 6tEVjWCJ2i2R7xq52EN7duplzglNZ5/2jzKcROJnSAfWPu+Wl3EwKIN8TepKvDi1T//P
 vBnEHSNb/hhGlUvOwdwVGanMWw2qzRGn+kBY0Vf65ZxKy4uuZVPO9GJTwI0ILcZhzv2H
 iPoi4N6Lknv63dkxljPXjdRbogfv1YfRj2J7s12pSrxoJ01U/bbJ4t8DkL4T1RUTYY2o
 iPJnox5bSqTlQHFaxYvAqXvuOXAUfgjHjLAPKBh0zmJrAkFiV0J9juy7bX+FUe7aQIT0 Sg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6fey0epe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 04:02:56 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32842tBA029988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Mar 2023 04:02:55 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 7 Mar 2023 20:02:54 -0800
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arthur Simchaev" <Arthur.Simchaev@wdc.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER..." 
        <linux-arm-msm@vger.kernel.org>
Subject: [RFC PATCH v1 1/4] ufs: mcq: Use ufshcd_mcq_poll_cqe_lock() in mcq mode
Date:   Tue, 7 Mar 2023 20:01:41 -0800
Message-ID: <b4f9153f9181506a954da1a877dbd3a222982dd0.1678247309.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1678247309.git.quic_nguyenb@quicinc.com>
References: <cover.1678247309.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nZ5790PnhxRv9pG8ib3gVBGo7leFVBTc
X-Proofpoint-ORIG-GUID: nZ5790PnhxRv9pG8ib3gVBGo7leFVBTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding mcq error handler support, update the mcq
code to use the ufshcd_mcq_poll_cqe_lock() in interrupt context
instead of using ufshcd_mcq_poll_cqe_nolock(). This is to keep
synchronization between mcq interrupt and error handler contexts
because both need to access the mcq hardware in separate contexts.

Signed-off-by: Bao D. Nguyen <quic_nguyenb@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c     | 6 +++---
 drivers/ufs/core/ufshcd-priv.h | 2 --
 drivers/ufs/core/ufshcd.c      | 2 +-
 drivers/ufs/host/ufs-qcom.c    | 2 +-
 include/ufs/ufshcd.h           | 2 +-
 5 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 31df052..63729dd 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -277,8 +277,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 	ufshcd_compl_one_cqe(hba, tag, cqe);
 }
 
-unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
-					 struct ufs_hw_queue *hwq)
+static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+						struct ufs_hw_queue *hwq)
 {
 	unsigned long completed_reqs = 0;
 
@@ -294,7 +294,6 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
-EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
 
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq)
@@ -307,6 +306,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_lock);
 
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f850..9597e955 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -71,8 +71,6 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
 void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
-unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
-					 struct ufs_hw_queue *hwq);
 struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 					   struct request *req);
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 629442c..e4d1b4e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6739,7 +6739,7 @@ static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
 			ufshcd_mcq_write_cqis(hba, events, i);
 
 		if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
-			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+			ufshcd_mcq_poll_cqe_lock(hba, hwq);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 34fc453..c686fb8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1558,7 +1558,7 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *__hba)
 	struct ufs_hw_queue *hwq = &hba->uhq[id];
 
 	ufshcd_mcq_write_cqis(hba, 0x1, id);
-	ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+	ufshcd_mcq_poll_cqe_lock(hba, hwq);
 
 	return IRQ_HANDLED;
 }
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 05e4164..5d7f9b2 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1244,7 +1244,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
 void ufshcd_hba_stop(struct ufs_hba *hba);
 void ufshcd_schedule_eh_work(struct ufs_hba *hba);
 void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
-unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 					 struct ufs_hw_queue *hwq);
 void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
 void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
-- 
2.7.4

