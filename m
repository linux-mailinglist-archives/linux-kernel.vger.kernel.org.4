Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2197E6233B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiKITnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiKITnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:43:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716382AF7;
        Wed,  9 Nov 2022 11:43:30 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9Gm4CD024707;
        Wed, 9 Nov 2022 19:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=moWiMdb/B93rijqFbs30H5stZY7YoxeIqrKiwTyFdfc=;
 b=IC58+VZBnKdQHxlqWZS+o0ETe6g3pdKKSIpQ/BliCGNoABu+z0u0mRhmvKb3Ej9NtiXk
 Yh3sfALP6BDRYyFcfzbE2uX6WUXyuQhWCxUaAx2ELUJv52acfeDW/GTWidHC5zUwfO6a
 +BGJMQwWN4iq5mExsu+hzgA6xAZBZoTvb/t68JTSkkIuv+HBeVfWUFxJvNPI+ueQqs2C
 Xyyz3POxKmj/tm/uqBHVZE2Us5o2QnCEQp/izyPBjVfnMMycHr6PdOAAMeUowEKuye2t
 Mpzo+VyO0OWqYOVManpHdQSkjRXZEW7qZRgxYjxpKOyuczfXqTgw+IDntH++yKoxuPq0 nw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krg1y8j76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 19:43:19 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A9JhJV2000362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Nov 2022 19:43:19 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 11:43:18 -0800
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
Subject: [PATCH v4 03/16] ufs: core: Introduce Multi-circular queue capability
Date:   Wed, 9 Nov 2022 11:41:28 -0800
Message-ID: <aa223196f80538f061cac6245fd690d34f12f4b2.1668022680.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1668022680.git.quic_asutoshd@quicinc.com>
References: <cover.1668022680.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rsYeGvWAdYVktNHFF7UxzUURUS2GjIJ9
X-Proofpoint-ORIG-GUID: rsYeGvWAdYVktNHFF7UxzUURUS2GjIJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211090148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 drivers/ufs/core/ufshcd.c | 31 +++++++++++++++++++++++++++++++
 include/ufs/ufshcd.h      |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 66b797f..55cd0cd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -89,6 +89,33 @@
 /* Polling time to wait for fDeviceInit */
 #define FDEVICEINIT_COMPL_TIMEOUT 1500 /* millisecs */
 
+/* UFSHC 4.0 compliant HC support this mode, refer param_set_mcq_mode() */
+static bool mcq_mode = true;
+
+static inline bool is_mcq_supported(struct ufs_hba *hba)
+{
+	return hba->mcq_sup && mcq_mode;
+}
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
+module_param_cb(mcq_mode, &mcq_mode_ops, &mcq_mode, 0644);
+MODULE_PARM_DESC(mcq_mode, "Disable MCQ mode for UFSHCI 4.0 controllers");
+
 #define ufshcd_toggle_vreg(_dev, _vreg, _on)				\
 	({                                                              \
 		int _ret;                                               \
@@ -2258,6 +2285,10 @@ static inline int ufshcd_hba_capabilities(struct ufs_hba *hba)
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

