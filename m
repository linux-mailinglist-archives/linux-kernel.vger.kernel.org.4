Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6BB6FC36D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjEIKGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:06:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753652126;
        Tue,  9 May 2023 03:06:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64384c6797eso4587027b3a.2;
        Tue, 09 May 2023 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683626775; x=1686218775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rSHR0ehtB2U6yMU0nFNA2cGE1gtgPOWWyVaF76Frhk8=;
        b=Vi1G1NAKv9XWgPjE7QbWiX6BlpCxh9Ni3BopbDive+HIIjZbGW7FE7U108+iq6i7S6
         C/a1ej6xB+ulyDR7HiP+yXHg81X/j+Ooxig2TD+AN/NfAuHsEsfQpRLcfW36lZJ+jx2O
         G04xxxnaUToXtkMrgcWhRgvrnx8RbBJZY4+ZHWdczzKZRTI1TXQQf8jtuYEMKoebceZC
         qVygZPznG/eRY8P6ZV6B6uLI38ow4fHNB0Wh7fsYiPlTr2tI/X1Pzr9X6J6TV+F12BHd
         ZNiaTaFNsrLxaHYshT3D8EO35F/wW6dBvU2diBxUJcub1mEUAOqJ+0Pz47xF7NQacau9
         uQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683626775; x=1686218775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSHR0ehtB2U6yMU0nFNA2cGE1gtgPOWWyVaF76Frhk8=;
        b=fTZh7bXWi5UV3+wsVeth41w+fEBpXZYmkluKRs+i7AdU/EAHiUSsur+ekBzxftLllx
         OPKtBI2AufxlZFoZ1vtLQI+8Qm4rkIUzzFWg5fTn0K6oy0hloN8wVLtQwWMwnc5P4lLI
         qVIHMdVf/TaO7FwW6gWgMCMQ5DmKcDk3/riUOriPy7CDFgdMfMSCzREp5K5Mstna2Y1A
         0wXz6rXNLaVQmwVq8hrcqj9abGuFK4VVLnPWKdU6NvRkmZ6U0LRPXZqqzug+bmTAqBRL
         VEISJGfXjiDHKEhDZ15/rodlysQ1Nsw2eWZs6m3zPhOZf2YiwuvCUdvHJc1vA/AP9ku5
         3i6Q==
X-Gm-Message-State: AC+VfDwJxOPcFR798ZcdLosLI72athkwWJGvr/XK7+YyBEBT8yekLPs2
        mb42qSAE4Y6Xl7Edm3i2C/w=
X-Google-Smtp-Source: ACHHUZ652st2RqBIyIOxPTtzqMCXN3fTicm9MdVndNcyYFPE2GW2Cw6lX0OD7sa2m2xrZX5ffT0ivA==
X-Received: by 2002:a05:6a00:1688:b0:647:5409:5d08 with SMTP id k8-20020a056a00168800b0064754095d08mr854975pfc.17.1683626774849;
        Tue, 09 May 2023 03:06:14 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id f17-20020aa78b11000000b00642ea56f06fsm1460696pfd.0.2023.05.09.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 03:06:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0207D1068BA; Tue,  9 May 2023 17:06:11 +0700 (WIB)
Date:   Tue, 9 May 2023 17:06:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <ZFobE/Zo8FjJ/o+P@debian.me>
References: <20230509030653.039732630@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4sHR0uTJkFkorbG"
Content-Disposition: inline
In-Reply-To: <20230509030653.039732630@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4sHR0uTJkFkorbG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 05:26:31AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 610 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled in my computer (Acer Aspire E15, Intel Core i3
Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--k4sHR0uTJkFkorbG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFobEwAKCRD2uYlJVVFO
o9MtAQC8eEi7ld6tOVtOypT4uakIZtPXwLzw06E9oaCvDXhg4QEAtn+2Z7MJeDW1
DlNakHo1LaSZvW8sfS0tUZ0EiK4lhgo=
=NfSP
-----END PGP SIGNATURE-----

--k4sHR0uTJkFkorbG--
