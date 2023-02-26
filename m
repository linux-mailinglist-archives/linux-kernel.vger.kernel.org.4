Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7C6A3491
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBZWSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBZWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:18:08 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F49BBB3;
        Sun, 26 Feb 2023 14:18:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PPygc2nm8z4x80;
        Mon, 27 Feb 2023 09:18:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677449885;
        bh=AiXfxdXTWzEsQr34CRW3iDvQyVOgrswdRHZ4Y6rELTo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ps++lvJA+yZaLNtxbZt/mzhOsekkdFcVsf4UPvyYVFmDeGVVa8IAljJiBUiYpLZbu
         j3sFtvM8bNC7oVGJv8U5qu1tTXd49zmQicgdHpqFxiojpaA1LGbIEBAegGDTIBB2O4
         gQia9uKXKFiWbbnRCY2FkpvC3yjV1SRgftUq448gMvior9Uae5CjIVkpYnmNWTyFBV
         q+f1FObI99YP3erIPjaifowucqaLh67afoK218SLdPmy77XzhITQJxQFGg4l6gzF5Y
         MaYoZlisG0zCaxPVoLOB/SOgi+9MybW+UX/6iw0gB1oJQSvxpa/U+YFJwRIvRTtHgd
         tQQkY/uxW+TxA==
Date:   Mon, 27 Feb 2023 09:18:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230227091803.5e29b563@canb.auug.org.au>
In-Reply-To: <20230130080956.ikb3w5cjkhtxqzcr@wittgenstein>
References: <20230130161414.25a71a87@canb.auug.org.au>
        <20230130080956.ikb3w5cjkhtxqzcr@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MDSDkz7un69i84TtOnuOtUC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MDSDkz7un69i84TtOnuOtUC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, 30 Jan 2023 09:09:56 +0100 Christian Brauner <brauner@kernel.org> w=
rote:
>
> On Mon, Jan 30, 2023 at 04:14:14PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the mm tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >=20
> > kernel/sys.c: In function '__do_sys_prctl':
> > kernel/sys.c:2664:9: error: duplicate case value
> >  2664 |         case PR_SET_HIDE_SELF_EXE:
> >       |         ^~~~
> > kernel/sys.c:2655:9: note: previously used here
> >  2655 |         case PR_SET_MDWE:
> >       |         ^~~~
> > kernel/sys.c:2669:9: error: duplicate case value
> >  2669 |         case PR_GET_HIDE_SELF_EXE:
> >       |         ^~~~
> > kernel/sys.c:2658:9: note: previously used here
> >  2658 |         case PR_GET_MDWE:
> >       |         ^~~~
> >=20
> > Caused by commit
> >=20
> >   ab30677b499c ("mm: implement memory-deny-write-execute as a prctl")
> >=20
> > interacting with commit
> >=20
> >   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> >=20
> > from the pidfd tree.
> >=20
> > I have applied the following merge fix patch.
> >=20
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 30 Jan 2023 16:08:34 +1100
> > Subject: [PATCH] mm: fixup for "mm: implement memory-deny-write-execute=
 as a prctl"
> >=20
> > interacting with
> >=20
> >   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > --- =20
>=20
> Thanks Stephen,
>=20
> I'm moving this out of -next for now until we've settled a few more
> details.

I am still applying this to the merge of the pidfd tree.  Also I
noticed that a similar fixup will need to be applied to
tools/testing/selftests/prctl/hide-self-exe.c

--=20
Cheers,
Stephen Rothwell

--Sig_/MDSDkz7un69i84TtOnuOtUC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP72psACgkQAVBC80lX
0GyPQQf+IXLCzLRVcFE2V22gMpcgkUwWa0ErgmMOQPeUBlV59213loGEByX2LhPN
gaKH3FiCW/cfRKgdiMMTh/4u/v13h4xKgEt4D67HFtPKXcb/UqKW6+PuU3O/Xh+v
2Ktr4QR3eKSV8W2I9sK78La847K5LjbfpOvNYFmA/aOFJO0Iv/b5e+zDPmMSONO7
OIwrtEb/x6OMVhTX8mO6y6Qt8FTfmmcyP0Am33n131Zl9wC6tQUwVJq0iE0rnE8b
LocUffkPLWrrVTbCLfj84LRFtzT/XemUuoVI4HOGAKWgS3Hvn8LFDn5hXRBMAgDB
n8DDyLXhhS0Dk1OQAdIUzcNxK5RXKA==
=DvlT
-----END PGP SIGNATURE-----

--Sig_/MDSDkz7un69i84TtOnuOtUC--
