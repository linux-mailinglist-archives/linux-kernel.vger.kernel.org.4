Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C3271438E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjE2FE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjE2FEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:04:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232710D1;
        Sun, 28 May 2023 22:03:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d44b198baso1983447b3a.0;
        Sun, 28 May 2023 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685336606; x=1687928606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS7IsfdpubWMWbMIpSsxRx+ub93QQK4IFCY1BnBE+eM=;
        b=r/iPY92YyEc5+MDaILsPQQqvI9WFXX+4hU774+EUv6Sqsc2YqL7KPtQ5bQGcEXW8mX
         +wfnF1Wd1JC725MQ65yleNXQGCN5sNqZBGFLeXe9c9JYT1hcJmaF+DLqea1zxM1hOocZ
         GsQ0yos8BRDmLZIbrRjMAwwrxcxpO+V6CvmOUxPVly6aG3IJk1G7ItqJneFF26nhb3ng
         pbh3Zl8V9Gwryk+KAoM2xU7k/h0/igVs6Bgj5ZHU2d67rVjVZgxytvSr18thOCEU/Cut
         o73z8IxRLP6NQJooHynGhT5Q30/6sOrRyridqlWe3bkI9ooWNiUL0yEqZ+YhPAt/OfIA
         mOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685336606; x=1687928606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS7IsfdpubWMWbMIpSsxRx+ub93QQK4IFCY1BnBE+eM=;
        b=ITWR6B5WO7HDvPSRxPmwPfLy9Oi5MH5AdWqTxJ7xjAhyxR9edOCdfn3ENpMO1ClTGl
         s4me+uATdNV1ApJQovxDRa5fHxkxTDKksP+FBC/+x8u7ILwe80CMHbSF7tvF3pXSrNGF
         x3u5PpunSmudp0mcfgtfkI5IobpCOvFdowbwZEhWE7wsAsH4Co9ejCdwCxrVuLFmOYg/
         050DuACH+HPKnAfL4miJtkCR3pA1C+BH11nml8zpbFp9fZqavXv/4dXEmk44xm59gtKm
         y1S7L/HUjmhUlBWR0lMwU94Dalh3TpffnvySy7azhTuXPxrua/reTeZd1B6jlx6z+Km1
         NhJw==
X-Gm-Message-State: AC+VfDznP+hglc3kWGOi3Oyfvd0iP+h+Qrx9BfkaUsB1NiO0Mk39UXbO
        z/TZRImbdhuAMFXxd8GsxDI=
X-Google-Smtp-Source: ACHHUZ6mtt6tvQ+KHq1AAuJM6+9hmFCBIzLzhkXZXBEj9JRLqflfZsYHasXuQ+bzxBYhWfG4TKy1nA==
X-Received: by 2002:a05:6a00:2315:b0:646:c56c:f0e0 with SMTP id h21-20020a056a00231500b00646c56cf0e0mr7293552pfh.15.1685336605533;
        Sun, 28 May 2023 22:03:25 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78385000000b0064305676b61sm5921609pfm.203.2023.05.28.22.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:03:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4AB191069EE; Mon, 29 May 2023 12:03:21 +0700 (WIB)
Date:   Mon, 29 May 2023 12:03:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/69] 5.15.114-rc1 review
Message-ID: <ZHQyGGR2TBzuW_3I@debian.me>
References: <20230528190828.358612414@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WJgiagu4JoyStVG+"
Content-Disposition: inline
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WJgiagu4JoyStVG+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 08:11:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.114 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--WJgiagu4JoyStVG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHQyFAAKCRD2uYlJVVFO
o29dAQCZe88o+K8RGhFVMiRABqfAHr4p6ODLJ6bGua9Ecn6mlAEA8GVDkv0+b4W1
AIujQRnwo0ml5L4phj70108U21h5mw8=
=Y/iw
-----END PGP SIGNATURE-----

--WJgiagu4JoyStVG+--
