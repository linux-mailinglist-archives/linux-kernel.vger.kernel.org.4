Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100C16D9A32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjDFObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjDFOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:30:28 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84C88A7E;
        Thu,  6 Apr 2023 07:30:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id n21so1873071ejz.4;
        Thu, 06 Apr 2023 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680791425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQhUC48C6wHrpynrBLKu6E6JYZ/G69c0U7Fw89TbAAs=;
        b=kDOOqQM8r/fMLfoKQs/IN3KdhOeZVXq6IKjq+NmpuI3Nbp3GY5P4GDrn2CrByhvDeu
         EWAjDR4Z8ZleR3HKC1cmY2spstSNnB/Khvo1ymjzcvloNFHtxRAbIjnwJTVxZYQPGMN1
         OtcrQuOyXUeGpZ3VEGUOs4ttExdXTkEaMaQR6qgqa8eN3F10VX2if5cPh+2yU0EqQ4Af
         TVBJt0uMI5PD9lPxYuMVhgZMfKOqSSWtYiapQBtwL34qNXbBo8ks54SaYh2d7imYToF0
         Kn94WYCLs+fdzYrRLGmsM4Q7FT4WnOWjL6Vy/TG3IHNllqFW2+AruAztWe/W0j8qVKCn
         IEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQhUC48C6wHrpynrBLKu6E6JYZ/G69c0U7Fw89TbAAs=;
        b=231je9ypA2ku3FKPqkU0LdCoeYfEqJlGsy15NMi4adaBJVG7QmffpfAdPacTbKDtpd
         dh3BSUpJBUVJZLNwHOK6pxXKy+eTtdFrOZlV3BPWSsc6CBLr0rHJ0grrpGV8/RNTSQ/W
         PVeBesj08T1Dt3EvplOfiaY2vsW1JHBLIA2qmIMI+zZQsnzytg/nNJ9yVV2AzfObZc2S
         OZKdUU1gCsudVsrl8ghk8LHkrvzDxc1NPieYiydtN44GmQN3zeF8r5LFunbLzUJFRkds
         LeFKbrUPwSGHdDAiFnyyxDmgsM+66ZU5ZCOrjXXH1UbFATP1S6G0K3ylcAxiMpGA6V2d
         +c3A==
X-Gm-Message-State: AAQBX9e4yBgguBTYpcAMFXbeZHLUREQ7PeujpKLPqLoONjnGdAMtMSxB
        yLKKdTLRvG2U8/38tCBAiQc=
X-Google-Smtp-Source: AKy350aiBqXW2UWscI0vgWKtSbPJl7vSCZnaC+Q+fMor6zOBrfrqrLsRVMdvXTw3ToBjy+9r3IsNzg==
X-Received: by 2002:a17:906:6d6:b0:8f6:5a70:cccc with SMTP id v22-20020a17090606d600b008f65a70ccccmr6946401ejb.66.1680791425036;
        Thu, 06 Apr 2023 07:30:25 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dd20-20020a1709069b9400b009475bf82935sm884746ejc.31.2023.04.06.07.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:30:24 -0700 (PDT)
Date:   Thu, 6 Apr 2023 16:30:23 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lorenz Brun <lorenz@brun.one>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] pwm: mediatek: support inverted polarity
Message-ID: <ZC7Xf8Wy1x9gnaAY@orome>
References: <20230309010410.2106525-1-lorenz@brun.one>
 <ZC7LaC19YjNwTIi1@orome>
 <20230406135358.x3et6gvvxqsknfn6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vTrnEci5s8VqfSaD"
Content-Disposition: inline
In-Reply-To: <20230406135358.x3et6gvvxqsknfn6@pengutronix.de>
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


--vTrnEci5s8VqfSaD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 03:53:58PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Thu, Apr 06, 2023 at 03:38:48PM +0200, Thierry Reding wrote:
> > On Thu, Mar 09, 2023 at 02:04:10AM +0100, Lorenz Brun wrote:
> > > +	 * appear to have the capability to invert the output.
> > > +	 * This means that inverted mode can not be fully supported as the
> > > +	 * waveform will always start with the low period and end with the =
high
> > > +	 * period. Thus reject non-normal polarity if the shape of the wave=
form
> > > +	 * matters, i.e. usage_power is not set.
> > > +	 */
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL && !state->usage_power)
> > >  		return -EINVAL;
> > > =20
> > >  	if (!state->enabled) {
> > > @@ -213,7 +221,11 @@ static int pwm_mediatek_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > >  		return 0;
> > >  	}
> > > =20
> > > -	err =3D pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, stat=
e->period);
> > > +	duty_cycle =3D state->duty_cycle;
> > > +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> > > +		duty_cycle =3D state->period - state->duty_cycle;
> >=20
> > That's not really what state->usage_power was meant to address.
>=20
> I don't understand your concern here. I don't like .usage_power, but
> AFAICT this is a legitimite use. With .usage_power =3D true, the lowlevel
> driver is free to shift the phase_offset and even modify the period size
> and the goal is just that the average power-output matches.
>=20
> Lorenz's patch does exactly this: It even keeps the period and only
> shifts the phase (by period - duty_cycle). If you consider this not
> legitmate, I think we have to improve the docs about .usage_power.

I realize that I'm being nitpicky here. Setting usage_power =3D true and
duty =3D period - duty is a lazy way of achieving what you can easily do
by adjusting the input duty cycle.

If you all really want this, then it should go into the core, because
it's something that can be implemented on basically every single PWM
controller.

Thierry

--vTrnEci5s8VqfSaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQu134ACgkQ3SOs138+
s6HdEg//QB1RbC+b2D1fyJp2a/878DZw0Noui4uzQ9hqOvjkcUvly2m9Nt/YPMG3
LK8yJ8Zmxkytm6YqFHgYwaYZk7vnRL6Cvoo5gVdxlAvsgG+Go/UAEgvMpq5dgnP+
FO8mZa4P7LKgJe/5sGuZanDrwVt7Xh6Y12RsmiBYcaMkC4fkpyKutR0VRy31KIE4
qNJP0DozI7wHDyJcdV+AW+2saARDEt+5IRFn/fKjpxx5hp2pIg04OUcelAJEgF6E
pg16Vs9BAqUYfN+LnqdGqph3+tJR6pvcXLG+uU6o/FgQLTqf3ic1oQca7stRfAH9
BbqhkkoTzlpOiLvp0S4bzxqOiaFioRnROBppZvNIl85j3NIOSm7NTAzUE3rh/Z9I
qkn06FT3+Y1R3/NsOKZoQfH0ygm97RdjtQhwWscm0VHIneh165fW8e++dcrBLYCY
NyYA01We7VONe4m05ycsWzXq3xckZj7T4225MOK/NA2AK2KTNhMUhSqA3T41IEto
iWBzS9J8azku8jAYj0My5RO7obpymkVX0+ymixsmFVvBW4V7Hd7fPR43eI805Rg9
OMuh92K+e1XBvgq8nUUuA8pJxmBBkG+Qpz9t1zta55X1hu9LBtSdocZcJtaBr746
ELWDyZxNNGBTfbmchrp5SIP1zphRDVY3o3wzoKVY4XQewLaDL5g=
=rBYM
-----END PGP SIGNATURE-----

--vTrnEci5s8VqfSaD--
