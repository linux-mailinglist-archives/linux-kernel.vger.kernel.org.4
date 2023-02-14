Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526A3696C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjBNRwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBNRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:52:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75828234;
        Tue, 14 Feb 2023 09:52:03 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E8tEua027654;
        Tue, 14 Feb 2023 17:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZYHZ4ckjyGD5Yz0B1eMhHGI9Jd6vVkao9w1IpBrLy4E=;
 b=YNwuMBeMkdlqPajEujadxbWkrmDIzxsf27wV4bB0N6PlVY0x8pdgj/HDj+MWb1URoec9
 UlXTj3lDJAzq1Vh2mZyVLkecw3Uhe88k7q/2WpSJlA6Z9HzabBQ+/BzKOgxUL1XQqkzC
 DKh+f65GTvpAYBXWm+iGIcA/CXAm8EYY9JVL6IkSlxqqc9bXgppSj4bnZwnKkvwxjvXI
 gGuSBU74n4BR5l7Z6xhXrFM9GkBX65PQkYi9gA2GXfAnXYWb7aVFIdqdkEpHYzAdOrxi
 XCQiYcVnb4zQOlAcZlTqMMo41AlM8oKR7cSb/RuqBNpDoFmNDFUbdJ2ciVG8gRhjo3n2 Bg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nr6qkhgaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:51:46 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EHpjSI010658
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 17:51:45 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 09:51:44 -0800
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
        Jinyoung Choi <j-young.choi@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] ufs: mcq: fix incorrectly set queue depth
Date:   Tue, 14 Feb 2023 09:50:25 -0800
Message-ID: <da085383bec5c08bf34220ec6cc577f7a1b49ba8.1676396928.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0p7jTAV8lW10qSLCX2xzxsOclg6UpE41
X-Proofpoint-ORIG-GUID: 0p7jTAV8lW10qSLCX2xzxsOclg6UpE41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_13,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ufshcd_config_mcq() may change the can_queue value.
The current code invokes scsi_add_host() before ufshcd_config_mcq().
So the tags are limited to the old can_queue value.

Fix this by invoking scsi_add_host() after ufshcd_config_mcq().

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3b3cf78..04e42b2 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8535,6 +8535,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 				use_mcq_mode = false;
 				dev_err(hba->dev, "MCQ mode is disabled, err=%d\n",
 					 ret);
+			} else {
+				ufshcd_config_mcq(hba);
 			}
 			ret = scsi_add_host(host, hba->dev);
 			if (ret) {
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

