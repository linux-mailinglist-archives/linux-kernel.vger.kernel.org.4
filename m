Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730BF5F70F9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiJFWJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiJFWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:09:14 -0400
Received: from resqmta-h1p-028591.sys.comcast.net (resqmta-h1p-028591.sys.comcast.net [IPv6:2001:558:fd02:2446::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C0B6017
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:09:11 -0700 (PDT)
Received: from resomta-h1p-028434.sys.comcast.net ([96.102.179.205])
        by resqmta-h1p-028591.sys.comcast.net with ESMTP
        id gRssoZm6KhQF9gZ3FoMzub; Thu, 06 Oct 2022 22:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665094149;
        bh=/3S8XYUPoLNoCQFIeNIKXKOqGeoEn1XS9eHYJ1DMxRs=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=sS75FlrEChfEwMJx0Nvzdb8o2dOh8w74OOEgtRjB/bVxdEJm0MvZ96uGuRIXXGldr
         oPxw6YpSQ9T04laROsdg9fhbOed5JoP/1o7dz3MVKUc9m2mbXckJHGqaa/o/vmkOq1
         p8mymwnrL79+IE4sr2q1FsG2xXwzRAjqyx4No+hcqUG2Mvlnk/XOWiYHAJYrALaBlv
         h19WVT1kxF0j16d3GEJrm/hQDm9YHtx2Klvbgqs68+nqq450K0BNvjpeMTXIeeiu4P
         uZf2mzYBPrUVsCXa2CazZ4IjJteufFLXWeRbS1A+XeEAKADENQfWdx0Uh2E6D2IZ9C
         ZdFs+AvQuELZg==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-028434.sys.comcast.net with ESMTPA
        id gZ2nocknTZjG3gZ2woEgxW; Thu, 06 Oct 2022 22:08:51 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghkse
 hsohhlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH 2/2] md/bitmap: Add chunk-count-based bitmap flushing
Date:   Thu,  6 Oct 2022 16:08:40 -0600
Message-Id: <20221006220840.275-4-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006220840.275-1-jonathan.derrick@linux.dev>
References: <20221006220840.275-1-jonathan.derrick@linux.dev>
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

In addition to the timer, allow the bitmap flushing to be controlled by a
counter that tracks the number of dirty chunks and flushes when it exceeds a
user-defined chunk-count threshold.

This introduces a new field to the bitmap superblock and version 6.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/md/md-bitmap.c | 37 ++++++++++++++++++++++++++++++++++---
 drivers/md/md-bitmap.h |  5 ++++-
 drivers/md/md.h        |  1 +
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 451259b38d25..fa6b3c71c314 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -499,6 +499,7 @@ void md_bitmap_print_sb(struct bitmap *bitmap)
 	pr_debug("         state: %08x\n", le32_to_cpu(sb->state));
 	pr_debug("     chunksize: %d B\n", le32_to_cpu(sb->chunksize));
 	pr_debug("  daemon sleep: %ds\n", le32_to_cpu(sb->daemon_sleep));
+	pr_debug("  flush chunks: %d\n", le32_to_cpu(sb->daemon_flush_chunks));
 	pr_debug("     sync size: %llu KB\n",
 		 (unsigned long long)le64_to_cpu(sb->sync_size)/2);
 	pr_debug("max write behind: %d\n", le32_to_cpu(sb->write_behind));
@@ -581,6 +582,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 	bitmap_super_t *sb;
 	unsigned long chunksize, daemon_sleep, write_behind;
 	unsigned long long events;
+	unsigned int daemon_flush_chunks;
 	int nodes = 0;
 	unsigned long sectors_reserved = 0;
 	int err = -EINVAL;
@@ -644,7 +646,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 	if (sb->magic != cpu_to_le32(BITMAP_MAGIC))
 		reason = "bad magic";
 	else if (le32_to_cpu(sb->version) < BITMAP_MAJOR_LO ||
-		 le32_to_cpu(sb->version) > BITMAP_MAJOR_CLUSTERED)
+		 le32_to_cpu(sb->version) > BITMAP_MAJOR_CHUNKFLUSH)
 		reason = "unrecognized superblock version";
 	else if (chunksize < 512)
 		reason = "bitmap chunksize too small";
