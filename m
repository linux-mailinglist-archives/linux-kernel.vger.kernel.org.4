Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6A6ADC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjCGKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCGKjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:39:16 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028E550726
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:39:08 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so12656240ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678185547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27gb/Vmx4k0wozNmy7fvDOxlzhfN36LbW43vZixFfHI=;
        b=LB5NNYwJK9A8gI1Ir3XLYf4kX1RUndQW7ukWmZ/6UeKv1mJ46FjWuzjDblQXPJ/keC
         x2RzIGhJth6LYv86bzoVx4l9MrhxvywwNnA9nwIEuRycr/yhDGOFjTouVdHIWofYC1P0
         8LJENbZiGuXb6gNKX8M2srTPFhs53htu3dsFcuznDV1e+3qO5GUZze6QGljPxDdZXkDJ
         YAfs/F3h0XEIwwfLkfhAFmaZn21GtNGv7iReNwS5jzDdIerl6XetpoGdAkUB63VWKeoL
         DxMxjQZDsJLE5zHo7u8armDzw/7FH5B3V9hxCj80DL1LGyR/qR1AlUMa49mS28s379KZ
         UHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27gb/Vmx4k0wozNmy7fvDOxlzhfN36LbW43vZixFfHI=;
        b=XNy9lFcaLFLTLRYo3WPzQPYqutVFVot7OgNjPUz04aFxHF7DJEpCh6EVsKsFmV3B8Z
         KkJ+BHZDVVHy25Q5Qvtn9wXRZfVk/ZfD3Zr570krG9GDKmTe8BggRMhizx4KanNeC+vI
         VJEhHCNatVtIRHN2CGrzmGPUfJUPyJk8Nxb+tQbL3QKMsEOkyX12rja/ZHYCegTqhY5e
         oA0injRHbfPzpxQwHXTX9REQA7XsGLfzc++6/IPJmlgaADIsXgMw46kLn0LauAUNxIhy
         K7jxmtfmbDbK+PRDLko1+6PxH8Cs4kogCir6kQe5x/K/+y1lli3VkXvHF1ECGJw04Ezd
         L6vw==
X-Gm-Message-State: AO0yUKUi5c89QNtKqUr7WgbgRRus428eYLHHitdvdxMs39vS3SUqKgCs
        1f9So7qBvw4n0fsVnvD3TOKd7A==
X-Google-Smtp-Source: AK7set80rMkkDr/jl894AszLa4kNVOz4G6dreNnvMaoZjjE9f5/9fbLebt9VOr6yMgii01BLLVmqcA==
X-Received: by 2002:a2e:3109:0:b0:293:3128:3fd1 with SMTP id x9-20020a2e3109000000b0029331283fd1mr4008745ljx.21.1678185546908;
        Tue, 07 Mar 2023 02:39:06 -0800 (PST)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e9d4d000000b00295965f7495sm2125244ljj.0.2023.03.07.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 02:39:06 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     stable@kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, boyu.mt@taobao.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com,
        Jun Nie <jun.nie@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH RESEND][for-stable 5.10, 5.4, 4.19, 4.14] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
Date:   Tue,  7 Mar 2023 10:38:40 +0000
Message-Id: <20230307103840.2603092-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5c099c4fdc438014d5893629e70a8ba934433ee8 ]

tudor.ambarus@linaro.org: The patch deviates from original upstream
patch, as it had to be backported. Backport this 3 line patch instead
of carring it's dependency:
'commit 6984aef59814 ("ext4: factor out write end code of inline file")'
The dependency conflicts with
'commit a54c4613dac1 ("ext4: fix race writing to an inline_data file while its xattrs are changing")'
and was fixed in:
'commit 11ef08c9eb52 ("Merge branch 'delalloc-buffer-write' into dev")'
Even if backporting the dependency is straight forward (keep the
contents of the second patch together with the changes from the first)
choose to backport just the fix as the refactoring patch brings little
benefit and high risk. Tested the fix with the reproducer and it no longer
complains on linux-{5.10, 5.4, 4.19, 4.14}.y. The original upstream commit
message follows below.

Syzbot report follow issue:
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:227!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3629 Comm: syz-executor212 Not tainted 6.1.0-rc5-syzkaller-00018-g59d0d52c30d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:227
RSP: 0018:ffffc90003b3f368 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880704e16c0 RCX: 0000000000000000
RDX: ffff888021763a80 RSI: ffffffff821e31a4 RDI: 0000000000000006
RBP: 000000000006818e R08: 0000000000000006 R09: 0000000000068199
R10: 0000000000000079 R11: 0000000000000000 R12: 000000000000000b
R13: 0000000000068199 R14: ffffc90003b3f408 R15: ffff8880704e1c82
FS:  000055555723e3c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe8ac9080 CR3: 0000000079f81000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2a3/0x12f0 fs/ext4/inline.c:768
 ext4_write_end+0x242/0xdd0 fs/ext4/inode.c:1313
 ext4_da_write_end+0x3ed/0xa30 fs/ext4/inode.c:3063
 generic_perform_write+0x316/0x570 mm/filemap.c:3764
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bc/0x16e0 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
---[ end trace 0000000000000000 ]---

Above issue may happens as follows:
ext4_da_write_begin
  ext4_da_write_inline_data_begin
    ext4_da_convert_inline_data_to_extent
      ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
ext4_da_write_end

ext4_run_li_request
  ext4_mb_prefetch
    ext4_read_block_bitmap_nowait
      ext4_validate_block_bitmap
        ext4_mark_group_bitmap_corrupted(sb, block_group, EXT4_GROUP_INFO_BBITMAP_CORRUPT)
	 percpu_counter_sub(&sbi->s_freeclusters_counter,grp->bb_free);
	  -> sbi->s_freeclusters_counter become zero
ext4_da_write_begin
  if (ext4_nonda_switch(inode->i_sb)) -> As freeclusters_counter is zero will return true
    *fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
    ext4_write_begin
ext4_da_write_end
  if (write_mode == FALL_BACK_TO_NONDELALLOC)
    ext4_write_end
      if (inline_data)
        ext4_write_inline_data_end
	  ext4_write_inline_data
	    BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
           -> As inode is already convert to extent, so 'pos + len' > inline_size
	   -> then trigger BUG.

To solve this issue, instead of checking ext4_has_inline_data() which
is only cleared after data has been written back, check the
EXT4_STATE_MAY_INLINE_DATA flag in ext4_write_end().

Fixes: f19d5870cbf7 ("ext4: add normal write support for inline data")
Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Reported-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Ye Bin <yebin10@huawei.com>
Link: https://lore.kernel.org/r/20221206144134.1919987-1-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
For RESEND I put stable@kernel.org in To:

 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 355343cf4609..7ac3fa2863c7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1303,7 +1303,8 @@ static int ext4_write_end(struct file *file,
 	bool verity = ext4_verity_in_progress(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
-	if (inline_data) {
+	if (inline_data &&
+	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
 		ret = ext4_write_inline_data_end(inode, pos, len,
 						 copied, page);
 		if (ret < 0) {
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

