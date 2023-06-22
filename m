Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5573A88D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFVSrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjFVSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:47:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995902693;
        Thu, 22 Jun 2023 11:46:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08F76618DB;
        Thu, 22 Jun 2023 18:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620D5C433C9;
        Thu, 22 Jun 2023 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687459616;
        bh=aoZEIYZEdwo95vf6kneu0rBSKd4FMAQlbn+BrfpOvy8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VgVDLBByYxHIs1HHLMNk2QwMx2pjcUv0P7lmmQ8XhYnH7IkHIWjLnPnXviGC/RF3v
         xWPsghobOJfsv4Y8JEGD7CapSZJXAyCsErof5m+AFlYLbJNqqlrj8eL2eEFyVrEj0B
         iAWsnZl6JnQvNPXJMhkPtffq2Si9xh/pRXqAw27064stvWZ/1R1iDkWqwhxreI8JGZ
         81IaBrCt/qXRSwcLM+OCq/pjEhH2U+bDioe6WkTJeXX7jjIIPRb+P/MxaBeBnw+osD
         LLEYQtajamtnww+9wmY0jQg25p+iYgjbkzwrmJGJzxvyvaE+32LQsHvnZx27cJgbMt
         cPUKO+EwO2YsQ==
Message-ID: <a76feaed107e83c2d356438cd04b5c790550c92c.camel@kernel.org>
Subject: Re: [PATCH 03/79] s390: switch to new ctime accessors
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 22 Jun 2023 14:46:54 -0400
In-Reply-To: <ZJSRf9FnEFc+dPO6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20230621144507.55591-1-jlayton@kernel.org>
         <20230621144735.55953-1-jlayton@kernel.org>
         <20230621144735.55953-2-jlayton@kernel.org>
         <ZJSGVjryWEjbeW1U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
         <468a895b93b83ed6369ea95519f832998a89d76f.camel@kernel.org>
         <ZJSRf9FnEFc+dPO6@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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

On Thu, 2023-06-22 at 20:22 +0200, Alexander Gordeev wrote:
> On Thu, Jun 22, 2023 at 01:51:33PM -0400, Jeff Layton wrote:
> > On Thu, 2023-06-22 at 19:35 +0200, Alexander Gordeev wrote:
> > > On Wed, Jun 21, 2023 at 10:45:16AM -0400, Jeff Layton wrote:
> > >=20
> > > Hi Jeff,
> > > > In later patches, we're going to change how the ctime.tv_nsec field=
 is
> > > > utilized. Switch to using accessor functions instead of raw accesse=
s of
> > > > inode->i_ctime.
> > > >=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  arch/s390/hypfs/inode.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
> > > > index ee919bfc8186..30fa336ec63e 100644
> > > > --- a/arch/s390/hypfs/inode.c
> > > > +++ b/arch/s390/hypfs/inode.c
> > > > @@ -53,7 +53,7 @@ static void hypfs_update_update(struct super_bloc=
k *sb)
> > > >  	struct inode *inode =3D d_inode(sb_info->update_file);
> > > > =20
> > > >  	sb_info->last_update =3D ktime_get_seconds();
> > > > -	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D current_=
time(inode);
> > > > +	inode->i_atime =3D inode->i_mtime =3D inode_ctime_set_current(ino=
de);
> > > >  }
> > > > =20
> > > >  /* directory tree removal functions */
> > > > @@ -101,7 +101,7 @@ static struct inode *hypfs_make_inode(struct su=
per_block *sb, umode_t mode)
> > > >  		ret->i_mode =3D mode;
> > > >  		ret->i_uid =3D hypfs_info->uid;
> > > >  		ret->i_gid =3D hypfs_info->gid;
> > > > -		ret->i_atime =3D ret->i_mtime =3D ret->i_ctime =3D current_time(=
ret);
> > > > +		ret->i_atime =3D ret->i_mtime =3D inode_ctime_set_current(ret);
> > > >  		if (S_ISDIR(mode))
> > > >  			set_nlink(ret, 2);
> > > >  	}
> > >=20
> > > I guess, inode_set_ctime() called from inode_ctime_set_current()
> > > updates i_ctime and is part of some other series?
> > >=20
> >=20
> > No, that gets added in patch #1 of this series.
> >=20
> > You should have gotten cc'ed on that one, though the postings to vger
> > mailing lists of patches 1, 2, and 79 bounced because the mail header
> > length on those was >8k.
>=20
> I actually received #1, if we're talking about this one:
> https://lore.kernel.org/all/20230621144507.55591-2-jlayton@kernel.org/
>=20
> I see inode_set_ctime() gets called, but nowere defined.
>=20
>=20

That's a bug -- that should be calling inode_ctime_set() instead. It
gets fixed up in a later patch in the series, but that should be fixed.

I'm already respinning this now with an updated coccinelle patch. I'll
make sure that's correct on the next posting.

Thanks,
--
Jeff Layton <jlayton@kernel.org>
