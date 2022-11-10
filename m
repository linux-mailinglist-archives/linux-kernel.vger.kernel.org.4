Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E16241C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKJLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:53:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665D6CA20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:53:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5E09C22CC7;
        Thu, 10 Nov 2022 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668081179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6jyYG8X7Y9H3uoDBRZJ6IFnZAFbqVKxt4W+XZRY/RU=;
        b=iALvoIHBsY407mBqOoj+xl1y71haO5aCcnuOTCnBFyh15I8wN6Z18t+PwBH3UXCej63tkk
        ptwP4+GLxevKj/qdTIKoXba1jLwgaWzjG4bobMR5xuN5eHoFCdA/3GqD/OTAgYGmH5NzDf
        Sirtm/AyKICpSH6E0FGLZV6mB2Me2hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668081179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m6jyYG8X7Y9H3uoDBRZJ6IFnZAFbqVKxt4W+XZRY/RU=;
        b=isuVriHgHHO/ps/7qLQT1FS9LQ0P4Y1FpgsTbMXRQPdE4C5QhC+zcN1ej/ngi1NUskeqyG
        hJ29suqdCTpN02BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E1461332F;
        Thu, 10 Nov 2022 11:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z0UFExvmbGMdQAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 10 Nov 2022 11:52:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E03A1A0704; Thu, 10 Nov 2022 12:52:57 +0100 (CET)
Date:   Thu, 10 Nov 2022 12:52:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     jack@suse.com, jack@suse.cz, yi.zhang@huawei.com,
        yujie.liu@intel.com, hch@lst.de, akpm@linux-foundation.org,
        bvanassche@acm.org, willy@infradead.org,
        linux-kernel@vger.kernel.org,
        syzbot+908340a8367281960537@syzkaller.appspotmail.com
Subject: Re: [PATCH] udf: Fix a slab-out-of-bounds write bug in
 udf_write_aext()
