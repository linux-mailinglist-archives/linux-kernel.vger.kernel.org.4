Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3B727EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjFHL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFHL2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:28:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6302426B9;
        Thu,  8 Jun 2023 04:28:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b02d0942caso1862475ad.1;
        Thu, 08 Jun 2023 04:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686223690; x=1688815690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR0QghZNj2zTc0D2V5r40rM8DIgSPHbR48m3RRcLmCM=;
        b=n5H0ExkkA6IesCR64tBnnqRJF5/XFC96mu60Llj4lEj9pc2Tv7+NsDVWs2Rb83mMb2
         SQBZ0OFZfq4DvBF0deyr+KtvlXmwQf3lt//0w6TV0OMJs81DxY4l46FvpulqLc47RfhV
         9Ecd/BsObGdwsXzjr5aaSep8ECcau+QWyLJC6F4j6diXKNQ7ct74oh/FthB8uq4bDByG
         awx3Xppvm6IRgd405MoYvfqYPIILxdo2ha3Ms0IiHatIM9EwsgW8lQz1IirapMZAQAn3
         rGeq4knvgQ6BO++401Es537XCe9isZyIRUxMJxFXXz1n7mNSPaM5F/x4DI+RUnw8ReIC
         PSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686223690; x=1688815690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR0QghZNj2zTc0D2V5r40rM8DIgSPHbR48m3RRcLmCM=;
        b=bkTM/HFEg1d9y+//1UHx178qVyMmhPMedu09HbkstS5Sa0ZPM71zaXUjg+091fOnfV
         nOga+PGMK/U2k3HX/csAv3M5iIDDXfslxjwwCQmZckJLKgrHkAmefapABaSTsTwQW/CK
         c/GRhrvJBjsYsssaOeEwHKq+ME6bYHhMjlo1M+nU2CWknyFdJKn5aE8NSAIMJl3b/Bl7
         3EKp9b1EZSzTC8CkRRcT4PaNlaWPqHSORzQy3y7FtInEtCKww3/Dh0mfpBdtvXw5NcIO
         6g/xdbIsR4Zi3vltpZe1TYlaNS1q5KtUjOzy1TW8x1Xn1PyXc3oB7kpivygnMJ9xXskk
         7uZQ==
X-Gm-Message-State: AC+VfDwOeMY/x03QiuV3gaPni9dlmlVbUkRfJFglzIJYA5/e4mgxNx9U
        2Hds+oZvoQNfG9RMqN3MskE=
X-Google-Smtp-Source: ACHHUZ7S+2xH0uqwOZNdKwuC2d08iZquDkW3swDSyQsscIUOAeyAbZenZaksV1hZTo24O0Jqg13jPA==
X-Received: by 2002:a17:902:ecc5:b0:1b2:3d0f:be33 with SMTP id a5-20020a170902ecc500b001b23d0fbe33mr4533385plh.27.1686223689718;
        Thu, 08 Jun 2023 04:28:09 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-16.three.co.id. [180.214.233.16])
        by smtp.gmail.com with ESMTPSA id jk8-20020a170903330800b001b0358848b0sm1222348plb.161.2023.06.08.04.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 04:28:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 456FC106A0E; Thu,  8 Jun 2023 18:28:05 +0700 (WIB)
Date:   Thu, 8 Jun 2023 18:28:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
Message-ID: <ZIG7RAcyKAXqF_TG@debian.me>
References: <20230607200903.652580797@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c313YtrzuUNFtKdY"
Content-Disposition: inline
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c313YtrzuUNFtKdY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 10:15:03PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--c313YtrzuUNFtKdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIG7PwAKCRD2uYlJVVFO
o7E+AP9D3UNFQ86+a4pFoU5JXlMfXixRpZ2k6jdv2V4jTwOqFAD/fh+JprL31ynZ
PPKszEiBLcHsAyHEJjZOwhIqXYCeowM=
=AnWe
-----END PGP SIGNATURE-----

--c313YtrzuUNFtKdY--
