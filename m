Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4716F55D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjECKS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjECKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:18:26 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433410F3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:18:25 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230503101823epoutp04815e1c14af75c719f65d18de3dfea4e1~bms-oWC1h2446024460epoutp04b
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:18:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230503101823epoutp04815e1c14af75c719f65d18de3dfea4e1~bms-oWC1h2446024460epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109103;
        bh=v5aifcuvT4v06m1yAYerf8h0h01yE8oqVL3cCIFGtC8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=myswX6UxBKURqrjDtEP0GJhJBNd0eaji8TVOc/qyvb+cpSkZ0z6IIBzA55CTGpsmJ
         WoNZ/f4vUAIC/fLMsesY4yH3pDbthdqmOX+7shEHsY8u1Cfxqn1aTSAOb2Calo+noD
         kMX9bsxXDjPvnh1JiYMqnWOba95gTDxG8a1B1VKM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20230503101822epcas2p41907fc7be801aa47a35830041603d10e~bms-EZHM-1649716497epcas2p4q;
        Wed,  3 May 2023 10:18:22 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCZk2lGCz4x9Q5; Wed,  3 May
        2023 10:18:22 +0000 (GMT)
X-AuditID: b6c32a46-b23fd7000001438d-ff-645234ee3fd6
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.C6.17293.EE432546; Wed,  3 May 2023 19:18:22 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 09/15] scsi: add scsi_alloc_integrity_sgtables() for
 integrity process
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230503101822epcms2p3ce469757778cee255368e213755d58d6@epcms2p3>
Date:   Wed, 03 May 2023 19:18:22 +0900
X-CMS-MailID: 20230503101822epcms2p3ce469757778cee255368e213755d58d6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdljTXPedSVCKwcEdghar7/azWbw8pGmx
        cvVRJove/q1sFotubGOy2HtL2+LyrjlsFsuP/2Ny4PC4fLbUY8KiA4weu282sHl8fHqLxaNv
        yypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
        dN0yc4CuUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBfoFSfmFpfmpevlpZZY
        GRoYGJkCFSZkZ/zsfcVW8FGyYtPJY4wNjJNEuxg5OSQETCRaF0xi72Lk4hAS2MEo0fhnN3MX
        IwcHr4CgxN8dwiA1wgIREr07VzCD2EICShLn1sxiBCkRFjCQuNVrDhJmE9CT+LlkBhvIGBGB
        G0wSez6/ZoaYzysxo/0pC4QtLbF9+VZGEJtTwE/i8YZbjBBxDYkfy3qh6kUlbq5+yw5jvz82
        H6pGRKL13lmoGkGJBz93Q8UlJQ4d+soGco+EQL7EhgOBEOEaibfLD0CV6Etc69gIdgKvgK/E
        gf7nYDaLgKrEy4sgrSA1LhJ9z9ezgtjMAvIS29/OAYcCs4CmxPpd+hDTlSWO3GKBqOCT6Dj8
        lx3mwYaNv7Gyd8x7wgTRqiaxqMkIIiwj8fXwfPYJjEqzEKE8C8naWQhrFzAyr2IUSy0ozk1P
        LTYqMIJHbHJ+7iZGcKLUctvBOOXtB71DjEwcjIcYJTiYlUR4PxT6pQjxpiRWVqUW5ccXleak
        Fh9iNAV6eCKzlGhyPjBV55XEG5pYGpiYmRmaG5kamCuJ80rbnkwWEkhPLEnNTk0tSC2C6WPi
        4JRqYNpyr65/rgm7k9xiHl6XPzbfBfv2xVw+GlG5aOMzp+JP+5Q392/YVz7pUH9p8N3HnVu1
        F2Zor7gZlvK66MfLK1dnz/XZvKJkzq+MjVHrfI+oMv0uE3h33+bg6/s7eG6yGnMJujzJK09r
        yPtR7KE9eaVhs/dv6+hHtUpyx+ebHHXa+UTPcn/wEYee1MCfsbzJJa2bTyevS9+0ZlI1x7cm
        /49+hcsi/623nz/t70GdriqxiSyXJmczse2q4e5inmERXiCpOsX526Qlk0SYTXLUgrbJnuqb
        0FUlZCacomhx9xBT0xLXWh7mjrqdS+6fDFYpNBJdeoCr133r7hMT7H5NXfbCRKP3tFnAP/tp
        Evzi0kosxRmJhlrMRcWJAHg749UdBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p3>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
