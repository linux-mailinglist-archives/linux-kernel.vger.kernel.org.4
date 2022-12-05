Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218CA642B26
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiLEPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiLEPNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:13:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340D5F84
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:13:27 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B51d4Sq028659
        for <linux-kernel@vger.kernel.org>; Mon, 5 Dec 2022 07:13:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=MLWHDUS20C0jmHJ39hBO1H02jIUsWm5bZEXT2SOrcPk=;
 b=ejYF75fU7LKM8wl5jpImHC6ob7OmFqntqgSVGc7q7fBRtNTo2YbmogV9/hYldchrM5wM
 G0+tjYboDIyd5JbXawla0H4uvIOtKIYTIurU5zdZBP0kxApMAZGRIOvXKAig2QNU3KMf
 eIiafVB8VOpgv6FqOoo28oMSYTlMz1YLZA6rOqxa7tMTjf+eHGdJuwl4dbcwngVrLne1
 l16/SnAwj5orN2eNpyh6zDEi0moXxB76qmVzGa0EU66PzkXkQAohAew/QcGDljqEA6kz
 WusGmDZ0R0+69WEmS1e817ytYI09qRBuM4V9W9N5PPvhKdasT7p0qd7KndjZCpcdkU7Z yw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m82ntv1f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 07:13:26 -0800
Received: from twshared0551.06.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 5 Dec 2022 07:13:24 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 6027CC6156E3; Mon,  5 Dec 2022 07:00:09 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Tony Battersby <tonyb@cybernetics.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 03/11] dmapool: use sysfs_emit() instead of scnprintf()
Date:   Mon, 5 Dec 2022 06:59:29 -0800
Message-ID: <20221205145937.54367-4-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205145937.54367-1-kbusch@meta.com>
References: <20221205145937.54367-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gIKqeh2PxnGikkroHP_deWhRD57Zjpuo
X-Proofpoint-GUID: gIKqeh2PxnGikkroHP_deWhRD57Zjpuo
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

From: Tony Battersby <tonyb@cybernetics.com>

Use sysfs_emit instead of scnprintf, snprintf or sprintf.

Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
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

