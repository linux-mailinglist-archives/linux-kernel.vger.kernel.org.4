Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6883738B74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFUQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjFUQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:35:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE721FDC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:35:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9768D1FF37;
        Wed, 21 Jun 2023 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufxeOgyDiqX74luvUgtKpXgHocEQOiFjyzfmI13gtTQ=;
        b=fxh+5t+H1P7MZ8v5CpJiyIt6ogVuU2xcpLP8jQFFBjIExUeNWFcdKhhJg1A6KnzBrcz1p/
        NDmVazZIcxOUIIiR5iF8aDwsRBZUaB2TmJ1yuvD2IUQtY6gvXQvJHtIvrOvUs4+/J1BC7J
        KPWm0pXDJN0qb2X9myMQrjC9F2/fIzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ufxeOgyDiqX74luvUgtKpXgHocEQOiFjyzfmI13gtTQ=;
        b=X2k02qtLX4zTEUX8p8QQeaK6J/WiV1dfgkP6vqArbtxB+soD+5/linUSR7OVzGb9+7RyFx
        1G63fAUL8PsChwDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 848D9133E6;
        Wed, 21 Jun 2023 16:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BJ9KILsmk2Q/QwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:35:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F4195A075D; Wed, 21 Jun 2023 18:35:06 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:35:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/79] binderfs: switch to new ctime accessors
Message-ID: <20230621163506.r7wewyfgpbuz45cy@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-3-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:17, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/android/binderfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 76e7d6676657..b6b1220e1e55 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -153,7 +153,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  		goto err;
>  
>  	inode->i_ino = minor + INODE_OFFSET;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
>  	init_special_inode(inode, S_IFCHR | 0600,
>  			   MKDEV(MAJOR(binderfs_dev), minor));
>  	inode->i_fop = &binder_fops;
> @@ -432,7 +432,7 @@ static int binderfs_binder_ctl_create(struct super_block *sb)
>  	}
>  
>  	inode->i_ino = SECOND_INODE;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
>  	init_special_inode(inode, S_IFCHR | 0600,
>  			   MKDEV(MAJOR(binderfs_dev), minor));
>  	inode->i_fop = &binder_ctl_fops;
> @@ -474,7 +474,7 @@ static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
>  	if (ret) {
>  		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
>  		ret->i_mode = mode;
> -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
>  	}
>  	return ret;
>  }
> @@ -703,7 +703,7 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	inode->i_ino = FIRST_INODE;
>  	inode->i_fop = &simple_dir_operations;
>  	inode->i_mode = S_IFDIR | 0755;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_ctime_set_current(inode);
>  	inode->i_op = &binderfs_dir_inode_operations;
>  	set_nlink(inode, 2);
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
