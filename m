Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6210738BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjFUQnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjFUQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:43:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E1129
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:43:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC47B1FF44;
        Wed, 21 Jun 2023 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eamQPaw3ceUPi0v5CWyenAK6T9SKP6JH3fmm2c3QkVc=;
        b=vrRmmVnWHyAf3RM0zg8e4brubLmZ21xcAZv7zqMWXkoUFIsvTclDWmo+Md2K0cHgn/F2L/
        ImlJJJY3aUf2gl3LVXB5ScFLLKP6Bw7non2NEw5f4KhZ8Uli4hrumiD/nwdyf5wHaGVPxw
        +Ab13jUmKwX1gHv2eYHFYbnqc5YGLTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eamQPaw3ceUPi0v5CWyenAK6T9SKP6JH3fmm2c3QkVc=;
        b=o6xXxBfv6jzudfevPm/G0VuGDVjZVThrL3v/0SDAS6ZYLeNaZM5YXSg7XNpQLn+zjETbCC
        ar8WkIKlcx7Yj0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD145133E6;
        Wed, 21 Jun 2023 16:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCL+MaUok2QqRwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:43:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 732F5A075D; Wed, 21 Jun 2023 18:43:17 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:43:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/79] afs: switch to new ctime accessors
Message-ID: <20230621164317.6xscug2jvcwv6nhb@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-10-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:24, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/afs/dynroot.c | 2 +-
>  fs/afs/inode.c   | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
> index d7d9402ff718..ee36375de337 100644
> --- a/fs/afs/dynroot.c
> +++ b/fs/afs/dynroot.c
> @@ -88,9 +88,9 @@ struct inode *afs_iget_pseudo_dir(struct super_block *sb, bool root)
>  	set_nlink(inode, 2);
>  	inode->i_uid		= GLOBAL_ROOT_UID;
>  	inode->i_gid		= GLOBAL_ROOT_GID;
> -	inode->i_ctime = inode->i_atime = inode->i_mtime = current_time(inode);
>  	inode->i_blocks		= 0;
>  	inode->i_generation	= 0;
> +	inode->i_atime		= inode->i_mtime = inode_ctime_set_current(inode);
>  
>  	set_bit(AFS_VNODE_PSEUDODIR, &vnode->flags);
>  	if (!root) {
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 866bab860a88..0b59903c2a43 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -90,7 +90,7 @@ static int afs_inode_init_from_status(struct afs_operation *op,
>  	vnode->status = *status;
>  
>  	t = status->mtime_client;
> -	inode->i_ctime = t;
> +	inode_ctime_set(inode, t);
>  	inode->i_mtime = t;
>  	inode->i_atime = t;
>  	inode->i_flags |= S_NOATIME;
> @@ -206,7 +206,7 @@ static void afs_apply_status(struct afs_operation *op,
>  	t = status->mtime_client;
>  	inode->i_mtime = t;
>  	if (vp->update_ctime)
> -		inode->i_ctime = op->ctime;
> +		inode_ctime_set(inode, op->ctime);
>  
>  	if (vnode->status.data_version != status->data_version)
>  		data_changed = true;
> @@ -252,7 +252,7 @@ static void afs_apply_status(struct afs_operation *op,
>  		vnode->netfs.remote_i_size = status->size;
>  		if (change_size) {
>  			afs_set_i_size(vnode, status->size);
> -			inode->i_ctime = t;
> +			inode_ctime_set(inode, t);
>  			inode->i_atime = t;
>  		}
>  	}
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
