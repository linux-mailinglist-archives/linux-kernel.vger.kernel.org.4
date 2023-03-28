Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3716CBDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjC1L2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjC1L2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:28:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE9901B;
        Tue, 28 Mar 2023 04:27:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t10so48081804edd.12;
        Tue, 28 Mar 2023 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680002864;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH679ERMSWNWvXyyXLYJ8g9hSSHQrkcB5OP8voimmFc=;
        b=gXIQbLvbeMucqMf+c3bLPfUYw9LCwhdze69JIPGKgQYp55MekKZrZhC05qqHwTIxjs
         Q+vH8szRNFgSiSMMRaPm8ftuQrQrKvg79urc0qS1cubJ8PlEOU6VeTesKuNDa9hLZYJG
         WIVTUh3hR3JuqiIRlVyfXOMVT7Xjvzce1iVAGFIH9MadtQeLW63l9804BtYxEC9tiCWh
         vSYikVo9nPkNEsb34uh0sRuxTRkeYnjElvSjjVs6UzKCmRPyt9lTcM8EnuhUjOqboGSo
         nkkm/S2zYEOUd2bzpPp4JgaB1D3CYutiTLnuor/NKxz9T0uc5qbB4fsxLY0Pine+Kpyo
         KWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002864;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aH679ERMSWNWvXyyXLYJ8g9hSSHQrkcB5OP8voimmFc=;
        b=Axgk9CkhlsdB3aJm3hAlU60KNQT1zC3ixE5VUENERb4gfw2WSaOE5TzlGGxL+eLv9+
         er5nfo/ZKw9tzjwBJUnvntiX1AT6zqBrJCKS30xZ/ztYHURyi5LDmyyG4y0MZQG4GtBD
         4Wij/xNmqH+LM+fXh2yUFj0G0MnSauhopwhpe6fjbTYt4XaMiymt8rKlESI3Dbv5S+RM
         fgc+4e0BM4ry6fiGy7DezIRWJEgThaFus11CoWA1fTzSzTwcsnUhCmvD2fYWs5H36BXz
         DGtUqFwwFo0+oWOvRN9pbB4pnEnlUwaVPaMxJnr/xVEYb8p2zdeC/0e2USx1BrVrV0cB
         97Ig==
X-Gm-Message-State: AAQBX9cCELke2VpdbOO8s2mWE/sxlYIdmJxWLSljeh1gC3qfSZXNnoiA
        yHrgciYg5FirJyrs5Z6xC9Q=
X-Google-Smtp-Source: AKy350ZHcR+qthehrvWOddTp/MfouX/tJnnAMq8wa6jAB/Fcla2by8oFGNX4wJOfl/VcEqw1xEkK8Q==
X-Received: by 2002:a17:907:d386:b0:87b:dac0:b23b with SMTP id vh6-20020a170907d38600b0087bdac0b23bmr16831917ejc.55.1680002863802;
        Tue, 28 Mar 2023 04:27:43 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b0093ebc654f78sm5091121ejd.25.2023.03.28.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:27:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:27:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ARM: tegra: Add labels to tegra30.dtsi
Message-ID: <ZCLPLUFFzzQ0NUoV@orome>
References: <20230304084319.18424-1-clamor95@gmail.com>
 <20230304084319.18424-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MJ5Vjm57uiN1d04K"
Content-Disposition: inline
In-Reply-To: <20230304084319.18424-2-clamor95@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MJ5Vjm57uiN1d04K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 04, 2023 at 10:43:15AM +0200, Svyatoslav Ryhel wrote:
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
> for cleaner device descriptions.
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi | 36 +++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

This patch by itself only adds labels and isn't useful by itself. If you
really must have these labels, add them in the same patch that makes use
of them to demonstrate why you think this is an improvement.

Thierry

--MJ5Vjm57uiN1d04K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQizy0ACgkQ3SOs138+
s6Epcw/+I6jhse64EVfUoKxu5Z7OM2+MicpOkAYQ9COsMPlwmzk5ZTOK+ghZhEa3
m8CWNMWej6EiyCl61idoIwkDyD4Y7+WlTWcfLbc5NWYdQk1qaVcOUek2fcCLYxDX
bNCN2GLdK19z7qoaq9I9GLontKnfbWTNh8l9XxvHUgA+1cZ3n03tcnlSzsapZnEK
fJYfrJn3miYNGO1U7pM1ESpkluCOYbe7KuvW9u1D7IodLANHBIJqotDdSGSh3SKh
3yr10UMM0IuBy1PHXGevs/Di7rkHwBjabzzb+jzaC8dMiYwgSh0q2iM+TIIH4+Rw
hfaiYW10E7+ogZ00GtNSLFl6d1CLKZ3mX1UBm5CYj9n2ZX+4LPWlSj+oM6aZAPI7
fEbfaxQ4+FDu7ENLJiXcl36XJtROLkwae7liui1wbVbYA4navfP/Utoa5L9eDoPz
Zk0bLFzNu5fvFptA52gy5Y+r35gdh/dNegIeV4E5xiGk5pVPZaX5Y6tq8J0/hWU1
69UmsElMiv0Af8xad11SCzq/xX7RugVaShiuOsfSiiTPWBVKjmnO6MWFyfrunpwZ
qyaukK8odh8NNLDNNe0INbr7Vl3DoUJ9BVDiXsVzlQ2TQE9McvvouLj5zV4oO0at
JEbqrtgqZpWmKRevCuPM6iyg3rwaQKCdfTi97J9pwuVdzUDQqKY=
=F73r
-----END PGP SIGNATURE-----

--MJ5Vjm57uiN1d04K--
