Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4156B4D92
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCJQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCJQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4512DC24;
        Fri, 10 Mar 2023 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466835; x=1710002835;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=KX/iTmcBpaIAoIjv9JTMuJvuGPr3lnqVnA+65OUxKf4=;
  b=bVH+avfnThZB1SixpCLv0TvYvx0fPqU18DnA00uVq2/FMq9hLuF3CRWC
   hv5XQgGyR02uVrH2BrSKXp/9y8diyKSrk3RfRyGGNX359JRh1WEGjttlO
   gTLUzbGz59tGJp4dfFO5hmlL2jFNC3q8d2z5ZDQoSOZdWJ7uAizEFvrUD
   Md9nwqa5oZ/BzoV7SjDIjSp7vwDjCnUr+fYkN68DmphxAQGMgOpaNCG07
   r2hT91A6w13501KtRKdItstAnYut8NtmbJIyPc423wD5qsKp7HF+o5Mn1
   iNu26m1jjHDAizi4jtKTSBOfNuaUPqjxJ3bklBLxJeXTDS95+ePAh28Xs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621136"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778624"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778624"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1041794; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] pktcdvd: Get rid of custom printing macros
Date:   Fri, 10 Mar 2023 18:45:41 +0200
Message-Id: <20230310164549.22133-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
References: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may use traditional dev_*() macros instead of custom ones
provided by the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c      | 247 ++++++++++++++++++-----------------
 include/linux/pktcdvd.h      |   1 -
 include/uapi/linux/pktcdvd.h |   1 +
 3 files changed, 130 insertions(+), 119 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 2f1a92509271..0ec8dc8ee5ed 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -72,22 +72,6 @@
 
 #define DRIVER_NAME	"pktcdvd"
 
