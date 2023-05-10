Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE5A6FDA26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbjEJI4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEJI4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:56:15 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5C7ED0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:56:11 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230510085609epoutp03305dd53153e7a5d1d50f276d45d0f9e4~dvGMxsuYv1834518345epoutp03H
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:56:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230510085609epoutp03305dd53153e7a5d1d50f276d45d0f9e4~dvGMxsuYv1834518345epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683708969;
        bh=v5aifcuvT4v06m1yAYerf8h0h01yE8oqVL3cCIFGtC8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=QeisWYDH+pcUIb/jjZqmWj9kjOeqOborClEn2r1kgCkny2ZD12tzuTCUrkOFPgoFR
         vWVed2KbkcSKLifspcau6Oq85O4v+e+sA9oB9ZqWFohzOm2snELr9l/unXmCbBzrRU
         dZCwaCFHMwgNC6j0FrAH7YNO3zQ2I51EjoThIh40=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230510085608epcas2p1febf27b02dec1003268c5c8056bb5682~dvGL35aQq1806718067epcas2p15;
        Wed, 10 May 2023 08:56:08 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.92]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QGTQc2M0Rz4x9QB; Wed, 10 May
        2023 08:56:08 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-9c-645b5c28f5cc
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.09.08199.82C5B546; Wed, 10 May 2023 17:56:08 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2 08/14] scsi: add scsi_alloc_integrity_sgtables() for
 integrity process
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
Message-ID: <20230510085607epcms2p3d2b2dfc5db42f77c41f570c361a41c6a@epcms2p3>
Date:   Wed, 10 May 2023 17:56:07 +0900
X-CMS-MailID: 20230510085607epcms2p3d2b2dfc5db42f77c41f570c361a41c6a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFJsWRmVeSWpSXmKPExsWy7bCmha5GTHSKwfHn/Bar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy+Nt1j8li0qFrjBZPr85isth7S9vi8q45bBbLj/9jslj3+j2Lxe8f
        c9gceD3O39vI4rF5hZbH5bOlHptWdbJ5TFh0gNFj980GNo/e5ndsHh+f3mLx6NuyitHj8yY5
        j/YD3UwB3FHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCswL9IoTc4tL89L18lJLrAwN
        DIxMgQoTsjN+9r5iK/goWbHp5DHGBsZJol2MnBwSAiYSs7/8Y+li5OIQEtjBKLH/4wGmLkYO
        Dl4BQYm/O4RBaoQFoiV27j3BDmILCShJnFszixGkRFjAQOJWrzlImE1AT+LnkhlsIGNEBHay
        SHy/f5QRYj6vxIz2pywQtrTE9uVbwXo5BfwkWh9bQoQ1JH4s62WGsEUlbq5+yw5jvz82H2qM
        iETrvbNQNYISD37uhopLShw69JUNZKSEQL7EhgOBEOEaibfLD0CV6Etc69gIdgGvgK/E8WML
        WEFsFgFViQPbf7NC1LhIzG/eCmYzC8hLbH87hxlkJLOApsT6XfoQ05Uljtxigajgk+g4/Jcd
        5r+Gjb+xsnfMe8IE0aomsajJCCIsI/H18Hz2CYxKsxCBPAvJ2lkIaxcwMq9iFEstKM5NTy02
        KjCGx2tyfu4mRnAi1nLfwTjj7Qe9Q4xMHIyHGCU4mJVEeL1Do1KEeFMSK6tSi/Lji0pzUosP
        MZoCPTyRWUo0OR+YC/JK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBK
        NTBNcq6b8SvAYMql6jCDuNS+7A1H+lXjdBR29tlsEPSY3ZoXp2ba5rPjxM6DZVM35W4ovyL8
        K4Uj+EbWnVL/A5pXvy3MPfj81LdlD/mj/E9dcCr+N4Vn6yf/kJxd8z40PrUPfxkg9Ox9f1Tn
        JrVlXYY9hjub0pY1iysFbPv8VCGWPaUn/Hvkg5aYDRGF+pomSbvYxBczP/abv23Xb07+NYI8
        CXwKMz7ZOoY6pPfkLAh8IhsueeO6UC6XwtNjx+yunVcQmJDpVfhk693ZVc3yz1+0KnK807ve
        eUZfccm2qEtXvs0Jmug1O5d3a1rYGe5v34QvnzNYs2tzwKTtVSaO2RxP4uTWG9rXSYQ3Rs35
        /lmJpTgj0VCLuag4EQD4eukiTQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p3>
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

