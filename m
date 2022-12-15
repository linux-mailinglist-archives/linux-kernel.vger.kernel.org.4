Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5977864DAD0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiLOMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLOMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:00:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A648E08A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:00:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0836461DAC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 12:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4CEC433D2;
        Thu, 15 Dec 2022 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671105650;
        bh=oPpUqYlxr77fNyRzxzW8QwAyxbVGbPr6qrLHJlP9Cs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM9kX1fCDfqx8+0VlEePZMWX+U72VRPacsWkztsWfeB7KsPEpPoX2+TCUrOP7nsMP
         28WvETvisFcPeGoZjHtmPw6CVgPu6n5HxGxV/fpM8hlda6gVtO/kTjIY5VYKLhP8Dm
         jcCfpKkrILJ/8UEXagGLYUcq6ON5Hjcws13AR5EkClCVRVWJNs+PK2kVagyaInqlNJ
         ZrXyWSY4VemIjWObq3KdxeAAeq13MZhhjeICiNiyeu6vEXSvKm/c8FM0mnCDQm0r3U
         d+3+FFZmZRNmXCp6nReN0ovWwErflvFvvwXloxrGtIA5DVbVXG6XlYJx89Cp3zZ1P1
         pIWRD2lZHAgtA==
Date:   Thu, 15 Dec 2022 12:00:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: max98088: fix initial dai mute state
Message-ID: <Y5sMbQZix760NH4T@sirena.org.uk>
References: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
 <20221213095328.122309-2-r.czerwinski@pengutronix.de>
 <Y5hpqWH2WuSIUHil@sirena.org.uk>
 <20221215091747.xn3f7ecrwoc7ssyo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0PHvdl9amdw8Qwv7"
Content-Disposition: inline
In-Reply-To: <20221215091747.xn3f7ecrwoc7ssyo@pengutronix.de>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0PHvdl9amdw8Qwv7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 10:17:47AM +0100, Marco Felsch wrote:
> On 22-12-13, Mark Brown wrote:

> > > +       snd_soc_component_update_bits(component, M98088_REG_2F_LVL_DAI1_PLAY,
> > > +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> > > +       snd_soc_component_update_bits(component, M98088_REG_31_LVL_DAI2_PLAY,
> > > +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> > > +

> > Won't this be broken again after suspend?  The device gets powered off
> > over suspend, then when it powers on again with the output unmuted
> > nothing will do another write since the register is already in the state
> > in the cache.

> I didn't found any suspend logic within the driver. Is this handled
> within the ASoC core?

Register save and restore for the device won't be.

--0PHvdl9amdw8Qwv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmObDGwACgkQJNaLcl1U
h9DKQQf/YCCGtpBvt7QeiGZoRVFHxvOPm7/7+AKqoB29uFoyBgi+BsaQPu2DWs7u
wthV/jYoKl5Dqc4aTVUPEaHd+LfHrI1Z5zNk8bnsW/KTh73AYfBFelcgn78w+23n
5uMwbHBQIESsiJTAELJOiHrfG/8M2WBrNO5gskq4NRbzclI5e0hZnI0lMFr7Uega
R0nMslzE5cNiRGlbn1k33a8Rpi08T2cH1zS1cfAru4OPy4VEpgT/gyFK7dtDmH8f
hPKSc0c1wBFlRz0a0cDMkf0HyoGeKrpMAGv+OPHjIvt9lzNjDMR9ekBConrqkrdg
UXKSodtBH6MXrmjcOX3JFJwsGhCRSw==
=W9y5
-----END PGP SIGNATURE-----

--0PHvdl9amdw8Qwv7--
