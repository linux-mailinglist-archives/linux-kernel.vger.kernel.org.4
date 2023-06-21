Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6136738BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjFUQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFUQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:39:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA89210C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:38:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64E351FF3A;
        Wed, 21 Jun 2023 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+Kbmlgc5A8uS9DJQna3QJnRBNQVG0etfbPkRzxEKrI=;
        b=HV3GsErnCA4YwRnezHFbEqnvcbX94w06aNV/ReORMbnHYo9hNTFNvTsjRIn065XRZLDMvU
        MjLgEex6ZFhjowXKlRWH7QogU7SgBpKAVHcmQn/vCNGnd1r4HCB3FVViFem0SF4oEXbM/c
        I7e/WDbErdK+HGfgWmnY4hpTE0n0Uy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+Kbmlgc5A8uS9DJQna3QJnRBNQVG0etfbPkRzxEKrI=;
        b=sgDcs4FUR/4sSaEZaV4Wo9SKd9pzZS7WgsgnacmjrAu+0kGyb7qX3CxioTXTJPdUtmFH6q
        aEScYHH1CYa+yOBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 573A7133E6;
        Wed, 21 Jun 2023 16:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GZBMFZMnk2ThRAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:38:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E61B0A075D; Wed, 21 Jun 2023 18:38:42 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:38:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/79] adfs: switch to new ctime accessors
Message-ID: <20230621163842.7orhklwa5mhhfwwy@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-8-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:22, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/adfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
> index c3ac613d0975..266191e6b80c 100644
> --- a/fs/adfs/inode.c
> +++ b/fs/adfs/inode.c
> @@ -270,7 +270,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
>  	inode->i_mode	 = adfs_atts2mode(sb, inode);
>  	adfs_adfs2unix_time(&inode->i_mtime, inode);
>  	inode->i_atime = inode->i_mtime;
> -	inode->i_ctime = inode->i_mtime;
> +	inode_ctime_set(inode, inode->i_mtime);
>  
>  	if (S_ISDIR(inode->i_mode)) {
>  		inode->i_op	= &adfs_dir_inode_operations;
> @@ -331,7 +331,7 @@ adfs_notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (ia_valid & ATTR_ATIME)
>  		inode->i_atime = attr->ia_atime;
>  	if (ia_valid & ATTR_CTIME)
> -		inode->i_ctime = attr->ia_ctime;
> +		inode_ctime_set(inode, attr->ia_ctime);
>  	if (ia_valid & ATTR_MODE) {
>  		ADFS_I(inode)->attr = adfs_mode2atts(sb, inode, attr->ia_mode);
>  		inode->i_mode = adfs_atts2mode(sb, inode);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
