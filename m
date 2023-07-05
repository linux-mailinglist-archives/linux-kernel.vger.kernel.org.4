Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B44C748DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjGETYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjGETYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41FE198E;
        Wed,  5 Jul 2023 12:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 856DF616CC;
        Wed,  5 Jul 2023 19:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3334C433C7;
        Wed,  5 Jul 2023 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688584924;
        bh=mVNP1XHCm1ujuAN+24CqZIRE255cx//Gzw9yow8paAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxqQIxVxA794QTmGBDFpwJkxwwwan39x/70eMW1npZ0h2cisyfZ8X7Jz+DcHF9B2y
         U7V00JBcbqMfm4TrexatJAwQBDeWQJ2vOlaHMxoJbRSZX/OEKo2i0vl74xmTcrmt6n
         5eKx7otbFa3APKxzSsL1G8AGK2tHnTDR9NtYAGmQnE83gHSmFD1E/HqwbmH8ONPtdv
         yAr2ueE4uwlE5qbXPGvdy64KqkAYkCR2WWpw5sClwFmMwrqei4WHGoUGtmWs3BP2rY
         tOi5m4ej/tKDNT3VL9RnRQdpFJzRcQKLKCWmMA/IZY50orF/VPWtEEhjLQTvlRPJUE
         bi+B8oPuYi/zA==
Date:   Wed, 5 Jul 2023 20:21:58 +0100
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
Message-ID: <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yoex5Ky+2rrSrz/8"
Content-Disposition: inline
In-Reply-To: <20230705190324.355282-3-andreas@kemnade.info>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yoex5Ky+2rrSrz/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 09:03:23PM +0200, Andreas Kemnade wrote:

> +	/* probably no mclk if not master, so rely on bitclk */
> +	if (!aic3x->master)
> +		clk_id = 2;
> +

This is fairly clearly a massive hack, we're just silently ignoring the
clock we were asked to configure and choosing another one which is
likely at a different rate to that we were expecting and sadly the
driver didn't provide an automatic mode due to how old it is.  We also
appear to try to use the configured clock rate during PLL setup which
still happens in hw_params() even with this change which is a bit of a
concern here.  Are you sure hw_params ends up doing the right thing, and
that there are no other systems that get broken by this (perhaps ones
sending a lower BCLK for example)?

It would be nicer to set the clock via the DT bindings, ideally with the
clock bindings...

--yoex5Ky+2rrSrz/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSlwtUACgkQJNaLcl1U
h9Bt5ggAggsV+iF6iC39kukkwtxxKCtM675w6JEhW+9ET7xYGX4FrhRZTvq/mQ64
MhVd1VHY0bsPA/+vS7GtU470TRnBKYhORwVBIFFQHABfoM99rsT027jDG3gxH1gQ
Br26OAWMLgKALJ84g7HkXegZLmdtyPjcmceHoiVH8eJPuXkZJKvJ3aJIXoAtUVFF
Wfj8y/b2NoisYIRIkE8frezt4Rxtje7GJt0N2IwOcg0rcLZoNq3H7x8sgI6n+uL0
7v3ynYxxwPjFEuJ/n8w41GTidvaCZhurxk++g1DywgOcSiKcrr+ciKLYGDQfcZ/X
DMFBjIkkpCxggopwmDRMcpec92yj2g==
=sQ1/
-----END PGP SIGNATURE-----

--yoex5Ky+2rrSrz/8--
