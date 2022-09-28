Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2C5EDCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiI1Mb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiI1Mbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:31:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575F925AC;
        Wed, 28 Sep 2022 05:31:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rk17so13601191ejb.1;
        Wed, 28 Sep 2022 05:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a+YK+sOaAr06YqwD/6gGw78eX83RIWDlgvjrbDoyUEg=;
        b=JkfbblA/Go8wkLhhiII9xXOZ/Q4yTYZfjOsjVo8kXWFEWdzmOYeLNytCig7MoJ+aEo
         K/to6pxnzQIKOBqU469SVieS6h3Y7uS7YO0MwN5NiujDk/ppDg7G8hxwiyHhhA2sUmkA
         u6JynE5azgOKDGJ0nTbQlLu3A/p6zWffguUr7ASBrRhXH6/IuoxtDYzJnXSg7+oBCOMs
         ZIMNrkLzHgyurjoO73vnCFTWuAYlOhLOM3WmSp0CqKcvr1xMA7F1oBlAQiB6TmoJACJn
         WJ+wqJcm82cL+WzWEJA5fuoxrtpk/9vo8aEOJxsL4qnEAaM8HWDzv87G40n+dI8VBfgS
         YrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a+YK+sOaAr06YqwD/6gGw78eX83RIWDlgvjrbDoyUEg=;
        b=NlJJTn8dtWBd8Cp9pQa3waVIQWz0HTVXxrvgmEa0cVx+ABsL5S74rXIVaraCvz0xcT
         wdbDrL+9oTZl3dUaH5PSwaKIPeyf8bCBbObMOdV2tEMdMA3rAZwurPCWKn8GmYbEPAsU
         LatKXcps6ILzJGZZqrm8sjUHelq017fenJmQ0+mcBnN1aU7JSU63gfb7lLerRZ/W9+3d
         5pZKUgd49hXFgQt/FmCnGeTaVCt3whxXDYMiNvXSnpq0tEqKHUyTa3gr5vJD9scNkQjv
         of1447CBXf6LZGVPRXj/KUA0h4ZdFssTH3Cwg8oCT/QRi/6NR78mBgXJc7heUtV28jb0
         8NrA==
X-Gm-Message-State: ACrzQf2S2XENLFou4wPJZ3iOCsqn1Tf/wRa45MlgQCcWlvxxd2dobHet
        CUTdhqD3RHHUFlNlSHlc/UNpfMmM5P4=
X-Google-Smtp-Source: AMsMyM5+F4A3pIzODJUSsyuE24SZpblU8q+Lmby2O30RLEdcvW/lEafvB3XIslbHhFzEJMBUWAdCKA==
X-Received: by 2002:a17:907:9816:b0:787:4350:3a19 with SMTP id ji22-20020a170907981600b0078743503a19mr5547221ejc.627.1664368308072;
        Wed, 28 Sep 2022 05:31:48 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b00780982d77d1sm2278422ejb.154.2022.09.28.05.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:31:46 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:31:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <YzQ+sYdl2HR/4fNi@orome>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bc7ifuzH2AwXLvof"
Content-Disposition: inline
In-Reply-To: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bc7ifuzH2AwXLvof
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2022 at 08:07:13PM +0300, Andy Shevchenko wrote:
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> v2: added tag (Uwe)
>  drivers/pwm/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

Thierry

--bc7ifuzH2AwXLvof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0PrEACgkQ3SOs138+
s6Fibg//Uw167V2Wf+JtDDPv8IVcnyVx6lGpkFKF5IFHNZRBJ8KX2DAMrzFOsv+f
/KIQdAPfxCP+AT2ZDUf6JbECW4m4dQSf8SYRhxzi1LqHntZLQnOPDsIF3cAM7NCT
vdbTlBeNLjV+iIcO34zkIolE9LdIykWUmS4U+7Mc8igq5P5Tn3dLqXLegk49uo47
26+Ldev7cpniqK1RtGyWT+qOFnCmxR+P9OJwJIDdA6HhcEf9VBNuqTvyubqRAklr
Vh4oh6Sov204KdwWlbZ1MIf+dVWB2Su16q8Rrevggg7NFIcWVO2zfvfWFe4UcAWd
uWrZcusub0FFANIW22KyF3yZnJvg+buaLPni2dCCTy/396muGY2rk4+q2dnTazR1
wI2GXhCzdC2lK8CpLxvyBR+nXM1NDPkiSayjcVU2R8oWYxhegsFD72ZrQY2KE53u
HJkWihAbGWCb5dsWGi38Xsl5r5JAXxHdelK6MZKD2Eu6ulACfui+kuxAKTeLdXCm
F0G/dn6hbDHZgQJXN4g048Ac+FB4bNDoXRNbfxYxfmhy3OylmRGxJs6KGnTZcWTK
pHgydMTPzh1pJOdL+xK+NZ3rULA4mG8VzFVusiHH3GfQW52tgfmawwF0Hd5eXMmd
S/sXsdVA98E3ASBJoy9lTR7idD0AxoG4UvVZMuyqL4EFrwSI1kY=
=2fes
-----END PGP SIGNATURE-----

--bc7ifuzH2AwXLvof--
