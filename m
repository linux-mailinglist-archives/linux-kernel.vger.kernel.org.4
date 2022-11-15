Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB4629AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiKONja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238294AbiKONj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:39:28 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7933B120A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:39:27 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBS2H3ZrBzmVyK;
        Tue, 15 Nov 2022 21:39:03 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (7.193.23.147) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:39:24 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:39:23 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <ericvh@gmail.com>, <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <linux_oss@crudebyte.com>, <dhowells@redhat.com>,
        <jlayton@kernel.org>, <v9fs-developer@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        <syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com>
Subject: [PATCH v2] fscache: fix OOB Read in __fscache_acquire_volume
Date:   Tue, 15 Nov 2022 14:04:47 +0000
Message-ID: <20221115140447.2971680-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

Syzbot reported slab-out-of-bounds Read in __fscache_acquire_volume.

==================================================================
BUG: KASAN: slab-out-of-bounds in memcmp+0x16f/0x1c0 lib/string.c:757
Read of size 8 at addr ffff888016f3aa90 by task syz-executor344/3613

CPU: 0 PID: 3613 Comm: syz-executor344 Not tainted
6.0.0-rc2-syzkaller-00327-g8379c0b31fbc #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS
Google 07/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 memcmp+0x16f/0x1c0 lib/string.c:757
 memcmp include/linux/fortify-string.h:420 [inline]
 fscache_volume_same fs/fscache/volume.c:133 [inline]
 fscache_hash_volume fs/fscache/volume.c:171 [inline]
 __fscache_acquire_volume+0x76c/0x1080 fs/fscache/volume.c:328
 fscache_acquire_volume include/linux/fscache.h:204 [inline]
 v9fs_cache_session_get_cookie+0x143/0x240 fs/9p/cache.c:34
 v9fs_session_init+0x1166/0x1810 fs/9p/v9fs.c:473
 v9fs_mount+0xba/0xc90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d5064b1d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1700c028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd1700c060 RCX: 00007f7d5064b1d9
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000200 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000f4240
R13: 0000000000000000 R14: 00007ffd1700c04c R15: 00007ffd1700c050
==================================================================

The type of a->key[0] is char in fscache_volume_same(). If the length of
cache volume key is greater than 127, the value of a->key[0] is less
than 0. In this case, klen becomes much larger than 255 after type
conversion, because the type of klen is size_t. As a result, memcmp() is
read out of bounds. Fix this by adding a check on the length of the key
in fscache_alloc_volume().
---
v1 -> v2:
- Make sure the length of cache volume key (klen) fits a signed char
before writing key[0] that'd benefit everyone, thanks to Dominique
Martinet.

Reported-by: syzbot+a76f6a6e524cf2080aa3@syzkaller.appspotmail.com
Fixes: 62ab63352350 ("fscache: Implement volume registration")
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 fs/fscache/volume.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
index a058e0136bfe..cc206d5e4cc7 100644
--- a/fs/fscache/volume.c
+++ b/fs/fscache/volume.c
@@ -230,6 +230,8 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	 * hashing easier.
 	 */
 	klen = strlen(volume_key);
+	if (klen > 127)
+		goto err_cache;
 	hlen = round_up(1 + klen + 1, sizeof(__le32));
 	key = kzalloc(hlen, GFP_KERNEL);
 	if (!key)
-- 
2.25.1

