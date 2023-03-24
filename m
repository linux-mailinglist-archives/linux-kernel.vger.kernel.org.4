Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206B26C787F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCXHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:11:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65D25BBA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 152CDB82178
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0639C433EF;
        Fri, 24 Mar 2023 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679641892;
        bh=fd449v8qUAZkDHI6JVneORMPbA4ytiODmJnf767Az2E=;
        h=From:To:Cc:Subject:Date:From;
        b=Ifgg7zI5WbqRt/wqU+zoY5M6knul1KM3tbF0F9zWBh/P/F0IUZoA9U0oA8fJLKqe7
         XFu7rjzuhLE0JGqH5oTfrqQNn3akT63mR4zyes68LX5vvspHXTFAAE6VTP1+HwX1ai
         6o/ZQ7DDwUOX1YVudxWf0iQUWdDZM4wEAUNkPPGqFabR7y9xGIULR1Nq2rd0eKXwP/
         OLM3xaXi9QdTa+TQLOwIKvifuaPlCBCQwGHcDNFx1BN3HPmm1x4F3svRGykC/4S1W/
         mL682Ozy7WyDe40UAdex1veILvNgqTaN8aVQe/cZaogmNTU4W67Emo6fZbLQ5822I9
         l6nWibBrt4IwQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to trigger a checkpoint in the end of foreground garbage collection
Date:   Fri, 24 Mar 2023 15:10:28 +0800
Message-Id: <20230324071028.336982-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reclaim free blocks in prefree sections before latter use.

Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/gc.c      | 8 ++++++++
 fs/f2fs/segment.c | 1 +
 3 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 53a005b420cf..b1515375cb4c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1269,6 +1269,7 @@ struct f2fs_gc_control {
 	unsigned int victim_segno;	/* target victim segment number */
 	int init_gc_type;		/* FG_GC or BG_GC */
 	bool no_bg_gc;			/* check the space and stop bg_gc */
+	bool reclaim_space;		/* trigger checkpoint to reclaim space */
 	bool should_migrate_blocks;	/* should migrate blocks */
 	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
 	unsigned int nr_free_secs;	/* # of free sections to do GC */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2996d38aa89c..5a451d3d512d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -132,6 +132,7 @@ static int gc_thread_func(void *data)
 
 		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
 		gc_control.no_bg_gc = foreground;
+		gc_control.reclaim_space = foreground;
 		gc_control.nr_free_secs = foreground ? 1 : 0;
 
 		/* if return value is not zero, no victim was selected */
@@ -1880,6 +1881,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
 		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
 			goto go_gc_more;
+
+		/*
+		 * trigger a checkpoint in the end of foreground garbage
+		 * collection.
+		 */
+		if (gc_control->reclaim_space)
+			ret = f2fs_write_checkpoint(sbi, &cpc);
 		goto stop;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6c11789da884..b62af2ae1685 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -421,6 +421,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 				.victim_segno = NULL_SEGNO,
 				.init_gc_type = BG_GC,
 				.no_bg_gc = true,
+				.reclaim_space = true,
 				.should_migrate_blocks = false,
 				.err_gc_skipped = false,
 				.nr_free_secs = 1 };
-- 
2.25.1

