Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673A67F3F2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 03:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjA1CTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 21:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 21:19:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAE45A351;
        Fri, 27 Jan 2023 18:19:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c124so4451977pfb.8;
        Fri, 27 Jan 2023 18:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZV9rvN4qsanmX17CVOteA9XmLzydA+MR4vpNaUfAF4=;
        b=XpTtuMZafUnig1H0QB53kDqXUzY0Bq6Z+bcc/J9wGFqgY8J/UwLJXgLuXEbF1KPkaC
         DDdulDOf60axpnyHwPecF/PdElLxrln3l66FSf3fEnIu2BLcRD47Y4uuU1YlQg5U8D+H
         Mr3iBt7Bqzu8qrEvH93lzcRO454QuyyhQuDfYMYqWL9bD4H7X3ovejl26nfjR8JQ92YC
         h072ali4AX13Fav52Pw7dHth8r3AgqvYhhReR6oSnnGj8FLM17RpnzRMd5ItY70t6L2L
         7fyvIAVhHEgwd3Wr+NDgCs9Tdy1Or/oX2kevXoIdor3httvQa2FxwYpdSeAQNhbKrmgy
         Yn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZV9rvN4qsanmX17CVOteA9XmLzydA+MR4vpNaUfAF4=;
        b=H5BEWWjzahQBedyNTkKo8K0Rz2DL4pO8QVwljBp26xLkuuyaHvuE9+5Byo9IKvQSvd
         1LSeucpmDhdNDq5WleRb3xQADcBAZ3F33JMngpQ297A8WBpY0X9nKDUS7e0sSzy6Bmsk
         3URhtcqLBiHuVjRVkIvMCV/fxxZJir+HN2guB4mmtGcx2iL9Yf51hLSEwfAKBp6AMNV1
         qhkTxQhBp2v9Qnem0wH8gZjukk5t+ZhTYh8sxEsFHE+iQFBqzFw0UwneKlkPkMJh00lJ
         2UQJsL38bQig/2oHjV962eXOa4O5DNzCJEWrvzjRMornJB/vPEDoi2u0CVjCa1aUvfTS
         W1Xw==
X-Gm-Message-State: AFqh2kpTv9AUTrUO4/ivYF/YeU6HHOyuD2hVyQHSOvv8aTi8bmSq1heM
        qIZ/5etwvRSCZSqOZXxg5eY=
X-Google-Smtp-Source: AMrXdXuOTLryPXLXoza1OZpMKsE2KUK5TESXECkJve2OdSjeLnXQC8zhe15oxjO2Z0mRQrZFAP8IVA==
X-Received: by 2002:a05:6a00:3315:b0:582:294d:f465 with SMTP id cq21-20020a056a00331500b00582294df465mr42781750pfb.13.1674872378261;
        Fri, 27 Jan 2023 18:19:38 -0800 (PST)
Received: from debian.me (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7809a000000b00589d91962d5sm3245074pff.195.2023.01.27.18.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 18:19:37 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AFE5D1055A0; Sat, 28 Jan 2023 09:19:34 +0700 (WIB)
Date:   Sat, 28 Jan 2023 09:19:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: remove useless markup
Message-ID: <Y9SGNlU88EkNY/zW@debian.me>
References: <20230127080352.177185-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M609CHVxhbOhrtYK"
Content-Disposition: inline
In-Reply-To: <20230127080352.177185-1-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M609CHVxhbOhrtYK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 10:03:52AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>=20
> Jon says:
>=20
>   > +See also :ref:`Page Reclaim <page_reclaim>`.
>=20
>   Can also just be "See also Documentation/mm/page_reclaim.rst".  The
>   right things will happen in the HTML output, readers of the plain-text
>   will know immediately where to go, and we don't have to add the label
>   clutter.
>=20
> Remove reference markup and unnecessary labes and use plain file names.
>=20
> Fixes: 5d8c5e430a63 ("docs/mm: Physical Memory: add structure, introducti=
on and nodes description")
> Suggested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  Documentation/core-api/dma-api.rst   | 2 --
>  Documentation/mm/page_reclaim.rst    | 2 --
>  Documentation/mm/physical_memory.rst | 6 +++---
>  3 files changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api/=
dma-api.rst
> index c847a5b0a0d3..829f20a193ca 100644
> --- a/Documentation/core-api/dma-api.rst
> +++ b/Documentation/core-api/dma-api.rst
> @@ -1,5 +1,3 @@
> -.. _dma_api:
> -
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Dynamic DMA mapping using the generic device
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/mm/page_reclaim.rst b/Documentation/mm/page_re=
claim.rst
> index 3fccde066436..50a30b7f8ac3 100644
> --- a/Documentation/mm/page_reclaim.rst
> +++ b/Documentation/mm/page_reclaim.rst
> @@ -1,7 +1,5 @@
>  .. SPDX-License-Identifier: GPL-2.0
> =20
> -.. _page_reclaim:
> -
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Page Reclaim
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/phys=
ical_memory.rst
> index d24220d62475..120d54ba6ea7 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -39,8 +39,8 @@ one of the types described below.
>  * ``ZONE_DMA`` and ``ZONE_DMA32`` historically represented memory suitab=
le for
>    DMA by peripheral devices that cannot access all of the addressable
>    memory. For many years there are better more and robust interfaces to =
get
> -  memory with DMA specific requirements (:ref:`DMA API <dma_api>`), but
> -  ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that have
> +  memory with DMA specific requirements (Documentation/core-api/dma-api.=
rst),
> +  but ``ZONE_DMA`` and ``ZONE_DMA32`` still represent memory ranges that=
 have
>    restrictions on how they can be accessed.
>    Depending on the architecture, either of these zone types or even they=
 both
>    can be disabled at build time using ``CONFIG_ZONE_DMA`` and
> @@ -252,7 +252,7 @@ General
>  Reclaim control
>  ~~~~~~~~~~~~~~~
> =20
> -See also :ref:`Page Reclaim <page_reclaim>`.
> +See also Documentation/mm/page_reclaim.rst.
> =20
>  ``kswapd``
>    Per-node instance of kswapd kernel thread.

Seems like I always forget to keep crossrefs uncluttered, thanks!

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--M609CHVxhbOhrtYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9SGMQAKCRD2uYlJVVFO
oy2oAQDievC9p0NAkBxHv3+wJjj7gQSxAQjUtYIH8UN5yAMRRAEAmFN0yR3TZ/OI
QMh6BTP1vsptJGbBvp+t05UUAHke9QQ=
=DVR+
-----END PGP SIGNATURE-----

--M609CHVxhbOhrtYK--
