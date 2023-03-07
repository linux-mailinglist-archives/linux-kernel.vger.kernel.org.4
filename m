Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575796ADE06
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCGLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjCGLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:52:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB736470;
        Tue,  7 Mar 2023 03:51:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PWDLQ488Gz4x8y;
        Tue,  7 Mar 2023 22:51:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678189886;
        bh=DkIdiKTvUE6XytdhHB1+DL4OHRdTQaxskfUkPQU8XME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZTr+bTInxFsUngiO+1u9vRc995MjUn/i64uh7aGbx0bFmJHEBE23Y6bpAr0aN65gs
         99pyEVzk16e979bi4GKowHSDHDwI1W9ll+d7lw/E7dAIeeqp3CurNsnETRjlU5/7iZ
         FDmiyan/0exQspl0h6SOqj+PDj9nV9iP7h2XfZnyyA51yCw7dbEKFpwMwJlQer7cXx
         My+C2UCNOeeB4FdVXUSLnks4U+UUpOBcvd7X+781p7WpHJghF+5WkCFbVUkGnyTp/A
         Gwidbq+Th315BaCvYsJ7lFXJ9Wz9nNhdEKVcbVA7xTDHq5TNluVrCNofJZYam+gnvM
         wYVvupHDPZv5A==
Date:   Tue, 7 Mar 2023 22:51:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the driver-core tree
Message-ID: <20230307225119.6c3e257c@canb.auug.org.au>
In-Reply-To: <ZAbvdBbavVDnlgnJ@kroah.com>
References: <20230307134313.1b2aa555@canb.auug.org.au>
        <ZAbaXeEKfUJY+hYx@kroah.com>
        <20230307174855.73b474df@canb.auug.org.au>
        <ZAbvdBbavVDnlgnJ@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OVeD9.RScT9Owt9CT+E7gNc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OVeD9.RScT9Owt9CT+E7gNc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, 7 Mar 2023 09:01:56 +0100 Greg KH <greg@kroah.com> wrote:
>
> On Tue, Mar 07, 2023 at 05:48:55PM +1100, Stephen Rothwell wrote:
> > Hi Greg,
> >=20
> > On Tue, 7 Mar 2023 07:31:57 +0100 Greg KH <greg@kroah.com> wrote: =20
> > >
> > > On Tue, Mar 07, 2023 at 01:43:13PM +1100, Stephen Rothwell wrote: =20
> > > > Hi all,
> > > >=20
> > > > After merging the driver-core tree, today's linux-next qemu boot
> > > > (powerpc pseries_le_defconfig) produced this boot time warning:
> > > >=20
> > > > HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
> > > > sysfs: cannot create duplicate filename '//block'   =20
> > >=20
> > > That is odd.  What type of userspace are you running this with?  And =
is
> > > there a pointer to the .config anywhere?  No one should be needing th=
is
> > > old config option anymore, but maybe I messed something up in removing
> > > it... =20
> > The userspace is a trivial PowerPC LE initramfs that just shuts down
> > after it boots.  However, the warning occurs before the initramfs is
> > even unpacked.
> >=20
> > I have attached the generated .config =20
>=20
> No .config was attached :(

Yeah, sorry, by the time I noticed you had posted that you thought you
knew what the problem was, so I didn't bother sending it.

> Anyway, should now be fixed with:
> 	https://lore.kernel.org/r/20230307075102.3537-1-gregkh@linuxfoundation.o=
rg
>=20
> I'll queue that up to my tree so hopefully linux-next will be working
> properly tomorrow.  Sorry for the bug.

OK, thanks.  I will let you know if it still warns ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/OVeD9.RScT9Owt9CT+E7gNc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQHJTcACgkQAVBC80lX
0Gx99gf/f8VIZ0Gj82b6MwF3ez1hg/BNnLMd/wkRtIUDCzjjr6B2jeJ8ebAAp1ZI
jPWDeWImSKYDKv1VtzJGCsnYJ+8RA7JZFxZNh62B3PEyk0TmYh1dlMaKm8n72YqE
Y1U9vAzg5SiUpc2LOIm8l3ExSRppU1RB/Lqoqh8ovP8qnHyPqrqq8C96S5YJ3vjz
On0C40GgAAUvOGHpeQw7EnDtLt11MpgP/wbXkx5NtHN8cOtYeRQw2j56c0OdTs/f
UPeY7KsLt7z2s/KzgpARk6maFsmjl5bhyiWJWxXUBk7hyZVyakKNPWfzVCWHyF/P
1KbsgKdE8M9uv3dZ1s6CMpNew61SHg==
=svFU
-----END PGP SIGNATURE-----

--Sig_/OVeD9.RScT9Owt9CT+E7gNc--
