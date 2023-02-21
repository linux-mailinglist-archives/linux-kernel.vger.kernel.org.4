Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1330869DDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjBUKd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjBUKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:33:21 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA383C4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:33:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcC7r-U_1676975595;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcC7r-U_1676975595)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 18:33:15 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fscache: introduce fscache_begin_wait_operation() helper
Date:   Tue, 21 Feb 2023 18:33:13 +0800
Message-Id: <20230221103313.120834-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230221103313.120834-1-jefflexu@linux.alibaba.com>
References: <20230221103313.120834-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a variant of fscache_wait_for_operation() except that it's
exported for users of FsCache, and thus cookie->lock is held when
checking cookie's state.

Exporting fscache_begin_operation() directly is not acceptable as it
would introduce dependency of <trace/events/fscache.h> for users of
FsCache.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/fscache/io.c         |  9 +++++++++
 include/linux/fscache.h | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/fscache/io.c b/fs/fscache/io.c
index 0d2b8dec8f82..6ccc5aadf151 100644
--- a/fs/fscache/io.c
+++ b/fs/fscache/io.c
@@ -158,6 +158,15 @@ int __fscache_begin_write_operation(struct netfs_cache_resources *cres,
 }
 EXPORT_SYMBOL(__fscache_begin_write_operation);
 
+int __fscache_begin_wait_operation(struct netfs_cache_resources *cres,
+				   struct fscache_cookie *cookie,
+				   enum fscache_want_state want_state)
+{
+	return fscache_begin_operation(cres, cookie, want_state,
+				       fscache_access_io_wait);
+}
+EXPORT_SYMBOL(__fscache_begin_wait_operation);
+
 /**
  * fscache_dirty_folio - Mark folio dirty and pin a cache object for writeback
  * @mapping: The mapping the folio belongs to.
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 8e312c8323a8..708cf8db7f46 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -171,6 +171,8 @@ extern void __fscache_resize_cookie(struct fscache_cookie *, loff_t);
 extern void __fscache_invalidate(struct fscache_cookie *, const void *, loff_t, unsigned int);
 extern int __fscache_begin_read_operation(struct netfs_cache_resources *, struct fscache_cookie *);
 extern int __fscache_begin_write_operation(struct netfs_cache_resources *, struct fscache_cookie *);
+extern int __fscache_begin_wait_operation(struct netfs_cache_resources *, struct fscache_cookie *,
+					  enum fscache_want_state want_state);
 
 extern void __fscache_write_to_cache(struct fscache_cookie *, struct address_space *,
 				     loff_t, size_t, loff_t, netfs_io_terminated_t, void *,
@@ -543,6 +545,26 @@ int fscache_begin_write_operation(struct netfs_cache_resources *cres,
 	return -ENOBUFS;
 }
 
+/**
+ * fscache_begin_wait_operation - Wait for an object become accessible
+ * @cres: The cache resources for the operation being performed
+ * @cookie: The cookie representing the cache object
+ *
+ * Returns:
+ * * 0		- Success
+ * * -ENOBUFS	- No caching available
+ * * Other error code from the cache, such as -ENOMEM.
+ */
+static inline
+int fscache_begin_wait_operation(struct netfs_cache_resources *cres,
+				 struct fscache_cookie *cookie,
+				 enum fscache_want_state want_state)
+{
+	if (fscache_cookie_enabled(cookie))
+		return __fscache_begin_wait_operation(cres, cookie, want_state);
+	return -ENOBUFS;
+}
+
 /**
  * fscache_write - Start a write to the cache.
  * @cres: The cache resources to use
-- 
2.19.1.6.gb485710b

