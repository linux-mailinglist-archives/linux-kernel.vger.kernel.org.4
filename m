Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75935F70F7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiJFWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiJFWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:09:13 -0400
Received: from resqmta-h1p-028592.sys.comcast.net (resqmta-h1p-028592.sys.comcast.net [IPv6:2001:558:fd02:2446::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE56A2856
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:09:11 -0700 (PDT)
Received: from resomta-h1p-028434.sys.comcast.net ([96.102.179.205])
        by resqmta-h1p-028592.sys.comcast.net with ESMTP
        id gUO5ooXzKSl18gZ3FohK5y; Thu, 06 Oct 2022 22:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665094149;
        bh=4bReB5ysVuzj9J5Lw/ImRMSRjeBQ5PeaGd2KDieB5II=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=gOB9rFSNfk0/QJ31v3dHPo6r/7i7uqNLQ4640/fAS3chf23vOj6j50d0d5fGGMoAV
         IYpk4h9zcB5ljCZnVxReKv+61b1tUqb22z47GdE4Tqcx3H5Dr5lsBLOltoo7IYuDke
         OnYolDu+bfyIjaARp2n/ldlyi6P022/6YqXwjCNPYYuu6K9W4+Q0dlMN/WGcdwS0f1
         bN5SqXFNbCuuR/PvAmdfTBPUEVeavcvfKLApUQqIHzE6FnQAeG3ugneNWe2tZefg24
         7lTQk8hxwWbVRw32nwIUZSTDTwHUxLk2hi10tVqFgcQxHBYd5SQ45XTSm+6fHBQtey
         PwW4xIHCMTGDg==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-028434.sys.comcast.net with ESMTPA
        id gZ2nocknTZjG3gZ2voEgxO; Thu, 06 Oct 2022 22:08:50 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghkse
 hsohhlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH 1/2] md/bitmap: Move unplug to daemon thread
Date:   Thu,  6 Oct 2022 16:08:39 -0600
Message-Id: <20221006220840.275-3-jonathan.derrick@linux.dev>
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

It's been observed in raid1/raid10 configurations that synchronous I/O
can cause workloads resulting in greater than 40% bitmap updates. This
appears to be due to the synchronous workload requiring a bitmap flush
with every flush of the I/O list. Instead prefer to flush this
configuration in the daemon sleeper thread.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/md/md-bitmap.c | 1 +
 drivers/md/raid1.c     | 2 --
 drivers/md/raid10.c    | 4 ----
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index bf6dffadbe6f..451259b38d25 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1244,6 +1244,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 			+ mddev->bitmap_info.daemon_sleep))
 		goto done;
 
+	md_bitmap_unplug(bitmap);
 	bitmap->daemon_lastrun = jiffies;
 	if (bitmap->allclean) {
 		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 05d8438cfec8..42ba2d884773 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -793,8 +793,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 
 static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 {
-	/* flush any pending bitmap writes to disk before proceeding w/ I/O */
-	md_bitmap_unplug(conf->mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9117fcdee1be..e43352aae3c4 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -881,9 +881,6 @@ static void flush_pending_writes(struct r10conf *conf)
 		__set_current_state(TASK_RUNNING);
 
 		blk_start_plug(&plug);
-		/* flush any pending bitmap writes to disk
-		 * before proceeding w/ I/O */
-		md_bitmap_unplug(conf->mddev->bitmap);
 		wake_up(&conf->wait_barrier);
 
 		while (bio) { /* submit pending writes */
@@ -1078,7 +1075,6 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
-	md_bitmap_unplug(mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
-- 
2.31.1

