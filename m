Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70227738B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjFUQgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjFUQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:36:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD01FD3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:36:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DAC221F4A;
        Wed, 21 Jun 2023 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3/2qkZOiIpngc//liQ1ElLKZZimoZHHFJB2veLJVi8=;
        b=HFZfleBXIXJadAtAr9UP2dW5kQ3dtNZaC0Apa7yWwFVy0V3rhfjs2Ss1SxyBuE4+GfWHoA
        ckPxKZeQVdkhh/QlWubdpVQZ3gzP8seR/JZXch5k9KtZEBum4uQ5B5r3yvF+slf0EXK/WP
        e1IR5Rh7dO2j3Qg+78w0IhGokAjtkzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365360;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3/2qkZOiIpngc//liQ1ElLKZZimoZHHFJB2veLJVi8=;
        b=ksAQ/TNuORoy5R077gxyy3HgBWveOXy3dPHyFrxAX4m4STBZk7vvYgPHP4Gr/X6xYU5nqB
        WgrQV4AveY966JDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E496133E6;
        Wed, 21 Jun 2023 16:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XkwvD/Amk2SoQwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:36:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D6F27A075D; Wed, 21 Jun 2023 18:35:59 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:35:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/79] ibm: switch to new ctime accessors
Message-ID: <20230621163559.3qmfb5spep5ux5vy@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-5-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:19, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/misc/ibmasm/ibmasmfs.c | 2 +-
>  drivers/misc/ibmvmc.c          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
> index 35fec1bf1b3d..34d41b2a0d89 100644
> --- a/drivers/misc/ibmasm/ibmasmfs.c
> +++ b/drivers/misc/ibmasm/ibmasmfs.c
> @@ -139,7 +139,7 @@ static struct inode *ibmasmfs_make_inode(struct super_block *sb, int mode)
>  	if (ret) {
>  		ret->i_ino = get_next_ino();
>  		ret->i_mode = mode;
> -		ret->i_atime = ret->i_mtime = ret->i_ctime = current_time(ret);
> +		ret->i_atime = ret->i_mtime = inode_ctime_set_current(ret);
>  	}
>  	return ret;
>  }
> diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
> index d7c7f0305257..b69c978c2590 100644
> --- a/drivers/misc/ibmvmc.c
> +++ b/drivers/misc/ibmvmc.c
> @@ -1124,7 +1124,7 @@ static ssize_t ibmvmc_write(struct file *file, const char *buffer,
>  		goto out;
>  
>  	inode = file_inode(file);
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_ctime_set_current(inode);
>  	mark_inode_dirty(inode);
>  
>  	dev_dbg(adapter->dev, "write: file = 0x%lx, count = 0x%lx\n",
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