@@ -660,6 +662,9 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 		goto out;
 	}
 
+	if (sb->version == cpu_to_le32(BITMAP_MAJOR_CHUNKFLUSH))
+		daemon_flush_chunks = le32_to_cpu(sb->daemon_flush_chunks);
+
 	/*
 	 * Setup nodes/clustername only if bitmap version is
 	 * cluster-compatible
@@ -720,6 +725,7 @@ static int md_bitmap_read_sb(struct bitmap *bitmap)
 			bitmap->events_cleared = bitmap->mddev->events;
 		bitmap->mddev->bitmap_info.chunksize = chunksize;
 		bitmap->mddev->bitmap_info.daemon_sleep = daemon_sleep;
+		bitmap->mddev->bitmap_info.daemon_flush_chunks = daemon_flush_chunks;
 		bitmap->mddev->bitmap_info.max_write_behind = write_behind;
 		bitmap->mddev->bitmap_info.nodes = nodes;
 		if (bitmap->mddev->bitmap_info.space == 0 ||
@@ -1218,6 +1224,31 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 					       sector_t offset, sector_t *blocks,
 					       int create);
 
+static bool md_daemon_should_sleep(struct mddev *mddev)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+	struct bitmap_page *bp;
+	unsigned long k, pages;
+	unsigned int count = 0;
+
+	if (time_after(jiffies, bitmap->daemon_lastrun
+			+ mddev->bitmap_info.daemon_sleep))
+		return false;
+
+	if (mddev->bitmap_info.daemon_flush_chunks) {
+		bp = bitmap->counts.bp;
+		pages = bitmap->counts.pages;
+		for (k = 0; k < pages; k++)
+			if (bp[k].map && !bp[k].hijacked)
+				count += bp[k].count;
+
+		if (count >= mddev->bitmap_info.daemon_flush_chunks)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * bitmap daemon -- periodically wakes up to clean bits and flush pages
  *			out to disk
@@ -1240,8 +1271,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 		mutex_unlock(&mddev->bitmap_info.mutex);
 		return;
 	}
-	if (time_before(jiffies, bitmap->daemon_lastrun
-			+ mddev->bitmap_info.daemon_sleep))
+
+	if (md_daemon_should_sleep(mddev))
 		goto done;
 
 	md_bitmap_unplug(bitmap);
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index cfd7395de8fd..e0aeedbdde17 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -11,10 +11,12 @@
 /* version 4 insists the bitmap is in little-endian order
  * with version 3, it is host-endian which is non-portable
  * Version 5 is currently set only for clustered devices
++ * Version 6 supports the flush-chunks threshold
  */
 #define BITMAP_MAJOR_HI 4
 #define BITMAP_MAJOR_CLUSTERED 5
 #define	BITMAP_MAJOR_HOSTENDIAN 3
+#define BITMAP_MAJOR_CHUNKFLUSH 6
 
 /*
  * in-memory bitmap:
@@ -135,7 +137,8 @@ typedef struct bitmap_super_s {
 				  * reserved for the bitmap. */
 	__le32 nodes;        /* 68 the maximum number of nodes in cluster. */
 	__u8 cluster_name[64]; /* 72 cluster name to which this md belongs */
-	__u8  pad[256 - 136]; /* set to zero */
+	__le32 daemon_flush_chunks; /* 136 dirty chunks between flushes */
+	__u8  pad[256 - 140]; /* set to zero */
 } bitmap_super_t;
 
 /* notes:
diff --git a/drivers/md/md.h b/drivers/md/md.h
index b4e2d8b87b61..d25574e46283 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -497,6 +497,7 @@ struct mddev {
 		struct mutex		mutex;
 		unsigned long		chunksize;
 		unsigned long		daemon_sleep; /* how many jiffies between updates? */
+		unsigned int		daemon_flush_chunks; /* how many dirty chunks between updates */
 		unsigned long		max_write_behind; /* write-behind mode */
 		int			external;
 		int			nodes; /* Maximum number of nodes in the cluster */
-- 
2.31.1

