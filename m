Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A69724247
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjFFMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237486AbjFFMf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:35:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A09110C6;
        Tue,  6 Jun 2023 05:35:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9786c67ec32so114060866b.1;
        Tue, 06 Jun 2023 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054956; x=1688646956;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDFqFlixqyPP3yOtm62pTXCk1c+zCqOZPFMFr0y6lPk=;
        b=RcpmWUV2QzYfqN9MDtkblWZQ7UK/At7xh+UmusYkkTEoakieQcSqdyhitNeoPxLT8l
         CtSUIg6DDbJgt1lXIphlDw1JZjiALsKIfxvXgC6fMTgU+iD2AZPj96yq9qgpsEB0BypZ
         WOjRsy4Sil/UnsewAWfwhFWhIkZHlA0tRUGEn3EI/UfmfSdVPF568Gk9otuc2RfnmcPj
         tAh/A51KkPRy+cVgHNwibLzWSqe+/ai5FwFNHYYiJXWaOcrq8omlpH87nAfH0/O804Gj
         tbuFgcnBPyKKduNUDhadN/84Ksq6LnmfNtGaHPlt02foprHRQYv/vfiP9S0csAmdfL60
         +nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054956; x=1688646956;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDFqFlixqyPP3yOtm62pTXCk1c+zCqOZPFMFr0y6lPk=;
        b=D8YvqkvilxR1wsxEME/0H44U5MOlRZvxtMjIxWCtfGnrZhdH1bWJGw/QBRf5Vz4Z3L
         9TaOsSMUJOzQWPG+k4mOPpbH3dCAAjAbQMMfKSHz/Cfrw7TeNeFo7v658N819fKWHD79
         zATVwHFnA2nsfd9HuBOiYMpxjagQy1sVQpUfFOIPQg8zBdNHAcpimSg6Fsqe4aqdbkMy
         E2FBgl4atRO6eRxryr4fnMv6cdvIicBuXcn48UzIASSb/LM3aIGsKccb4OhvIS9uY1cp
         YbYe3vg2H5posU/qWQR2qw2AO2iNaE2OOcru+dvgiXoTFJTtUTiq9AYM0bDWgzwegSWs
         jSLw==
X-Gm-Message-State: AC+VfDxsl1YGnnCI6uxew2ekqAS+EDNGqxrGiW3L2QQRjpY9FiiaaDu9
        LasL74UqMirfu6OQIqs/Yvm/dNBhLh4=
X-Google-Smtp-Source: ACHHUZ6stKm1h9XwolResZGNvz8CgkwvfkQ1MhnG+DJKzMAqJ59L+8dn17Ysloj/ltEFM+81ivQejA==
X-Received: by 2002:a17:907:8a1e:b0:973:e034:fd47 with SMTP id sc30-20020a1709078a1e00b00973e034fd47mr2656250ejc.29.1686054956099;
        Tue, 06 Jun 2023 05:35:56 -0700 (PDT)
Received: from orome (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c10-20020a1709060fca00b00965a4350411sm5501730ejk.9.2023.06.06.05.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:35:55 -0700 (PDT)
Date:   Tue, 6 Jun 2023 14:35:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Message-ID: <ZH8oKiteNGxYmw9l@orome>
References: <20230508100320.345673-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vfMTC1L5xpBYeOiz"
Content-Disposition: inline
In-Reply-To: <20230508100320.345673-1-haotienh@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vfMTC1L5xpBYeOiz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 06:03:20PM +0800, Haotien Hsu wrote:
> From: EJ Hsu <ejh@nvidia.com>
>=20
> For the dual-role port, it will assign the phy dev to usb-phy dev and
> use the port dev driver as the dev driver of usb-phy.
>=20
> When we try to destroy the port dev, it will destroy its dev driver
> as well. But we did not remove the reference from usb-phy dev. This
> might cause the use-after-free issue in KASAN.
>=20
> Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> Cc: stable@vger.kernel.org
>=20
> Signed-off-by: EJ Hsu <ejh@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
> V1 -> V2: Remove extra movements to clarify the change
> ---
>  drivers/phy/tegra/xusb.c | 1 +
>  1 file changed, 1 insertion(+)

Haotien,

I had already given an Acked-by on v1. Typically you should add such
tags when you post new versions so that people don't have to repeat
them. Anyway, here it is again:

Acked-by: Thierry Reding <treding@nvidia.com>

--vfMTC1L5xpBYeOiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmR/KCYACgkQ3SOs138+
s6Fj3w//SXEz4e+9L1+FbWcfAd5YJtGNumhfQDUBHj/bsNY/K0g/y32rvoqsi40y
yo89ZtYKlMrZhmWpkXri+FIgFHNsYPScOVQJqOBCmdjY+aog3FQNN6BxNDOqfOJK
GJ9UDD1+7jTo+42dAsvPcyqBTdaY2w7/AdUIGu3n7+56Uaktwh4o6tqxHYTWP28S
UfP/IcuqovzEq29xLUOA5FqVK2wgAmA0c6rKUJ1XhDFiMeSIca26xdy4MxoQtKE/
82G/Aw8Ooi9Req0zZMg3lIZ7HarMfOr28P/2v8RLQCoKTs0ozVv+sg1owdw3jtYp
QUPvuicR/PUXwr5UYXYninXPSQ8PGLh9ETrZusKJK2fLbguXwXzF2TgqzqIj+ogX
JiP/dK7E3lSUWmertbNyHmNPc8369AsNAOQIGBe3QwCH7Msr8tOkhJcmfcaKwDrT
frGN8YwHcLyIHlqEiE1puQ6PgZlOxDCIOiyK1gWe1jCEUCih8zDPwxSzltKDpO5d
tktHf7hzGCXa44BvHNN3QIRlIyIzTdvxb64LZqAROvILd/l2MEHWHgsc4YdQ7OqL
ytL1UqUQao3k/LpTgj6E3KYFKmWx3XakRtVpdKi3Ox3lnS+RkwjT7aga0gx4qlw/
e2gmKVofE4nXJAbwV6nXSvS/LVyfy6DOLtPS1jO+fCCMcNwKcCs=
=VY0I
-----END PGP SIGNATURE-----

--vfMTC1L5xpBYeOiz--
