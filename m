Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B2D714C49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjE2Ooq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjE2Ooi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:44:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F261AD;
        Mon, 29 May 2023 07:44:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF0FA21A60;
        Mon, 29 May 2023 14:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685371475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/FyBTV5M4b/W8STqCVQkl2EcWpckzR9ef6skTUv8W8=;
        b=DLuIaBNQ7JIV6RbCB2HdjjyB/G9763/J7gfloSTgCGPSYvTtxtxkVA/K3Frc6SQv3z49WL
        r2Vg+Lu9/l2GtD5dTExUjjyZNpEnDpr0A6M6vA+V8g4U8DwXeF3ynijWsev5j9W3gYwVGu
        /cQXtnox8UhIEkzQz3tlrl1yQE6g7H8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685371475;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e/FyBTV5M4b/W8STqCVQkl2EcWpckzR9ef6skTUv8W8=;
        b=1AjdzLmaP5fOMOX/ESkebb+i95YrVc7Ftuaelz0FXXSvP4S14jkfQ4MeRzMWLHYLjMZHTw
        ksrdn1QNMIldLIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBCA71332D;
        Mon, 29 May 2023 14:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dM6iNVO6dGQPOwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 May 2023 14:44:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 656EDA0719; Mon, 29 May 2023 16:44:35 +0200 (CEST)
Date:   Mon, 29 May 2023 16:44:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, jun.nie@linaro.org,
        ebiggers@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20230529144435.bj65ltbww5jbh2uc@quack3>
References: <20230529080148.3810143-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529080148.3810143-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-05-23 16:01:48, Baokun Li wrote:
> Syzbot reported a BUG_ON:
> ==================================================================
> EXT4-fs (loop0): mounted filesystem without journal. Quota mode: none.
> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1098: group 0, block
>      bitmap and bg descriptor inconsistent: 25 vs 150994969 free clusters
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/ext4_jbd2.c:53!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 494 Comm: syz-executor.0 6.1.0-rc7-syzkaller-ga4412fdd49dc #0
> RIP: 0010:__ext4_journal_stop+0x1b3/0x1c0
>  [...]
> Call Trace:
>  ext4_write_inline_data_end+0xa39/0xdf0
>  ext4_da_write_end+0x1e2/0x950
>  generic_perform_write+0x401/0x5f0
>  ext4_buffered_write_iter+0x35f/0x640
>  ext4_file_write_iter+0x198/0x1cd0
>  vfs_write+0x8b5/0xef0
>  [...]
> ==================================================================
> 
> The above BUG_ON is triggered by the following race:
> 
>            cpu1                    cpu2
> ________________________|________________________
> ksys_write
>  vfs_write
>   new_sync_write
>    ext4_file_write_iter
>     ext4_buffered_write_iter
>      generic_perform_write
>       ext4_da_write_begin
>                           do_fault
>                            do_page_mkwrite
>                             ext4_page_mkwrite
>                              ext4_convert_inline_data
>                               ext4_convert_inline_data_nolock
>                                ext4_destroy_inline_data_nolock
>                                 //clear EXT4_STATE_MAY_INLINE_DATA
>                                ext4_map_blocks --> return error
>        ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>        ext4_block_write_begin
>                                ext4_restore_inline_data
>                                 // set EXT4_STATE_MAY_INLINE_DATA
>       ext4_da_write_end
>        ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)
>        ext4_write_inline_data_end
>         handle=NULL
>         ext4_journal_stop(handle)
>          __ext4_journal_stop
>           ext4_put_nojournal(handle)
>            ref_cnt = (unsigned long)handle
>            BUG_ON(ref_cnt == 0)  ---> BUG_ON
> 
> The root cause of this problem is that the ext4_convert_inline_data() in
> ext4_page_mkwrite() does not grab i_rwsem, so it may race with
> ext4_buffered_write_iter() and cause the write_begin() and write_end()
> functions to be inconsistent and trigger BUG_ON.
> 
> To solve the above issue, we cannot add inode_lock directly to
> ext4_page_mkwrite(), because this function is a hot path and frequent calls
> to inode_lock will cause performance degradation for multi-threaded reads
> and writes. Hence, we move ext4_convert_inline_data() to ext4_file_mmap(),
> and only when inline_data is enabled and mmap a file in shared write mode,
> we hold the lock to convert, which can reduce the impact on performance.
> 
> Reported-by: Jun Nie <jun.nie@linaro.org>
> Closes: https://lore.kernel.org/lkml/63903521.5040307@huawei.com/t/
> Reported-by: syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=899b37f20ce4072bcdfecfe1647b39602e956e36
> Fixes: 7b4cc9787fe3 ("ext4: evict inline data when writing to memory map")
> CC: stable@vger.kernel.org # 4.12+
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the patch! The problem with i_rwsem in ext4_page_mkwrite() is
not so much about performance as about lock ordering. In
ext4_page_mkwrite() we are called with mmap_sem held and so we cannot
acquire i_rwsem because it ranks about it.

> ---
>  fs/ext4/file.c  | 24 +++++++++++++++++++++++-
>  fs/ext4/inode.c |  4 ----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index d101b3b0c7da..7a04376c33f2 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -795,7 +795,8 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
>  static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	struct inode *inode = file->f_mapping->host;
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> +	struct super_block *sb = inode->i_sb;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct dax_device *dax_dev = sbi->s_daxdev;
>  
>  	if (unlikely(ext4_forced_shutdown(sbi)))
> @@ -808,6 +809,27 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!daxdev_mapping_supported(vma, dax_dev))
>  		return -EOPNOTSUPP;
>  
> +	/*
> +	 * Writing via mmap has no logic to handle inline data, so we
> +	 * need to call ext4_convert_inline_data() to convert the inode
> +	 * to normal format before doing so, otherwise a BUG_ON will be
> +	 * triggered in ext4_writepages() due to the
> +	 * EXT4_STATE_MAY_INLINE_DATA flag. Moreover, we need to grab
> +	 * i_rwsem during conversion, since clearing and setting the
> +	 * inline data flag may race with ext4_buffered_write_iter()
> +	 * to trigger a BUG_ON.
> +	 */
> +	if (ext4_has_feature_inline_data(sb) &&
> +	    vma->vm_flags & VM_SHARED && vma->vm_flags & VM_WRITE) {

Sadly this does not work because we can mmap(2) the file read-only and then
use mprotect(2) to make file writeable. But we can test for VM_MAYWRITE
which gets set when mapping can be made writeable (basically anytime when
the file descriptor itself is writeable).

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
