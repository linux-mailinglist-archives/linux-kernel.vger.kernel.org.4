Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44866C8FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCYSMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYSM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 14:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316B211C;
        Sat, 25 Mar 2023 11:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D02D60C88;
        Sat, 25 Mar 2023 18:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE99C433D2;
        Sat, 25 Mar 2023 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679767946;
        bh=CajaQHBsxDOFeWJ2Z4uhMq5fkuJ8Vq6DMecim34eK/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUCM6GRAikDeM9qfa7PiMJ/0Dw+GRabGMDc4q3NX0t/nsMJnQzpoROwQ0SkKcPyUq
         VR65LV/hVTQkSw+4J8V0XeKmu6ncB0RkxNW1oCexmX0XIoe7foBNVYvz/RrrQL3YUH
         CAhHltUbyW8gpA1WcvHnkmMuRKEfzS3FoUjftPyce/BEoRwmn9FUf6S/M5yvV6tpBu
         DZwww6l2sDKaS3QTi/VhYAv4LKMfgE54KL5TZA0G8zt4yRQ/Ys0fRT4aLuj8OM88ng
         IcI9mrgVU40MqYCT4JqVDRVbNchp98sZKx89mfJELQRBjNaE1tr9DjIRlTuFkW6y7g
         Ksp/Fwvdy5BqA==
Date:   Sat, 25 Mar 2023 18:12:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dylan Van Assche <me@dylanvanassche.be>
Cc:     Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v3 1/1] sound: soc: codecs: wcd-mbhc-v2: expose ALSA
 control for jack
Message-ID: <ZB85h55to1MsQnnh@sirena.org.uk>
References: <20230325142142.24337-1-me@dylanvanassche.be>
 <20230325142142.24337-2-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BY1KhK6s61gDAstw"
Content-Disposition: inline
In-Reply-To: <20230325142142.24337-2-me@dylanvanassche.be>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BY1KhK6s61gDAstw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 25, 2023 at 03:21:42PM +0100, Dylan Van Assche wrote:

> =20
>  	mutex_lock(&mbhc->lock);
> =20
> +	ret =3D snd_jack_add_new_kctl(mbhc->jack->jack, "Headset Jack", WCD_MBH=
C_JACK_MASK);
> +	if (ret)
> +		dev_warn(component->dev, "failed creating Headset Jack kctl with err: =
%d\n", ret);
> +

No, drivers should not be open coding userspace reporting - there
is no reason for this device to be special, or for this device to
duplicate what machine drivers and the core are doing.  Any
configuration should be done by the machine driver, the ASoC core
jack handling already creates userspace controls when asked.

--BY1KhK6s61gDAstw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQfOYYACgkQJNaLcl1U
h9D8yAf/fy9sMmjyaQSaCVRAtU6vPerFG2ZHD4sxzKPFhQb/dYDzG1AIAN+Dcp6p
TNKiM3DeqpzAV9GsThFTdllqXMAu79UOYhkPiPhjqUIH7gCli6TD0nhE7FerQWs0
MNYJFlZb9ZanjrSLm9QX0nraG9B/2mFgfK5ug7nH2WpNnuTm+5jwztOISRpAhOmm
/dWq7YTfT9CZdJkruUFsq0OgvDHnR294QQbzziUeRVX69msTC9h7BQVFk09Unvf7
wIP0p7qOLGuMjanJ/SyKU51V1Z078t7TrQhrPDzIW95oXgJeDAdmsqkeIfZDoAMm
mRLRKpwn0bVRbSCjisW24bgr/1tajQ==
=yrsm
-----END PGP SIGNATURE-----

--BY1KhK6s61gDAstw--
