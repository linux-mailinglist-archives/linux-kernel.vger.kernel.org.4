Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A7738BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjFUQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjFUQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:43:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399619AB;
        Wed, 21 Jun 2023 09:43:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DEA9521F6A;
        Wed, 21 Jun 2023 16:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SW8r+78YHL2HQQT/A92GF4QTN/9RpyRtse9JVJJVsr4=;
        b=KVhYCJZZ3Mzn9nHTbc+LDWEW89VaXSt0bSvd/kuuKaH85N8X3N+oZHuzK7pGediSc/IeNW
        0D7bOR367bXgqEc6rvwu8uv9jtQGj2/+tsESknVYoSVfXrstNGVQRajPrPJXT+IAzFSaDe
        5UJKhvIGQHOhQO54h1hsW1lAaYO/gxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SW8r+78YHL2HQQT/A92GF4QTN/9RpyRtse9JVJJVsr4=;
        b=iX9fn4sOORitLAx5Z+Ye3zUVvAvkdD62b53ou8MesfRr3sqK1URmEN+C5MRuigIGvZE6l1
        P5ovOrhr/bIIotDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0ABC133E6;
        Wed, 21 Jun 2023 16:43:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AjftMsMok2RaRwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:43:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6F138A075D; Wed, 21 Jun 2023 18:43:47 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:43:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/79] autofs: switch to new ctime accessors
Message-ID: <20230621164347.qfzqyxdu6k3t3unc@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-12-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-12-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:26, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/autofs/inode.c | 2 +-
>  fs/autofs/root.c  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index affa70360b1f..47e3054b29dc 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
>  		inode->i_uid = d_inode(sb->s_root)->i_uid;
>  		inode->i_gid = d_inode(sb->s_root)->i_gid;
>  	}
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_ino = get_next_ino();
>  
>  	if (S_ISDIR(mode)) {
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 93046c9dc461..4c0fc0f8d688 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>  	p_ino = autofs_dentry_ino(dentry->d_parent);
>  	p_ino->count++;
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	return 0;
>  }
> @@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
>  	d_inode(dentry)->i_size = 0;
>  	clear_nlink(d_inode(dentry));
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	spin_lock(&sbi->lookup_lock);
>  	__autofs_add_expiring(dentry);
> @@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
>  	p_ino = autofs_dentry_ino(dentry->d_parent);
>  	p_ino->count++;
>  	inc_nlink(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
