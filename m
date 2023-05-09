Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E6E6FD0C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEIVUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjEIVTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD15D30F0;
        Tue,  9 May 2023 14:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 692C7634CE;
        Tue,  9 May 2023 21:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CB1C433D2;
        Tue,  9 May 2023 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667182;
        bh=uLRVtIT6H9AEbh3tAShBXIGi/Qzo+ucu2UDpNenffOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3iOBesgSTL1tnwL69L8upFj7adFUjCLPwQNg9eVja2Ryo0klRh4qvyEaK845BZs3
         ykY+ccEFHQD15gP1GP5mvQZBgYt/DQ4Wk9NvayAlMzS9+PicGK0PkouSotsSRBDLYj
         PmJtCWq3xpkbNUilDSPXUSrHcNA9aNzViH5ZI0X7JsmSTFfxIvdUhPjObbP0qjwng+
         O1IOKB1S4ibhYV9IQILPHC+xhZwGpNwGwVDJS0Wj133C6QJTQr7AYnUqmxj/cDV/R8
         D/JkE7EbLSxWioGv2miHu2FSvDamK9/SW1q+JMRZEeNU5OIH6MkodjeFXAdDcl0DZi
         uycK/bcZpnS8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Lo <edward.lo@ambergroup.io>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 08/18] fs/ntfs3: Add length check in indx_get_root
Date:   Tue,  9 May 2023 17:19:16 -0400
Message-Id: <20230509211928.21010-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211928.21010-1-sashal@kernel.org>
References: <20230509211928.21010-1-sashal@kernel.org>
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

[ Upstream commit 08e8cf5f2d9ec383a2e339a2711b62a54ff3fba0 ]

This adds a length check to guarantee the retrieved index root is legit.

