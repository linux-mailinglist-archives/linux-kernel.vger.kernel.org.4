Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD66479BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLHXT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLHXTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:19:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03170A0FB6;
        Thu,  8 Dec 2022 15:19:29 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B8MlgbL007456;
        Thu, 8 Dec 2022 23:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pdKIMJ/UrD6GGAEohrm/VtNxCd41dtCamf/awJloxGM=;
 b=Udv5OdiRZGN4UYjnt0wkz4MGfyAoRX2VcHONH4atUKZDU+4NYFj6WKNcN8x4UsoXKK32
 cVpcgfY/wYwDse0dE0ZZmAvcuDFNbf3Sf/qwlRw13LKpQVpmz5HAFC2+GeAnJpzvIWcc
 UFA2d5CdVCxIQwsdsmx45gmWavvBZqhqGXsR93RjUhe+HF5vs4MKlQdXO2NqiAizFmdS
 G69z526IjJe0xgJ1QWHo5V4dedDhT6yyBH+XMGKa3rOiUfDuQVg2YrnfUblt496Wyh/8
 /TQKLcQCdAna6E6WZCswk3kcFMvOzUiT5xBVNOdexHFsd/ZyZatld21MKvrLKCJX/lpi EA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mbffs9ne4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Dec 2022 23:19:11 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B8NJAML030391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Dec 2022 23:19:10 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 8 Dec 2022 15:19:10 -0800
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
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Keoseong Park <keosung.park@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v11 03/16] ufs: core: Introduce Multi-circular queue capability
Date:   Thu, 8 Dec 2022 15:18:29 -0800
Message-ID: <49921a49f2ad5b64a7c46535c485f281877baf7a.1670541364.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1670541363.git.quic_asutoshd@quicinc.com>
References: <cover.1670541363.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _b2Tx6UY_jpi75V805qr1CFuiC4t2SLp
X-Proofpoint-GUID: _b2Tx6UY_jpi75V805qr1CFuiC4t2SLp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-08_12,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212080192
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to check for MCQ capability in the UFSHC.
Add a module parameter to disable MCQ if needed.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 26 ++++++++++++++++++++++++++
 include/ufs/ufshcd.h      |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 595fd3c..eca15b0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -89,6 +89,28 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
+static bool use_mcq_mode = true;
+
+static int param_set_mcq_mode(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_bool(val, kp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct kernel_param_ops mcq_mode_ops = {
+	.set = param_set_mcq_mode,
+	.get = param_get_bool,
+};
+
+module_param_cb(use_mcq_mode, &mcq_mode_ops, &use_mcq_mode, 0644);
+MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from UFSHCI 4.0. 1 - enable MCQ, 0 - disable MCQ. MCQ is enabled by default");
+
 #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
 	({                                                              \
 		int _ret;                                               \
@@ -2258,6 +2280,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
 	if (err)
 		dev_err(hba->dev, "crypto setup failed\n");
 
+	hba->mcq_sup = FIELD_GET(MASK_MCQ_SUPPORT, hba->capabilities);
+	if (!hba->mcq_sup)
+		return err;
+
 	hba->mcq_capabilities = ufshcd_readl(hba, REG_MCQCAP);
 	hba->ext_iid_sup = FIELD_GET(MASK_EXT_IID_SUPPORT,
 				     hba->mcq_capabilities);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index aec37cb9..70c0f9f 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -832,6 +832,7 @@ struct ufs_hba_monitor {
  * @complete_put: whether or not to call ufshcd_rpm_put() from inside
  *	ufshcd_resume_complete()
  * @ext_iid_sup: is EXT_IID is supported by UFSHC
+ * @mcq_sup: is mcq supported by UFSHC
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -982,6 +983,7 @@ struct ufs_hba {
 	u32 luns_avail;
 	bool complete_put;
 	bool ext_iid_sup;
+	bool mcq_sup;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
-- 
2.7.4

