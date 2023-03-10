Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959696B4D99
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCJQvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCJQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461FB132A84;
        Fri, 10 Mar 2023 08:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466858; x=1710002858;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+1rJdMqj0UtsYZzwLweMEvMl27Gcr0fBPSk0iIRNRR4=;
  b=D8CFR1LTJ5zUFPFoydQqPeBuNFDb3zVe/r4XGRaHOLhA7d/tbEIPXBSE
   VawS/rPKLLWvpBcRDg6Aod/1S4hQqUCeGMieSr23IQBuKdg9zdfpO0PmD
   0OsY8kwP+6oZ7zGu01RH6TGJLKWuAOwJryH2O/f2bbRTeVZz9b+z4Vff5
   VyIHkL+rJt0xsILQKalJUwHXuheQkYue02KGnenbbcUsubCLqNRe3T9Hw
   y/dy1ajnq3oW4XdfrSVJeuIbWS/sUD/xFIl8+Y0067t7JozgEgcy8IvcK
   HtfXRzP6YKN1xQrCnR6aUlgQ/9H1Okk6hu+eCfB/vclKmYfM2ElRmCZ3y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621144"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621144"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778638"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778638"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 411AE398; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] pktcdvd: Drop redundant castings for sector_t
Date:   Fri, 10 Mar 2023 18:45:45 +0200
Message-Id: <20230310164549.22133-6-andriy.shevchenko@linux.intel.com>
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

Since the commit 72deb455b5ec ("block: remove CONFIG_LBDAF")
the sector_t is always 64-bit type, no need to cast anymore.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 96db6e348e1e..a53d21dbf2ab 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -493,7 +493,7 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 	seq_printf(m, "\nQueue state:\n");
 	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
 	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
-	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
+	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", pd->current_sector);
 
 	pkt_count_states(pd, states);
 	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
@@ -1003,8 +1003,7 @@ static void pkt_end_io_read(struct bio *bio)
 	BUG_ON(!pd);
 
 	dev_dbg(disk_to_dev(pd->disk), "bio=%p sec0=%llx sec=%llx err=%d\n",
-		bio, (unsigned long long)pkt->sector,
-		(unsigned long long)bio->bi_iter.bi_sector, bio->bi_status);
+		bio, pkt->sector, bio->bi_iter.bi_sector, bio->bi_status);
 
 	if (bio->bi_status)
 		atomic_inc(&pkt->io_errors);
@@ -1067,7 +1066,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	spin_unlock(&pkt->lock);
 
 	if (pkt->cache_valid) {
-		dev_dbg(ddev, "zone %llx cached\n", (unsigned long long)pkt->sector);
+		dev_dbg(ddev, "zone %llx cached\n", pkt->sector);
 		goto out_account;
 	}
 
@@ -1099,8 +1098,7 @@ static void pkt_gather_data(struct pktcdvd_device *pd, struct packet_data *pkt)
 	}
 
 out_account:
-	dev_dbg(ddev, "need %d frames for zone %llx\n", frames_read,
-		(unsigned long long)pkt->sector);
+	dev_dbg(ddev, "need %d frames for zone %llx\n", frames_read, pkt->sector);
 	pd->stats.pkt_started++;
 	pd->stats.secs_rg += frames_read * (CD_FRAMESIZE >> 9);
 }
@@ -1143,8 +1141,7 @@ static inline void pkt_set_state(struct device *ddev, struct packet_data *pkt,
 	enum packet_data_state old_state = pkt->state;
 
 	dev_dbg(ddev, "pkt %2d : s=%6llx %s -> %s\n",
-		pkt->id, (unsigned long long)pkt->sector,
-		state_name[old_state], state_name[state]);
+		pkt->id, pkt->sector, state_name[old_state], state_name[state]);
 
 	pkt->state = state;
 }
@@ -1218,12 +1215,12 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	 * to this packet.
 	 */
 	spin_lock(&pd->lock);
-	dev_dbg(ddev, "looking for zone %llx\n", (unsigned long long)zone);
+	dev_dbg(ddev, "looking for zone %llx\n", zone);
 	while ((node = pkt_rbtree_find(pd, zone)) != NULL) {
 		sector_t tmp = get_zone(node->bio->bi_iter.bi_sector, pd);
 
 		bio = node->bio;
-		dev_dbg(ddev, "found zone=%llx\n", (unsigned long long)tmp);
+		dev_dbg(ddev, "found zone=%llx\n", tmp);
 		if (tmp != zone)
 			break;
 		pkt_rbtree_erase(pd, node);
@@ -1323,8 +1320,7 @@ static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 	pkt_set_state(ddev, pkt, PACKET_WRITE_WAIT_STATE);
 	spin_unlock(&pkt->lock);
 
-	dev_dbg(ddev, "Writing %d frames for zone %llx\n", pkt->write_size,
-		(unsigned long long)pkt->sector);
+	dev_dbg(ddev, "Writing %d frames for zone %llx\n", pkt->write_size, pkt->sector);
 
 	if (test_bit(PACKET_MERGE_SEGS, &pd->flags) || (pkt->write_size < pkt->frames))
 		pkt->cache_valid = 1;
@@ -2472,8 +2468,7 @@ static void pkt_submit_bio(struct bio *bio)
 		return;
 
 	dev_dbg(ddev, "start = %6llx stop = %6llx\n",
-		(unsigned long long)bio->bi_iter.bi_sector,
-		(unsigned long long)bio_end_sector(bio));
+		bio->bi_iter.bi_sector, bio_end_sector(bio));
 
 	/*
 	 * Clone READ bios so we can have our own bi_end_io callback.
@@ -2484,8 +2479,7 @@ static void pkt_submit_bio(struct bio *bio)
 	}
 
 	if (!test_bit(PACKET_WRITABLE, &pd->flags)) {
-		dev_notice(ddev, "WRITE for ro device (%llu)\n",
-			   (unsigned long long)bio->bi_iter.bi_sector);
+		dev_notice(ddev, "WRITE for ro device (%llu)\n", bio->bi_iter.bi_sector);
 		goto end_io;
 	}
 
-- 
2.39.1