Separate the integrity mapping process of scsi_alloc_sgtables() into a
new function for readability.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/scsi_lib.c | 71 ++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b7c569a42aa4..89cf21345e1a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1003,6 +1003,40 @@ static inline bool scsi_cmd_needs_dma_drain(struct scsi_device *sdev,
 	       sdev->host->hostt->dma_need_drain(rq);
 }
 
+static blk_status_t scsi_alloc_integrity_sgtables(struct scsi_cmnd *cmd)
+{
+	struct request *rq = scsi_cmd_to_rq(cmd);
+	struct scsi_data_buffer *prot_sdb = cmd->prot_sdb;
+	int count, ivecs;
+
+	if (WARN_ON_ONCE(!prot_sdb)) {
+		/*
+		 * This can happen if someone (e.g. multipath)
+		 * queues a command to a device on an adapter
+		 * that does not support DIX.
+		 */
+		return BLK_STS_IOERR;
+	}
+
+	ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
+
+	if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
+				   prot_sdb->table.sgl,
+				   SCSI_INLINE_PROT_SG_CNT)) {
+		return BLK_STS_RESOURCE;
+	}
+
+	count = blk_rq_map_integrity_sg(rq->q, rq->bio, prot_sdb->table.sgl);
+
+	BUG_ON(count > ivecs);
+	BUG_ON(count > queue_max_integrity_segments(rq->q));
+
+	cmd->prot_sdb = prot_sdb;
+	cmd->prot_sdb->table.nents = count;
+
+	return BLK_STS_OK;
+}
+
 /**
  * scsi_alloc_sgtables - Allocate and initialize data and integrity scatterlists
  * @cmd: SCSI command data structure to initialize.
@@ -1021,7 +1055,7 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 	struct request *rq = scsi_cmd_to_rq(cmd);
 	unsigned short nr_segs = blk_rq_nr_phys_segments(rq);
 	struct scatterlist *last_sg = NULL;
-	blk_status_t ret;
+	blk_status_t ret = BLK_STS_OK;
 	bool need_drain = scsi_cmd_needs_dma_drain(sdev, rq);
 	int count;
 
@@ -1071,40 +1105,11 @@ blk_status_t scsi_alloc_sgtables(struct scsi_cmnd *cmd)
 	cmd->sdb.length = blk_rq_payload_bytes(rq);
 
 	if (blk_integrity_rq(rq)) {
-		struct scsi_data_buffer *prot_sdb = cmd->prot_sdb;
-		int ivecs;
-
-		if (WARN_ON_ONCE(!prot_sdb)) {
-			/*
-			 * This can happen if someone (e.g. multipath)
-			 * queues a command to a device on an adapter
-			 * that does not support DIX.
-			 */
-			ret = BLK_STS_IOERR;
-			goto out_free_sgtables;
-		}
-
-		ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
-
-		if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
-				prot_sdb->table.sgl,
-				SCSI_INLINE_PROT_SG_CNT)) {
-			ret = BLK_STS_RESOURCE;
-			goto out_free_sgtables;
-		}
-
-		count = blk_rq_map_integrity_sg(rq->q, rq->bio,
-						prot_sdb->table.sgl);
-		BUG_ON(count > ivecs);
-		BUG_ON(count > queue_max_integrity_segments(rq->q));
-
-		cmd->prot_sdb = prot_sdb;
-		cmd->prot_sdb->table.nents = count;
+		ret = scsi_alloc_integrity_sgtables(cmd);
+		if (ret != BLK_STS_OK)
+			scsi_free_sgtables(cmd);
 	}
 
-	return BLK_STS_OK;
-out_free_sgtables:
-	scsi_free_sgtables(cmd);
 	return ret;
 }
 EXPORT_SYMBOL(scsi_alloc_sgtables);
-- 
2.34.1
