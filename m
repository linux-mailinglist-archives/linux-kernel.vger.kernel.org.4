Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5001F642AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLEPHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiLEPHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:07:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D7C1D32E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:07:21 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Er24L016570
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:07:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=F5ndiXKSIYwdaNgVa7CtE+9m7dnA1GNZSuFoZd2plto=;
 b=mchHDRAi5Y0NSIA/d5ZQByFsbGCqJGxyw/MVRIdaNFXNvPVeaq988bd12h7IoioZs6EI
 SD3zJCyGVReY0pzNdSxOeJf0mpdvBksWs7eulu083Kaw7Nt4wVr0j2r9fPfgxbhGelIq
 TFbLZfXKIiP/0F9VtKtg0fo7M35YRx/T5YOxFFL93ljc4clxOAq4ILIpu71JEHGgKLHO
 u97Z05whH18sMXo18co/ua/e3GQksMUQjhtUyV8cbzMmJj1JJ3Rev4+6w9x9tjl5H/5s
 JahH1T9bKot/R3RA3a2HtRbL19m1hjz87pPdVDQAHQ84L6zHNbRHf+XwlaQzr3VkyNRL Xw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m82ntv08u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:07:21 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:07:19 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 49143C615720; Mon,  5 Dec 2022 07:00:12 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 10/11] dmapool: don't memset on free twice
Date:   Mon, 5 Dec 2022 06:59:36 -0800
Message-ID: <20221205145937.54367-11-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7zteIjRPGoiqQ6V4rJv-8VpjGRg8hYF0
X-Proofpoint-GUID: 7zteIjRPGoiqQ6V4rJv-8VpjGRg8hYF0
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

