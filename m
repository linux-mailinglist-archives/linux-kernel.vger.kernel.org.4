Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34186A7E83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCBJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCBJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:47:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759A1ABC8;
        Thu,  2 Mar 2023 01:47:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x3so2168382edb.10;
        Thu, 02 Mar 2023 01:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677750425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qe0Li2oGvWX18ZM3w3rNfX+KQMA8rRBxTKHfoJQVdc=;
        b=Gvh7PfztBNgT/nyPAtEUwJ4hQBaRLHoypcVeP8M6hVcxDj9RhwyOX4BA3ZzUUD3XO7
         lNb6t6Jv5lRRsxSGHGvOpirFMaP0cQ26J66/IA+73Bbr8f8y4itjlQIycqfdj6jt0B+q
         nXMIco/+D85fayGa0OYBk07GFpRJxd5y/UVQ/y8fVPofMqOwRPFbzAGrBzn6EJTSjccy
         byInFR+NzGL3JGK+9vWt4ImM9MTCsgOUQKnB/7XnX1eHvwZDFJyHt2lsDSPHbS2Bgol0
         7KI9jQ+Zl+C9CMI7iKmmGzTZl4aSHtRD3/ojB4KjZGWP0488WTJladMtXcp31UctjQSE
         DpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750425;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qe0Li2oGvWX18ZM3w3rNfX+KQMA8rRBxTKHfoJQVdc=;
        b=VK/NRm3EgBLOhNC1t/9ICy9eN4BMtvlIN20Hwmfg3HlSkTR+SkY22WzIIOxD8C/8Gq
         s0/R4jiGB82YeCybwQ1HgKpgINZtmdNuBA5IYlwkGJpc7eS8GhhfOtFhpU5Nn8F0mBR+
         n9Epv/8VH4xyhoDIHptwf0hDER9Oq/9/ilZBG7CzWgIXpT8d0CC1H8mBnmV50r/evp13
         6W5DPFPopUHOMMc2dqgefYzS4AsWIvp+QBEn+WFAGK5Po13Ipxl0BPll903Y6UG7EoOm
         gTFkkilAp8OFNsk2OZ16gPLriH7ihrXdVQWFd2hCO0do1FRphNLzg+1oBGkATUAed6z0
         g2Zw==
X-Gm-Message-State: AO0yUKVmZoGOOqIRQami+nxCJuKIVhWaTd/PpUWjTwdvGFBcIyBh3Y7j
        3Uxs47zXFbIjnvOb0DSpCPQ=
X-Google-Smtp-Source: AK7set+w7t5FsEyn281dLvfHhYds09jPRD2GXvdbMLLEJvaa9rt5QhaL4eqoRmCCneTAs+OrP13Pjw==
X-Received: by 2002:a17:906:a9a:b0:878:4bc1:dd19 with SMTP id y26-20020a1709060a9a00b008784bc1dd19mr9097818ejf.52.1677750424867;
        Thu, 02 Mar 2023 01:47:04 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906358b00b008baeb5c9bdbsm7016571ejb.141.2023.03.02.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:47:04 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:47:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v5 16/18] thermal/drivers/tegra: Remove unneeded lock
 when setting a trip point
Message-ID: <ZABwllXuTHbUhnue@orome>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
 <20230301201446.3713334-17-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4/U54hRVG0VAzoU8"
Content-Disposition: inline
In-Reply-To: <20230301201446.3713334-17-daniel.lezcano@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4/U54hRVG0VAzoU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2023 at 09:14:44PM +0100, Daniel Lezcano wrote:
> The function tegra_tsensor_enable_hw_channel() takes the thermal zone
> lock to prevent "a potential" race with a call to set_trips()
> callback.
>=20
> The driver must not play with the thermal framework core code
> internals.
>=20
> The tegra_tsensor_enable_hw_channel() is called by:
>=20
>  - the suspend / resume callbacks
>  - the probe function after the thermal zones are registered
>=20
> The thermal zone lock taken in this function is supposed to protect
> from a call to the set_trips() callback which writes in the same
> register.
>=20
> The potential race is when suspend / resume are called at the same
> time as set_trips. This one is called only in
> thermal_zone_device_update().
>=20
>  - At suspend time, the 'in_suspend' is set, thus the
>    thermal_zone_device_update() bails out immediately and set_trips is
>    not called during this moment.
>=20
>  - At resume time, the thermal zone is updated at PM_POST_SUSPEND,
>    thus the driver has already set the TH2 temperature.
>=20
>  - At probe time, we register the thermal zone and then we set the
>    TH2. The only scenario I can see so far is the interrupt fires, the
>    thermal_zone_update() is called exactly at the moment
>    tegra_tsensor_enable_hw_channel() a few lines after registering it.
>=20
> Enable the channels before setting up the interrupt. We close the
> potential race window without using the thermal zone's lock.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> ---
>  drivers/thermal/tegra/tegra30-tsensor.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--4/U54hRVG0VAzoU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQAcJYACgkQ3SOs138+
s6HAow//bXdkecSf8BK7JCcXO2dmg2HCFrd0N4Kt/cY/86hVZKL4rmqgEz8gqwaG
k/PhFwYLrLWqdenFyA47E1rj5Np2uQy6b5+iS6345abC3k0nA/j6wwDzNOXCiQKn
vMC7ZJwJx2nZxmaFiv46z2SJ3k8sdA3ew6dACrRXUAtbOerUZtdOKU0JQjzyIKBo
JURmhfexudw1oVkg8GqUmpc1dfO8pJ40jDu93QoPS1y/JPPzy5lJ6sjxaWRbELa8
tRSza/pyNm3fkJp18iOvoj3IIoVYLIuvT7shF9DuAI7FL+zXDU4o3JBs1jvBcqUE
dzQY/MNyeekQFwiq1XNxc42JzBLSWWfeuwV/LSNyfyvoYieHXaWCcjPSqK/X+JmD
UcRvrKc8rO0q6XkWneMk1RTzMyKNw17LofYHWt1WFHt82zJxTa8wSE6z2Rvx8ebK
e/MrYzuGrPiyzxzwugtVYu0fOUzdFlEip9s/iFHrhn8x/1QKR4tloJEUd5c557ap
bhUvsjYcy2zyjWVUE0gg2RbT4QG8TkO7EjpUkIFwDJIHxn1ASVlV9eE6L8TOan9P
lrGfvfmu+NrsHWjhhr1wNbxyQeA/ns83CV3nAKcz+5pxMLjtzWfpbLoqSx6e9H6G
6YekX1Yizxss8/93IskqGB5I9Y9xzE36+y1iqnTFO2XjQXmZbYg=
=jAUw
-----END PGP SIGNATURE-----

--4/U54hRVG0VAzoU8--
