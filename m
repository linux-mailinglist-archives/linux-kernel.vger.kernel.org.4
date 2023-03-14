Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D466B9B80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCNQb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCNQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:31:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7414A19C7A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:31:24 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id op8so11893795qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678811483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JokN87WLq1aEN8gzjoxg/4DilusycZbuSWsZ0B+pKHY=;
        b=DJ0YYOjy0s2tRXjYajolLFEUbB0dYP269vTqxV/+xq8YPOsEt/A4ABK0TLJgnbzT6k
         tpdPh4xKnsXglIiSNgDi5cPzwkQLMNkuBxfbr+VhXy6vMBT6JkxGWmEZd/eB6g1/BNbA
         JpOWWjSofQVj7gsHN67e7G/DMwA9ADKugo1Rps+YtWEARGec4M+B+86ns0un0iVaZqk5
         20CHNqGXpwuNTN/GR+Ts/0OaA1nkfhtxWPrsdyRKDXkcmRpx7pvUFY+6g9VqnKkoU7ZS
         iimAYZCFRfWqfl1qMmYpavNRSV6C/GXkZmimecQweQadifYh3vY1FOedCe/Wg9tIkCSU
         fYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JokN87WLq1aEN8gzjoxg/4DilusycZbuSWsZ0B+pKHY=;
        b=In6V9vCq5NjPxPuxG8L5PHbUmBRbaMXroxBiwkzXASorxjTaTeOS5Xh27LMB0NPbG8
         R9mHMwslY9l8u0gKAV3iR9B1v1t9GVtoA/LvE1+8sMQ2xM3vAKON+4kW9Dg0qzWpEKZw
         NpMRPW4Q/IqFB1w3Kkd3BaFNcRIhCvMfCu9/3s8UjrPLwjIjoiE+11aIyK3ru1aVHf5C
         KM9KsdvsIciImlrnP/vM3Ngt+OvGDYa0Dy5FA3AwrSxQIkX6+v+hD4e7Zyo+vQtkpnrp
         UJAMCfbRldEyQ+G9B1MDaAC89EyymmXyw+4G4CZSxVM0++Zc30aH43t61GCGL74mI38h
         nZBg==
X-Gm-Message-State: AO0yUKXFjT90mBD8Drd/GzSsmMYd2uqyzHsMKYI1gxD7o6Ce9xj8vYR6
        7Pb+h1peZ9z3ToAaHJWO5JS2Mw==
X-Google-Smtp-Source: AK7set8YqlrmUkzzTOaG8j2sxU7H6fp5fxqiCnnUsnzZjFjxPwB8vCprLJ+6mBOe6Blb/ZUCMj4hVA==
X-Received: by 2002:a05:622a:8b:b0:3d4:17dc:3fcf with SMTP id o11-20020a05622a008b00b003d417dc3fcfmr1126549qtw.5.1678811483494;
        Tue, 14 Mar 2023 09:31:23 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id d18-20020ac86152000000b003d3a34d2eb2sm589289qtm.41.2023.03.14.09.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 09:31:22 -0700 (PDT)
Date:   Tue, 14 Mar 2023 12:31:20 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Message-ID: <ZBChWA6aGLPZ/2vG@fedora>
References: <20230314152916.185939-1-william.gray@linaro.org>
 <ZBCX0iVwYD4uVxwM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IxJEXLiCa9EcaoIp"
Content-Disposition: inline
In-Reply-To: <ZBCX0iVwYD4uVxwM@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IxJEXLiCa9EcaoIp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 05:50:42PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 14, 2023 at 11:29:16AM -0400, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver.
>=20
> ...
>=20
> >  - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()
>=20
> I'm wondering why you can't use dev_get_regmap() instead.

We can set `wdd->parent =3D dev` in ebc_c384_wdt_probe(), and then use
`dev_get_regmap(wdev->parent)` to retrieve the regmap. The only downside
I see if perhaps the added latency a call to devres_find(), whereas
using watchdog_get_drvdata() is just a pointer dereference.

I'm indifferent to either choice, so if Guenter or Wim have a preference
here I'll follow their decision.

>=20
> >  - Map watchdog control registers based on offset 0x1 and adjust regmap
> >    configurations accordingly; offset 0x0 is unused in this driver so we
> >    should avoid unnecessary exposure of it
>=20
> I'm wondering what bad could happen if you expose it.

The WINSYSTEMS EBC-C384 documentation I have does not specify what
offset 0x0 does (nor offsets 0x3-0x4), so I don't know if there are side
effects to reading those addresses. Really, I'm just avoiding the hassle
of writing an explicit precious registers table for those offsets by not
exposing them at all.

William Breathitt Gray

--IxJEXLiCa9EcaoIp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBChWAAKCRC1SFbKvhIj
K+drAP9p43P0w0nREDtGKpEvbdiSQ+iGLMm+VukR4SVjeTLX0wD/RmCC9x7xhBnC
UJ0SEqq84HDKODsHYOZfWi6/AB8qSwY=
=PSAm
-----END PGP SIGNATURE-----

--IxJEXLiCa9EcaoIp--
