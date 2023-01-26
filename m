Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6A67D7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 22:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjAZVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 16:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjAZVvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 16:51:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A134A1F3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:37 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QKqvbB000849
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=bKgaIgCzl+sBGwA7v3YqE5kXwxl/qwPaI+k5PR78ySk=;
 b=fMCMSJnsInPjYMhsW+pbka/x8V+e6/LX+0UItt0S9df8MkqWdeQREl3xVMtuF1WAePTK
 UME9C3Uexi1D7J1HOb6QyNqWYacL3gF7/nyG/smx08AUUmIU/aYXwd/rE7haPzKYOgpn
 IFkrJNUMDxfPwc0w5nPYQmixyfP8ICmosVwtODZgpkn1YN4g7itlMpAy2lfAGC61G3eu
 3ycTb3N8f5wDGZBMxsogKKMojt6srWVK5nMN2i6ZTUUomsO97u3ZtPvNuwcI8QJxfvi1
 eWe1Uww60gIuB+k3LIBBTzRmKH293wn5EwiRh6hmVOxmD+uPKCxk0u0JmTtZpRUdPdbz Xw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nb7mbshbn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 13:51:37 -0800
Received: from twshared24547.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Jan 2023 13:51:35 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 0ABA5FE80A93; Thu, 26 Jan 2023 13:51:26 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <akpm@linux-foundation.org>
CC:     <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 03/12] dmapool: use sysfs_emit() instead of scnprintf()
Date:   Thu, 26 Jan 2023 13:51:16 -0800
Message-ID: <20230126215125.4069751-4-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Drs3qtSZhX-1CO45sEN_nVklAO4Z158-
X-Proofpoint-ORIG-GUID: Drs3qtSZhX-1CO45sEN_nVklAO4Z158-
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

From: Tony Battersby <tonyb@cybernetics.com>

Use sysfs_emit instead of scnprintf, snprintf or sprintf.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/dmapool.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/mm/dmapool.c b/mm/dmapool.c
index 559207e1c3339..20616b760bb9c 100644
--- a/mm/dmapool.c
+++ b/mm/dmapool.c
@@ -64,18 +64,11 @@ static DEFINE_MUTEX(pools_reg_lock);
=20
 static ssize_t pools_show(struct device *dev, struct device_attribute *a=
ttr, char *buf)
 {
-	unsigned temp;
-	unsigned size;
-	char *next;
+	int size;
 	struct dma_page *page;
 	struct dma_pool *pool;
=20
-	next =3D buf;
-	size =3D PAGE_SIZE;
-
-	temp =3D scnprintf(next, size, "poolinfo - 0.1\n");
-	size -=3D temp;
-	next +=3D temp;
+	size =3D sysfs_emit(buf, "poolinfo - 0.1\n");
=20
 	mutex_lock(&pools_lock);
 	list_for_each_entry(pool, &dev->dma_pools, pools) {
@@ -90,16 +83,14 @@ static ssize_t pools_show(struct device *dev, struct =
device_attribute *attr, cha
 		spin_unlock_irq(&pool->lock);
=20
 		/* per-pool info, no real statistics yet */
-		temp =3D scnprintf(next, size, "%-16s %4u %4zu %4zu %2u\n",
-				 pool->name, blocks,
-				 pages * (pool->allocation / pool->size),
-				 pool->size, pages);
-		size -=3D temp;
-		next +=3D temp;
+		size +=3D sysfs_emit_at(buf, size, "%-16s %4u %4zu %4zu %2u\n",
+				      pool->name, blocks,
+				      pages * (pool->allocation / pool->size),
+				      pool->size, pages);
 	}
 	mutex_unlock(&pools_lock);
=20
-	return PAGE_SIZE - size;
+	return size;
 }
=20
 static DEVICE_ATTR_RO(pools);
--=20
2.30.2

