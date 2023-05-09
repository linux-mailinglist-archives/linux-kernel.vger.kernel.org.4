Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BF86FD0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjEIVVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjEIVUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381777ABB;
        Tue,  9 May 2023 14:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20B676373F;
        Tue,  9 May 2023 21:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445EAC43445;
        Tue,  9 May 2023 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667205;
        bh=7y9NwjrTWdltFZ82xwZxKSxXc6t6dVR7aMslbcuAWJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PULfvVFgkZCDFFX/VUrUu06sZ9Nd+zeAmrFUCj0ubZF37555JJqdgK06jaWgyInfD
         Tg1Kpaw0DOb6ASROyCUmTXY6UT+vrf27lCYIi4GixDtJlngQSEfVNozDcb9czrfuyM
         BTR5x00I5O+xDOgvo1F4N2xTDDTnzNFgbNyiuUNewEBH978i7xSEpbpGYg7lZV6ZBC
         voXdNGNcnH8QkbIZ9kLQgAlBgixV75/SaSfw/rtp2Sh8uRZIx/1p/7gnD9MBkgXK/n
         s5bfZRh1e3qYikKYVmrBOQjlv/Ezdwu0/CQRQk6ov9p45qwUjWsY8OfOgeqIaXiiNO
         VlQUW+5N11GDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Lo <edward.lo@ambergroup.io>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.2 05/18] fs/ntfs3: Enhance the attribute size check
Date:   Tue,  9 May 2023 17:19:43 -0400
Message-Id: <20230509211958.21596-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211958.21596-1-sashal@kernel.org>
References: <20230509211958.21596-1-sashal@kernel.org>
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

[ Upstream commit 4f082a7531223a438c757bb20e304f4c941c67a8 ]

This combines the overflow and boundary check so that all attribute size
will be properly examined while enumerating them.

[  169.181521] BUG: KASAN: slab-out-of-bounds in run_unpack+0x2e3/0x570
[  169.183161] Read of size 1 at addr ffff8880094b6240 by task mount/247
[  169.184046]
[  169.184925] CPU: 0 PID: 247 Comm: mount Not tainted 6.0.0-rc7+ #3
[  169.185908] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  169.187066] Call Trace:
[  169.187492]  <TASK>
[  169.188049]  dump_stack_lvl+0x49/0x63
[  169.188495]  print_report.cold+0xf5/0x689
[  169.188964]  ? run_unpack+0x2e3/0x570
[  169.189331]  kasan_report+0xa7/0x130
[  169.189714]  ? run_unpack+0x2e3/0x570
[  169.190079]  __asan_load1+0x51/0x60
[  169.190634]  run_unpack+0x2e3/0x570
[  169.191290]  ? run_pack+0x840/0x840
[  169.191569]  ? run_lookup_entry+0xb3/0x1f0
[  169.192443]  ? mi_enum_attr+0x20a/0x230
[  169.192886]  run_unpack_ex+0xad/0x3e0
[  169.193276]  ? run_unpack+0x570/0x570
[  169.193557]  ? ni_load_mi+0x80/0x80
[  169.193889]  ? debug_smp_processor_id+0x17/0x20
[  169.194236]  ? mi_init+0x4a/0x70
[  169.194496]  attr_load_runs_vcn+0x166/0x1c0
[  169.194851]  ? attr_data_write_resident+0x250/0x250
[  169.195188]  mi_read+0x133/0x2c0
[  169.195481]  ntfs_iget5+0x277/0x1780
[  169.196017]  ? call_rcu+0x1c7/0x330
[  169.196392]  ? ntfs_get_block_bmap+0x70/0x70
[  169.196708]  ? evict+0x223/0x280
[  169.197014]  ? __kmalloc+0x33/0x540
[  169.197305]  ? wnd_init+0x15b/0x1b0
[  169.197599]  ntfs_fill_super+0x1026/0x1ba0
[  169.197994]  ? put_ntfs+0x1d0/0x1d0
[  169.198299]  ? vsprintf+0x20/0x20
[  169.198583]  ? mutex_unlock+0x81/0xd0
[  169.198930]  ? set_blocksize+0x95/0x150
[  169.199269]  get_tree_bdev+0x232/0x370
[  169.199750]  ? put_ntfs+0x1d0/0x1d0
[  169.200094]  ntfs_fs_get_tree+0x15/0x20
[  169.200431]  vfs_get_tree+0x4c/0x130
[  169.200714]  path_mount+0x654/0xfe0
[  169.201067]  ? putname+0x80/0xa0
[  169.201358]  ? finish_automount+0x2e0/0x2e0
[  169.201965]  ? putname+0x80/0xa0
[  169.202445]  ? kmem_cache_free+0x1c4/0x440
[  169.203075]  ? putname+0x80/0xa0
[  169.203414]  do_mount+0xd6/0xf0
[  169.203719]  ? path_mount+0xfe0/0xfe0
[  169.203977]  ? __kasan_check_write+0x14/0x20
[  169.204382]  __x64_sys_mount+0xca/0x110
[  169.204711]  do_syscall_64+0x3b/0x90
[  169.205059]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  169.205571] RIP: 0033:0x7f67a80e948a
[  169.206327] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 008
[  169.208296] RSP: 002b:00007ffddf020f58 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
[  169.209253] RAX: ffffffffffffffda RBX: 000055e2547a6060 RCX: 00007f67a80e948a
[  169.209777] RDX: 000055e2547a6260 RSI: 000055e2547a62e0 RDI: 000055e2547aeaf0
[  169.210342] RBP: 0000000000000000 R08: 000055e2547a6280 R09: 0000000000000020
[  169.210843] R10: 00000000c0ed0000 R11: 0000000000000202 R12: 000055e2547aeaf0
[  169.211307] R13: 000055e2547a6260 R14: 0000000000000000 R15: 00000000ffffffff
[  169.211913]  </TASK>
[  169.212304]
[  169.212680] Allocated by task 0:
[  169.212963] (stack is not available)
[  169.213200]
[  169.213472] The buggy address belongs to the object at ffff8880094b5e00
[  169.213472]  which belongs to the cache UDP of size 1152
[  169.214095] The buggy address is located 1088 bytes inside of
[  169.214095]  1152-byte region [ffff8880094b5e00, ffff8880094b6280)
[  169.214639]
[  169.215004] The buggy address belongs to the physical page:
[  169.215766] page:000000002e324c8c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x94b4
[  169.218412] head:000000002e324c8c order:2 compound_mapcount:0 compound_pincount:0
[  169.219078] flags: 0xfffffc0010200(slab|head|node=0|zone=1|lastcpupid=0x1fffff)
[  169.220272] raw: 000fffffc0010200 0000000000000000 dead000000000122 ffff888002409b40
[  169.221006] raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
[  169.222320] page dumped because: kasan: bad access detected
[  169.222922]
[  169.223119] Memory state around the buggy address:
[  169.224056]  ffff8880094b6100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.224908]  ffff8880094b6180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.225677] >ffff8880094b6200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.226445]                                            ^
[  169.227055]  ffff8880094b6280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  169.227638]  ffff8880094b6300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/record.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index defce6a5c8e1b..abfe004774c03 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -220,11 +220,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
-		if (off + asize < off) {
-			/* overflow check */
-			return NULL;
-		}
-
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -247,8 +242,8 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if ((t32 & 0xf) || (t32 > 0x100))
 		return NULL;
 
-	/* Check boundary. */
-	if (off + asize > used)
+	/* Check overflow and boundary. */
+	if (off + asize < off || off + asize > used)
 		return NULL;
 
 	/* Check size of attribute. */
-- 
2.39.2

