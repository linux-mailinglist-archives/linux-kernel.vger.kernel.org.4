Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7FE6B2DCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCITeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCITeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:34:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45856DABA5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:33:27 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w23so3263036qtn.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678390403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQXs/idENx3qQbq6dtiVnbHhxQA0BF/uYGUOEUZAl98=;
        b=gVBEZw0VDUt77IcUdGYsdclvBJ7Tsv+GAfXBCkkcD9YweytbnLTIFr634g+gKtoICi
         W6lhKIGYJpsWte3bVMmfT9ByNLefYQKWVUDn2Q/hkdmkoSJ4gWiAx1Pc5CIOMvZvhI3m
         m38SYc2NQm3Cv1M9UIPt20MLpM3SpVIDRBlPHq1sufQbgs79dbhHccuppXaa13J+p/cd
         YE34GjdQFO88P6SvjB/VWpnweaXERaQnvaBmJncp0xHverI5RUIa30xLpeBtoo61jHvY
         E41E7csqVc4Sqi+CttjfiuBycEiWPXnmwCVwHjGbsVmBGpzgKLTjXzmplwcYxuKVaMDy
         W8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQXs/idENx3qQbq6dtiVnbHhxQA0BF/uYGUOEUZAl98=;
        b=h5D1FC0AHC6Zd28s/4W2RIJQYp2QbVCEuA4cwDnfGDEOdGVxWhViPO33Bq5fxBNodj
         4JesnhKbcKT2lFWqDMVc/ZR73XoZeyKfPhwUoViDkaW/GRGeR1je9+Udm2QpCYPv/UXR
         pDdTibwo739/eELZGF2XYD5nPqj9l+Ak+QuJWhCDPYGc6mZk5m1/mL3BL3auf4i4Bt/R
         ZQSEQn+lfD/4mVExv5Pn9/fvtvl3c5TscxkaRQYw1Q0gojCCasrOgQKlHchG+a+Njnnd
         WfjbXUNj4XbCm500RMCYmU8aiNMBOQQXx/euEVUBlS9qXePH7kL7C8OVmw2ZjFBUnt9z
         /tow==
X-Gm-Message-State: AO0yUKX5sy9bzPg57Hd2wz0u3RRFz3A0R1gKdlY79reVySa3ZWW+oF1Q
        b0HlsizX0QhrPoY0iPzZPMuMdA==
X-Google-Smtp-Source: AK7set9F+b44FJJ86PB8yQaXX4WkIky8I65o1fY/NEFRt2DJH5tadal7H+G/NW9ITUuo+MTstN9VrQ==
X-Received: by 2002:a05:622a:1b8a:b0:3bf:aa39:982b with SMTP id bp10-20020a05622a1b8a00b003bfaa39982bmr38862455qtb.32.1678390402153;
        Thu, 09 Mar 2023 11:33:22 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id l19-20020ac84593000000b003c03ae61af9sm5769003qtn.3.2023.03.09.11.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:33:21 -0800 (PST)
Date:   Thu, 9 Mar 2023 14:33:19 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, techsupport@winsystems.com,
        Paul Demetrotion <pdemetrotion@winsystems.com>
Subject: Re: [PATCH v4 3/3] gpio: ws16c48: Migrate to the regmap API
Message-ID: <ZAo0f0VG8eRrtMIH@fedora>
References: <cover.1678106722.git.william.gray@linaro.org>
 <4b6cd42426521808962d68a44952b95818fc5daf.1678106722.git.william.gray@linaro.org>
 <ZAX2k9gW1AA88T/P@smile.fi.intel.com>
 <ZAf4LudZkYLsWVWh@fedora>
 <ZAiISgAroSD3YOfk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gYdWBrdL+KqBcWeI"
Content-Disposition: inline
In-Reply-To: <ZAiISgAroSD3YOfk@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gYdWBrdL+KqBcWeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 08, 2023 at 03:06:18PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 07, 2023 at 09:51:26PM -0500, William Breathitt Gray wrote:
> > On Mon, Mar 06, 2023 at 04:20:03PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 06, 2023 at 07:59:53AM -0500, William Breathitt Gray wrot=
e:
>=20
> ...
>=20
> > > > -	raw_spinlock_t lock;
> > > > +	spinlock_t lock;
> > >=20
> > > This is a regression.
> > > That said, do we need a support of raw spin locks in the regmap IRQ?
> >=20
> > So this code has a similar need as the gpio-pcie-idio-24 patch: guard
> > registers between handle_mask_sync() and set_type_config(); however, now
> > we also need to protect registers in regmap_irq_thread(). We can't use a
> > mutex here because regmap_irq_thread() is executed in an interrupt
> > context so we cannot sleep.
> >=20
> > This might be a mistake in my understanding: I chose spinlock_t here
> > because I believed it to map out to a raw_spinlock_t anyway underneath,
> > whereas on RT kernels it would map out to whatever the equivalent is. I
> > suspect this is not actually the case. Would using raw_spinlock_t
> > explicitly be the correct way to go for this particular case?
>=20
> You may read the commit message of the 27d9098cff6e ("pinctrl: intel:
> Use raw_spinlock for locking"). TL;DR: this is only affects IRQ chips,
> so if your GPIO controller is _not_ an IRQ chip, you are fine.
>=20
> WRT the other driver, can_sleep may reduce scope of the use of GPIOs
> and even make a regression if any consumer don't want that behaviour
> and currently works.

Looking through kernel/irq/manage.c, I see the raw_spinlock desc->lock
is taken in __setup_irq() before potentially calling __irq_set_trigger()
which ultimate calls the chip->irq_set_type() callback. So it seems
unsafe to sleep within at least this callback which is utilized by both
drivers, so both gpio-pcie-idio-24 and gpio-ws16c48 will need the
raw_spinlock lock type afterall.

I'll make the necessary changes and release a v5 of this patchset.

As an aside, I wonder if locking is not needed if we only utilize the
set_type_config() callback, because the desc->lock taken by the irq
subsystem will be enough to guard between regmap_irq_set_type() and
regmap_irq_thread(). It's not valid for our particular case here because
we also utilize a handle_mask_sync() callback (chip_bus_lock() is not
protected by desc->chip) but it's something to think about.

William Breathitt Gray

--gYdWBrdL+KqBcWeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAo0fwAKCRC1SFbKvhIj
K0GCAPsH4oQt3CLZycxBwi4Kq5J9EIU2IK7jPmsloJkz5HKO3QEAzcBw1CEUwlq6
bpcLQ/rnxaWqs1u1vlASpoDW4U/9swQ=
=aBu6
-----END PGP SIGNATURE-----

--gYdWBrdL+KqBcWeI--
