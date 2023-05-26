Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9EB712E12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjEZUPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjEZUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:15:16 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCC134
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:15:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VjXYN5q_1685132111;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VjXYN5q_1685132111)
          by smtp.aliyun-inc.com;
          Sat, 27 May 2023 04:15:12 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/6] erofs: use struct lockref to replace handcrafted approach
Date:   Sat, 27 May 2023 04:14:58 +0800
Message-Id: <20230526201459.128169-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
References: <20230526201459.128169-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid the current handcrafted lockref although `struct lockref`
inclusion usually increases extra 4 bytes with an explicit spinlock if
CONFIG_DEBUG_SPINLOCK is off.

Apart from the size difference, note that the meaning of refcount is
also changed to active users. IOWs, it doesn't take an extra refcount
for XArray tree insertion.

I don't observe any significant performance difference at least on
our cloud compute server but the new one indeed simplifies the
overall codebase a bit.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h | 38 ++------------------
 fs/erofs/utils.c    | 87 ++++++++++++++++++++++-----------------------
 fs/erofs/zdata.c    | 15 ++++----
 3 files changed, 53 insertions(+), 87 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0b8506c39145..e63f6cd424a0 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -208,46 +208,12 @@ enum {
 	EROFS_ZIP_CACHE_READAROUND
 };
 
-#define EROFS_LOCKED_MAGIC     (INT_MIN | 0xE0F510CCL)
-
 /* basic unit of the workstation of a super_block */
 struct erofs_workgroup {
-	/* the workgroup index in the workstation */
 	pgoff_t index;
-
-	/* overall workgroup reference count */
-	atomic_t refcount;
+	struct lockref lockref;
 };
 
-static inline bool erofs_workgroup_try_to_freeze(struct erofs_workgroup *grp,
-						 int val)
-{
-	preempt_disable();
-	if (val != atomic_cmpxchg(&grp->refcount, val, EROFS_LOCKED_MAGIC)) {
-		preempt_enable();
-		return false;
-	}
-	return true;
-}
-
-static inline void erofs_workgroup_unfreeze(struct erofs_workgroup *grp,
-					    int orig_val)
-{
-	/*
-	 * other observers should notice all modifications
-	 * in the freezing period.
-	 */
-	smp_mb();
-	atomic_set(&grp->refcount, orig_val);
-	preempt_enable();
-}
-
-static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
-{
-	return atomic_cond_read_relaxed(&grp->refcount,
-					VAL != EROFS_LOCKED_MAGIC);
-}
-
 enum erofs_kmap_type {
 	EROFS_NO_KMAP,		/* don't map the buffer */
 	EROFS_KMAP,		/* use kmap_local_page() to map the buffer */
@@ -492,7 +458,7 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
 void erofs_release_pages(struct page **pagepool);
 
 #ifdef CONFIG_EROFS_FS_ZIP
-int erofs_workgroup_put(struct erofs_workgroup *grp);
+void erofs_workgroup_put(struct erofs_workgroup *grp);
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 					     pgoff_t index);
 struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 46627cb69abe..6895680e1372 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -33,22 +33,21 @@ void erofs_release_pages(struct page **pagepool)
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
-static int erofs_workgroup_get(struct erofs_workgroup *grp)
+static bool erofs_workgroup_get(struct erofs_workgroup *grp)
 {
-	int o;
+	if (lockref_get_not_zero(&grp->lockref))
+		return true;
 
-repeat:
-	o = erofs_wait_on_workgroup_freezed(grp);
-	if (o <= 0)
-		return -1;
-
-	if (atomic_cmpxchg(&grp->refcount, o, o + 1) != o)
-		goto repeat;
+	spin_lock(&grp->lockref.lock);
+	if (__lockref_is_dead(&grp->lockref)) {
+		spin_unlock(&grp->lockref.lock);
+		return false;
+	}
 
-	/* decrease refcount paired by erofs_workgroup_put */
-	if (o == 1)
+	if (!grp->lockref.count++)
 		atomic_long_dec(&erofs_global_shrink_cnt);
-	return 0;
+	spin_unlock(&grp->lockref.lock);
+	return true;
 }
 
 struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
