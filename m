Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9E74DB31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGJQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGJQgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:36:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19A127;
        Mon, 10 Jul 2023 09:36:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E356110F;
        Mon, 10 Jul 2023 16:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D151C433C7;
        Mon, 10 Jul 2023 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689006993;
        bh=AD97xExNl4d84kadkKD325pdkAS93Gnf4sgXQoaxnZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmTrTk5j+Te/PpiLnGRf7RXv23Ll6SmZ3onfIrQDWSlcXzdLzeJiNp34vp0Lvzcx3
         1VeiAo0BBxDKz9aBiiMJbwiz/uENORqMQ0DGn1RtFQ7oy4sU06ere2B5gvFfyQ4T/K
         qRSScN9VA3Yfsq+GoD1/PHIxjXCPyS71pSAFmJcpTnIep9ZGLFVU2MRwv1C3uyDzzQ
         PNQjjtkCwxFUAwzYHyIdskA1P1KGDwYGRJUvAKpqcSBEGJEF2xpWwuPWvLsQsxxAWM
         GQ5K6DHT5Smi+Qfrzfn/nGxgQ8R/aDV6/zONQUtJCczf5/z4McP1y76BrNhxZ6JdmO
         100S1CgHQ9MaA==
Date:   Mon, 10 Jul 2023 17:36:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/3] ASoC: tlv320aic3x: use BCLK instead of MCLK if not
 in master mode
Message-ID: <6144f294-939b-4fb7-a4c1-ca5a6dabd86b@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-3-andreas@kemnade.info>
 <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
 <20230705215611.5f96584e@aktux>
 <eeba3297-acdb-45ca-a80d-40d8b3a90231@sirena.org.uk>
 <20230708150319.202789c1@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vHDl3oKRCXKY7VQ0"
Content-Disposition: inline
In-Reply-To: <20230708150319.202789c1@aktux>
X-Cookie: Do you have lysdexia?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vHDl3oKRCXKY7VQ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 08, 2023 at 03:03:19PM +0200, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Since we already have clock bindings we should use those to configure
> > the clocks, there's several drivers that have added this support already
> > - look for clock providers.

> ok, looking around:
> Just to make sure I am not running in a bad direction: Do you think
> tlv320aic32x4{,-clk}.c is a good example? It is ignoring clk_id.=20
> I was mentally bound to have to use clk_id there, so I did not found a go=
od
> solution.

Yes, that looks like a good example - the whole thing here is to move
away from using clk_id and to using the clock API to specify clocks.

> So I guess I have to configure the chip as a master and using mclk and co=
mpare
> register dumps with the state we have now and the state after the changes,
> additionally to check bclk functionality directly.

You can probably get away with less but it's goot to be thorough.

--vHDl3oKRCXKY7VQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsM4oACgkQJNaLcl1U
h9DKTQf+KSiGFfJgn0+yCS95t/1zJ49EUaL2ZJUBjVK2dx2CDyvCcTr2/gdfUkK2
klgsCubpCO1sj6X2Ogxw5b/el/L7wIIbWiR7pN/4GdCj3Dr6citfHmo4MPKlS0Z7
CfdIVt781Xt2SfMNTxOkb6bE8+i80trmm4UTux5+llCVCw5s4fHI6lMngoIHypvA
i5ngOyDYS0Op3tLf8/CEN+jYu7v1dltfwuEHfkghswSTT4OZF5Q3RfdVFrCBih7Z
G6diu0etMQqdgoPp1gHkzxiYUw7/WJoWcrFVg0fAVgvPztaXR5J8FYBTZsnZhOmN
V6V8i6RhYKQ/ESgvfjQUA8RojVXotA==
=IDaC
-----END PGP SIGNATURE-----

--vHDl3oKRCXKY7VQ0--
