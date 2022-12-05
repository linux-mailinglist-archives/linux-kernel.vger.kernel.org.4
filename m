Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1322642B25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiLEPON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLEPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:13:23 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC55637F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:13:20 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4Nenk5021995
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:13:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=YU1RvihRnvDJ0EI7aPZRW/ndJTmtKABPXXQKd2XE/QM=;
 b=h72aB84uF535vhqcSF/upzVkRKlcy1O4YHQ33llTxkXXqGNEv07PJm/9UT0GamvqFm69
 letw054sf96K2yDECmaBk5enLnO0+h+gBqXZpn3F9n3gVsFu4VqjzsvjyQUHNSWvgrsH
 ZYetGQPpLXxAeBwNCLvHfg+F6A153f/jl5EwJ17EI7tbQ5br8Zz0ZbAHA16VCXqzRSKp
 yMbMqL1mylZiV7qWL1Zmk1MRN/59JJuWSaNU8zWZiPNEAKZ11tvspWwFc9X4MX/uo989
 +XykDO8PcS9Hz6d+i8hEd+kGzILJyBRYQoaU9DJOf749WEbwODmDaNso2QkV4OFWjpcB vA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m851tk7w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:13:20 -0800
Received: from twshared2003.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:13:19 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C5CE2C6156E0; Mon,  5 Dec 2022 07:00:09 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 02/11] dmapool: remove checks for dev == NULL
Date:   Mon, 5 Dec 2022 06:59:28 -0800
Message-ID: <20221205145937.54367-3-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rONogpZ9_xQB1Zx-cRrVm6fV4xv7R1d1
X-Proofpoint-ORIG-GUID: rONogpZ9_xQB1Zx-cRrVm6fV4xv7R1d1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Battersby <tonyb@cybernetics.com>

dmapool originally tried to support pools without a device because
dma_alloc_coherent() supports allocations without a device.  But nobody
ended up using dma pools without a device, and trying to do so will
result in an oops.  So remove the checks for pool->dev =3D=3D NULL since =
they
are unneeded bloat.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
[added check for null dev on create]
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index a7eb5d0eb2da7..559207e1c3339 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -134,6 +134,9 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 	size_t allocation;
 	bool empty =3D false;
=20
+	if (!dev)
+		return NULL;
+
 	if (align =3D=3D 0)
 		align =3D 1;
 	else if (align & (align - 1))
@@ -275,7 +278,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
 	list_del(&pool->pools);
-	if (pool->dev && list_empty(&pool->dev->dma_pools))
+	if (list_empty(&pool->dev->dma_pools))
 		empty =3D true;
 	mutex_unlock(&pools_lock);
 	if (empty)
@@ -284,12 +287,8 @@ void dma_pool_destroy(struct dma_pool *pool)
=20
 	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
 		if (is_page_busy(page)) {
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
-					pool->name, page->vaddr);
-			else
-				pr_err("%s %s, %p busy\n", __func__,
-				       pool->name, page->vaddr);
+			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
+				pool->name, page->vaddr);
 			/* leak the still-in-use consistent memory */
 			list_del(&page->page_list);
 			kfree(page);
@@ -351,12 +350,8 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t me=
m_flags,
 		for (i =3D sizeof(page->offset); i < pool->size; i++) {
 			if (data[i] =3D=3D POOL_POISON_FREED)
 				continue;
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, %p (corrupted)\n",
-					__func__, pool->name, retval);
-			else
-				pr_err("%s %s, %p (corrupted)\n",
-					__func__, pool->name, retval);
+			dev_err(pool->dev, "%s %s, %p (corrupted)\n",
+				__func__, pool->name, retval);
=20
 			/*
 			 * Dump the first 4 bytes even if they are not
@@ -411,12 +406,8 @@ void dma_pool_free(struct dma_pool *pool, void *vadd=
r, dma_addr_t dma)
 	page =3D pool_find_page(pool, dma);
 	if (!page) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		if (pool->dev)
-			dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
-				__func__, pool->name, vaddr, &dma);
-		else
-			pr_err("%s %s, %p/%pad (bad dma)\n",
-			       __func__, pool->name, vaddr, &dma);
+		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
+			__func__, pool->name, vaddr, &dma);
 		return;
 	}
=20
@@ -426,12 +417,8 @@ void dma_pool_free(struct dma_pool *pool, void *vadd=
r, dma_addr_t dma)
 #ifdef	DMAPOOL_DEBUG
 	if ((dma - page->dma) !=3D offset) {
 		spin_unlock_irqrestore(&pool->lock, flags);
-		if (pool->dev)
-			dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
-				__func__, pool->name, vaddr, &dma);
-		else
-			pr_err("%s %s, %p (bad vaddr)/%pad\n",
-			       __func__, pool->name, vaddr, &dma);
+		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
+			__func__, pool->name, vaddr, &dma);
 		return;
 	}
 	{
@@ -442,12 +429,8 @@ void dma_pool_free(struct dma_pool *pool, void *vadd=
r, dma_addr_t dma)
 				continue;
 			}
 			spin_unlock_irqrestore(&pool->lock, flags);
-			if (pool->dev)
-				dev_err(pool->dev, "%s %s, dma %pad already free\n",
-					__func__, pool->name, &dma);
-			else
-				pr_err("%s %s, dma %pad already free\n",
-				       __func__, pool->name, &dma);
+			dev_err(pool->dev, "%s %s, dma %pad already free\n",
+				__func__, pool->name, &dma);
 			return;
 		}
 	}
--=20
2.30.2

