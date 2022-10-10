Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF55F9D74
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiJJLTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJJLTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:19:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816E5C961;
        Mon, 10 Oct 2022 04:19:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5655BB80E10;
        Mon, 10 Oct 2022 11:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4F9C433D6;
        Mon, 10 Oct 2022 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665400769;
        bh=Kovg57r5VykKe/+/1vpAjKiI6SWlnob5ulkWDfEuaLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=do+O8KByAmhICHFjP9zRlZ3lgv8xdB45e+5xsEuNV1c5ydSPdFLpB4zQIuEQt732c
         ucggdO8j6Tax6bkHjxV3anSm6gXuYMUmyk/QhEWaJ6BP0B0yucEaVhha2S4YqafnN5
         oHcbGzO2dMChPTuZPmTDMpJz3IT+4tYu0tMYlQ8900rPUrAvsBqN3BBQjKRg0wkVzv
         TyUZSnPEqFMev20RNn2a16RkyhCU5HCnz36qK8o1q6HzfDvSfN1kzjqUGyoJkJyJrl
         WRN/JXTueIa9xp+uY3d0/GiXdGwQvZ3dIPzm4KPmlOH39DMEjbiRKqfi/kJSdMXllQ
         pBx2BeAFzVsww==
Date:   Mon, 10 Oct 2022 12:19:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Various improvements and fixes
Message-ID: <Y0P/u4pJT8rup8Za@sirena.org.uk>
References: <20221008181655.2747857-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op3ThFipb3tyblPC"
Content-Disposition: inline
In-Reply-To: <20221008181655.2747857-1-lis8215@gmail.com>
X-Cookie: This sentence no verb.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Op3ThFipb3tyblPC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2022 at 09:16:55PM +0300, Siarhei Volkau wrote:
> The patch fixes:
> - incorrectly represented dB values in alsamixer, et al.
> - Line In path stays powered off during capturing or
>   bypass to mixer.
>=20
> The patch improves:
> - Exposes all mixer inputs (both Mics, LineIn and DAC) with their
>   gain controls.
> - Exposes output stage (post mixer) gain control and makes it new
>   Master playback gain, DAC gain was the previous master.
>   However, no Master mute now.
>=20
> Known issues:
> - Bypass path enablement isn't applied immediately, for make
>   things going bit clock needs to be triggered for a bit,
>   e.g. by aplay dummy.wav
>   It might be a hardware bug, since the bit clock isn't
>   declared as required for codec operation.

As covered in submitting-patches.rst this should really be split up into
multiple patches, with one change per patch.  This is especially the
case here since you have a mix of fixes and new features which should be
applied differently.

> -	SOC_DOUBLE_R_TLV("Master Capture Volume",
> +	SOC_DOUBLE_TLV("Master Capture Volume",
> +		       JZ4725B_CODEC_REG_CGR10,
> +		       REG_CGR10_GIL_OFFSET,
> +		       REG_CGR10_GIR_OFFSET,
> +		       0xf, 0, jz4725b_adc_tlv),
> +	SOC_DOUBLE_R_TLV("Mixer Line In Bypass Playback Volume",
>  			 JZ4725B_CODEC_REG_CGR3,

This doesn't appear to correspond to what your patch description said
and will presumably cause problems for any existing configurations...

--Op3ThFipb3tyblPC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmND/7oACgkQJNaLcl1U
h9Ck3gf+MN3H2Q8YLJKMm3xOdxFyrrH0ZsGoIK4lRoS2exdLznRoBee133qnowPW
g+3+Oe3kzCX/Pd+uHl3u6Xsj63GkKUM7UewBPSqlxa0ErTBKPO7GSOaWKQanpyah
oPvhJ4CXee0Ul6nS3STH8SKZ8v57Xca64GFHn7yQ+8mFvob6PspUsYhpk7098Obj
nOMlKo1E1UCjZTJ6lmaPc5uSyBGb400n+t0jq1YYZEcWiRiCtqGITwctzplf3Cjo
6gW0O9R8goqDdIZE/rFCoDu8PfEc69ulzSw4LaKPQJKHSXdFlY/Vrzz5w5NQJgM9
R7ziLxg/PCEgA6SOQTt4KABRUxuGzw==
=jUV/
-----END PGP SIGNATURE-----

--Op3ThFipb3tyblPC--
