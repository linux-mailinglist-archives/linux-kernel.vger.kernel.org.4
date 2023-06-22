Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F573A0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjFVMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjFVMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:30:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8966199E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:30:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31DCB20531;
        Thu, 22 Jun 2023 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687437051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzY323mQUEaPSPf813mKgRO+4Beu4snqpHW/IzKYAjU=;
        b=PS734gUeAK8+AHIpRVUG6bR15AnhvLk28zCVggGpqI2djzWRLhgi1XYLgivZMXTs7KbddO
        KO+rG6P5bnR+kk9W3G5R8AvmDgOoEGl6izmWm2eessfRCjOc5HOrdfvjIee706GEKB/L9B
        yG8M97MMKPGZk2XcCvf2/Wgsx7OkqFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687437051;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzY323mQUEaPSPf813mKgRO+4Beu4snqpHW/IzKYAjU=;
        b=FtuI66ii0CvO+NJsIEzAwGIDY0q59zR5aP0kOORsmZwTD3nDesBkQcmscXhqH/s0QM1W+0
        Fc3tMs2OwahXILDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2535813905;
        Thu, 22 Jun 2023 12:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4PoNCfs+lGRMawAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 22 Jun 2023 12:30:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9E41AA0754; Thu, 22 Jun 2023 14:30:50 +0200 (CEST)
Date:   Thu, 22 Jun 2023 14:30:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
Message-ID: <20230622123050.thpf7qdnmidq3thj@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-14-jlayton@kernel.org>
 <20230621164808.5lhujni7qb36hhtk@quack3>
 <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wmtgul4dtcqfppqy"
Content-Disposition: inline
In-Reply-To: <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmtgul4dtcqfppqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 21-06-23 12:57:19, Jeff Layton wrote:
> On Wed, 2023-06-21 at 18:48 +0200, Jan Kara wrote:
> > On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> > > In later patches, we're going to change how the ctime.tv_nsec field is
> > > utilized. Switch to using accessor functions instead of raw accesses of
> > > inode->i_ctime.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > ...
> > 
> > > diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> > > index 1926bec2c850..c964316be32b 100644
> > > --- a/fs/bfs/inode.c
> > > +++ b/fs/bfs/inode.c
> > > @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
> > >  	inode->i_blocks = BFS_FILEBLOCKS(di);
> > >  	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
> > >  	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
> > > -	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
> > > +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
> > >  	inode->i_atime.tv_nsec = 0;
> > >  	inode->i_mtime.tv_nsec = 0;
> > > -	inode->i_ctime.tv_nsec = 0;
> > > +	inode_ctime_set_nsec(inode, 0);
> > 
> > So I'm somewhat wondering here - in other filesystem you construct
> > timespec64 and then use inode_ctime_set(). Here you use
> > inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? It
> > seems these two functions are not used that much some maybe we could just
> > live with just inode_ctime_set() and constructing timespec64 when needed?
> > 
> > 								Honza
> 
> The main advantage is that by using that, I didn't need to do quite so
> much of this conversion by hand. My coccinelle skills are pretty
> primitive. I went with whatever conversion was going to give minimal
> changes, to the existing accesses for the most part.
> 
> We could certainly do it the way you suggest, it just means having to
> re-touch a lot of this code by hand, or someone with better coccinelle
> chops suggesting a way to declare a temporary variables in place.

Well, maybe temporary variables aren't that convenient but we could provide
function setting ctime from sec & nsec value without having to declare
temporary timespec64? Attached is a semantic patch that should deal with
that - at least it seems to handle all the cases I've found.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--wmtgul4dtcqfppqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ctime.cocci"

@@
struct inode *inode;
expression val, E1, E2;
@@
- inode->i_ctime.tv_sec = val
+ inode_set_ctime(inode, val, 0)
...
(
- inode->i_ctime.tv_nsec = 0;
|
- E1 = inode->i_ctime.tv_nsec = 0
+ E1 = 0
|
- inode->i_ctime.tv_nsec = E1 = 0
+ E1 = 0
|
- inode->i_ctime.tv_nsec = E1 = E2 = 0
+ E1 = E2 = 0
)

@@
struct inode *inode;
expression val, val2;
@@
- inode->i_ctime.tv_sec = val
+ inode_set_ctime(inode, val, val2)
...
- inode->i_ctime.tv_nsec = val2;

--wmtgul4dtcqfppqy--
