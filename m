Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7AB6745DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjASWXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjASWWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:22:08 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B69371C;
        Thu, 19 Jan 2023 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674166062; x=1705702062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=szqNUUKgXj1YoKKFHpFixfKBGxMIBzy9o4xIK/wxqfA=;
  b=R9i8dXLnKGjMJUmIpbi9xByJshAjY2vx1pSjsFpI6iAN8Q6Q4JzzRZ12
   bNCqahsOpXYx19lsQ05oPPQrrTnU1g5pB2uvGXIuk9jk8xBNwgFeDqJHf
   K7hUONgiQs4ur4beHsKaYw9tYQ9moYiR3gtImKcBxckladCm9wSCBJE7u
   1HSk6pNyxs1q3ys7bLGpQsA6yH+xbT7yB6KMcisnWZ6WD9wZeA60mgohb
   S76BF5jwr8W1hOXUnmqj7PMVTYdUpPgfD+Y+cuiyWgM2mXpq0VhlFTdwe
   P2NSe03a52Sq2Th4Bk1MY26WAMALCFYNzagZfQpSwBZU7szL2xD5XJaW5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305114108"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="305114108"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 14:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="637879309"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="637879309"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 14:07:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5599B38F; Fri, 20 Jan 2023 00:08:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/9] pktcdvd: Get rid of pkt_seq_show() forward declaration
Date:   Fri, 20 Jan 2023 00:08:04 +0200
Message-Id: <20230119220809.5518-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code can be neater without forward declarations.
Get rid of pkt_seq_show() forward declaration. This
will also allow futher cleanups to be cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/block/pktcdvd.c | 151 ++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 76 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 98a5c388eabf..96db6e348e1e 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -90,7 +90,6 @@ static struct dentry	*pkt_debugfs_root = NULL; /* /sys/kernel/debug/pktcdvd */
 /* forward declaration */
 static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev);
 static int pkt_remove_dev(dev_t pkt_dev);
