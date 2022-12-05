Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE179642B88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiLEPVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiLEPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:19:53 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0691DF2B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:19:34 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5CVba5012959
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:19:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=ADvvFQUdwkTabb+mgOJxdznef25hLYACuBWcCNuRK/M=;
 b=ELaivGWdKmR+7P/NGl0TQf7pvFbhWJmnbb62RC3z369pUeY6UlSZuwWKDKnOMSokdVJs
 Arw3dzuIgZEFFiZKh7MI7upKp3GquRl9YtAp/b9OeNH9VpE3fc6BuIEppTY6lc31y+FK
 LaHIinB+i7JmHxo6VpvquK9mcBDYlPHu/VKMFVu0hGibcaFJHo9ZodKMSPrw5DipBopS
 uGmULh1f9rX4DcZCFpIYeeDEGjI873/8R0AuQD5HMA8ykYMx3wM2CDemmSaePK0SWjpn
 j4fDvG28OUbNt9QR1pEaZAc+xeP4vszHywKECkkB0CfBOhvspsI4pCJ29Qp/DKwpnGas FA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m9gqj9gct-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:19:33 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub103.TheFacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:19:30 -0800
Received: from twshared16963.27.frc3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:19:29 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6E86FC615703; Mon,  5 Dec 2022 07:00:11 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/11] dmapool: rearrange page alloc failure handling
Date:   Mon, 5 Dec 2022 06:59:33 -0800
Message-ID: <20221205145937.54367-8-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: M-RugQYgPLFsi3Q5ETmSydZwIfhtxjAM
X-Proofpoint-ORIG-GUID: M-RugQYgPLFsi3Q5ETmSydZwIfhtxjAM
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

Handle the error in a condition so the good path can be in the normal
flow.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 8a7aa19e650a1..f77e2af4941de 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -222,17 +222,17 @@ static struct dma_page *pool_alloc_page(struct dma_=
pool *pool, gfp_t mem_flags)
 		return NULL;
 	page->vaddr =3D dma_alloc_coherent(pool->dev, pool->allocation,
 					 &page->dma, mem_flags);
-	if (page->vaddr) {
-#ifdef	DMAPOOL_DEBUG
-		memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
-#endif
-		pool_initialise_page(pool, page);
-		page->in_use =3D 0;
-		page->offset =3D 0;
-	} else {
+	if (!page->vaddr) {
 		kfree(page);
-		page =3D NULL;
+		return NULL;
 	}
+#ifdef	DMAPOOL_DEBUG
+	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
+#endif
+	pool_initialise_page(pool, page);
+	page->in_use =3D 0;
+	page->offset =3D 0;
+
 	return page;
 }
=20
--=20
2.30.2

