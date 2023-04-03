Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D26D435E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjDCLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDCLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:23:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51A40DB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:23:18 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PqpM90v61zSqnD;
        Mon,  3 Apr 2023 19:19:33 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 19:23:15 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v8 1/3] mm/zswap: remove zswap_entry_cache_{create,destroy} helper function
Date:   Mon, 3 Apr 2023 20:13:16 +0800
Message-ID: <20230403121318.1876082-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403121318.1876082-1-liushixin2@huawei.com>
References: <20230403121318.1876082-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove zswap_entry_cache_create and zswap_entry_cache_destroy and use
kmem_cache_* function directly.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/zswap.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 2f0ebd8bc620..6d2b879f091e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -272,17 +272,6 @@ static void zswap_update_total_size(void)
 **********************************/
 static struct kmem_cache *zswap_entry_cache;
 
-static int __init zswap_entry_cache_create(void)
-{
-	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
-	return zswap_entry_cache == NULL;
-}
-
-static void __init zswap_entry_cache_destroy(void)
-{
-	kmem_cache_destroy(zswap_entry_cache);
-}
-
 static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
 {
 	struct zswap_entry *entry;
@@ -1489,7 +1478,8 @@ static int __init init_zswap(void)
 
 	zswap_init_started = true;
 
-	if (zswap_entry_cache_create()) {
+	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
+	if (!zswap_entry_cache) {
 		pr_err("entry cache creation failed\n");
 		goto cache_fail;
 	}
@@ -1538,7 +1528,7 @@ static int __init init_zswap(void)
 hp_fail:
 	cpuhp_remove_state(CPUHP_MM_ZSWP_MEM_PREPARE);
 dstmem_fail:
-	zswap_entry_cache_destroy();
+	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */
 	zswap_init_failed = true;
-- 
2.25.1

