Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100D612309
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJ2Mvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2Mvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:51:32 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF097604A6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:51:30 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e4so7001089pfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgDXgk7FuLqSjYSHTukmMPrXTG+st9OsjiLo4n29idM=;
        b=JO2jd1Z/NOyQgrbn16cqUV0itG+chsiubmruSnr+e1dZ3/92RrvAQzLg895WyS1Df+
         fWjlV6JpaStCXG/TYmpcd9VZ7CTYGiCkRL3Jrfw3I9V6MFBP7vUj/A24EIY6bdwDKojf
         bGgEQ3hqHZa+IhaEbPP1ZxZVqGlguDgU0QKbn9wvxKezXn/ZlDw+1oOS8doRGHEeXfIB
         mKtBRaePFwU122Xl+cq8gVbhaOG4B5eZ+wh4w/aVI69jDQXI1L7m1asqZIe3tTEyEorP
         t56wD++WXZwmyXSsTAyP1wn+GjiqyM9lGrpXLxmTIjWXaaZrzUYYTt759hrXEX9ALYl3
         cEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgDXgk7FuLqSjYSHTukmMPrXTG+st9OsjiLo4n29idM=;
        b=ntILUWUf0FlTRsIaNrhJKZW5JzQWPqQEaPP+o80eh5ScC1CKVudbaTFFM9060gGVOc
         V31IOqnrWQBuOkdF2ZPSdwGIjktC/QaSkyercf+7L5xBI+Zjlnu6fgaBjQlRiW/prXrT
         M9pEleUWhsEwontep/Iyv1Q+uKbMpPNa9z9yFularoY1na/BdNdc7CvFFjQU4Ep+yZpB
         uo9p+HbOKtsC+iHdezA5/ypz4KpkOGsRqTNQhbr5BF4/bsnYHHrvYIBCmFD/PM59BhyV
         pWw6TmW+ma9nbgb3gyRg2XpGxjGHT1D1hl1RyDZFBtOscW9hP2JN3iljtLfDTKakkppC
         pCAA==
X-Gm-Message-State: ACrzQf1BpWGMbxx6/wHfQMyw5/a+EwBkvkB5plQJBRWT2oD9rk3uy2x5
        WG+lfwFJ9ivsoI3b/VI6ADaCnlXkq1qFAQu3
X-Google-Smtp-Source: AMsMyM7Rizv+baGEcTKQ8pAHACKrvmaPnpMPXQuqYg4YWPbpxCN53T9CV9ybXlwAaUo8/Qr2nQf2KA==
X-Received: by 2002:a63:d66:0:b0:46f:8979:30e2 with SMTP id 38-20020a630d66000000b0046f897930e2mr1552827pgn.348.1667047890231;
        Sat, 29 Oct 2022 05:51:30 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b001769e6d4fafsm1233440plb.57.2022.10.29.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:51:29 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DDD9E10169F; Sat, 29 Oct 2022 19:51:25 +0700 (WIB)
Date:   Sat, 29 Oct 2022 19:51:25 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: delete rebundant word in comments
Message-ID: <Y10hzXgvq+djdQEH@debian.me>
References: <20221029100431.10825-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6r8c1Np5+DOCagk8"
Content-Disposition: inline
In-Reply-To: <20221029100431.10825-1-dengshaomin@cdjrlc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6r8c1Np5+DOCagk8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2022 at 06:04:31AM -0400, Shaomin Deng wrote:
> Delete the repeated word "that" in comments.
>=20

Meh...

On what comment?

Also, on patch subject, s/rebundant/redundant/.

> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 27a3f29c0181..2ad2fec6ed3f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7053,7 +7053,7 @@ static int balance_pgdat(pg_data_t *pgdat, int orde=
r, int highest_zoneidx)

Ah! You mean balance_pgdat().

> =20
>  		/*
>  		 * There should be no need to raise the scanning priority if
> -		 * enough pages are already being scanned that that high
> +		 * enough pages are already being scanned that high
>  		 * watermark would be met at 100% efficiency.
>  		 */
>  		if (kswapd_shrink_node(pgdat, &sc))

Dunno if the comment above is right.

I have already say to fellow @cdjrlc.com people that you and your team
**IGNORE** patch reviews. If you don't reply to this review, I would like
to just say NAK.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6r8c1Np5+DOCagk8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY10hyQAKCRD2uYlJVVFO
o4+DAQCjYXNm0mExgM3U/s8wV2lQP8WtQJNh7b/wCItI6EbYqgD/URc5d3dY3LYd
7gTUdFAbOY7i8ebUoZRi7Fmvv5F90wU=
=gq3T
-----END PGP SIGNATURE-----

--6r8c1Np5+DOCagk8--
