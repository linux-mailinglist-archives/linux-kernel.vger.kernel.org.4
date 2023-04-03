Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525946D4360
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjDCLX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjDCLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:23:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ECC448B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:23:18 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PqpMZ3vWqz17R6b;
        Mon,  3 Apr 2023 19:19:54 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 19:23:16 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next v8 2/3] mm/zswap: replace zswap_init_{started/failed} with zswap_init_state
Date:   Mon, 3 Apr 2023 20:13:17 +0800
Message-ID: <20230403121318.1876082-3-liushixin2@huawei.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 mm/zswap.c | 55 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6d2b879f091e..9169c2baee87 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -214,11 +214,13 @@ static DEFINE_SPINLOCK(zswap_pools_lock);
 /* pool counter to provide unique names to zpool */
 static atomic_t zswap_pools_count = ATOMIC_INIT(0);
 
-/* used by param callback function */
-static bool zswap_init_started;
+enum zswap_init_type {
+	ZSWAP_UNINIT,
+	ZSWAP_INIT_SUCCEED,
+	ZSWAP_INIT_FAILED
+};
 
-/* fatal error during init */
-static bool zswap_init_failed;
+static enum zswap_init_type zswap_init_state;
 
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
@@ -761,21 +763,22 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	char *s = strstrip((char *)val);
 	int ret;
 
-	if (zswap_init_failed) {
+	switch (zswap_init_state) {
+	case ZSWAP_UNINIT:
+		/* if this is load-time (pre-init) param setting,
+		 * don't create a pool; that's done during init.
+		 */
+		return param_set_charp(s, kp);
+	case ZSWAP_INIT_SUCCEED:
+		/* no change required */
+		if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
+			return 0;
+		break;
+	case ZSWAP_INIT_FAILED:
 		pr_err("can't set param, initialization failed\n");
 		return -ENODEV;
 	}
 
-	/* no change required */
-	if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
-		return 0;
-
-	/* if this is load-time (pre-init) param setting,
-	 * don't create a pool; that's done during init.
-	 */
-	if (!zswap_init_started)
-		return param_set_charp(s, kp);
-
 	if (!type) {
 		if (!zpool_has_pool(s)) {
 			pr_err("zpool %s not available\n", s);
@@ -864,16 +867,19 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
-	if (zswap_init_failed) {
+	switch (zswap_init_state) {
+	case ZSWAP_UNINIT:
+		return param_set_bool(val, kp);
+	case ZSWAP_INIT_SUCCEED:
+		if (!zswap_has_pool) {
+			pr_err("can't enable, no pool configured\n");
+			return -ENODEV;
+		} else
+			return param_set_bool(val, kp);
+	case ZSWAP_INIT_FAILED:
 		pr_err("can't enable, initialization failed\n");
 		return -ENODEV;
 	}
-	if (!zswap_has_pool && zswap_init_started) {
-		pr_err("can't enable, no pool configured\n");
-		return -ENODEV;
-	}
-
-	return param_set_bool(val, kp);
 }
 
 /*********************************
@@ -1476,8 +1482,6 @@ static int __init init_zswap(void)
 	struct zswap_pool *pool;
 	int ret;
 
-	zswap_init_started = true;
-
 	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
 	if (!zswap_entry_cache) {
 		pr_err("entry cache creation failed\n");
@@ -1518,6 +1522,7 @@ static int __init init_zswap(void)
 		goto destroy_wq;
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
+	zswap_init_state = ZSWAP_INIT_SUCCEED;
 	return 0;
 
 destroy_wq:
@@ -1531,7 +1536,7 @@ static int __init init_zswap(void)
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

