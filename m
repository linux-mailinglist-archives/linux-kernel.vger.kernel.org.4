Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73A76ABF81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCFMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCFMah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:30:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4C223652;
        Mon,  6 Mar 2023 04:30:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 424D3223E0;
        Mon,  6 Mar 2023 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678105834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpCP66UmYhng8vwThDdbM80HuIiEWCjFui/hmpOimjc=;
        b=22hZPC3Yq85Zfx1vGMdyJA7wsKWyS/GTD6FNczp5HWerTvX3Vsm8mY8ozlBnkHwc6ltxKD
        ja7mNB6cu++veDJ5hUvElJCgmgjnICxhOd6y1drT6at1ZkPb5CUh4bKHKBfJ7ufMmxQbJ4
        x++PLRmHbGjRhNwf7sWmuQDb4HJcCxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678105834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpCP66UmYhng8vwThDdbM80HuIiEWCjFui/hmpOimjc=;
        b=pu79jJHygyxrD7ktTZqJeZ+ExTmWKRFqPdK9ax9gBYIixgdOd8fCHFFtxw9XjiE3DXT2AO
        YbxYvFc/7KGfZvAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35A6613A66;
        Mon,  6 Mar 2023 12:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k0sWDercBWQgPwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 06 Mar 2023 12:30:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CB014A064F; Mon,  6 Mar 2023 13:30:33 +0100 (CET)
Date:   Mon, 6 Mar 2023 13:30:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 2/2] ext4: fix WARNING in ext4_update_inline_data
Message-ID: <20230306123033.b7tqrqbcftetdvxg@quack3>
References: <20230304025458.4007825-1-yebin@huaweicloud.com>
 <20230304025458.4007825-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304025458.4007825-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 04-03-23 10:54:58, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
> fscrypt: AES-256-XTS using implementation "xts-aes-aesni"
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5071 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
> Modules linked in:
> CPU: 1 PID: 5071 Comm: syz-executor263 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
> RSP: 0018:ffffc90003c2f1c0 EFLAGS: 00010246
> RAX: ffffc90003c2f220 RBX: 0000000000000014 RCX: 0000000000000000
> RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003c2f248
> RBP: ffffc90003c2f2d8 R08: dffffc0000000000 R09: ffffc90003c2f220
> R10: fffff52000785e49 R11: 1ffff92000785e44 R12: 0000000000040d40
> R13: 1ffff92000785e40 R14: dffffc0000000000 R15: 1ffff92000785e3c
> FS:  0000555556c0d300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95d5e04138 CR3: 00000000793aa000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __alloc_pages_node include/linux/gfp.h:237 [inline]
>  alloc_pages_node include/linux/gfp.h:260 [inline]
>  __kmalloc_large_node+0x95/0x1e0 mm/slab_common.c:1113
>  __do_kmalloc_node mm/slab_common.c:956 [inline]
>  __kmalloc+0xfe/0x190 mm/slab_common.c:981
>  kmalloc include/linux/slab.h:584 [inline]
>  kzalloc include/linux/slab.h:720 [inline]
>  ext4_update_inline_data+0x236/0x6b0 fs/ext4/inline.c:346
>  ext4_update_inline_dir fs/ext4/inline.c:1115 [inline]
>  ext4_try_add_inline_entry+0x328/0x990 fs/ext4/inline.c:1307
>  ext4_add_entry+0x5a4/0xeb0 fs/ext4/namei.c:2385
>  ext4_add_nondir+0x96/0x260 fs/ext4/namei.c:2772
>  ext4_create+0x36c/0x560 fs/ext4/namei.c:2817
>  lookup_open fs/namei.c:3413 [inline]
>  open_last_lookups fs/namei.c:3481 [inline]
>  path_openat+0x12ac/0x2dd0 fs/namei.c:3711
>  do_filp_open+0x264/0x4f0 fs/namei.c:3741
>  do_sys_openat2+0x124/0x4e0 fs/open.c:1310
>  do_sys_open fs/open.c:1326 [inline]
>  __do_sys_openat fs/open.c:1342 [inline]
>  __se_sys_openat fs/open.c:1337 [inline]
>  __x64_sys_openat+0x243/0x290 fs/open.c:1337
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Above issue happens as follows:
> ext4_iget
>    ext4_find_inline_data_nolock ->i_inline_off=164 i_inline_size=60
> ext4_try_add_inline_entry
>    __ext4_mark_inode_dirty
>       ext4_expand_extra_isize_ea ->i_extra_isize=32 s_want_extra_isize=44
>          ext4_xattr_shift_entries
> 	 ->after shift i_inline_off is incorrect, actually is change to 176
> ext4_try_add_inline_entry
>   ext4_update_inline_dir
>     get_max_inline_xattr_value_size
>       if (EXT4_I(inode)->i_inline_off)
> 	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
> 			EXT4_I(inode)->i_inline_off);
>         free += EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size));
> 	->As entry is incorrect, then 'free' may be negative
>    ext4_update_inline_data
>       value = kzalloc(len, GFP_NOFS);
>       -> len is unsigned int, maybe very large, then trigger warning when
>          'kzalloc()'
> To resolve above issue there's need to update 'i_inline_off' after
> 'ext4_xattr_shift_entries()'. At here we do not need to set
> EXT4_STATE_MAY_INLINE_DATA flag. As if do mark inode dirty we already set
> this flag if need. If we set EXT4_STATE_MAY_INLINE_DATA flag may lead to
> BUG_ON in ext4_writepages().
> 
> Reported-by: syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 62f2ec599218..767454d74cd6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2852,6 +2852,9 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  			(void *)header, total_ino);
>  	EXT4_I(inode)->i_extra_isize = new_extra_isize;
>  
> +	if (ext4_has_inline_data(inode))
> +		error = ext4_find_inline_data_nolock(inode);
> +
>  cleanup:
>  	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
>  		ext4_warning(inode->i_sb, "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
