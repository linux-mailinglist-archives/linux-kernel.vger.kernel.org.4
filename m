Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAF642AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiLEPH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiLEPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:07:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A41D333
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:07:22 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Er24M016570
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:07:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=5sHDLhRqo9/RufklnGKFVoQ7JnNipMp+QhHHPmz6D+s=;
 b=ZZKdYNlsm54rW2y2lXptkIcf6E1liXqw1DNspW49oxKbTmP2vwjiCs4DRRXeems2hYR3
 6qapFMudkYne5j5GHbcpsX1UVn2043+GI8tuykSaN824e9yky3kjr5XSyQhbXBShv3uo
 NQHPOFuGNTr8Ol3n3UahOu1iLedUpdBbIHN0UnVBPhBsHj2PfSxdwWA5qdtDph2S3d3f
 3QKeKpPxulwP8jxrB5HSC1fW1vli3JuotxSJ5ZVo+77ZD0hoHMG8DSKDdlSIhOFB1cfS
 GB6t71Ixo6lHkqw4IkY1RGIVUR9WNGVVcuaR5fcvMul8+T9d7d5pgnQfyKg+Nz+8PnBN /g== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m82ntv08u-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:07:21 -0800
Received: from twshared13940.35.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:07:20 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 8B08CC615706; Mon,  5 Dec 2022 07:00:12 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 08/11] dmapool: consolidate page initialization
Date:   Mon, 5 Dec 2022 06:59:34 -0800
Message-ID: <20221205145937.54367-9-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7YLAVJ-68DODBvOn3Nk_Ms-XVOl_65d_
X-Proofpoint-GUID: 7YLAVJ-68DODBvOn3Nk_Ms-XVOl_65d_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Various fields of the dma pool are set in different places. Move it all
to one function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index f77e2af4941de..33d20ceff18c5 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -202,6 +202,8 @@ static void pool_initialise_page(struct dma_pool *poo=
l, struct dma_page *page)
 	unsigned int offset =3D 0;
 	unsigned int next_boundary =3D pool->boundary;
=20
+	page->in_use =3D 0;
+	page->offset =3D 0;
 	do {
 		unsigned int next =3D offset + pool->size;
 		if (unlikely((next + pool->size) >=3D next_boundary)) {
@@ -211,6 +213,8 @@ static void pool_initialise_page(struct dma_pool *poo=
l, struct dma_page *page)
 		*(int *)(page->vaddr + offset) =3D next;
 		offset =3D next;
 	} while (offset < pool->allocation);
+
+	list_add(&page->page_list, &pool->page_list);
 }
=20
 static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem=
_flags)
@@ -229,10 +233,6 @@ static struct dma_page *pool_alloc_page(struct dma_p=
ool *pool, gfp_t mem_flags)
 #ifdef	DMAPOOL_DEBUG
 	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
 #endif
-	pool_initialise_page(pool, page);
-	page->in_use =3D 0;
-	page->offset =3D 0;
-
 	return page;
 }
=20
@@ -354,8 +354,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem=
_flags,
 		return NULL;
=20
 	spin_lock_irqsave(&pool->lock, flags);
-
-	list_add(&page->page_list, &pool->page_list);
+	pool_initialise_page(pool, page);
  ready:
 	page->in_use++;
 	offset =3D page->offset;
--=20
2.30.2

