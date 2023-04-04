Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18536D6F16
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjDDVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbjDDVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20849FE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A5F638F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E81CC433D2;
        Tue,  4 Apr 2023 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680644380;
        bh=NHSIcpjoPf9wpAnrKABRpzgjh7hQvftgW9HZxw+Kxug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzZHtbkpXSbyzyseVkhx0Ml4Tgti15LHBfISnTnRceP8Cu1omxpVMVfwTyGHFiYhc
         sNZ5HJmV+fPMzamV3cMDeNltsdCi8BBeQnRmZ/lGrVgwb9XrF3NuoAZDz+09obhfHY
         PKnWIPh32AYHxiobShzGPcCCXvJDj6G3c3kXXNLadY8AdjUvydUCjFcH8N6d5thjDi
         Jn/evoP6Mc2d/2Z0vLiY1MqqcbTM1y3uAKl3CPA3OmHI1RxQlnYMJJbgCvYaL2cKhy
         t67vRwQ4Y52Mi6nOgAI6Ptn6oMlOI75yHQtPTl8yt6GL4L8Q3ZRWaTk6BwpGdHPcl1
         xmrb7nxqtwBCQ==
Date:   Tue, 4 Apr 2023 14:39:38 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to trigger a checkpoint in the end of
 foreground garbage collection
Message-ID: <ZCyZGgf4RSEjyHTF@google.com>
References: <20230324071028.336982-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324071028.336982-1-chao@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we do like this?

From 9a58f0e59364241aa31b555cfe793d278e39b0dc Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 4 Apr 2023 14:36:00 -0700
Subject: [PATCH] f2fs: do checkpoint when there's not enough free sections

We didn't do checkpoint in FG_GC case, which may cause losing to reclaim prefree
sctions in time.

Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 56c53dbe05c9..f1d0dd9c5a6c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1806,6 +1806,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	};
 	unsigned int skipped_round = 0, round = 0;
 	unsigned int upper_secs;
+	bool stop_gc = false;
 
 	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
 				gc_control->nr_free_secs,
@@ -1876,19 +1877,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
 		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
 			goto go_gc_more;
-		goto stop;
-	}
-
-	/* FG_GC stops GC by skip_count */
-	if (gc_type == FG_GC) {
+		stop_gc = true;
+	} else if (gc_type == FG_GC) {
+		/* FG_GC stops GC by skip_count */
 		if (sbi->skipped_gc_rwsem)
 			skipped_round++;
 		round++;
 		if (skipped_round > MAX_SKIP_GC_COUNT &&
-				skipped_round * 2 >= round) {
-			ret = f2fs_write_checkpoint(sbi, &cpc);
-			goto stop;
-		}
+				skipped_round * 2 >= round)
+			stop_gc = true;
 	}
 
 	__get_secs_required(sbi, NULL, &upper_secs, NULL);
@@ -1901,12 +1898,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 				prefree_segments(sbi)) {
 		ret = f2fs_write_checkpoint(sbi, &cpc);
 		if (ret)
-			goto stop;
+			stop_gc = true;
 	}
 go_gc_more:
-	segno = NULL_SEGNO;
-	goto gc_more;
-
+	if (!stop_gc) {
+		segno = NULL_SEGNO;
+		goto gc_more;
+	}
 stop:
 	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
 	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = gc_control->victim_segno;
-- 
2.40.0.348.gf938b09366-goog

