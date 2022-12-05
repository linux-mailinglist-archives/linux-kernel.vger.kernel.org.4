Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB2642B85
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiLEPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLEPTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:19:34 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE71A3AD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:19:31 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4LV1RP002801
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:19:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=vVY03djUbGuw9RyCWd6Eexf1lAzlqKJXlcJv1cor+cc=;
 b=QLN4GBhnbA83aq6qOliJgBUpxscTILYzIYn4FBmCQUXsY0guqxzDTGzMbv1wiLpjeJd1
 1kXhbx5PtNDp8z7ZTQ8fX09HUzubN2G3RIFZwNrb6q6/an9SdF20Ts13Qs2pjagC42Sm
 Juvu/nK1ng81PI8ZbYGbcNHF5ep+mp6hU1cA4DUFQyi3EOL0TJamGK9WLtGOlf098kqF
 YxeRX/gIKjuwc6oYotHgsf9+jhI3xzlBhUTYWLp0F5JSGlJkNiaalY/WlhzJwKKyrFy3
 06/uLfeJU75Ff9urSFA88fxTXl+9jGCXavrFP6auX4NXkV9+GpQKEcIw8u7pTAeM7mef cQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m8561avw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:19:31 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:19:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id BDE46C615708; Mon,  5 Dec 2022 07:00:12 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 09/11] dmapool: simplify freeing
Date:   Mon, 5 Dec 2022 06:59:35 -0800
Message-ID: <20221205145937.54367-10-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: PymH5d3YwBk1q4cny15SOprF69vKwoqV
X-Proofpoint-ORIG-GUID: PymH5d3YwBk1q4cny15SOprF69vKwoqV
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

The actions for busy and not busy are mostly the same, so combine these
and remove the unnecessary function. Also, the pool is about to be freed
so there's no need to poison the page data since we only check for
poison on alloc, which can't be done on a freed pool.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 33d20ceff18c5..44622f2bf4641 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
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
@@ -445,11 +433,6 @@ void dma_pool_free(struct dma_pool *pool, void *vadd=
r, dma_addr_t dma)
 	page->in_use--;
 	*(int *)vaddr =3D page->offset;
 	page->offset =3D offset;
-	/*
-	 * Resist a temptation to do
-	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
-	 * Better have a few empty pages hang around.
-	 */
 	spin_unlock_irqrestore(&pool->lock, flags);
 }
 EXPORT_SYMBOL(dma_pool_free);
--=20
2.30.2

