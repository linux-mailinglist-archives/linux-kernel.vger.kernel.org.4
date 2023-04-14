Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF56E298B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjDNRfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F355AB;
        Fri, 14 Apr 2023 10:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C35F6497A;
        Fri, 14 Apr 2023 17:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD973C433EF;
        Fri, 14 Apr 2023 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681493724;
        bh=PdlPchlBqq3ipIe1/5avWeUUYeo8hYM1C6FOgpJVePE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHyrqHeYFDR408+DVbywqdFdI5GZKpRRQe+rslBVGoCMgTxqF+CAtyTC9jcAKomNz
         PfFasrHSeJp341AxUycZArVFXHXCW5TKn0Xb7ZilD+q0ehTk+irIq11PYbUZ9zGrLp
         6ThJGCgMv0RNeESv03yDmCQkKpWF5K+DteXEi1L5vP5NsKJD66qxtdJMwmyuIzqsPm
         QOlGK2hVNdQjwc0VTI3v9X5qNkB/wJe46FODMI+uKTk2DaWJWNqm7N7Ku5hkZzfgUm
         hHItTYOL1nkJ/zA7/RHzNc0O/EnkLC5HZIV0/fiT8fJce/ObiPD6Z1SxOrlqOjQIoa
         mQtJQBmKqECTg==
Date:   Fri, 14 Apr 2023 18:35:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 5/9] ASoC: ssm2602: Add workaround for playback with
 external MCLK
Message-ID: <cb35f3f2-4dc9-4d56-96bd-bcffb33b7aaf@sirena.org.uk>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-6-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EH6yRfJ9i6hhIpAh"
Content-Disposition: inline
In-Reply-To: <20230414140203.707729-6-pan@semihalf.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EH6yRfJ9i6hhIpAh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 04:01:59PM +0200, Pawe=C5=82 Anikiel wrote:

> Apply a workaround for what seems to be a hardware quirk: when using
> an external MCLK signal, powering on Output and DAC for the first time
> produces output distortions unless they're powered together with whole
> chip power.

This doesn't seem coherent, these are multiple register writes so
clearly can't be done at the same moment as initial power on.  Clearly
there's some other constraint here.

> The workaround powers them on in probe for the first time, as doing it
> later may be impossible (e.g. when starting playback while recording,
> whole chip power will already be on).

It doesn't do that, it powers them on at component probe.

> Here are some sequences run at the very start before a sw reset (and
> later using one of the NOT OK sequences from above):
>=20
>   ssmset 0x09 0x01 # core
>   ssmset 0x06 0x07 # chip, out, dac
>   OK

I can't tell what any of this is trying to say, especially given all the
magic numbers, and obviously no actual use of the driver should be
writing directly to the register map.

> +	/* Workaround for what seems to be a hardware quirk: when using an
> +	 * external MCLK signal, powering on Output and DAC for the first
> +	 * time produces output distortions unless they're powered together
> +	 * with whole chip power. We power them here for the first time,
> +	 * as doing it later may be impossible (e.g. when starting playback
> +	 * while recording, whole chip power will already be on)
> +	 */
> +	regmap_write(ssm2602->regmap, SSM2602_ACTIVE, 0x01);
> +	regmap_write(ssm2602->regmap, SSM2602_PWR,    0x07);
> +	regmap_write(ssm2602->regmap, SSM2602_RESET,  0x00);
> +

The rest of the driver uses symbolic names for register values, this
code should too. =20

This also seems buggy in that it writes non-default values to the
hardware then does a reset, meaning that the cache and hardware values
will be out of sync, and since it only happens on probe there will be an
issue after suspend if power is removed.  It looks like this would be
most comfortably implemented as a register patch applied as soon as the
regmap is instantiated.  See regmap_register_patch().

--EH6yRfJ9i6hhIpAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5jtUACgkQJNaLcl1U
h9Ajkwf+ODUCBkDtTHlEW7Kmhees6SWhoER3fk+u//I4yyeodw2AopWmhSQaUs0m
k5/cPXokWbQaCDic+hod7YejaAtDGHj3lDH9s4CAsE9SRtuYV1SCL8N94LN6ZETG
/3MlDr+ScZ+ga+8OsSQVvGMfYZlSuRlTiUJmocRWO5dJ/thyDzh/89QdgGfQt0eo
g6asIK+pLjG4N7Pl20E/bAG5sG1AHGkYiAxOLVD6vsXzcBZT+GoI5xYxD2rleRNi
cAN5Og3SghfLXhZNQeDBZ4/7mjCF/AwymoAsPuYwQRkWeWdZh29gOhPqSUD/Mzss
EtMguFBBN3y1NPRsMRBqzvmFV4TkcQ==
=zZC1
-----END PGP SIGNATURE-----

--EH6yRfJ9i6hhIpAh--
