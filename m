Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EA86BDE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 02:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCQBgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 21:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCQBgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 21:36:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55409FBCC;
        Thu, 16 Mar 2023 18:36:44 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 65E681A0087F;
        Fri, 17 Mar 2023 09:36:44 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TMYbAjDf1u6j; Fri, 17 Mar 2023 09:36:43 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 51FE01A00ADF;
        Fri, 17 Mar 2023 09:36:42 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] dm: remove unnecessary (void*) conversions
Date:   Fri, 17 Mar 2023 09:35:54 +0800
Message-Id: <20230317013554.20479-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/md/dm-integrity.c       |  6 +++---
 drivers/md/dm-io.c              |  4 ++--
 drivers/md/dm-kcopyd.c          |  4 ++--
 drivers/md/dm-linear.c          |  6 +++---
 drivers/md/dm-log-writes.c      |  2 +-
 drivers/md/dm-log.c             | 24 ++++++++++++------------
 drivers/md/dm-raid1.c           | 10 +++++-----
 drivers/md/dm-snap-persistent.c |  2 +-
 drivers/md/dm-stripe.c          |  4 ++--
 drivers/md/dm-verity-fec.c      |  4 ++--
 drivers/md/dm-zoned-metadata.c  |  6 +++---
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b0d5057fbdd9..2a388b5f3a95 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3118,7 +3118,7 @@ static int dm_integrity_reboot(struct notifier_block *n, unsigned long code, voi
 
 static void dm_integrity_postsuspend(struct dm_target *ti)
 {
-	struct dm_integrity_c *ic = (struct dm_integrity_c *)ti->private;
+	struct dm_integrity_c *ic = ti->private;
 	int r;
 
 	WARN_ON(unregister_reboot_notifier(&ic->reboot_notifier));
@@ -3167,7 +3167,7 @@ static void dm_integrity_postsuspend(struct dm_target *ti)
 
 static void dm_integrity_resume(struct dm_target *ti)
 {
-	struct dm_integrity_c *ic = (struct dm_integrity_c *)ti->private;
+	struct dm_integrity_c *ic = ti->private;
 	__u64 old_provided_data_sectors = le64_to_cpu(ic->sb->provided_data_sectors);
 	int r;
 
@@ -3290,7 +3290,7 @@ static void dm_integrity_resume(struct dm_target *ti)
 static void dm_integrity_status(struct dm_target *ti, status_type_t type,
 				unsigned int status_flags, char *result, unsigned int maxlen)
 {
-	struct dm_integrity_c *ic = (struct dm_integrity_c *)ti->private;
+	struct dm_integrity_c *ic = ti->private;
 	unsigned int arg_count;
 	size_t sz = 0;
 
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index dc2df76999b0..f053ce245814 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -187,7 +187,7 @@ static void list_get_page(struct dpages *dp,
 		  struct page **p, unsigned long *len, unsigned int *offset)
 {
 	unsigned int o = dp->context_u;
-	struct page_list *pl = (struct page_list *) dp->context_ptr;
+	struct page_list *pl = dp->context_ptr;
 
 	*p = pl->page;
 	*len = PAGE_SIZE - o;
@@ -196,7 +196,7 @@ static void list_get_page(struct dpages *dp,
 
 static void list_next_page(struct dpages *dp)
 {
-	struct page_list *pl = (struct page_list *) dp->context_ptr;
+	struct page_list *pl = dp->context_ptr;
 
 	dp->context_ptr = pl->next;
 	dp->context_u = 0;
diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index a158c6e5fbd7..d01807c50f20 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -519,7 +519,7 @@ static int run_complete_job(struct kcopyd_job *job)
 
 static void complete_io(unsigned long error, void *context)
 {
-	struct kcopyd_job *job = (struct kcopyd_job *) context;
+	struct kcopyd_job *job = context;
 	struct dm_kcopyd_client *kc = job->kc;
 
 	io_job_finish(kc->throttle);
@@ -696,7 +696,7 @@ static void segment_complete(int read_err, unsigned long write_err,
 	/* FIXME: tidy this function */
 	sector_t progress = 0;
 	sector_t count = 0;
-	struct kcopyd_job *sub_job = (struct kcopyd_job *) context;
+	struct kcopyd_job *sub_job = context;
 	struct kcopyd_job *job = sub_job->master_job;
 	struct dm_kcopyd_client *kc = job->kc;
 
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3e622dcc9dbd..f4448d520ee9 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -72,7 +72,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 static void linear_dtr(struct dm_target *ti)
 {
-	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct linear_c *lc = ti->private;
 
 	dm_put_device(ti, lc->dev);
 	kfree(lc);
@@ -98,7 +98,7 @@ static int linear_map(struct dm_target *ti, struct bio *bio)
 static void linear_status(struct dm_target *ti, status_type_t type,
 			  unsigned int status_flags, char *result, unsigned int maxlen)
 {
-	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct linear_c *lc = ti->private;
 	size_t sz = 0;
 
 	switch (type) {
@@ -120,7 +120,7 @@ static void linear_status(struct dm_target *ti, status_type_t type,
 
 static int linear_prepare_ioctl(struct dm_target *ti, struct block_device **bdev)
 {
-	struct linear_c *lc = (struct linear_c *) ti->private;
+	struct linear_c *lc = ti->private;
 	struct dm_dev *dev = lc->dev;
 
 	*bdev = dev->bdev;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index cbd0f81f4a35..eba9c5c869aa 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -429,7 +429,7 @@ static inline sector_t logdev_last_sector(struct log_writes_c *lc)
 
 static int log_writes_kthread(void *arg)
 {
-	struct log_writes_c *lc = (struct log_writes_c *)arg;
+	struct log_writes_c *lc = arg;
 	sector_t sector = 0;
 
 	while (!kthread_should_stop()) {
diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index afd94d2e7295..f9f84236dfcd 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -530,7 +530,7 @@ static void destroy_log_context(struct log_c *lc)
 
 static void core_dtr(struct dm_dirty_log *log)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	vfree(lc->clean_bits);
 	destroy_log_context(lc);
@@ -569,7 +569,7 @@ static int disk_ctr(struct dm_dirty_log *log, struct dm_target *ti,
 
 static void disk_dtr(struct dm_dirty_log *log)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	dm_put_device(lc->ti, lc->log_dev);
 	vfree(lc->disk_header);
@@ -590,7 +590,7 @@ static int disk_resume(struct dm_dirty_log *log)
 {
 	int r;
 	unsigned int i;
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 	size_t size = lc->bitset_uint32_count * sizeof(uint32_t);
 
 	/* read the disk header */
@@ -652,14 +652,14 @@ static int disk_resume(struct dm_dirty_log *log)
 
 static uint32_t core_get_region_size(struct dm_dirty_log *log)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	return lc->region_size;
 }
 
 static int core_resume(struct dm_dirty_log *log)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	lc->sync_search = 0;
 	return 0;
@@ -667,14 +667,14 @@ static int core_resume(struct dm_dirty_log *log)
 
 static int core_is_clean(struct dm_dirty_log *log, region_t region)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	return log_test_bit(lc->clean_bits, region);
 }
 
 static int core_in_sync(struct dm_dirty_log *log, region_t region, int block)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	return log_test_bit(lc->sync_bits, region);
 }
@@ -727,14 +727,14 @@ static int disk_flush(struct dm_dirty_log *log)
 
 static void core_mark_region(struct dm_dirty_log *log, region_t region)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	log_clear_bit(lc, lc->clean_bits, region);
 }
 
 static void core_clear_region(struct dm_dirty_log *log, region_t region)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	if (likely(!lc->flush_failed))
 		log_set_bit(lc, lc->clean_bits, region);
@@ -742,7 +742,7 @@ static void core_clear_region(struct dm_dirty_log *log, region_t region)
 
 static int core_get_resync_work(struct dm_dirty_log *log, region_t *region)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	if (lc->sync_search >= lc->region_count)
 		return 0;
@@ -765,7 +765,7 @@ static int core_get_resync_work(struct dm_dirty_log *log, region_t *region)
 static void core_set_region_sync(struct dm_dirty_log *log, region_t region,
 				 int in_sync)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	log_clear_bit(lc, lc->recovering_bits, region);
 	if (in_sync) {
@@ -779,7 +779,7 @@ static void core_set_region_sync(struct dm_dirty_log *log, region_t region,
 
 static region_t core_get_sync_count(struct dm_dirty_log *log)
 {
-	struct log_c *lc = (struct log_c *) log->context;
+	struct log_c *lc = log->context;
 
 	return lc->sync_count;
 }
diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index bc417a5e5b89..83c7cbb1107b 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -604,7 +604,7 @@ static void do_reads(struct mirror_set *ms, struct bio_list *reads)
 static void write_callback(unsigned long error, void *context)
 {
 	unsigned int i;
-	struct bio *bio = (struct bio *) context;
+	struct bio *bio = context;
 	struct mirror_set *ms;
 	int should_wake = 0;
 	unsigned long flags;
@@ -1180,7 +1180,7 @@ static int mirror_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 static void mirror_dtr(struct dm_target *ti)
 {
-	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct mirror_set *ms = ti->private;
 
 	del_timer_sync(&ms->timer);
 	flush_workqueue(ms->kmirrord_wq);
@@ -1246,7 +1246,7 @@ static int mirror_end_io(struct dm_target *ti, struct bio *bio,
 		blk_status_t *error)
 {
 	int rw = bio_data_dir(bio);
-	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct mirror_set *ms = ti->private;
 	struct mirror *m = NULL;
 	struct dm_bio_details *bd = NULL;
 	struct dm_raid1_bio_record *bio_record =
@@ -1311,7 +1311,7 @@ static int mirror_end_io(struct dm_target *ti, struct bio *bio,
 
 static void mirror_presuspend(struct dm_target *ti)
 {
-	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct mirror_set *ms = ti->private;
 	struct dm_dirty_log *log = dm_rh_dirty_log(ms->rh);
 
 	struct bio_list holds;
@@ -1407,7 +1407,7 @@ static void mirror_status(struct dm_target *ti, status_type_t type,
 {
 	unsigned int m, sz = 0;
 	int num_feature_args = 0;
-	struct mirror_set *ms = (struct mirror_set *) ti->private;
+	struct mirror_set *ms = ti->private;
 	struct dm_dirty_log *log = dm_rh_dirty_log(ms->rh);
 	char buffer[MAX_NR_MIRRORS + 1];
 
diff --git a/drivers/md/dm-snap-persistent.c b/drivers/md/dm-snap-persistent.c
index f14e5df27874..15649921f2a9 100644
--- a/drivers/md/dm-snap-persistent.c
+++ b/drivers/md/dm-snap-persistent.c
@@ -567,7 +567,7 @@ static int read_exceptions(struct pstore *ps,
 
 static struct pstore *get_info(struct dm_exception_store *store)
 {
-	return (struct pstore *) store->context;
+	return store->context;
 }
 
 static void persistent_usage(struct dm_exception_store *store,
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 8d6951157106..e2854a3cbd28 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -189,7 +189,7 @@ static int stripe_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 static void stripe_dtr(struct dm_target *ti)
 {
 	unsigned int i;
-	struct stripe_c *sc = (struct stripe_c *) ti->private;
+	struct stripe_c *sc = ti->private;
 
 	for (i = 0; i < sc->stripes; i++)
 		dm_put_device(ti, sc->stripe[i].dev);
@@ -360,7 +360,7 @@ static size_t stripe_dax_recovery_write(struct dm_target *ti, pgoff_t pgoff,
 static void stripe_status(struct dm_target *ti, status_type_t type,
 			  unsigned int status_flags, char *result, unsigned int maxlen)
 {
-	struct stripe_c *sc = (struct stripe_c *) ti->private;
+	struct stripe_c *sc = ti->private;
 	unsigned int sz = 0;
 	unsigned int i;
 
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 962fc32c947c..a9ee2faa75a2 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -567,14 +567,14 @@ void verity_fec_dtr(struct dm_verity *v)
 
 static void *fec_rs_alloc(gfp_t gfp_mask, void *pool_data)
 {
-	struct dm_verity *v = (struct dm_verity *)pool_data;
+	struct dm_verity *v = pool_data;
 
 	return init_rs_gfp(8, 0x11d, 0, 1, v->fec->roots, gfp_mask);
 }
 
 static void fec_rs_free(void *element, void *pool_data)
 {
-	struct rs_control *rs = (struct rs_control *)element;
+	struct rs_control *rs = element;
 
 	if (rs)
 		free_rs(rs);
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index cf9402064aba..8f0896a6990b 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1701,7 +1701,7 @@ static int dmz_load_mapping(struct dmz_metadata *zmd)
 			if (IS_ERR(dmap_mblk))
 				return PTR_ERR(dmap_mblk);
 			zmd->map_mblk[i] = dmap_mblk;
-			dmap = (struct dmz_map *) dmap_mblk->data;
+			dmap = dmap_mblk->data;
 			i++;
 			e = 0;
 		}
@@ -1832,7 +1832,7 @@ static void dmz_set_chunk_mapping(struct dmz_metadata *zmd, unsigned int chunk,
 				  unsigned int dzone_id, unsigned int bzone_id)
 {
 	struct dmz_mblock *dmap_mblk = zmd->map_mblk[chunk >> DMZ_MAP_ENTRIES_SHIFT];
-	struct dmz_map *dmap = (struct dmz_map *) dmap_mblk->data;
+	struct dmz_map *dmap = dmap_mblk->data;
 	int map_idx = chunk & DMZ_MAP_ENTRIES_MASK;
 
 	dmap[map_idx].dzone_id = cpu_to_le32(dzone_id);
@@ -2045,7 +2045,7 @@ struct dm_zone *dmz_get_chunk_mapping(struct dmz_metadata *zmd,
 				      unsigned int chunk, enum req_op op)
 {
 	struct dmz_mblock *dmap_mblk = zmd->map_mblk[chunk >> DMZ_MAP_ENTRIES_SHIFT];
-	struct dmz_map *dmap = (struct dmz_map *) dmap_mblk->data;
+	struct dmz_map *dmap = dmap_mblk->data;
 	int dmap_idx = chunk & DMZ_MAP_ENTRIES_MASK;
 	unsigned int dzone_id;
 	struct dm_zone *dzone = NULL;
-- 
2.11.0

