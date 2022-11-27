Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16346639D73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 23:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiK0WAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 17:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiK0WAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 17:00:46 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB40DECC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 14:00:44 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id v81so9832630oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 14:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSqT2ziZe11V4stP6hX7PoNGl+KrR2XZl2qyRP90t9E=;
        b=mRH7eCr3oQl29U3axHsnZy9kt+hpnjU3+26wwZzQ62fzzwq5jahhc9zoYYtexhQLp4
         Zcab+JQ4eg4qnDt2gWPqVy+SagbQejlyH+Pk64fAoNjrxdbw9ol1VsanTAHv0NSuB7We
         QA6ZlzD7qE6cXyBTK23vdfWEAKpGzirCMGoIrQg/CSCGIUICaqjO52w5Qu+xR8bsWhuv
         r58TZdLCxYisjUSaYgvRlc3nO9TStlYVhvjifqEnEx7vRCR52Q4QedqEybYT5NGvODRQ
         Hf26M0aQxSCBj29Y2WAeIA4a2tKf7sS8/fKu4X3/i4updlPZJnpTxo+IirYeW4dIrOPK
         n+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSqT2ziZe11V4stP6hX7PoNGl+KrR2XZl2qyRP90t9E=;
        b=lrS8n7EwWqqWC7rCz/KfCH/T7D/a9cXDKF2QoMcaRVG5jI7eC6hKACv9QmXlYqbvhG
         Uy25ZV8MzAJETsmPYzpFZ4/mtrnQ2WvBT079FkTYo3T25Eppq193v8IejWnYbf91kLH1
         61Okvvpx8u/p39UlTnAUbO4/3yikTq5VaXJaEN8EeNsc0Z2tKh/51zBGIQd10ZzkmM58
         pkdQdwRLdm7bzG4o2cQF4tFmHYkCypyMy1Rt571uYGp6NBdctIQmXqQQLbMbNLKHmlKL
         jWLQ55lzrQq+p90qO1ffj2LTI1oB6bIHa7iAZvF0zCASd/gPcaNgG3b0gjWeyTbkUjBN
         wIyA==
X-Gm-Message-State: ANoB5pmofn1kSQ4Fn92EbyJI90z5we+3F8J+cMK3Jr6wCCtb1UhADVd9
        +4Wab0tEe/JAFHIbzNYuklqzu/RJ4aabcA==
X-Google-Smtp-Source: AA0mqf6s3X073r0zxMTMDTtn3gFD1xmlZXOeyLY+X0/5kFPk+W+zyAsfcYL1MU9sZdzi3GOK5GkFjQ==
X-Received: by 2002:a05:6808:655:b0:35a:2e4b:4c44 with SMTP id z21-20020a056808065500b0035a2e4b4c44mr15000804oih.263.1669586443496;
        Sun, 27 Nov 2022 14:00:43 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s6-20020a4ac806000000b004a05629149bsm677606ooq.17.2022.11.27.14.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 14:00:42 -0800 (PST)
Date:   Sun, 27 Nov 2022 17:00:40 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 3/9] gpio: 104-dio-48e: Migrate to the regmap-irq API
Message-ID: <Y4PeCBy/8slpMp2R@fedora>
References: <cover.1669100542.git.william.gray@linaro.org>
 <80fc819bcafe9697b6e02c0750d3cf0ea4ec9e1b.1669100542.git.william.gray@linaro.org>
 <Y3414YhVjqKakddV@smile.fi.intel.com>
 <Y3ykg1Vc96Px6ovg@fedora>
 <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s3ya4vK15ghsrGGf"
Content-Disposition: inline
In-Reply-To: <3a23df35a35cdba19eeb10c75b5bca97@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s3ya4vK15ghsrGGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 27, 2022 at 07:31:48PM +0100, Michael Walle wrote:
> Hi,
>=20
> [sorry this mail was just delivered now, although it seems
> to be sent last Tuesday.]

Actually I just sent it today, but you're right that it seems to have a
date of last Tuesday, so I must have configured something wrong on my
end before I sent it (sorry).

>=20
> Am 2022-11-22 11:29, schrieb William Breathitt Gray:
> > On Wed, Nov 23, 2022 at 05:01:53PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 22, 2022 at 02:11:00AM -0500, William Breathitt Gray
> > > wrote:
> > > > +	/* Initialize device interrupt state */
> > > > +	err =3D regmap_read(map, DIO48E_DISABLE_INTERRUPT, &val);
> > > > +	if (err)
> > > > +		return err;
> > >=20
> > > Use ->init_hw() callback for this.
> >=20
> > In a subsequent patch 7/9 we remove direct gpio_chip registration in
> > favor of the i8255 library registration via gpio_regmap. It doesn't look
> > like gpio_regmap_register() sets the init_hw() callback.
> >=20
> > Michael, do you see any issues if I introduce init_hw() to
> > gpio_regmap_config? Or do you think this IRQ initialization belongs
> > somewhere else?
>=20
> Something like the following?
>   gpiochip->init_hw =3D config.irq_init_hw;
>=20
> gpiochip doesn't seem to be the correct place, gpiochip_add_irqchip()
> is a noop for gpio-regmap, right? So using gpiochip_irqchip_init_hw()
> seems wrong.
>=20
> Maybe make gpio-regmap call it on its own? But really we just connect
> the regmap-irq to the gpiochip irqdomain.

I think you're right, it feels strange to handle IRQ initialization via
the GPIO framework. Maybe somewhere in regmap_irq might be more
appropriate?

> What is the purpose of the
> .init_hw callback? I've looked at other drivers which use regmap-irq
> and they all seem to just initialize the hardware in their _probe().
>=20
> -michael

I'm not opposed to initializing the hardware in _probe(), although I can
see merit in pushing that operation instead closer to the framework
where the initialization is actually relevant.

Andy, maybe you can shed some light about .init_hw; I think you
introduced it to gpiolib in commit 9411e3aaa6342.

William Breathitt Gray

--s3ya4vK15ghsrGGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY4PeCAAKCRC1SFbKvhIj
K73/AQD/c/ICZCQAd1nYvZNfmkfuslnbIWNQbkV2Pcv+42hzUQEAjZsetUe8+/Ox
38xhXR0oZQabGUoopQu3g0lelfpQqwg=
=vrdf
-----END PGP SIGNATURE-----

--s3ya4vK15ghsrGGf--
