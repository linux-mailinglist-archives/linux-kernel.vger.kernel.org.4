Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30269E52E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjBUQyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbjBUQyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:54:15 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7034B10F6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:54:14 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDjqJD007138
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:54:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=Lv9wtK+Nznn45ETj9R3Fhuj6gPKzD5SadJcUnBYgOLQ=;
 b=P0Ku8hmcIFQ1Qij/mJfUcp0QRf/3OcOzbXplOI8L34/kr6qJP8UQBK42btsF1JeovfM1
 9UmSK1s6/sLzNce0o4/Ue3SDIbwfXh3zVEPPgq+FUzb2xePVm4Ol0NGkkJnO7bP8E81b
 kRlWlTnOcUZ+sARg9Nq2X9kJOSjg9/M0sbwxgMsyICxrhfsyZDp725XPqiuG56iGUA6Q
 3IUBTnK1jrtnkqHr+UaAReODuNPfeXWWcG74ShAkvPnIQE4QkurJU/ae2isakwUeoOiC
 rw1XFmRAlZArLhRzs2mgecTepCIwdg+H3CUysNPwNHVRIIBbtVyFlqhJX5E+pyKywrGG cA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nuf8xwnht-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:54:13 -0800
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Feb 2023 08:54:11 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id D5EF011DFBF75; Tue, 21 Feb 2023 08:54:00 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Keith Busch <kbusch@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH] dmapool: push new blocks in ascending order
Date:   Tue, 21 Feb 2023 08:54:00 -0800
Message-ID: <20230221165400.1595247-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JWZacyIf0A60AyEE_VpTanpdoMR3eHeA
X-Proofpoint-ORIG-GUID: JWZacyIf0A60AyEE_VpTanpdoMR3eHeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_09,2023-02-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Some users of the dmapool need their allocations to happen in ascending
order. The recent optimizations pushed the blocks in reverse order, so
restore the previous behavior by linking the next available block from
low-to-high.

Fixes: ced6d06a81fb69 ("dmapool: link blocks across pages")
Reported-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 1920890ff8d3d..a151a21e571b7 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -300,7 +300,7 @@ EXPORT_SYMBOL(dma_pool_create);
 static void pool_initialise_page(struct dma_pool *pool, struct dma_page =
*page)
 {
 	unsigned int next_boundary =3D pool->boundary, offset =3D 0;
-	struct dma_block *block;
+	struct dma_block *block, *first =3D NULL, *last =3D NULL;
=20
 	pool_init_page(pool, page);
 	while (offset + pool->size <=3D pool->allocation) {
@@ -311,11 +311,22 @@ static void pool_initialise_page(struct dma_pool *p=
ool, struct dma_page *page)
 		}
=20
 		block =3D page->vaddr + offset;
-		pool_block_push(pool, block, page->dma + offset);
+		block->dma =3D page->dma + offset;
+		block->next_block =3D NULL;
+
+		if (last)
+			last->next_block =3D block;
+		else
+			first =3D block;
+		last =3D block;
+
 		offset +=3D pool->size;
 		pool->nr_blocks++;
 	}
=20
+	last->next_block =3D pool->next_block;
+	pool->next_block =3D first;
+
 	list_add(&page->page_list, &pool->page_list);
 	pool->nr_pages++;
 }
--=20
2.30.2

