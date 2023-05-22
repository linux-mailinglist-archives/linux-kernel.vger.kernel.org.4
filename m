Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D070C3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjEVQop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjEVQon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:44:43 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E73F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:44:36 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4572a528cefso1962011e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684773876; x=1687365876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qf40rv8DBLq+v06OlsPRtE2dsuAUv6hxQKxmbaIviKQ=;
        b=e7Lw+thSe5d1e6sITwdpnIdOdUGvIxVmEe0BxIhp63kB5BnA31eHqpKgglctBgKKVN
         7fvb2Zyxc/lxgxT2vG5V9rnnoCvNUPUuB2PRU2TQ5X68oY9HwLq6Vra6FqguuC14+kXn
         QNoD6rMywiw/EdacPC7yJeW+xXRwV5TjWocAOtbeCafNZpAvikJIok28T2aaqle0WWcV
         OLTftqPlJz/HtreogAAWIsoD+yI9ysS5WOHcMjuQURz59EQEFlZjz9nM26+BvMAqevDV
         t3o/tVYOE6Gk5h0GQBE5RBl9oj5Vh8T+iEbJbOB4GeuIZdVRbveX39aElDnNfM1OiSyQ
         Iy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773876; x=1687365876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qf40rv8DBLq+v06OlsPRtE2dsuAUv6hxQKxmbaIviKQ=;
        b=CwLP7+xChqpGHe7hqJqQUfjdIIAJZQfAM/ivUIgOJx9XHmmjq3p3+Lm4QOh5d+G2Se
         s/2l/remOFEG8DQ48wROZSKW/5LQeqClPLJ6sCZ5EnrbsfXGoBILiUxDPDS+9NUh4BIy
         mHJRU1SP/jay+3epg3d5DxqhBGLzjv0ClyOmBJlGN4ZAlkkeaA/RaysMtfzaXUoaRO7S
         i6B9xOMKoUH5koMzhuASXkK+XeXLekk2/abmesMo/KXWBnYX4j92lFgbhblorMTwwk8c
         5IwCzNHleTbqep1zXlWSR5YqkgDfyNeBmrFfRjpwzl5aGRMvVPm7FAppz+3fEB0U+5dM
         guIg==
X-Gm-Message-State: AC+VfDykAd0u0pMSgNADw+egPYKs0ZWIAf39XvAxwy0aERQvakvpoEN4
        726q6kxdHh3ePaJbDKSYSo92tQmpkZ0JqLaMOek=
X-Google-Smtp-Source: ACHHUZ6DYaJdwqgap33MUTKTqBjgi25tq8wBKTHfrsMuN4GY7bGQLQIEt24m6QyflO3bjIxsEJRf/w==
X-Received: by 2002:a1f:5c10:0:b0:44f:eae4:da84 with SMTP id q16-20020a1f5c10000000b0044feae4da84mr4325461vkb.5.1684773875933;
        Mon, 22 May 2023 09:44:35 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id 205-20020a1f14d6000000b0044ad1d3834bsm1143752vku.29.2023.05.22.09.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:44:35 -0700 (PDT)
Date:   Mon, 22 May 2023 12:44:32 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/3] gpio: 104-dio-48e: Add Counter/Timer support
Message-ID: <ZGub8Gyu773b+V92@fedora>
References: <cover.1681665189.git.william.gray@linaro.org>
 <dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org>
 <CACRpkdYdcU1JNmk7Jyyw+MA+GBKG950P1Nbn7QB4Nx7YJ1jwig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nY+9GuX2jNswXxCO"
Content-Disposition: inline
In-Reply-To: <CACRpkdYdcU1JNmk7Jyyw+MA+GBKG950P1Nbn7QB4Nx7YJ1jwig@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nY+9GuX2jNswXxCO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 20, 2023 at 09:28:15PM +0200, Linus Walleij wrote:
> On Sun, Apr 16, 2023 at 7:37=E2=80=AFPM William Breathitt Gray
> <william.gray@linaro.org> wrote:
>=20
> > The 104-DIO-48E features an 8254 Counter/Timer chip providing three
> > counter/timers which can be used for frequency measurement, frequency
> > output, pulse width modulation, pulse width measurement, event count,
> > etc. The counter/timers use the same addresses as PPI 0 (addresses 0x0
> > to 0x3), so a raw_spinlock_t is used to synchronize operations between
> > the two regmap mappings to prevent clobbering.
> >
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> Very interesting development here.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Yours,
> Linus Walleij

With this patch, we should now have complete support for every feature
available on this device. A nice milestone as well after first
introducing basic GPIO support for the ACCES 104-DIO-48E in 2016.

Given that there is also Intel 8255 support, it would be fun to route
back one of the device's GPIO outputs into the Intel 8254 timer gate and
hook up a simple speaker; we could get some nice beep generation going
and party like it's 1989! B-)

William Breathitt Gray

--nY+9GuX2jNswXxCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZGub8AAKCRC1SFbKvhIj
K2kGAQDQ4etWXlSzJn2uKfMuRCmiO+y67grNnTuy7sjzMZTZNwD/S8BOaRUrfrWL
iRvXchrNN0b5qCcKvm9eJHnirLZ9lwI=
=enuv
-----END PGP SIGNATURE-----

--nY+9GuX2jNswXxCO--
