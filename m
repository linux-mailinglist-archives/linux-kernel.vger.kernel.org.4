Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1197670D23E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjEWDNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjEWDNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:13:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711691;
        Mon, 22 May 2023 20:13:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2ca9ef0cso3338153b3a.1;
        Mon, 22 May 2023 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684811596; x=1687403596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSMjb6e9YuYDEpRsFJ5qPxDQBlW7HCE/u3pEvidV/n8=;
        b=LOHS+IKHgCH7I6zpoTgXUFvdAvGmdtEi7FJDkBgEsyPu4bDMO/jzsjUZk+AOs8Juwc
         24tMy/zx9R+ZA8+KduyU91VftzIeaQCoTUohCnufZggWSx/SSy6CWZrY+wR9F9y2cfit
         urp5Ohx0hR8XxWlL9tSGYq8rsSUoEx6RxWxFWiepxle9IXzaNiwps+hyaSSq+AW8/ny9
         pZTOyLXYeBGrU4JEKeweFbYhb9e5U0bMPwa7rcOdg3iYNjxrLZFASudp9O6CVlNwl7k9
         3Offhmqdy77PWuWi6zEx0Oqppi+iXdqkpwm3g3fLaZ8xImEdRaMKmYlXk0BGcHO7BZEM
         gOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684811596; x=1687403596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSMjb6e9YuYDEpRsFJ5qPxDQBlW7HCE/u3pEvidV/n8=;
        b=fKeky150WDjuFgA+x2zLyRiuNgcdo5DYfYfx9d9d45N3zaB7DZ3wt8i3ssRqCXWOd7
         UYVrgzLroN9rNsZ0wQ8MFMWkm5Ao/8JFf+DrSIjOr9DuCmeUyMOe8aQ1r+RF2e8moru9
         sYdFjvQ/+1CLM8uUeEfhRMs7PxhNCC+T5thHMkqKnPwChfubTOxpdFa5zow6sb33S4Kf
         8ZtLiae6sLkHLRPp69fEI3qwHQPPlKcU9gOvbxe+DLL0JKW9LQYmxoiuXfNjRxOc9Lvm
         Xaz5u581m8rgQ8f8kA6of+Io2HxZJiW8Q5xlY+fhJ0UqDyZPgd8N5fhqZSv+PEWQLGmp
         KB5A==
X-Gm-Message-State: AC+VfDzg2d55KkkOVAV1B+40dxqsPOTBl3VuDXMmf2bgHh6oxolLgqWV
        P+EHt6d/IbxCLVYfiOukLtgctJsWSTk=
X-Google-Smtp-Source: ACHHUZ4TILvhwPx1Qq3dBgT+ohnqKeV9vn+3VhaecOzj+SaorKy1P9Uccrse8qK1DcRfNtu9/etW/Q==
X-Received: by 2002:a05:6a00:1a15:b0:643:b4d5:e3db with SMTP id g21-20020a056a001a1500b00643b4d5e3dbmr16970929pfv.4.1684811595987;
        Mon, 22 May 2023 20:13:15 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79185000000b0064ccc164c9fsm4705232pfa.194.2023.05.22.20.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:13:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 820D2106954; Tue, 23 May 2023 10:13:12 +0700 (WIB)
Date:   Tue, 23 May 2023 10:13:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Message-ID: <ZGwvSFRNm/zrIP6J@debian.me>
References: <20230522190354.935300867@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SDoHcXug8PvAf8Bu"
Content-Disposition: inline
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SDoHcXug8PvAf8Bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:07:04PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--SDoHcXug8PvAf8Bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGwvPwAKCRD2uYlJVVFO
o8M/AP4z5zLsu3LabwIkpBiOnf458k977I04xlrWyux8Cek1TAD+IjkK3wOFFm7i
xEeVVd9Qagdw+cL47zJkkUt+aglGSgg=
=AxGy
-----END PGP SIGNATURE-----

--SDoHcXug8PvAf8Bu--
