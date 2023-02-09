Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806E6902BE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBIJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjBIJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:02:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4459E6D;
        Thu,  9 Feb 2023 01:02:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3378880wms.0;
        Thu, 09 Feb 2023 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC97GopJvrXLbn2PKKUSbpHzg6otGN8/TmQ45fLzCwg=;
        b=LGXbmHpD82SwO7t5GHJRbL9D9tnGJBSbJlXfWcp/0FH9N84f2Sa13M0Re9YHbDoyhg
         YPINzA85tPnpsiS45W+IRgN8BP7ND5XOFV8iri4ZAyz9uDeaK4qQbL1BXngATrjsua5i
         NSKPbaEH9+rAVkrRRMGb9fTB3PUUPutZBWzYztXMlo0eInA0cWi8U4Q7mgEmhUivgjpO
         ehJiOPvzW7Fa0H0YsS+0gNjEF3MciPQ2ZY1wcuDxBQznbhm1iVtNn0uAt0dqryAGpE0C
         rkkJahjNJOR82mfmYbg2jDdpktGf+ifYLxNksidRLVjKl98KZU0nmFBFxb8Dlecb8nzu
         oJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC97GopJvrXLbn2PKKUSbpHzg6otGN8/TmQ45fLzCwg=;
        b=7WIK1y6zXdpKR9GrjXHPgMhihOsWpQx8Yds2rtOC9+OZYKeyQpsC1CIt+9UhnllMg5
         C0uwaG4GeAvqLr4JmpHQx5BJONdTAeGtcsbWQ0b04a4amY1L2RLwVUoqZ7ZPxWTf0qDd
         eCL7b0O9VpQXBLohUN9m5QyhjPsBhB2c2Hl5AhRUt93EV5tfI3O7HHioAC48Y1py9ZQl
         jXIfLAsOsFgLeGHMEsD/vn0XhKu9pde1gQds7sTY31Mv7lcciomV2VkKceOBYcHHWW4m
         u+ENDJZ/U/BCEcDxbSywDI6xlJFHbsSpupq7flKhFpPBr1MaNpDE2V1UJgWSb0QKXPbq
         tAeQ==
X-Gm-Message-State: AO0yUKU77vXldAvvY9i1EDtxBBj4Tf0WziwBvyGO29XJ04gV8EfZH5UM
        nbeyDYNFLcUCuwRBb7IR1SWWHoc0KEI=
X-Google-Smtp-Source: AK7set/OIOma0JSIKRu7iGW0p18KEvtZnF5RX5xn4Okviz+X/IXGT3ecqTS1iIBjUDnxtjjbArLbzA==
X-Received: by 2002:a05:600c:4f85:b0:3df:f127:efa7 with SMTP id n5-20020a05600c4f8500b003dff127efa7mr3746626wmq.22.1675933354740;
        Thu, 09 Feb 2023 01:02:34 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bce01000000b003e0010a9f67sm4394680wmc.44.2023.02.09.01.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:02:34 -0800 (PST)
Date:   Thu, 9 Feb 2023 10:02:32 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
Subject: Re: [PATCH 2/7] hte: Add Tegra234 provider
Message-ID: <Y+S2qES83S4pZKOb@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-3-dipenp@nvidia.com>
 <Y25x9gc4tpF1f022@orome>
 <1a186be2-498a-a63b-a383-c165a9f8e732@nvidia.com>
 <2cc8378a-3f74-d4b5-613d-f9112806ec92@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3s7xSXdBBpM6Hx5L"
Content-Disposition: inline
In-Reply-To: <2cc8378a-3f74-d4b5-613d-f9112806ec92@nvidia.com>
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


