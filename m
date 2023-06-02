Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB371FCEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjFBJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjFBJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:01:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628FE55;
        Fri,  2 Jun 2023 02:01:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-65299178ac5so952950b3a.1;
        Fri, 02 Jun 2023 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685696473; x=1688288473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQmDZuz51pdsQD5VZZckL893ovxLX5KE41c163666Jw=;
        b=T3F9QcAU4PSgra2G3adC2lpzm+QLxPR6QpY2g0TFL3FHwkfkx1jLZOfGgZXmc/c22V
         +K7WM1qWvQt7pB/fm55ZcpJPO9J5CeZSSLKQLRXTSQEYRYamH93s/4Vs19rEeCRm9hW5
         aRlHic/N2nH86nQJ4WU1xAecrrScaipUOfsuDzBXlMGmooccQjmjNmMQsDCljvuupQZD
         RN4lKuqVg5aJSgDOOAulKacth4vhcOz7/sKdwCzQFWVzZbAN7zpUCIjVDpUutLyxaVgD
         Th5ui7JbAAQ2Bz/9PpTsdoamWSR4arZ3rHhtCdSRZ371bgOCyobcSqwFxuF/FGIxjY76
         DWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696473; x=1688288473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQmDZuz51pdsQD5VZZckL893ovxLX5KE41c163666Jw=;
        b=igYVm5hWaLjWTGf2f3rPTBwZ4BN4d/RCMgvAn25FtTDtyL6tS+JrvaG2a3LeyuReFi
         UjDCEzDyJk8OEQ5WpjZ7w+R6jTuyvzYaLzyUR3aWQwed/FEtGnEBPkWSa3H1xGgBtGiS
         GXv7mc9T1YLtDUg2ySSiCKrY+n0p1h44hZ6Zjzfz2J98shJCnjd+IgVXvrxtWGkcxSS1
         bvGIiFk2Eqn6mDNnHPJTWXXI3rBm0Z5M4Ub6zt5o0/YToO4MLkb7lkdn7/KSV6nlfRAI
         qBPK/LNUFaBPr0GjUS25lmv8s1Rj9tmJRqx6Vp1yMn1S39/WFIOjgC+gVaEFT9unvsva
         pLeA==
X-Gm-Message-State: AC+VfDw+byacepcckNGk8fCqS1NPIlcK58OahVggGC3ImMdWJ9nUK91H
        fjnbATKrcccg0otHBmZgzKo=
X-Google-Smtp-Source: ACHHUZ7i3d8OCsl6CoFU9gNyQDFsEKsuLTVb8kPJkRzYiPumurV044GTpK9HAooU1TXCrmZ213GVRw==
X-Received: by 2002:a05:6a20:7486:b0:109:c161:a679 with SMTP id p6-20020a056a20748600b00109c161a679mr12965246pzd.19.1685696472878;
        Fri, 02 Jun 2023 02:01:12 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78107000000b0063f0ef3b421sm632776pfi.14.2023.06.02.02.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:01:12 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 468B2106A05; Fri,  2 Jun 2023 16:01:07 +0700 (WIB)
Date:   Fri, 2 Jun 2023 16:01:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Message-ID: <ZHmv0xaN146efJL7@debian.me>
References: <20230601143331.405588582@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3DdP6FizpbllIged"
Content-Disposition: inline
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3DdP6FizpbllIged
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 03:36:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--3DdP6FizpbllIged
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHmvzgAKCRD2uYlJVVFO
o5QXAP4tyPXNMNtVXvnAjJVWKrA9cX5E45kp4F85WS0q8/9CxAD/dxHd0kptAQwE
42/8HS6VDHOr3uMKn7ykccIfT+/8rQg=
=C1tp
-----END PGP SIGNATURE-----

--3DdP6FizpbllIged--
