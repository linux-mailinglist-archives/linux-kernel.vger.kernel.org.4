Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646496B4D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCJQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCJQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:07 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FAE12869;
        Fri, 10 Mar 2023 08:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466825; x=1710002825;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/LsCytNw1mSWibP4pLwEiJlc3RavT6gtvEvzKlrViL8=;
  b=goYd3orcIG20OpaG7Yis60TF31ZuF1TgVDgeoYAOgJ34meu9rkJe/46x
   4COVCpxRjt/xRYZtCMbgvKBCUWfKjbiFncz6oAyLm9T+UMp9Ynpw+Srgi
   Zr+Du1weeEvRlgJAYDMYPk5/8tRl0UKj19ArNgD2r8uj9Bhne9MNAdTb9
   8rok/hZu4TPGLPyMBFp44PXWSSNmQFPksrxyLmDsr/H30zBbntBuxvWhJ
   aQjw7ZWZ8a6e94nwQ31lZ4RzdA+Nn2I3uJSh45iDWagMCWXsyv2JVCY22
   jQfYwOBIqSntIpD2XV6c/bU+YnUXXRqedOfEjG7Jk93PvvKm/iJ29DwEw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621117"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621117"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778620"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31B80154; Fri, 10 Mar 2023 18:45:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] pktcdvd: Get rid of pkt_seq_show() forward declaration
Date:   Fri, 10 Mar 2023 18:45:44 +0200
Message-Id: <20230310164549.22133-5-andriy.shevchenko@linux.intel.com>
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

The code can be neater without forward declarations.
Get rid of pkt_seq_show() forward declaration. This
will also allow futher cleanups to be cleaner.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.39.1

