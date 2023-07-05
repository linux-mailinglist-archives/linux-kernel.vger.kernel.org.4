Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F589747D76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGEGuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGEGu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:50:28 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B819AF;
        Tue,  4 Jul 2023 23:49:50 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7658430eb5dso678651985a.2;
        Tue, 04 Jul 2023 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688539789; x=1691131789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN4dJ8uJf+yfpLbNOPBTsXnaH4U3xyC1VSZoGX/yD5g=;
        b=m4T+3PxA8HKfBr2TtZ/oCxC/7I+nwE60cEOIjA0Akxk2fo9u+kXotl/Y66pyVMpYy8
         iKdcXwMg1fGYqsgHGd7K1+wViX3AhH1x4gKM3cbCHomNoVLKvz2wQ/ASV5YU/ZPA/cOR
         H6brhmnxUTUIDsMPUiW4AsY4RltaoK7d2+L7RY9R1Df+bAPqeejptgmtO8x+zyipm/3B
         nHQyKxILNe/MUeIn8t/U4cdUz90v8SadkxouoS6yryYeOpkvmKr2ub4VNJgWEmmf4f8G
         NgHdpM52h07tHqnAL7pH0Jl7vNjXI4n02ht0ImkuECqbTi7WllRuCWYCSMYoTM79YP4V
         ZdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539789; x=1691131789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN4dJ8uJf+yfpLbNOPBTsXnaH4U3xyC1VSZoGX/yD5g=;
        b=JkdCCeOfQKGnvs9EyyxsVctiS9iwCltlj/7oRXsDm7bt3tqH47lj4Yi0EnqJ8LElMJ
         LZaU/5eQ1BAgOwxwX51Bw648Fr6e/pnLgJZZjTgcLWWbKAKcm8TUBoG422IKqxHsejpH
         Fx0SrzL78IzNqTdhjCz6MyhA86E6e0fOZHKfDwaqKwy8qpsSequ3sclC4uc5kc5iMAnr
         juG/iLw/9kYKWgZtw1Cr9uc5A9ujMYyS15Nk1fgx69kWTLhT/a5gA0BxnHR1ntgPaqzP
         tFRv0gjPrLIltVm/a+6WrCJtkG5eRblGJHVdisbecU/C3zatIwFr2L6z0DXq1ZFs9BvO
         sPSg==
X-Gm-Message-State: ABy/qLbmQ26VODr9LKkp+riBX9Vbghsk2nDk53kICcnKHo+XVtYbAaZY
        GgOpbzoT8zpftEUhxUfumqY=
X-Google-Smtp-Source: APBJJlHKocwWU4up8nA4Gn1I7Nh1oYffL5uD+Ha03luBbt7pFqLDhuLz8yNEvDhyLcxugjHdl0J5Ow==
X-Received: by 2002:a37:f718:0:b0:766:fd2c:fca1 with SMTP id q24-20020a37f718000000b00766fd2cfca1mr15674220qkj.75.1688539789332;
        Tue, 04 Jul 2023 23:49:49 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bn10-20020a056a00324a00b0065980654baasm16591235pfb.130.2023.07.04.23.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:49:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1B2D3808759F; Wed,  5 Jul 2023 13:49:43 +0700 (WIB)
Date:   Wed, 5 Jul 2023 13:49:43 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/15] 6.4.2-rc2 review
Message-ID: <ZKUSh0p8ynyFCG4n@debian.me>
References: <20230704084611.900603362@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5eonTzacrvwGSkuM"
Content-Disposition: inline
In-Reply-To: <20230704084611.900603362@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5eonTzacrvwGSkuM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 09:48:24AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.2 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--5eonTzacrvwGSkuM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKUSgwAKCRD2uYlJVVFO
o3uiAQDbj4eI9kQDllJlbiIZXvqitq2jET2swj+CoKrC34S6/QEAygBCFW5W6ort
46cTN7NMFBFj8fuLvf4fvc9Z52VMkgM=
=Ag84
-----END PGP SIGNATURE-----

--5eonTzacrvwGSkuM--
