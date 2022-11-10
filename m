Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327B0623901
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiKJBkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiKJBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:40:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29066643D;
        Wed,  9 Nov 2022 17:40:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so247381wmb.0;
        Wed, 09 Nov 2022 17:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsRXxULf7WH/xl1mUfu+fpJdtkaXSivdXXajCmMxLvU=;
        b=FNOuWwDb6Zsymll8tFpPyfGqRgdYSWOU4C5qgXqUvwvSE3PiTK7OmUb5lx9vsHgOLV
         dILocjtv5ziPBDuU9eqo43jVRL9bM02JOD0mQhns6N6OeIATi7pnd1d7FKt6HKlDkskQ
         vwf6aKJASb+IUmIc03jN35K+LnO3bBzGMVegYXIyWbIhLslwKCt/GB0ZIvKF5QT+yHXZ
         lxAkdzE5ESAOJGbJBLExkrog4N5J/eJbupJYzByUxXjdyD17FE24EVskOwPVQuNm5N5u
         P0NcGk6Xjnn6Tqz63nU3x6u6ZSG4j7X95sZ4N/n4o+f1krYfbS9TqAT0IvLkZEPn2Bv9
         fMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsRXxULf7WH/xl1mUfu+fpJdtkaXSivdXXajCmMxLvU=;
        b=7WxC/Xq/dkr2LtIRnhzacyj7QNtTerbLOYHKw51bJlEZPsJ65tvfWftV9n81mum9O2
         SgzwSXYq4wykAuEqIBxdnVB2gfKJmkxpTovNT30nT2Vl7Z249viJNogHnXAK5jnL190E
         koaX62TlVwNkq8H97jsDlB39SIhA1vwVwmUDuAenpzQxZxe6gtfykC/LH++GzKXyyPPp
         oavNXFV1L6k3MXh78QLQyXBeWgxIM8ALs0yyVGx2o7qfpFDdCdE2DgByDu11TkiwcnVA
         9gREjiNQn406Yw4Hcxy57p2KVT8xIRAjetWGkk4ydf0XhuBhrWqnLj/ZPidJTRuh4W4u
         G7NA==
X-Gm-Message-State: ACrzQf1GQTulTyPijLE+zNaP1o2JI1CzOhyxFgtbzSVpGE8DvUsHoJx4
        0RX85fDyD1vUoHHaI7PfncVORHI8q18=
X-Google-Smtp-Source: AMsMyM79nelurPIkMypnvhYXHKMiWzIllpkTFVJqzOxmImEzk0XFigxZp/n/3xaxchGOWxhRtBiYPw==
X-Received: by 2002:a7b:cbc4:0:b0:3b4:fd67:d70d with SMTP id n4-20020a7bcbc4000000b003b4fd67d70dmr52246783wmi.98.1668044436487;
        Wed, 09 Nov 2022 17:40:36 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v16-20020a05600c4d9000b003a6a3595edasm3078915wmp.27.2022.11.09.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:40:35 -0800 (PST)
Date:   Thu, 10 Nov 2022 02:40:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     jonathanh@nvidia.com, p.zabel@pengutronix.de,
        dmitry.osipenko@collabora.com, ulf.hansson@linaro.org,
        kkartik@nvidia.com, cai.huoqing@linux.dev, spatra@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] soc/tegra: pmc: Add IO Pad table for tegra234
Message-ID: <Y2xWkRcsDo7FdAo4@orome>
References: <20220930160213.2447099-1-petlozup@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VqdMED4Jqe9W+ZGV"
Content-Disposition: inline
In-Reply-To: <20220930160213.2447099-1-petlozup@nvidia.com>
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


--VqdMED4Jqe9W+ZGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 04:02:13PM +0000, Petlozu Pravareshwar wrote:
> Add IO PAD table for tegra234 to allow configuring dpd mode
> and switching the pins to 1.8V or 3.3V as needed.
>=20
> In tegra234, DPD registers are reorganized such that there is
> a DPD_REQ register and a DPD_STATUS register per pad group.
> This change accordingly updates the PMC driver.
>=20
> Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> ---
> v3->v4:
> * Addressing the review comments from Thierry Reding.
> v4->v5:
> * Remove dpd request and status variables from "struct tegra_pmc_regs"
>   as they are no longer needed.
> v5->v6:
> * Fix compilation warning: unused variable.
> ---
>  drivers/soc/tegra/pmc.c | 708 +++++++++++++++++++++++++---------------
>  1 file changed, 439 insertions(+), 269 deletions(-)

Applied, with slight fixups to the commit message.

Thanks,
Thierry

--VqdMED4Jqe9W+ZGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNsVo4ACgkQ3SOs138+
s6GgSQ//cK+0K+RzpZtbjZce876wvnZDxuOxhdSqTj4u4qnmlTOP+Hta28ATqWBZ
LXJvXMkKz8GtMjJXo+IyktB6KUtP1AckPYen5fKYXxPlyXhE7gv+BU+69wmFG007
N9kONoY5eWjbAOJwtB0OB5Xjz3EJafFEfRxHGqXuKpkezpy6nwPFtbyf/7ElEnBR
wz3a9OGhTKsR6HXVquPJPV+a7TME7Gr/ViOvVoMzBfcbFqFMh7hrq3nGBvdCtPJj
qsSHwyNhrp/hw6iywgXvUGKPtmGgYvtFkod/WX00e9UNLIpLDme6biE3MLL0NGhw
OBNqR3tWRN07Xcdc0mg0UReWXiGi66LyXtrrRlsLDh4Q5TDKfqUtwTV0Yjv2UtpT
fgKX+XQWyyI4xaNkjL5f7r84Mxe+lMqA1aS15RrMQAAeXv0GpQuqEShQJwvdjHLO
7DRoLJ4wOuwpjY1vPKikRmfBjbtKxd2qozGj9W1MSeDOKAIPxj0rSYAcoZHi9HWM
5396zpyp+wzsARqHPMd7bxzKTnFrAqh3//1ZmoqZmG1SZKkp+0d+bUHzoGcJJCXF
ejV7lTuXtTnKIE6b3056VZuv2/0ZldI3SnW+bqZnvOOi0GI5l73iaVxYY+Uvwfd7
ret5vYAgfLpnHcZxvddsjTBfRjv51sEwVVluv+o6xgWyHJezXFQ=
=OYYT
-----END PGP SIGNATURE-----

--VqdMED4Jqe9W+ZGV--
