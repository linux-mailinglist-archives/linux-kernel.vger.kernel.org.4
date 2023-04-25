Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFFF6EE243
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjDYM4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjDYM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389A9D30E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7EA5616A0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 12:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64233C433D2;
        Tue, 25 Apr 2023 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682427388;
        bh=WFqdsbjQA1vnRQupRN+CqeKWDQbtJsSTLh4Q8kWeiBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz9CkJDJSSNnCzcLYr28xns7faj4QIsO0/JpqjpFPybCvR88QDD5j6cVHVCMduRWE
         qf6hs8GOuZuERt3CYLMkuFUdYdNSqK1MhsOfD4jekuQ4XpOFnzeGfes4t0WdWDTxOP
         FcboqPS4mh0pUHGUjxUqTN6MOi+mY9ikW4Fb31W17hqis8fP6sqYmNvyOfsEdCrFq7
         x26VQQ/oOZP8PcfahKaQfu1VKmWwA7p+DDE2Yr+c6ZjGA4OxfFTXINMQQ3F3ue8rR5
         udrnVlW4bPrT9l0HssFu7ho6WRq+TjawmRs0ZTRHqANAsWxPDNXloIlxkjHmeeB8Ss
         B2tCqTyQgERsQ==
Date:   Tue, 25 Apr 2023 13:56:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
 <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DiFt6ZB+CLaQPege"
Content-Disposition: inline
In-Reply-To: <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
X-Cookie: The meek don't want it.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DiFt6ZB+CLaQPege
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2023 at 08:50:30AM -0700, Colin Foster wrote:
> On Thu, Apr 20, 2023 at 05:06:17PM +0200, Maxime Chevallier wrote:

> > On regmap consumers that require address translation through
> > up/downshifting, the alignment check in the regmap core doesn't take the
> > translation into account. This doesn't matter when downshifting the
> > register address, as any address that fits a given alignment requirement
> > will still meet it when downshifted (a 4-byte aligned address will
> > always also be 2-bytes aligned for example).

> > However, when upshifting, this check causes spurious errors, as it
> > occurs before the upshifting.

> I don't follow why upshifting should make a difference to alignment.
> Assuming it does though, would it make sense to test

> map->format.reg_shift > 0

> instead of just !map->format.reg_shift?

Yeah, I think the question is more when we should run the alignment
check than if we should have one.  I think running the check after any
shifting makes sense, we'd be better off reorganising the checks if
needed than removing them.

>=20
> > -	if (!IS_ALIGNED(reg, map->reg_stride))
> > +	if (!map->format.reg_shift && !IS_ALIGNED(reg, map->reg_stride))
> >  		return -EINVAL;
>=20
> In the case of ocelot_spi, we'd want to flag an invalid access to a
> register like 0x71070003... Before this patch it would return -EINVAL,
> after this patch it would access 0x71070000.
>=20
> Colin Foster

--DiFt6ZB+CLaQPege
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRHzfYACgkQJNaLcl1U
h9Cpggf/c7E3rKx9CqXXzBlq45k7DnQbPm0a1LBhR2l4e4Tt8fLdhpImflz2foAJ
rwiYt18SG3Lr8eXqXrPjItqjiHb79lpjJdB1rlze6rkVJohxVlpxTWZPYnCmhcXu
7NYMzlQpCiPZZzVqmIDF9/IuA/3pinFBVegyzJxdbjbhBGUZDvIL2hez0D2JfAlD
97OlNQPwEJ46d/AoWZjhHecb+7gWHZZRzvREkiqTYDAqrg5ZSXm3DJ+v6j0EfCV2
sWYYyjXdN0x5mLy7yZDiBnDP8FdQh5Fk+A/kQ1gR3Rqh69CJFEuv+O6+mkOgnVmf
VKTVmhsWvZwsYRp1jTkxeUbuv4CKmQ==
=+cEC
-----END PGP SIGNATURE-----

--DiFt6ZB+CLaQPege--
