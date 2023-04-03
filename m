Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02E46D4361
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjDCLXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDCLXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:23:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FD559E1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:23:19 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PqpMZ1sYvznZpl;
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
Subject: [PATCH -next v8 3/3] mm/zswap: delay the initialization of zswap
Date:   Mon, 3 Apr 2023 20:13:18 +0800
Message-ID: <20230403121318.1876082-4-liushixin2@huawei.com>
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

Since some users may not use zswap, the zswap_pool is wasted. Save memory
by delaying the initialization of zswap until enabled.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/zswap.c | 56 +++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9169c2baee87..14db57450bfd 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -81,6 +81,8 @@ static bool zswap_pool_reached_full;
 
 #define ZSWAP_PARAM_UNSET ""
 
+static int zswap_setup(void);
+
 /* Enable/disable zswap */
 static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
@@ -222,6 +224,9 @@ enum zswap_init_type {
 
 static enum zswap_init_type zswap_init_state;
 
+/* used to ensure the integrity of initialization */
+static DEFINE_MUTEX(zswap_init_lock);
+
 /* init completed, but couldn't create the initial pool */
 static bool zswap_has_pool;
 
@@ -654,7 +659,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	return NULL;
 }
 
-static __init struct zswap_pool *__zswap_pool_create_fallback(void)
+static struct zswap_pool *__zswap_pool_create_fallback(void)
 {
 	bool has_comp, has_zpool;
 
@@ -763,21 +768,28 @@ static int __zswap_param_set(const char *val, const struct kernel_param *kp,
 	char *s = strstrip((char *)val);
 	int ret;
 
+	mutex_lock(&zswap_init_lock);
 	switch (zswap_init_state) {
 	case ZSWAP_UNINIT:
 		/* if this is load-time (pre-init) param setting,
 		 * don't create a pool; that's done during init.
 		 */
-		return param_set_charp(s, kp);
+		ret = param_set_charp(s, kp);
+		mutex_unlock(&zswap_init_lock);
+		return ret;
 	case ZSWAP_INIT_SUCCEED:
 		/* no change required */
-		if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool)
+		if (!strcmp(s, *(char **)kp->arg) && zswap_has_pool) {
+			mutex_unlock(&zswap_init_lock);
 			return 0;
+		}
 		break;
 	case ZSWAP_INIT_FAILED:
 		pr_err("can't set param, initialization failed\n");
+		mutex_unlock(&zswap_init_lock);
 		return -ENODEV;
 	}
+	mutex_unlock(&zswap_init_lock);
 
 	if (!type) {
 		if (!zpool_has_pool(s)) {
@@ -867,19 +879,30 @@ static int zswap_zpool_param_set(const char *val,
 static int zswap_enabled_param_set(const char *val,
 				   const struct kernel_param *kp)
 {
+	int ret = -ENODEV;
+
+	/*if this is load-time (pre-init) param setting, only set param.*/
+	if (system_state != SYSTEM_RUNNING)
+		return param_set_bool(val, kp);
+
+	mutex_lock(&zswap_init_lock);
 	switch (zswap_init_state) {
 	case ZSWAP_UNINIT:
-		return param_set_bool(val, kp);
+		if (zswap_setup())
+			break;
+		fallthrough;
 	case ZSWAP_INIT_SUCCEED:
-		if (!zswap_has_pool) {
+		if (!zswap_has_pool)
 			pr_err("can't enable, no pool configured\n");
-			return -ENODEV;
-		} else
-			return param_set_bool(val, kp);
+		else
+			ret = param_set_bool(val, kp);
+		break;
 	case ZSWAP_INIT_FAILED:
 		pr_err("can't enable, initialization failed\n");
-		return -ENODEV;
 	}
+	mutex_unlock(&zswap_init_lock);
+
+	return ret;
 }
 
 /*********************************
@@ -1437,7 +1460,7 @@ static const struct frontswap_ops zswap_frontswap_ops = {
 
 static struct dentry *zswap_debugfs_root;
 
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	if (!debugfs_initialized())
 		return -ENODEV;
@@ -1468,7 +1491,7 @@ static int __init zswap_debugfs_init(void)
 	return 0;
 }
 #else
-static int __init zswap_debugfs_init(void)
+static int zswap_debugfs_init(void)
 {
 	return 0;
 }
@@ -1477,7 +1500,7 @@ static int __init zswap_debugfs_init(void)
 /*********************************
 * module init and exit
 **********************************/
-static int __init init_zswap(void)
+static int zswap_setup(void)
 {
 	struct zswap_pool *pool;
 	int ret;
@@ -1540,8 +1563,15 @@ static int __init init_zswap(void)
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

