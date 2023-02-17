Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CDC69B463
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBQVJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBQVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:09:03 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3705EC95
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:08:54 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d10so2072560qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7kMhaMk0ra1bxEhmhUd3nL+weLy5X860ySTDmIfCoc=;
        b=l2CFdhXj76hZTmNNKWKbGh/kbsp3vniCAulyPNGgLKp8K1cfTwj2DOhlqKb39UgD9L
         1q/7m/dTIRyz6gYeYstVqeY7Ac0tIGMvj8Gw9cH4fn7ZiypA7GaGoj18Re2RHmBwsI2n
         7992NgFDwlKbzudgcuf8iEKz/Xi51dccLVW6nvmobi1vOIFGBBTVWzY4nfYrBgD8fSaj
         xizYOcTrrUpLrqGqFF3ooPbHfAKANmA1tUzsuV5uKjVJ5aNhx6evs1CCkcNST1kw3tD5
         2pC1TouUV7qdYQ1YdRmiHNAqAAWFN3VPnpGDxIcbrr/s5SrC/PgK/LkumcExyqPpl5gD
         QOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7kMhaMk0ra1bxEhmhUd3nL+weLy5X860ySTDmIfCoc=;
        b=SoR9i0XdJlIGdx942gSiOJQrp3ISgKyAmeBlrDN/X07ouc7G8ajKlstJJFtYPg8ztD
         rk9/us3iQutqQ+thxmDx409dMuXJFiPWmT3uFCwjoOdJO9v9EQTQ3K7ODaaCLPH0nLJz
         DLEIfaziq3QVevRcl6Fdgw63RUY5kwakKETw2Y/NwdajnDYqDh7VEUYN45URExn/lIgh
         /u3JyyhICq4Uf3Kbkb8Ynyezxm7WkH6TTW9nfCzDVgiv169g5v2LiM4KVsWv/tbcNUyS
         vOUL7Do1wYW4v31ySmFMqEusa5HtuE8bBE34YCsT7Fwgk+UXe9aTGDNPiii4lKZAHrAy
         iYoA==
X-Gm-Message-State: AO0yUKVT6OjTH5XKBnAW8HcQyVp2Ed0qMy8aRnxbW4UCMFa6U7cFQulN
        ofUq0tz55oav/94kHyCiZRHEI5hYckizsWm6
X-Google-Smtp-Source: AK7set9EI1kBLnJWEubBwMVczc1uvj6w0FTxENlGxAlCNpRheGHxEPXpefb1HDmKjoGmgSLwA44Klw==
X-Received: by 2002:a05:622a:1883:b0:3b8:6d92:bf62 with SMTP id v3-20020a05622a188300b003b86d92bf62mr3315105qtc.46.1676668133269;
        Fri, 17 Feb 2023 13:08:53 -0800 (PST)
Received: from fedora ([185.203.218.250])
        by smtp.gmail.com with ESMTPSA id r207-20020a3744d8000000b00706bc44fda8sm3942740qka.79.2023.02.17.13.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 13:08:52 -0800 (PST)
Date:   Fri, 17 Feb 2023 16:08:50 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] gpio: 104-idio-16: Migrate to the regmap API
Message-ID: <Y+/s4hExXVVmFzNk@fedora>
References: <cover.1675876659.git.william.gray@linaro.org>
 <013141e0daf5f82dbd85310b498727b105a8523a.1675876659.git.william.gray@linaro.org>
 <Y+/PHNePm45TPLRC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGVk67cl+MvGjJ85"
Content-Disposition: inline
In-Reply-To: <Y+/PHNePm45TPLRC@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGVk67cl+MvGjJ85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 17, 2023 at 09:01:48PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 12:18:19PM -0500, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver. Migrate the 104-idio-16 module to the new
> > idio-16 library interface leveraging the gpio-regmap API.
>=20
> Hmm... I'm under the impression that I have already gave some tags
> to this series.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This series is a continuation of the regmap migration work I've been
doing for PC104 drivers in the tree. I based this on the i8255 series
you reviewed last year[0] so that's probably why it seems familiar.

[0] https://lore.kernel.org/all/c8c7a8b1f8d49473ac219cfb40800b44dbc019ac.16=
72149007.git.william.gray@linaro.org/

William Breathitt Gray

--bGVk67cl+MvGjJ85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY+/s4gAKCRC1SFbKvhIj
K64GAP4rE3Xo+O6BiEK6U6Sau+Bg/I4oAKJKYxfiC+t18v21+AEA0hNtMeXu4/R3
szMq9sMB8ZSZ8qyVm0Za0wzQ1V+t1Qo=
=ruEl
-----END PGP SIGNATURE-----

--bGVk67cl+MvGjJ85--
