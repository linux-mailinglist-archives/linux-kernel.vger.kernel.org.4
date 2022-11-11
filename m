Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9F625493
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiKKHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:46:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943177227;
        Thu, 10 Nov 2022 23:46:22 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7rJt3LW3zbndc;
        Fri, 11 Nov 2022 15:42:38 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 15:46:20 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <james.smart@broadcom.com>, <dick.kennedy@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] scsi: lpfc: Use memset_startat() helper
Date:   Fri, 11 Nov 2022 15:43:10 +0800
Message-ID: <20221111074310.132125-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User memset_startat() helper to simplify the code, no functional
changes in this patch.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index d25afc9dde14..35c9404d5e49 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -1373,7 +1373,6 @@ static void
 __lpfc_sli_release_iocbq_s4(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 {
 	struct lpfc_sglq *sglq;
-	size_t start_clean = offsetof(struct lpfc_iocbq, wqe);
 	unsigned long iflag = 0;
 	struct lpfc_sli_ring *pring;
 
@@ -1430,7 +1429,7 @@ __lpfc_sli_release_iocbq_s4(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 	/*
 	 * Clean all volatile data fields, preserve iotag and node struct.
 	 */
-	memset((char *)iocbq + start_clean, 0, sizeof(*iocbq) - start_clean);
+	memset_startat(iocbq, 0, wqe);
 	iocbq->sli4_lxritag = NO_XRI;
 	iocbq->sli4_xritag = NO_XRI;
 	iocbq->cmd_flag &= ~(LPFC_IO_NVME | LPFC_IO_NVMET | LPFC_IO_CMF |
@@ -1453,12 +1452,11 @@ __lpfc_sli_release_iocbq_s4(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 static void
 __lpfc_sli_release_iocbq_s3(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq)
 {
-	size_t start_clean = offsetof(struct lpfc_iocbq, iocb);
 
 	/*
 	 * Clean all volatile data fields, preserve iotag and node struct.
 	 */
-	memset((char*)iocbq + start_clean, 0, sizeof(*iocbq) - start_clean);
+	memset_startat(iocbq, 0, iocb);
 	iocbq->sli4_xritag = NO_XRI;
 	list_add_tail(&iocbq->list, &phba->lpfc_iocb_list);
 }
-- 
2.17.1

