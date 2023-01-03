Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36065C758
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjACTTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbjACTSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7614D33
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:12 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 303IGCvd022006
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=iXmWMfcoBGa5vD07ETm52nqXiTTfc73Lql3XbCdcySs=;
 b=EEYsfP2M9WNnURBVz6KsvF1YEhKqi2nGaWj0b5J8VvTo6GjX33vdliT3mPJxKn039G8+
 UmmnRFVxjglD1H10TFoPdELERz+PJ0kusbOUxpntOIHmMsFa40fSt5a+J5esQWG40E+G
 xQfAfak90JuEgR0nKpu5nobQ9VdDAMAL0xM5GZfKktn1pQCWEcU3TdRv3j8tUgH+fU3P
 AMjD7oBi51TVqezogDYGGyWhhDp5Rik2HOeXqLMkaDd0qxBp1YlQ8y9gYaJG2pj+KJ1B
 WUKud3bT75pfGPy7b0bwWtgiQNsId/kjcuL3C+N7T26IQTKfd/dSky+//mIeWOgofCRs 5A== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mthffaew3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:11 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:09 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 2E341E1F5E14; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 06/12] dmapool: move debug code to own functions
Date:   Tue, 3 Jan 2023 11:15:45 -0800
Message-ID: <20230103191551.3254778-7-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N9mIbeEgnTo__7nEabzMr8-QNygWXgqF
X-Proofpoint-ORIG-GUID: N9mIbeEgnTo__7nEabzMr8-QNygWXgqF
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

Clean up the normal path by moving the debug code outside it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 113 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 45 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index eaed3ffb42aa8..7bd8990e1913d 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -294,6 +294,38 @@ void dma_pool_destroy(struct dma_pool *pool)
 }
 EXPORT_SYMBOL(dma_pool_destroy);
=20
+#ifdef	DMAPOOL_DEBUG
+static void pool_check_block(struct dma_pool *pool, void *retval,
+			     unsigned int offset, gfp_t mem_flags)
+{
+	int i;
+	u8 *data =3D retval;
+	/* page->offset is stored in first 4 bytes */
+	for (i =3D sizeof(offset); i < pool->size; i++) {
+		if (data[i] =3D=3D POOL_POISON_FREED)
+			continue;
+		dev_err(pool->dev, "%s %s, %p (corrupted)\n",
+			__func__, pool->name, retval);
+
+		/*
+		 * Dump the first 4 bytes even if they are not
+		 * POOL_POISON_FREED
+		 */
+		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 16, 1,
+				data, pool->size, 1);
+		break;
+	}
+	if (!want_init_on_alloc(mem_flags))
+		memset(retval, POOL_POISON_ALLOCATED, pool->size);
+}
+#else
+static void pool_check_block(struct dma_pool *pool, void *retval,
+			     unsigned int offset, gfp_t mem_flags)
+
+{
+}
+#endif
+
 /**
  * dma_pool_alloc - get a block of consistent memory
  * @pool: dma pool that will produce the block
@@ -336,29 +368,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t me=
m_flags,
 	page->offset =3D *(int *)(page->vaddr + offset);
 	retval =3D offset + page->vaddr;
 	*handle =3D offset + page->dma;
-#ifdef	DMAPOOL_DEBUG
-	{
-		int i;
-		u8 *data =3D retval;
-		/* page->offset is stored in first 4 bytes */
-		for (i =3D sizeof(page->offset); i < pool->size; i++) {
-			if (data[i] =3D=3D POOL_POISON_FREED)
-				continue;
-			dev_err(pool->dev, "%s %s, %p (corrupted)\n",
-				__func__, pool->name, retval);
-
-			/*
-			 * Dump the first 4 bytes even if they are not
-			 * POOL_POISON_FREED
-			 */
-			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_OFFSET, 16, 1,
-					data, pool->size, 1);
-			break;
-		}
-	}
-	if (!want_init_on_alloc(mem_flags))
-		memset(retval, POOL_POISON_ALLOCATED, pool->size);
-#endif
+	pool_check_block(pool, retval, offset, mem_flags);
 	spin_unlock_irqrestore(&pool->lock, flags);
=20
 	if (want_init_on_alloc(mem_flags))
@@ -381,6 +391,39 @@ static struct dma_page *pool_find_page(struct dma_po=
ol *pool, dma_addr_t dma)
 	return NULL;
 }
=20
+#ifdef DMAPOOL_DEBUG
+static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
+			  void *vaddr, dma_addr_t dma)
+{
+	unsigned int offset =3D vaddr - page->vaddr;
+	unsigned int chain =3D page->offset;
+
+	if ((dma - page->dma) !=3D offset) {
+		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
+			__func__, pool->name, vaddr, &dma);
+		return true;
+	}
+
+	while (chain < pool->allocation) {
+		if (chain !=3D offset) {
+			chain =3D *(int *)(page->vaddr + chain);
+			continue;
+		}
+		dev_err(pool->dev, "%s %s, dma %pad already free\n",
+			__func__, pool->name, &dma);
+		return true;
+	}
+	memset(vaddr, POOL_POISON_FREED, pool->size);
+	return false;
+}
+#else
+static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
+			  void *vaddr, dma_addr_t dma)
+{
+	return false;
+}
+#endif
+
 /**
  * dma_pool_free - put block back into dma pool
  * @pool: the dma pool holding the block
@@ -394,7 +437,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr=
, dma_addr_t dma)
 {
 	struct dma_page *page;
 	unsigned long flags;
-	unsigned int offset;
=20
 	spin_lock_irqsave(&pool->lock, flags);
 	page =3D pool_find_page(pool, dma);
@@ -405,35 +447,16 @@ void dma_pool_free(struct dma_pool *pool, void *vad=
dr, dma_addr_t dma)
 		return;
 	}
=20
-	offset =3D vaddr - page->vaddr;
 	if (want_init_on_free())
 		memset(vaddr, 0, pool->size);
-#ifdef	DMAPOOL_DEBUG
-	if ((dma - page->dma) !=3D offset) {
+	if (pool_page_err(pool, page, vaddr, dma)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
-			__func__, pool->name, vaddr, &dma);
 		return;
 	}
-	{
-		unsigned int chain =3D page->offset;
-		while (chain < pool->allocation) {
-			if (chain !=3D offset) {
-				chain =3D *(int *)(page->vaddr + chain);
-				continue;
-			}
-			spin_unlock_irqrestore(&pool->lock, flags);
-			dev_err(pool->dev, "%s %s, dma %pad already free\n",
-				__func__, pool->name, &dma);
-			return;
-		}
-	}
-	memset(vaddr, POOL_POISON_FREED, pool->size);
-#endif
=20
 	page->in_use--;
 	*(int *)vaddr =3D page->offset;
-	page->offset =3D offset;
+	page->offset =3D vaddr - page->vaddr;
 	/*
 	 * Resist a temptation to do
 	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
--=20
2.30.2

