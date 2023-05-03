Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906726F55EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjECKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjECKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:20:40 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BFC3C01
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:20:36 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230503102034epoutp038516e84dadbf9a7f8e767c6ff62cb6da~bmu6DyAvz2814228142epoutp03S
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:20:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230503102034epoutp038516e84dadbf9a7f8e767c6ff62cb6da~bmu6DyAvz2814228142epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683109234;
        bh=J1DOTjK8gn87giwmABoGcvRXxfDSssG6aRXYYY56duk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=SYz7FF1KL6BdMYc160Ff2BtS1fSYTB0TvuSmDXSZ9jhcWA7zFLJ05/XoqOSxwq0dz
         ZHQkL4ufCrdiyjcenkYJU2TvFn4iXmiHOQoNudDXQpZqSVDuRbn8kkHK1kFFxBd6Vc
         FA/Jz595IT+vNeueLQc4D4PHN798KQ09dAmtfTfU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230503102034epcas2p34b8034eb2deb907bbf5df2d4aa118ce5~bmu5juCS13143031430epcas2p3V;
        Wed,  3 May 2023 10:20:34 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QBCdF6VV4z4x9Q5; Wed,  3 May
        2023 10:20:33 +0000 (GMT)
X-AuditID: b6c32a47-c29ff70000002007-03-6452357195ef
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.61.08199.17532546; Wed,  3 May 2023 19:20:33 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 10/15] scsi: change to use blk_rq_nr_integrity_segments()
 instead of blk_rq_count_integrity_sg()
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
Message-ID: <20230503102033epcms2p5791708735197d3aac4fe546bcd7ac387@epcms2p5>
Date:   Wed, 03 May 2023 19:20:33 +0900
X-CMS-MailID: 20230503102033epcms2p5791708735197d3aac4fe546bcd7ac387
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTXLfQNCjF4PItY4vVd/vZLF4e0rRY
        ufook0Vv/1Y2i0U3tjFZ7L2lbXF51xw2i+XH/zE5cHhcPlvqMWHRAUaP3Tcb2Dw+Pr3F4tG3
        ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4B
        um6ZOUDXKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkus
        DA0MjEyBChOyM/Zums9UsImvYuKqbewNjBN5uhg5OSQETCTOnl7D0sXIxSEksINRYu2L/6xd
        jBwcvAKCEn93CIOYwgJFEpPXR4OUCwkoSZxbM4sRImwgcavXHCTMJqAn8XPJDDaQKSICN5gk
        9nx+zQwxnldiRvtTFghbWmL78q2MIDangJ/E4w23GCHiGhI/lvVC1YtK3Fz9lh3Gfn9sPlSN
        iETrvbNQNYISD37uhopLShw69JUN5B4JgXyJDQcCIcI1Em+XH4Aq0Ze41rER7AReAV+Jhvsb
        wGwWAVWJb1f+MUHUuEj0/l8PNp5ZQF5i+9s5zCAjmQU0Jdbv0oeYrixx5BYLRAWfRMfhv+ww
        DzZs/I2VvWPeEyaIVjWJRU1GEGEZia+H57NPYFSahQjkWUjWzkJYu4CReRWjWGpBcW56arFR
        gTE8XpPzczcxgtOklvsOxhlvP+gdYmTiYDzEKMHBrCTC+6HQL0WINyWxsiq1KD++qDQntfgQ
        oynQwxOZpUST84GJOq8k3tDE0sDEzMzQ3MjUwFxJnFfa9mSykEB6YklqdmpqQWoRTB8TB6dU
        A1PA0xgh9puejDxS6XIqbl23ryutmTVBx/VG+WlNlRlMWom3592p8hbTv7iv9dPUhazpP5sl
        vnQkbeFNm99j1F8XJv1/YVmx4PsPPBprF4hf9M8OOX21bv2JipKt0iqNZ1imSK11as5Z8O+D
        xT+nPfG1Xw9F6VuVeCgsdni+qnPbPAeWSa4GYhpbmS9ablltxMSpdeXP24QIY93+V0fP8r5Y
        zvWNXaFc+bTF9SWGPtMT3ld86o0t42NYnmPCOpXXfgGvyleGBbMsH1nnWMrxSPx0+Jq/Vm/K
        pSw2zb7pBYFuVbNfa3s6Ob7nNbbP8NeI+ZqnlB8T39a6Y15Mzs6jXX8Ny1gXrBH1193ikPVc
        iaU4I9FQi7moOBEAdX0yCBwEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323
References: <20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p4>
        <CGME20230503094912epcms2p4bef206eab1c41a92eba2583a69c74323@epcms2p5>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
