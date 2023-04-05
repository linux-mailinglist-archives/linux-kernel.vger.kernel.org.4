Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877276D8394
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjDEQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjDEQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75E56EAC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA8663F85
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5BC433D2;
        Wed,  5 Apr 2023 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711746;
        bh=IKKd5/z6diLNwuttq1cK4BoG4eEmFEMFdox28Mo3uos=;
        h=From:To:Cc:Subject:Date:From;
        b=AAbjh4o1z/necfAjZKY1Sln6VweDJ7xXWEsUoZ2KWAdtadfcbfHDyuFfdCPjQ0TV0
         /QnxXK3/AzDHI4I909K4A7pA9y8k6e9uijWFJxSGnvy6oq8YVqfG7syd7wn+VyZVa9
         JOuBZI80K3uFps/zD19EUN2gzKbqwo0KcDTMD3oJkOfs6Vq4dcmLglKBPdHz1C9NH4
         HcIJt+yzuXVDGUyrfy2izT+eWHTvDHXYWSOvcMgDDcdXhbwN6OoHixI8ZgqrbIM38v
         DnS4ll5JbOu2168GJa0B8boo+ZnUr/W13wj6VEbcyKRJ7YquVi5T315DYgrSBloAlc
         +QNzVWlmiwdjQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: fix to check return value of inc_valid_block_count()
Date:   Wed,  5 Apr 2023 22:45:36 +0800
Message-Id: <20230405144536.930370-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
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

In __replace_atomic_write_block(), we missed to check return value
of inc_valid_block_count(), for extreme testcase that f2fs image is
run out of space, it may cause inconsistent status in between SIT
table and total valid block count.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc0734e4fb92..17203e8b865a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -246,10 +246,16 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	} else {
 		blkcnt_t count = 1;
 
+		err = inc_valid_block_count(sbi, inode, &count);
+		if (err) {
+			f2fs_put_dnode(&dn);
+			return err;
+		}
+
 		*old_addr = dn.data_blkaddr;
 		f2fs_truncate_data_blocks_range(&dn, 1);
 		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
-		inc_valid_block_count(sbi, inode, &count);
+
 		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
 					ni.version, true, false);
 	}
-- 
2.36.1

