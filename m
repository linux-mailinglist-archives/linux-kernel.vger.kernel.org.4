Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BE46E29A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDNRrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:47:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE58412A;
        Fri, 14 Apr 2023 10:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BA161551;
        Fri, 14 Apr 2023 17:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD3C433EF;
        Fri, 14 Apr 2023 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681494467;
        bh=H2tltmGDexc0tM0MnRw4xaZV6e/RVXjyojoxgxu9RBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rixmkwkcwZPphZbiVeWBBHCySWojOlFZDKQsmXMJyxcztUdYXMp6PyBJAZI5H5zut
         42/0Rm8Aja27F8wcDt4CKh7uO0mAdPfMqbq8fpYdADW1DMMs4HwkJRRhcxPAOHktvB
         t0ERdMOnhmFY3H2JbSbIeJWLSjk/M3pYPmMCOArKKXkDdyQHzhZ6zkRjWJVgV1K5fJ
         UaykqchjMXSR7I/qpCbz30RB3RKjJaYNF8DRhUyGXMaownpZZJtBDJ/mZrYqzdaxVh
         W7LlKbA+VRUV9Y+1CMzel8YvVjFdctAsiYrMJmzv63ceRHLA29FNgiAaRGwz7aRSOO
         wsri1kCQxJgmw==
Date:   Fri, 14 Apr 2023 18:47:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Anikiel <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com
Subject: Re: [PATCH 7/9] ASoC: ssm2602: Add mute gpio
Message-ID: <a1d81f71-e661-4deb-a20c-500eb114588e@sirena.org.uk>
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-8-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GnJcmBP2L1vfDhQF"
Content-Disposition: inline
In-Reply-To: <20230414140203.707729-8-pan@semihalf.com>
X-Cookie: One Bell System - it works.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GnJcmBP2L1vfDhQF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 14, 2023 at 04:02:01PM +0200, Pawe=C5=82 Anikiel wrote:

> @@ -352,6 +355,10 @@ static int ssm2602_mute(struct snd_soc_dai *dai, int=
 mute, int direction)
>  	else
>  		regmap_update_bits(ssm2602->regmap, SSM2602_APDIGI,
>  				    APDIGI_ENABLE_DAC_MUTE, 0);
> +
> +	if (ssm2602->mute_gpiod)
> +		gpiod_set_value_cansleep(ssm2602->mute_gpiod, mute);
> +

It seems pointless to control both the mute register and the GPIO mute
here, we gain nothing but overhead from having the GPIO.  What I would
suggest is that if the GPIO is present then that is used in _mute() and
we add a control allowing the user to mute and unmute via the register.

--GnJcmBP2L1vfDhQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ5kbwACgkQJNaLcl1U
h9BB2Qf/e9bVE1OecQ9c/4HvNMB9t3T0Dv3daa7u5NKNtro4noS50whQBwWcmW3D
NCt/vVNrLjGx2I+UYNrxE811ip8miMeyPmYAFOfq1/mTH2MCs5ch+7KfR3hma2qR
Rt+bbQFau5JfNdl3dDumT7F7iZSHXyIJyaDx/422OeUsBoSu2kNPxGsBJe/3767k
E/CwmpAdzhXtHwQjwlH29yJO1eqgXFJjjMv/95XkhhhW0SQouhGRxSuWxwDxXHAv
MaeNBF0/6mqMnwVrfBj+3YhtPdGklnGKsQXCLMKdag+VAguAkmzlz0nlUZc9glea
a1U1SCE9Y/OqEGNttsWm2dd7ADgxeg==
=LFjs
-----END PGP SIGNATURE-----

--GnJcmBP2L1vfDhQF--
