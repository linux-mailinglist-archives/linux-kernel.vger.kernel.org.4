Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EEF65C75E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238914AbjACTUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbjACTTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:19:02 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8907B15FD6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:25 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IGJr4029037
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=EOLA9aVIScshxrJuNiGV2+LmB+VUm+EtdNOtAx7GzaQ=;
 b=bQWuyv+REu/rWxKIIt5pFQHfv6VkUQnqqsU4nMgd7grrG8l1JYZ/mielJCyZU59Tl9cZ
 pY0R1Duk/8humoda1L9r263oMQV8u879tTR7ptrT+mddnnZAi5OMITLh+QeJWPbUWVZf
 2GfF6Mx14MV+UC/IM9Tr8V+aQA1I4ofcUzgV4KAj8u7Wv/8qup89qXTMsGKqOgll8X2P
 HSFlJ/J8x/lkIBj/EgFKA1GH6d416ZiDx4PI/QuIno6ni/h1ind8bQBCqMJ9ymO2BYHR
 eGBB8zjMnVuiG1wA/7eQXGdH3alHYRVOWZuR834veJNx9fRT29jp3xkrCMSfZOO6YdkG TA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mtknw6qb0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:25 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:23 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 56F0CE1F5E1C; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 10/12] dmapool: don't memset on free twice
Date:   Tue, 3 Jan 2023 11:15:49 -0800
Message-ID: <20230103191551.3254778-11-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eNpu0xlI4tvvmiLIcvbRqv1-aD1c3_DI
X-Proofpoint-ORIG-GUID: eNpu0xlI4tvvmiLIcvbRqv1-aD1c3_DI
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

If debug is enabled, dmapool will poison the range, so no need to clear
it to 0 immediately before writing over it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 4dab48e7e0d75..d886b46c4b289 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -408,6 +408,8 @@ static bool pool_page_err(struct dma_pool *pool, stru=
ct dma_page *page,
 static bool pool_page_err(struct dma_pool *pool, struct dma_page *page,
 			  void *vaddr, dma_addr_t dma)
 {
+	if (want_init_on_free())
+		memset(vaddr, 0, pool->size);
 	return false;
 }
 #endif
@@ -435,8 +437,6 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr=
, dma_addr_t dma)
 		return;
 	}
=20
-	if (want_init_on_free())
-		memset(vaddr, 0, pool->size);
 	if (pool_page_err(pool, page, vaddr, dma)) {
 		spin_unlock_irqrestore(&pool->lock, flags);
 		return;
--=20
2.30.2

