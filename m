Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0266E1522
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDMTZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDMTZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:25:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FD5FE4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 12:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D60560F8B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 19:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86386C433EF;
        Thu, 13 Apr 2023 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681413942;
        bh=v2u5oYGNyJxsqoJq7fHElU/OCH8U1BXBn6+cfSORKYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UefcNkeBeZA2V7UO619RutpO7ZpB+ffNqzOa2ZR7QMMx560EHAdLqZjNKAc7gUqrJ
         8elF0zE6VUf7u7ti776W2wVRqsaj1ozhryqTuQxLaq3La2u1SO0yZPdYh5XUfQ3cBc
         cVPqnj4AgVZW+mj7rghuP2hWt0B2bOaWOWletfRCpit2cVb7XuCeLvhr1CyXBhrs9M
         QAHBaZmUcBI6OAWvxkTlXuyiGdCisetRvCkPaFAN3F64bVMWgJ6bUo3Tvc/gizm6Ww
         umzNAbfG202q1sJ+S0VdDW99ks0L4dnzp4fsSGj1rGKwroPgmmofkfGQvFTxJvwqWU
         lqzsmcOa+16sg==
Date:   Thu, 13 Apr 2023 12:25:40 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to trigger a checkpoint in the end
 of foreground garbage collection
Message-ID: <ZDhXNMkgnmjccIhF@google.com>
References: <20230324071028.336982-1-chao@kernel.org>
 <ZCyZGgf4RSEjyHTF@google.com>
 <a4e49177-3959-eb2b-996c-5d07b7390495@kernel.org>
 <ZC2aA+i5+HpdJ6M2@google.com>
 <f4ae2b3a-0aff-8941-4081-9dc53334c590@kernel.org>
 <ZDSaCsLSYLyzUxBQ@google.com>
 <6c9abd05-297a-ea4f-fd5c-9f4d9fb488ab@kernel.org>
 <ZDgmGoWx2bHNO1zP@google.com>
 <ZDgmvf6O488GG7tH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDgmvf6O488GG7tH@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a xfstests failure.

From 400c722c2117660b83190c88e5442d63fbbffe6e Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 10 Apr 2023 14:48:50 -0700
Subject: [PATCH] f2fs: refactor f2fs_gc to call checkpoint in urgent condition

The major change is to call checkpoint, if there's not enough space while having
some prefree segments in FG_GC case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c748cdfb0501..ba5775dcade6 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1829,7 +1829,10 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 
-	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
+	/* Let's run FG_GC, if we don't have enough space. */
+	if (has_not_enough_free_secs(sbi, 0, 0)) {
+		gc_type = FG_GC;
+
 		/*
 		 * For example, if there are many prefree_segments below given
 		 * threshold, we can make them free by checkpoint. Then, we
@@ -1840,8 +1843,6 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 			if (ret)
 				goto stop;
 		}
-		if (has_not_enough_free_secs(sbi, 0, 0))
-			gc_type = FG_GC;
 	}
 
 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
@@ -1868,19 +1869,15 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	if (seg_freed == f2fs_usable_segs_in_sec(sbi, segno))
 		sec_freed++;
 
-	if (gc_type == FG_GC)
+	if (gc_type == FG_GC) {
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (gc_control->init_gc_type == FG_GC ||
-	    !has_not_enough_free_secs(sbi,
-				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
-		if (gc_type == FG_GC && sec_freed < gc_control->nr_free_secs)
-			goto go_gc_more;
-		goto stop;
-	}
-
-	/* FG_GC stops GC by skip_count */
-	if (gc_type == FG_GC) {
+		if (!has_not_enough_free_secs(sbi, sec_freed, 0)) {
+			if (!gc_control->no_bg_gc &&
+			    sec_freed < gc_control->nr_free_secs)
+				goto go_gc_more;
+			goto stop;
+		}
 		if (sbi->skipped_gc_rwsem)
 			skipped_round++;
 		round++;
@@ -1889,6 +1886,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 			ret = f2fs_write_checkpoint(sbi, &cpc);
 			goto stop;
 		}
+	} else if (!has_not_enough_free_secs(sbi, 0, 0)) {
+		goto stop;
 	}
 
 	__get_secs_required(sbi, NULL, &upper_secs, NULL);
-- 
2.40.0.634.g4ca3ef3211-goog

