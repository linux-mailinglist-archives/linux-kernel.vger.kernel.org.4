Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1C6CBD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC1LVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC1LVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:21:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E27AA;
        Tue, 28 Mar 2023 04:21:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x3so48059574edb.10;
        Tue, 28 Mar 2023 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680002472;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=499Z2GrIO+Whkf/vL9g1WX07+MdA7SkN1+fTiuxGLek=;
        b=SiruflNAwaibB+4a7tiCMbVsiC9ZQ5Mv4XdDLEEojDvdwGZA6G9nYdOypXtG+vwAu8
         QEpHmcxOuLSitKHxPquHy3QdnNgtLZG9TnbJcr34D4/iHYZBX7bmv4qfIJL9u7GMh1dp
         tpYnQgJnYjt7NLE5Z3dVHGwIo/bMGDcwm3jf6jlrwyglJRlqC0xifltcNlXFRh9ek8Ql
         ClN0ac2G70CBFpYuw2cN/HcowYue9t61vA0gQuYuL37BPRdEX+zicbTZLNTk9RIvFtcD
         snLfrl9bETjX3DGME3K/2nBTm1WEpbaUJ2SgVjRE2epp1PW0I36n6f2Ol72ZRiPs9OIz
         yCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002472;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=499Z2GrIO+Whkf/vL9g1WX07+MdA7SkN1+fTiuxGLek=;
        b=LTrhiDos+rwJP2V5wrptJRucVaA+MogE3JglF35O1dte7T4FaBzc1blNK5N67eylbc
         QpGJ1AJqleEgItnY2MFYntjNFrmeHIM8Xp7x2DBwIri2Hy/VSKihYFa8ZD6ckrWYYYb2
         HfLIm/+Dec9y/NW+b5CIccA6MpHvFPB1rOqX538QAsXFHf/t/XwTKLLqsQ7my48oOlRs
         dT136Bq8eR9sH4JiORCtqZpH9DLiaRJwkw86fzX3cdo13u6Ayn8adtrFgMLMTNlJXDvZ
         cFgySMty3lrAFq/k3HLkXeSvFzqC6NyfE1xHVSAx/svmKv3jFwq2V1fqy28+OTJzzl+u
         QjBQ==
X-Gm-Message-State: AAQBX9ewL0n1CJPze1Dn2cmsJ874kLUGkFFAcvQK67ilLabDF+er3IWf
        DBDji1n12zQOihbHvvS41Gw=
X-Google-Smtp-Source: AKy350aNn79n6oJTpw3R5z/PxoNR4rLWvCHHzIwWI42Q2WyDEDGjHg9M/kz/u2QY3Otvf3El77nQIg==
X-Received: by 2002:a05:6402:1145:b0:4fb:9b54:ccbf with SMTP id g5-20020a056402114500b004fb9b54ccbfmr14857123edw.22.1680002472707;
        Tue, 28 Mar 2023 04:21:12 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b00501c96564b5sm11906744edc.93.2023.03.28.04.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 04:21:12 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:21:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ARM: tegra: transformers: update WM8903 sound
 nodes
Message-ID: <ZCLNphF/bMRqcQEv@orome>
References: <20230327150219.13636-1-clamor95@gmail.com>
 <20230327150219.13636-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbaeChoE4AChVqkh"
Content-Disposition: inline
In-Reply-To: <20230327150219.13636-2-clamor95@gmail.com>
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


--VbaeChoE4AChVqkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 06:02:18PM +0300, Svyatoslav Ryhel wrote:
> - fix headset detection in common device tree;
> - use device GPIO mic detection on wm8903 transformers;
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/arm/boot/dts/tegra20-asus-tf101.dts            | 13 +++++++------
>  arch/arm/boot/dts/tegra30-asus-tf300t.dts           |  6 ++----
>  .../boot/dts/tegra30-asus-transformer-common.dtsi   |  9 +++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)

If you feel compelled to create a list of things you've changed in the
commit message, it often indicates that you should be creating separate
patches for each list item. Not a huge deal in this case because this
is all about fixing audio, but something to keep in mind for future
patches.

Thierry

--VbaeChoE4AChVqkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQizaQACgkQ3SOs138+
s6HO1BAAweDnFMq60h4Zpb6qIrmAXJktCgojkOPVIRMk7b/akazbEJ3jpVf/EmqQ
QLJyJ9H9NutT5G0AtLmeUaUSNJDWvKiXEMx23cGJbbuVik2FaWkwgTs5eH3CE0V6
w26JbeHaw85Yh8ABXNzMjnCxNw7NWoHozziwp35Yr63GFcMd1nD/3hUEUm/pIcBf
WAIqgvybW3PlCg8aEY9t4GwifygtvnKYB2tSHweQOG2LODSd1T0lRT1q6MZYDya+
unqkS+Z7zd24whHqEm7/XpdJK0a9pWFZ89rnCw11lA03Ee66d37wNPJsw8SkzBNj
PGBMuqzKWA5sFKK9H2cWX5Hd3DuX3mT8243RzhF23jmy+ZGBW7zmuk9trrlFPNDd
JvMNPRVW+LjOb1bcX1bcYhio4AxKnyqilqLrQQcnl2h5uPx6ybG9KwlM2hIYBYr2
fhMK4wqT5bDHGYRvkLrm2nSD7jagVx0as+CRqFQc2CtbFXhruy3WTPsundL8+8/J
rxItOP9RGH4tn+lrK+0WEaeYQj0exnJaaabzXFQiHp1I1mPghn84vM+ZKNAhc26f
PMu+hxiHUvGM7/5SjXcgifYDxmHdwWZibgDwFtAA5CG3LAQ2M0Mk8UJjvHMzzH4i
cnTk71xXYNfSuZVXKB/EI08VblpDQT3yGD+IAkvQsLh1L5dERiE=
=q4QJ
-----END PGP SIGNATURE-----

--VbaeChoE4AChVqkh--
