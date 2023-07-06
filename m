Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802E4749B53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjGFMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjGFMCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:02:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEAA1732;
        Thu,  6 Jul 2023 05:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52466191C;
        Thu,  6 Jul 2023 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96F7C433C8;
        Thu,  6 Jul 2023 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688644963;
        bh=h9LrxEnYQVUI2MkYbCyF11apaeJLH2yAAAdmse5JAiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgNGcSYcVE3AYRdE7H5V5oVuZshVvy40hrtdXktEGVucVAOLL46WDITONePSeKoF+
         d6uL6r+0bGKEO3p8ByHwgUyqZla17pk98qO0LWHtPo+mwmcSWYi3Y+7Zq5z7+zXV2f
         0nj08ntYMRPHtY4ioUOYb+vl1I69A2+pQYOIwAG5WcGJGDFZw+pHtJJmVjLeNpFPr8
         Hf0p9hK6ShXKXDMVgJolstggzMi7wK/T23G2SERuqk8RcKIx+fCQq9bolIEQXuBcfY
         jYkDUCCWXCfIrne3ltvC3uBt6b105Q1Q0Og+odusezuXA1B3YzL1mrlSgrdlO2UTVk
         JU/e+u5jGTYOg==
Date:   Thu, 6 Jul 2023 13:02:36 +0100
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
Message-ID: <eeba3297-acdb-45ca-a80d-40d8b3a90231@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-3-andreas@kemnade.info>
 <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
 <20230705215611.5f96584e@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UomsMsmcZLuNBQaC"
Content-Disposition: inline
In-Reply-To: <20230705215611.5f96584e@aktux>
X-Cookie: Being ugly isn't illegal.  Yet.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UomsMsmcZLuNBQaC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 09:56:11PM +0200, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > It would be nicer to set the clock via the DT bindings, ideally with the
> > clock bindings...

> I found no path from these simple-audio-card things to provide a clk_id=
=20
> to set_dai_sysclk. I would of course prefer such a thing. Do I have overl=
ooked
> something?

Since we already have clock bindings we should use those to configure
the clocks, there's several drivers that have added this support already
- look for clock providers.

--UomsMsmcZLuNBQaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSmrVsACgkQJNaLcl1U
h9Aiigf+Ou9AA4di16Yf4y+H1mj8NnkVAid2OFXa6NQ0mptBZxo5im31eX6esarn
GnrzN6qYs06qcNO/mOZepRaEuSgIUZlWLqaMAdOawiCHVgSuqkYHGtpTbZnjxDOP
KSoqrumSBJOtyoKIh3ZT2YxrWcD193dkFDXILJB1jbpSQpMpe7D09Jgj1uCys0Xs
JO6U5l0/pc5gZSmPpQnKNk2kDA/Y5ec7C+TXdffpc9T98s9xFHBq2lkVAfz+1T96
ARQcsL9sa9rxo7L1opX98iqszsQ4roWK7WfdcGeUWt4tpF+6bLNuKc8jT8ZGPCmq
RYMPCFF4pCILcLF1sIjozgLtc3OiAA==
=RAi2
-----END PGP SIGNATURE-----

--UomsMsmcZLuNBQaC--
