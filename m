Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9362B742834
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjF2OXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF2OXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930D19B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D59586153C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB3C433C8;
        Thu, 29 Jun 2023 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688048595;
        bh=Cl64NSXCEzp6krj0LeHcOjj1IvL5UV/UkBxiVL5pfRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNWmiWH9irc2j4RkMBv/9Lr+OOEPhO8+7gllg5GMU2kYJ1sRCLUi+8aGhR/4jajS4
         sfmmPGG5XO0Za3VeCJGqrlIxPkpPdGsbyqbtIg0nAeTdMVtPLt5J2kkW0k+nzzxYkW
         uVlWAkWA5mRDJfTSJJwlV9G43kkWxaMNc/atMWGF6q4KgwKhrEoxGOt61gDKUYZdlu
         KirAn0GnsNghKIJZ8XhswExP3th0Nnv4Ypu8yHGno8XN8jlnMx/EnEf438Ac7xvMnd
         7I5rVxp5DiWpY2iVmzM21nOg2TXjJfrcBUIrK6oaZ+paeeyHN9xjX4N8cVuI7MqbYj
         eWsRKsECbVJIQ==
Date:   Thu, 29 Jun 2023 15:23:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: core: Always store of_node when getting DAI link
 component
Message-ID: <1d74d2ed-0c4d-4fce-849d-5f2288394569@sirena.org.uk>
References: <20230623-asoc-fix-meson-probe-v1-1-82b2c2ec5ca4@kernel.org>
 <87jzvrksi2.wl-kuninori.morimoto.gx@renesas.com>
 <9fbe4924-5c02-43f7-b47f-bc290fd07e67@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3xSwJ/njDdW/FTy"
Content-Disposition: inline
In-Reply-To: <9fbe4924-5c02-43f7-b47f-bc290fd07e67@sirena.org.uk>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p3xSwJ/njDdW/FTy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2023 at 12:49:16PM +0100, Mark Brown wrote:
> On Sun, Jun 25, 2023 at 11:54:29PM +0000, Kuninori Morimoto wrote:
>=20
> > > The generic snd_soc_dai_get_dlc() contains a default translation func=
tion
> > > for DAI names which has factored out common code in a number of card
> > > drivers, resolving the dai_name and of_node either using a driver pro=
vided
>=20
> > Yes, indeed.
> > But I think we want to set it under lock and if ret was no error case ?
>=20
> It doesn't really matter - there's only one possible result, and nothing
> should be looking at the dlc unless we return success, but yes that'd
> probably be a little cleaner providing we don't ever return early.

BTW that's not to say don't submit this as a patch, just that it doesn't
need to get applied as a fix.

--p3xSwJ/njDdW/FTy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdk84ACgkQJNaLcl1U
h9A7NQf8DiMYBVpbql+uhhR4/aQO3adkGIelIoUtUaDRAb9Qvsuliz0afLzBRmLY
iXJEQ02Hak6oJrt0OiPFct2vtsZ8E6LPJf3P/WirIlmiUpLIShr9/feri3Nt7gIo
WCja2NjjWjfmHj1fkZxjXnQ3CRB4+byV9cyeRjfSok65A6P/jLMif6GlnNp0ieFK
zwaEmmLGzayLL6UTekwL2gU/I8CI+yp4zVgAkIe6utxTSQJ06mz/HEBL1np/+qFs
hQf4zjGdVUGpDQ+O9yS2P7CpOQPQaay4bvM8LRGkIvFZWGsMSkS0VBbsK7FiLpI6
PXqIUOfTj4BmMRnqc5vmLVMPfKgKrg==
=W096
-----END PGP SIGNATURE-----

--p3xSwJ/njDdW/FTy--
