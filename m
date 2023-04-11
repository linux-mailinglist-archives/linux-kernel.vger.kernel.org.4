Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980066DE67B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDKVeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKVeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:34:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159504228;
        Tue, 11 Apr 2023 14:34:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pwzd405nrz4xGK;
        Wed, 12 Apr 2023 07:34:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681248872;
        bh=NdF58jLHx4n+4W97Ekl7289ni3p0YZEUJn6YKApCCNA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ferQ/4U4HZViVUp+nilMKGhbvcfbNMFfPb82e33THuNvGjLVRssGo2BvQqL2DHExG
         61X3e7rp+IiZHwN6rAvVgNqEYOmJKgZZnUbqcy/7ZiSK4l4ZPJxogsEkEBSjW/8Hnl
         pwp3EeGs3Vn18ZkxVQPtSydcACRaqsDKjWPbA75pwZt21AjfiVukOcTDX4zb3XyeqA
         OG6N7W6C37pRdL6IImbUxK0Kc6GXBWBSTL6W8KYZo3230eYS3sZ5BcWE3fv//MIkUB
         5etxLEJdLN2qIVzQqC0XGj86LJRicBWsjnwOqy7yqZPMXM2EMv1ZMFoikkqgqfloiA
         m0dbmqK9Ytsfg==
Date:   Wed, 12 Apr 2023 07:34:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230412073416.73a8ea1a@canb.auug.org.au>
In-Reply-To: <20230328104719.65133586@canb.auug.org.au>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qrK=WyadaQFbKuH9/nY8L+F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qrK=WyadaQFbKuH9/nY8L+F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 28 Mar 2023 10:47:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 27 Mar 2023 09:26:30 -0700 Josh Poimboeuf <jpoimboe@kernel.org> w=
rote:
> >
> > On Mon, Mar 27, 2023 at 12:00:17PM +1100, Stephen Rothwell wrote: =20
> > >=20
> > > After merging the block tree, today's linux-next build (x86_64
> > > allnoconfig) produced these warnings:
> > >=20
> > > lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundan=
t UACCESS d
> > > isable
> > > lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call t=
o copy_comp
> > > at_iovec_from_user.part.0() with UACCESS enabled
> > > lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_=
compat_iovec_from_user.part.0() with UACCESS enabled
> > >=20
> > > Presumably introduced by commit
> > >=20
> > >   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")=
   =20
> >=20
> > I'm not able to recreate.  What's your compiler version? =20
>=20
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0

Any progress?
--=20
Cheers,
Stephen Rothwell

--Sig_/qrK=WyadaQFbKuH9/nY8L+F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ10lgACgkQAVBC80lX
0GyxTgf/S/DpX0i3xcxkRMLHaD9vn/nsWzi1FcbKT6J2tHPbSw32j+gyNzNpjWcf
uvJZV3kPoWEQf3Xu+awn06dfk2vXLdaAvc1zAIK98Qk9K8dPFzpBUEfB2ZUA8+Du
d0lqUrR/xa+IYhFVWoWA64isNi/jK3uU/IgVq2FkuAlT7rd722sLS618NLyCQIsv
ntKvTN2luABb5nlhd/BFGqJ1KBldqc/KK/Jr7awrp/91Y7Tj10GcfJFOXrxTjtgd
MB5P8b5/SkoQhJrqmZKjoekgTluKmyavv/SpAuWEBvduVqlLztKrvX2ikl0JLT7+
e2FdLGYj55d2aYdOM+/rZ+SgWGdunQ==
=VA7W
-----END PGP SIGNATURE-----

--Sig_/qrK=WyadaQFbKuH9/nY8L+F--
