Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4F696ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBNVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:06:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5329759
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8482B81F44
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 21:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1221C433EF;
        Tue, 14 Feb 2023 21:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676408793;
        bh=rPKJCRasuq9TquryFfdx87T1wNg8t+dYuch6LyE+yDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvLOwJokEdBBkLEItmAWHu++ANqliFCR7iwTBeswEUImoKP/OmfzpzesRwIZBV+s7
         DJV78LdE7wf8ikpr3PDBvIvl42ogohcCjk18O/QvWuF1yAjJ7iVBI5qbeV6eKoih7w
         Dq6t1kSfyglCN6o/QiCccLm9u7+ZsPoxm7POA+16zMhdTSD9QQAaOIDYfukDRrxsAJ
         8RXFzN7Ls+FWCP56W7fBzWCATE1k06wFJJ0R/MY5lgGceulfPOR/ue2Y5EQGHE1Ldu
         F62KgwonJPCa5USgTvQzgppqQm59AI8dcCJAEPjX7z+A/MeW24x6RoSnnigzO5ZR8V
         /wu+2+7gLO9mQ==
Date:   Tue, 14 Feb 2023 21:06:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 4/6] regulator: Add operation to let drivers select vsel
 register
Message-ID: <Y+v31bkMWxPEVqrT@sirena.org.uk>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-5-frieder@fris.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NaBXGsd+qhj6WDye"
Content-Disposition: inline
In-Reply-To: <20230213155833.1644366-5-frieder@fris.de>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NaBXGsd+qhj6WDye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 04:58:22PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> There are regulators that use multiple registers for storing the
> voltage. Add a get_reg_voltage_sel member to struct regulator_ops in
> order to let drivers register a function that returns the currently
> used register.
>=20
> The pca9450 driver will be a user of this as the LDO5 regulator of
> that chip uses two different control registers depending on the
> state of an external signal.

Aside from the build warnings the bots reported it's not clear to
me that it's better to do this than it is to just have these
drivers implement appropriate ops directly - there's probably
going to be cases when it's a different bitfield in the same
register, and by the time you've implemented the op so things
aren't completely data driven I'm not sure how much you win by
reusing the register read/write.

--NaBXGsd+qhj6WDye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPr99QACgkQJNaLcl1U
h9Dm0Af/T9/6tAxXnRh5Wr5xXNCxbTqyF59h9AU3Zzc75ebXkVxeay8+pFeDJK1i
EF40vqbKO2ZOgtVa4A1YcZRH203yQYW2L9AgZR7eV58gkS9zK70go9jCKiZb2WQX
0+lISHovUIq9sV1tca1Qtgd/J4/kGaINJZN5l7JAHmzlodB5vFt9AuGXKZPz0+VU
lzZ9+t7RyzZY1LruiLuXovzLD5vOmRA961ZT7RGhkaZKdMiOgusq0/XjyXdIjieg
z3Xw2ZVycWGCenie3qxnIyIeyZRPE6kH6J5FTzkinMjxu3lQKsZqlWz9Ct0Q0wxY
dFDSvYzV6Ve11Q30hP1I8UD+1CKUsw==
=3jaZ
-----END PGP SIGNATURE-----

--NaBXGsd+qhj6WDye--
