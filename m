Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0874DBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjGJRCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGJRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A437FD7;
        Mon, 10 Jul 2023 10:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2217161130;
        Mon, 10 Jul 2023 17:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E573C433C7;
        Mon, 10 Jul 2023 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689008564;
        bh=Gfbro5z1Kt5R98Wc9n3qs0pE9M2SXUT4zakI1+0gLNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXJiu86eMqlhLTHh2hjCceH7GoXNQ8cIw/PSdl3Ul4K57rshZ6b7PQhzjKhc7HgDQ
         v8WZjUIPTDiRhhVC+udX6XBZSHkbLa0Ta7by8nOdv6r6f7qLmsnfRz5mSQE7NtmCm0
         6I1dEuLdD2uYAREAO3EbX/IQV/duLv4sth4gvDr/h8bP0hF9ryGB1UERK2t4lCXybX
         zEYK7pycafurJ49f2DO7S0lKi59z6vV4hDfdQcrK4l7oBd6yOpJ4hgOvw+6ubYW9Qm
         VIryyovukuv3AbtSMlDE/x7soqkG3NY147elQFW8iZ4+sAhnpyOg/ShPgaIip0+BMp
         95IKiADXnFnRg==
Date:   Mon, 10 Jul 2023 10:02:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xfs WARNING on v6.5-rc1 kernel
Message-ID: <20230710170243.GF11456@frogsfrogsfrogs>
References: <17881cf776b2c19dcd5a6d628fdfb54dae0eb4f8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17881cf776b2c19dcd5a6d628fdfb54dae0eb4f8.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:29:29PM -0400, Jeff Layton wrote:
> I hit this this morning while running generic/013 (fsstress), with a
> kernel based on v6.5-rc1. The main changes on top of this are timestamp
> related, so I doubt they're a factor here.
> 
> Is this some of the flexarray hardening?

Yes.

https://lore.kernel.org/linux-xfs/ZI+3QXDHiohgv%2FPb@dread.disaster.area/
https://lore.kernel.org/linux-xfs/bug-217522-201763-D34HpuP9xe@https.bugzilla.kernel.org%2F/
https://lore.kernel.org/linux-xfs/Y9xiYmVLRIKdpJcC@work/

--D

