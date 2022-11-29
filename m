Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AF63B70C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiK2BVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiK2BVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:21:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954083FB86;
        Mon, 28 Nov 2022 17:21:30 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT13jFf013961;
        Tue, 29 Nov 2022 01:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0QH8aboh/geCuqJzxjijv8s1wuxaYyzgSyyLOLEPuPI=;
 b=Hg0joTioSSf1I42suzEGgjhoYWAE/39dIIkIUw8dpmwNVqQJzOUDC78CllOnV1foEKsm
 mSXGsR4WtOg0C9H/7fiIQ8Nqq7apCcwHWLEX7CrUEbRZsmTzv4y9we/2F71bgUZOc9pe
 rSatdbUZ3MpVYQY+Lht5oqzgnd9pE/zIiQ5lj6E5qrBtyvS4Q602DDPzq0i+Nc1JfC/Z
 e2mTinuoNEBPalO+g1/jhKZSFieJbmpPoYRYAcEC3EnQ/JbctnoTU/f4KPFebwm3iwc1
 KvJvAljAB4k9WO4WFVhZJx8qBE3MPc4GqHfeXC6ol24lEkD03h4sKea+s3MjNUNRp26m 7g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3aw35fke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 01:21:18 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AT1LHE8026381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 01:21:17 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 28 Nov 2022 17:21:17 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 01/16] ufs: core: Optimize duplicate code to read extended feature
Date:   Mon, 28 Nov 2022 17:20:42 -0800
Message-ID: <773db7d025539dd1413281128416e36f324f8ac0.1669684648.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669684648.git.quic_asutoshd@quicinc.com>
References: <cover.1669684648.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cguR7NW5ZD4piKv_NBVOJ8c7itFb6EpM
X-Proofpoint-GUID: cguR7NW5ZD4piKv_NBVOJ8c7itFb6EpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_17,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211290006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to parse the extended feature is duplicated twice
in the ufs core. Replace the duplicated code with a
function.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 2dbe249..6ea22b5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -215,6 +215,17 @@ ufs_get_desired_pm_lvl_for_dev_link_state(enum ufs_dev_pwr_mode dev_state,
 	return UFS_PM_LVL_0;
 }
 
+static unsigned int ufs_get_ext_ufs_feature(struct ufs_hba *hba,
+					    const u8 *desc_buf)
+{
+	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
+	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
+		return 0;
+
+	return get_unaligned_be32(desc_buf +
+				  DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+}
+
 static const struct ufs_dev_quirk ufs_fixups[] = {
 	/* UFS cards deviations table */
 	{ .wmanufacturerid = UFS_VENDOR_MICRON,
@@ -7608,13 +7619,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
 		goto wb_disabled;
 
-	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
-	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
-		goto wb_disabled;
-
-	ext_ufs_feature = get_unaligned_be32(desc_buf +
-					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
-
+	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
 	if (!(ext_ufs_feature & UFS_DEV_WRITE_BOOSTER_SUP))
 		goto wb_disabled;
 
@@ -7668,7 +7673,7 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	if (!(hba->caps & UFSHCD_CAP_TEMP_NOTIF) || dev_info->wspecversion < 0x300)
 		return;
 
-	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
 
 	if (ext_ufs_feature & UFS_DEV_LOW_TEMP_NOTIF)
 		mask |= MASK_EE_TOO_LOW_TEMP;
-- 
2.7.4

