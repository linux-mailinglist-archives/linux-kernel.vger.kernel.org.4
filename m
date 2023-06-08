Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82E727EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjFHL3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjFHL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:29:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC7926B9;
        Thu,  8 Jun 2023 04:29:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-256712d65ceso241129a91.1;
        Thu, 08 Jun 2023 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686223777; x=1688815777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdZkN37ZILcUA0SzaoHvQXMR2eu2xrCGId0Fwo9xSEM=;
        b=mmeQy0RxY3/m9n1Tc/6VyHFiFtTESs1UzwRqgXK7qiT3exDguzfoKKIexdCPiK0rqC
         9QsZ0DBFkJ3R8actzla4TmiF/nJI9x5YzWwBMqOq+2HogXS9Rrg3S3a+Crp1/kfC6Gms
         9rzFvxa+ZCQrfPDU1SgjlvIaNFTS1TuDw+KhiCseC43oMAEGMDLRKvssihIl5hkDdxwY
         fhsX9LckTuvWmnfXAH7JTCwqBkE2rUmCRohxl/NMD1AZvvdMNgB/UYvQS/5pgqtJeOwA
         YR6m2OfSY3Dw9UgLFgI3GFfFgtVSN1W1ija+cNjJObff0tM3ncirGZhZZintVbsjfN5k
         rU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686223777; x=1688815777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdZkN37ZILcUA0SzaoHvQXMR2eu2xrCGId0Fwo9xSEM=;
        b=WLFdz6FR7sNlx2pGyyAK7pAGw7AFyYrx8iI8PvK3j6IeZ1trfxcB97eZq7E3vgLVyg
         Ryq3G5lCAargftXDxOkyhTwBxt2J25bmigwfR8q/VqyduBC3TMvcqwILcLghccgW/mTg
         PsytuV09WDNqxH5vukNoN/w+0tjUb44FnmFGrh4ZkUYyJNZvR5zEnv4J33/beD+48NeR
         d9ADnhxVSgeiLHhO501F2MMT6YlEeu7DMfCnR2t0/lt4FayE03YOZ4GQ6pas4Fou9gpr
         HWoBkBXp580qWsomGWNt8xsYKUp7WusBz818cKTTYkibz4mAICNaLbAXRiFhYi95IOJt
         PgPg==
X-Gm-Message-State: AC+VfDwld7QIflnjDTN3D5cQc6bmE7Gx7D9M0oQmDUHaPlU4bTbzUTyb
        tg6QFZufRfGNqLgQRSRFvP0=
X-Google-Smtp-Source: ACHHUZ7eDxuCuVIbcSWQGxEzT4I4LHuPHji8GPVD8NARhMMZTVM5qicIZ1HtLmCdXawNWuo0J8BHXA==
X-Received: by 2002:a17:90a:6c42:b0:253:749d:205 with SMTP id x60-20020a17090a6c4200b00253749d0205mr3303630pjj.35.1686223776885;
        Thu, 08 Jun 2023 04:29:36 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a284b00b0025621aa4c6bsm3056840pjf.25.2023.06.08.04.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:29:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A571C106A0E; Thu,  8 Jun 2023 18:29:33 +0700 (WIB)
Date:   Thu, 8 Jun 2023 18:29:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/286] 6.3.7-rc1 review
Message-ID: <ZIG7nTLICXoVn_08@debian.me>
References: <20230607200922.978677727@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXfqkyGF6d67kcHE"
Content-Disposition: inline
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXfqkyGF6d67kcHE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 10:11:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 286 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--DXfqkyGF6d67kcHE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIG7nQAKCRD2uYlJVVFO
o43fAQCRl0BKECL0R96Z8JXOY9Sgh8i39Rf4//oqKfag3g38VgEA/L3FNS78m5nt
0otloeCVR4Y4yfbim8cQulyUDD1SPAI=
=yZft
-----END PGP SIGNATURE-----

--DXfqkyGF6d67kcHE--
