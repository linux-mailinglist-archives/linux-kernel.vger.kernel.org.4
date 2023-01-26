Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B02267D7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjAZVy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjAZVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16EF30D1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:23 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30QLpQYG012189
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=GssxkqRHzywk5Sc3h7qaypNsDK+tSAkz3BBhF75F+wE=;
 b=EW66EzzZTYxhxkLjG2nAjPndtIL8LgcOKBBHD/sSSDMd31TgPu0CZWKSeSNRB/D6mSNa
 dt8c+/70JMd1fhW8sMd/GQB2mQ6ijYChIbRbJkEnPu5A3lVTMiT+K5SXTBS7IBZooSgl
 /6Q5fi9ryDlra82ARf9bFswTsfAilHAwZv6cK5HYODvGn0/iGaYxhPGYWjwGEJhMzPyg
 o3eCENiy864rN1NDEddVjj2fQ++ENMLr7FwVH5byL0Zl58Piuhf0mCxzaKG1ldF3hIsz
 cLuGoG7fMBu8A1TwmCZ4NWzF1qpnle/lWci29BDJ4Mts+COFT4eBwAaLIvgHiZQWRQAz pQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nbw49tujt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:22 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:54:21 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 3DA2DFE80A9C; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 07/12] dmapool: rearrange page alloc failure handling
Date:   Thu, 26 Jan 2023 13:51:20 -0800
Message-ID: <20230126215125.4069751-8-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nVICH2WN4RRxlrWXGNPzgcFglWzOIOop
X-Proofpoint-GUID: nVICH2WN4RRxlrWXGNPzgcFglWzOIOop
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

Handle the error in a condition so the good path can be in the normal
flow.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 30b069e999968..900f2afa363a9 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -292,17 +292,19 @@ static struct dma_page *pool_alloc_page(struct dma_=
pool *pool, gfp_t mem_flags)
 	page =3D kmalloc(sizeof(*page), mem_flags);
 	if (!page)
 		return NULL;
+
 	page->vaddr =3D dma_alloc_coherent(pool->dev, pool->allocation,
 					 &page->dma, mem_flags);
-	if (page->vaddr) {
-		pool_init_page(pool, page);
-		pool_initialise_page(pool, page);
-		page->in_use =3D 0;
-		page->offset =3D 0;
-	} else {
+	if (!page->vaddr) {
 		kfree(page);
-		page =3D NULL;
+		return NULL;
 	}
+
+	pool_init_page(pool, page);
+	pool_initialise_page(pool, page);
+	page->in_use =3D 0;
+	page->offset =3D 0;
+
 	return page;
 }
=20
--=20
2.30.2

