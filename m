Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BF65C75A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbjACTTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjACTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:18:58 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D0C15F3D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:22 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 303IGCpf022019
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=DPYWWx3luRLtta2iFpIUOXNxanpVUtqQPN0BpxuHMCA=;
 b=AnFIxVSaGE6gXgfhDaP7q2SxuMKMtnPKgkOrDyix104aCCkGvyjP6cr3JbDXWZeGn4xI
 PKiAszJF2jsCnTeBITUXMTZ2uhLVvFxe+NQI2JV8hLQ0TtVM8VnbWlDaYKjXjWDIR4mL
 cJrFQNT+qO833UQl7d0zWIwga9jBE1ZXwt0Nd/+C0yoFf0mMWq0gfGavDVCHk1yWpUvZ
 qCf/UuwJbrDxokmYRwphcNIN78pZBwXpwkGYsz8mzXrUWgypV+K6QEM05JvOKaGm+LI6
 iFnjYQ8EN40a0XN1w9oBlq9LZ00REsoI35qU2z2305LcNozNjT5JXOgMay0PfudCcx8B yQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3mthffaex4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:21 -0800
Received: from twshared8047.05.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:20 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 46AAFE1F5E18; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 08/12] dmapool: consolidate page initialization
Date:   Tue, 3 Jan 2023 11:15:47 -0800
Message-ID: <20230103191551.3254778-9-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xq9DEONIIPOhQJUmDDFdM3-Fnwo9O_PF
X-Proofpoint-ORIG-GUID: xq9DEONIIPOhQJUmDDFdM3-Fnwo9O_PF
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

Various fields of the dma pool are set in different places. Move it all
to one function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 0a443c8120f62..6862b4e763891 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -202,6 +202,11 @@ static void pool_initialise_page(struct dma_pool *po=
ol, struct dma_page *page)
 	unsigned int offset =3D 0;
 	unsigned int next_boundary =3D pool->boundary;
=20
+#ifdef	DMAPOOL_DEBUG
+	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
+#endif
+	page->in_use =3D 0;
+	page->offset =3D 0;
 	do {
 		unsigned int next =3D offset + pool->size;
 		if (unlikely((next + pool->size) >=3D next_boundary)) {
@@ -226,12 +231,7 @@ static struct dma_page *pool_alloc_page(struct dma_p=
ool *pool, gfp_t mem_flags)
 		kfree(page);
 		return NULL;
 	}
-#ifdef	DMAPOOL_DEBUG
-	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
 	pool_initialise_page(pool, page);
-	page->in_use =3D 0;
-	page->offset =3D 0;
=20
 	return page;
 }
--=20
2.30.2