[  162.459513] BUG: KASAN: use-after-free in hdr_find_e.isra.0+0x10c/0x320
[  162.460176] Read of size 2 at addr ffff8880037bca99 by task mount/243
[  162.460851]
[  162.461252] CPU: 0 PID: 243 Comm: mount Not tainted 6.0.0-rc7 #42
[  162.461744] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  162.462609] Call Trace:
[  162.462954]  <TASK>
[  162.463276]  dump_stack_lvl+0x49/0x63
[  162.463822]  print_report.cold+0xf5/0x689
[  162.464608]  ? unwind_get_return_address+0x3a/0x60
[  162.465766]  ? hdr_find_e.isra.0+0x10c/0x320
[  162.466975]  kasan_report+0xa7/0x130
[  162.467506]  ? _raw_spin_lock_irq+0xc0/0xf0
[  162.467998]  ? hdr_find_e.isra.0+0x10c/0x320
[  162.468536]  __asan_load2+0x68/0x90
[  162.468923]  hdr_find_e.isra.0+0x10c/0x320
[  162.469282]  ? cmp_uints+0xe0/0xe0
[  162.469557]  ? cmp_sdh+0x90/0x90
[  162.469864]  ? ni_find_attr+0x214/0x300
[  162.470217]  ? ni_load_mi+0x80/0x80
[  162.470479]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  162.470931]  ? ntfs_bread_run+0x190/0x190
[  162.471307]  ? indx_get_root+0xe4/0x190
[  162.471556]  ? indx_get_root+0x140/0x190
[  162.471833]  ? indx_init+0x1e0/0x1e0
[  162.472069]  ? fnd_clear+0x115/0x140
[  162.472363]  ? _raw_spin_lock_irqsave+0x100/0x100
[  162.472731]  indx_find+0x184/0x470
[  162.473461]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  162.474429]  ? indx_find_buffer+0x2d0/0x2d0
[  162.474704]  ? do_syscall_64+0x3b/0x90
[  162.474962]  dir_search_u+0x196/0x2f0
[  162.475381]  ? ntfs_nls_to_utf16+0x450/0x450
[  162.475661]  ? ntfs_security_init+0x3d6/0x440
[  162.475906]  ? is_sd_valid+0x180/0x180
[  162.476191]  ntfs_extend_init+0x13f/0x2c0
[  162.476496]  ? ntfs_fix_post_read+0x130/0x130
[  162.476861]  ? iput.part.0+0x286/0x320
[  162.477325]  ntfs_fill_super+0x11e0/0x1b50
[  162.477709]  ? put_ntfs+0x1d0/0x1d0
[  162.477970]  ? vsprintf+0x20/0x20
[  162.478258]  ? set_blocksize+0x95/0x150
[  162.478538]  get_tree_bdev+0x232/0x370
[  162.478789]  ? put_ntfs+0x1d0/0x1d0
[  162.479038]  ntfs_fs_get_tree+0x15/0x20
[  162.479374]  vfs_get_tree+0x4c/0x130
[  162.479729]  path_mount+0x654/0xfe0
[  162.480124]  ? putname+0x80/0xa0
[  162.480484]  ? finish_automount+0x2e0/0x2e0
[  162.480894]  ? putname+0x80/0xa0
[  162.481467]  ? kmem_cache_free+0x1c4/0x440
[  162.482280]  ? putname+0x80/0xa0
[  162.482714]  do_mount+0xd6/0xf0
[  162.483264]  ? path_mount+0xfe0/0xfe0
[  162.484782]  ? __kasan_check_write+0x14/0x20
[  162.485593]  __x64_sys_mount+0xca/0x110
[  162.486024]  do_syscall_64+0x3b/0x90
[  162.486543]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  162.487141] RIP: 0033:0x7f9d374e948a
[  162.488324] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 008
[  162.489728] RSP: 002b:00007ffe30e73d18 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[  162.490971] RAX: ffffffffffffffda RBX: 0000561cdb43a060 RCX: 00007f9d374e948a
[  162.491669] RDX: 0000561cdb43a260 RSI: 0000561cdb43a2e0 RDI: 0000561cdb442af0
[  162.492050] RBP: 0000000000000000 R08: 0000561cdb43a280 R09: 0000000000000020
[  162.492459] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 0000561cdb442af0
[  162.493183] R13: 0000561cdb43a260 R14: 0000000000000000 R15: 00000000ffffffff
[  162.493644]  </TASK>
[  162.493908]
[  162.494214] The buggy address belongs to the physical page:
[  162.494761] page:000000003e38a3d5 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x37bc
[  162.496064] flags: 0xfffffc0000000(node=0|zone=1|lastcpupid=0x1fffff)
[  162.497278] raw: 000fffffc0000000 ffffea00000df1c8 ffffea00000df008 0000000000000000
[  162.498928] raw: 0000000000000000 0000000000240000 00000000ffffffff 0000000000000000
[  162.500542] page dumped because: kasan: bad access detected
[  162.501057]
[  162.501242] Memory state around the buggy address:
[  162.502230]  ffff8880037bc980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.502977]  ffff8880037bca00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.503522] >ffff8880037bca80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.503963]                             ^
[  162.504370]  ffff8880037bcb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[  162.504766]  ffff8880037bcb80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Signed-off-by: Edward Lo <edward.lo@ambergroup.io>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 51ab759546403..b6e5c34070c83 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -986,6 +986,7 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct ATTRIB *a;
 	const struct INDEX_NAMES *in = &s_index_names[indx->type];
+	struct INDEX_ROOT *root = NULL;
 
 	a = ni_find_attr(ni, NULL, &le, ATTR_ROOT, in->name, in->name_len, NULL,
 			 mi);
@@ -995,7 +996,15 @@ struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (attr)
 		*attr = a;
 
-	return resident_data_ex(a, sizeof(struct INDEX_ROOT));
+	root = resident_data_ex(a, sizeof(struct INDEX_ROOT));
+
+	/* length check */
+	if (root && offsetof(struct INDEX_ROOT, ihdr) + le32_to_cpu(root->ihdr.used) >
+			le32_to_cpu(a->res.data_size)) {
+		return NULL;
+	}
+
+	return root;
 }
 
 static int indx_write(struct ntfs_index *indx, struct ntfs_inode *ni,
-- 
2.39.2

