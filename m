Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF76C8BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjCYGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCYGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:24:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C865115541
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:24:26 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk8CW3lQwzrVts;
        Sat, 25 Mar 2023 14:23:19 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 14:24:23 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v7 3/4] mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
Date:   Sat, 25 Mar 2023 15:14:19 +0800
Message-ID: <20230325071420.2246461-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230325071420.2246461-1-liushixin2@huawei.com>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

The zswap_init_started variable name has a bit confusing. Actually, there
are three state: uninitialized, initial failed and initial succeed. Add
a new variable zswap_init_state to replace zswap_init_{started/failed}.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index d2adc1ffe47d..9eda48c8b8dc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -214,11 +214,11 @@ static DEFINE_SPINLOCK(zswap_pools_lock);
 /* pool counter to provide unique names to zpool */
 static atomic_t zswap_pools_count = ATOMIC_INIT(0);
 
-/* used by param callback function */
-static bool zswap_init_started;
+#define ZSWAP_UNINIT		0x0
+#define ZSWAP_INIT_SUCCEED	0x1
+#define ZSWAP_INIT_FAILED	0x2
 
-/* fatal error during init */
-static bool zswap_init_failed;
+static int zswap_init_state;
 
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
@@ -765,7 +765,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
 		return 0;
 
-	if (zswap_init_failed) {
+	if (zswap_init_state == ZSWAP_INIT_FAILED) {
 		pr_err("can't set param, initialization failed\n");
 		return -ENODEV;
 	}
@@ -773,7 +773,7 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	/* if this is load-time (pre-init) param setting,
 	 * don't create a pool; that's done during init.
 	 */
-	if (!zswap_init_started)
+	if (zswap_init_state == ZSWAP_UNINIT)
 		return param_set_charp(s, kp);
 
 	if (!type) {
@@ -873,11 +873,11 @@ static int zswap_enabled_param_set(const char *val,
 	if (res == *(bool *)kp->arg)
 		return 0;
 
-	if (zswap_init_failed) {
+	if (zswap_init_state == ZSWAP_INIT_FAILED) {
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
 	}
-	if (!zswap_has_pool && zswap_init_started) {
+	if (!zswap_has_pool && (zswap_init_state == ZSWAP_INIT_SUCCEED)) {
 		pr_err("can't enable, no pool configured\n");
 		return -ENODEV;
 	}
@@ -1485,8 +1485,6 @@ static int __init init_zswap(void)
 	struct zswap_pool *pool;
 	int ret;
 
-	zswap_init_started = true;
-
 	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
 	if (!zswap_entry_cache) {
 		pr_err("entry cache creation failed\n");
@@ -1527,6 +1525,7 @@ static int __init init_zswap(void)
 		goto destroy_wq;
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
+	zswap_init_state = ZSWAP_INIT_SUCCEED;
 	return 0;
 
 destroy_wq:
@@ -1540,7 +1539,7 @@ static int __init init_zswap(void)
 	kmem_cache_destroy(zswap_entry_cache);
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */
-	zswap_init_failed = true;
+	zswap_init_state = ZSWAP_INIT_FAILED;
 	zswap_enabled = false;
 	return -ENOMEM;
 }
-- 
2.25.1

