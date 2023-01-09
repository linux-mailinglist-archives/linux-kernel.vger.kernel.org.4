Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD66661CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbjAIDpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjAIDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:45:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D611593
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEEE8B8085B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8769EC433F0;
        Mon,  9 Jan 2023 03:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673235915;
        bh=hVQIDpSVJOnPY2pK3qWpbcFhTb9CAdeMNX3yCL8XtEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tjJos42kd7YwDy512Qj+aLjV4Lf4PU/FjJhfrLf/9lBdLNo8IV4QeYNs4yxC6TXdn
         LCk6WkCi4srQ/ohEXXB8RUPAPD0oDBPiVtQ3hYVh2j/BBoJKKfDi21Oj+gXI6tucyN
         azQGIomcooCa+UMy1wTUrISbPzyjY0/Gzd9by6iz/3VuArvhLCEPhcWo42enhqRVgn
         PzMSaOd0YiKYCJZcjlPDvLNP1CXttCtFTqpJ2HAuenfd/0op4YNFEwfJ1bNqShu9bK
         XeqL4Sg0O3/3/bRFqJxuO4HDsFrBxKiZJnxOCpQg9MDiKYP1c0KYGQ4Tk4QmLyJOME
         SbusW1M3r6woQ==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 3/5] f2fs: fix to abort atomic write only during do_exist()
Date:   Mon,  9 Jan 2023 11:44:51 +0800
Message-Id: <20230109034453.490176-3-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109034453.490176-1-chao@kernel.org>
References: <20230109034453.490176-1-chao@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7a10f0177e11 ("f2fs: don't give partially written atomic data
from process crash") attempted to drop atomic write data after process
crash, however, f2fs_abort_atomic_write() may be called from noncrash
case, fix it by adding missed PF_EXITING check condition
f2fs_file_flush().

- application crashs
 - do_exit
  - exit_signals -- sets PF_EXITING
  - exit_files
   - put_files_struct
    - close_files
     - filp_close
      - flush (f2fs_file_flush)
       - check atomic_write_task && PF_EXITING
       - f2fs_abort_atomic_write

Fixes: 7a10f0177e11 ("f2fs: don't give partially written atomic data from process crash")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 434c0d89c145..7b62c533f6d3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1876,7 +1876,8 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
 	 * until all the writers close its file. Since this should be done
 	 * before dropping file lock, it needs to do in ->flush.
 	 */
-	if (F2FS_I(inode)->atomic_write_task == current)
+	if (F2FS_I(inode)->atomic_write_task == current &&
+				(current->flags & PF_EXITING))
 		f2fs_abort_atomic_write(inode, true);
 	return 0;
 }
-- 
2.25.1

