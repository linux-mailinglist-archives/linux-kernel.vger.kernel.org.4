Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753755B9ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIOMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:33:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DA153D3B;
        Thu, 15 Sep 2022 05:33:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z97so26705082ede.8;
        Thu, 15 Sep 2022 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=uRcCz7w/qNQWN54sm/KxVXaxOcNEAOypLJYBNVshaf0=;
        b=BbefnUICwHHtKzxyfBVFf1WlKOK88Lv1gI8/isMFbjqenp/CVSsJSlMT6JNmtnZ83n
         dgc71FDpkEfSYeE2eodABTOqd6E2ES3pIssm1FCOMDJ2lCcEwqvxm5bygOu0pPaXY/8T
         U+4+XP3Bap4SCD2l5IENEyooakWYN4YWOdM/mWKFwV+OBfjPpA68nJo3FEo+zVD85oYI
         mXrtNB09lvR64mA7XQk6LD1MsalNA8G2A+bK5prT98USHJ7J80PP/Htx/m8kJQnnO7yl
         kkexF2SWV/i0CyMeXmBveXSc/VI3rnw4nHMks513pvIbPkMTCuVPUlU2htP9M5WJISj3
         9Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uRcCz7w/qNQWN54sm/KxVXaxOcNEAOypLJYBNVshaf0=;
        b=MvaFBMMErb9qKxKjF4ds8X9vyBd4N7xId7q7R0xsSZ0OAa/cNm8cUWQfMEIHwY+jve
         Iw6SJQz3/imv3tyfrDTKxusNm27SMXmiF7XzY4w4H2rLcgIS3OAplB9oHCOgsueCljg3
         LECk/QLsggciw2OCBDtYf3UOpQW+FPh21EXr0E2gaz5XQrToNv+zKcxtJXd2l3lumCR9
         K5mM2qQs+E9HexASqlwGiboFdSp+htDwYoTqpppbFa43nGeECm7YMN6q70yv9S1fWJ94
         uDX1nNoo7BcKYDn8eUj3ZffEZO8yzKKY9vJMlAEADMXLDf18V86UsjYQT/aRzmoDmJiF
         1/PA==
X-Gm-Message-State: ACgBeo2CVxwRSSf7QmYuoXa8GZJysNNKtysqSueND7lDvR1ykpEnoz1/
        /2qgXZyJCI7ppwL3iFxQZvs=
X-Google-Smtp-Source: AA6agR5pClp9iMUcfqEMXXv3D/94SFr6VI7ht/lKcFkZNxlQK337vbzQdkg7OWc9HmxLIzYdy3v2bA==
X-Received: by 2002:a05:6402:2554:b0:450:28d2:2152 with SMTP id l20-20020a056402255400b0045028d22152mr30497812edb.303.1663245200077;
        Thu, 15 Sep 2022 05:33:20 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id va6-20020a17090711c600b0076feb45e2d7sm2568937ejb.135.2022.09.15.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:33:18 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:33:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 5/5] serial: tegra: Remove custom frame size
 calculation
Message-ID: <YyMbjFMguOjiP0kV@orome>
References: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
 <20220830084925.5608-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neI4Ah5D6zKSsQ0D"
Content-Disposition: inline
In-Reply-To: <20220830084925.5608-6-ilpo.jarvinen@linux.intel.com>
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


--neI4Ah5D6zKSsQ0D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2022 at 11:49:25AM +0300, Ilpo J=C3=A4rvinen wrote:
> The number of bits can be calculated using tty_get_frame_size(), no
> need for the driver to do it on its own.
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Looks fine:

Acked-by: Thierry Reding <treding@nvidia.com>

--neI4Ah5D6zKSsQ0D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjG4wACgkQ3SOs138+
s6HcxA//QwyuWDzZbDmTNw+S78W8M2qz8Fm20rimP46tydT3aB5yG5s+L6y8hvCp
g/2/GdSMaReB+ZEJadXEJedxh8LHJctucQT54/mjIRUWbIqhY30pgU8sdeOYJ/Wq
94+a66sYiI0/nO8M4h+xhaoLweTwsaBWrPp1CX/fiFx/aD+60/Csf9+WLBD8IwYU
qxn02Y/fsaQemFf2WseUSKEcZgexshIl4LQE5pdPwKjSG6speUGgQ18uVe4uhvgn
fpWS9lAAqROI83u2ZQGLJZTU5m6bHiTGO1q9vhE0b0OqU06sBoZTECvdXReFzkiZ
g9zt4MfBkZHqpmO/AavSk6p2nPTO2zCJGOkQEJi88Gb2OxKRlMrDBgwr78cSqMEJ
y4bO3Ty8L0xxOn1R+FDZLUf2erMG97OjPR6vloreA5wt/r9k3R9TDdGEgkzL6ovQ
rQFzQo91p25Buy6WxaRhCL3g/Rp7YvgVqHMVSQQdGpo2AfeVL30iGQygNJar7MZt
AAF1Ez8n3OC9s8JNrxU9jXM2KKk6Tg2IN55ycTCCBb6m3gdAaHzaJ0LTjT4hWuIH
7jHRFoytmJrTdpdaRSH2TL411zv5Xd366mAofXCfo6xtkfPhj78dQ3Dqwp6Ty1wu
lF5nEnRabBRxUGuM/4MvL1e8ZMzGA3uV82kPe6sR85BZ7/1SC2E=
=6qEz
-----END PGP SIGNATURE-----

--neI4Ah5D6zKSsQ0D--
