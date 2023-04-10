Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0B26DC293
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDJCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJCOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D92701
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 19:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 549B260D32
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918D1C433EF;
        Mon, 10 Apr 2023 02:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681092850;
        bh=pXSNSEY080dCZ45hxP1p6QKFX6fqVzj/5je/deUizYA=;
        h=From:To:Cc:Subject:Date:From;
        b=n0DnDTV39nOj54ijI8xX14a/fVfk9sb29YAwpg1Njihu112/Z2WuHhSez2wB3VT5+
         hDMhWrJ0w4tA2L4t7IM282Nh8c74N5OgCX2zCqgqrmIWR7qDHHK/m4FOfk1D8oCJKC
         yLs5EfczK6jb6+70E8GlxQhvpLO8V3hdnSHeXDpKHxXJE7jsmUFOu3SpV4BTuVdHN2
         SaLsZ/mG/9j9Gux99gVA4vf/XAfnj9XLdxddMh3/TWN/roBztJ17IdcJ2U+WJgnRjR
         2qB6HZSUggm50IScvP1fzkgbLudZvtJZIRDH3tVqajaIZI4FY6l/+zfrrZqN+hRMZF
         /i1a/H21BZKLQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid use-after-free for cached IPU bio
Date:   Mon, 10 Apr 2023 10:14:02 +0800
Message-Id: <20230410021402.1833220-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstest generic/019 reports a bug:

kernel BUG at mm/filemap.c:1619!
RIP: 0010:folio_end_writeback+0x8a/0x90
Call Trace:
 end_page_writeback+0x1c/0x60
 f2fs_write_end_io+0x199/0x420
 bio_endio+0x104/0x180
 submit_bio_noacct+0xa5/0x510
 submit_bio+0x48/0x80
 f2fs_submit_write_bio+0x35/0x300
 f2fs_submit_merged_ipu_write+0x2a0/0x2b0
 f2fs_write_single_data_page+0x838/0x8b0
 f2fs_write_cache_pages+0x379/0xa30
 f2fs_write_data_pages+0x30c/0x340
 do_writepages+0xd8/0x1b0
 __writeback_single_inode+0x44/0x370
 writeback_sb_inodes+0x233/0x4d0
 __writeback_inodes_wb+0x56/0xf0
 wb_writeback+0x1dd/0x2d0
 wb_workfn+0x367/0x4a0
 process_one_work+0x21d/0x430
 worker_thread+0x4e/0x3c0
 kthread+0x103/0x130
 ret_from_fork+0x2c/0x50

The root cause is: after cp_error is set, f2fs_submit_merged_ipu_write()
in f2fs_write_single_data_page() tries to flush IPU bio in cache, however
f2fs_submit_merged_ipu_write() missed to check validity of @bio parameter,
result in submitting random cached bio which belong to other IO context,
then it will cause use-after-free issue, fix it by adding additional
validity check.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8064df5f829d..b59b5c7096f3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -874,6 +874,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 	bool found = false;
 	struct bio *target = bio ? *bio : NULL;
 
+	f2fs_bug_on(sbi, !target && !page);
+
 	for (temp = HOT; temp < NR_TEMP_TYPE && !found; temp++) {
 		struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 		struct list_head *head = &io->bio_list;
@@ -2902,7 +2904,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, DATA);
-		f2fs_submit_merged_ipu_write(sbi, bio, NULL);
+		if (bio && *bio)
+			f2fs_submit_merged_ipu_write(sbi, bio, NULL);
 		submitted = NULL;
 	}
 
-- 
2.25.1

