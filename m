Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895B62D5A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiKQI6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiKQI55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:57:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FE6748CF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:57:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NCYhq4fwSz4f3jZn
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 16:57:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgBHPayN93VjOieKAg--.30052S4;
        Thu, 17 Nov 2022 16:57:50 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     almaz.alexandrovich@paragon-software.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, ntfs3@lists.linux.dev
Cc:     yebin10@huawei.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        syzbot+f45957555ed4a808cc7a@syzkaller.appspotmail.com
Subject: [PATCH] ntfs3: fix NULL pointer dereference in 'ni_write_inode'
Date:   Thu, 17 Nov 2022 17:19:12 +0800
Message-Id: <20221117091912.3436127-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgBHPayN93VjOieKAg--.30052S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW7Cr45Jr4Dtw1UKw4Uurg_yoWrArykpF
        sxGr4UGr4ktF12kws2qF1qqry5Jay7CF4UGr4xGry7KF1jqr1UtF18tFW3XryxtrWrJryI
        qr1DZ3y8try8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

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
---
 fs/ntfs3/fsntfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 567563771bf8..8de861ddec60 100644
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
2.31.1

