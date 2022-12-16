Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9928D64F24C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiLPUSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiLPURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:17:48 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B9E7262D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:33 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxW12024664
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=5sHDLhRqo9/RufklnGKFVoQ7JnNipMp+QhHHPmz6D+s=;
 b=B3+PZwrAtaqliipErF2lfKdvLX5EMW9rOh5+K5jLhFVOZTR6d84n31oJMOU7BQP/Jy7d
 D8kKSAzX4C+1S5wPBIyz0XG//m6IRbrBuVAH3NI3MrEBBRvOz3mNAk+YmZcR+ZAWWwFZ
 bhKgP5sfoRhbcJvhAx6SCWUm2KK+XBD6ktgWXKG2U3XXJLKkfcYUP9eJBEgC2lSKnM/I
 jR0zY/1WX2HYcwlCkv4At2tSXEmljOaozDVn9+FU7YNHCMW/NbzkkJECwOl0vVG2tw4Z
 ua5e9XR/e3zItHGcTMZEPYxkFX4QHySE465IScJgjoqOOWppX3osl/JdnwdWxLNcB07K 4A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hn2egg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:32 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 12:17:31 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 4F484D042ACE; Fri, 16 Dec 2022 12:17:10 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 08/11] dmapool: consolidate page initialization
Date:   Fri, 16 Dec 2022 12:16:22 -0800
Message-ID: <20221216201625.2362737-9-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216201625.2362737-1-kbusch@meta.com>
References: <20221216201625.2362737-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -0JmSdXK1FHllZ1u-Rup9TA3m6XpVZrI
X-Proofpoint-ORIG-GUID: -0JmSdXK1FHllZ1u-Rup9TA3m6XpVZrI
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

