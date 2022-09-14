Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6542D5B8576
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiINJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiINJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:47:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E0F63F3D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:47:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lc7so33483176ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NPNk/KWqAXxjBKV05Yg3xR69jYiK/EQQkvoXdLziwaM=;
        b=KW4DcZuqBmtvLR2DEq59YjYuAJDYlXZW0bXJ7xaS0KYZtpD8d60UvTzMM0iWceL7oM
         JsNiJMObiQhiEMsBbRmYZ7PPcSYKIDTXQ/tDhP/Gspboez2SRSHKDThB9bCgciVgWHrr
         5lw45PEIhXjPC7a3MLcvWcCq5j1+JWpJBm05CT0ymjjmekuCl+omVyclGFtd6ZuB3D2r
         wLwwOL65cE3j2EzGqU1+Eir8Up6YvOHrHdJ9++DNRY+CxS193iub0q7ElzRlgCMCfX+h
         kB37uZo7JYKf+dRBA9F9eGkV0fEd6m3LN7qprgrHj4vCLrtnmo+GplbTu7TiBRt7uqHv
         zLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NPNk/KWqAXxjBKV05Yg3xR69jYiK/EQQkvoXdLziwaM=;
        b=NcrXk1p21rpRInjXUDns5Tj3dANiUp0w7QmdgMVzfWW0KsVecHKD/XM2eE6UGIU75q
         qly4PdBkqlZOvyUyn5dWoT+rklDEyl3OEXMNEV1qal45KlgPjKlmhJTu40+XPKweEdpJ
         lJYLjEmSpTmNfv3gmvuOF6BT8Aaca6LdQb4VyfPaCIBu+pXHGsLrwwul8zFmsFHjlu+P
         qby1/XnUN7WnaVTwIX2Ec138HZDI+tRdUbmJ/XCfyG+poU8fShDZz1XNM1936gTkhre3
         qehvW248AZe6UIrQDzQvFYMR4aSsFN5yqaDp6Lshvr2lB9SAWQlIGTOWp4DNpqENzdUX
         /8oQ==
X-Gm-Message-State: ACgBeo2AosIc4W+g4roXDulSFCQ9AYxSol6WEYNuQcoisr353V+J8H7s
        iI/fg19BcsVHc7se4vdGMD8=
X-Google-Smtp-Source: AA6agR7vc4cGQ0TauFok98WzX2UKxOSmjo912JTdce1IL4HRSP6lms/sM4Cq8lOKT4ORZrrlChSgzg==
X-Received: by 2002:a17:907:7215:b0:780:3153:cca2 with SMTP id dr21-20020a170907721500b007803153cca2mr1836405ejc.427.1663148865591;
        Wed, 14 Sep 2022 02:47:45 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id dk9-20020a0564021d8900b0044ea683d04csm9481113edb.14.2022.09.14.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:47:44 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:47:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Message-ID: <YyGjPoM6ooNeJKhT@orome>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
 <4740744e-2e12-520d-8598-188b8d2ebd6b@huawei.com>
 <38988c89-ec61-faa1-6b15-2fd3aa51eede@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxiM4cf+GB3fdexT"
Content-Disposition: inline
In-Reply-To: <38988c89-ec61-faa1-6b15-2fd3aa51eede@arm.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxiM4cf+GB3fdexT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2022 at 03:15:18PM +0100, Robin Murphy wrote:
> On 2022-09-13 14:01, John Garry wrote:
> > On 13/09/2022 12:47, Robin Murphy wrote:
> > > IOMMU_IOVA is intended to be an optional library for users to select =
as
> > > and when they desire. Since it can be a module now, this means that
> > > built-in code which has chosen not to select it should not fail to li=
nk
> > > if it happens to have selected as a module by someone else. Replace
> > > IS_ENABLED() with IS_REACHABLE() to do the right thing.
> >=20
> > Hi Robin,
> >=20
> > Recently you mentioned "I wonder if we couldn't replace the IS_ENABLED()
> > with IS_REACHABLE() and restore some of the previously-conditional
> > selects", and pointed me to 84db889e6d82 as an example of when a
> > conditional select was made unconditional.
> >=20
> > So will you also restore some previously-conditional selects next?
>=20
> I figured I'd leave that up to Thierry (and/or anyone else with a vested
> interest), but having mulled it over since that previous thread, there's
> really no excuse for the API itself not to do the right thing either way,=
 so
> I felt compelled to write up this much.

On Tegra specifically, as the commit message says, we don't really care
about the conditional selection because practically we always want IOMMU
support enabled. So instead of adding back the conditional select it
would make more sense to select IOMMU_API instead and then get rid of
the handful of #ifdef blocks we have for that.

On a side note: I'm looking at a subtle regression right now where some
corner case no longer works and that's primarily due to the fact that we
can have four different scenarios: non-IOMMU, IOMMU, DMA/IOMMU and IOMMU
but devices with no iommus property in their DT nodes. This has all
become very unwieldy and becomes increasingly difficult to test. So
anything that we can do to keep down the number of permutations is
welcome.

While that's not directly related to this issue, the lesson learned is
that, at least on the Tegra side, we have in the past made things
unnecessarily difficult for ourselves based on the misguided assumption
that maximum configurability is key.

Thierry

--wxiM4cf+GB3fdexT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMhozsACgkQ3SOs138+
s6FWXw/+PHWdbXa32ZnwndVQaRUolrlckoZxu6Zna5i4/G4JMrLTHtebY+3qNguZ
kuDNz42qizMH/XB138WCGZ6715CVOExNaW6Rqugu3gemSe6k7/aRZPcZ7Hw6Fn83
HDXiY09X4notns4v5nO6bnFIv+Bb5ZIS42yngcvi8yrdhm/wmzr0GxPBH7GY5cSG
gU1JcwyxzFDKsyWely/U2G6+11yzuuxuS3vraGpEL+fZEd3XlCts08kyL0bdrPbo
kSXmE88eMmq1yS6bTiro13gjbO8ar4NBiNnoaYMNJEGjA9cLXxZvETUH1Ka9nyHC
bTj1BeuG5JM5Rdky+uMHGgYRmA+kXp2cI1admgoo5sX4k42xD31WAHDYTCNba0TN
GIJF6mbfWj4Kq7F6RuCA+QQzT+W+Gw0V13xprLHFZHtUGnlcV6GtpXeeTpEpjQs7
6HFRSGri/H7YZiFILLnU0O30nSqSrzLn7NgdiGfGGUsKJM8tyGeBro/cYlbprMMA
NTFL6j/tHO6A/mAdVLxcPMAKheXrP+jDKdVptrEzwxRQ9UM7NtMrXfv+bHRhGUZA
oLE8iS99gktA1TaOhODkOmyqInt6+HvZe2C92YTGt+psQNsX58sUolPOI9GCTDCD
0h5T+ykW9TG7U+ZcVlApvAS0wE7U1zXdfDzTRzjJcCzrXPEGQjQ=
=OYgt
-----END PGP SIGNATURE-----

--wxiM4cf+GB3fdexT--
