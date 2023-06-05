Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C0721F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjFEHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFEHZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:25:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F5B7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:25:21 -0700 (PDT)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QZPk742mlzTkrJ;
        Mon,  5 Jun 2023 15:04:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500011.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 15:05:04 +0800
From:   Li Lingfeng <lilingfeng3@huawei.com>
To:     <dm-devel@redhat.com>
CC:     <agk@redhat.com>, <snitzer@kernel.org>,
        <linux-kernel@vger.kernel.org>, <houtao1@huawei.com>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>,
        <lilingfeng3@huawei.com>
Subject: [PATCH] dm thin: Fix ABBA deadlock by resetting dm_bufio_client
Date:   Mon, 5 Jun 2023 15:03:16 +0800
Message-ID: <20230605070316.1457957-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in commit 8111964f1b85 ("dm thin: Fix ABBA deadlock between
shrink_slab and dm_pool_abort_metadata"), ABBA deadlock will be triggered
since shrinker_rwsem need to be held when operations failed on dm pool
metadata.

We have noticed the following three problem scenarios:
1) Described by commit 8111964f1b85 ("dm thin: Fix ABBA deadlock between
shrink_slab and dm_pool_abort_metadata")

2) shrinker_rwsem and throttle->lock
          P1(drop cache)                        P2(kworker)
drop_caches_sysctl_handler
 drop_slab
  shrink_slab
   down_read(&shrinker_rwsem)  - LOCK A
   do_shrink_slab
    super_cache_scan
     prune_icache_sb
      dispose_list
       evict
        ext4_evict_inode
         ext4_clear_inode
          ext4_discard_preallocations
           ext4_mb_load_buddy_gfp
            ext4_mb_init_cache
             ext4_wait_block_bitmap
              __ext4_error
               ext4_handle_error
                ext4_commit_super
                 ...
                 dm_submit_bio
                                     do_worker
                                      throttle_work_update
                                       down_write(&t->lock) -- LOCK B
                                      process_deferred_bios
                                       commit
                                        metadata_operation_failed
                                         dm_pool_abort_metadata
                                          dm_block_manager_create
                                           dm_bufio_client_create
                                            register_shrinker
                                             down_write(&shrinker_rwsem)
                                             -- LOCK A
                 thin_map
                  thin_bio_map
                   thin_defer_bio_with_throttle
                    throttle_lock
                     down_read(&t->lock)  - LOCK B

3) shrinker_rwsem and wait_on_buffer
          P1(drop cache)                            P2(kworker)
drop_caches_sysctl_handler
 drop_slab
  shrink_slab
   down_read(&shrinker_rwsem)  - LOCK A
   do_shrink_slab
   ...
    ext4_wait_block_bitmap
     __ext4_error
      ext4_handle_error
       jbd2_journal_abort
        jbd2_journal_update_sb_errno
         jbd2_write_superblock
          submit_bh
           // LOCK B
           // RELEASE B
                             do_worker
                              throttle_work_update
                               down_write(&t->lock) - LOCK B
                              process_deferred_bios
                               process_bio
                               commit
                                metadata_operation_failed
                                 dm_pool_abort_metadata
                                  dm_block_manager_create
                                   dm_bufio_client_create
                                    register_shrinker
                                     register_shrinker_prepared
                                      down_write(&shrinker_rwsem)  - LOCK A
                               bio_endio
      wait_on_buffer
       __wait_on_buffer

Fix these by resetting dm_bufio_client without holding shrinker_rwsem.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 drivers/md/dm-bufio.c                         |  7 +++
 drivers/md/dm-thin-metadata.c                 | 58 ++++++++-----------
 drivers/md/persistent-data/dm-block-manager.c |  6 ++
 drivers/md/persistent-data/dm-block-manager.h |  1 +
 drivers/md/persistent-data/dm-space-map.h     |  3 +-
 .../persistent-data/dm-transaction-manager.c  |  3 +
 include/linux/dm-bufio.h                      |  2 +
 7 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index eea977662e81..a7079b38756a 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -2592,6 +2592,13 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 }
 EXPORT_SYMBOL_GPL(dm_bufio_client_destroy);
 
