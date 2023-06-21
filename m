Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8058D738C70
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFUQ5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjFUQ5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A33EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4305A615F0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F2AC433C8;
        Wed, 21 Jun 2023 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687366641;
        bh=/OdLCkloJVncRhV1FKt8gD7MorWPsDlrib1dfNI58fI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RWigavUahYfOgy8R8jUMwttNnO43zu6iJZbI4OOZqi4VBtrv1o8aND/IZb0BSeh6P
         ML0XlxiRq+I9IfoSDnNLidgtAGTWqZvFoQZb68mja8lfRNCfN4h19GjZSobfdaRrHD
         K0R0btUujXIiuGPbiEIFfFYF+n+l3zDc6s1jFJMNVLEDT3PaC6aVcLOXtrTyQansL4
         9+bpGLUtVm93YL4dW6KQyGNlRMYiDJkH7LPy8WdRy3UJUzlvT84+A9c5V/ykDxS4o+
         czyCXaNTMnG9N+vE99EoxmALvZiGKViIyNtuSG3z5g3kcWAoCEhOwz8bE704DN+GYk
         X8x3+jXI94Mjg==
Message-ID: <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Date:   Wed, 21 Jun 2023 12:57:19 -0400
In-Reply-To: <20230621164808.5lhujni7qb36hhtk@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144735.55953-1-jlayton@kernel.org>
         <20230621144735.55953-14-jlayton@kernel.org>
         <20230621164808.5lhujni7qb36hhtk@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 18:48 +0200, Jan Kara wrote:
> On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> > In later patches, we're going to change how the ctime.tv_nsec field is
> > utilized. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> ...
>=20
> > diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> > index 1926bec2c850..c964316be32b 100644
> > --- a/fs/bfs/inode.c
> > +++ b/fs/bfs/inode.c
> > @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsi=
gned long ino)
> >  	inode->i_blocks =3D BFS_FILEBLOCKS(di);
> >  	inode->i_atime.tv_sec =3D  le32_to_cpu(di->i_atime);
> >  	inode->i_mtime.tv_sec =3D  le32_to_cpu(di->i_mtime);
> > -	inode->i_ctime.tv_sec =3D  le32_to_cpu(di->i_ctime);
> > +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
> >  	inode->i_atime.tv_nsec =3D 0;
> >  	inode->i_mtime.tv_nsec =3D 0;
> > -	inode->i_ctime.tv_nsec =3D 0;
> > +	inode_ctime_set_nsec(inode, 0);
>=20
> So I'm somewhat wondering here - in other filesystem you construct
> timespec64 and then use inode_ctime_set(). Here you use
> inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? It
> seems these two functions are not used that much some maybe we could just
> live with just inode_ctime_set() and constructing timespec64 when needed?
>=20
> 								Honza

The main advantage is that by using that, I didn't need to do quite so
much of this conversion by hand. My coccinelle skills are pretty
primitive. I went with whatever conversion was going to give minimal
changes, to the existing accesses for the most part.

We could certainly do it the way you suggest, it just means having to
re-touch a lot of this code by hand, or someone with better coccinelle
chops suggesting a way to declare a temporary variables in place.
--=20
Jeff Layton <jlayton@kernel.org>
