Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0325467D804
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjAZVzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjAZVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:54:45 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5A21A14
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:43 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30QJ9NFV028224
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=3bZHL2Z78cKAF6RylfMcYGJJt43dfPQsNy0PbvPE3is=;
 b=lVrUtV7eIfA+pTjKwQ4ayJK+j8lGNrnWZANTogfISnYDcFY9OF80Vn5S04uuKHS/jvMb
 EeIGIEZdjrEWbgNpuS8LBQAaHrWV0XYxLUVb/6Ed1igPwjGL2oDsIWOAwyfA9vMPoAg/
 FSab2TSFYmid8os9V6E+9I8CkMTsyXS9OMoypXZdyoOYM+Eh4FSii6xiMosOSPIu8Ugm
 Fe4yICWSigw/3zCpzzISOciiyvIN1f0JvD8MxwEtigJPCeUM4eEqHqzxGcg0HvCEt4Qy
 y3+QrA+qmX6r+kanWgp4UYVU9/3jM5IO4hErIm4/A4RrjzXCeXZNVhz5SakVnWoRMigx Sw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nbe8yye5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:54:42 -0800
Received: from twshared1408.04.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:54:41 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 72918FE80AA6; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 12/12] dmapool: create/destroy cleanup
Date:   Thu, 26 Jan 2023 13:51:25 -0800
Message-ID: <20230126215125.4069751-13-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CmWiZxWWIwo4IzqQFJFLEKuRryx8QaqQ
X-Proofpoint-GUID: CmWiZxWWIwo4IzqQFJFLEKuRryx8QaqQ
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

Set the 'empty' bool directly from the result of the function that
determines its value instead of adding additional logic.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 mm/dmapool.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index bb8893b4f4b96..1920890ff8d3d 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -226,7 +226,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
ruct device *dev,
 {
 	struct dma_pool *retval;
 	size_t allocation;
-	bool empty =3D false;
+	bool empty;
=20
 	if (!dev)
 		return NULL;
@@ -276,8 +276,7 @@ struct dma_pool *dma_pool_create(const char *name, st=
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
@@ -350,7 +349,7 @@ static struct dma_page *pool_alloc_page(struct dma_po=
ol *pool, gfp_t mem_flags)
 void dma_pool_destroy(struct dma_pool *pool)
 {
 	struct dma_page *page, *tmp;
-	bool empty =3D false, busy =3D false;
+	bool empty, busy =3D false;
=20
 	if (unlikely(!pool))
 		return;
@@ -358,8 +357,7 @@ void dma_pool_destroy(struct dma_pool *pool)
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

