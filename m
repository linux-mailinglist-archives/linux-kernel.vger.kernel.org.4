Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B067AD98
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjAYJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjAYJQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:16:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C04A43902
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:16:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2208D21C63;
        Wed, 25 Jan 2023 09:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674638174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbEk+ZO9OgIMyfnfk7cAzQznGDfrejCScbCPOkSmu1w=;
        b=s0ozv1x9WXQ3dVgwQCWBhwhhR42bJ9Y8Oqd/qFRIUy1uRxCPJ/zFFe2F6ok5PV/DytzFeX
        +zPvwL0KT/BKtOVyx1kLXv6MxTj9LuJM6GPrwIVQJpIYAme1bchNNQmPt0MhL3v1j+XOvS
        xLeDw1vJ6LXcjbFysIRSIOo9BelbRpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674638174;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbEk+ZO9OgIMyfnfk7cAzQznGDfrejCScbCPOkSmu1w=;
        b=CguzZdWDaw9vRJhhpHymRwFFEWXULpojH/hqepwNAj+i/bVHxMdTpWkLsFiAwhAqJKLIw6
        BwRQDwZWqMXOigBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07D271339E;
        Wed, 25 Jan 2023 09:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qZDYAV7z0GMbFAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 25 Jan 2023 09:16:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6879DA06B5; Wed, 25 Jan 2023 10:16:13 +0100 (CET)
Date:   Wed, 25 Jan 2023 10:16:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
Subject: Re: [PATCH -next] udf: Fix a race condition between udf_rename() and
 udf_expand_dir_adinicb()
Message-ID: <20230125091613.6pg5ft3lpcwijw6q@quack3>
References: <20230124173015.3213309-1-syoshida@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124173015.3213309-1-syoshida@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-01-23 02:30:15, Shigeru Yoshida wrote:
> syzbot reported a general fault in udf_filter_write_fi() [1].  This
> causes a stack trace like below:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> CPU: 0 PID: 5127 Comm: syz-executor298 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
> ...
> Call Trace:
>  <TASK>
>  udf_rename+0x69d/0xb80 fs/udf/namei.c:874
>  vfs_rename+0x1162/0x1a90 fs/namei.c:4780
>  do_renameat2+0xb22/0xc30 fs/namei.c:4931
>  __do_sys_rename fs/namei.c:4977 [inline]
>  __se_sys_rename fs/namei.c:4975 [inline]
>  __x64_sys_rename+0x81/0xa0 fs/namei.c:4975
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The cause of this issue is a race condition between udf_rename() and
> udf_expand_dir_adinicb().
> 
> If udf_rename() and udf_expand_dir_adinicb() run concurrently,
> iinfo->i_alloc_type can be changed by udf_expand_dir_adinicb() while
> udf_rename() is running.  This causes NULL pointer dereference for
> iter->bh[0]->b_data in udf_fiiter_write_fi().
> 
> Link: https://syzkaller.appspot.com/bug?id=2811e6cdd35ea1df1fa2ef31b8d92c6408aa15d2 [1]
> Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Thanks for the patch but I have already fixed the bug in a patch I've
posted here [1]. A cleaner fix is actually to use i_rwsem to protect moved
directory from other modifications (which is what I did).

[1] https://lore.kernel.org/all/20230124121814.25951-14-jack@suse.cz

								Honza

