Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43B6C4B49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCVNHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCVNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:07:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A961888
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAAFDB81CE6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C5CC433EF;
        Wed, 22 Mar 2023 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679490463;
        bh=2Y7bTCRnlSlrxK3L/xRJycRafvM776NSZ/Krg4zHKwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kiW+ueNetZbct+oeecx3pIRKgXYRoB0MujJ6y7p74Bnxfg4mHSKAflQFuIoL1OM0z
         YfwaJwepj/h1PqtqdJFEYLtJATdPJqrD3bi+niSbmb7ZnbNDBNCAmnsnUMWXgdr1kF
         ISflWttkCzGmRl5+rSnUcUeLch46tx3qik6Sy16V3nNQAOlGy2hlXST0JhSYFcjvIa
         rhVu0Ks/TaeYzsM8kSRLwL3xynQuTWta/div7YAC7uZBWDN1axi/bEHKdJHHPia6A8
         bHWjl6s22r0vCDQKSHO2Yc4ls1AF+jwBePPjmLDgRXflvplvklsKqjIGBQU1vbjR7C
         FtVQrwfCr+UUQ==
Date:   Wed, 22 Mar 2023 13:07:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 3/4] ASoC: amd: acp: Add machine driver that enables
 sound for systems with a ES8336 codec
Message-ID: <ZBr9rJn50ovG1w9W@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-4-posteuca@mutex.one>
 <141a3320-ff65-459f-9d00-c8bed691dcfc@sirena.org.uk>
 <87lejpwxzf.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ox7OggTfOqKWPV/Q"
Content-Disposition: inline
In-Reply-To: <87lejpwxzf.fsf@mutex.one>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ox7OggTfOqKWPV/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2023 at 12:17:24AM +0200, Marian Postevca wrote:
> Mark Brown <broonie@kernel.org> writes:

> >> +	if (SND_SOC_DAPM_EVENT_ON(event))
> >> +		acp3x_es83xx_set_gpios_values(priv, 1, 0);
> >> +	else
> >> +		acp3x_es83xx_set_gpios_values(priv, 0, 1);

> > Why are these two GPIOs tied together like this?

> These GPIOs represent the speaker and the headphone switches. When
> activating the speaker GPIO you have to deactivate the headphone GPIO
> and vice versa. The logic is taken from the discussion on the sofproject
> pull request:
> https://github.com/thesofproject/linux/pull/4112/commits/810d03e0aecdf0caf580a5179ee6873fb33485ab
> and
> https://github.com/thesofproject/linux/pull/4066

Sure, but that doesn't answer the question.  What is the reason
they're tied together - what if someone wants to play back from
both speaker and headphones simultaneously?

> >> +static int acp3x_es83xx_suspend_pre(struct snd_soc_card *card)
> >> +{
> >> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
> >> +
> >> +	dev_dbg(priv->codec_dev, "card suspend\n");
> >> +	snd_soc_component_set_jack(priv->codec, NULL, NULL);
> >> +	return 0;
> >> +}

> > That's weird, why do that?

> This is needed because if suspending the laptop with the headphones
> inserted, when resuming, the sound is not working anymore. Sound stops
> working on speakers and headphones. Reinsertion and removals of the
> headphone doesn't solve the problem.

> This seems to be caused by the fact
> that the GPIO IRQ stops working in es8316_irq() after resume.

That's a bug that should be fixed.

--Ox7OggTfOqKWPV/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQa/akACgkQJNaLcl1U
h9Ae4gf/e6/5uF/Cshw0/KAUpswFNPMtqowgQJKCeb1t0sE1bo9NguN2cK8tey2g
tycLYii10gLKkaZAHbwUntUmcTPMR/lpArrSRCfrycoJyqZ0XikSIeGloLdOlqAS
czi8c7f/CRq2XJP2YQQ7BY7/6z00KnP7+qXcKO9/Lk1DLd1ZorBC0WEuKPEX6+lz
0FygLY91cCbw1pWB6JiUbvEhgPUXKTKpIaM51W0UB5ShX9hSMiPb2XrWjlY5JOzo
8y3rIClYOMkrrpW855Ep8wZDsx3WbbwjqKvl9onarPQvINYHxA5waQUm3O6rOwwV
gI9AVmGankR8assP1w8NLp1ZcQBmwg==
=s0wu
-----END PGP SIGNATURE-----

--Ox7OggTfOqKWPV/Q--
