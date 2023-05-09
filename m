Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F386FD12D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjEIVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbjEIVXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868F8A6E;
        Tue,  9 May 2023 14:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E5AA63771;
        Tue,  9 May 2023 21:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D76AC4339C;
        Tue,  9 May 2023 21:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667233;
        bh=EEhAHG57ZcLMorHka0uFmt+iz7gSFHvA25yERZTrgyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgfhGbIjGwCy4TBgNY2o8XwqbztPjU/wx+uVYkycZNfUFd8s8h7jzgS62N7u6qUv9
         MQ5N/G6Uu3syvmfjOmJMGK4t1yhRxInTSTFjV8qrBuKuwTjK4a/A5bxOfU7oGyGrDF
         XP/oSxwZcZJse4MjRuzmVhZfLIlL5cYLLxLMDVwM5SuDzlEuy5TudSj+4EI4evaukN
         fVlXrC63WDpZNLHofiUz+OjseKaS7wgsgye+VK9HbkUbAvXInDRXXPIc3W+a+63/nH
         DDxqO/FFbxKFWrk4zqsLN7sxw+P21fgWJjRmvtluqZdZqYabyEAE6AV5eK7u+mO/cC
         AdOvSHjfOn5Ew==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Lo <edward.lo@ambergroup.io>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 06/13] fs/ntfs3: Validate MFT flags before replaying logs
Date:   Tue,  9 May 2023 17:20:14 -0400
Message-Id: <20230509212023.22105-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Lo <edward.lo@ambergroup.io>

[ Upstream commit 98bea253aa28ad8be2ce565a9ca21beb4a9419e5 ]

Log load and replay is part of the metadata handle flow during mount
operation. The $MFT record will be loaded and used while replaying logs.
However, a malformed $MFT record, say, has RECORD_FLAG_DIR flag set and
contains an ATTR_ROOT attribute will misguide kernel to treat it as a
directory, and try to free the allocated resources when the
corresponding inode is freed, which will cause an invalid kfree because
the memory hasn't actually been allocated.