@@ -61,7 +60,7 @@ struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
 	rcu_read_lock();
 	grp = xa_load(&sbi->managed_pslots, index);
 	if (grp) {
-		if (erofs_workgroup_get(grp)) {
+		if (!erofs_workgroup_get(grp)) {
 			/* prefer to relax rcu read side */
 			rcu_read_unlock();
 			goto repeat;
@@ -80,11 +79,10 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 	struct erofs_workgroup *pre;
 
 	/*
-	 * Bump up a reference count before making this visible
-	 * to others for the XArray in order to avoid potential
-	 * UAF without serialized by xa_lock.
+	 * Bump up before making this visible to others for the XArray in order
+	 * to avoid potential UAF without serialized by xa_lock.
 	 */
-	atomic_inc(&grp->refcount);
+	lockref_get(&grp->lockref);
 
 repeat:
 	xa_lock(&sbi->managed_pslots);
@@ -93,13 +91,13 @@ struct erofs_workgroup *erofs_insert_workgroup(struct super_block *sb,
 	if (pre) {
 		if (xa_is_err(pre)) {
 			pre = ERR_PTR(xa_err(pre));
-		} else if (erofs_workgroup_get(pre)) {
+		} else if (!erofs_workgroup_get(pre)) {
 			/* try to legitimize the current in-tree one */
 			xa_unlock(&sbi->managed_pslots);
 			cond_resched();
 			goto repeat;
 		}
-		atomic_dec(&grp->refcount);
+		lockref_put_return(&grp->lockref);
 		grp = pre;
 	}
 	xa_unlock(&sbi->managed_pslots);
@@ -112,38 +110,36 @@ static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
 	erofs_workgroup_free_rcu(grp);
 }
 
-int erofs_workgroup_put(struct erofs_workgroup *grp)
+void erofs_workgroup_put(struct erofs_workgroup *grp)
 {
-	int count = atomic_dec_return(&grp->refcount);
+	if (lockref_put_not_zero(&grp->lockref))
+		return;
 
-	if (count == 1)
+	spin_lock(&grp->lockref.lock);
+	DBG_BUGON(__lockref_is_dead(&grp->lockref));
+	if (grp->lockref.count == 1) {
 		atomic_long_inc(&erofs_global_shrink_cnt);
-	else if (!count)
-		__erofs_workgroup_free(grp);
-	return count;
+		--grp->lockref.count;
+	}
+	spin_unlock(&grp->lockref.lock);
 }
 
 static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   struct erofs_workgroup *grp)
 {
-	/*
-	 * If managed cache is on, refcount of workgroups
-	 * themselves could be < 0 (freezed). In other words,
-	 * there is no guarantee that all refcounts > 0.
-	 */
-	if (!erofs_workgroup_try_to_freeze(grp, 1))
-		return false;
+	int free = false;
+
+	spin_lock(&grp->lockref.lock);
+	if (grp->lockref.count)
+		goto out;
 
 	/*
-	 * Note that all cached pages should be unattached
-	 * before deleted from the XArray. Otherwise some
-	 * cached pages could be still attached to the orphan
-	 * old workgroup when the new one is available in the tree.
+	 * Note that all cached pages should be detached before deleted from
+	 * the XArray. Otherwise some cached pages could be still attached to
+	 * the orphan old workgroup when the new one is available in the tree.
 	 */
-	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
-		erofs_workgroup_unfreeze(grp, 1);
-		return false;
-	}
+	if (erofs_try_to_free_all_cached_pages(sbi, grp))
+		goto out;
 
 	/*
 	 * It's impossible to fail after the workgroup is freezed,
@@ -152,10 +148,13 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	 */
 	DBG_BUGON(__xa_erase(&sbi->managed_pslots, grp->index) != grp);
 
-	/* last refcount should be connected with its managed pslot.  */
-	erofs_workgroup_unfreeze(grp, 0);
-	__erofs_workgroup_free(grp);
-	return true;
+	lockref_mark_dead(&grp->lockref);
+	free = true;
+out:
+	spin_unlock(&grp->lockref.lock);
+	if (free)
+		__erofs_workgroup_free(grp);
+	return free;
 }
 
 static unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 15a383899540..2ea8e7f08372 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -643,7 +643,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 	/*
-	 * refcount of workgroup is now freezed as 1,
+	 * refcount of workgroup is now freezed as 0,
 	 * therefore no need to worry about available decompression users.
 	 */
 	for (i = 0; i < pcl->pclusterpages; ++i) {
@@ -676,10 +676,11 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 	if (!folio_test_private(folio))
 		return true;
 
-	if (!erofs_workgroup_try_to_freeze(&pcl->obj, 1))
-		return false;
-
 	ret = false;
+	spin_lock(&pcl->obj.lockref.lock);
+	if (pcl->obj.lockref.count > 0)
+		goto out;
+
 	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
 	for (i = 0; i < pcl->pclusterpages; ++i) {
 		if (pcl->compressed_bvecs[i].page == &folio->page) {
@@ -688,10 +689,10 @@ static bool z_erofs_cache_release_folio(struct folio *folio, gfp_t gfp)
 			break;
 		}
 	}
-	erofs_workgroup_unfreeze(&pcl->obj, 1);
-
 	if (ret)
 		folio_detach_private(folio);
+out:
+	spin_unlock(&pcl->obj.lockref.lock);
 	return ret;
 }
 
@@ -807,7 +808,7 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	if (IS_ERR(pcl))
 		return PTR_ERR(pcl);
 
-	atomic_set(&pcl->obj.refcount, 1);
+	spin_lock_init(&pcl->obj.lockref.lock);
 	pcl->algorithmformat = map->m_algorithmformat;
 	pcl->length = 0;
 	pcl->partial = true;
-- 
2.24.4

