Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF56C4669
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCVJ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCVJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:29:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776559439
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 02:29:27 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PhNQ32plkz17MRb;
        Wed, 22 Mar 2023 17:26:19 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 22 Mar
 2023 17:29:25 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v6 2/2] mm/zswap: delay the initializaton of zswap
Date:   Wed, 22 Mar 2023 18:20:06 +0800
Message-ID: <20230322102006.780624-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322102006.780624-1-liushixin2@huawei.com>
References: <20230322102006.780624-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since some users may not use zswap, the zswap_pool is wasted. Save memory
by delaying the initialization of zswap until enabled.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 09fa956920fa..3aed3b26524a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
 
 #define ZSWAP_PARAM_UNSET ""
 
+static int zswap_setup(void);
+
 /* Enable/disable zswap */
 static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
@@ -220,6 +222,9 @@ static bool zswap_init_started;
 /* fatal error during init */
 static bool zswap_init_failed;
 
+/* used to ensure the integrity of initialization */
+static DEFINE_MUTEX(zswap_init_lock);
+
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
 
@@ -272,13 +277,13 @@ static void zswap_update_total_size(void)
 **********************************/
 static struct kmem_cache *zswap_entry_cache;
 
-static int __init zswap_entry_cache_create(void)
+static int zswap_entry_cache_create(void)
 {
 	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
 	return zswap_entry_cache == NULL;
 }
 
-static void __init zswap_entry_cache_destroy(void)
+static void zswap_entry_cache_destroy(void)
 {
 	kmem_cache_destroy(zswap_entry_cache);
 }
@@ -663,7 +668,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	return NULL;
 }
 
-static __init struct zswap_pool *__zswap_pool_create_fallback(void)
+static struct zswap_pool *__zswap_pool_create_fallback(void)
 {
 	bool has_comp, has_zpool;
 
@@ -784,8 +789,15 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	/* if this is load-time (pre-init) param setting,
 	 * don't create a pool; that's done during init.
 	 */
-	if (!zswap_init_started)
-		return param_set_charp(s, kp);
+	if (!zswap_init_started) {
+		mutex_lock(&zswap_init_lock);
+		if (!zswap_init_started) {
+			ret = param_set_charp(s, kp);
+			mutex_unlock(&zswap_init_lock);
+			return ret;
+		}
+		mutex_unlock(&zswap_init_lock);
+	}
 
 	if (!type) {
 		if (!zpool_has_pool(s)) {
@@ -884,6 +896,15 @@ static int zswap_enabled_param_set(const char *val,
 	if (res == *(bool *)kp->arg)
 		return 0;
 
+	if (!zswap_init_started && (system_state == SYSTEM_RUNNING)) {
+		mutex_lock(&zswap_init_lock);
+		if (zswap_setup()) {
+			mutex_unlock(&zswap_init_lock);
+			return -ENODEV;
+		}
+		mutex_unlock(&zswap_init_lock);
+	}
+
 	if (zswap_init_failed) {
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
@@ -1451,7 +1472,7 @@ static const struct frontswap_ops zswap_frontswap_ops = {
 
 static struct dentry *zswap_debugfs_root;
 
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
 		return -ENODEV;
@@ -1482,7 +1503,7 @@ static int __init zswap_debugfs_init(void)
 	return 0;
 }
 #else
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	return 0;
 }
@@ -1491,12 +1512,13 @@ static int __init zswap_debugfs_init(void)
 /*********************************
 * module init and exit
 **********************************/
-static int __init init_zswap(void)
+static int zswap_setup(void)
 {
 	struct zswap_pool *pool;
 	int ret;
 
-	zswap_init_started = true;
+	if (zswap_init_started)
+		return 0;
 
 	if (zswap_entry_cache_create()) {
 		pr_err("entry cache creation failed\n");
@@ -1537,6 +1559,7 @@ static int __init init_zswap(void)
 		goto destroy_wq;
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
+	zswap_init_started = true;
 	return 0;
 
 destroy_wq:
@@ -1551,11 +1574,19 @@ static int __init init_zswap(void)
 cache_fail:
 	/* if built-in, we aren't unloaded on failure; don't allow use */
 	zswap_init_failed = true;
+	zswap_init_started = true;
 	zswap_enabled = false;
 	return -ENOMEM;
 }
+
+static int __init zswap_init(void)
+{
+	if (!zswap_enabled)
+		return 0;
+	return zswap_setup();
+}
 /* must be late so crypto has time to come up */
-late_initcall(init_zswap);
+late_initcall(zswap_init);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Seth Jennings <sjennings@variantweb.net>");
-- 
2.25.1

