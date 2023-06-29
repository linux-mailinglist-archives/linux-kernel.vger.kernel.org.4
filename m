Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4874267E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjF2MdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjF2MdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:33:21 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE2DE2690
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1688041995;
        bh=YvOqWiFtFie40UOJvNP7QURcYJbiCMIxuBeWZGI3Rro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FFasBtSZkbD/nYrxy0SGti29j2w3oPRoBuTZSe4qUakXttC0AXD4p1ZvVacEMQcHy
         evqYPDkhcjuHYXG5J+j84aIB6Ok4o07CocT+IVMvyF/oKwUloNt67fwAACqwcYNv+a
         9gFkX8rM9Wr0wBNmQhf05U2q5TXfvq+7H0sdzrU6eG52lzw8embZxKwQHTa+/gLCwl
         9cVHoZ1PMN0KqwiF76bb1tbkWcVFFriF6PLROCclqvhIocEZQ3iybYu0YNWEgvTrqf
         0zI6mMeqf334Hn8dNaoemmq0301vy7bfJyAhWLWBA7TadA8ryc5fZgXWJ42zecDyo6
         ayst7mHb4uKig==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 86EC111DE;
        Thu, 29 Jun 2023 14:33:15 +0200 (CEST)
Date:   Thu, 29 Jun 2023 14:33:14 +0200
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: don't take signature to be part of the
 commit SHA
Message-ID: <p6by5totn26ofijoki4v6a7lgciswfqovyfrmavtldxg63g2k5@bp3uxxbccxvr>
References: <cmhc6xudksabuza2jrhgs5yg2a2xbohadyyazitg6463uskhjp@enclcjvmbx4r>
 <f316a9d3b9f9d65e6b5542bcd8550ac3b63cbbe2.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ny4gbpphvx5wfdzh"
Content-Disposition: inline
In-Reply-To: <f316a9d3b9f9d65e6b5542bcd8550ac3b63cbbe2.camel@perches.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ny4gbpphvx5wfdzh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 09:11:00PM -0700, Joe Perches wrote:
> On Wed, 2023-06-28 at 22:35 +0200, Ahelenia Ziemia=C5=84ska wrote:
> > Grepped through for /log /, /show /, and /git_command/, and this
> > is all I found. Unsure if there's other git executions that need
> > to be fixed, tho.
> Not sure either but perhaps these should be in some
> negative options variable like:
>=20
> my $git_log_no =3D "--no-show-signature --no-merges --no-color";
>=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -1164,7 +1164,7 @@ sub seed_camelcase_includes {
> >  	$camelcase_seeded =3D 1;
> > =20
> >  	if (-e "$gitroot") {
> > -		my $git_last_include_commit =3D `${git_command} log --no-merges --pr=
etty=3Dformat:"%h%n" -1 -- include`;
> > +		my $git_last_include_commit =3D `${git_command} log --no-show-signat=
ure --no-merges --pretty=3Dformat:"%h%n" -1 -- include`;
> 		my $git_last_include_commit =3D `${git_command} log ${git_log_no} --pre=
tty=3D...
git_commit_info doesn't use --no-merges, and so that'd change the
behaviour of "fixes: xxx"/"commit xxx" thusly:
  $ git log --no-show-signature --no-color --format=3D"%H %s" -1 e3b2e2c14b=
cc12da2c463a7179db39139f682573
  e3b2e2c14bcc12da2c463a7179db39139f682573 Merge tag 'i2c-for-6.4-rc8' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
  $ git log --no-show-signature --no-merges --no-color --format=3D"%H %s" -=
1 e3b2e2c14bcc12da2c463a7179db39139f682573
  afa4bb778e48d79e4a642ed41e3b4e0de7489a6c workqueue: clean up WORK_* const=
ant types, clarify masking
(flattening a referenced merge to its first parent).

Just confirming that's what we want, because I wouldn't think it is?

--ny4gbpphvx5wfdzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmSdeggACgkQvP0LAY0m
WPEUpQ/+IZafp5CVHAA6OoPfwvsxMlSER/5c6p9wqrdeWKwBqv6+DVoqtyNqSsNL
2ioRgZr91/TDOZ7/VWWhlZiU45MALuTSzpXT7Z2OyZMRgpm09XcEijiAVWojaa3Q
2zy3dNPGs46aoDsI/fLSHoYKGOVvlxN35rK7L5zItYXOnEqBYJdRvrIX5n+8P4Pe
7emtPEhevkNHv9DGmz7niPLdXboh/nPEieGNwakuuHr4bMJXiUige+YgAGTn+lDi
1Nc+sP3vhngvFKFY9Gz4zw5yzKLF8q7pVcRsT5g238Hii2Muf909Uk60IZlNPXZm
HXCCfxAsxshXzSUW9kRL5gHqDiLsW7pBy2MTiQxGzTLQNivzRe3qkuHsdZtDfANK
BbQg5MHDHDxSk+6hdHeprm68MordxRbpmzLgyDH3kINnNjsx4qj2gMnVjne3n18D
NjxX1yAGEo1NDtxxk2uojN/bb7d1L03jQfWvE7SHW0xJrVBc/kuvtVIBUmgsABpH
MfEWxxJcBR26sCu4hfeYhJ2gT5FPaKa4kPd9ITddYR/HULY8wJCAg2V1y4VLALyr
wXd9xC2twS36yr4Dh9+sgQpO3HSgX8rB4QAbuZ5n2t6nPUH4u/nAiMyCSjurU90a
r0+anxDbwj4W8JkFo6sF7lp6Ppbjy3FGa/0PeAmlufI1Aj4LZVA=
=+JhW
-----END PGP SIGNATURE-----

--ny4gbpphvx5wfdzh--
