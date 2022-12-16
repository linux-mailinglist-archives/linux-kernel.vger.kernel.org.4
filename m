Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002CA64F24E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiLPUSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiLPURw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:17:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB9472621
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:34 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxW16024664
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=F5ndiXKSIYwdaNgVa7CtE+9m7dnA1GNZSuFoZd2plto=;
 b=Vz3TOfSogj9YKRFU0FPVZV0gvOoQfhhRcsSA2dhXhwwH5EVElRZRqVcp+5Kia1PCjJpH
 PCiVZBhnC2ZHhHKTD99jCGXf65/gI1n25OjFKY2uMuHEkwFZItTEMf2nKCzxlNTr17hJ
 bwYX6YWAYRudAD9vyv02nU9aIyZMn+e75WlL0CgObA04Vh7/SawYqZyWVCcgPO+vJD5G
 VpKN6+BtPKllYrYXIEZ2U4j31ciACWiy8T8fdbD9o2DnxEeTxBHLFjh0qYndfkzxLOD5
 8/XA8/lpO/Zv+0HF2a5k44B9b4kC8/n3JVtDEKzykCSu3oilrAxp0ZQDA5CJcIrqXwXF Cw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hn2egg-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:17:34 -0800
Received: from twshared7043.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 12:17:31 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6DD18D042AD7; Fri, 16 Dec 2022 12:17:10 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 10/11] dmapool: don't memset on free twice
Date:   Fri, 16 Dec 2022 12:16:24 -0800
Message-ID: <20221216201625.2362737-11-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216201625.2362737-1-kbusch@meta.com>
References: <20221216201625.2362737-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7u5zG4jAVa0GYklJhRAMokqPf1kxQiva
X-Proofpoint-ORIG-GUID: 7u5zG4jAVa0GYklJhRAMokqPf1kxQiva
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

If debug is enabled, dmapool will poison the range, so no need to clear
it to 0 immediately before writing over it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 44622f2bf4641..f5b79c3268856 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -372,10 +372,10 @@ static struct dma_page *pool_find_page(struct dma_p=
ool *pool, dma_addr_t dma)
 	return NULL;
 }
=20
+#ifdef DMAPOOL_DEBUG
 static inline bool pool_page_err(struct dma_pool *pool, struct dma_page =
*page,
 				 void *vaddr)
 {
-#ifdef DMAPOOL_DEBUG
 	unsigned int chain =3D page->offset;
=20
 	if ((dma - page->dma) !=3D offset) {
@@ -394,9 +394,17 @@ static inline bool pool_page_err(struct dma_pool *po=
ol, struct dma_page *page,
 		return true;
 	}
 	memset(vaddr, POOL_POISON_FREED, pool->size);
-#endif
 	return false;
 }
+#else
+static inline bool pool_page_err(struct dma_pool *pool, struct dma_page =
*page,
+				 void *vaddr)
+{
+	if (want_init_on_free())
+		memset(vaddr, 0, pool->size);
+	return false;
+}
+#endif
=20
 /**
  * dma_pool_free - put block back into dma pool
@@ -423,8 +431,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr=
, dma_addr_t dma)
 	}
=20
 	offset =3D vaddr - page->vaddr;
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 	if (pool_page_err(pool, page, vaddr)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return;
--=20
2.30.2

