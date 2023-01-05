Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B704165E54E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 06:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjAEF6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 00:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjAEF6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 00:58:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96548824;
        Wed,  4 Jan 2023 21:58:52 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c6so5166158pls.4;
        Wed, 04 Jan 2023 21:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tNdvPdu+g7RYVhcJLZlq9O+uy6an39IXGO//h1iwuE=;
        b=jn9Gt5k69FQrB1By9QFNQpLTbmrKZhHwPNdfyJe0rAW/vl2+i85JKiCHohQWMtBFzN
         dWupUyVBx1PUr9D4tRn8bfL7z/lVqWZYpmvy/rFn+lIfV+XbYJw4rmvimQmdQQfwIfcZ
         8kFteXfBPf36bzn4j5lfaJkmsevv3J5kRdWdw46KL1tNTumuKLdN82VISgcWkE6tXYxD
         lH3bPaRXmhF4POU2LFEtg5xjqAAzsuR9SL85bsZ/3LLNt6O0c4PVUQ7K+LZecM8eJHvN
         +G3UQavd/EkyUF+rkXBDN5tqt7MOVws7PMx2BPKesZspF23qb820qDq3X6OSxtOSmxeQ
         NrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tNdvPdu+g7RYVhcJLZlq9O+uy6an39IXGO//h1iwuE=;
        b=BpUefj+BgbcS/AhLFNdVYRKrGpBgrPabQfN8H+1OGbbjkq3jk7G9coDMqnO/QDF1nn
         nBKOchg3m6SfYS/9Nkg/JhOiJvSLu+TdIlNIl74vBdMv3ilVx1wN/F/fjoWIpIWa2D2c
         oUkcGQRtTrm9tDdDZ05U4YWfPq/sC5b3x3LQNeR8HPLoZu1W3h5G/21IKCnvvzopkoqZ
         JbNBqb6/LCSIMmCggAlu6WKSUb5uJ3whgIp5tTfnxm/sWL7qZeoSIkLlO1VdWv8t4OWB
         qdaBv0Jb7gPW1bDxG3WRDPlK/9VACOaojoECKGIaAS7cpCGHeTjKz2p1yBQ7PyEOJ8pZ
         dfrg==
X-Gm-Message-State: AFqh2kpfn22bbOnc/ZXCpdKGyZ3UV6KIgKFjRbmIgufox7Nw6o/MWMFB
        8wksqYoFpIiuzb6EozArWNk=
X-Google-Smtp-Source: AMrXdXsMzpPxQVFf3iC5UduJOyd52AgwM83STADIqtXW9/oQoxz4zKdGwqEtYw6UOdFykFHK9xknAA==
X-Received: by 2002:a05:6a20:b047:b0:ac:10:adfe with SMTP id dx7-20020a056a20b04700b000ac0010adfemr47173436pzb.30.1672898331195;
        Wed, 04 Jan 2023 21:58:51 -0800 (PST)
Received: from carrot.. (i220-108-121-218.s42.a014.ap.plala.or.jp. [220.108.121.218])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b0019141c79b1dsm25111577plb.254.2023.01.04.21.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 21:58:49 -0800 (PST)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        syzbot <syzbot+ede796cecd5296353515@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: fix general protection fault in nilfs_btree_insert()
Date:   Thu,  5 Jan 2023 14:53:56 +0900
Message-Id: <20230105055356.8811-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000bd89e205f0e38355@google.com>
References: <000000000000bd89e205f0e38355@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If nilfs2 reads a corrupted disk image and tries to reads a b-tree node
block by calling __nilfs_btree_get_block() against an invalid virtual
block address, it returns -ENOENT because conversion of the virtual
block address to a disk block address fails.  However, this return
value is the same as the internal code that b-tree lookup routines
return to indicate that the block being searched does not exist, so
functions that operate on that b-tree may misbehave.

When nilfs_btree_insert() receives this spurious 'not found' code from
nilfs_btree_do_lookup(), it misunderstands that the 'not found' check
was successful and continues the insert operation using incomplete
lookup path data, causing the following crash:

 general protection fault, probably for non-canonical address
 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
 KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
 ...
 RIP: 0010:nilfs_btree_get_nonroot_node fs/nilfs2/btree.c:418 [inline]
 RIP: 0010:nilfs_btree_prepare_insert fs/nilfs2/btree.c:1077 [inline]
 RIP: 0010:nilfs_btree_insert+0x6d3/0x1c10 fs/nilfs2/btree.c:1238
 Code: bc 24 80 00 00 00 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89
 ff e8 4b 02 92 fe 4d 8b 3f 49 83 c7 28 4c 89 f8 48 c1 e8 03 <42> 80 3c
 28 00 74 08 4c 89 ff e8 2e 02 92 fe 4d 8b 3f 49 83 c7 02
 ...
 Call Trace:
 <TASK>
  nilfs_bmap_do_insert fs/nilfs2/bmap.c:121 [inline]
  nilfs_bmap_insert+0x20d/0x360 fs/nilfs2/bmap.c:147
  nilfs_get_block+0x414/0x8d0 fs/nilfs2/inode.c:101
  __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
  __block_write_begin fs/buffer.c:2041 [inline]
  block_write_begin+0x93/0x1e0 fs/buffer.c:2102
  nilfs_write_begin+0x9c/0x110 fs/nilfs2/inode.c:261
  generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
  __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
  generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
  call_write_iter include/linux/fs.h:2186 [inline]
  new_sync_write fs/read_write.c:491 [inline]
  vfs_write+0x7dc/0xc50 fs/read_write.c:584
  ksys_write+0x177/0x2a0 fs/read_write.c:637
  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 ...
 </TASK>

This patch fixes the root cause of this problem by replacing the error
code that __nilfs_btree_get_block() returns on block address conversion
failure from -ENOENT to another internal code -EINVAL which means that
the b-tree metadata is corrupted.

By returning -EINVAL, it propagates without glitches, and for all
relevant b-tree operations, functions in the upper bmap layer output
an error message indicating corrupted b-tree metadata via
nilfs_bmap_convert_error(), and code -EIO will be eventually returned
as it should be.

Link: https://lkml.kernel.org/r/000000000000bd89e205f0e38355@google.com
Reported-by: syzbot+ede796cecd5296353515@syzkaller.appspotmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org
---
Hi Andrew, please apply this bugfix.
This fixes the kernel crash above for corrupted disk images like
the one syzbot produced, and presumably fixes some unexpected WARN_ONs
on nilfs2 as well (which I will continue to investigate).

Thanks,
Ryusuke Konishi

fs/nilfs2/btree.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index b9d15c3df3cc..40ce92a332fe 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -480,9 +480,18 @@ static int __nilfs_btree_get_block(const struct nilfs_bmap *btree, __u64 ptr,
 	ret = nilfs_btnode_submit_block(btnc, ptr, 0, REQ_OP_READ, &bh,
 					&submit_ptr);
 	if (ret) {
-		if (ret != -EEXIST)
-			return ret;
-		goto out_check;
+		if (likely(ret == -EEXIST))
+			goto out_check;
+		if (ret == -ENOENT) {
+			/*
+			 * Block address translation failed due to invalid
+			 * value of 'ptr'.  In this case, return internal code
+			 * -EINVAL (broken bmap) to notify bmap layer of fatal
+			 * metadata corruption.
+			 */
+			ret = -EINVAL;
+		}
+		return ret;
 	}
 
 	if (ra) {
-- 
2.34.1