[  101.368647] BUG: KASAN: invalid-free in kvfree+0x2c/0x40
[  101.369457]
[  101.369986] CPU: 0 PID: 198 Comm: mount Not tainted 6.0.0-rc7+ #5
[  101.370529] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  101.371362] Call Trace:
[  101.371795]  <TASK>
[  101.372157]  dump_stack_lvl+0x49/0x63
[  101.372658]  print_report.cold+0xf5/0x689
[  101.373022]  ? ni_write_inode+0x754/0xd90
[  101.373378]  ? kvfree+0x2c/0x40
[  101.373698]  kasan_report_invalid_free+0x77/0xf0
[  101.374058]  ? kvfree+0x2c/0x40
[  101.374352]  ? kvfree+0x2c/0x40
[  101.374668]  __kasan_slab_free+0x189/0x1b0
[  101.374992]  ? kvfree+0x2c/0x40
[  101.375271]  kfree+0x168/0x3b0
[  101.375717]  kvfree+0x2c/0x40
[  101.376002]  indx_clear+0x26/0x60
[  101.376316]  ni_clear+0xc5/0x290
[  101.376661]  ntfs_evict_inode+0x45/0x70
[  101.377001]  evict+0x199/0x280
[  101.377432]  iput.part.0+0x286/0x320
[  101.377819]  iput+0x32/0x50
[  101.378166]  ntfs_loadlog_and_replay+0x143/0x320
[  101.378656]  ? ntfs_bio_fill_1+0x510/0x510
[  101.378968]  ? iput.part.0+0x286/0x320
[  101.379367]  ntfs_fill_super+0xecb/0x1ba0
[  101.379729]  ? put_ntfs+0x1d0/0x1d0
[  101.380046]  ? vsprintf+0x20/0x20
[  101.380542]  ? mutex_unlock+0x81/0xd0
[  101.380914]  ? set_blocksize+0x95/0x150
[  101.381597]  get_tree_bdev+0x232/0x370
[  101.382254]  ? put_ntfs+0x1d0/0x1d0
[  101.382699]  ntfs_fs_get_tree+0x15/0x20
[  101.383094]  vfs_get_tree+0x4c/0x130
[  101.383675]  path_mount+0x654/0xfe0
[  101.384203]  ? putname+0x80/0xa0
[  101.384540]  ? finish_automount+0x2e0/0x2e0
[  101.384943]  ? putname+0x80/0xa0
[  101.385362]  ? kmem_cache_free+0x1c4/0x440
[  101.385968]  ? putname+0x80/0xa0
[  101.386666]  do_mount+0xd6/0xf0
[  101.387228]  ? path_mount+0xfe0/0xfe0
[  101.387585]  ? __kasan_check_write+0x14/0x20
[  101.387979]  __x64_sys_mount+0xca/0x110
[  101.388436]  do_syscall_64+0x3b/0x90
[  101.388757]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  101.389289] RIP: 0033:0x7fa0f70e948a
[  101.390048] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 008
[  101.391297] RSP: 002b:00007ffc24fdecc8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[  101.391988] RAX: ffffffffffffffda RBX: 000055932c183060 RCX: 00007fa0f70e948a
[  101.392494] RDX: 000055932c183260 RSI: 000055932c1832e0 RDI: 000055932c18bce0
[  101.393053] RBP: 0000000000000000 R08: 000055932c183280 R09: 0000000000000020
[  101.393577] R10: 00000000c0ed0000 R11: 0000000000000202 R12: 000055932c18bce0
[  101.394044] R13: 000055932c183260 R14: 0000000000000000 R15: 00000000ffffffff
[  101.394747]  </TASK>
[  101.395402]
[  101.396047] Allocated by task 198:
[  101.396724]  kasan_save_stack+0x26/0x50
[  101.397400]  __kasan_slab_alloc+0x6d/0x90
[  101.397974]  kmem_cache_alloc_lru+0x192/0x5a0
[  101.398524]  ntfs_alloc_inode+0x23/0x70
[  101.399137]  alloc_inode+0x3b/0xf0
[  101.399534]  iget5_locked+0x54/0xa0
[  101.400026]  ntfs_iget5+0xaf/0x1780
[  101.400414]  ntfs_loadlog_and_replay+0xe5/0x320
[  101.400883]  ntfs_fill_super+0xecb/0x1ba0
[  101.401313]  get_tree_bdev+0x232/0x370
[  101.401774]  ntfs_fs_get_tree+0x15/0x20
[  101.402224]  vfs_get_tree+0x4c/0x130
[  101.402673]  path_mount+0x654/0xfe0
[  101.403160]  do_mount+0xd6/0xf0
[  101.403537]  __x64_sys_mount+0xca/0x110
[  101.404058]  do_syscall_64+0x3b/0x90
[  101.404333]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  101.404816]
[  101.405067] The buggy address belongs to the object at ffff888008cc9ea0
[  101.405067]  which belongs to the cache ntfs_inode_cache of size 992
[  101.406171] The buggy address is located 232 bytes inside of
[  101.406171]  992-byte region [ffff888008cc9ea0, ffff888008cca280)
[  101.406995]
[  101.408559] The buggy address belongs to the physical page:
[  101.409320] page:00000000dccf19dd refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8cc8
[  101.410654] head:00000000dccf19dd order:2 compound_mapcount:0 compound_pincount:0
[  101.411533] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[  101.412665] raw: 000fffffc0010200 0000000000000000 dead000000000122 ffff888003695140
[  101.413209] raw: 0000000000000000 00000000800e000e 00000001ffffffff 0000000000000000
[  101.413799] page dumped because: kasan: bad access detected
[  101.414213]
[  101.414427] Memory state around the buggy address:
[  101.414991]  ffff888008cc9e80: fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00
[  101.415785]  ffff888008cc9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  101.416933] >ffff888008cc9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  101.417857]                       ^
[  101.418566]  ffff888008cca000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  101.419704]  ffff888008cca080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 136236a25da60..290602724e1e0 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -98,6 +98,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	/* Record should contain $I30 root. */
 	is_dir = rec->flags & RECORD_FLAG_DIR;
 
+	/* MFT_REC_MFT is not a dir */
+	if (is_dir && ino == MFT_REC_MFT) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	inode->i_generation = le16_to_cpu(rec->seq);
 
 	/* Enumerate all struct Attributes MFT. */
-- 
2.39.2

