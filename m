Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6176E53A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 23:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjDQVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 17:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDQVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 17:07:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D4E55;
        Mon, 17 Apr 2023 14:07:47 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HL2TTf024426;
        Mon, 17 Apr 2023 21:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OE1OGoV4a7VT903Heg3hMhnFRvsQQTxE017MPMfKI/o=;
 b=dVGOb4a0mdw/s4pnk4O1ZDUw8GGKn/PzzEWrQIBwaIGu2eIG7bfXf+6F5iOWpWbadA9f
 FJPTUF/s5BU+b2ny9Tal/7/BjY0A2Kx6ozDRhM4yW7p2zfbftpYwjnz2xZiDAaFOJ9R0
 B3Hip06EjxpkGyNjsZqrSaDw+pFef+x6cIA+sBmY10w90cuhv3sn3e9JEK0JYj81VhWu
 UDKaYEYQpvDvtXY2cIGdZthhhuT56zproV51kB2gcXC/HpzSqxnkd4LYNy5h7Ur7fYwI
 JHNXqKR3lV2qd/5fnmxTKCPJxF3oyfVJ+jHxxiovYNyHDLGzFHErlfbaURjocFAEHPoX OA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q171gh3wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 21:07:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33HL7ViK020713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 21:07:31 GMT
Received: from stor-berry.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 17 Apr 2023 14:07:31 -0700
From:   "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
To:     <quic_asutoshd@quicinc.com>, <quic_cang@quicinc.com>,
        <bvanassche@acm.org>, <mani@kernel.org>, <Powen.Kao@mediatek.com>,
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
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 4/5] ufs: mcq: Use ufshcd_mcq_poll_cqe_lock() in mcq mode
Date:   Mon, 17 Apr 2023 14:05:48 -0700
Message-ID: <69ff7913c5060396281610568929e18784a50717.1681764704.git.quic_nguyenb@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1681764704.git.quic_nguyenb@quicinc.com>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JJLnci1GgdhdI7WKOolnYP2wTb9jOazu
X-Proofpoint-ORIG-GUID: JJLnci1GgdhdI7WKOolnYP2wTb9jOazu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304170186
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e3031cd..ede4343 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -283,8 +283,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 	ufshcd_compl_one_cqe(hba, tag, cqe);
 }
 
-unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
-					 struct ufs_hw_queue *hwq)
+static unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+						struct ufs_hw_queue *hwq)
 {
 	unsigned long completed_reqs = 0;
 
@@ -300,7 +300,6 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
-EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
 
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq)
@@ -313,6 +312,7 @@ unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_lock);
 
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 {
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index ef66151..70b7ffc 100644
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
index 84efb52..fef1907 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6792,7 +6792,7 @@ static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
 			ufshcd_mcq_write_cqis(hba, events, i);
 
 		if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
-			ufshcd_mcq_poll_cqe_nolock(hba, hwq);
+			ufshcd_mcq_poll_cqe_lock(hba, hwq);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 6568fdf..34d3814 100644
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
index 25aab8e..3fca558 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1246,7 +1246,7 @@ void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
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

