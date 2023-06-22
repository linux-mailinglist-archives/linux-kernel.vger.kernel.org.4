Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332173A13C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjFVMwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66F18C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B18D46182E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7373FC433C8;
        Thu, 22 Jun 2023 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687438320;
        bh=PSC33hESgFExf5tG2kZ0py17djoyBcdSMaPPGvVFKaU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ukrpDNkerHgmi5t32CoX13rRMbL8aGK6TuU9OmgwZ8Y6i840zSV1vwldqCboeP122
         c5rnEe7O2K1Ipm4u14uDomC1UAokQWdSDoo7YINWM9LKpW6qIySvNWa/61qA27LQS3
         bBlT6W83rHRDsR7Urbj/FBYKD2kyZfXs/B0j16RvX+ZoYzEUtqp429lXD7b0a4esS3
         oAppNw7EfG/1fKvc3/q+83GzIvzkrSMnqtz6oqFmBxmHKMSKxO6Oy2Fu0pXk2pxcbo
         lvpPkPURMuG0u94GGmAAMKrxJffUHDcnrRZCtqxmTwQwOKsj41qq0omezBo9fPIIVT
         Rq0FLjDMMSTuQ==
Message-ID: <d316dca7c248693575dae3d8032e9e3332bbae7a.camel@kernel.org>
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        "damien.lemoal" <damien.lemoal@opensource.wdc.com>
Date:   Thu, 22 Jun 2023 08:51:58 -0400
In-Reply-To: <20230622123050.thpf7qdnmidq3thj@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144735.55953-1-jlayton@kernel.org>
         <20230621144735.55953-14-jlayton@kernel.org>
         <20230621164808.5lhujni7qb36hhtk@quack3>
         <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
         <20230622123050.thpf7qdnmidq3thj@quack3>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-22 at 14:30 +0200, Jan Kara wrote:
> On Wed 21-06-23 12:57:19, Jeff Layton wrote:
> > On Wed, 2023-06-21 at 18:48 +0200, Jan Kara wrote:
> > > On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> > > > In later patches, we're going to change how the ctime.tv_nsec field=
 is
> > > > utilized. Switch to using accessor functions instead of raw accesse=
s of
> > > > inode->i_ctime.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > >=20
> > > ...
> > >=20
> > > > diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> > > > index 1926bec2c850..c964316be32b 100644
> > > > --- a/fs/bfs/inode.c
> > > > +++ b/fs/bfs/inode.c
> > > > @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, =
unsigned long ino)
> > > >  	inode->i_blocks =3D BFS_FILEBLOCKS(di);
> > > >  	inode->i_atime.tv_sec =3D  le32_to_cpu(di->i_atime);
> > > >  	inode->i_mtime.tv_sec =3D  le32_to_cpu(di->i_mtime);
> > > > -	inode->i_ctime.tv_sec =3D  le32_to_cpu(di->i_ctime);
> > > > +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
> > > >  	inode->i_atime.tv_nsec =3D 0;
> > > >  	inode->i_mtime.tv_nsec =3D 0;
> > > > -	inode->i_ctime.tv_nsec =3D 0;
> > > > +	inode_ctime_set_nsec(inode, 0);
> > >=20
> > > So I'm somewhat wondering here - in other filesystem you construct
> > > timespec64 and then use inode_ctime_set(). Here you use
> > > inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? I=
t
> > > seems these two functions are not used that much some maybe we could =
just
> > > live with just inode_ctime_set() and constructing timespec64 when nee=
ded?
> > >=20
> > > 								Honza
> >=20
> > The main advantage is that by using that, I didn't need to do quite so
> > much of this conversion by hand. My coccinelle skills are pretty
> > primitive. I went with whatever conversion was going to give minimal
> > changes, to the existing accesses for the most part.
> >=20
> > We could certainly do it the way you suggest, it just means having to
> > re-touch a lot of this code by hand, or someone with better coccinelle
> > chops suggesting a way to declare a temporary variables in place.
>=20
> Well, maybe temporary variables aren't that convenient but we could provi=
de
> function setting ctime from sec & nsec value without having to declare
> temporary timespec64? Attached is a semantic patch that should deal with
> that - at least it seems to handle all the cases I've found.
>=20

Ok, let me try respinning this with your cocci script and see how it
looks.

Damien also suggested in a reply to the zonefs patch a preference for
the naming style you have above. Should I also rename these like?

    inode_ctime_peek -> inode_get_ctime
    inode_ctime_set -> inode_set_ctime

This would be the time to change it if that's preferred.
--=20
Jeff Layton <jlayton@kernel.org>
