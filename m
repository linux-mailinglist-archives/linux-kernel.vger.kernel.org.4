Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7306A60B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjB1Uuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjB1Uuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:50:50 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189705B9F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:50:49 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d7so12035746qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677617448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9V0E1rJTrvC5d+cKJrObAJitCaY9TIGIgqzXrqAQgnE=;
        b=ADDop40f3f2P+t2JdmV8VSwYnKONB/KR2gFYPXPVCIp1u+yUIgg/HoVlKadQrcrKFN
         lT9vBq+1iBO/LhKfUhNXi+UIzRphcKQVwj+bxdvo/BBAiNHlLL8Dpnn4iCz3UyTUXzK4
         BOUTEMNH28JsmSXIRicAFcAkJVMK5R62eZQoV8JoG9Zi89Q5BMOVvUWpmPKMUa633+R+
         Fh1PHh1udOznnKxlwFN7+rO3kFUUJ9iUyLlKsWrFaszt/drasVqM/2Dh6Bec7ukUAVY/
         sWsuMJRiEQTn+IwI0BnEwICbHkPEkWDRPZYcrMiXkV/B/QKw+PLDurNN3uLhNE+SO/05
         XguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677617448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V0E1rJTrvC5d+cKJrObAJitCaY9TIGIgqzXrqAQgnE=;
        b=S+PfhY8XHLc6DR/861Oy0xqvLKcpwObrkBH4SFASiBZsWWvTM2DDJkhUWkb+ifpzq8
         Gl4dS7E3AsLJLuUq+nkjUuFhZrFutwEoaT3yoast5I8lbXAIIKBb0FNNguZRt77P1+Jz
         KrnnHO5bZHqVbT4B47e3/Fo5CJEW+k6lzKRaC1M/7zBUG/5S82ofdNuwuYp7pXMIT8PP
         y4bqZxr0BBRkl1MphSedY2By51gfTnM3lDx5NiUN/00VVrnXBVVa7n0L38BYJogFWZQ1
         syu0VoomXZbBmFn4rRv6dbod6nqgC4sHYxf2FBGtd4BRMuNnjZd9Xok4r/qr3qveiMR+
         NtBQ==
X-Gm-Message-State: AO0yUKUaXlfQ4SJMMmwFcu3VMfK9m0JNvJkCJaDISWwxIbFEFiD1PUtD
        wOBsmBml5v+6Lsj+9Qv+FP24Cg==
X-Google-Smtp-Source: AK7set+GOU+U/LQWVOHF8IMoL9BLrOCNDHLn5apqJd0S9LVhnZZmMp5D/YOLRluf1Ghyk2KNBH2lfw==
X-Received: by 2002:a05:622a:50:b0:3bf:c6c9:2f29 with SMTP id y16-20020a05622a005000b003bfc6c92f29mr7906472qtw.27.1677617448146;
        Tue, 28 Feb 2023 12:50:48 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r23-20020ac85217000000b003b8238114d9sm7047639qtn.12.2023.02.28.12.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:50:47 -0800 (PST)
Date:   Mon, 27 Feb 2023 22:12:27 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        quarium@gmail.com, jhentges@accesio.com, jay.dolan@accesio.com
Subject: Re: [PATCH 2/3] gpio: gpio-regmap: Expose struct gpio_regmap in
 linux/gpio/regmap.h
Message-ID: <Y/1xG+K1yzcRZtZ4@fedora>
References: <cover.1677547393.git.william.gray@linaro.org>
 <5c0354c87d4d2a082cf0c331076d5aad18a93169.1677547393.git.william.gray@linaro.org>
 <0e0901de3668baec5ce7cd4836c045a5@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4P2X6kH733MEoG5H"
Content-Disposition: inline
In-Reply-To: <0e0901de3668baec5ce7cd4836c045a5@walle.cc>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4P2X6kH733MEoG5H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 09:44:02PM +0100, Michael Walle wrote:
> Hi,
>=20
> Am 2023-02-28 02:53, schrieb William Breathitt Gray:
> > A struct gpio_regmap is passed as a parameter for reg_mask_xlate(), but
> > for callbacks to access its members the declaration must be exposed.
>=20
> That parameter is only an opaque one to call any gpio_regmap_*().
>=20
> > Move the struct gpio_regmap declaration from drivers/gpio/gpio-regmap.c
> > to include/linux/gpio/regmap.h so callbacks can properly interact with
> > struct gpio_regmap members.
>=20
> That struct should be kept private. It seems you only need the
> regmap. Either introduce a gpio_regmap_get_regmap() or add the
> regmap to a private struct and use gpio_regmap_get_drvdata().
>=20
> -michael

Ah, I'll drop this patch then and use gpio_regmap_get_drvdata() in v2
instead to get access to the regmap.

William Breathitt Gray

--4P2X6kH733MEoG5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY/1xGwAKCRC1SFbKvhIj
K6wQAQDYbtyg6tuPPY4lER4AZoJHKCG9Dw5uTQjYToENfO9mhAEAyhvpWcsNNt50
RwPbG2WFbcZbFB7Ihb9hV9MEZyE9Kg4=
=JR+8
-----END PGP SIGNATURE-----

--4P2X6kH733MEoG5H--
