Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DD1698871
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBOXBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOXBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:01:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D66868C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:01:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF2161DC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63738C4339E;
        Wed, 15 Feb 2023 23:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676502072;
        bh=qUAQ4o1k3Tx16YTQ5EJjEyz2cYifF3N6njNHqinnFqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCpefWQKqXBMBJNBJ/9+pRNem0PAWlKM61g89lD3yJ/ioHm1Sd3cHUz20oaDrU8q0
         hmFi271nnK2TGxryySurJCjh8gsAPpY1TsRpnyh9tL+6+XLfCVYS1qXUooCXJrqXrG
         VDPFtyNsrieJIpT/1/5Wx8trJiBJg6h4gGlLnFcKaFKG93JPSCKm1U5sgEdEQ9rbtk
         P6xYMINwaww1aXpSAixISAsHC/tVGg5ySFRRPHAMkq+DvHpgdVA7ekjW3hweQMpEY5
         pjdjmCvfPTqvSkFLU0kLMRsfW33OjnpGaUj7ctmzwDh9RRskxLTTE/cdGLNY9nXgp1
         cnrNLV7KpdOoA==
Date:   Wed, 15 Feb 2023 23:01:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] ASoC: da7219: Improve the IRQ process to increase the
 stability
Message-ID: <Y+1kNa8KYCUzgAfo@sirena.org.uk>
References: <20230215101045.21456-1-David.Rau.opensource@dm.renesas.com>
 <Y+zZwKFX1gMC5/ac@sirena.org.uk>
 <CABXOdTdv=+n8+UCgWUvyrZ6R0uAu48bODa3TA_2nUuMbUT7MUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e1E9LnR+Ahmxjv3e"
Content-Disposition: inline
In-Reply-To: <CABXOdTdv=+n8+UCgWUvyrZ6R0uAu48bODa3TA_2nUuMbUT7MUg@mail.gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e1E9LnR+Ahmxjv3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 15, 2023 at 08:06:35AM -0800, Guenter Roeck wrote:
> On Wed, Feb 15, 2023 at 5:10 AM Mark Brown <broonie@kernel.org> wrote:

> > Copying in Guenter given the issues he raised with this, not
> > deleting context for his benefit.  It looks like this should
> > avoid the issues with the interrupt appearing locked up.

> It should since it limits the delay to cases where jack_inserted is
> false, but on the other side it hides the delay in an odd way.
>=20
=2E..

> Effectively this seems to be quite similar to moving the conditional
> sleep to the place where cancel_work_sync() is called. I would assume
> that will fix the problem (after all, the msleep() is no longer called
> unconditionally), but I don't see the benefit of introducing a worker
> to do that. Also, since there is no guarantee that the worker actually
> started by the time cancel_work_sync() is called, I would suspect that
> it may result in unexpected behavior if the worker has not started by
> that time, which I would assume can happen if the system is heavily
> loaded. It also makes the use of the ground switch (i.e., when to set
> and when to drop it) even more of a mystery than it is right now.

> Having said that, I don't really know or understand the code, so maybe
> this all makes sense and my feedback should be ignored.

Yes, I would certainly welcome more clarity especially around the
ground switch.  OTOH it does seem like an improvement over the
current situation so I think I'll go ahead and apply it for now,
hopefully it can be improved upon in future.

--e1E9LnR+Ahmxjv3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPtZDQACgkQJNaLcl1U
h9D+3Qf7B/pdT2c5Gz6fLqeKbf9iXv7oOvDmvUhZUnPiTDyuuQ5fDNg+WDBp/i7K
6Y7Je3c8seM0sdixYFrb3zG52ob3NMmU9a/cdcjpTaRGl7FI+BJDjApQPCY5Usbu
7Sai0SVpv+mMPo5lzsyfAD7E0YjrfvvHWved7r8plXhsVCZK0Su4idwBczw6Axn4
cCV7f0f0Vp2nihlDJQaSeX+j3qgkR4yq8Da33GJQnaapiens51aZDsmQrvuLOxUO
cDr+kcKa5rlvXM77XHqX1N0xI0Ev+pESxSkcCGrOwq3CtgeWdXyeeATNEUn8rKXC
pXmYs3mBaH3o3lywQLh9MITFtHuG/Q==
=LJK/
-----END PGP SIGNATURE-----

--e1E9LnR+Ahmxjv3e--
