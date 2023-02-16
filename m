Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0D699AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBPROc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:14:31 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148393346A;
        Thu, 16 Feb 2023 09:14:30 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GEx63f003817;
        Thu, 16 Feb 2023 17:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=PxPkRJZzc4JHU9m0FVL3OCsRRck3AX4/UIm6ZPgmGyI=;
 b=dqCh6u5AzRFZ5yRDu6FJIOHzCF7TBybioPbVc5Kw+6PDsrPSwIzltPkDDJLsyPxwUcLZ
 tOlLFcS/hribn3wu7c4Cb8nB9EBLGLkE8ycbuYx1wykN3BcCYdWV/plSxcXhJOsodJhc
 /n0X2S/Q9fLomuwBsrXNB9gXtLWLRskC5+4YtEwUJpA0nfNuWKg5x3/P3D2AaJXHn1Qc
 ukxj+23BWqem8IqyJ0At4+27knozZCPapGqQnHKuZdXdFIUFSpKz4HHdj0Uc1gt0Xp4X
 AU/zJitVmXxWVGgR2nLeV1UlijKT0DUdqnvg7QnAfaffiXmlDekaVOpkDMh+V6Y8F2MD iA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nse3d1qa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:14:09 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GHE9PT022019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:14:09 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 09:14:08 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <adrian.hunter@intel.com>,
        <bvanassche@acm.org>, <avri.altman@wdc.com>, <mani@kernel.org>,
        <beanhuo@micron.com>, Asutosh Das <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/1] ufs: mcq: fix incorrectly set queue depth
Date:   Thu, 16 Feb 2023 09:13:46 -0800
Message-ID: <8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6ILm0250VvaxEv178_pMJUTq5WNSwrfR
X-Proofpoint-ORIG-GUID: 6ILm0250VvaxEv178_pMJUTq5WNSwrfR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_13,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302160150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_config_mcq() may change the can_queue value.
The current code invokes scsi_add_host() before ufshcd_config_mcq().
So the tags are limited to the old can_queue value.

Fix this by invoking scsi_add_host() after ufshcd_config_mcq().

Fixes: 2468da61ea09 ("scsi: ufs: core: mcq: Configure operation and runtime interface")
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>

----
v1 -> v2:
  - Added Fixes tag
  - Reworked to handle success case first
---
 drivers/ufs/core/ufshcd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78d3b10..3891183897f0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8530,7 +8530,9 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 			return ret;
 		if (is_mcq_supported(hba) && !hba->scsi_host_added) {
 			ret = ufshcd_alloc_mcq(hba);
-			if (ret) {
+			if (!ret) {
+				ufshcd_config_mcq(hba);
+			} else {
 				/* Continue with SDB mode */
 				use_mcq_mode = false;
 				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
@@ -8542,10 +8544,10 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 				return ret;
 			}
 			hba->scsi_host_added = true;
-		}
-		/* MCQ may be disabled if ufshcd_alloc_mcq() fails */
-		if (is_mcq_supported(hba) && use_mcq_mode)
+		} else if (is_mcq_supported(hba)) {
+			/* UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH is set */
 			ufshcd_config_mcq(hba);
+		}
 	}
 
 	ufshcd_tune_unipro_params(hba);
-- 
2.7.4

