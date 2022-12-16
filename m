Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2EF64F24A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiLPUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLPURY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:17:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A898172605
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:23 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxCtm024349
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=vVY03djUbGuw9RyCWd6Eexf1lAzlqKJXlcJv1cor+cc=;
 b=EKCA0B+hrgWZGusugiQjREbG/siOJhUpzpm7y5E7Byc0U1PFytmCSSpP+757rRLlob3M
 /DAkqpdjkU+berglGccH1db6L+KkuuhcMEb28WPevJe8nz6PtsfX3n6J6UTZtxBkUd9x
 ohwjRsEQY5ex0hF2rJOrXt+rNPYYzoxLNkG7O4Qsfi0i3vvg294ITcoBm3af2cLcDuc5
 3DUH6NPTjIJTd7qSu9VDmoSKBlPcb9liN8SaXpkox/+3HKnXZmlF4JayolAEbZiFonBN
 IHF3j3reEBigwDGFUZvdiP2zwtjbZzZW8hzOLipYwJbBJEZodYBTbhYztHun1U1wdfnz Og== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgxjy8gcx-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:23 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 12:17:22 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 619E0D042AD5; Fri, 16 Dec 2022 12:17:10 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 09/11] dmapool: simplify freeing
Date:   Fri, 16 Dec 2022 12:16:23 -0800
Message-ID: <20221216201625.2362737-10-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216201625.2362737-1-kbusch@meta.com>
References: <20221216201625.2362737-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: f6v824Ga87VXh6Ka0_PRSnOIlVsNosSW
X-Proofpoint-ORIG-GUID: f6v824Ga87VXh6Ka0_PRSnOIlVsNosSW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
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

