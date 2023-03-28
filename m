Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2366CBD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC1LV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjC1LVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:21:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB827A8A;
        Tue, 28 Mar 2023 04:21:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so48068669edb.11;
        Tue, 28 Mar 2023 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680002510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uV8dWinN4UoTmw9006A8Yi8Nmf//s38L4m1uuCw/6o=;
        b=Z8IWeCmXyimOyR61VNL6lafjFaK/PgrLtpeBX+Ym3xj3VI17fe7f7cJDSch1CZph2f
         fzg7PVGr5Iy2ytybSxI7+vrm/1PLfFfPByUuV0lOasqgwTscpRq0xjpqVgL2WTcyZ/QC
         AB/vtbBDObUQOF5fFzVtBeZEmS+JoYVq34EGdgE5zdFfhm+MmPq0J/KN0mi+eOJBDAKA
         hmfPx5NG3tPrDnzZDPrqlaC85mlncNponnV/NZ1X/MMXfjxBg3U1PcwurJ3rkCp+lG/3
         1K8iBq04OB2kozVcFyASya30U+ISjv/0FRoRI+BCyoQx9HCSFpDFikGLosMMJlDoQKPA
         pBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uV8dWinN4UoTmw9006A8Yi8Nmf//s38L4m1uuCw/6o=;
        b=6wujYzTPYfoKEQDncohuTUO+b2HCUCPQ3tKU4y2gW5LaZsYXYW/YPc01tAoLfSeghu
         yMsRjwJryTPhY8bSRo5rCMnLd9M+VdOZqwl/ALrI2McuIGqlXamcmxpit22gGu6z23Gq
         VYS1sX7L0oV6zEsJYq6C8hrCX1hY0QGExbKt5MINbH3x9IASsfJL09nMsYR40wuZ5pLZ
         3Vql1JsQSHbpFrsaWQUj/kn9Gog2UmFU9OUUqqBorEnedypu7qPEFbL0TVWwDMQiATUl
         v75ZHPyDcVLr7jO3u9zB195igHvGV4vLdAceq/LIS7Bk7hyAA/ku8vXhQbm+BthisxYw
         PS+A==
X-Gm-Message-State: AAQBX9e3HMWuG1O4/I0KJvBSsN8wXix0uHii/Bpzlpr0wKeM2Wjqk3dQ
        VthSgnM9IosOeB43MNwpfFvXvz1u/Uw=
X-Google-Smtp-Source: AKy350YNJqW2Fdv328B0CnIhA6U3LZ8U501/lms78tE7OXPrOZ21aK+VITMTCPn3H0WQ8FFMnVcd9w==
X-Received: by 2002:a17:906:4b08:b0:8b1:7de3:cfaa with SMTP id y8-20020a1709064b0800b008b17de3cfaamr16262164eju.3.1680002509658;
        Tue, 28 Mar 2023 04:21:49 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k19-20020a508ad3000000b00501c0eaf10csm12868133edk.40.2023.03.28.04.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:21:49 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:21:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Fix sound on ASUS Transformers
Message-ID: <ZCLNy7jB1H6eClwf@orome>
References: <20230327150219.13636-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zp4bjfirGDraf1PA"
Content-Disposition: inline
In-Reply-To: <20230327150219.13636-1-clamor95@gmail.com>
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


--zp4bjfirGDraf1PA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 06:02:17PM +0300, Svyatoslav Ryhel wrote:
> - update dts bindings
>=20
> ---
> Changes from v3
> - fixed typo in wm8903 audio-routing
>=20
> Changes from v2
> - dropped already picked patches
> - adjustments in binding updates (tf101 and tf300t require wm8903
>   codec patch to properly work with internal mic)
>=20
> Changes from v1
> - fm34 dropped for re-work
> - quirk for headset detection and rt5631 bringup splitted
> - minor adjustments in binding updates
> - improvement of rt5631 rate asignment
> ---
>=20
> Svyatoslav Ryhel (2):
>   ARM: tegra: transformers: update WM8903 sound nodes
>   ARM: tegra: transformers: bind RT5631 sound nodes

Applied, with a slightly modified commit message on the first patch.

Thanks,
Thierry

--zp4bjfirGDraf1PA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQizcsACgkQ3SOs138+
s6Gz4Q/+NOMS5FzvQg5WA+9YZlqgugF7iYmC9iLdDMeRQDBJOH26CNTS6JpYqtxa
oilauC4jeuVhGVRFQtoESm7cplU0nUdy4tDbdiT46/iLaDXRk+0YXAbo7EOgJoLv
mm4SmUDNIW5QrAKrgQkQNXCVStSI3c/eaoGoI4/LW4y69LeYUwRz3jmNiPUnFHE7
MLrYEYqTcWU3eoQeyEF6FZTIkZLob7z08roTRVUEmVa0JPwmZYRZ8ASCGF5X3UOw
QbJcKTwFoEf9PFBj7mZCWj6cm63crA4+yLAKyvnqImKBbX9XXXw+DoxuzMq7LSCV
c4ANiAIwngwRbwoGsvY/KCkL78jG3TRtqCtMD4yGowlrL1Q3aIt29fWJ9J+RpRxe
8LVi5zNDf5eZ1EYSwNhWybJLjzslmC9ihS8aDZg54zXttCcDoXugGlvUd/PRi2oe
lppGr1c/fC01Tkzyniq2PlnTW2EnfJXdYwfOusJ9z/IbV+UwkKyeiElc0DA4Yq9E
M+qfj9r/lsjQRiE0yfNx6t+uexZV5Voqw+A8H5P22giNbs0FVHP+cINwJPOe2WrB
pNgxv+1xgq0oJSrSJ8bXKyc1dMmaUZa1tzJYEjuY37eNccdgaZWvg/FuTnmfb2O+
VmdOOTsJWZ2cZ11Nz5u/h+RTEdfLuckssJ83pndXlugvSNIIe4I=
=II9E
-----END PGP SIGNATURE-----

--zp4bjfirGDraf1PA--
