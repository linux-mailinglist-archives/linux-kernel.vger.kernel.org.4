Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897C6723841
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjFFG50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235632AbjFFG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:57:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C2E42
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:57:22 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb1Vj2Xs5zTl5h;
        Tue,  6 Jun 2023 14:57:01 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 14:57:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] mm/slab_common: reduce an if statement in create_cache()
Date:   Tue, 6 Jun 2023 14:55:43 +0800
Message-ID: <20230606065543.1324-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the 'out:' statement block out of the successful path to avoid
redundant check on 'err'. The value of 'err' is always zero on success
and negative on failure.

No functional changes, no performance improvements, just a little more
readability.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/slab_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 607249785c077e9..f6fe35105774944 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -236,14 +236,12 @@ static struct kmem_cache *create_cache(const char *name,
 
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
-out:
-	if (err)
-		return ERR_PTR(err);
 	return s;
 
 out_free_cache:
 	kmem_cache_free(kmem_cache, s);
-	goto out;
+out:
+	return ERR_PTR(err);
 }
 
 /**
-- 
2.25.1

