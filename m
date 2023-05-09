Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B61D6FD0F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbjEIVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjEIVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B37AAA;
        Tue,  9 May 2023 14:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B701063735;
        Tue,  9 May 2023 21:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4328C433A4;
        Tue,  9 May 2023 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667205;
        bh=4gd0VHHIGVTyCdsboHL+9KS/vnbU3v/+7hsVfKv+l/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pe6peqDVoTy6gftJUVKdWx1iXwXVy1CdXzhaVQRucUoz5nFW6JDA6WgfqtNyDkqEw
         s6gFN+Z0k6Op37yGTY2RNpryDh4MHBoXof5pmFXBHmkkEVnfsC2zFsMCjGzRI8twwP
         5UjUuYWjWiJVQzbF6oIKvblcLrPtBG8d3vu1AfCbe/3P7FuBjprCPSECK+KeS9mfBR
         w1kaTFioQnzDY6iPTdE159kfjTHobeDegRF5QYoQq8WGovniiIotNk7nG7sMGEJvlr
         w9P5Q9jAUUFwBlLR6TDOAmA+CxFz2xN/X77PD13CwFwsns+rdP+7c1NeNLgPbqanT1
         A6Y8Fqcgs82gQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>,
        syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.2 04/18] fs/ntfs3: Fix NULL pointer dereference in 'ni_write_inode'
Date:   Tue,  9 May 2023 17:19:42 -0400
Message-Id: <20230509211958.21596-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit db2a3cc6a3481076da6344cc62a80a4e2525f36f ]

Syzbot found the following issue:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010af56000
[0000000000000016] pgd=08000001090da003, p4d=08000001090da003, pud=08000001090ce003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3036 Comm: syz-executor206 Not tainted 6.0.0-rc6-syzkaller-17739-g16c9f284e746 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
pc : ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
lr : ni_write_inode+0xa0/0x798 fs/ntfs3/frecord.c:3226
sp : ffff8000126c3800
x29: ffff8000126c3860 x28: 0000000000000000 x27: ffff0000c8b02000
x26: ffff0000c7502320 x25: ffff0000c7502288 x24: 0000000000000000
x23: ffff80000cbec91c x22: ffff0000c8b03000 x21: ffff0000c8b02000
x20: 0000000000000001 x19: ffff0000c75024d8 x18: 00000000000000c0
x17: ffff80000dd1b198 x16: ffff80000db59158 x15: ffff0000c4b6b500
x14: 00000000000000b8 x13: 0000000000000000 x12: ffff0000c4b6b500
x11: ff80800008be1b60 x10: 0000000000000000 x9 : ffff0000c4b6b500
x8 : 0000000000000000 x7 : ffff800008be1b50 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000008 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 is_rec_inuse fs/ntfs3/ntfs.h:313 [inline]
 ni_write_inode+0xac/0x798 fs/ntfs3/frecord.c:3232
 ntfs_evict_inode+0x54/0x84 fs/ntfs3/inode.c:1744
 evict+0xec/0x334 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput+0x2c4/0x324 fs/inode.c:1774
 ntfs_new_inode+0x7c/0xe0 fs/ntfs3/fsntfs.c:1660
 ntfs_create_inode+0x20c/0xe78 fs/ntfs3/inode.c:1278
 ntfs_create+0x54/0x74 fs/ntfs3/namei.c:100
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 97dafee4 340001b4 f9401328 2a1f03e0 (79402d14)
---[ end trace 0000000000000000 ]---

Above issue may happens as follows:
ntfs_new_inode
  mi_init
    mi->mrec = kmalloc(sbi->record_size, GFP_NOFS); -->failed to allocate memory
      if (!mi->mrec)
        return -ENOMEM;
iput
  iput_final
    evict
      ntfs_evict_inode
        ni_write_inode
	  is_rec_inuse(ni->mi.mrec)-> As 'ni->mi.mrec' is NULL trigger NULL-ptr-deref

To solve above issue if new inode failed make inode bad before call 'iput()' in
'ntfs_new_inode()'.

Reported-by: syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/fsntfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 567563771bf89..8de861ddec600 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1683,6 +1683,7 @@ struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST rno, bool dir)
 
 out:
 	if (err) {
+		make_bad_inode(inode);
 		iput(inode);
 		ni = ERR_PTR(err);
 	}
-- 
2.39.2

