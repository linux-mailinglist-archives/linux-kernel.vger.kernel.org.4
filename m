Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CEB606272
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiJTOGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJTOGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:06:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA716A4DF;
        Thu, 20 Oct 2022 07:06:46 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q19so30072361edd.10;
        Thu, 20 Oct 2022 07:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjifGQ4JE8DLKxsqx0+XuO/FFbQ1yrdr8HMQtyJ7Xe8=;
        b=FoBW2jJmQgdnEV7UaIIbo9+nGOt6W6p6e3xj3va03ld4y0dO1OU8nF+dcxDK6Dd0lE
         ovSo0SrOGe9cmsoclo1wEeud5p4pEvBrAqwEonwqw6Eqo4qRLI+ovvbQCHaVcypRhlb+
         JQotANSxZ0oYXqU9hOhfEAS67WPsG2L3jQCGREwZzEcyq7m6Go/gcr6ugAaToc3v8eIq
         G8SQ8FC/KZDO8Olm/Qi9jBjPWupRKHYWl9re+g9btMHugcUam8JBMXp/jZ1Fy7oylf+e
         8fB/IcCOFjaDA2CrfC/2nxwUN/crN6fzL8EGgAnxKYmL+BzRUMLvbSxJLrY0MXIO5ehM
         U3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjifGQ4JE8DLKxsqx0+XuO/FFbQ1yrdr8HMQtyJ7Xe8=;
        b=lCuwFY25HYrvX7r9cDjsgEOz595JYa6cgDVt2hzPECe7d1wcLOkD+CR2m+F2Xn4kLI
         EQ6mZXyjAmLN8xdLi49e0OONGi7AvKpHou/hwpG0rrcIHu5EaotihtjpwBpAfuwpY8Px
         BpMka4eYrkPDlBoXeSLr+4nZoY7uQ2RynwTUiWf8Cv6R2XLQPmjhDXvjD3QOKEgGwqu7
         goGLNazNn/FwY32YLrsDn6LBkGhJEt3/V8UeJrp047ql36AnOY+s7/AkHchp+NGmYzKG
         VxHmPWf+VXXpvbExBANo6LMZdNJ7mSCqfsiUF7RC7cxZkjEMZrZ3vsYwLXCw2WX6i/fU
         rh9A==
X-Gm-Message-State: ACrzQf2IjlENZFTm7nz2V6WbdMCh6k6druU5Pxc19m+bw137iZ3F4XKJ
        wo8EEV+KknInbMSO/i0p//Q=
X-Google-Smtp-Source: AMsMyM532n48vLbQUX2qWMsiOiYga3di18Bp4/joWO8yyB5v81QapbyGSUyGDt3cVa1N1wlOrXKE3g==
X-Received: by 2002:aa7:c6c8:0:b0:460:e19b:ec12 with SMTP id b8-20020aa7c6c8000000b00460e19bec12mr2014910eds.209.1666274805145;
        Thu, 20 Oct 2022 07:06:45 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906308f00b0078d4e39d87esm10316603ejv.225.2022.10.20.07.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 07:06:43 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:06:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Olof Johansson <olof@lixom.net>, Kartik <kkartik@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>, windhl@126.com,
        sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc/tegra: fuse: Export tegra_get_platform() &
 tegra_is_silicon()
Message-ID: <Y1FV8TNkYUUcWbFl@orome>
References: <1664186759-9821-1-git-send-email-kkartik@nvidia.com>
 <Y1EavIxVymPSfwJC@orome>
 <b6c37fd4-d9ca-484a-80c2-d4b6b05c77cb@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UunOC0lUIQp7wYUv"
Content-Disposition: inline
In-Reply-To: <b6c37fd4-d9ca-484a-80c2-d4b6b05c77cb@app.fastmail.com>
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


