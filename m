Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDE74B2D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGGOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjGGOLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:11:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18110EA;
        Fri,  7 Jul 2023 07:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2497619BF;
        Fri,  7 Jul 2023 14:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19996C433C8;
        Fri,  7 Jul 2023 14:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688739107;
        bh=qEVfET8z8S73LvLh3PY54F9PzceMtvGsraHWCNQ8ptE=;
        h=From:To:Cc:Subject:Date:From;
        b=f9d9kcenNHNwGjTe3+QCPUOSC0DBITssUxcSLIJny3F31OcjiAXY4Uy414f5WJcAu
         swryHkHAGt1KVqcs7sxDE/eD3iTp8c1dj1HQrHutgOshLN217AdPw5DJo+0zzIx2eW
         ktC7955R1DVymDtA+1PM5CIbquSKDFIvvElDFKj+GbKf2sGQMxQyv4xrqxkcZvjLOJ
         p7Ry4kcq4w9PEzhziDv32g9Pd0oJnauEmI0rBm6jNibGU9nu348EK2NHWyZi1/gEbe
         2gV2pvL/k/gvZqgtltmT3zSWY30l/HA7VjCVntd3gRVUAaz+nqZ+8cibSLfGeAnHgv
         6H8o8xzjiyX3g==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org,
        syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: flush inode if atomic file is aborted
Date:   Fri,  7 Jul 2023 07:11:42 -0700
Message-ID: <20230707141142.2276510-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's flush the inode being aborted atomic operation to avoid stale dirty
inode during eviction in this call stack:

  f2fs_mark_inode_dirty_sync+0x22/0x40 [f2fs]
  f2fs_abort_atomic_write+0xc4/0xf0 [f2fs]
  f2fs_evict_inode+0x3f/0x690 [f2fs]
  ? sugov_start+0x140/0x140
  evict+0xc3/0x1c0
  evict_inodes+0x17b/0x210
  generic_shutdown_super+0x32/0x120
  kill_block_super+0x21/0x50
  deactivate_locked_super+0x31/0x90
  cleanup_mnt+0x100/0x160
  task_work_run+0x59/0x90
  do_exit+0x33b/0xa50
  do_group_exit+0x2d/0x80
  __x64_sys_exit_group+0x14/0x20
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

This triggers f2fs_bug_on() in f2fs_evict_inode:
 f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));

This fixes the syzbot report:

loop0: detected capacity change from 0 to 131072
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:869!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5014 Comm: syz-executor220 Not tainted 6.4.0-syzkaller-11479-g6cd06ab12d1a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:f2fs_evict_inode+0x172d/0x1e00 fs/f2fs/inode.c:869
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 6a 06 00 00 8b 75 40 ba 01 00 00 00 4c 89 e7 e8 6d ce 06 00 e9 aa fc ff ff e8 63 22 e2 fd <0f> 0b e8 5c 22 e2 fd 48 c7 c0 a8 3a 18 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880273b8000 RSI: ffffffff83a2bd0d RDI: 0000000000000007
RBP: ffff888077db91b0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888029a3c000
R13: ffff888077db9660 R14: ffff888029a3c0b8 R15: ffff888077db9c50
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1909bb9000 CR3: 00000000276a9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:665
 dispose_list+0x117/0x1e0 fs/inode.c:698
 evict_inodes+0x345/0x440 fs/inode.c:748
 generic_shutdown_super+0xaf/0x480 fs/super.c:478
 kill_block_super+0x64/0xb0 fs/super.c:1417
 kill_f2fs_super+0x2af/0x3c0 fs/f2fs/super.c:4704
 deactivate_locked_super+0x98/0x160 fs/super.c:330
 deactivate_super+0xb1/0xd0 fs/super.c:361
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1254
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa9a/0x29a0 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f309be71a09
Code: Unable to access opcode bytes at 0x7f309be719df.
RSP: 002b:00007fff171df518 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f309bef7330 RCX: 00007f309be71a09
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f309bef1e40
R10: 0000000000010600 R11: 0000000000000246 R12: 00007f309bef7330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x172d/0x1e00 fs/f2fs/inode.c:869
Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 6a 06 00 00 8b 75 40 ba 01 00 00 00 4c 89 e7 e8 6d ce 06 00 e9 aa fc ff ff e8 63 22 e2 fd <0f> 0b e8 5c 22 e2 fd 48 c7 c0 a8 3a 18 8d 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003a6fa00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff8880273b8000 RSI: ffffffff83a2bd0d RDI: 0000000000000007
RBP: ffff888077db91b0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff888029a3c000
R13: ffff888077db9660 R14: ffff888029a3c0b8 R15: ffff888077db9c50
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1909bb9000 CR3: 00000000276a9000 CR4: 0000000000350ef0

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0457d620011f..6e5d1039ca76 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -205,6 +205,8 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		f2fs_i_size_write(inode, fi->original_i_size);
 		fi->original_i_size = 0;
 	}
+	/* avoid stale dirty inode during eviction */
+	sync_inode_metadata(inode, 0);
 }
 
 static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
-- 
2.41.0.255.g8b1d071c50-goog