> ---
>  fs/udf/namei.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 06f066ba3072..5048652c6cd4 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -149,6 +149,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  	uint8_t *impuse;
>  	int ret;
>  
> +	down_write(&iinfo->i_data_sem);
> +
>  	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
>  		alloctype = ICBTAG_FLAG_AD_SHORT;
>  	else
> @@ -157,7 +159,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  	if (!inode->i_size) {
>  		iinfo->i_alloc_type = alloctype;
>  		mark_inode_dirty(inode);
> -		return NULL;
> +		goto out;
>  	}
>  
>  	/* alloc block, and copy data to it */
> @@ -165,15 +167,15 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  			       iinfo->i_location.partitionReferenceNum,
>  			       iinfo->i_location.logicalBlockNum, err);
>  	if (!(*block))
> -		return NULL;
> +		goto out;
>  	newblock = udf_get_pblock(inode->i_sb, *block,
>  				  iinfo->i_location.partitionReferenceNum,
>  				0);
>  	if (!newblock)
> -		return NULL;
> +		goto out;
>  	dbh = udf_tgetblk(inode->i_sb, newblock);
>  	if (!dbh)
> -		return NULL;
> +		goto out;
>  	lock_buffer(dbh);
>  	memcpy(dbh->b_data, iinfo->i_data, inode->i_size);
>  	memset(dbh->b_data + inode->i_size, 0,
> @@ -197,7 +199,7 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  	if (ret < 0) {
>  		*err = ret;
>  		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
> -		return NULL;
> +		goto out;
>  	}
>  	mark_inode_dirty(inode);
>  
> @@ -213,6 +215,8 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  			impuse = NULL;
>  		udf_fiiter_write_fi(&iter, impuse);
>  	}
> +	up_write(&iinfo->i_data_sem);
> +
>  	/*
>  	 * We don't expect the iteration to fail as the directory has been
>  	 * already verified to be correct
> @@ -221,6 +225,9 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
>  	udf_fiiter_release(&iter);
>  
>  	return dbh;
> +out:
> +	up_write(&iinfo->i_data_sem);
> +	return NULL;
>  }
>  
>  static int udf_fiiter_add_entry(struct inode *dir, struct dentry *dentry,
> @@ -766,6 +773,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	bool has_diriter = false;
>  	int retval;
>  	struct kernel_lb_addr tloc;
> +	struct udf_inode_info *old_iinfo = UDF_I(old_inode);
>  
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
> @@ -780,11 +788,13 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  		goto out_oiter;
>  	}
>  
> +	down_read(&old_iinfo->i_data_sem);
> +
>  	if (S_ISDIR(old_inode->i_mode)) {
>  		if (new_inode) {
>  			retval = -ENOTEMPTY;
>  			if (!empty_dir(new_inode))
> -				goto out_oiter;
> +				goto out_unlock;
>  		}
>  		retval = udf_fiiter_find_entry(old_inode, &dotdot_name,
>  					       &diriter);
> @@ -795,7 +805,7 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			retval = -EFSCORRUPTED;
>  		}
>  		if (retval)
> -			goto out_oiter;
> +			goto out_unlock;
>  		has_diriter = true;
>  		tloc = lelb_to_cpu(diriter.fi.icb.extLocation);
>  		if (udf_get_lb_pblock(old_inode->i_sb, &tloc, 0) !=
> @@ -805,25 +815,25 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  				"directory (ino %lu) has parent entry pointing to another inode (%lu != %u)\n",
>  				old_inode->i_ino, old_dir->i_ino,
>  				udf_get_lb_pblock(old_inode->i_sb, &tloc, 0));
> -			goto out_oiter;
> +			goto out_unlock;
>  		}
>  	}
>  
>  	retval = udf_fiiter_find_entry(new_dir, &new_dentry->d_name, &niter);
>  	if (retval && retval != -ENOENT)
> -		goto out_oiter;
> +		goto out_unlock;
>  	/* Entry found but not passed by VFS? */
>  	if (!retval && !new_inode) {
>  		retval = -EFSCORRUPTED;
>  		udf_fiiter_release(&niter);
> -		goto out_oiter;
> +		goto out_unlock;
>  	}
>  	/* Entry not found? Need to add one... */
>  	if (retval) {
>  		udf_fiiter_release(&niter);
>  		retval = udf_fiiter_add_entry(new_dir, new_dentry, &niter);
>  		if (retval)
> -			goto out_oiter;
> +			goto out_unlock;
>  	}
>  
>  	/*
> @@ -882,7 +892,10 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  			mark_inode_dirty(new_dir);
>  		}
>  	}
> +	up_read(&old_iinfo->i_data_sem);
>  	return 0;
> +out_unlock:
> +	up_read(&old_iinfo->i_data_sem);
>  out_oiter:
>  	if (has_diriter)
>  		udf_fiiter_release(&diriter);
> -- 
> 2.39.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