-#define pkt_err(pd, fmt, ...)						\
-	pr_err("%s: " fmt, pd->name, ##__VA_ARGS__)
-#define pkt_notice(pd, fmt, ...)					\
-	pr_notice("%s: " fmt, pd->name, ##__VA_ARGS__)
-#define pkt_info(pd, fmt, ...)						\
-	pr_info("%s: " fmt, pd->name, ##__VA_ARGS__)
-
-#define pkt_dbg(level, pd, fmt, ...)					\
-do {									\
-	if (level == 2 && PACKET_DEBUG >= 2)				\
-		pr_notice("%s: %s():" fmt,				\
-			  pd->name, __func__, ##__VA_ARGS__);		\
-	else if (level == 1 && PACKET_DEBUG >= 1)			\
-		pr_notice("%s: " fmt, pd->name, ##__VA_ARGS__);		\
-} while (0)
-
 #define MAX_SPEED 0xffff
 
 static DEFINE_MUTEX(pktcdvd_mutex);
@@ -318,7 +302,7 @@ static void pkt_sysfs_dev_new(struct pktcdvd_device *pd)
 	if (class_pktcdvd) {
 		pd->dev = device_create_with_groups(class_pktcdvd, NULL,
 						    MKDEV(0, 0), pd, pkt_groups,
-						    "%s", pd->name);
+						    "%s", pd->disk->disk_name);
 		if (IS_ERR(pd->dev))
 			pd->dev = NULL;
 	}
@@ -354,7 +338,7 @@ static ssize_t device_map_show(struct class *c, struct class_attribute *attr,
 		if (!pd)
 			continue;
 		n += sprintf(data+n, "%s %u:%u %u:%u\n",
-			pd->name,
+			pd->disk->disk_name,
 			MAJOR(pd->pkt_dev), MINOR(pd->pkt_dev),
 			MAJOR(pd->bdev->bd_dev),
 			MINOR(pd->bdev->bd_dev));
@@ -467,7 +451,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 {
 	if (!pkt_debugfs_root)
 		return;
-	pd->dfs_d_root = debugfs_create_dir(pd->name, pkt_debugfs_root);
+	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
 	if (!pd->dfs_d_root)
 		return;
 
@@ -501,9 +485,11 @@ static void pkt_debugfs_cleanup(void)
 
 static void pkt_bio_finished(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
+
 	BUG_ON(atomic_read(&pd->cdrw.pending_bios) <= 0);
 	if (atomic_dec_and_test(&pd->cdrw.pending_bios)) {
-		pkt_dbg(2, pd, "queue empty\n");
+		dev_dbg(ddev, "queue empty\n");
 		atomic_set(&pd->iosched.attention, 1);
 		wake_up(&pd->wqueue);
 	}
@@ -734,15 +720,16 @@ static const char *sense_key_string(__u8 index)
 static void pkt_dump_sense(struct pktcdvd_device *pd,
 			   struct packet_command *cgc)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct scsi_sense_hdr *sshdr = cgc->sshdr;
 
 	if (sshdr)
-		pkt_err(pd, "%*ph - sense %02x.%02x.%02x (%s)\n",
+		dev_err(ddev, "%*ph - sense %02x.%02x.%02x (%s)\n",
 			CDROM_PACKET_SIZE, cgc->cmd,
 			sshdr->sense_key, sshdr->asc, sshdr->ascq,
 			sense_key_string(sshdr->sense_key));
 	else
-		pkt_err(pd, "%*ph - no sense\n", CDROM_PACKET_SIZE, cgc->cmd);
+		dev_err(ddev, "%*ph - no sense\n", CDROM_PACKET_SIZE, cgc->cmd);
 }
 
 /*
@@ -826,6 +813,7 @@ static void pkt_queue_bio(struct pktcdvd_device *pd, struct bio *bio)
  */
 static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 
 	if (atomic_read(&pd->iosched.attention) == 0)
 		return;
@@ -853,7 +841,7 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 				need_write_seek = 0;
 			if (need_write_seek && reads_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					pkt_dbg(2, pd, "write, waiting\n");
+					dev_dbg(ddev, "write, waiting\n");
 					break;
 				}
 				pkt_flush_cache(pd);
@@ -862,7 +850,7 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
 		} else {
 			if (!reads_queued && writes_queued) {
 				if (atomic_read(&pd->cdrw.pending_bios) > 0) {
-					pkt_dbg(2, pd, "read, waiting\n");
+					dev_dbg(ddev, "read, waiting\n");
 					break;
 				}
 				pd->iosched.writing = 1;
@@ -909,6 +897,8 @@ static void pkt_iosched_process_queue(struct pktcdvd_device *pd)
  */
 static int pkt_set_segment_merging(struct pktcdvd_device *pd, struct request_queue *q)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
+
 	if ((pd->settings.size << 9) / CD_FRAMESIZE
 	    <= queue_max_segments(q)) {
 		/*
@@ -925,7 +915,7 @@ static int pkt_set_segment_merging(struct pktcdvd_device *pd, struct request_que
 		set_bit(PACKET_MERGE_SEGS, &pd->flags);
 		return 0;
 	} else {
-		pkt_err(pd, "cdrom max_phys_segments too small\n");
+		dev_err(ddev, "cdrom max_phys_segments too small\n");
 		return -EIO;
 	}
 }
@@ -936,7 +926,7 @@ static void pkt_end_io_read(struct bio *bio)
 	struct pktcdvd_device *pd = pkt->pd;
 	BUG_ON(!pd);
 
-	pkt_dbg(2, pd, "bio=%p sec0=%llx sec=%llx err=%d\n",
+	dev_dbg(disk_to_dev(pd->disk), "bio=%p sec0=%llx sec=%llx err=%d\n",
 		bio, (unsigned long long)pkt->sector,
 		(unsigned long long)bio->bi_iter.bi_sector, bio->bi_status);
 
@@ -956,7 +946,7 @@ static void pkt_end_io_packet_write(struct bio *bio)
 	struct pktcdvd_device *pd = pkt->pd;
 	BUG_ON(!pd);
 
-	pkt_dbg(2, pd, "id=%d, err=%d\n", pkt->id, bio->bi_status);
+	dev_dbg(disk_to_dev(pd->disk), "id=%d, err=%d\n", pkt->id, bio->bi_status);
 
 	pd->stats.pkt_ended++;
 
@@ -972,6 +962,7 @@ static void pkt_end_io_packet_write(struct bio *bio)
  */
 static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	int frames_read = 0;
 	struct bio *bio;
 	int f;
@@ -1000,8 +991,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	spin_unlock(&pkt->lock);
 
 	if (pkt->cache_valid) {
-		pkt_dbg(2, pd, "zone %llx cached\n",
-			(unsigned long long)pkt->sector);
+		dev_dbg(ddev, "zone %llx cached\n", (unsigned long long)pkt->sector);
 		goto out_account;
 	}
 
@@ -1022,8 +1012,8 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 
 		p = (f * CD_FRAMESIZE) / PAGE_SIZE;
 		offset = (f * CD_FRAMESIZE) % PAGE_SIZE;
-		pkt_dbg(2, pd, "Adding frame %d, page:%p offs:%d\n",
-			f, pkt->pages[p], offset);
+		dev_dbg(ddev, "Adding frame %d, page:%p offs:%d\n", f,
+			pkt->pages[p], offset);
 		if (!bio_add_page(bio, pkt->pages[p], CD_FRAMESIZE, offset))
 			BUG();
 
@@ -1033,8 +1023,8 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	}
 
 out_account:
-	pkt_dbg(2, pd, "need %d frames for zone %llx\n",
-		frames_read, (unsigned long long)pkt->sector);
+	dev_dbg(ddev, "need %d frames for zone %llx\n", frames_read,
+		(unsigned long long)pkt->sector);
 	pd->stats.pkt_started++;
 	pd->stats.secs_rg += frames_read * (CD_FRAMESIZE >> 9);
 }
@@ -1068,17 +1058,18 @@ static void pkt_put_packet_data(struct pktcdvd_device *pd, struct packet_data *p
 	}
 }
 
-static inline void pkt_set_state(struct packet_data *pkt, enum packet_data_state state)
+static inline void pkt_set_state(struct device *ddev, struct packet_data *pkt,
+				 enum packet_data_state state)
 {
-#if PACKET_DEBUG > 1
 	static const char *state_name[] = {
 		"IDLE", "WAITING", "READ_WAIT", "WRITE_WAIT", "RECOVERY", "FINISHED"
 	};
 	enum packet_data_state old_state = pkt->state;
-	pkt_dbg(2, pd, "pkt %2d : s=%6llx %s -> %s\n",
+
+	dev_dbg(ddev, "pkt %2d : s=%6llx %s -> %s\n",
 		pkt->id, (unsigned long long)pkt->sector,
 		state_name[old_state], state_name[state]);
-#endif
+
 	pkt->state = state;
 }
 
@@ -1088,6 +1079,7 @@ static inline void pkt_set_state(struct packet_data *pkt, enum packet_data_state
  */
 static int pkt_handle_queue(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_data *pkt, *p;
 	struct bio *bio = NULL;
 	sector_t zone = 0; /* Suppress gcc warning */
@@ -1097,7 +1089,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	atomic_set(&pd->scan_queue, 0);
 
 	if (list_empty(&pd->cdrw.pkt_free_list)) {
-		pkt_dbg(2, pd, "no pkt\n");
+		dev_dbg(ddev, "no pkt\n");
 		return 0;
 	}
 
@@ -1134,7 +1126,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	}
 	spin_unlock(&pd->lock);
 	if (!bio) {
-		pkt_dbg(2, pd, "no bio\n");
+		dev_dbg(ddev, "no bio\n");
 		return 0;
 	}
 
@@ -1150,12 +1142,13 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	 * to this packet.
 	 */
 	spin_lock(&pd->lock);
-	pkt_dbg(2, pd, "looking for zone %llx\n", (unsigned long long)zone);
+	dev_dbg(ddev, "looking for zone %llx\n", (unsigned long long)zone);
 	while ((node = pkt_rbtree_find(pd, zone)) != NULL) {
+		sector_t tmp = get_zone(node->bio->bi_iter.bi_sector, pd);
+
 		bio = node->bio;
-		pkt_dbg(2, pd, "found zone=%llx\n", (unsigned long long)
-			get_zone(bio->bi_iter.bi_sector, pd));
-		if (get_zone(bio->bi_iter.bi_sector, pd) != zone)
+		dev_dbg(ddev, "found zone=%llx\n", (unsigned long long)tmp);
+		if (tmp != zone)
 			break;
 		pkt_rbtree_erase(pd, node);
 		spin_lock(&pkt->lock);
@@ -1174,7 +1167,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	spin_unlock(&pd->lock);
 
 	pkt->sleep_time = max(PACKET_WAIT_TIME, 1);
-	pkt_set_state(pkt, PACKET_WAITING_STATE);
+	pkt_set_state(ddev, pkt, PACKET_WAITING_STATE);
 	atomic_set(&pkt->run_sm, 1);
 
 	spin_lock(&pd->cdrw.active_list_lock);
@@ -1226,6 +1219,7 @@ static void bio_list_copy_data(struct bio *dst, struct bio *src)
  */
 static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	int f;
 
 	bio_init(pkt->w_bio, pd->bdev, pkt->w_bio->bi_inline_vecs, pkt->frames,
@@ -1242,7 +1236,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 		if (!bio_add_page(pkt->w_bio, page, CD_FRAMESIZE, offset))
 			BUG();
 	}
-	pkt_dbg(2, pd, "vcnt=%d\n", pkt->w_bio->bi_vcnt);
+	dev_dbg(ddev, "vcnt=%d\n", pkt->w_bio->bi_vcnt);
 
 	/*
 	 * Fill-in bvec with data from orig_bios.
@@ -1250,11 +1244,11 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	spin_lock(&pkt->lock);
 	bio_list_copy_data(pkt->w_bio, pkt->orig_bios.head);
 
-	pkt_set_state(pkt, PACKET_WRITE_WAIT_STATE);
+	pkt_set_state(ddev, pkt, PACKET_WRITE_WAIT_STATE);
 	spin_unlock(&pkt->lock);
 
-	pkt_dbg(2, pd, "Writing %d frames for zone %llx\n",
-		pkt->write_size, (unsigned long long)pkt->sector);
+	dev_dbg(ddev, "Writing %d frames for zone %llx\n", pkt->write_size,
+		(unsigned long long)pkt->sector);
 
 	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames))
 		pkt->cache_valid = 1;
@@ -1282,7 +1276,9 @@ static void pkt_finish_packet(struct packet_data *pkt, blk_status_t status)
 
 static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
-	pkt_dbg(2, pd, "pkt %d\n", pkt->id);
+	struct device *ddev = disk_to_dev(pd->disk);
+
+	dev_dbg(ddev, "pkt %d\n", pkt->id);
 
 	for (;;) {
 		switch (pkt->state) {
@@ -1292,7 +1288,7 @@ static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data
 
 			pkt->sleep_time = 0;
 			pkt_gather_data(pd, pkt);
-			pkt_set_state(pkt, PACKET_READ_WAIT_STATE);
+			pkt_set_state(ddev, pkt, PACKET_READ_WAIT_STATE);
 			break;
 
 		case PACKET_READ_WAIT_STATE:
@@ -1300,7 +1296,7 @@ static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data
 				return;
 
 			if (atomic_read(&pkt->io_errors) > 0) {
-				pkt_set_state(pkt, PACKET_RECOVERY_STATE);
+				pkt_set_state(ddev, pkt, PACKET_RECOVERY_STATE);
 			} else {
 				pkt_start_write(pd, pkt);
 			}
@@ -1311,15 +1307,15 @@ static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data
 				return;
 
 			if (!pkt->w_bio->bi_status) {
-				pkt_set_state(pkt, PACKET_FINISHED_STATE);
+				pkt_set_state(ddev, pkt, PACKET_FINISHED_STATE);
 			} else {
-				pkt_set_state(pkt, PACKET_RECOVERY_STATE);
+				pkt_set_state(ddev, pkt, PACKET_RECOVERY_STATE);
 			}
 			break;
 
 		case PACKET_RECOVERY_STATE:
-			pkt_dbg(2, pd, "No recovery possible\n");
-			pkt_set_state(pkt, PACKET_FINISHED_STATE);
+			dev_dbg(ddev, "No recovery possible\n");
+			pkt_set_state(ddev, pkt, PACKET_FINISHED_STATE);
 			break;
 
 		case PACKET_FINISHED_STATE:
@@ -1335,6 +1331,7 @@ static void pkt_run_state_machine(struct pktcdvd_device *pd, struct packet_data
 
 static void pkt_handle_packets(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_data *pkt, *next;
 
 	/*
@@ -1355,7 +1352,7 @@ static void pkt_handle_packets(struct pktcdvd_device *pd)
 		if (pkt->state == PACKET_FINISHED_STATE) {
 			list_del(&pkt->list);
 			pkt_put_packet_data(pd, pkt);
-			pkt_set_state(pkt, PACKET_IDLE_STATE);
+			pkt_set_state(ddev, pkt, PACKET_IDLE_STATE);
 			atomic_set(&pd->scan_queue, 1);
 		}
 	}
@@ -1384,7 +1381,9 @@ static void pkt_count_states(struct pktcdvd_device *pd, int *states)
 static int kcdrwd(void *foobar)
 {
 	struct pktcdvd_device *pd = foobar;
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_data *pkt;
+	int states[PACKET_NUM_STATES];
 	long min_sleep_time, residue;
 
 	set_user_nice(current, MIN_NICE);
@@ -1415,13 +1414,9 @@ static int kcdrwd(void *foobar)
 				goto work_to_do;
 
 			/* Otherwise, go to sleep */
-			if (PACKET_DEBUG > 1) {
-				int states[PACKET_NUM_STATES];
-				pkt_count_states(pd, states);
-				pkt_dbg(2, pd, "i:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
-					states[0], states[1], states[2],
-					states[3], states[4], states[5]);
-			}
+			pkt_count_states(pd, states);
+			dev_dbg(ddev, "i:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+				states[0], states[1], states[2], states[3], states[4], states[5]);
 
 			min_sleep_time = MAX_SCHEDULE_TIMEOUT;
 			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
@@ -1429,9 +1424,9 @@ static int kcdrwd(void *foobar)
 					min_sleep_time = pkt->sleep_time;
 			}
 
-			pkt_dbg(2, pd, "sleeping\n");
+			dev_dbg(ddev, "sleeping\n");
 			residue = schedule_timeout(min_sleep_time);
-			pkt_dbg(2, pd, "wake up\n");
+			dev_dbg(ddev, "wake up\n");
 
 			/* make swsusp happy with our thread */
 			try_to_freeze();
@@ -1479,7 +1474,7 @@ static int kcdrwd(void *foobar)
 
 static void pkt_print_settings(struct pktcdvd_device *pd)
 {
-	pkt_info(pd, "%s packets, %u blocks, Mode-%c disc\n",
+	dev_info(disk_to_dev(pd->disk), "%s packets, %u blocks, Mode-%c disc\n",
 		 pd->settings.fp ? "Fixed" : "Variable",
 		 pd->settings.size >> 2,
 		 pd->settings.block_mode == 8 ? '1' : '2');
@@ -1607,6 +1602,7 @@ static noinline_for_stack int pkt_get_last_written(struct pktcdvd_device *pd,
  */
 static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_command cgc;
 	struct scsi_sense_hdr sshdr;
 	write_param_page *wp;
@@ -1673,7 +1669,7 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
 		/*
 		 * paranoia
 		 */
-		pkt_err(pd, "write mode wrong %d\n", wp->data_block_type);
+		dev_err(ddev, "write mode wrong %d\n", wp->data_block_type);
 		return 1;
 	}
 	wp->packet_size = cpu_to_be32(pd->settings.size >> 2);
@@ -1694,6 +1690,8 @@ static noinline_for_stack int pkt_set_write_settings(struct pktcdvd_device *pd)
  */
 static int pkt_writable_track(struct pktcdvd_device *pd, track_information *ti)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
+
 	switch (pd->mmc3_profile) {
 		case 0x1a: /* DVD+RW */
 		case 0x12: /* DVD-RAM */
@@ -1718,7 +1716,7 @@ static int pkt_writable_track(struct pktcdvd_device *pd, track_information *ti)
 	if (ti->rt == 1 && ti->blank == 0)
 		return 1;
 
-	pkt_err(pd, "bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
+	dev_err(ddev, "bad state %d-%d-%d\n", ti->rt, ti->blank, ti->packet);
 	return 0;
 }
 
@@ -1727,6 +1725,8 @@ static int pkt_writable_track(struct pktcdvd_device *pd, track_information *ti)
  */
 static int pkt_writable_disc(struct pktcdvd_device *pd, disc_information *di)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
+
 	switch (pd->mmc3_profile) {
 		case 0x0a: /* CD-RW */
 		case 0xffff: /* MMC3 not supported */
@@ -1736,8 +1736,7 @@ static int pkt_writable_disc(struct pktcdvd_device *pd, disc_information *di)
 		case 0x12: /* DVD-RAM */
 			return 1;
 		default:
-			pkt_dbg(2, pd, "Wrong disc profile (%x)\n",
-				pd->mmc3_profile);
+			dev_dbg(ddev, "Wrong disc profile (%x)\n", pd->mmc3_profile);
 			return 0;
 	}
 
@@ -1746,22 +1745,22 @@ static int pkt_writable_disc(struct pktcdvd_device *pd, disc_information *di)
 	 * but i'm not sure, should we leave this to user apps? probably.
 	 */
 	if (di->disc_type == 0xff) {
-		pkt_notice(pd, "unknown disc - no track?\n");
+		dev_notice(ddev, "unknown disc - no track?\n");
 		return 0;
 	}
 
 	if (di->disc_type != 0x20 && di->disc_type != 0) {
-		pkt_err(pd, "wrong disc type (%x)\n", di->disc_type);
+		dev_err(ddev, "wrong disc type (%x)\n", di->disc_type);
 		return 0;
 	}
 
 	if (di->erasable == 0) {
-		pkt_notice(pd, "disc not erasable\n");
+		dev_err(ddev, "disc not erasable\n");
 		return 0;
 	}
 
 	if (di->border_status == PACKET_SESSION_RESERVED) {
-		pkt_err(pd, "can't write to last track (reserved)\n");
+		dev_err(ddev, "can't write to last track (reserved)\n");
 		return 0;
 	}
 
@@ -1770,6 +1769,7 @@ static int pkt_writable_disc(struct pktcdvd_device *pd, disc_information *di)
 
 static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_command cgc;
 	unsigned char buf[12];
 	disc_information di;
@@ -1787,7 +1787,7 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 
 	ret = pkt_get_disc_info(pd, &di);
 	if (ret) {
-		pkt_err(pd, "failed get_disc\n");
+		dev_err(ddev, "failed get_disc\n");
 		return ret;
 	}
 
@@ -1799,12 +1799,12 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 	track = 1; /* (di.last_track_msb << 8) | di.last_track_lsb; */
 	ret = pkt_get_track_info(pd, track, 1, &ti);
 	if (ret) {
-		pkt_err(pd, "failed get_track\n");
+		dev_err(ddev, "failed get_track\n");
 		return ret;
 	}
 
 	if (!pkt_writable_track(pd, &ti)) {
-		pkt_err(pd, "can't write to this track\n");
+		dev_err(ddev, "can't write to this track\n");
 		return -EROFS;
 	}
 
@@ -1814,11 +1814,11 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 	 */
 	pd->settings.size = be32_to_cpu(ti.fixed_packet_size) << 2;
 	if (pd->settings.size == 0) {
-		pkt_notice(pd, "detected zero packet size!\n");
+		dev_notice(ddev, "detected zero packet size!\n");
 		return -ENXIO;
 	}
 	if (pd->settings.size > PACKET_MAX_SECTORS) {
-		pkt_err(pd, "packet size is too big\n");
+		dev_err(ddev, "packet size is too big\n");
 		return -EROFS;
 	}
 	pd->settings.fp = ti.fp;
@@ -1860,7 +1860,7 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 			pd->settings.block_mode = PACKET_BLOCK_MODE2;
 			break;
 		default:
-			pkt_err(pd, "unknown data mode\n");
+			dev_err(ddev, "unknown data mode\n");
 			return -EROFS;
 	}
 	return 0;
@@ -1872,6 +1872,7 @@ static noinline_for_stack int pkt_probe_settings(struct pktcdvd_device *pd)
 static noinline_for_stack int pkt_write_caching(struct pktcdvd_device *pd,
 						int set)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_command cgc;
 	struct scsi_sense_hdr sshdr;
 	unsigned char buf[64];
@@ -1895,10 +1896,10 @@ static noinline_for_stack int pkt_write_caching(struct pktcdvd_device *pd,
 	cgc.buflen = cgc.cmd[8] = 2 + ((buf[0] << 8) | (buf[1] & 0xff));
 	ret = pkt_mode_select(pd, &cgc);
 	if (ret) {
-		pkt_err(pd, "write caching control failed\n");
+		dev_err(ddev, "write caching control failed\n");
 		pkt_dump_sense(pd, &cgc);
 	} else if (!ret && set)
-		pkt_notice(pd, "enabled write caching\n");
+		dev_notice(ddev, "enabled write caching\n");
 	return ret;
 }
 
@@ -1979,6 +1980,7 @@ static char us_clv_to_speed[16] = {
 static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 						unsigned *speed)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_command cgc;
 	struct scsi_sense_hdr sshdr;
 	unsigned char buf[64];
@@ -2013,11 +2015,11 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 	}
 
 	if (!(buf[6] & 0x40)) {
-		pkt_notice(pd, "disc type is not CD-RW\n");
+		dev_notice(ddev, "disc type is not CD-RW\n");
 		return 1;
 	}
 	if (!(buf[6] & 0x4)) {
-		pkt_notice(pd, "A1 values on media are not valid, maybe not CDRW?\n");
+		dev_notice(ddev, "A1 values on media are not valid, maybe not CDRW?\n");
 		return 1;
 	}
 
@@ -2037,25 +2039,26 @@ static noinline_for_stack int pkt_media_speed(struct pktcdvd_device *pd,
 			*speed = us_clv_to_speed[sp];
 			break;
 		default:
-			pkt_notice(pd, "unknown disc sub-type %d\n", st);
+			dev_notice(ddev, "unknown disc sub-type %d\n", st);
 			return 1;
 	}
 	if (*speed) {
-		pkt_info(pd, "maximum media speed: %d\n", *speed);
+		dev_info(ddev, "maximum media speed: %d\n", *speed);
 		return 0;
 	} else {
-		pkt_notice(pd, "unknown speed %d for sub-type %d\n", sp, st);
+		dev_notice(ddev, "unknown speed %d for sub-type %d\n", sp, st);
 		return 1;
 	}
 }
 
 static noinline_for_stack int pkt_perform_opc(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct packet_command cgc;
 	struct scsi_sense_hdr sshdr;
 	int ret;
 
-	pkt_dbg(2, pd, "Performing OPC\n");
+	dev_dbg(ddev, "Performing OPC\n");
 
 	init_cdrom_command(&cgc, NULL, 0, CGC_DATA_NONE);
 	cgc.sshdr = &sshdr;
@@ -2070,18 +2073,19 @@ static noinline_for_stack int pkt_perform_opc(struct pktcdvd_device *pd)
 
 static int pkt_open_write(struct pktcdvd_device *pd)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	int ret;
 	unsigned int write_speed, media_write_speed, read_speed;
 
 	ret = pkt_probe_settings(pd);
 	if (ret) {
-		pkt_dbg(2, pd, "failed probe\n");
+		dev_dbg(ddev, "failed probe\n");
 		return ret;
 	}
 
 	ret = pkt_set_write_settings(pd);
 	if (ret) {
-		pkt_dbg(1, pd, "failed saving write settings\n");
+		dev_notice(ddev, "failed saving write settings\n");
 		return -EIO;
 	}
 
@@ -2094,30 +2098,29 @@ static int pkt_open_write(struct pktcdvd_device *pd)
 		case 0x13: /* DVD-RW */
 		case 0x1a: /* DVD+RW */
 		case 0x12: /* DVD-RAM */
-			pkt_dbg(1, pd, "write speed %ukB/s\n", write_speed);
+			dev_notice(ddev, "write speed %ukB/s\n", write_speed);
 			break;
 		default:
 			ret = pkt_media_speed(pd, &media_write_speed);
 			if (ret)
 				media_write_speed = 16;
 			write_speed = min(write_speed, media_write_speed * 177);
-			pkt_dbg(1, pd, "write speed %ux\n", write_speed / 176);
+			dev_notice(ddev, "write speed %ux\n", write_speed / 176);
 			break;
 	}
 	read_speed = write_speed;
 
 	ret = pkt_set_speed(pd, write_speed, read_speed);
 	if (ret) {
-		pkt_dbg(1, pd, "couldn't set write speed\n");
+		dev_notice(ddev, "couldn't set write speed\n");
 		return -EIO;
 	}
 	pd->write_speed = write_speed;
 	pd->read_speed = read_speed;
 
 	ret = pkt_perform_opc(pd);
-	if (ret) {
-		pkt_dbg(1, pd, "Optimum Power Calibration failed\n");
-	}
+	if (ret)
+		dev_notice(ddev, "Optimum Power Calibration failed\n");
 
 	return 0;
 }
@@ -2127,6 +2130,7 @@ static int pkt_open_write(struct pktcdvd_device *pd)
  */
 static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	int ret;
 	long lba;
 	struct request_queue *q;
@@ -2145,7 +2149,7 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 
 	ret = pkt_get_last_written(pd, &lba);
 	if (ret) {
-		pkt_err(pd, "pkt_get_last_written failed\n");
+		dev_err(ddev, "pkt_get_last_written failed\n");
 		goto out_putdev;
 	}
 
@@ -2174,11 +2178,11 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
 
 	if (write) {
 		if (!pkt_grow_pktlist(pd, CONFIG_CDROM_PKTCDVD_BUFFERS)) {
-			pkt_err(pd, "not enough memory for buffers\n");
+			dev_err(ddev, "not enough memory for buffers\n");
 			ret = -ENOMEM;
 			goto out_putdev;
 		}
-		pkt_info(pd, "%lukB available on disc\n", lba << 1);
+		dev_info(ddev, "%lukB available on disc\n", lba << 1);
 	}
 
 	return 0;
@@ -2195,8 +2199,10 @@ static int pkt_open_dev(struct pktcdvd_device *pd, fmode_t write)
  */
 static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
+
 	if (flush && pkt_flush_cache(pd))
-		pkt_dbg(1, pd, "not flushing cache\n");
+		dev_notice(ddev, "not flushing cache\n");
 
 	pkt_lock_door(pd, 0);
 
@@ -2397,13 +2403,14 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 static void pkt_submit_bio(struct bio *bio)
 {
 	struct pktcdvd_device *pd = bio->bi_bdev->bd_disk->queue->queuedata;
+	struct device *ddev = disk_to_dev(pd->disk);
 	struct bio *split;
 
 	bio = bio_split_to_limits(bio);
 	if (!bio)
 		return;
 
-	pkt_dbg(2, pd, "start = %6llx stop = %6llx\n",
+	dev_dbg(ddev, "start = %6llx stop = %6llx\n",
 		(unsigned long long)bio->bi_iter.bi_sector,
 		(unsigned long long)bio_end_sector(bio));
 
@@ -2416,13 +2423,13 @@ static void pkt_submit_bio(struct bio *bio)
 	}
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
-		pkt_notice(pd, "WRITE for ro device (%llu)\n",
+		dev_notice(ddev, "WRITE for ro device (%llu)\n",
 			   (unsigned long long)bio->bi_iter.bi_sector);
 		goto end_io;
 	}
 
 	if (!bio->bi_iter.bi_size || (bio->bi_iter.bi_size % CD_FRAMESIZE)) {
-		pkt_err(pd, "wrong bio size\n");
+		dev_err(ddev, "wrong bio size\n");
 		goto end_io;
 	}
 
@@ -2464,7 +2471,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 	char *msg;
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %pg:\n", pd->name, pd->bdev);
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name, pd->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -2520,12 +2527,13 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
+	struct device *ddev = disk_to_dev(pd->disk);
 	int i;
 	struct block_device *bdev;
 	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
-		pkt_err(pd, "recursive setup not allowed\n");
+		dev_err(ddev, "recursive setup not allowed\n");
 		return -EBUSY;
 	}
 	for (i = 0; i < MAX_WRITERS; i++) {
@@ -2533,11 +2541,11 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		if (!pd2)
 			continue;
 		if (pd2->bdev->bd_dev == dev) {
-			pkt_err(pd, "%pg already setup\n", pd2->bdev);
+			dev_err(ddev, "%pg already setup\n", pd2->bdev);
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
-			pkt_err(pd, "can't chain pktcdvd devices\n");
+			dev_err(ddev, "can't chain pktcdvd devices\n");
 			return -EBUSY;
 		}
 	}
@@ -2561,14 +2569,14 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	pkt_init_queue(pd);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
-	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
+	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->disk->disk_name);
 	if (IS_ERR(pd->cdrw.thread)) {
-		pkt_err(pd, "can't start kernel thread\n");
+		dev_err(ddev, "can't start kernel thread\n");
 		goto out_mem;
 	}
 
-	proc_create_single_data(pd->name, 0, pkt_proc, pkt_seq_show, pd);
-	pkt_dbg(1, pd, "writer mapped to %pg\n", bdev);
+	proc_create_single_data(pd->disk->disk_name, 0, pkt_proc, pkt_seq_show, pd);
+	dev_notice(ddev, "writer mapped to %pg\n", bdev);
 	return 0;
 
 out_mem:
@@ -2581,10 +2589,10 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
 {
 	struct pktcdvd_device *pd = bdev->bd_disk->private_data;
+	struct device *ddev = disk_to_dev(pd->disk);
 	int ret;
 
-	pkt_dbg(2, pd, "cmd %x, dev %d:%d\n",
-		cmd, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	dev_dbg(ddev, "cmd %x, dev %d:%d\n", cmd, MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
 
 	mutex_lock(&pktcdvd_mutex);
 	switch (cmd) {
@@ -2610,7 +2618,7 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 			ret = bdev->bd_disk->fops->ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-		pkt_dbg(2, pd, "Unknown ioctl (%x)\n", cmd);
+		dev_dbg(ddev, "Unknown ioctl (%x)\n", cmd);
 		ret = -ENOTTY;
 	}
 	mutex_unlock(&pktcdvd_mutex);
@@ -2688,7 +2696,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	spin_lock_init(&pd->iosched.lock);
 	bio_list_init(&pd->iosched.read_queue);
 	bio_list_init(&pd->iosched.write_queue);
-	sprintf(pd->name, DRIVER_NAME"%d", idx);
 	init_waitqueue_head(&pd->wqueue);
 	pd->bio_queue = RB_ROOT;
 
@@ -2705,7 +2712,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->minors = 1;
 	disk->fops = &pktcdvd_ops;
 	disk->flags = GENHD_FL_REMOVABLE | GENHD_FL_NO_PART;
-	strcpy(disk->disk_name, pd->name);
+	snprintf(disk->disk_name, sizeof(disk->disk_name), DRIVER_NAME"%d", idx);
 	disk->private_data = pd;
 
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
@@ -2747,6 +2754,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 static int pkt_remove_dev(dev_t pkt_dev)
 {
 	struct pktcdvd_device *pd;
+	struct device *ddev;
 	int idx;
 	int ret = 0;
 
@@ -2767,6 +2775,9 @@ static int pkt_remove_dev(dev_t pkt_dev)
 		ret = -EBUSY;
 		goto out;
 	}
+
+	ddev = disk_to_dev(pd->disk);
+
 	if (!IS_ERR(pd->cdrw.thread))
 		kthread_stop(pd->cdrw.thread);
 
@@ -2777,8 +2788,8 @@ static int pkt_remove_dev(dev_t pkt_dev)
 
 	blkdev_put(pd->bdev, FMODE_READ | FMODE_NDELAY);
 
-	remove_proc_entry(pd->name, pkt_proc);
-	pkt_dbg(1, pd, "writer unmapped\n");
+	remove_proc_entry(pd->disk->disk_name, pkt_proc);
+	dev_notice(ddev, "writer unmapped\n");
 
 	del_gendisk(pd->disk);
 	put_disk(pd->disk);
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index f9c5ac80d59b..80cb00db42a4 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -156,7 +156,6 @@ struct pktcdvd_device
 {
 	struct block_device	*bdev;		/* dev attached */
 	dev_t			pkt_dev;	/* our dev */
-	char			name[20];
 	struct packet_settings	settings;
 	struct packet_stats	stats;
 	int			refcnt;		/* Open count */
diff --git a/include/uapi/linux/pktcdvd.h b/include/uapi/linux/pktcdvd.h
index 9cbb55d21c94..69121ca7065c 100644
--- a/include/uapi/linux/pktcdvd.h
+++ b/include/uapi/linux/pktcdvd.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 
 /*
+ * UNUSED:
  * 1 for normal debug messages, 2 is very verbose. 0 to turn it off.
  */
 #define PACKET_DEBUG		1
-- 
2.39.1

