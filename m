Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A1C669110
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbjAMIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjAMIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:34:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792C47324;
        Fri, 13 Jan 2023 00:34:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so26286927pjk.3;
        Fri, 13 Jan 2023 00:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j77PGYqYJn6fj2VF6XY1qynbAo3cIFZ7iaf0qNN3ZTU=;
        b=adhX4rmmJBkXWjL/a4iswXOC9rzFBPTwR8XZNp1cZQZbnp6IRjpIMxWsf/BXEqOSei
         Di4zAyZ3D/GUeHc+0XsyBsnzC4ZgoIUlGS5ZAHAOytsG9VI4/67yer7DnI/nY1rFOBVh
         GC/q8x6zS1Qj49e4iWciE4uC4JgFe7jSucS/yRuKEmkNjmTdtD3v2DF4hSGiVPWu6LBH
         lHzXZX6hWjZO5ZRQuiY5EZpGfPdhBGy45N8crsjoviFCXcnbABRElwK2xf0lMlzYxXH1
         aBgvsczAT/N8NLdD3hatzCdhmua0BxqVTW6mhjxRreq+dObyFRQSwAIDVOvY3yUA2Uq+
         DoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j77PGYqYJn6fj2VF6XY1qynbAo3cIFZ7iaf0qNN3ZTU=;
        b=kPdI1yfXXXWEugq8YdefVZRVy34XlZsptsD+b9eEm4NnPHcitKxnrjPvV9qyIxJFii
         PuhRu01GaijK+4mr4TrTMG9jjis+yTqFTZR3Ylh1TvZmIFHE0e+9fCwslAChUCf3VQFN
         h9j6nvti6Q1eQRoD5NWRSZr3m5PPEDcP3g/FE9DRv3TIBFczg6C8pd4aeS1UbzYRT6rT
         +nnd7iwUEPzhUHhBk+rmDsj001QCbwpwmY5QfHXb9/F/6tV3uJBYTRChQRb8qe3jGoId
         EkFhiJf+9BFp1fduCuM/hzOVL8Ap2ZkaPrtMmWC7yIH52DYIZ/Gy2PdIPSgMXMc61ZIa
         xIRg==
X-Gm-Message-State: AFqh2koGQV1euIuZJlAZU/tvQ5EaOJO/rnUsJeZl/w9atJe6rbxV1whn
        4vCrsHNIl2rAQO4uPXDR62c=
X-Google-Smtp-Source: AMrXdXt3JUopvLVybbNRplMD4EQ8RxFZx+6SOs27uJf6lqYqBckodqAApAF0Sn1Ufdq2XYTVzg1g0g==
X-Received: by 2002:a17:902:f78d:b0:192:ae36:f760 with SMTP id q13-20020a170902f78d00b00192ae36f760mr56126788pln.47.1673598880311;
        Fri, 13 Jan 2023 00:34:40 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0017f73dc1549sm2762362plg.263.2023.01.13.00.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:34:38 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 80776103F81; Fri, 13 Jan 2023 15:34:36 +0700 (WIB)
Date:   Fri, 13 Jan 2023 15:34:36 +0700
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
Subject: Re: [PATCH v3 3/3] docs/mm: Physical Memory: add structure,
 introduction and nodes description
Message-ID: <Y8EXnMFoYLscVxru@debian.me>
References: <20230112091616.824565-1-rppt@kernel.org>
 <20230112091616.824565-4-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C2A7EoUsUIXm2M4R"
Content-Disposition: inline
In-Reply-To: <20230112091616.824565-4-rppt@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C2A7EoUsUIXm2M4R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 12, 2023 at 11:16:16AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>=20
> Add structure, introduction and Nodes section to Physical Memory
> chapter.
>=20
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Seems like you forgot to add my Reviewed-by from v2 [1], so here it is agai=
n:

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks.

[1]: https://lore.kernel.org/linux-doc/Y7%2FVLTiPSkSulj5D@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--C2A7EoUsUIXm2M4R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8EXnAAKCRD2uYlJVVFO
o7MzAP9dXjNOuSJXgDjXB+/myd6Ze93HXrJp35WFHBU3fNriYgEA0t2unLG0WOxV
fVBWEnkNh+N1ijls34FHZlpyOVNtfgQ=
=1gD5
-----END PGP SIGNATURE-----

--C2A7EoUsUIXm2M4R--