-static int pkt_seq_show(struct seq_file *m, void *p);
 
 static sector_t get_zone(sector_t sector, struct pktcdvd_device *pd)
 {
@@ -431,6 +430,81 @@ static void pkt_sysfs_cleanup(void)
 
  *******************************************************************/
 
+static void pkt_count_states(struct pktcdvd_device *pd, int *states)
+{
+	struct packet_data *pkt;
+	int i;
+
+	for (i = 0; i < PACKET_NUM_STATES; i++)
+		states[i] = 0;
+
+	spin_lock(&pd->cdrw.active_list_lock);
+	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
+		states[pkt->state]++;
+	}
+	spin_unlock(&pd->cdrw.active_list_lock);
+}
+
+static int pkt_seq_show(struct seq_file *m, void *p)
+{
+	struct pktcdvd_device *pd = m->private;
+	char *msg;
+	int states[PACKET_NUM_STATES];
+
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name, pd->bdev);
+
+	seq_printf(m, "\nSettings:\n");
+	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
+
+	if (pd->settings.write_type == 0)
+		msg = "Packet";
+	else
+		msg = "Unknown";
+	seq_printf(m, "\twrite type:\t\t%s\n", msg);
+
+	seq_printf(m, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
+	seq_printf(m, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
+
+	seq_printf(m, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
+
+	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
+		msg = "Mode 1";
+	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
+		msg = "Mode 2";
+	else
+		msg = "Unknown";
+	seq_printf(m, "\tblock mode:\t\t%s\n", msg);
+
+	seq_printf(m, "\nStatistics:\n");
+	seq_printf(m, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
+	seq_printf(m, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
+	seq_printf(m, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
+	seq_printf(m, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
+	seq_printf(m, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
+
+	seq_printf(m, "\nMisc:\n");
+	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
+	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
+	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
+	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
+	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
+	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
+
+	seq_printf(m, "\nQueue state:\n");
+	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
+	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
+	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
+
+	pkt_count_states(pd, states);
+	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
+		   states[0], states[1], states[2], states[3], states[4], states[5]);
+
+	seq_printf(m, "\twrite congestion marks:\toff=%d on=%d\n",
+			pd->write_congestion_off,
+			pd->write_congestion_on);
+	return 0;
+}
+
 static int pkt_debugfs_seq_show(struct seq_file *m, void *p)
 {
 	return pkt_seq_show(m, p);
@@ -1361,21 +1435,6 @@ static void pkt_handle_packets(struct pktcdvd_device *pd)
 	spin_unlock(&pd->cdrw.active_list_lock);
 }
 
-static void pkt_count_states(struct pktcdvd_device *pd, int *states)
-{
-	struct packet_data *pkt;
-	int i;
-
-	for (i = 0; i < PACKET_NUM_STATES; i++)
-		states[i] = 0;
-
-	spin_lock(&pd->cdrw.active_list_lock);
-	list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
-		states[pkt->state]++;
-	}
-	spin_unlock(&pd->cdrw.active_list_lock);
-}
-
 /*
  * kcdrwd is woken up when writes have been queued for one of our
  * registered devices
@@ -2467,66 +2526,6 @@ static void pkt_init_queue(struct pktcdvd_device *pd)
 	q->queuedata = pd;
 }
 
-static int pkt_seq_show(struct seq_file *m, void *p)
-{
-	struct pktcdvd_device *pd = m->private;
-	char *msg;
-	int states[PACKET_NUM_STATES];
-
-	seq_printf(m, "Writer %s mapped to %pg:\n", pd->disk->disk_name, pd->bdev);
-
-	seq_printf(m, "\nSettings:\n");
-	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
-
-	if (pd->settings.write_type == 0)
-		msg = "Packet";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\twrite type:\t\t%s\n", msg);
-
-	seq_printf(m, "\tpacket type:\t\t%s\n", pd->settings.fp ? "Fixed" : "Variable");
-	seq_printf(m, "\tlink loss:\t\t%d\n", pd->settings.link_loss);
-
-	seq_printf(m, "\ttrack mode:\t\t%d\n", pd->settings.track_mode);
-
-	if (pd->settings.block_mode == PACKET_BLOCK_MODE1)
-		msg = "Mode 1";
-	else if (pd->settings.block_mode == PACKET_BLOCK_MODE2)
-		msg = "Mode 2";
-	else
-		msg = "Unknown";
-	seq_printf(m, "\tblock mode:\t\t%s\n", msg);
-
-	seq_printf(m, "\nStatistics:\n");
-	seq_printf(m, "\tpackets started:\t%lu\n", pd->stats.pkt_started);
-	seq_printf(m, "\tpackets ended:\t\t%lu\n", pd->stats.pkt_ended);
-	seq_printf(m, "\twritten:\t\t%lukB\n", pd->stats.secs_w >> 1);
-	seq_printf(m, "\tread gather:\t\t%lukB\n", pd->stats.secs_rg >> 1);
-	seq_printf(m, "\tread:\t\t\t%lukB\n", pd->stats.secs_r >> 1);
-
-	seq_printf(m, "\nMisc:\n");
-	seq_printf(m, "\treference count:\t%d\n", pd->refcnt);
-	seq_printf(m, "\tflags:\t\t\t0x%lx\n", pd->flags);
-	seq_printf(m, "\tread speed:\t\t%ukB/s\n", pd->read_speed);
-	seq_printf(m, "\twrite speed:\t\t%ukB/s\n", pd->write_speed);
-	seq_printf(m, "\tstart offset:\t\t%lu\n", pd->offset);
-	seq_printf(m, "\tmode page offset:\t%u\n", pd->mode_offset);
-
-	seq_printf(m, "\nQueue state:\n");
-	seq_printf(m, "\tbios queued:\t\t%d\n", pd->bio_queue_size);
-	seq_printf(m, "\tbios pending:\t\t%d\n", atomic_read(&pd->cdrw.pending_bios));
-	seq_printf(m, "\tcurrent sector:\t\t0x%llx\n", (unsigned long long)pd->current_sector);
-
-	pkt_count_states(pd, states);
-	seq_printf(m, "\tstate:\t\t\ti:%d ow:%d rw:%d ww:%d rec:%d fin:%d\n",
-		   states[0], states[1], states[2], states[3], states[4], states[5]);
-
-	seq_printf(m, "\twrite congestion marks:\toff=%d on=%d\n",
-			pd->write_congestion_off,
-			pd->write_congestion_on);
-	return 0;
-}
-
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	struct device *ddev = disk_to_dev(pd->disk);
-- 
2.39.0

