Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE794661CD2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjAIDpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjAIDpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CF495A0
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:45:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C94960EE3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 03:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CC0C433EF;
        Mon,  9 Jan 2023 03:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673235912;
        bh=o0QGez8JNtfwfRegKYb2IXEmNk+VVLuwDSFz2DvJBSY=;
        h=From:To:Cc:Subject:Date:From;
        b=Dy6vAaYUAxbL0xhJdA/zEa4jCKnVodSGMc2y9Q4A0ow9KBjQxCrDnqHLIbsIXZa2f
         TywH6ZfEZpyz2yPG5trS6msnAOgiPWvdRGF689/7tOTnVZXt+c73hS2ZSJj40cON5b
         1DB/RBLilUSOMCk0SYq0HJOc45t9r67XXCiwulrNyVs9gY399xQy2a3Nge7XowtrWL
         I0KOZxviWblfWtzlRft6Zq4ovvUOxvHeIzgJNnw/xj7DXwTuPrF63qVZoUSU5kXlng
         viw1wNIdvG/P2pRZZ8AYfVRjnb3iad7ZJoK333Ln8ZzSQn+PauwxNNeaiohdMwcIn4
         OLozjyTItmxKw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH 1/5] f2fs: introduce trace_f2fs_replace_atomic_write_block
Date:   Mon,  9 Jan 2023 11:44:49 +0800
Message-Id: <20230109034453.490176-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Commit 3db1de0e582c ("f2fs: change the current atomic write way")
removed old tracepoints, but it missed to add new one, this patch
fixes to introduce trace_f2fs_replace_atomic_write_block to trace
atomic_write commit flow.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c           |  3 +++
 include/trace/events/f2fs.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8b773f3eef3b..c6f6d0618164 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -255,6 +255,9 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	}
 
 	f2fs_put_dnode(&dn);
+
+	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
+					index, *old_addr, new_addr, recover);
 	return 0;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 3852085198fb..fe6bcf5f917d 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1290,6 +1290,43 @@ DEFINE_EVENT(f2fs__page, f2fs_vm_page_mkwrite,
 	TP_ARGS(page, type)
 );
 
+TRACE_EVENT(f2fs_replace_atomic_write_block,
+
+	TP_PROTO(struct inode *inode, struct inode *cow_inode, pgoff_t index,
+			block_t old_addr, block_t new_addr, bool recovery),
+
+	TP_ARGS(inode, cow_inode, index, old_addr, new_addr, recovery),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(ino_t,	cow_ino)
+		__field(pgoff_t, index)
+		__field(block_t, old_addr)
+		__field(block_t, new_addr)
+		__field(bool, recovery)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->cow_ino	= cow_inode->i_ino;
+		__entry->index		= index;
+		__entry->old_addr	= old_addr;
+		__entry->new_addr	= new_addr;
+		__entry->recovery	= recovery;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, cow_ino = %lu, index = %lu, "
+			"old_addr = 0x%llx, new_addr = 0x%llx, recovery = %d",
+		show_dev_ino(__entry),
+		__entry->cow_ino,
+		(unsigned long)__entry->index,
+		(unsigned long long)__entry->old_addr,
+		(unsigned long long)__entry->new_addr,
+		__entry->recovery)
+);
+
 TRACE_EVENT(f2fs_filemap_fault,
 
 	TP_PROTO(struct inode *inode, pgoff_t index, unsigned long ret),
-- 
2.25.1