Message-ID: <20221110115257.itqilpn4x7npmzaa@quack3>
References: <20221110014052.3039100-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110014052.3039100-1-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu 10-11-22 01:40:52, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Syzbot reported a slab-out-of-bounds write bug:
> 
> loop0: detected capacity change from 0 to 2048
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in udf_write_aext+0x8bc/0x8f0
> fs/udf/inode.c:2103
> Write of size 4 at addr ffff8880777c63f8 by task syz-executor216/3611
> 
> CPU: 0 PID: 3611 Comm: syz-executor216 Not tainted
> 6.0.0-syzkaller-09589-g55be6084c8e0 #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS
> Google 09/22/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:317 [inline]
>  print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
>  kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
>  udf_write_aext+0x8bc/0x8f0 fs/udf/inode.c:2103
>  udf_add_entry+0xd03/0x2ac0 fs/udf/namei.c:482
>  udf_mkdir+0x145/0x650 fs/udf/namei.c:681
>  vfs_mkdir+0x489/0x740 fs/namei.c:4013
>  do_mkdirat+0x28c/0x310 fs/namei.c:4038
>  __do_sys_mkdir fs/namei.c:4058 [inline]
>  __se_sys_mkdir fs/namei.c:4056 [inline]
>  __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fef3beda479
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89
> f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
> f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe952d4e28 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef3beda479
> RDX: 00007fef3be986e3 RSI: 0000000000000000 RDI: 0000000020000000
> RBP: 00007fef3be999b0 R08: 00007ffe952d4d10 R09: 0000000000000000
> R10: 00007ffe952d4cf0 R11: 0000000000000246 R12: 00007fef3be99a40
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> Allocated by task 3611:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:45 [inline]
>  set_alloc_info mm/kasan/common.c:437 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:516 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:475 [inline]
>  __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
>  kmalloc include/linux/slab.h:600 [inline]
>  kmalloc_array include/linux/slab.h:639 [inline]
>  kcalloc include/linux/slab.h:671 [inline]
>  udf_process_sequence+0xe9/0x4470 fs/udf/super.c:1689
>  udf_load_sequence fs/udf/super.c:1813 [inline]
>  udf_check_anchor_block+0x44b/0x640 fs/udf/super.c:1852
>  udf_scan_anchors+0x1b3/0x6d0 fs/udf/super.c:1885
>  udf_find_anchor fs/udf/super.c:1941 [inline]
>  udf_load_vrs+0x27b/0xbe0 fs/udf/super.c:2006
>  udf_fill_super+0x859/0x1a40 fs/udf/super.c:2184
>  mount_bdev+0x34d/0x410 fs/super.c:1400
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1326/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Freed by task 3611:
>  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
>  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
>  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
>  ____kasan_slab_free mm/kasan/common.c:367 [inline]
>  ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
>  kasan_slab_free include/linux/kasan.h:200 [inline]
>  slab_free_hook mm/slub.c:1759 [inline]
>  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1785
>  slab_free mm/slub.c:3539 [inline]
>  kfree+0xe2/0x580 mm/slub.c:4567
>  udf_process_sequence+0x421/0x4470 fs/udf/super.c:1781
>  udf_load_sequence fs/udf/super.c:1813 [inline]
>  udf_check_anchor_block+0x44b/0x640 fs/udf/super.c:1852
>  udf_scan_anchors+0x1b3/0x6d0 fs/udf/super.c:1885
>  udf_find_anchor fs/udf/super.c:1941 [inline]
>  udf_load_vrs+0x27b/0xbe0 fs/udf/super.c:2006
>  udf_fill_super+0x859/0x1a40 fs/udf/super.c:2184
>  mount_bdev+0x34d/0x410 fs/super.c:1400
>  legacy_get_tree+0x105/0x220 fs/fs_context.c:610
>  vfs_get_tree+0x89/0x2f0 fs/super.c:1530
>  do_new_mount fs/namespace.c:3040 [inline]
>  path_mount+0x1326/0x1e20 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff8880777c6000
>  which belongs to the cache kmalloc-512 of size 512
> The buggy address is located 504 bytes to the right of
>  512-byte region [ffff8880777c6000, ffff8880777c6200)
> 
> The buggy address belongs to the physical page:
> page:ffffea0001ddf100 refcount:1 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x777c4
> head:ffffea0001ddf100 order:2 compound_mapcount:0 compound_pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011841c80
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 2, migratetype Unmovable, gfp_mask
> pid 2972, tgid 2972 (udevadm), ts 11705893480, free_ts 9906278250
>  prep_new_page mm/page_alloc.c:2532 [inline]
>  get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
>  __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
>  alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
>  alloc_slab_page mm/slub.c:1829 [inline]
>  allocate_slab+0x27e/0x3d0 mm/slub.c:1974
>  new_slab mm/slub.c:2034 [inline]
>  ___slab_alloc+0x84f/0xe80 mm/slub.c:3036
>  __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3123
>  slab_alloc_node mm/slub.c:3214 [inline]
>  slab_alloc mm/slub.c:3256 [inline]
>  kmem_cache_alloc_trace+0x323/0x3e0 mm/slub.c:3287
>  kmalloc include/linux/slab.h:600 [inline]
>  kzalloc include/linux/slab.h:733 [inline]
>  kernfs_fop_open+0x31a/0xec0 fs/kernfs/file.c:666
>  do_dentry_open+0x6cc/0x13f0 fs/open.c:882
>  do_open fs/namei.c:3557 [inline]
>  path_openat+0x1c92/0x28f0 fs/namei.c:3691
>  do_filp_open+0x1b6/0x400 fs/namei.c:3718
>  do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
>  do_sys_open fs/open.c:1326 [inline]
>  __do_sys_openat fs/open.c:1342 [inline]
>  __se_sys_openat fs/open.c:1337 [inline]
>  __x64_sys_openat+0x13f/0x1f0 fs/open.c:1337
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1449 [inline]
>  free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
>  free_unref_page_prepare mm/page_alloc.c:3380 [inline]
>  free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
>  free_contig_range+0xb1/0x180 mm/page_alloc.c:9457
>  destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1031
>  debug_vm_pgtable+0x2945/0x29d6 mm/debug_vm_pgtable.c:1354
>  do_one_initcall+0xfe/0x650 init/main.c:1296
>  do_initcall_level init/main.c:1369 [inline]
>  do_initcalls init/main.c:1385 [inline]
>  do_basic_setup init/main.c:1404 [inline]
>  kernel_init_freeable+0x6b1/0x73a init/main.c:1623
>  kernel_init+0x1a/0x1d0 init/main.c:1512
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> 
> Memory state around the buggy address:
>  ffff8880777c6280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8880777c6300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff8880777c6380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                                                 ^
>  ffff8880777c6400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff8880777c6480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================
> 
> Writing to the address ptr will cause an out-of-bounds bug if the inode
> allocation type is ICBTAG_FLAG_AD_SHORT (or ICBTAG_FLAG_AD_LONG), the
> buffer head pointer is NULL, and iinfo->i_lenEAttr is 0. In this case,
> the address ptr is iinfo->i_data - sizeof(struct short_ad), and the
> out-of-bounds offset is the size of struct short_ad. This can be fixed
> by adding the size of struct short_ad (or struct long_ad) to the address
> ptr.
> 
> Reported-by: syzbot+908340a8367281960537@syzkaller.appspotmail.com
> Fixes: 2c948b3f86e5 ("udf: Avoid IO in udf_clear_inode")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Thanks for the fix! So do I understand correctly that in this case the
inode has type ICBTAG_FLAG_AD_SHORT and its size is 0 as well? Then I can
see how what you describe is happening. But the fix is actually wrong, it
will lead to writing extent to a wrong place in most cases. The problem
rather is that in this particular case in udf_add_entry() epos.offset
should not be decremented before calling udf_write_aext(). But when it
should / should not be decremented is really messy. It needs a broader look
and cleaning up...

								Honza

> ---
>  fs/udf/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 8d06daed549f..abb3257b4c74 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -2090,10 +2090,15 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
>  	struct long_ad *lad;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  
> -	if (!epos->bh)
> +	if (!epos->bh) {
>  		ptr = iinfo->i_data + epos->offset -
>  			udf_file_entry_alloc_offset(inode) +
>  			iinfo->i_lenEAttr;
> +		if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_SHORT)
> +			ptr = ptr + sizeof(struct short_ad);
> +		else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
> +			ptr = ptr + sizeof(struct long_ad);
> +	}
>  	else
>  		ptr = epos->bh->b_data + epos->offset;
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
