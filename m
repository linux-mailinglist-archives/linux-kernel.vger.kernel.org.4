Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B68D6362E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbiKWPJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238540AbiKWPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:09:00 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B98697F0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:08:17 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s4so11374568qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+S7mFwOjPwIOTHt6SuUNUfln0CNGkBMEDjngY+UgUuw=;
        b=rzZ+y6MWMosxPSSLwzCaISThrED4G5+KW6v323GlLLMD+syvy4SFu0r6eNrMbH57sd
         uMZXQ1S2+vrMF8Wq25KawQXHdvH68RxHeGEk484kuMYOA+QApc5NgjNr/e6EWPs6nyDX
         kCengAM3vFGiyuzEP+bZWGM6bkmBOTL1D07J/t94+2HuS/Ic/dVLYnOyLsMp06vGPwc/
         VXk87fMZ9jDpHO3oDrGCPbIeetmZTquIiluoxMRHf+GKyz/nRElElgM7Z0rdir/tly0U
         kPv29RU8QOzUFa72Uxd3+3//mcjj2fG77rzINTQWO8nhD7vHUr4IOvppHgMLOdwsntSC
         HfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S7mFwOjPwIOTHt6SuUNUfln0CNGkBMEDjngY+UgUuw=;
        b=15VcD9M03NwUBy6fD1NaS5AGdCnu/4lApVbiyNrjARdqk45z8WEfNtlWkH/VBVDim+
         dW8H9HsXZYU/ePAPw80PmKBx9oSsPgrxxPYrKbuk9QSR2ojbmxTrdcF3eUmS8ZDMPMEu
         XI5y31hOVKS0qCatPTo7tOoOyZvOhyVD0jyNh91oE0osBgXmCeBC6Ea/VcV3j+YIeeNl
         hDyyRepPDIdSkkIgADnF0HnylmgXyNkaXXHf3hE8mBfMp/oZCifHr3e3MDYZXT0Zt8dL
         8Ls0SKi/H6YKeFSTr2lP5X0R20cqk5CRyDPTmHo+RVSCZqFlDuB60E8AbyXdvI5YhgbE
         jG0Q==
X-Gm-Message-State: ANoB5pmqNrF6XkJckDZDJvJRV9zxg/b3NldytNsRfvFcN7B7g8uAgFgR
        chlaTu+8lE9S7zpoABm3BjUo8w==
X-Google-Smtp-Source: AA0mqf6lbGcYJ1up0v8P7VKqnSrzjDshqpztg9z1N3SWYybjjY8vuJvLTB0jH62UATdfYKb42oe7/w==
X-Received: by 2002:a05:622a:4a11:b0:3a5:1cc6:ae12 with SMTP id fv17-20020a05622a4a1100b003a51cc6ae12mr26699265qtb.103.1669216096994;
        Wed, 23 Nov 2022 07:08:16 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a284900b006f9ddaaf01esm12455343qkp.102.2022.11.23.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:08:16 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:41:14 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, alexandre.torgue@foss.st.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix the check on arr and cmp
 registers update
Message-ID: <Y3x9GgxsdJM7NTjY@fedora>
References: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
 <Y3x59hNekCDuOFXT@fedora>
 <Y3x7YIBDT3xTeqtk@fedora>
 <c4792fd3-73e3-20ee-cd7a-a8d00eb877f9@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MBQTBXmEy5ZnhVes"
Content-Disposition: inline
In-Reply-To: <c4792fd3-73e3-20ee-cd7a-a8d00eb877f9@foss.st.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MBQTBXmEy5ZnhVes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 03:56:31PM +0100, Fabrice Gasnier wrote:
> On 11/22/22 08:33, William Breathitt Gray wrote:
> > On Tue, Nov 22, 2022 at 02:27:50AM -0500, William Breathitt Gray wrote:
> >> On Wed, Nov 23, 2022 at 02:36:09PM +0100, Fabrice Gasnier wrote:
> >>> The ARR (auto reload register) and CMP (compare) registers are
> >>> successively written. The status bits to check the update of these
> >>> registers are polled together with regmap_read_poll_timeout().
> >>> The condition to end the loop may become true, even if one of the reg=
ister
> >>> isn't correctly updated.
> >>> So ensure both status bits are set before clearing them.
> >>>
> >>> Fixes: d8958824cf07 ("iio: counter: Add support for STM32 LPTimer")
> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >>> ---
> >>>  drivers/counter/stm32-lptimer-cnt.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/st=
m32-lptimer-cnt.c
> >>> index d6b80b6dfc28..8439755559b2 100644
> >>> --- a/drivers/counter/stm32-lptimer-cnt.c
> >>> +++ b/drivers/counter/stm32-lptimer-cnt.c
> >>> @@ -69,7 +69,7 @@ static int stm32_lptim_set_enable_state(struct stm3=
2_lptim_cnt *priv,
> >>> =20
> >>>  	/* ensure CMP & ARR registers are properly written */
> >>>  	ret =3D regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
> >>> -				       (val & STM32_LPTIM_CMPOK_ARROK),
> >>> +				       (val & STM32_LPTIM_CMPOK_ARROK) =3D=3D STM32_LPTIM_CMPOK_=
ARROK,
> >>
> >> This is a reasonable fix, but I don't like seeing so much happening in
> >> an argument list -- it's easy to misunderstand what's going on which c=
an
> >> lead to further bugs the future. Pull out this condition to a dedicated
> >> bool variable with a comment explaining why we need the equivalence
> >> check (i.e. to ensure both status bits are set and not just one).
> >>
> >> William Breathitt Gray
> >=20
> > Alternatively, you could pull out just (val & STM32_LPTIM_CMPOK_ARROK)
> > to a separate variable and keep the equivalence condition inline if you
> > think it'll be clearer that way.
>=20
> Hi William,
>=20
> I'm not sure to fully understand your proposal here.
> Could you clarify ?
>=20
> regmap_read_poll_timeout() macro requires:
>=20
>  * @val: Unsigned integer variable to read the value into
>  * @cond: Break condition (usually involving @val)
>=20
> So do you wish I introduce a macro that abstracts the condition check ?
> (val & STM32_LPTIM_CMPOK_ARROK) =3D=3D STM32_LPTIM_CMPOK_ARROK
>=20
>=20
> Best regards,
> Fabrice

My apologies Fabrice, I realize now that regmap_read_poll_timeout() is a
macro. Abstracting out the conditional would probably be more confusing
than having it inline, so the way it is right now is probably fine after
all.

William Breathitt Gray

--MBQTBXmEy5ZnhVes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3x9GgAKCRC1SFbKvhIj
Kz+lAQDMbIxU7BPDmxYGeA4ARRXDfefK7ZVmk8dutqzuUI9PMwD8CRczxb5A9kTp
ZqBOIIef6M/iAzY6hZV01bnuvoOxhAo=
=Crky
-----END PGP SIGNATURE-----

--MBQTBXmEy5ZnhVes--
