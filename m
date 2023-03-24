Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B66C7CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCXKiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCXKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:38:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C255E3AB;
        Fri, 24 Mar 2023 03:38:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so6044788ede.8;
        Fri, 24 Mar 2023 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679654320;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECT1/Ru7wV82ugDePS3u/IWmW8AXpzFH/azNcPIPIVk=;
        b=RzqE2AQnZGhHDLwMMdp+78VXQ2QgjyazQbEtVsMB/DIoReiiYrQY3DOmbRPwLmjXbV
         xX/Ar0CnzH3u/UsvfhAykXjF7Tq9BdN02wmcNErfPEIhtHe2M6jnS0R7eTahexUCwJAm
         bnKrketFKxMGlsHyuT/qM3OUKv+D40LHlJr/VoF+jecJ54YcrE5tyCF13AzKfDRSiTSG
         wKnwP/IxIH+cqvesf+mrMlai9NHeTQgOw/Mq+/3HcbPRbbYqLixKTvWI8385JuDCCQwj
         CqcMc72Qa4zRqMTNwuii+ZCbZtqKJTWwiFeWdXrHyF/LBOrEIf5354vGUkj7bzrBvtWK
         AaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679654320;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECT1/Ru7wV82ugDePS3u/IWmW8AXpzFH/azNcPIPIVk=;
        b=KWBUf3HFKYWG4DD1PwprHVCaHUHPx5Q0NdaBwu9dhqTi2beXzHvL0mCJ9YdEVnEIgf
         B7+5lcyg8Oiu+46pU0my6jIuMRF4wwe4XODH+mTcrgdPWLeLUKgB8/xHqZKhfKOOCM0/
         nzioWQOy1m+KzFnwn740KCYyEd+T2/dpKXlq4E3p6FGh+HuQoUvKohBVy34r9YGsSj2H
         bMPw/mNBYkFUerycMXXP0r6Ox2nRWV6R45iuDs1XJ4s8vJdAWhOJtGmDMUAhk/CSm6uv
         JYHSmyZdvxddscLIU5qidEDwfa6e5F2XkJ56yqWjvZloS9X6GUUPGOe6XkbtXtyfsGzH
         rFZA==
X-Gm-Message-State: AAQBX9eMNZGW1zAblPeqthq6wrB5M6yN5iCxW9ygJmHCdOmIso12B2AQ
        LgV5MgW5R92SFY9AckbD7mA=
X-Google-Smtp-Source: AKy350YhoHLiRBo1ctGglttUmGpas7AzWt+igKKTxGZtmvo09PoGpabh9E5mLh3z1b3hamSWfM7xYA==
X-Received: by 2002:a17:906:b24e:b0:930:21a:c80 with SMTP id ce14-20020a170906b24e00b00930021a0c80mr2089595ejb.47.1679654319862;
        Fri, 24 Mar 2023 03:38:39 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g26-20020a1709064e5a00b00930525d89e2sm9972454ejw.89.2023.03.24.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 03:38:39 -0700 (PDT)
Date:   Fri, 24 Mar 2023 11:38:37 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] gpu: host1x: fix uninitialized variable use
Message-ID: <ZB19rRHIeLxyzDrX@orome>
References: <20230127221418.2522612-1-arnd@kernel.org>
 <Y/eULFO4jbivQ679@dev-arch.thelio-3990X>
 <20230308165644.GA1181835@dev-arch.thelio-3990X>
 <67f9fe7f-392a-9acd-1a4d-0a43da634367@nvidia.com>
 <ZB1xWRo0rkhku2BS@phenom.ffwll.local>
 <CAKMK7uF4tYyw6Eio6YkWZpBej1J8_5+VLU_hvVbL-Lnk06=v1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kg2CDr5zPYYVxPyh"
Content-Disposition: inline
In-Reply-To: <CAKMK7uF4tYyw6Eio6YkWZpBej1J8_5+VLU_hvVbL-Lnk06=v1g@mail.gmail.com>
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


--kg2CDr5zPYYVxPyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 10:59:23AM +0100, Daniel Vetter wrote:
> On Fri, 24 Mar 2023 at 10:46, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Mar 08, 2023 at 05:28:06PM +0000, Jon Hunter wrote:
> > >
> > >
> > > On 08/03/2023 16:56, Nathan Chancellor wrote:
> > > > Ping? This warning is now in 6.3-rc1.
> > >
> > > Thierry is away at the moment.
> > >
> > > David, Daniel, do you want to pick this up directly in the meantime a=
s a fix
> > > for 6.3? Mikko has already reviewed and FWIW ...
> >
> > Generally first fallback should be drm-misc maintainers (or anyone else
> > with commit rights), but since this fell through cracks for weeks it se=
ems
> > I'll pick it up to drm-fixes now directly.
>=20
> Ok I think I found out why this fell through cracks, MAINTAINERS isn't
> updated that host1x&tegra is maintained in drm-misc.
>=20
> John, since Thierry is out, can you pls create the MAINTAINERS patch to
> - point at drm-misc git repo everywhere needed
> - add any missing host1x paths to the drm-misc entry so that
> get_maintainers.pl adds the right people for this patch (currently it
> doesn't)
>=20
> Also should we have at least a 2nd person for tegra stuff (or well
> maybe nvidia stuff in general) for drm-misc? Currently it's just
> Thierry, and I don't think that's enough. Whomever gets volunteered
> please follow
>=20
> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm=
-misc

We never actually moved host1x and Tegra DRM to drm-misc completely.
There's still a separate tree that feeds into linux-next. This made
sense a while ago because there was a lot going on, but development
speed has decreased recently, so we may want to fix that. The big
benefit is that drm-misc is better oiled than drm-tegra, so getting
things merged would be easier for everyone.

I'm all in favor of adding a second Tegra person to take pick up the
slack when necessary.

Thierry

--kg2CDr5zPYYVxPyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQdfasACgkQ3SOs138+
s6GJTg//d12Nx4SOSj062aViq5Ogt408l+g2R+09DBr0O/NW9IoUKKRq7fCrhw9P
JLcHXdUYAgr9WylfV2Y/KVkd2zIVOUzmwqtM5S3knJ2WYZfLV9X4R9H2dOqN4YrL
uVxLeQtZB6NRAZMZeg0YnPuS25Lx7gYbK7GqViItayAlhqx0lbpYM3LrjSeC5cwP
W2scYiTrwByz5w6VFizFUztlZON8DrAEJ9+PcLWDjVzJwTl6cfvRRimkj9A380XK
R6YVZpNGLy7Jlb8i/UayquMrl9YzJh6oewgDLnM/ckx/Pq0KWs5RH/wKRTS+9tX6
y9FFrf3WIc0oz/mK7A7T9hW6Vno7Ys1N+RYxCENLdruWODQfjAeB23C+k7O8dckX
yVJmhRSqBRBfnnsMursu9le1/m2ahXjTuch6rNlBWdXgiWlgsOtXqCCwo039C/al
DrLJ6FtY2qftqjOFZUFvdArFPIER9Qrki1UFyBEOVnKdw7RFvs8iht1nXi7Blqny
R20SUVz+U8ptBV0JvxPa/IjuRw8G+pE0pUHv73FmArI+oVO+uSilaLqVZLYSKZqo
02sod/iBFkbic92VT8zItvb3N4fvYE+jVyHAPG+YuaqXfRdYFZTcm1mcETw5omll
i5PFlRnImLAvtl6Uz3MEgYCs/4jvWUnxKlA+8KV/JtcM7XfrgwA=
=zSBl
-----END PGP SIGNATURE-----

--kg2CDr5zPYYVxPyh--
