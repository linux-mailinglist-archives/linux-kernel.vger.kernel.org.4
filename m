Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A615FE58C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJMWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJMWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:45:04 -0400
Received: from resqmta-c1p-024063.sys.comcast.net (resqmta-c1p-024063.sys.comcast.net [IPv6:2001:558:fd00:56::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45F65C96E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:44:56 -0700 (PDT)
Received: from resomta-c1p-023267.sys.comcast.net ([96.102.18.232])
        by resqmta-c1p-024063.sys.comcast.net with ESMTP
        id j5u4o8WmbopRHj6uGozIg7; Thu, 13 Oct 2022 22:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665700944;
        bh=RmsPdp6XB2/XHXf0fJ7VeuVLgpyyn/dl4lgDaA8Nfi4=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=o+aFDZmt1HIJr8SdJmyUSe1F6OhddikpPnTNE/7TWKuY8ZeOlKKMXW8mb6qExDBmg
         Ttlz1va1XslPHu/tqqsY2297fd1RWO0KlPDdjY8ql8JSq4zd9Vo8mmoBaDRHA2gfEF
         QyUIWDPw6ru4Pb81MLiDsC5QHYxnPXpg+p5Mvl10BT90kN5pL244H06/i0DjOO5lDa
         BSfSPGFGgKEFr3SQc73vO9wlddOHLttZ3jDC2szN8r1N6f3C31ZXIJqA6CZ1RxmkrI
         vF2aWwE0qOB8BR1TSu3x0O+QL8kvymFjzy2GJVcqWQD2ZL9EfJGL+kW8NLGHqDAwoF
         ct0H9LC9SYUxw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-c1p-023267.sys.comcast.net with ESMTPA
        id j6toofOVmA6uYj6tuozg6q; Thu, 13 Oct 2022 22:42:02 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghkse
 hsohhlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhushiirdhtkhgrtgiihihksehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 1/3] md/bitmap: Add chunk-threshold unplugging
Date:   Thu, 13 Oct 2022 16:41:49 -0600
Message-Id: <20221013224151.300-2-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221013224151.300-1-jonathan.derrick@linux.dev>
References: <20221013224151.300-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mechanism to allow bitmap unplugging and flushing to wait until it
has surpassed a defined threshold of dirty chunks. This allows certain
high I/O write workloads to make good forward progress between bitmap
updates or provide reliable bitmap consistency. The default behavior is
previous behavior of always unplugging when called.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/md/md-bitmap.c | 35 +++++++++++++++++++++++++++++++----
 drivers/md/md-bitmap.h |  1 +
 drivers/md/md.h        |  1 +
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index bf6dffadbe6f..c5c77f8371a8 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1004,7 +1004,7 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
 /* this gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
  * sync the dirty pages of the bitmap file to disk */
-void md_bitmap_unplug(struct bitmap *bitmap)
+static void __md_bitmap_unplug(struct bitmap *bitmap)
 {
 	unsigned long i;
 	int dirty, need_write;
@@ -1038,6 +1038,33 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 	if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
 		md_bitmap_file_kick(bitmap);
 }
+
+/*
+ * Conditional unplug based on user-defined parameter
+ * Defaults to unconditional behavior
+ */
+void md_bitmap_unplug(struct bitmap *bitmap)
+{
+	unsigned int flush_threshold = bitmap->mddev->bitmap_info.flush_threshold;
+
+	if (!flush_threshold) {
+		__md_bitmap_unplug(bitmap);
+	} else {
+		struct bitmap_page *bp = bitmap->counts.bp;
+		unsigned long pages = bitmap->counts.pages;
+		unsigned long k, count = 0;
+
+		for (k = 0; k < pages; k++)
+			if (bp[k].map && !bp[k].hijacked)
+				count += bp[k].count;
+
+		if (count - bitmap->unplugged_count > flush_threshold) {
+			bitmap->unplugged_count = count;
+			md_bitmap_daemon_work(&bitmap->mddev->daemon_timer);
+			__md_bitmap_unplug(bitmap);
+		}
+	}
+}
 EXPORT_SYMBOL(md_bitmap_unplug);
 
 static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
@@ -2012,9 +2039,9 @@ int md_bitmap_copy_from_slot(struct mddev *mddev, int slot,
 		for (i = 0; i < bitmap->storage.file_pages; i++)
 			if (test_page_attr(bitmap, i, BITMAP_PAGE_PENDING))
 				set_page_attr(bitmap, i, BITMAP_PAGE_NEEDWRITE);
-		md_bitmap_unplug(bitmap);
+		__md_bitmap_unplug(bitmap);
 	}
-	md_bitmap_unplug(mddev->bitmap);
+	__md_bitmap_unplug(mddev->bitmap);
 	*low = lo;
 	*high = hi;
 	md_bitmap_free(bitmap);
@@ -2246,7 +2273,7 @@ int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
 	spin_unlock_irq(&bitmap->counts.lock);
 
 	if (!init) {
-		md_bitmap_unplug(bitmap);
+		__md_bitmap_unplug(bitmap);
 		bitmap->mddev->pers->quiesce(bitmap->mddev, 0);
 	}
 	ret = 0;
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index cfd7395de8fd..49a93d8ff307 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -223,6 +223,7 @@ struct bitmap {
 	unsigned long daemon_lastrun; /* jiffies of last run */
 	unsigned long last_end_sync; /* when we lasted called end_sync to
 				      * update bitmap with resync progress */
+	unsigned long unplugged_count; /* last dirty count from md_bitmap_unplug */
 
 	atomic_t pending_writes; /* pending writes to the bitmap file */
 	wait_queue_head_t write_wait;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b4e2d8b87b61..1a558cb18bd4 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -501,6 +501,7 @@ struct mddev {
 		int			external;
 		int			nodes; /* Maximum number of nodes in the cluster */
 		char                    cluster_name[64]; /* Name of the cluster */
+		unsigned int		flush_threshold; /* how many dirty chunks between updates */
 	} bitmap_info;
 
 	atomic_t			max_corr_read_errors; /* max read retries */
-- 
2.31.1

