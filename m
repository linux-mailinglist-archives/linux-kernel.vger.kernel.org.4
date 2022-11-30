Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB29763E1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiK3U2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiK3U2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:28:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75614A05B;
        Wed, 30 Nov 2022 12:28:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUCs0e9018690;
        Wed, 30 Nov 2022 20:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=7S4T/d7o/o3m7oWFT/7SEWHru8hmIy5SxOT8QbpPUxE=;
 b=UDmRATgk0DXvADAkXnui6N1XTQORWUGFNS0gCUGlU7+4pgWmvotN5xtfWT7M3IvoFX+G
 yNPCsDsLm+eSqUVhXF/nky3ujeHpe9QLgIfZb4FjkuqYzytHzofyBtRMuzXHpei9Vpu9
 d4MaVb4gX4EFA9an0DlXVuOSUmAZSy/ZoAhftpyGRf8Xm0yy9onGAT9plM0LQvseRsQD
 q6v9dZsmi/QzP3p3PQC03+gPu3LDMah7O3Qc4bTAuPS1nFG+L+Nv6PnugY3A9DvNDyU+
 2pEOM37CV9zhqKticq4t1Zj4X6RZPTacbjpx8EKbc02SB1L4Xpgu3dBD88++G5mbfasF Hw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5n1rw1tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:28:10 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AUKS9Zs029678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 20:28:10 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 12:28:09 -0800
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
Subject: [PATCH v8 01/16] ufs: core: Optimize duplicate code to read extended feature
Date:   Wed, 30 Nov 2022 12:27:42 -0800
Message-ID: <c166e46a1fff4662f7b3677dcbf0b814eaa98ae0.1669839847.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669839847.git.quic_asutoshd@quicinc.com>
References: <cover.1669839847.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z5kwM0iEVXrSzspFZ5YUCTlfkZVqaekK
X-Proofpoint-ORIG-GUID: Z5kwM0iEVXrSzspFZ5YUCTlfkZVqaekK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300143
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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

