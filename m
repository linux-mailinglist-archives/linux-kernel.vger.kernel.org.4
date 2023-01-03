Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5310065C75B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbjACTTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjACTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:19:00 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435E115FCC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:23 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IGIJn001055
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=QzKwUsIi8fNNyxqU4gSlX689JPGZXFMKHp3FG8bPQk0=;
 b=YM/iCJ3o6HKArA7nL6LTrutZomDvnOw56HpdIUvyLO75ES706rfmrHO5dPYgK/RpfbGy
 IXnxxlaF8vptl6L8lc22Dc3vB1V0sTBxBlSuT4wWW4fyolpy5uKkojKMovhOlNIWhNTv
 hlyGuTioplr/tQW1QCKa4uR7ElS2v/d8bXVq2sOL1qaFXNB+qDLBuw2YcH3FQDeLVAiz
 +l3L2m0K0GOhGz4TeNuAUN1B6mKZHIZqQxxydgCnKzKqT8i09IXqvlutA1BIkAdC8F9l
 T3y3ch390raZME2aKn2oWOz+0fvZlW/koEJkguWmD6kv5LjW5i7sZ2J94daLuJKLpvTT ww== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtkt0sxf9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:22 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:20 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 4EC4BE1F5E1A; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 09/12] dmapool: simplify freeing
Date:   Tue, 3 Jan 2023 11:15:48 -0800
Message-ID: <20230103191551.3254778-10-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6n8oV55mLMnsH-Si-F2SnqpIsQW4iP4j
X-Proofpoint-GUID: 6n8oV55mLMnsH-Si-F2SnqpIsQW4iP4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
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

The actions for busy and not busy are mostly the same, so combine these
and remove the unnecessary function. Also, the pool is about to be freed
so there's no need to poison the page data since we only check for
poison on alloc, which can't be done on a freed pool.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 6862b4e763891..4dab48e7e0d75 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * DMA Pool allocator
+* DMA Pool allocator
  *
  * Copyright 2001 David Brownell
  * Copyright 2007 Intel Corporation
@@ -241,18 +241,6 @@ static inline bool is_page_busy(struct dma_page *pag=
e)
 	return page->in_use !=3D 0;
 }
=20
-static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
-{
-	dma_addr_t dma =3D page->dma;
-
-#ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
-	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
-	list_del(&page->page_list);
-	kfree(page);
-}
-
 /**
  * dma_pool_destroy - destroys a pool of dma memory blocks.
  * @pool: dma pool that will be destroyed
@@ -280,14 +268,14 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_unlock(&pools_reg_lock);
=20
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
-		if (is_page_busy(page)) {
+		if (!is_page_busy(page))
+			dma_free_coherent(pool->dev, pool->allocation,
+					  page->vaddr, page->dma);
+		else
 			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
 				pool->name, page->vaddr);
-			/* leak the still-in-use consistent memory */
-			list_del(&page->page_list);
-			kfree(page);
-		} else
-			pool_free_page(pool, page);
+		list_del(&page->page_list);
+		kfree(page);
 	}
=20
 	kfree(pool);
--=20
2.30.2

