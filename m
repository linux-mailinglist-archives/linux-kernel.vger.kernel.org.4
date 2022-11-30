Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF23363E620
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 01:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLAAGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 19:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiLAAEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 19:04:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D7890778;
        Wed, 30 Nov 2022 16:02:11 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUNKCCR012405;
        Thu, 1 Dec 2022 00:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ayT/B9TTsuGZyGZdPUqnbVMQKOPEfENgzDqXeHo/pjg=;
 b=Cpmrn6z98rNoutXFELRAzrOmYPfIk2tJGr8mvOHnMgsoCQA0utkOgPS7BZxbuG+m+ubs
 Abd/zoIzvsoy0Ty76S3jPNyxBv7QtdCENUf/6gHbaOZZt8lvhjlVwRd/x9BhQC38/a1u
 QwuUACao2S+aKH38+I8piT4YKuyTMK94FBZKOeEbNsyFWrL1bt79VD5g3c8zKZ/gh0gq
 8+NTOvvJHFhrDZFJSwT4J4w7/fdvUhuQvrC4OO66s6JuUqiq8OhBZKZ2GbN4NUrFYiAe
 EU1b5s+ejN4HEW2FIkbkVOG7kDNYrQn4Aa8edS9lVCLot46o1ziHDJql7Xm2dznUK7Uq 2Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5yhu3xeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 00:02:00 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2B1020u5025029
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Dec 2022 00:02:00 GMT
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 30 Nov 2022 16:01:59 -0800
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
Subject: [PATCH v9 10/16] ufs: core: mcq: Use shared tags for MCQ mode
Date:   Wed, 30 Nov 2022 15:50:42 -0800
Message-ID: <f789defa1a2b7ae163aaded60b6e55ffe6020203.1669850856.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1669850856.git.quic_asutoshd@quicinc.com>
References: <cover.1669850856.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DhLZSbAQrMZZmK93ydr7jSO703i0y7Xx
X-Proofpoint-ORIG-GUID: DhLZSbAQrMZZmK93ydr7jSO703i0y7Xx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211300171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable shared tags for MCQ. For UFS, this should
not have a huge performance impact. It however
simplifies the MCQ implementation and reuses most of
the existing code in the issue and completion path.
Also add multiple queue mapping to map_queue().

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/ufs/core/ufs-mcq.c |  2 ++
 drivers/ufs/core/ufshcd.c  | 28 ++++++++++++++++------------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index a783dcd..cffec4c 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -280,6 +280,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 
 int ufshcd_mcq_init(struct ufs_hba *hba)
 {
+	struct Scsi_Host *host = hba->host;
 	struct ufs_hw_queue *hwq;
 	int ret, i;
 
@@ -315,6 +316,7 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 	/* Give dev_cmd_queue the minimal number of entries */
 	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
 
+	host->host_tagset = 1;
 	return 0;
 }
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 3210f6e..965e844 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -2763,24 +2763,28 @@ static inline bool is_device_wlun(struct scsi_device *sdev)
  */
 static void ufshcd_map_queues(struct Scsi_Host *shost)
 {
-	int i;
+	struct ufs_hba *hba = shost_priv(shost);
+	int i, queue_offset = 0;
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
+		map->queue_offset = queue_offset;
+		if (i == HCTX_TYPE_POLL && !is_mcq_supported(hba))
+			map->queue_offset = 0;
+
 		blk_mq_map_queues(map);
+		queue_offset += map->nr_queues;
 	}
 }
 
-- 
2.7.4

