Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E164D578
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLODHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLODHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:07:36 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB1F57B68;
        Wed, 14 Dec 2022 19:07:25 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BF2w1jF019312;
        Thu, 15 Dec 2022 03:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=I8sFfArgA28fxxpoGe/I6RezTQ7Hqvhu32IadG6BIWw=;
 b=gOe4q41yQXiGaqJZrhjQPHRP2Hecn9knrY+r41pkyXqg0nXSnxp9b/J9jjCscBXgaIJ+
 vk9LtSGqMjUHRNZR0RcL9AiYjVPAZo3Pq8DKQBai2V/+nGeyNzHMHodmQGNXaq4THLFT
 WQzgaQV3c+NE0lVhyqCt33Sdr2Cbm6+YmeaAY1xVXcPPe86CZ8c3NKcavZ2Oz0lsqHGy
 cJc2D5HRdS+d0YVKboJ3R6IRYhrjLZtgSPt1CgnVJzXXhnvIrldf2ggVQy3TlMp4ysqE
 SsvTXrDKzYzZsUC7ALYuUf3arFqhw0HH2Fc7HpjmDo5iV1BqieiGVmOr3Ibi9Qvnov/R gA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkk2x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 03:07:03 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BF371WF026118;
        Thu, 15 Dec 2022 03:07:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3mffrsv2b0-1;
        Thu, 15 Dec 2022 03:07:01 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BF371Lx026103;
        Thu, 15 Dec 2022 03:07:01 GMT
Received: from stor-presley.qualcomm.com (stor-presley.qualcomm.com [192.168.140.85])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 2BF371ZH026099;
        Thu, 15 Dec 2022 03:07:01 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 75CAE20DB9; Wed, 14 Dec 2022 19:07:01 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Can Guo <quic_cang@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/3] ufs: core: mcq: Add Event Specific Interrupt enable and config functions
Date:   Wed, 14 Dec 2022 19:06:21 -0800
Message-Id: <1671073583-10065-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1671073583-10065-1-git-send-email-quic_cang@quicinc.com>
References: <1671073583-10065-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W0T5sR2JuSp94dGhBI4hVEfMldKZW7_0
X-Proofpoint-ORIG-GUID: W0T5sR2JuSp94dGhBI4hVEfMldKZW7_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_12,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212150019
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and export two functions to enable ESI and config ESI base addresses.
The calls to these exported functions will be added by the next patch in
this series.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufs-mcq.c | 16 ++++++++++++++++
 include/ufs/ufshcd.h       |  6 ++++++
 include/ufs/ufshci.h       |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index f99c912..c81e424 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -246,6 +246,7 @@ void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
 {
 	writel(val, mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_write_cqis);
 
 /*
  * Current MCQ specification doesn't provide a Task Tag or its equivalent in
@@ -293,6 +294,7 @@ unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
 
 	return completed_reqs;
 }
+EXPORT_SYMBOL_GPL(ufshcd_mcq_poll_cqe_nolock);
 
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq)
@@ -370,6 +372,20 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 	}
 }
 
+void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
+{
+	ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x2,
+		      REG_UFS_MEM_CFG);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_enable_esi);
+
+void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg)
+{
+	ufshcd_writel(hba, msg->address_lo, REG_UFS_ESILBA);
+	ufshcd_writel(hba, msg->address_hi, REG_UFS_ESIUBA);
+}
+EXPORT_SYMBOL_GPL(ufshcd_mcq_config_esi);
+
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
 	struct Scsi_Host *host = hba->host;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7f0139b..660ccd3 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -16,6 +16,7 @@
 #include <linux/blk-crypto-profile.h>
 #include <linux/blk-mq.h>
 #include <linux/devfreq.h>
+#include <linux/msi.h>
 #include <linux/pm_runtime.h>
 #include <scsi/scsi_device.h>
 #include <ufs/unipro.h>
@@ -1201,6 +1202,11 @@ void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
 void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
 void ufshcd_hba_stop(struct ufs_hba *hba);
 void ufshcd_schedule_eh_work(struct ufs_hba *hba);
+void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
+unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
+					 struct ufs_hw_queue *hwq);
+void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
+void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
 
 /**
  * ufshcd_set_variant - set variant specific data to the hba
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 1df8425..9b74194 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -59,6 +59,8 @@ enum {
 
 	REG_UFS_MEM_CFG				= 0x300,
 	REG_UFS_MCQ_CFG				= 0x380,
+	REG_UFS_ESILBA				= 0x384,
+	REG_UFS_ESIUBA				= 0x388,
 	UFSHCI_CRYPTO_REG_SPACE_SIZE		= 0x400,
 };
 
-- 
2.7.4

