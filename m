Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE80969DAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjBUGoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjBUGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:44:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997021ABDC;
        Mon, 20 Feb 2023 22:44:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLVBB4Kzxz4x5c;
        Tue, 21 Feb 2023 17:44:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676961842;
        bh=WdReY2/wAVvJYZnti5npjpayWKfRwp+N3NvydloCdGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VVNPkztK7UUoW8RuPRS8gWwL6B6iA5X+TrFeqkH9TpEtoui13sr+MOF7eIEH1ZhCD
         xCAeK2GX3jE3nCZ4TvJiTFcLWCtUgJbCPnKAcB+ox8q0LQoz4TssmvvB3t8o1WGouB
         ItK0bMJmyd20husqzbaPXOrjX80xh45mny8j6CQwGr+CEd2wMnh0HLEQQpRuLRh//O
         64MKGCX0Hj8FgBTmHvDYfxgv5xp9+BNa9bpxqYuoi2AdkrspTjt/ZRuNoGgF0FqIR/
         J3yFl1cZeE2HPTBzn4roo81+GIcIwEmLizEBE2p7Vjt/8mP4xghd5Jahk2XbxDDfy7
         vhqF4Os7xR1Qw==
Date:   Tue, 21 Feb 2023 17:44:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230221174401.7198357d@canb.auug.org.au>
In-Reply-To: <Y/Pe2xHklSr1hDtz@casper.infradead.org>
References: <20230220152933.1ab8fa4a@canb.auug.org.au>
        <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220190157.3b43b9a7@canb.auug.org.au>
        <Y/Pe2xHklSr1hDtz@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ki1YF7XklYAV5e=2qQ+JFWu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ki1YF7XklYAV5e=2qQ+JFWu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, 20 Feb 2023 20:58:03 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Feb 20, 2023 at 07:01:57PM +1100, Stephen Rothwell wrote:
> > Hi Matthew,
> >=20
> > On Mon, 20 Feb 2023 13:58:29 +0000 Matthew Wilcox <willy@infradead.org>=
 wrote: =20
> > >
> > > On Mon, Feb 20, 2023 at 03:29:33PM +1100, Stephen Rothwell wrote: =20
> > > >=20
> > > > Today's linux-next merge of the mm-stable tree got a conflict in:
> > > >=20
> > > >   fs/cifs/file.c
> > > >=20
> > > > between commit:
> > > >=20
> > > >   c8859bc0c129 ("cifs: Remove unused code")
> > > >=20
> > > > from the cifs tree and commits:
> > > >=20
> > > >   4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use f=
ilemap_get_folios_tag()")
> > > >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> > > >=20
> > > > from the mm-stable tree.
> > > >=20
> > > > This is a real mess :-(   =20
> > >=20
> > > Doesn't look too bad to me.  Dave's commit is just removing the
> > > functions, so it doesn't matter how they're being changed. =20
> >=20
> > The problem I see is that an earlier commit in the cifs tree moves the
> > use of find_get_pages_range_tag() to another function and 4cda80f3a7a5
> > then removes find_get_pages_range_tag(). =20
>=20
> Ah.  Just removing all traces of it should be fine.  As long as there
> are no remaining callers of find_get_pages_range_tag() after the merge,
> it's good from my point of view.

But I can't do that since commit

  d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than =
a page list")

in the cifs tree introduces a new usage of it in code that is used in
the cifs code ... so someone has to figure out what the merge
resolution is between the 2 trees (how to replace that new usage) and
let me know and then we need to test that combination for a while
before asking Linus to take it.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ki1YF7XklYAV5e=2qQ+JFWu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0aDEACgkQAVBC80lX
0GzEzAf/YEhRpepelO04fFm7U1b3tHAO6/WzX3JlWR6VZev2gVRN8/tbz4UK59/0
7G2ocGc10R8Jb2/DFt+715oav9juyL3OaZXo5H8q1wCwK26KkEerDEhDdJFyfFQy
5GLcR4pwbZAPpZoY+sfvLRACSylYUkDrSjAWLv1cwCJ+zYSIg6kcajPBFdIW5Nss
cg4rS4HTI4bJmnhwfSsQXFTKwEpE2TIloD3tLtbu9xLLtAl9fhSrdFCM7vCYglT2
rz1tCB+k8nPDWZ89jlh4X7pL2/oXr18OP1p9eRo2zvBSHSutJ/w9ce1piY3sphVT
GenksRz1QDHakejMYo/xeb5NB+ykFA==
=2mN+
-----END PGP SIGNATURE-----

--Sig_/Ki1YF7XklYAV5e=2qQ+JFWu--
