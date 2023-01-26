Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19C167D7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjAZVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjAZVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:36 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4C3CE2E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:34 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJ4q3I024956
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=TUPS34rQ0CeKMzaTGv3b3tvstwJOY1BaeTHmyPVxUHY=;
 b=DLPow7rFpO3/AwGHtO7lXvlG7VUjLgPQEBGpGszyW4ismx8epXy91eGg9nefHbBeSA6v
 YD3sejAge4Wqo3/2dbwF/3X0PDGGK3jZZ07Zn39oZ7R6OtImBVJsIvuuqPUUsu2A15Te
 l2Y8/M4A9R8K6HKl8/DBrWPexLW1F6GuhPjxlaSxHhZ5SUVNUXTMVOXZOPKrf6QpXyfV
 idITyjBi4jeCNTcD7vlZjTEvCffvefclPZQ+lpcDQh+O8yyIcZDUwnmqRPW9jwvmw9us
 iaNWnLnP/d7gVlTVwa8YVS2D+d2sDbR6NkCT0jPsygucEH/wdytqsfB8EJ/WRlXIKSMV qQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nbb800nhb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:33 -0800
Received: from twshared9608.03.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:54:32 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 41B56FE80A9E; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 08/12] dmapool: consolidate page initialization
Date:   Thu, 26 Jan 2023 13:51:21 -0800
Message-ID: <20230126215125.4069751-9-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: p9dx0QvDohvyje8ooDui9-bvFwcpNuTv
X-Proofpoint-GUID: p9dx0QvDohvyje8ooDui9-bvFwcpNuTv
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

Various fields of the dma pool are set in different places. Move it all
to one function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 900f2afa363a9..9e98065a68b1f 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -274,6 +274,9 @@ static void pool_initialise_page(struct dma_pool *poo=
l, struct dma_page *page)
 	unsigned int offset =3D 0;
 	unsigned int next_boundary =3D pool->boundary;
=20
+	pool_init_page(pool, page);
+	page->in_use =3D 0;
+	page->offset =3D 0;
 	do {
 		unsigned int next =3D offset + pool->size;
 		if (unlikely((next + pool->size) >=3D next_boundary)) {
@@ -300,11 +303,7 @@ static struct dma_page *pool_alloc_page(struct dma_p=
ool *pool, gfp_t mem_flags)
 		return NULL;
 	}
=20
-	pool_init_page(pool, page);
 	pool_initialise_page(pool, page);
-	page->in_use =3D 0;
-	page->offset =3D 0;
-
 	return page;
 }
=20
--=20
2.30.2

