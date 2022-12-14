Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587F64C30F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiLNEJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiLNEJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:09:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262227B3D;
        Tue, 13 Dec 2022 20:08:55 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BE46i5u031286;
        Wed, 14 Dec 2022 04:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=XrQ5Jw89llK1p/7+oyj2VSzcXyF2nqgQKJ4Q9FtdaLA=;
 b=fKa/kBgMB8l6sfypDsBtj4eMwRGPTjsffS7db0pUMpWwwHVjaQA66tkqt2bCkFnAHO8I
 aTU4ukMwzsNIdL1pqAuX8tpeH2BYAEDU0yCWfarWppyjM0LodbaUqGMKqayAgHJwtKUK
 bfXpL6GQsJjxVaTkdBEWUAxxS/t9AmB5R2dCGSaMXLhcZIsIW9JSBrcsvFVtbvyUCUN8
 E5h+MRLHHZPGI3xCsJ7pQoHJ6JmX1tIzIPmkeATF6u2govHLBLjMShxkzd/dmzCegvIB
 yRnCwwZB/14asJVdwEHOsdPykTy9y57lAnHomrVkhKNa038zx4KMoKjsuO13FfADbd7P HA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mf6rkg1bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 04:08:38 +0000
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE46xTB022230;
        Wed, 14 Dec 2022 04:08:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 3mck6m3hcr-1;
        Wed, 14 Dec 2022 04:08:37 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BE48bwg024555;
        Wed, 14 Dec 2022 04:08:37 GMT
Received: from stor-presley.qualcomm.com (wsp769891wss.qualcomm.com [192.168.140.85] (may be forged))
        by NASANPPMTA04.qualcomm.com (PPS) with ESMTP id 2BE48bQQ024551;
        Wed, 14 Dec 2022 04:08:37 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 3194320DF0; Tue, 13 Dec 2022 20:08:37 -0800 (PST)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, bvanassche@acm.org, mani@kernel.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        beanhuo@micron.com, avri.altman@wdc.com, junwoo80.lee@samsung.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Can Guo <quic_cang@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] ufs: core: mcq: Add Event Specific Interrupt enable and config APIs
Date:   Tue, 13 Dec 2022 20:06:01 -0800
Message-Id: <1670990763-30806-3-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670990763-30806-1-git-send-email-quic_cang@quicinc.com>
References: <1670990763-30806-1-git-send-email-quic_cang@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eLnFj10qD-nFBoUA4aPGtXriOe52caZb
X-Proofpoint-ORIG-GUID: eLnFj10qD-nFBoUA4aPGtXriOe52caZb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_01,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140031
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two APIs to enable ESI and config ESI base addresses.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
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

