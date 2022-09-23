Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E7D5E711E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiIWBIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiIWBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:08:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A29A1176F0;
        Thu, 22 Sep 2022 18:08:09 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N0j2ue012806;
        Fri, 23 Sep 2022 01:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lsfS4h+DL/itTRVioIStSKnw7sU3woJoVoxjfF+G9/8=;
 b=FfAC2bqIOF6Ofp0YCD+yPdiFhA9tzshZiFhZPDT+w7Y4RxXmM82hrYtR9axJ7DNXHlPM
 LIPyb8Y50BzjYAGpH1MAE/Cl4hk5klb3rHEakLbT5SM0l0Gu2+DmuQVEj9tBGx4mAQkW
 /xRe8RL+8p91PHdxliCGC30kHHcFUwbfj0fE2XdsHyYPp3VHKTNkbrtNAConmIp6JINF
 L+62/icPYb9fU2o/8VGwm4+t2Cpvxd4QzX2D7NVdxf5W/VExRUsx6tzbZa0sdQ2Urv1v
 K4opXHrlkbieNZLRSfzMKe9psiMi5++U1Nyw0dhST/FCoygP5OjwbxDqRIgnulMvQq1b Cg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jrpqnskkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:46 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28N17jMv009153
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 01:07:45 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 18:07:44 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <mani@kernel.org>, <quic_nguyenb@quicinc.com>,
        <quic_xiaosenh@quicinc.com>, <quic_cang@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_rampraka@quicinc.com>,
        <quic_richardp@quicinc.com>, <stanley.chu@mediatek.com>,
        <adrian.hunter@intel.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <beanhuo@micron.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 09/16] ufs: core: mcq: Use shared tags for MCQ mode
Date:   Thu, 22 Sep 2022 18:05:16 -0700
Message-ID: <c3af1d940d8a0d679281019e690c48506b8d29f3.1663894792.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1663894792.git.quic_asutoshd@quicinc.com>
References: <cover.1663894792.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P5HcJwnAVNO3L5y5sbFtAdxoRzl7_Qr2
X-Proofpoint-GUID: P5HcJwnAVNO3L5y5sbFtAdxoRzl7_Qr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_16,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable shared taggs for MCQ. For UFS, this should
not have a huge performance impact. It however
simplifies the MCQ implementation and reuses most of
the existing code in the issue and completion path.
Also add multiple queue mapping to map_queue().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufs-mcq.c |  2 ++
 drivers/ufs/core/ufshcd.c  | 31 +++++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 7e57e7e..d40b237 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -383,6 +383,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 {
 	int ret, i;
 	struct ufs_hw_queue *hwq;
+	struct Scsi_Host *host = hba->host;
 
 	ret = ufshcd_mcq_config_nr_queues(hba);
 	if (ret)
@@ -416,6 +417,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	/* Give dev_cmd_queue the minimal number of entries */
 	hba->dev_cmd_queue->max_entries = 2;
 
+	host->host_tagset = 1;
 	return 0;
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b1af85c..6d70065 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2719,25 +2719,28 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static int ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i, ret;
+	int i, queue_offset = 0;
+	struct ufs_hba *hba = shost_priv(shost);
+
+	if (!is_mcq_supported(hba)) {
+		hba->nr_queues[HCTX_TYPE_DEFAULT] = 1;
+		hba->nr_queues[HCTX_TYPE_READ] = 0;
+		hba->nr_queues[HCTX_TYPE_POLL] = 1;
+		hba->nr_hw_queues = 1;
+	}
 
 	for (i = 0; i < shost->nr_maps; i++) {
 		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
 
-		switch (i) {
-		case HCTX_TYPE_DEFAULT:
-		case HCTX_TYPE_POLL:
-			map->nr_queues = 1;
-			break;
-		case HCTX_TYPE_READ:
-			map->nr_queues = 0;
+		map->nr_queues = hba->nr_queues[i];
+		if (!map->nr_queues)
 			continue;
-		default:
-			WARN_ON_ONCE(true);
-		}
-		map->queue_offset = 0;
-		ret = blk_mq_map_queues(map);
-		WARN_ON_ONCE(ret);
+		map->queue_offset = queue_offset;
+		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
+			map->queue_offset = 0;
+
+		blk_mq_map_queues(map);
+		queue_offset += map->nr_queues;
 	}
 
 	return 0;
-- 
2.7.4

