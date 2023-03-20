Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F56C2352
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCTVBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCTVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:01:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824CDDBE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30F14B810E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842A5C433EF;
        Mon, 20 Mar 2023 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679346076;
        bh=u3MqWhlNO9Ez1oFr9MAB0V4YaP3aY5B7Rle7IvtQ/h0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL6OBdByFzSN/Jbjx0IDvRNV1JHope619zvo7lq6xNy4Sq6SZtNZwvsy5YFG+dWxY
         WXEY8wdUWnv1wKXDHA0efPGenPHaSgnim9X8Uy0mx21Zalaaq8Oqy696EXPl9Vn3HH
         /WmEmvvAjBv/9Ygg+CnDqX+f9mdPEKEvS8w3zeXsCJgl/3LouKTHB5TD37tztkCqsq
         H7YvJVDxoulwcpB8Gcdkib+WaR/lLr942LHugV8ZEmmyE1LafhTvmdf0PEAQ/0/fyd
         IISmlWmPtCEjuYceZ5Nj1bQMluPWa+jpirAT9QLKT4GPfTaR35B0CGvuAa8WNJ2SLj
         JQG3Z1Gk1vEhg==
Date:   Mon, 20 Mar 2023 21:01:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marian Postevca <posteuca@mutex.one>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 4/4] ASoC: amd: acp: Improve support for speaker power
 events
Message-ID: <0989fc51-fee7-4558-ba2c-084cc4fb6833@sirena.org.uk>
References: <20230320203519.20137-1-posteuca@mutex.one>
 <20230320203519.20137-5-posteuca@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gK7rshqe2sdB/wQi"
Content-Disposition: inline
In-Reply-To: <20230320203519.20137-5-posteuca@mutex.one>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gK7rshqe2sdB/wQi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 10:35:19PM +0200, Marian Postevca wrote:
> In order to reduce the audible pops when speaker or headphones
> are activated or disabled we need to delay the switching of the
> GPIOs.

The usual mechanism for doing this is with the standard kernel delay
functions.  Why not use them in the DAPM event?

> We need to also disable/enable the speaker/headphones GPIOs when
> the audio stream is stopped/started. To avoid race conditions
> between the speaker power event callback and the trigger callback
> we use a ring buffer to save the events that we need to process
> in the delayed work callback.

Why is this required?  DAPM is integrated with stream start and stop,
and there's a mute callback to mask any noise played back from the SoC
while it stops and starts without requiring all this complexity.  If
there is any audible noise then why would it only affect the speaker?

> +static int acp3x_es83xx_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_card *card = rtd->card;
> +	struct acp3x_es83xx_private *priv = get_mach_priv(card);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		if (substream->stream == 0) {
> +			dev_dbg(priv->codec_dev, "trigger start/release/resume, activating GPIOs\n");
> +			mutex_lock(&priv->rb_lock);

Triggers run in atomic context, you can't use mutexes in atomic context.
lockdep should tell you this.

--gK7rshqe2sdB/wQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYyZcACgkQJNaLcl1U
h9DkaQf+OTpwoJCS9rupSqOFbQKX/TWXlrvy/kIF0A80++s1yYuhU/1GjGj8oGE/
nqWgL6q2s0QHMENex4/EzSEL+OfQ++ibKPDOnILjgoNBmUP16Vmwz+bv2H/2Sruk
L0CmSPokXA7y31gZ6TgD3bW+ixPIE5NEE5YxsQ+Dm1pGj5xhXHyKvm9O9AjqzSPk
ltInh6wqRtlMTNOnGxNKpYGjLX20wKE5qZu1Kgih47iRUrvRqAozfusMd+cqBdo9
+ss1lnJyU9SQcq4PdD1YLZACjIaWnLotAPOjerFsjzEJvHTvtdxHGO2z+RdZfXz/
Snlzbh9qHUrhFJxJLbgFlyXkV4gIHw==
=lTjH
-----END PGP SIGNATURE-----

--gK7rshqe2sdB/wQi--
