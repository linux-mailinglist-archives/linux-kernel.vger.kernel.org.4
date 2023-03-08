Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4B6AFCF3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjCHCd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCHCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:33:23 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294024106
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:33:20 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id op8so10284654qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 18:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678242799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7d4avNQ4qTzn+SuqYWgHiW32J80h86PyMsPPQdN+eA=;
        b=o2Ttwa2SQB0HbezDy4bUDsIFHngLelMxlPtxY0hbYJxSQ00Fqnn6jHLq9SSnQaoNfg
         FaptAfJkhfmfmk7mrD7PrqA6iNABi3vpVfwdR4KB5YIglS/aL7f9XHCrUgtKC0Ma0E8P
         sk/jAZt7TQ8K64lGX8/gFgsh2F8Lm5GmwmfRQZ3nmu1YwBh9KqCwDNwpHItK8rQSzBfM
         uXLb8UwQNDJ7qU6QqeLenjB8S7nl9oaGQkp4WoJI/rurXRvv7t+/0pI2H/JzMSFDEi9l
         h7m0eEvWQlLmbKqnPFdq5cs9I3iXNhhH+Ve3ePyzJncZYAXqDG2X0tNS6+zVKKITywb3
         Hd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678242799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7d4avNQ4qTzn+SuqYWgHiW32J80h86PyMsPPQdN+eA=;
        b=vF/X2Uwr1XWGC+rcToyEP6imm5C40QURb+gGlM09/yX6cQiwW5CvprXzZ6R8/dUtKg
         Z6zodoSj16YIB37xdgvopJovIhtZQxpwsGKBSHd97SxoEk4MzsOl72xDKwYlE6tdWVRG
         evRFwbOCzMVXkH7/BuGzUnVcHvi+9/1C6+E8P4ZYQupy64s7U2OS5AIVTwqvlxIG0kPu
         p58RqNSVuHOZ3jFWd9uf4UVy7m0bY+bk6PA29IfuAWJnbrtl6KBSgVLdnDsHSWg8of1a
         n/wnpWT9aPlbsAEmzetv2eV22XN45H7knR1Hh5yUyyRu0i8rDP1ZNmuhdcjHqP81K0EC
         QEaQ==
X-Gm-Message-State: AO0yUKU0ved7Ql7YGsiMSutXj/STJsw1Qpr4IH66m7jNUetaSRbk61uo
        5cyQ3zq83Mg634YNFy713hxRyQ==
X-Google-Smtp-Source: AK7set+HTgcm7gFO+MYwMi2DWxf2VD4MLB/Hsx2K1yh+WaQ7Jadi/1bD6PFJZFDaMNxfBo+aTi0XZQ==
X-Received: by 2002:ad4:4eed:0:b0:56e:a7d1:4d65 with SMTP id dv13-20020ad44eed000000b0056ea7d14d65mr29986708qvb.52.1678242799311;
        Tue, 07 Mar 2023 18:33:19 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a0e9d00b0072396cb73cdsm10756583qkm.13.2023.03.07.18.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 18:33:18 -0800 (PST)
Date:   Tue, 7 Mar 2023 21:29:34 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, Arnaud de Turckheim <quarium@gmail.com>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: Re: [PATCH v4 2/3] gpio: pcie-idio-24: Migrate to the regmap API
Message-ID: <ZAfzDig+UzgH3QqO@fedora>
References: <cover.1678106722.git.william.gray@linaro.org>
 <b96429c66e7caca05d9fb93805e11650fdbad312.1678106722.git.william.gray@linaro.org>
 <ZAX3ntGgO4PjIkxx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="quWG8+aBeWgbNXre"
