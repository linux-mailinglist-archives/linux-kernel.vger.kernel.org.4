Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50A6D2993
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjCaUna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCaUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:43:28 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109891E73E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:43:27 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id w13-20020a4aca0d000000b0053b8aa32089so3709243ooq.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680295406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbJR1JChzmLTsVV+iWqp2hMTIHEnfqkgzoCIgyYNt9Y=;
        b=mtQb5LlUhEmXR/NfZBfC1qdFoj8FmXhaVQdtj43GHYsXr2rrb+9cdRt06c3M45CSq3
         CdIqt8RN9MPw67cGIDn6tbZBifoKYWQayevCowTwzuKXA9LcZDH/uTRF4i6KD4MkKeIm
         zY9L0U6VQajiEHIt4WHLNyD3ghRPr8IYOK1FWQ6PPvybLHSmu2q0a9A3r//DoLjWfoJm
         7Iaz0/oJGeW2Xl0JuZ63eUS5Yb6Nhs22ACUPmD2qwidlfgKQtSmlodVROXoiJVI03Lwl
         L+9sGfl4kyfgE2nMqzHmufT9VqCoGmxqL315JG5dlb+UiiAre2ySiwovpDOuJl9mEcDf
         5w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680295406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbJR1JChzmLTsVV+iWqp2hMTIHEnfqkgzoCIgyYNt9Y=;
        b=zZNXZuxHnFyH9HTztRCK8JLJzQjC2No4GNQcMGVeKNaV50DeoiBkWK05WXqQlmNmBj
         To0k1G42IPo4ecsUR8C13tzoCEytjUZoucksJsXg19bGI/FQ1Ca+YDOIibgSdzTANp9R
         JcWjlGP+P1R6kNmKj8iNLJF/V0jCwoXsNRXLGqyn2i7fwJOhSwxCSmDdP7RbJBQFYSsQ
         510X+z09cPME3+wFl9mjqLTrcN1DLXGTj2fevSVsla5mXj8HRmpyJCLFP9dpfLKUkwRj
         yuS6GkUXxpOfYmzt8wH23uAH/E6WdXE2BIifGvRB8bZmo3Xq1LrE2ywM0ZKX8wS90NnO
         ke4w==
X-Gm-Message-State: AO0yUKV+PGZeX5gbSWaNE4Cj2HCB+AryHM6ybymqalXqSz+wXRKllOhQ
        BglwfC3Uq+zqWuzLLc/rrc2ZRQ==
X-Google-Smtp-Source: AK7set8V3Ca+tICQ9ImYTvIekiytSecy9jsH4rdXe0Ny8GVw06BgVSCnoiUhP9+fRLKJDMrgoj4ILA==
X-Received: by 2002:a4a:2c86:0:b0:53b:5510:9594 with SMTP id o128-20020a4a2c86000000b0053b55109594mr14082165ooo.1.1680295406387;
        Fri, 31 Mar 2023 13:43:26 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 188-20020a4a1dc5000000b00529cc3986c8sm1235060oog.40.2023.03.31.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:43:25 -0700 (PDT)
Date:   Fri, 31 Mar 2023 14:24:28 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] counter: 104-quad-8: Refactor to buffer states
 for CMR, IOR, and IDR
Message-ID: <ZCclXMQ2NIUOdjas@fedora>
References: <cover.1679605919.git.william.gray@linaro.org>
 <c5adb13b4b0887beb1df40b34d2ef03d63a2860d.1679605919.git.william.gray@linaro.org>
 <ZB2OG4zZXsqqyN8v@smile.fi.intel.com>
 <ZB2Ob9VGe3GoEVko@smile.fi.intel.com>
 <ZB2k9m7rL7Hpy/zU@fedora>
 <ZB2qI7k/Igws5khg@smile.fi.intel.com>
 <ZB3DJjQLa48AodSD@fedora>
 <ZCDc0zPtPSyDgOaF@fedora>
 <ZCFn+A6oAVNOe3yp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G5V++XAWDcOgjajm"
Content-Disposition: inline
In-Reply-To: <ZCFn+A6oAVNOe3yp@smile.fi.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G5V++XAWDcOgjajm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 12:55:04PM +0300, Andy Shevchenko wrote:
> +Cc clang (for the ideas you might have, while the issue seems related to=
 GCC[?] )
>=20
> On Sun, Mar 26, 2023 at 08:01:23PM -0400, William Breathitt Gray wrote:
> > On Fri, Mar 24, 2023 at 11:35:02AM -0400, William Breathitt Gray wrote:
> > > There are eight calls to quad8_control_register_update() in 104-quad-=
8:
> > >=20
> > >         quad8_control_register_update(priv, priv->idr, id, DISABLE_IN=
DEX_MODE, INDEX_MODE);
> > >         quad8_control_register_update(priv, priv->cmr, id, mode_cfg, =
QUADRATURE_MODE);
> > >         quad8_control_register_update(priv, priv->ior, event_node->ch=
annel, flg_pins, FLG_PINS);
> > >         quad8_control_register_update(priv, priv->idr, channel_id, in=
dex_polarity, INDEX_POLARITY);
> > >         quad8_control_register_update(priv, priv->idr, channel_id, sy=
nchronous_mode, INDEX_MODE);
> > >         quad8_control_register_update(priv, priv->cmr, count->id, cou=
nt_mode, COUNT_MODE);
> > >         quad8_control_register_update(priv, priv->ior, count->id, ena=
ble, AB_GATE);
> > >         quad8_control_register_update(priv, priv->ior, count->id, !pr=
eset_enable, LOAD_PIN);
> >=20
> > I attempted the cross-compiling using an x86-64 system and I was able to
> > recreate the build error. I tried to isolate the problem line by
> > commenting out quad8_control_register_update() calls and discover that
> > this appears to be an inline issue after all: if there are more than six
> > calls to quad8_control_register_update() are in the code, then the
> > '__bad_mask' build error occurs.
> >=20
> > The build error doesn't occur if I force the inline via __always_inline,
> > so I'll add that to quad8_control_register_update() to resolve this
> > issue and submit a v3 patchset later this week.
>=20
> Doe it mean it's a compiler error? Or is it a code error?
>=20
> I'm wondering if clang also fails here.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Al, I think you were the one who introduced the field_multiplier()
implementation in commit 00b0c9b82663ac ("Add primitives for
manipulating bitfields both in host- and fixed-endian."). Is this build
error [0] expected in your opinion?

I see that the field specification must be a constant according to the
commit description, so does that mean a "const u8 field" parameter is
valid? Does the field_multiplier() implementation have an expectation
that the condition check will be evaluated by the compiler during the
build and bypass the __bad_mask() compile time error so that it doesn't
appear?

William Breathitt Gray

[0] https://lore.kernel.org/all/202303241128.WBKc4LIy-lkp@intel.com/

--G5V++XAWDcOgjajm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZCclXAAKCRC1SFbKvhIj
K78CAPwPh4AKoC34hyvsngmJT9sInLAPMmuoK926accTBjmCxwEAm2Vg3mw6/mBU
VHdlglwqFRrfFerddC9Mct8nmG89hwY=
=K6oT
-----END PGP SIGNATURE-----

--G5V++XAWDcOgjajm--
