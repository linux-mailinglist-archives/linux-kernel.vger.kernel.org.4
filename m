Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1251D65C755
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjACTTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjACTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886C914017
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:08 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 303IGBju008819
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Dd8QlDeIX9+IRxSeA5RcOHNXrB5QMHTJYiPzhiQ/gts=;
 b=REx2QlwLStkkzZEQQv4dQqGl0qTGywKsJiNiq7pgoBnDBs1VKjku1AnLpL9dUTlYmiAd
 jIb/F13PMMSwKsNCwS/LMgf0LFDMJw3IH/YPWrcC5HtrdUMppHjIMOoDEJQXBXqF/9Ha
 HBP2zCcd2WJd8VL4xoYXahzK8hmWkhSHuWhFiUpZnjZvhkPIl12EV9nbUEsyXGcJ/0+w
 8qxAYVV/ZeIdLwSomsOr0IqAS85hodVZrgzfm3EyKomCeOhC2ZYBi/PAW0dgZrrICe4k
 hoS9CM2TgO3ThWP1/v+ZoZdNFiSRse261vnESPHP97/zOudGoslWiB2qKJH24/Y7qFBh mQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mthn4aee4-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:07 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:06 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1BF14E1F5E10; Tue,  3 Jan 2023 11:15:54 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 04/12] dmapool: cleanup integer types
Date:   Tue, 3 Jan 2023 11:15:43 -0800
Message-ID: <20230103191551.3254778-5-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1I_5q6lYE25qjYcNf7mycD3GtNcVbikS
X-Proofpoint-GUID: 1I_5q6lYE25qjYcNf7mycD3GtNcVbikS
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

From: Tony Battersby <tonyb@cybernetics.com>

To represent the size of a single allocation, dmapool currently uses
'unsigned int' in some places and 'size_t' in other places.  Standardize
on 'unsigned int' to reduce overhead, but use 'size_t' when counting all
the blocks in the entire pool.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 20616b760bb9c..ee993bb59fc27 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -43,10 +43,10 @@
 struct dma_pool {		/* the pool */
 	struct list_head page_list;
 	spinlock_t lock;
-	size_t size;
 	struct device *dev;
-	size_t allocation;
-	size_t boundary;
+	unsigned int size;
+	unsigned int allocation;
+	unsigned int boundary;
 	char name[32];
 	struct list_head pools;
 };
@@ -73,7 +73,7 @@ static ssize_t pools_show(struct device *dev, struct de=
vice_attribute *attr, cha
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
 		unsigned pages =3D 0;
-		unsigned blocks =3D 0;
+		size_t blocks =3D 0;
=20
 		spin_lock_irq(&pool->lock);
 		list_for_each_entry(page, &pool->page_list, page_list) {
@@ -83,9 +83,10 @@ static ssize_t pools_show(struct device *dev, struct d=
evice_attribute *attr, cha
 		spin_unlock_irq(&pool->lock);
=20
 		/* per-pool info, no real statistics yet */
-		size +=3D sysfs_emit_at(buf, size, "%-16s %4u %4zu %4zu %2u\n",
+		size +=3D sysfs_emit_at(buf, size, "%-16s %4zu %4zu %4u %2u\n",
 				      pool->name, blocks,
-				      pages * (pool->allocation / pool->size),
+				      (size_t) pages *
+				      (pool->allocation / pool->size),
 				      pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
@@ -133,7 +134,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 	else if (align & (align - 1))
 		return NULL;
=20
-	if (size =3D=3D 0)
+	if (size =3D=3D 0 || size > INT_MAX)
 		return NULL;
 	else if (size < 4)
 		size =3D 4;
@@ -146,6 +147,8 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 	else if ((boundary < size) || (boundary & (boundary - 1)))
 		return NULL;
=20
+	boundary =3D min(boundary, allocation);
+
 	retval =3D kmalloc(sizeof(*retval), GFP_KERNEL);
 	if (!retval)
 		return retval;
@@ -306,7 +309,7 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem=
_flags,
 {
 	unsigned long flags;
 	struct dma_page *page;
-	size_t offset;
+	unsigned int offset;
 	void *retval;
=20
 	might_alloc(mem_flags);
--=20
2.30.2

