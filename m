Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86B636265
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237749AbiKWOwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiKWOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:52:07 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF16E571
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:52:04 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d7so12545529qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knbxmQVIOU2Pd66Dq2acA052ZEHkRF2txPVugpmQJls=;
        b=vgoCKFZRKLg5X6KRRSHGgXpYEh2IpY5j6Jj0EMht5qtQ5vVTuqIdbNTURoY0AF/5w3
         UG4cMxe7+vdo7xqYJkf0wioum7PckU4FwTl2NM4DiiKgXdx7FnMC4v9HUQFX5HhpeP4f
         ioRAEFIoHR95thd4TYiEIm3w41NCD3rn69jUjdDuL3QUc6WPJ+TMpVp1CfAHmLz6tkbw
         jTKsJ8BYK53PPoLsQEtvfiR6S+b4KvrxJufS3BUv8ynKpLJd/r197eXTqmcNp2mSHqLw
         8kZrNl4pn4Q96xALlgZmACcrrISzshdRfuyDoktiEl/wr6ZepBXVza/Dl0sywh0Ofvtx
         178A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knbxmQVIOU2Pd66Dq2acA052ZEHkRF2txPVugpmQJls=;
        b=XK6UZZhI8YjGWDMrf0UYvkxCeQKVMpAN4L+f+VnZy3PMyYBLu9+VJJe9KRO14lEell
         6PwA8OzHMSY2XgxQYWNbS5cL38Do+D03RpJ0cbwG4MloMPimfRaIpRqczNEJQKje4HrV
         I77SjpvG5ujVPI/AopcD3iVDVf1La59hF7dtWoiZrSE7sBxpJFBeaDCHCLvocoC3h+oE
         wqCZ973Oa+8ElpTTwm3zTim0ARH6bW+ha8YHetjBo2Do/1E4hQ3Kf7iehGVCIbCCWlUU
         8fpJkObzuuZAJ2zReC8KGA6RP9reen4dcQo/R6UqsijBrers4mF4TIH6shNm/XniRi2y
         JK4w==
X-Gm-Message-State: ANoB5pn6uChfSpliboD9Gdahi4BbArdpikdH2pJa7bLFjXrmBECVqR8O
        Gdj670I51YdkghaVlL7xEcdb7g==
X-Google-Smtp-Source: AA0mqf50nMaGK0F/5gySpgXWH3AhQK7OFs7Gu6ckRt9Fe7BUaW8hnqeaWOrFbDNOi68j5pTlArM48Q==
X-Received: by 2002:a37:2f44:0:b0:6fa:fc92:13fd with SMTP id v65-20020a372f44000000b006fafc9213fdmr25224598qkh.183.1669215123957;
        Wed, 23 Nov 2022 06:52:03 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b006fb3884e10bsm12520572qkn.24.2022.11.23.06.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:52:03 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:33:52 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, alexandre.torgue@foss.st.com,
        olivier.moysan@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: stm32-lptimer-cnt: fix the check on arr and cmp
 registers update
Message-ID: <Y3x7YIBDT3xTeqtk@fedora>
References: <20221123133609.465614-1-fabrice.gasnier@foss.st.com>
 <Y3x59hNekCDuOFXT@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzBUpj5aqWF9hSSN"
Content-Disposition: inline
In-Reply-To: <Y3x59hNekCDuOFXT@fedora>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pzBUpj5aqWF9hSSN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2022 at 02:27:50AM -0500, William Breathitt Gray wrote:
> On Wed, Nov 23, 2022 at 02:36:09PM +0100, Fabrice Gasnier wrote:
> > The ARR (auto reload register) and CMP (compare) registers are
> > successively written. The status bits to check the update of these
> > registers are polled together with regmap_read_poll_timeout().
> > The condition to end the loop may become true, even if one of the regis=
ter
> > isn't correctly updated.
> > So ensure both status bits are set before clearing them.
> >=20
> > Fixes: d8958824cf07 ("iio: counter: Add support for STM32 LPTimer")
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  drivers/counter/stm32-lptimer-cnt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm3=
2-lptimer-cnt.c
> > index d6b80b6dfc28..8439755559b2 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -69,7 +69,7 @@ static int stm32_lptim_set_enable_state(struct stm32_=
lptim_cnt *priv,
> > =20
> >  	/* ensure CMP & ARR registers are properly written */
> >  	ret =3D regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
> > -				       (val & STM32_LPTIM_CMPOK_ARROK),
> > +				       (val & STM32_LPTIM_CMPOK_ARROK) =3D=3D STM32_LPTIM_CMPOK_AR=
ROK,
>=20
> This is a reasonable fix, but I don't like seeing so much happening in
> an argument list -- it's easy to misunderstand what's going on which can
> lead to further bugs the future. Pull out this condition to a dedicated
> bool variable with a comment explaining why we need the equivalence
> check (i.e. to ensure both status bits are set and not just one).
>=20
> William Breathitt Gray

Alternatively, you could pull out just (val & STM32_LPTIM_CMPOK_ARROK)
to a separate variable and keep the equivalence condition inline if you
think it'll be clearer that way.

William Breathitt Gray

--pzBUpj5aqWF9hSSN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3x7YAAKCRC1SFbKvhIj
K9w1AP98ZG3DrAmGPMHuLe6esFEn0tC6ND7mWOexsyUahUYdawD/R2NVJxw+1mLI
RQk8aAe4SpweKg5EY0hASmH+yqpo4A0=
=2pWS
-----END PGP SIGNATURE-----

--pzBUpj5aqWF9hSSN--