+void dm_bufio_client_reset(struct dm_bufio_client *c)
+{
+	drop_buffers(c);
+	flush_work(&c->shrink_work);
+}
+EXPORT_SYMBOL_GPL(dm_bufio_client_reset);
+
 void dm_bufio_set_sector_offset(struct dm_bufio_client *c, sector_t start)
 {
 	c->start = start;
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 9f5cb52c5763..63d92d388ee6 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -603,6 +603,8 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	r = dm_tm_create_with_sm(pmd->bm, THIN_SUPERBLOCK_LOCATION,
 				 &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_create_with_sm failed");
 		return r;
 	}
@@ -611,6 +613,7 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_create failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -641,11 +644,15 @@ static int __format_metadata(struct dm_pool_metadata *pmd)
 
 bad_cleanup_nb_tm:
 	dm_tm_destroy(pmd->nb_tm);
+	pmd->nb_tm = NULL;
 bad_cleanup_data_sm:
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 bad_cleanup_tm:
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 
 	return r;
 }
@@ -711,6 +718,8 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 			       sizeof(disk_super->metadata_space_map_root),
 			       &pmd->tm, &pmd->metadata_sm);
 	if (r < 0) {
+		pmd->tm = NULL;
+		pmd->metadata_sm = NULL;
 		DMERR("tm_open_with_sm failed");
 		goto bad_unlock_sblock;
 	}
@@ -720,6 +729,7 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 	if (IS_ERR(pmd->data_sm)) {
 		DMERR("sm_disk_open failed");
 		r = PTR_ERR(pmd->data_sm);
+		pmd->data_sm = NULL;
 		goto bad_cleanup_tm;
 	}
 
@@ -746,9 +756,12 @@ static int __open_metadata(struct dm_pool_metadata *pmd)
 
 bad_cleanup_data_sm:
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 bad_cleanup_tm:
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 bad_unlock_sblock:
 	dm_bm_unlock(sblock);
 
@@ -795,9 +808,13 @@ static void __destroy_persistent_data_objects(struct dm_pool_metadata *pmd,
 					      bool destroy_bm)
 {
 	dm_sm_destroy(pmd->data_sm);
+	pmd->data_sm = NULL;
 	dm_sm_destroy(pmd->metadata_sm);
+	pmd->metadata_sm = NULL;
 	dm_tm_destroy(pmd->nb_tm);
+	pmd->nb_tm = NULL;
 	dm_tm_destroy(pmd->tm);
+	pmd->tm = NULL;
 	if (destroy_bm)
 		dm_block_manager_destroy(pmd->bm);
 }
@@ -1005,8 +1022,7 @@ int dm_pool_metadata_close(struct dm_pool_metadata *pmd)
 			       __func__, r);
 	}
 	pmd_write_unlock(pmd);
-	if (!pmd->fail_io)
-		__destroy_persistent_data_objects(pmd, true);
+	__destroy_persistent_data_objects(pmd, true);
 
 	kfree(pmd);
 	return 0;
@@ -1877,53 +1893,29 @@ static void __set_abort_with_changes_flags(struct dm_pool_metadata *pmd)
 int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 {
 	int r = -EINVAL;
-	struct dm_block_manager *old_bm = NULL, *new_bm = NULL;
 
 	/* fail_io is double-checked with pmd->root_lock held below */
 	if (unlikely(pmd->fail_io))
 		return r;
 
-	/*
-	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
-	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
-	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
-	 * - must take shrinker_mutex without holding pmd->root_lock
-	 */
-	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
-					 THIN_MAX_CONCURRENT_LOCKS);
-
 	pmd_write_lock(pmd);
 	if (pmd->fail_io) {
 		pmd_write_unlock(pmd);
-		goto out;
+		return r;
 	}
-
 	__set_abort_with_changes_flags(pmd);
+
+	/* destroy data_sm/metadata_sm/nb_tm/tm */
 	__destroy_persistent_data_objects(pmd, false);
-	old_bm = pmd->bm;
-	if (IS_ERR(new_bm)) {
-		DMERR("could not create block manager during abort");
-		pmd->bm = NULL;
-		r = PTR_ERR(new_bm);
-		goto out_unlock;
-	}
 