--UunOC0lUIQp7wYUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 11:57:39AM +0200, Arnd Bergmann wrote:
> On Thu, Oct 20, 2022, at 11:54, Thierry Reding wrote:
> > On Mon, Sep 26, 2022 at 03:35:59PM +0530, Kartik wrote:
> >> Functions tegra_get_platform() and tegra_is_silicon() are required
> >> for pre-silicon development to correctly identify the platform on
> >> which the software is running.
> >>=20
> >> Export tegra_get_platform() and tegra_is_silicon(), so they can be
> >> used for pre-slicon development of device drivers and kernel space
> >> tests.
> >>=20
> >> Signed-off-by: Kartik <kkartik@nvidia.com>
> >> ---
> >>  drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >
> > Hi Arnd, Olof,
> >
> > can you take a quick look at this and provide some feedback regarding
> > acceptance? It's slightly unorthodox because the only in-tree users of
> > these functions are built-in drivers and early code, so they don't
> > technically need to be exported for strictly in-kernel users. However,
> > we do see these used quite frequently in pre-silicon development and
> > having these available upstream would help with internal kernel
> > transitions and so on. We may also see them used more commonly in
> > upstream drivers in the future.
>=20
> Hi Thierry and Kartik,
>=20
> Have you looked at using soc_device_match() instead?
>=20
> As long as the information is part of the soc_device_attribute
> prvoided by the soc info driver, any other kernel driver should
> be able to just use string matching to get what you need here.

The values that we stash into the struct soc_device_attribute for Tegra
are not very useful for this purpose. If there's no concern about back-
wards compatibility, perhaps that could be changed. I could imagine that
we could store some "simulation" string as a special case into the
revision attribute. Any "revision" that doesn't match "simulation" could
then be considered to be "silicon".

We don't populate "machine" at all it seems, but I'm not sure it would
be a good fit for this anyway.

Kartik, Jon, I wonder if we're really also interested in the platform or
if we export that primarily because it's needed by tegra_is_silicon(). I
see derivatives used in certain cases, but perhaps they can be
represented by other special "revision" strings?

Thierry

--UunOC0lUIQp7wYUv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNRVe8ACgkQ3SOs138+
s6FuAg/+L3YAYp1XoHPsqbnFZ6WHBxgfIEHqtAu4oY4+BIVuDeWq0HsFYOdldaR1
p+Cg2ask628ZMbKhtAZZMj4luG2N+K+9YFM0SyftIwMTOEaN1YPVtIyHDrbKRotK
YgV8jF8trxRzOhfxrnAau9SNv0TMAbmqGK3BUnUSl5XZIn7IKKTEhMbpIZo9Y5Ws
WXD9xW+f0PEvms0x2iU/O1pxa6R+a6akYgIcoyaTLjY99UvmhMtc7X/DreXmDVA4
IOh9a8zCxLXGETo4u361TESQt0ai/KEVL/OG14sYjblTauvxomt1C382/VOalfsU
SYBTwRy/6cpXO6fo5fu24hT33dN3PdpRK6soQ4edwdUSEHJJj7/IGI9IuT/Voyd8
VuLOKGxlJ5UPyK3M7A3paBLCw4no77fUtxn4Zpe33XiFr1cL8hgIdlbaik4udFO4
qEirhZ5xQdRJBEfWAcB1Oq7uK1omaJEaTTANPB1vdB4G8iS21VH3hSeU+0drOynY
bQDabB6RBaZVMOIXy8xQxddfp8byX0bl0u9M0Ei8kPkIt+tgmESWZ/FZrcPrh0RJ
KYAdoa17KXT9BF0M78UTRQaqUQfAo+t70SmSYMNrAkv6HjCa5nc4Xwg/c+PUNfWX
TbV2WOtX99/VX+1oQuoFFwgS/9aPJt/M1fg1A2Obnrf0kQr6kcU=
=nZQK
-----END PGP SIGNATURE-----

--UunOC0lUIQp7wYUv--
