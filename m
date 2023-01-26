Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160167D7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjAZVym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjAZVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:35 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7030D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:30 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJOTBE021695
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1lwwQceFe1QpSr5S2HcEA6wQaoE2HB/NZ5plRAcwhzo=;
 b=RlM4IqGShMBtciXSfpcTCQ9wuKUE+1aak4ZzvkdSMs+fZyMj39YuDO/SuJFPYEh4Pfeb
 WECHH2miD4rohu7Jj8Kw3+FRbjf9sJZIBxERj7YdWYOvl4BoA2cyKuk6PRtEPPyxb96z
 AAA/2ZD2Bx8uUc5bB6OON3iVCTk2kp+DU6bHmu9tYGs5RXeydSNbNc0qAY4eTXG67Aa4
 vA5ftqD7PDnZRQwx8GDkGBuNSo47jBSC0hPk4v34aRLV9e65nE8As8OWzAqC+k+wmTIt
 UmGDtBm4InLZUN9JT5K9cxmi59GvreNWI6Mkx/BY3dJ27HHp1w9vZioi0bs2ndXRULxC Bw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3narn0xa3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:29 -0800
Received: from twshared5320.05.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:54:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 294DFFE80A9A; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 06/12] dmapool: move debug code to own functions
Date:   Thu, 26 Jan 2023 13:51:19 -0800
Message-ID: <20230126215125.4069751-7-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: M4PB81qbYPmfYLRcB4k0nrlzGWzoHWNP
X-Proofpoint-ORIG-GUID: M4PB81qbYPmfYLRcB4k0nrlzGWzoHWNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_09,2023-01-26_01,2022-06-22_01
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 128 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 51 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index eaed3ffb42aa8..30b069e999968 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -96,6 +96,78 @@ static ssize_t pools_show(struct device *dev, struct d=
evice_attribute *attr, cha
=20
 static DEVICE_ATTR_RO(pools);
=20
+#ifdef DMAPOOL_DEBUG
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
+
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
+
+static void pool_init_page(struct dma_pool *pool, struct dma_page *page)
+{
+	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
+}
+#else
+static void pool_check_block(struct dma_pool *pool, void *retval,
+			     unsigned int offset, gfp_t mem_flags)
+
+{
+}
+
+static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
+			  void *vaddr, dma_addr_t dma)
+{
+	return false;
+}
+
+static void pool_init_page(struct dma_pool *pool, struct dma_page *page)
+{
+}
+#endif
+
 /**
  * dma_pool_create - Creates a pool of consistent memory blocks, for dma=
.
  * @name: name of pool, for diagnostics
@@ -223,9 +295,7 @@ static struct dma_page *pool_alloc_page(struct dma_po=
ol *pool, gfp_t mem_flags)
 	page->vaddr =3D dma_alloc_coherent(pool->dev, pool->allocation,
 					 &page->dma, mem_flags);
 	if (page->vaddr) {
-#ifdef	DMAPOOL_DEBUG
-		memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
+		pool_init_page(pool, page);
 		pool_initialise_page(pool, page);
 		page->in_use =3D 0;
 		page->offset =3D 0;
@@ -245,9 +315,7 @@ static void pool_free_page(struct dma_pool *pool, str=
uct dma_page *page)
 {
 	dma_addr_t dma =3D page->dma;
=20
-#ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
+	pool_init_page(pool, page);
 	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
 	list_del(&page->page_list);
 	kfree(page);
@@ -336,29 +404,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t me=
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
@@ -394,7 +440,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr=
, dma_addr_t dma)
 {
 	struct dma_page *page;
 	unsigned long flags;
-	unsigned int offset;
=20
 	spin_lock_irqsave(&pool->lock, flags);
 	page =3D pool_find_page(pool, dma);
@@ -405,35 +450,16 @@ void dma_pool_free(struct dma_pool *pool, void *vad=
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