-	pmd->bm = new_bm;
+	/* reset bm */
+	dm_block_manager_reset(pmd->bm);
+
+	/* rebuild data_sm/metadata_sm/nb_tm/tm */
 	r = __open_or_format_metadata(pmd, false);
-	if (r) {
-		pmd->bm = NULL;
-		goto out_unlock;
-	}
-	new_bm = NULL;
-out_unlock:
 	if (r)
 		pmd->fail_io = true;
 	pmd_write_unlock(pmd);
-	dm_block_manager_destroy(old_bm);
-out:
-	if (new_bm && !IS_ERR(new_bm))
-		dm_block_manager_destroy(new_bm);
-
 	return r;
 }
 
diff --git a/drivers/md/persistent-data/dm-block-manager.c b/drivers/md/persistent-data/dm-block-manager.c
index 7bdfc23f758a..0e010e1204aa 100644
--- a/drivers/md/persistent-data/dm-block-manager.c
+++ b/drivers/md/persistent-data/dm-block-manager.c
@@ -421,6 +421,12 @@ void dm_block_manager_destroy(struct dm_block_manager *bm)
 }
 EXPORT_SYMBOL_GPL(dm_block_manager_destroy);
 
+void dm_block_manager_reset(struct dm_block_manager *bm)
+{
+	dm_bufio_client_reset(bm->bufio);
+}
+EXPORT_SYMBOL_GPL(dm_block_manager_reset);
+
 unsigned int dm_bm_block_size(struct dm_block_manager *bm)
 {
 	return dm_bufio_get_block_size(bm->bufio);
diff --git a/drivers/md/persistent-data/dm-block-manager.h b/drivers/md/persistent-data/dm-block-manager.h
index 5746b0f82a03..f706d3de8d5a 100644
--- a/drivers/md/persistent-data/dm-block-manager.h
+++ b/drivers/md/persistent-data/dm-block-manager.h
@@ -36,6 +36,7 @@ struct dm_block_manager *dm_block_manager_create(
 	struct block_device *bdev, unsigned int block_size,
 	unsigned int max_held_per_thread);
 void dm_block_manager_destroy(struct dm_block_manager *bm);
+void dm_block_manager_reset(struct dm_block_manager *bm);
 
 unsigned int dm_bm_block_size(struct dm_block_manager *bm);
 dm_block_t dm_bm_nr_blocks(struct dm_block_manager *bm);
diff --git a/drivers/md/persistent-data/dm-space-map.h b/drivers/md/persistent-data/dm-space-map.h
index dab490353781..6bf69922b5ad 100644
--- a/drivers/md/persistent-data/dm-space-map.h
+++ b/drivers/md/persistent-data/dm-space-map.h
@@ -77,7 +77,8 @@ struct dm_space_map {
 
 static inline void dm_sm_destroy(struct dm_space_map *sm)
 {
-	sm->destroy(sm);
+	if (sm)
+		sm->destroy(sm);
 }
 
 static inline int dm_sm_extend(struct dm_space_map *sm, dm_block_t extra_blocks)
diff --git a/drivers/md/persistent-data/dm-transaction-manager.c b/drivers/md/persistent-data/dm-transaction-manager.c
index 6dc016248baf..c88fa6266203 100644
--- a/drivers/md/persistent-data/dm-transaction-manager.c
+++ b/drivers/md/persistent-data/dm-transaction-manager.c
@@ -199,6 +199,9 @@ EXPORT_SYMBOL_GPL(dm_tm_create_non_blocking_clone);
 
 void dm_tm_destroy(struct dm_transaction_manager *tm)
 {
+	if (!tm)
+		return;
+
 	if (!tm->is_clone)
 		wipe_shadow_table(tm);
 
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 681656a1c03d..75e7d8cbb532 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -38,6 +38,8 @@ dm_bufio_client_create(struct block_device *bdev, unsigned int block_size,
  */
 void dm_bufio_client_destroy(struct dm_bufio_client *c);
 
+void dm_bufio_client_reset(struct dm_bufio_client *c);
+
 /*
  * Set the sector range.
  * When this function is called, there must be no I/O in progress on the bufio
-- 
2.31.1