> [ 2704.665314] run fstests generic/013 at 2023-07-10 16:09:58
> [ 2705.646507] XFS (loop16): Unmounting Filesystem 3058c032-3f67-4fb9-b24e-c1414b0b532b
> [ 2705.820402] XFS (loop16): Mounting V5 Filesystem 3058c032-3f67-4fb9-b24e-c1414b0b532b
> [ 2705.838655] XFS (loop16): Ending clean mount
> [ 2705.916080] ------------[ cut here ]------------
> [ 2705.917615] memcpy: detected field-spanning write (size 2) of single field "(char *)name_loc->nameval" at fs/xfs/libxfs/xfs_attr_leaf.c:1559 (size 1)
> [ 2705.921569] WARNING: CPU: 6 PID: 48206 at fs/xfs/libxfs/xfs_attr_leaf.c:1559 xfs_attr3_leaf_add_work+0x4ee/0x530 [xfs]
> [ 2705.926783] Modules linked in: xfs nls_iso8859_1 nls_cp437 vfat fat ext4 9p crc16 mbcache netfs jbd2 kvm_intel cirrus virtio_net kvm joydev drm_shmem_helper net_failover pcspkr virtio_balloon 9pnet_virtio psmouse irqbypass failover drm_kms_helper evdev button drm loop dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic nvme virtio_blk nvme_core t10_pi aesni_intel virtio_pci crc64_rocksoft_generic crypto_simd cryptd crc64_rocksoft virtio i6300esb crc64 virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
> [ 2705.942668] CPU: 6 PID: 48206 Comm: fsstress Not tainted 6.5.0-rc1+ #13
> [ 2705.945361] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [ 2705.947758] RIP: 0010:xfs_attr3_leaf_add_work+0x4ee/0x530 [xfs]
> [ 2705.949442] Code: fe ff ff b9 01 00 00 00 4c 89 fe 48 c7 c2 c8 2e fc c0 48 c7 c7 10 2f fc c0 48 89 44 24 08 c6 05 ac 9c 0e 00 01 e8 a2 de 67 d0 <0f> 0b 48 8b 44 24 08 e9 88 fe ff ff 80 3d 93 9c 0e 00 00 0f 85 bd
> [ 2705.953536] RSP: 0018:ffffb52ac29bb8c0 EFLAGS: 00010282
> [ 2705.954925] RAX: 0000000000000000 RBX: ffffb52ac29bb990 RCX: 0000000000000000
> [ 2705.956604] RDX: 0000000000000002 RSI: ffffffff92612d95 RDI: 00000000ffffffff
> [ 2705.958998] RBP: ffffb52ac29bb924 R08: 0000000000000000 R09: ffffb52ac29bb760
> [ 2705.960903] R10: 0000000000000003 R11: ffffffff928c1aa8 R12: ffff8ecf3adc8050
> [ 2705.962537] R13: ffff8ecf3adc8000 R14: ffff8ecf3adc8fcc R15: 0000000000000002
> [ 2705.964083] FS:  00007fcb152f4740(0000) GS:ffff8ed077d80000(0000) knlGS:0000000000000000
> [ 2705.965752] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2705.967124] CR2: 00007ff8022cd2d8 CR3: 000000015e1d2005 CR4: 0000000000060ee0
> [ 2705.969279] Call Trace:
> [ 2705.970318]  <TASK>
> [ 2705.971321]  ? xfs_attr3_leaf_add_work+0x4ee/0x530 [xfs]
> [ 2705.973729]  ? __warn+0x7d/0x130
> [ 2705.974822]  ? xfs_attr3_leaf_add_work+0x4ee/0x530 [xfs]
> [ 2705.976251]  ? report_bug+0x18d/0x1c0
> [ 2705.977242]  ? handle_bug+0x3c/0x80
> [ 2705.978282]  ? exc_invalid_op+0x13/0x60
> [ 2705.979310]  ? asm_exc_invalid_op+0x16/0x20
> [ 2705.980648]  ? xfs_attr3_leaf_add_work+0x4ee/0x530 [xfs]
> [ 2705.982645]  xfs_attr3_leaf_add+0x173/0x1e0 [xfs]
> [ 2705.984131]  xfs_attr_shortform_to_leaf+0x21d/0x230 [xfs]
> [ 2705.985415]  xfs_attr_set_iter+0x766/0x900 [xfs]
> [ 2705.986514]  ? path_setxattr+0xc7/0xe0
> [ 2705.987324]  xfs_xattri_finish_update+0x18/0x50 [xfs]
> [ 2705.988486]  xfs_attr_finish_item+0x1a/0xb0 [xfs]
> [ 2705.989566]  xfs_defer_finish_noroll+0x192/0x6e0 [xfs]
> [ 2705.990714]  __xfs_trans_commit+0x242/0x360 [xfs]
> [ 2705.991768]  xfs_attr_set+0x462/0x680 [xfs]
> [ 2705.993079]  xfs_xattr_set+0x89/0xe0 [xfs]
> [ 2705.994183]  __vfs_setxattr+0x95/0xd0
> [ 2705.995160]  __vfs_setxattr_noperm+0x73/0x1d0
> [ 2705.996536]  vfs_setxattr+0x9b/0x180
> [ 2705.997510]  setxattr+0x88/0xa0
> [ 2705.998249]  ? __pfx_free_object_rcu+0x10/0x10
> [ 2705.999190]  ? __call_rcu_common.constprop.0+0x107/0x220
> [ 2706.000196]  ? user_path_at_empty+0x40/0x50
> [ 2706.001045]  ? kmem_cache_free+0x160/0x380
> [ 2706.001881]  ? preempt_count_add+0x47/0xa0
> [ 2706.002719]  ? __mnt_want_write+0x61/0x90
> [ 2706.003528]  path_setxattr+0xc7/0xe0
> [ 2706.004277]  __x64_sys_setxattr+0x27/0x30
> [ 2706.005074]  do_syscall_64+0x3b/0x90
> [ 2706.005800]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 2706.006739] RIP: 0033:0x7fcb1540515e
> [ 2706.007628] Code: 48 8b 0d ad 6c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 bc 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7a 6c 0c 00 f7 d8 64 89 01 48
> [ 2706.010450] RSP: 002b:00007fffe4df12d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
> [ 2706.011976] RAX: ffffffffffffffda RBX: 0000000000000061 RCX: 00007fcb1540515e
> [ 2706.013103] RDX: 0000000001548010 RSI: 00007fffe4df1320 RDI: 000000000155cf50
> [ 2706.014103] RBP: 0000000001548071 R08: 0000000000000000 R09: 0000000000000000
> [ 2706.015177] R10: 0000000000000061 R11: 0000000000000246 R12: 0000000001548010
> [ 2706.016236] R13: 0000000001548071 R14: 0410410410410411 R15: 0000000001526450
> [ 2706.017238]  </TASK>
> [ 2706.017817] ---[ end trace 0000000000000000 ]---
> [ 2706.737755] ------------[ cut here ]------------
> [ 2706.739255] memmove: detected field-spanning write (size 24) of single field "entry" at fs/xfs/libxfs/xfs_attr_leaf.c:2235 (size 8)
> [ 2706.743694] WARNING: CPU: 1 PID: 48206 at fs/xfs/libxfs/xfs_attr_leaf.c:2235 xfs_attr3_leaf_remove+0x4a7/0x4d0 [xfs]
> [ 2706.747045] Modules linked in: xfs nls_iso8859_1 nls_cp437 vfat fat ext4 9p crc16 mbcache netfs jbd2 kvm_intel cirrus virtio_net kvm joydev drm_shmem_helper net_failover pcspkr virtio_balloon 9pnet_virtio psmouse irqbypass failover drm_kms_helper evdev button drm loop dm_mod zram zsmalloc crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 sha512_generic nvme virtio_blk nvme_core t10_pi aesni_intel virtio_pci crc64_rocksoft_generic crypto_simd cryptd crc64_rocksoft virtio i6300esb crc64 virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring serio_raw btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel xor raid6_pq autofs4
> [ 2706.763271] CPU: 1 PID: 48206 Comm: fsstress Tainted: G        W          6.5.0-rc1+ #13
> [ 2706.765484] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
> [ 2706.767821] RIP: 0010:xfs_attr3_leaf_remove+0x4a7/0x4d0 [xfs]
> [ 2706.769821] Code: c7 c2 00 30 fc c0 48 89 c6 48 c7 c7 08 2e fc c0 44 89 44 24 14 4c 89 4c 24 08 48 89 04 24 c6 05 30 6e 0e 00 01 e8 29 b0 67 d0 <0f> 0b 44 8b 44 24 14 4c 8b 4c 24 08 48 8b 04 24 e9 62 fd ff ff e8
> [ 2706.774843] RSP: 0018:ffffb52ac29bba20 EFLAGS: 00010282
> [ 2706.776465] RAX: 0000000000000000 RBX: 0000000000000f08 RCX: 0000000000000000
> [ 2706.778427] RDX: 0000000000000002 RSI: ffffffff92612d95 RDI: 00000000ffffffff
> [ 2706.780343] RBP: ffffb52ac29bbc70 R08: 0000000000000000 R09: ffffb52ac29bb8c0
> [ 2706.782170] R10: 0000000000000003 R11: ffffffff928c1aa8 R12: ffff8ecf3adc8050
> [ 2706.783934] R13: ffff8ecf61308900 R14: ffff8ecf3adc8000 R15: 0000000000000fcc
> [ 2706.786138] FS:  00007fcb152f4740(0000) GS:ffff8ed077c40000(0000) knlGS:0000000000000000
> [ 2706.788370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2706.790691] CR2: 0000000001606000 CR3: 000000015e1d2005 CR4: 0000000000060ee0
> [ 2706.792692] Call Trace:
> [ 2706.793721]  <TASK>
> [ 2706.794717]  ? xfs_attr3_leaf_remove+0x4a7/0x4d0 [xfs]
> [ 2706.796542]  ? __warn+0x7d/0x130
> [ 2706.797701]  ? xfs_attr3_leaf_remove+0x4a7/0x4d0 [xfs]
> [ 2706.799435]  ? report_bug+0x18d/0x1c0
> [ 2706.800684]  ? handle_bug+0x3c/0x80
> [ 2706.801938]  ? exc_invalid_op+0x13/0x60
> [ 2706.803272]  ? asm_exc_invalid_op+0x16/0x20
> [ 2706.804474]  ? xfs_attr3_leaf_remove+0x4a7/0x4d0 [xfs]
> [ 2706.806068]  xfs_attr_leaf_removename+0xad/0x110 [xfs]
> [ 2706.808661]  ? xfs_defer_add+0x57/0x160 [xfs]
> [ 2706.810164]  xfs_attr_set_iter+0x63/0x900 [xfs]
> [ 2706.811611]  ? removexattr+0x77/0x110
> [ 2706.812779]  xfs_xattri_finish_update+0x18/0x50 [xfs]
> [ 2706.814338]  xfs_attr_finish_item+0x1a/0xb0 [xfs]
> [ 2706.815799]  xfs_defer_finish_noroll+0x192/0x6e0 [xfs]
> [ 2706.817405]  __xfs_trans_commit+0x242/0x360 [xfs]
> [ 2706.818916]  xfs_attr_set+0x462/0x680 [xfs]
> [ 2706.820252]  xfs_xattr_set+0x89/0xe0 [xfs]
> [ 2706.822251]  __vfs_removexattr+0x7f/0xb0
> [ 2706.823463]  __vfs_removexattr_locked+0xb7/0x140
> [ 2706.824648]  vfs_removexattr+0x54/0x100
> [ 2706.825667]  removexattr+0x77/0x110
> [ 2706.826830]  ? __pfx_free_object_rcu+0x10/0x10
> [ 2706.827853]  ? __call_rcu_common.constprop.0+0x107/0x220
> [ 2706.828989]  ? user_path_at_empty+0x40/0x50
> [ 2706.830468]  ? kmem_cache_free+0x160/0x380
> [ 2706.831638]  ? preempt_count_add+0x47/0xa0
> [ 2706.832611]  ? __mnt_want_write+0x61/0x90
> [ 2706.833569]  path_removexattr+0x9f/0xc0
> [ 2706.834506]  __x64_sys_removexattr+0x17/0x20
> [ 2706.835443]  do_syscall_64+0x3b/0x90
> [ 2706.836267]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [ 2706.837302] RIP: 0033:0x7fcb1540512b
> [ 2706.838118] Code: f0 ff ff 73 01 c3 48 8b 0d da 6c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 c5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad 6c 0c 00 f7 d8 64 89 01 48
> [ 2706.841389] RSP: 002b:00007fffe4df1318 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
> [ 2706.842767] RAX: ffffffffffffffda RBX: 000000000000019e RCX: 00007fcb1540512b
> [ 2706.844024] RDX: 0000000000000000 RSI: 00007fffe4df1340 RDI: 000000000155d270
> [ 2706.845254] RBP: 00000000015345a0 R08: 0000000000000064 R09: 0000000000000000
> [ 2706.846557] R10: 0000000000000000 R11: 0000000000000246 R12: 028f5c28f5c28f5c
> [ 2706.847786] R13: 8f5c28f5c28f5c29 R14: 00000000004054b0 R15: 00007fcb152f46c8
> [ 2706.849029]  </TASK>
> [ 2706.849578] ---[ end trace 0000000000000000 ]---
> 
> 
> For reference:
> 
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 1555)        if (entry->flags & XFS_ATTR_LOCAL) {
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 1556)                name_loc = xfs_attr3_leaf_name_local(leaf, args->index);
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 1557)                name_loc->namelen = args->namelen;
> 053b5758cbc09 fs/xfs/xfs_attr_leaf.c        (Nathan Scott        2006-03-17 17:29:09 +1100 1558)                name_loc->valuelen = cpu_to_be16(args->valuelen);
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 1559)                memcpy((char *)name_loc->nameval, args->name, args->namelen);
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 1560)                memcpy((char *)&name_loc->nameval[args->namelen], args->value,
> 053b5758cbc09 fs/xfs/xfs_attr_leaf.c        (Nathan Scott        2006-03-17 17:29:09 +1100 1561)                                   be16_to_cpu(name_loc->valuelen));
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 1562)        } else {
> 
> [...]
> 
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 2233) 
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2234)        tmp = (ichdr.count - args->index) * sizeof(xfs_attr_leaf_entry_t);
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2235)        memmove(entry, entry + 1, tmp);
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2236)        ichdr.count--;
> 1d9025e56143c fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2012-06-22 18:50:14 +1000 2237)        xfs_trans_log_buf(args->trans, bp,
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2238)            XFS_DA_LOGRANGE(leaf, entry, tmp + sizeof(xfs_attr_leaf_entry_t)));
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2239) 
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2240)        entry = &xfs_attr3_leaf_entryp(leaf)[ichdr.count];
> 517c22207b045 fs/xfs/xfs_attr_leaf.c        (Dave Chinner        2013-04-24 18:58:55 +1000 2241)        memset(entry, 0, sizeof(xfs_attr_leaf_entry_t));
> ^1da177e4c3f4 fs/xfs/xfs_attr_leaf.c        (Linus Torvalds      2005-04-16 15:20:36 -0700 2242) 
> 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
