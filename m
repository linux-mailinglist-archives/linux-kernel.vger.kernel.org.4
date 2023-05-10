Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDE6FDA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbjEJI45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEJI4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:56:53 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF51992
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:56:51 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510085650epoutp0367c7b4233af43c34da0bb3038fcf24f9~dvGyJBiop1904419044epoutp03K
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:56:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510085650epoutp0367c7b4233af43c34da0bb3038fcf24f9~dvGyJBiop1904419044epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683709010;
        bh=J1DOTjK8gn87giwmABoGcvRXxfDSssG6aRXYYY56duk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=umFmWPI1h3xq6KWOn9ccYpx2SqYTYAq7IrFm01qWBs0DnJb6VIAcqq380Z18jZwUt
         Mo4gncJbmeFyniWZnn1BpwsDkFHl/XBNyFkDADGSeg59ERpzbK85JP5+gpfvdnlWvw
         F3vros25MA8PC1aMcPRRA1NLFjZR05yTA1S/csZ0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230510085649epcas2p2753e134660d5d8874f0a72088df2d640~dvGxmnF2f1277712777epcas2p2o;
        Wed, 10 May 2023 08:56:49 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTRN6M9zz4x9Py; Wed, 10 May
        2023 08:56:48 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-6d-645b5c50b6c2
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.69.08199.05C5B546; Wed, 10 May 2023 17:56:48 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 09/14] scsi: change to use blk_rq_nr_integrity_segments()
 instead of blk_rq_count_integrity_sg()
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230510085648epcms2p8f7a9095b798cab8746c39ea25d7f3bec@epcms2p8>
Date:   Wed, 10 May 2023 17:56:48 +0900
X-CMS-MailID: 20230510085648epcms2p8f7a9095b798cab8746c39ea25d7f3bec
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmuW5ATHSKQfcSE4vVd/vZLF4e0rRY
        ufook0Vv/1Y2i0U3tjFZ/O26x2Qx6dA1RounV2cxWey9pW1xedccNovlx/8xWax7/Z7F4veP
        OWwOvB7n721k8di8Qsvj8tlSj02rOtk8Jiw6wOix+2YDm0dv8zs2j49Pb7F49G1ZxejxeZOc
        R/uBbqYA7qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23
        zByg85UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYG
        BkamQIUJ2Rl7N81nKtjEVzFx1Tb2BsaJPF2MnBwSAiYS9488Yu9i5OIQEtjBKPHh9ibmLkYO
        Dl4BQYm/O4RBTGGBUomNBzNAyoUElCTOrZnFCBE2kLjVaw4SZhPQk/i5ZAYbyBQRgZ0sEt/v
        H2WEGM8rMaP9KQuELS2xfflWsF5OAT+J1seWEGENiR/LepkhbFGJm6vfssPY74/NhxojItF6
        7yxUjaDEg5+7oeKSEocOfWUDGSkhkC+x4UAgRLhG4u3yA1Al+hLXOjaCXcAr4Ctx7PcqJhCb
        RUBVYunE86wQNS4Sc79uBoszC8hLbH87BxwGzAKaEut36UNMV5Y4cosFooJPouPwX3aY/xo2
        /sbK3jHvCRNEq5rEoiYjiLCMxNfD89knMCrNQoTxLCRrZyGsXcDIvIpRLLWgODc9tdiowBge
        rcn5uZsYwWlYy30H44y3H/QOMTJxMB5ilOBgVhLh9Q6NShHiTUmsrEotyo8vKs1JLT7EaAr0
        8ERmKdHkfGAmyCuJNzSxNDAxMzM0NzI1MFcS55W2PZksJJCeWJKanZpakFoE08fEwSnVwFTB
        vdj1pNrdux4zzT98OH7IP0fs8FyjyMKwJbYfvuQLM6f1Czj8mNYj/qeY4+WyRdmTXEo1NRlO
        vV+ivPHGsWKVgoZts7SLOiXqjJQVKxaUnPzGd7f5E6ukqNikrGeZJjLr7zlN4j9+M741TEPp
        R1hFZ4/+jB0pKhueyFq7nGb/NcFs3iX+1zFXFt5afNTPVv+rGv+5n+8Xt2fIzE7/NWn5x0vB
        Jx87/JwvcT5kacsn7XXGh13Vt7Bt8Nz48Zjzr8QLtbdrN606tKGvR3rm5PZ3/d3H7035Ea5V
        v1mT9U5pWEnqE4vjmZb6/k/7tiw9Ye2xvCb2QPOfuKajp81PyUvIp7fp/1q6TCHs75nr7+Yp
        sRRnJBpqMRcVJwIA9QaM7UwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p8>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the block layer, the number of segments is recorded in the request.
It is already divided into separate segments based on hw information.
Therefore, there is no need to count again.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/scsi_lib.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 89cf21345e1a..5d67b6f6854e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1006,8 +1006,9 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 static blk_status_t scsi_alloc_integrity_sgtables(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
+	unsigned short nr_integrity_segs = blk_rq_nr_integrity_segments(rq);
 	struct scsi_data_buffer *prot_sdb = cmd->prot_sdb;
-	int count, ivecs;
+	int count;
 
 	if (WARN_ON_ONCE(!prot_sdb)) {
 		/*
@@ -1018,9 +1019,7 @@ static blk_status_t scsi_alloc_integrity_sgtables(struct scsi_cmnd *cmd)
 		return BLK_STS_IOERR;
 	}
 
-	ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
-
-	if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+	if (sg_alloc_table_chained(&prot_sdb->table, nr_integrity_segs,
 				   prot_sdb->table.sgl,
 				   SCSI_INLINE_PROT_SG_CNT)) {
 		return BLK_STS_RESOURCE;
@@ -1028,10 +1027,7 @@ static blk_status_t scsi_alloc_integrity_sgtables(struct scsi_cmnd *cmd)
 
 	count = blk_rq_map_integrity_sg(rq->q, rq->bio, prot_sdb->table.sgl);
 
-	BUG_ON(count > ivecs);
-	BUG_ON(count > queue_max_integrity_segments(rq->q));
-
-	cmd->prot_sdb = prot_sdb;
+	BUG_ON(count > prot_sdb->table.nents);
 	cmd->prot_sdb->table.nents = count;
 
 	return BLK_STS_OK;
-- 
2.34.1
