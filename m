Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11D60B7A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiJXT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiJXT1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:27:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71F27DFB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:59:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF5482206B;
        Mon, 24 Oct 2022 15:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666625916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAhaS218UxTjZK6/en9etUPPJDkm4cMKph+xvcdTZr8=;
        b=nasQ2ovWc6k/g3zQ/4zIX+jFy57v+afILjt6g2gMd4eb5NnPmMNXIALesWwJO0dWLcftd1
        FbS06BTGRQVrStg9lFD7EcGrtJRhE5ba8TJLNaERvam3bL8TECmwQJgGy5k1ESz6M1WPPa
        9ndlcW4UqS1MTd3r7vueTDK2N7zuGXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666625916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAhaS218UxTjZK6/en9etUPPJDkm4cMKph+xvcdTZr8=;
        b=q3Xk6YCbmvBtpMVBETQC9KHtOPYNnUSenhR7SmoIZTsZB3eCY050Z7MJs6IPaDAmVBhOM/
        BsVwf5VpeBoIGlDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFA8A13357;
        Mon, 24 Oct 2022 15:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ps2SNnyxVmMzSwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Oct 2022 15:38:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E210A06F6; Mon, 24 Oct 2022 17:38:36 +0200 (CEST)
Date:   Mon, 24 Oct 2022 17:38:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com
Subject: Re: [PATCH] udf: Avoid double brelse() in udf_rename()
Message-ID: <20221024153836.sdnx4eh5w5pev37s@quack3>
References: <20221023095741.271430-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023095741.271430-1-syoshida@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23-10-22 18:57:41, Shigeru Yoshida wrote:
> syzbot reported a warning like below [1]:
> 
> VFS: brelse: Trying to free free buffer
> WARNING: CPU: 2 PID: 7301 at fs/buffer.c:1145 __brelse+0x67/0xa0
> ...
> Call Trace:
>  <TASK>
>  invalidate_bh_lru+0x99/0x150
>  smp_call_function_many_cond+0xe2a/0x10c0
>  ? generic_remap_file_range_prep+0x50/0x50
>  ? __brelse+0xa0/0xa0
>  ? __mutex_lock+0x21c/0x12d0
>  ? smp_call_on_cpu+0x250/0x250
>  ? rcu_read_lock_sched_held+0xb/0x60
>  ? lock_release+0x587/0x810
>  ? __brelse+0xa0/0xa0
>  ? generic_remap_file_range_prep+0x50/0x50
>  on_each_cpu_cond_mask+0x3c/0x80
>  blkdev_flush_mapping+0x13a/0x2f0
>  blkdev_put_whole+0xd3/0xf0
>  blkdev_put+0x222/0x760
>  deactivate_locked_super+0x96/0x160
>  deactivate_super+0xda/0x100
>  cleanup_mnt+0x222/0x3d0
>  task_work_run+0x149/0x240
>  ? task_work_cancel+0x30/0x30
>  do_exit+0xb29/0x2a40
>  ? reacquire_held_locks+0x4a0/0x4a0
>  ? do_raw_spin_lock+0x12a/0x2b0
>  ? mm_update_next_owner+0x7c0/0x7c0
>  ? rwlock_bug.part.0+0x90/0x90
>  ? zap_other_threads+0x234/0x2d0
>  do_group_exit+0xd0/0x2a0
>  __x64_sys_exit_group+0x3a/0x50
>  do_syscall_64+0x34/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The cause of the issue is that brelse() is called on both ofibh.sbh
> and ofibh.ebh by udf_find_entry() when it returns NULL.  However,
> brelse() is called by udf_rename(), too.  So, b_count on buffer_head
> becomes unbalanced.
> 
> This patch fixes the issue by not calling brelse() by udf_rename()
> when udf_find_entry() returns NULL.
> 
> Link: https://syzkaller.appspot.com/bug?id=8297f45698159c6bca8a1f87dc983667c1a1c851 [1]
> Reported-by: syzbot+7902cd7684bc35306224@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Thanks! I've added the fix to my tree.

								Honza

> ---
>  fs/udf/namei.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index fb4c30e05245..d6081538bfc0 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -1091,8 +1091,9 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  		return -EINVAL;
>  
>  	ofi = udf_find_entry(old_dir, &old_dentry->d_name, &ofibh, &ocfi);
> -	if (IS_ERR(ofi)) {
> -		retval = PTR_ERR(ofi);
> +	if (!ofi || IS_ERR(ofi)) {
> +		if (IS_ERR(ofi))
> +			retval = PTR_ERR(ofi);
>  		goto end_rename;
>  	}
>  
> @@ -1101,8 +1102,7 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  
>  	brelse(ofibh.sbh);
>  	tloc = lelb_to_cpu(ocfi.icb.extLocation);
> -	if (!ofi || udf_get_lb_pblock(old_dir->i_sb, &tloc, 0)
> -	    != old_inode->i_ino)
> +	if (udf_get_lb_pblock(old_dir->i_sb, &tloc, 0) != old_inode->i_ino)
>  		goto end_rename;
>  
>  	nfi = udf_find_entry(new_dir, &new_dentry->d_name, &nfibh, &ncfi);
> -- 
> 2.37.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
