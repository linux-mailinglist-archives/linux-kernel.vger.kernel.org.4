Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAA56D4E85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjDCQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjDCQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD892D41
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD6BC62204
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52787C433EF;
        Mon,  3 Apr 2023 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680541112;
        bh=iqxc59ET3lN3lBscGV9OLRH4v6aWLbJznO+AhkK6vA4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=IAzhI9WwctqC0d+GHe9FFn/UcxLKnAH0rIn8xonBB8gz+5nVL29DckeqjaK/qaefq
         kQjht1tfouiU2hivs3MOsneGFJBAn1S9s+oxZBNAuvd4T2Ohnryw8JXZ8Tyb0q4TDk
         eh5+Ilg3on+MQIfPETduOI26tIa1N4b1hpenCV5EqWJi/KmcXWds/EVMfr5KIdNNK6
         9C8y7EyXPNKB9zjeldz9YrdQFT0UDY5oRKQmjmc9A+WgvEu/zQez2PWHhdDgZDCiKv
         VKBgTXS+3/YieYDIhsDkr35Bn8TJcA0CWZHDxM4d50ZAbnCmPbw5A4uT1RTEcfhNzK
         VsWIu1clW1+2g==
Date:   Mon, 3 Apr 2023 17:58:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regmap: Add maple tree based register cache
Message-ID: <6f49fdf0-c373-46f7-89bd-f30f0fb68c15@sirena.org.uk>
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
 <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
 <20230403154508.qia42tyasj4vhtm5@revolver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pz8PLUjRknEnv01J"
Content-Disposition: inline
In-Reply-To: <20230403154508.qia42tyasj4vhtm5@revolver>
X-Cookie: Membership dues are not refundable.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pz8PLUjRknEnv01J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:45:08AM -0400, Liam R. Howlett wrote:
> * Mark Brown <broonie@kernel.org> [230329 20:10]:

> > The entries stored in the maple tree are arrays of register
> > values, with the maple tree keys holding the register addresses.

> Why not store the registers to values in the maple tree without the
> array?  From reading the below code, the maple tree will hold a ranges
> (based on registers) pointing to an array which will store the value at
> the register offset.  Could we just store the value in the maple tree
> directly?

AFAICT that means that we can't readily get the values back out en masse
to do bulk operations on them without doing a bunch of work to check for
adjacency and then doing some intermediate marshalling, with cache sync
block operations are a noticable win.  I'm *hopeful* this might end up
working out fast enough to make the cache more viable on faster buses.

> > This should work well for a lot of devices, though there's some
> > additional areas that could be looked at such as caching the
> > last accessed entry like we do for rbtree and trying to minimise
> > the maple tree level locking.

> In the case of the VMAs, we had a vmacache, which was removed when the
> maple tree was added since it wasn't providing any benefit.  We lost any
> speed increase to cache misses and updating the cache.  I don't know
> your usecase or if it would result in the same outcome here, but I
> thought I'd share what happened in the VMA space.

Yeah, I'm hopeful that the maple tree is fast enough that it's not worth
it.  The main use case is read/modify/write sequences where you hit the
same register twice in quick succession.

> > +	rcu_read_lock();
> > +
> > +	entry =3D mas_find(&mas, reg);

> mas_walk() might be a better interface for this.

Ah, that's not very discoverable.  mas_find() should possibly be called
mas_find_pausable() or something?

> > +	/* Any adjacent entries to extend/merge? */
> > +	mas_set_range(&mas, reg - 1, reg + 1);
> > +	index =3D reg;
> > +	last =3D reg;
> > +
> > +	lower =3D mas_find(&mas, reg - 1);

> If you just want to check the previous, you can use:
> mas_prev(&mas, reg - 1);
> This will try the previous entry without rewalking from the top of the
> tree and you don't need to mas_set_range() call.

Hrm, right - it looks like that doesn't actually apply the constraints
so that'd work.  The whole specifying constraints for some operations in
the mas is a bit confusing.

> > +    =20
> > +     mas_set_range(&mas, index, last);
> > +     ret =3D mas_store_gfp(&mas, entry, GFP_KERNEL);

> You can avoid this walk as well by changing the order of the code
> before:

> mas_walk(&mas, reg);
> if entry... return
> mas_next(&mas, reg + 1);
> ...
> mas_prev(&mas, reg - 1);
> ...

> This should now be pointing at the location mas_store_gfp() expects:
> mas.last =3D last;
> ret =3D mas_store_gfp()

Don't we need to set mas.index as well?  It does feel a bit wrong to be
just writing into the mas struct.

--Pz8PLUjRknEnv01J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQrBbAACgkQJNaLcl1U
h9BPMgf/Ui2oTezf7ISr0rf8ZIIqbMcDAA6o/QSvY4WA7elSpDVuS2VXfJTRGPB4
PA6TwsvLLJ5ItxJCTdiR/Z/aNcnq4FlTy59K93kzg1j/0qQoQkE0hmzx7Kzwh3ek
xlSfj6IIJsscNHyIskg5D1u0fa7PSZK+2FHJYVv9JB8SALGqZx6P1Do2FJoy+R83
gOeMtCPu7kF9BciL5NBx0Mf6+O8qTvA2UI0MFrrHYODHSGC5LroeSI67rCM+YwW9
6cRSpCyeRpggqLhfaSNHICe0yQwNb8dChVMR+fkbyfCr0NwLQUTjQFLQlctAlHEN
ZSLDkyq9Mc0P+NGxgsVkXFsRSTwNVQ==
=XOAL
-----END PGP SIGNATURE-----

--Pz8PLUjRknEnv01J--
