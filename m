Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A33738C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFUQtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFUQt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:49:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49111BD6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:48:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E796B21F6F;
        Wed, 21 Jun 2023 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687366088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpiD7nZ3CxtSB25h11cYA22p73QI3NvhZV+46nJgvR4=;
        b=vx9uelIbcZARqzOURqtxV6YC86hereTNAbh49+mmf3kfF/KDCE46g31r3Q9x9vND7nrWXG
        oCMn2pvP+vPOd5baU/GPJET9gC6Km5pTai/PHtLbTkxgbc6av8VKi0q0irMCvOAwb2Sr7v
        kug5MfxsEngN9iPk2fHWUPXXUdw1v34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687366088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpiD7nZ3CxtSB25h11cYA22p73QI3NvhZV+46nJgvR4=;
        b=e6LjeoGTiAaFWeCLCdmtOQ3qE2zmHiVIwcVp1kX7f3Pfj1TNqEQZsIFjbknvak2koESNYp
        R721Ujbzl48SOHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA92B133E6;
        Wed, 21 Jun 2023 16:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dHBVNcgpk2Q8SQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:48:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 751E1A075D; Wed, 21 Jun 2023 18:48:08 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:48:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
Message-ID: <20230621164808.5lhujni7qb36hhtk@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-14-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-14-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

...

> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 1926bec2c850..c964316be32b 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
>  	inode->i_blocks = BFS_FILEBLOCKS(di);
>  	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
>  	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
> -	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
> +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
>  	inode->i_atime.tv_nsec = 0;
>  	inode->i_mtime.tv_nsec = 0;
> -	inode->i_ctime.tv_nsec = 0;
> +	inode_ctime_set_nsec(inode, 0);

So I'm somewhat wondering here - in other filesystem you construct
timespec64 and then use inode_ctime_set(). Here you use
inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? It
seems these two functions are not used that much some maybe we could just
live with just inode_ctime_set() and constructing timespec64 when needed?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