Content-Disposition: inline
In-Reply-To: <ZAX3ntGgO4PjIkxx@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--quWG8+aBeWgbNXre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 04:24:30PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 06, 2023 at 07:59:52AM -0500, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
> >=20
> > For the PCIe-IDIO-24 series of devices, the following BARs are
> > available:
> >=20
> >     BAR[0]: memory mapped PEX8311
> >     BAR[1]: I/O mapped PEX8311
> >     BAR[2]: I/O mapped card registers
> >=20
> > There are 24 FET Output lines, 24 Isolated Input lines, and 8 TTL/CMOS
> > lines (which may be configured for either output or input). The GPIO
> > lines are exposed by the following card registers:
> >=20
> >     Base +0x0-0x2 (Read/Write): FET Outputs
> >     Base +0xB (Read/Write): TTL/CMOS
> >     Base +0x4-0x6 (Read): Isolated Inputs
> >     Base +0x7 (Read): TTL/CMOS
> >=20
> > In order for the device to support interrupts, the PLX PEX8311 internal
> > PCI wire interrupt and local interrupt input must first be enabled.
> >=20
> > The following card registers for Change-Of-State may be used:
> >=20
> >     Base +0x8-0xA (Read): COS Status Inputs
> >     Base +0x8-0xA (Write): COS Clear Inputs
> >     Base +0xB (Read): COS Status TTL/CMOS
> >     Base +0xB (Write): COS Clear TTL/CMOS
> >     Base +0xE (Read/Write): COS Enable
> >=20
> > The COS Enable register is used to enable/disable interrupts and
> > configure the interrupt levels; each bit maps to a group of eight inputs
> > as described below:
> >=20
> >     Bit 0: IRQ EN Rising Edge IN0-7
> >     Bit 1: IRQ EN Rising Edge IN8-15
> >     Bit 2: IRQ EN Rising Edge IN16-23
> >     Bit 3: IRQ EN Rising Edge TTL0-7
> >     Bit 4: IRQ EN Falling Edge IN0-7
> >     Bit 5: IRQ EN Falling Edge IN8-15
> >     Bit 6: IRQ EN Falling Edge IN16-23
> >     Bit 7: IRQ EN Falling Edge TTL0-7
> >=20
> > An interrupt is asserted when a change-of-state matching the interrupt
> > level configuration respective for a particular group of eight inputs
> > with enabled COS is detected.
> >=20
> > The COS Status registers may be read to determine which inputs have
> > changed; if interrupts were enabled, an IRQ will be generated for the
> > set bits in these registers. Writing the value read from the COS Status
> > register back to the respective COS Clear register will clear just those
> > interrupts.
>=20
> ...
>=20
> >  - Add mutex to prevent clobbering the COS_ENABLE register when masking
> >    IRQ and setting their type configuration
>=20
> But this doesn't explain killing the raw spin lock.
>=20
> I don't understand how is it suppose to work then.
>=20
> What is this lock for and how IRQ related registers can be updated
> with RT type of kernel?
>=20
> If mutex is okay, doesn't mean we have to add 'can_sleep =3D true'?

I admit that RT locking is an area I often have trouble understanding,
so perhaps you can help me make sure whether this lock type change makes
sense here.

My reasoning for why we need a lock is that the COS Enable register is
modified in both the idio_24_set_type_config() function and the
idio_24_handle_mask_sync() function. These respectively are called by
regmap_irq_set_type() and regmap_irq_sync_unlock(), which are callbacks
for a struct irq_chip irq_set_type() and irq_bus_sync_unlock() members.

I think these callbacks could be executed in parrallel, but are allowed
to sleep, so that is why I selected mutex as the lock type here (I
probably do need to add 'can_sleep =3D true'). Is this reasoning correct,
or have I made a mistake here?

William Breathitt Gray

--quWG8+aBeWgbNXre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAfzDgAKCRC1SFbKvhIj
K6X6AQCb8V8G87zN4J8+wxzOx7owtXfV4gShJQXpdJzhhHNcNAD9ECtLyove5EKa
NApOWn2NjlkbJxgx/t7eGKvFk5ViEgo=
=vvBh
-----END PGP SIGNATURE-----

--quWG8+aBeWgbNXre--
