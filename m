Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1975C6D986E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbjDFNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjDFNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:38:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36359EC2;
        Thu,  6 Apr 2023 06:38:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 11so1477655ejw.0;
        Thu, 06 Apr 2023 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788330;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB2XWPbhfDFidinyV1LNhb8ctScJU+dAkHSX0qz7ET4=;
        b=DWFsNgwj/RZSXsLXnNUQoiR8umWiGJbUUiIYa58HYUntJINtF1X3sbUNK2SGmtQjur
         nf2zTDMyN8s4oHRR0TYqUkgjfIVkTLPs8CmJEMitOmxAZeERijaCX+6qOIZxycnmPgoR
         U9e6XbN9UEFMadS3q3VyQXrA/DT5Qq/i5hiY6cbb4evqd8uruoPSRNOH3i19c8Ye3Pfh
         zFkTgdxSfjPe42PgYkUWNAyotrDpkDFHp+KwaTjFl6b3ghsqOzXAhZeXx2VzEvzFwZZ3
         tp3DVny8GXxsRvaRknQVHwp+VB/LLgDBi4Jx60LtQrwg7MdoTkXd6w5QYympcGyh0otV
         dQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788330;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB2XWPbhfDFidinyV1LNhb8ctScJU+dAkHSX0qz7ET4=;
        b=NW8CzzzCr9yQsR9kqVRl/o5x8hvR9JbHJHX3YBc7L30C0Bip8fqjNL1xr5DPYEm28f
         GqUiyJytzhRZ8gfo+9jA1HU7UvViSzSZY3E5olWhHu2crr9SevvclLBpp97FSXOaIrE3
         Ob9QX66a7iAKaQQPSmMEtwI69ud25/+i9Doq3jbqeYHbLyayLR/3sbJ1X77QyLIUsmNH
         01qaAxHEOHOOhvqDoq8AEqzZE7ZQuX0a/1D3xrYtHfG3VQ09qEHJegXz6+wKnNNlAo0e
         H42dWB/FnIB4eYWUO+ECNivworxrO0A5hccJIcat4zROLrWf4bx7VDcg97dtUMMqj85g
         9+NQ==
X-Gm-Message-State: AAQBX9ccBiqKP8wdsan5OQRGyLBsAaoPZI7sCZarZf2LkhDMZlR5BM4p
        jvHVDIQkNLQm5h1fIiNrW+8=
X-Google-Smtp-Source: AKy350ZtRMRv7B/dzBQ47qJgU1XWDGBVEEwshFNdf9hH5SdFw8PysBgGRaYwtkrRRVPRdbePL9WAXw==
X-Received: by 2002:a17:907:2c4d:b0:92b:8fe7:344 with SMTP id hf13-20020a1709072c4d00b0092b8fe70344mr5959998ejc.16.1680788330175;
        Thu, 06 Apr 2023 06:38:50 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id mb14-20020a170906eb0e00b00947a749fc3esm835297ejb.33.2023.04.06.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:38:49 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:38:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenz Brun <lorenz@brun.one>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pwm: mediatek: support inverted polarity
Message-ID: <ZC7LaC19YjNwTIi1@orome>
References: <20230309010410.2106525-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B9cjqcWf+cUWsJxl"
Content-Disposition: inline
In-Reply-To: <20230309010410.2106525-1-lorenz@brun.one>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B9cjqcWf+cUWsJxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 02:04:10AM +0100, Lorenz Brun wrote:
> According to the MT7986 Reference Manual the Mediatek PWM controller
> doesn't appear to have support for inverted polarity.
>=20
> To still support inverted PWM for common use cases, this relaxes the
> check for inverted polarity within the driver to allow it to work in
> case usage_power is set to true, i.e. the exact waveform does not
> matter. If usage_power is true and the polarity is inverted the duty
> cycle is mathematically inverted before being applied to the hardware.
>=20
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
> V2: Only allow mathematically inverted PWM if usage_power is true
> ---
>  drivers/pwm/pwm-mediatek.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 5b5eeaff35da..18791304d1ca 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -202,8 +202,16 @@ static int pwm_mediatek_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  			      const struct pwm_state *state)
>  {
>  	int err;
> -
> -	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +	u64 duty_cycle;
> +
> +	/* According to the MT7986 Reference Manual the peripheral does not

Block comments should have no text on the first line:

	/*
	 * According
	 * ...
	 */

> +	 * appear to have the capability to invert the output.
> +	 * This means that inverted mode can not be fully supported as the
> +	 * waveform will always start with the low period and end with the high
> +	 * period. Thus reject non-normal polarity if the shape of the waveform
> +	 * matters, i.e. usage_power is not set.
> +	 */
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL && !state->usage_power)
>  		return -EINVAL;
> =20
>  	if (!state->enabled) {
> @@ -213,7 +221,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  		return 0;
>  	}
> =20
> -	err =3D pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->p=
eriod);
> +	duty_cycle =3D state->duty_cycle;
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		duty_cycle =3D state->period - state->duty_cycle;

That's not really what state->usage_power was meant to address. What's
wrong with just reversing the duty cycle in the pwm-fan? If you use DT
it's quite trivial to do that by just reversing the entries in your
cooling-levels property. Does that not work for you?

Thierry

--B9cjqcWf+cUWsJxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQuy2UACgkQ3SOs138+
s6EjfxAAoFem6yKro0FZC+kXhbzW9EpoGnhcTKrrD3iU//RmD1TMIk6xayb8XZIW
lAkXQtj+pB1Ck50VA26ygliJ2IFxbqJgwq3bBVUkhpkkoCMFI4KynDZgwnCu38cp
t8b3SjIEyi8Wernz9HlLWMJ5y/1uBRFnMYQoQnT2STh/nqmZx0lZ31xu9G4Bqt0f
cbT4IqQMXeosjng/vNcBkl7Svm/K+PxUK/mxnsqHLjjmYbtWahZDCpyqIVgU8D60
AWGRmkil2acw8ZLDMbnc59HhKAK6W55SxoGvvVtwagCRRbSrmVAvAg16Gi4NoSR8
mdabDVhVcTB50QNN5UWGn0H4ZzD22jWoAbc2iuK9p7p2OTgLI3LvxH4E5DVoIgxO
Yzc2fT9Y1o10A8hYLmSjEiHU0apY5PTjgF7T8deA0U/YH0xstxZIt+FV2mkySs7/
5iV8gqv4jCMTN2RFK6mwi7vQ+4ZA9qf1dW1H5GCd92kHYkuZ6EhUFHKc2gpQWNsF
/ENh1mJ3D6uFYD83oSiVG8WFJssCSBCIjUJsQuVDOBOZyKVrn2cd1usv8dh07fS6
MMmU39wD011XL5XjahcVZAV7Pe3xiK+CpMozlJVdG9L1SWwrh8q7f5Z+BIS1qXMN
vilxrUDLGLTvWUS4CnNWBNFE8n/udkkU8rFxPhY0R/rs8Ms6xSE=
=kG8p
-----END PGP SIGNATURE-----

--B9cjqcWf+cUWsJxl--