--3s7xSXdBBpM6Hx5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 04:43:48PM -0800, Dipen Patel wrote:
> On 11/29/22 7:00 PM, Dipen Patel wrote:
> > On 11/11/22 8:01 AM, Thierry Reding wrote:
> >> On Thu, Nov 03, 2022 at 10:45:18AM -0700, Dipen Patel wrote:
> >>> The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
> >>> HTE support, it requires to add mapping between GPIO and HTE framewor=
k.
> >>>
> >>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >>> ---
> >>>  drivers/hte/hte-tegra194-test.c |   2 +-
> >>>  drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++=
--
> >>>  2 files changed, 121 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra1=
94-test.c
> >>> index 5d776a185bd6..d79c28a80517 100644
> >>> --- a/drivers/hte/hte-tegra194-test.c
> >>> +++ b/drivers/hte/hte-tegra194-test.c
> >>> @@ -16,7 +16,7 @@
> >>>  #include <linux/hte.h>
> >>> =20
> <snip>
> >>>  MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
> >>> @@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_devic=
e *pdev)
> >>> =20
> >>>  		gc->match_from_linedata =3D tegra_hte_match_from_linedata;
> >>> =20
> >>> -		hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> >>> -					   tegra_get_gpiochip_from_name);
> >>> +		if (of_device_is_compatible(dev->of_node,
> >>> +					    "nvidia,tegra194-gte-aon"))
> >>> +			hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> >>> +						tegra_get_gpiochip_from_name);
> >>> +		else if (of_device_is_compatible(dev->of_node,
> >>> +						 "nvidia,tegra234-gte-aon"))
> >>> +			hte_dev->c =3D gpiochip_find("tegra234-gpio-aon",
> >>> +						tegra_get_gpiochip_from_name);
> >>> +		else
> >>> +			return -ENODEV;
> >>
> >> I'm wondering: instead of doing this cumbersome lookup, perhaps it wou=
ld
> >> be easier to create a direct link to the right GPIO controller with a
> >> phandle?
> > Possible, need to see if gpiod framework has API exposed to get the gpi=
ochip from
> > the phandle.
>=20
> Thierry, I can not find any API which can help retrieve gpio_chip from th=
e GPIO controller
> phandle. I need gpio_chip->base to map GPIO line to GTE mapping.

gpiochip_find() should allow you to implement that. So instead of
tegra_get_gpiochip_from_name() you could implement a function that
matches on the phandle that you've read from the HTE node.

You could probably add such a helper to the GPIO core, since it seems to
me like it would be universally helpful.

Actually there's of_find_gpiochip_by_node() in gpiolib-of.c already, so
you could propose to export it for external users.

Thierry

--3s7xSXdBBpM6Hx5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPktqgACgkQ3SOs138+
s6EpbxAAk28C3+2tpKxyVTrcXW2ws04VXUjVf2QP535J0kRWuq9f9bo81P0Fd4XZ
gQocbe5T1MRIePkqRYvZcXE5omLA7ATUVOxZHSiBOUkM0QtHe14WAN7xQ3AFeK5b
2R9Tx3HNmj2BOE666UCflda/OqkOOCqSf8R1Y0JL+efzK+80ve4nutR1ycJTJG7R
IWYwKTAraLvlUKmDhMtTerojVM7tknVKI1vYjeZKaXKfcDCgbUmgd3AkP4Bvu5HZ
bx/pBuscvukEcoTR7hofMnaHrBSSFeWIiNga6GgiWqdbubHathCVRZWFqvMifD1k
j5Cxi1LPUa4sNBBCiD+kt2lmlO2QAD2vL3ra9KHKhQ4G0fO1OTfMnd1f+ZBKP6u2
BQ7U3CrmF+v8DkDxCENIjMPzbwu5HlNKKfROEXBjGx5zwqdzjkoO6pOSUliOGJAH
jaormuuNAt+meL+o6SxpxHkHhwFdN+zv2cTU2SLM5s0ju7JwGriRyB5MbqhTQNoA
iAL8DW0pLxbr5fdJZMj9YBScq29eLfm62CDRn8l3mUOteDbGF0eDUquaKLDZFo0f
iPcQW5Z6ujzjue/95CiqnXDAgCZ/NNOlrVBc+HiWr7WxVP3vIrfzEsz/g6Dx4LTf
EO/ZwokCmEMsfY7OsWX6ZNyVERbLLpsfznAzMAVKg0p+FwjZ4FU=
=RZDR
-----END PGP SIGNATURE-----

--3s7xSXdBBpM6Hx5L--
