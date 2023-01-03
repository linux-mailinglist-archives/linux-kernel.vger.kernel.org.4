Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD965C75C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 20:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbjACTTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 14:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjACTTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 14:19:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940CA15F3F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 11:16:24 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303IGC14030763
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jan 2023 11:16:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=4vF82BWEqxBKkQknzp3N1SGxBDFI+587r5lj6iGRioE=;
 b=W7drp1G31q2A8YZXGiuHPW15tyy8FmzSChFaIlpYEPSTwiUgnKKEYYGO4bM7BjVNVj4N
 TY30UuhiwqRZmR3Yl+43quKXJC+j1M6Hqr8aga6uRYM+5MmMRSKwEoPt6N15R3zzWCwE
 GObl7RUpLHxm989ZWdK8WWXOo0GG64GbFsL+yvYjtjq+VPosePoZtB1axDB5kb0nGGhM
 q5zbuav5cwz2wmNWyTDZXPTtKQRuugNRngNlz7dwlzcdbGdm7y48Atn/Ve83egwcX2oY
 Gc/ilIip37gg8tK+C1ENyS47b5XZ6Wc5S4t23evmBL7rvHLHtDu62Bm/RfSXI05lSI0G Rw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mth9wetxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 11:16:24 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 3 Jan 2023 11:16:22 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6D499E1F5E20; Tue,  3 Jan 2023 11:15:55 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Kernel Team <kernel-team@meta.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 12/12] dmapool: create/destroy cleanup
Date:   Tue, 3 Jan 2023 11:15:51 -0800
Message-ID: <20230103191551.3254778-13-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103191551.3254778-1-kbusch@meta.com>
References: <20230103191551.3254778-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aQ59oVMoP8cqI78E6h-erikVlib-GnL2
X-Proofpoint-GUID: aQ59oVMoP8cqI78E6h-erikVlib-GnL2
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

Set the 'empty' bool directly from the result of the function that
determines its value instead of adding indirection logic.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index d23747a71bff2..db4de646a3a91 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -138,7 +138,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 {
 	struct dma_pool *retval;
 	size_t allocation;
-	bool empty =3D false;
+	bool empty;
=20
 	if (!dev)
 		return NULL;
@@ -188,8 +188,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 	 */
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
-	if (list_empty(&dev->dma_pools))
-		empty =3D true;
+	empty =3D list_empty(&dev->dma_pools);
 	list_add(&retval->pools, &dev->dma_pools);
 	mutex_unlock(&pools_lock);
 	if (empty) {
@@ -263,7 +262,7 @@ static struct dma_page *pool_alloc_page(struct dma_po=
ol *pool, gfp_t mem_flags)
 void dma_pool_destroy(struct dma_pool *pool)
 {
 	struct dma_page *page, *tmp;
-	bool empty =3D false, busy =3D false;
+	bool empty, busy =3D false;
=20
 	if (unlikely(!pool))
 		return;
@@ -271,8 +270,7 @@ void dma_pool_destroy(struct dma_pool *pool)
 	mutex_lock(&pools_reg_lock);
 	mutex_lock(&pools_lock);
 	list_del(&pool->pools);
-	if (list_empty(&pool->dev->dma_pools))
-		empty =3D true;
+	empty =3D list_empty(&pool->dev->dma_pools);
 	mutex_unlock(&pools_lock);
 	if (empty)
 		device_remove_file(pool->dev, &dev_attr_pools);
--=20
2.30.2

