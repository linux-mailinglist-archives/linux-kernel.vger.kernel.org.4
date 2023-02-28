Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9F6A5FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjB1TnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjB1TnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:43:00 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1C45BAE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:57 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c3so7591813qtc.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677613376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOLmVC7ejN2NslNDrJPSovA+e0oAlLmLUDFX6bU2iDE=;
        b=UOmMXfoWjXX3L7h271Pz1av820iIZFA6qfstUFcokEpR9qGkZdJUsPgoqaNNNee2XO
         +E/CShNg0tEKk1ccgiw20tlWXgouSakcR/Yz7Higekzc8eVeMd9e7ejuL2xg1mZj5ooc
         w8gl+kFZD0ho4yeqrVBup5kRcCCpQzRNDwACI7PZ0i77aS9RkljAWp5jVAj3lX22oaaU
         EA9wo2UkVIR2OCAR/XYxyo8SHC9zPHzGEKMJWtaxmV0upOIAip9G2fvIufJqHOCcBMHt
         R3w4Ud5b4t8JbXK/JdBtjCgrSKhZiF3/6o1Lk0ORnMMYQxZJBvwvo13vsqcre+Tjuwj9
         pxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOLmVC7ejN2NslNDrJPSovA+e0oAlLmLUDFX6bU2iDE=;
        b=352T+64b5TKf8ZFdQ7ICmrGPvmHVA1cuU3Fsds+ShmS876APu8NQrhB+KjFCF3rYKq
         nHvr6isDF2QYpDz18M1SEN6PdrDnwB5Vzlz39rUuctJ56XdFujqWnU+6VQMOl4EUvc5T
         OsS409qacOI50EwV2oJK+sUuzdrtk5g92Uldq9+91PgJDJtmc/qvnqM0QjF/yL7ZGClp
         k0l/NKE5MfrKJzvbQUYgUxANDrzEMlpFrFwGSj+t02No6wGngZMCJg/9euj/Hy/kCjQW
         /8y7vWXA8R+tadkEGfPAJXGkE6yblOvZXbIO67kodLytK9VOiRG+8v0G14WiKjPQjJBB
         j9/g==
X-Gm-Message-State: AO0yUKUcbtdbX8cO6L4sJXK3h0MnykNtPQoDR1qyiZfUTfZM0HSsrhXT
        JZM/4PkHobrGWJ4MuXLp4QGp/Q==
X-Google-Smtp-Source: AK7set+ttYqmHcaA29zqYdFS6PsD1sZyWny+1cUSaxr3LNkFIkzE2W7iOASVWMBd8RCUp7xYc+8/lQ==
X-Received: by 2002:a05:622a:1ba4:b0:3bc:dd21:4a0 with SMTP id bp36-20020a05622a1ba400b003bcdd2104a0mr7411969qtb.30.1677613376600;
        Tue, 28 Feb 2023 11:42:56 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id g3-20020ac84803000000b003be56bdd3b1sm6857999qtq.92.2023.02.28.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:42:56 -0800 (PST)
Date:   Mon, 27 Feb 2023 21:40:47 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, quarium@gmail.com, jhentges@accesio.com,
        jay.dolan@accesio.com
Subject: Re: [PATCH 0/3] Migrate PCIe-IDIO-24 GPIO driver to the regmap API
Message-ID: <Y/1pr33s5IAE4QJS@fedora>
References: <cover.1677547393.git.william.gray@linaro.org>
 <Y/5RfjJCDdrZbHgJ@sirena.org.uk>
 <Y/1ksJHUENCwg/jy@fedora>
 <Y/5V7a4M+LhZQhsM@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ZpSqVT8lVV/SEQV"
Content-Disposition: inline
In-Reply-To: <Y/5V7a4M+LhZQhsM@sirena.org.uk>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ZpSqVT8lVV/SEQV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 07:28:45PM +0000, Mark Brown wrote:
> On Mon, Feb 27, 2023 at 09:19:28PM -0500, William Breathitt Gray wrote:
> > On Tue, Feb 28, 2023 at 07:09:50PM +0000, Mark Brown wrote:
>=20
> > > The values from the config buffer are supposed to be written out in
> > > regmap_irq_sync_unlock() - why is something custom needed here?
>=20
> > The PCIe-IDIO-24 "COS Enable" serves a dual purpose of interrupt
> > enabling/disabling as well as configuring the interrupt types. Since
> > this register is used for masking, config buffer would clobber the
> > register if we use it in this particular case. Instead, we ignore the
> > config buffer and configure the type directly for the device (handling
> > the case where interrupts are masked and shouldn't be enabled).
>=20
> Could you be more concrete about what's going on here please?  In what
> way does this "COS Enable" serve these dual functions and why do they
> clobber each other?

An explanation of the device registers is provided in [PATCH 3/3];
here's the relevant portion:

The COS Enable register is used to enable/disable interrupts and
configure the interrupt levels; each bit maps to a group of eight inputs
as described below:

    Bit 0: IRQ EN Rising Edge IN0-7
    Bit 1: IRQ EN Rising Edge IN8-15
    Bit 2: IRQ EN Rising Edge IN16-23
    Bit 3: IRQ EN Rising Edge TTL0-7
    Bit 4: IRQ EN Falling Edge IN0-7
    Bit 5: IRQ EN Falling Edge IN8-15
    Bit 6: IRQ EN Falling Edge IN16-23
    Bit 7: IRQ EN Falling Edge TTL0-7

An interrupt is asserted when a change-of-state matching the interrupt
level configuration respective for a particular group of eight inputs
with enabled COS is detected.

So in order to mask lines, the respective bits need to be set to 0.
However, if we use the regmap-irq config buffer to set the type, this
mask will be cloberred and the disabled lines become enabled. To prevent
the clobber, we can save the type configuration to irq_drv_data for use
later in handle_mask_sync() and then update the type in this COS Enable
register only when the lines are unmasked.

William Breathitt Gray

--1ZpSqVT8lVV/SEQV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/1prwAKCRC1SFbKvhIj
K9s+AQCtKcJaTgx6IbX3HD2eUty2muCO/guMz/Cm1PjLitiLuQEAlSup7rwoNaBJ
Pa3mDIMAMQpO0Kugdp57+rXzMlVsvgU=
=nE8M
-----END PGP SIGNATURE-----

--1ZpSqVT8lVV/SEQV--
