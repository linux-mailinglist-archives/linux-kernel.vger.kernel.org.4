Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E485738B96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFUQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjFUQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:38:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205A1BE2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:38:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99FB221F58;
        Wed, 21 Jun 2023 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaXJHCGUSsnTlJeva4xvsTAglhWNfgVPvWSkMKuv9bw=;
        b=aoG/QsfH/FVPJXA7u+Pb05WjA945K0GQi/+SyeRAviS4AcxVtQWCu25ddnCyU8oGSGL+sL
        L0eVHj0Kbnf29N0xzety6eJR+cgfJgbn21vC46sBabTwLr55k5W5Bhq/HXvKnUz7RKOpDf
        WCk6AYY39nGtifSy6f7gu7etMCd2ID0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaXJHCGUSsnTlJeva4xvsTAglhWNfgVPvWSkMKuv9bw=;
        b=hmo3I2I8IoPLyHfI4CTCOnqhLtNtuSk5oDRn4ZP+egk4AvXd6CtebvhWVumP5y0S7FQU1o
        iSLyIrhuI3iQ/UAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CD85133E6;
        Wed, 21 Jun 2023 16:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vaNUImUnk2SARAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:37:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2CA67A075D; Wed, 21 Jun 2023 18:37:57 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:37:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/79] 9p: switch to new ctime accessors
Message-ID: <20230621163757.i6c2gecet25p5gsr@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-7-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:21, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_inode.c      |  6 ++++--
>  fs/9p/vfs_inode_dotl.c | 11 +++++------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 36b466e35887..098e4c7160a8 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -261,7 +261,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
>  	inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
>  	inode->i_blocks = 0;
>  	inode->i_rdev = rdev;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_mapping->a_ops = &v9fs_addr_operations;
>  	inode->i_private = NULL;
>  
> @@ -1153,12 +1153,14 @@ v9fs_stat2inode(struct p9_wstat *stat, struct inode *inode,
>  	umode_t mode;
>  	struct v9fs_session_info *v9ses = sb->s_fs_info;
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> +	struct timespec64 ctime = { .tv_sec  = stat->mtime,
> +				    .tv_nsec = 0 };
>  
>  	set_nlink(inode, 1);
>  
>  	inode->i_atime.tv_sec = stat->atime;
>  	inode->i_mtime.tv_sec = stat->mtime;
> -	inode->i_ctime.tv_sec = stat->mtime;
> +	inode_ctime_set(inode, ctime);
>  
>  	inode->i_uid = v9ses->dfltuid;
>  	inode->i_gid = v9ses->dfltgid;
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 5361cd2d7996..0041b5fc4407 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -640,14 +640,15 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
>  {
>  	umode_t mode;
>  	struct v9fs_inode *v9inode = V9FS_I(inode);
> +	struct timespec64 ctime = { .tv_sec  = stat->st_ctime_sec,
> +				    .tv_nsec = stat->st_ctime_nsec };
>  
>  	if ((stat->st_result_mask & P9_STATS_BASIC) == P9_STATS_BASIC) {
>  		inode->i_atime.tv_sec = stat->st_atime_sec;
>  		inode->i_atime.tv_nsec = stat->st_atime_nsec;
>  		inode->i_mtime.tv_sec = stat->st_mtime_sec;
>  		inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
> -		inode->i_ctime.tv_sec = stat->st_ctime_sec;
> -		inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
> +		inode_ctime_set(inode, ctime);
>  		inode->i_uid = stat->st_uid;
>  		inode->i_gid = stat->st_gid;
>  		set_nlink(inode, stat->st_nlink);
> @@ -668,10 +669,8 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
>  			inode->i_mtime.tv_sec = stat->st_mtime_sec;
>  			inode->i_mtime.tv_nsec = stat->st_mtime_nsec;
>  		}
> -		if (stat->st_result_mask & P9_STATS_CTIME) {
> -			inode->i_ctime.tv_sec = stat->st_ctime_sec;
> -			inode->i_ctime.tv_nsec = stat->st_ctime_nsec;
> -		}
> +		if (stat->st_result_mask & P9_STATS_CTIME)
> +			inode_ctime_set(inode, ctime);
>  		if (stat->st_result_mask & P9_STATS_UID)
>  			inode->i_uid = stat->st_uid;
>  		if (stat->st_result_mask & P9_STATS_GID)
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
