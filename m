Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138A36FBD7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjEIDHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjEIDHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:07:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6431449FD;
        Mon,  8 May 2023 20:07:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so39260294b3a.1;
        Mon, 08 May 2023 20:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683601631; x=1686193631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JvMCL94HWXtWXaOhm3x+6fo3/iFeZR4RzaE9AL9QZjw=;
        b=QFZQGPsD1BfzCUW4AbgKrpjQaC1YPI/GFHIglygbGb+FHpJBb0Eh/GVVKUO/a2CWdD
         dbNu1Gp5lR1RbXj4O+0S5YSiuw6Nme7L7TdDIyX4Y4ZHKpzFdCsc25wF6GFqhtrRj/Oe
         oezyVgkXk0+SI1JjLJ5Aj34qj+Pd2wpnZWvvxYoUgStjnfYcMY3L/4quZIIaahwe6qqq
         rHNj5Q/pzVdemgsNR+E9wVWvGu4+l0/5oYNFwg3lzANTc1ogSx7EwCmdNnb+nZKzktTT
         uk5ipLaU8rKplfgJddruHLO9wZCMn+Dk7SsrJ4JuNWLwM56jc2HKsDmmhGfZum5bKVlI
         IKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683601631; x=1686193631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvMCL94HWXtWXaOhm3x+6fo3/iFeZR4RzaE9AL9QZjw=;
        b=gLnO03zhVKD07CzohrPwhtsy/zr1tnw3pHqyvJNBox1d9YlDIKQ6M2dW58CGu/Ryv/
         JAFM/Za6frXB1ovsGNcOE4LlQcq/nHWlzm4sDcSyRc2aQ+KfLuz3tue4qHjm8EptCYFx
         X0987rHN5pgL3EqNBrLdXaACORDv3O82lMzROLTprWSKaXIHLaawF+5PNfox/8ticzsn
         6kZip+iiNZTld0PUYk/L4OKiNpliBoOfVniji983FPNKo9kAM39OFLYwxVtj8Wl12gPF
         VcgoIzlxhXznVgJC9NNBp3c1BDTD4WULq0X/Qp27HGmFVisrvVff7Vh2C2S+LxX3RCUX
         CzEg==
X-Gm-Message-State: AC+VfDwN7NgM/EqwJHbyFbGC2i86ZVxOUVDBz7FNcPjJZQvfT7rtaWRD
        NHpy6zgO4rs1c6+jeA5R6mM=
X-Google-Smtp-Source: ACHHUZ4i72BhMuhdVOUaapXiiooE7xVTct+mEdco635HDQ9hdQZOQU2mEC7xd7qquoku8W3rcQlLEA==
X-Received: by 2002:a05:6a20:4420:b0:fd:4273:f45b with SMTP id ce32-20020a056a20442000b000fd4273f45bmr15571802pzb.29.1683601631521;
        Mon, 08 May 2023 20:07:11 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id o33-20020a635a21000000b0052871962579sm208121pgb.63.2023.05.08.20.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 20:07:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 473CD1068A9; Tue,  9 May 2023 10:07:07 +0700 (WIB)
Date:   Tue, 9 May 2023 10:07:06 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc1 review
Message-ID: <ZFm42pTaUG3eHAOc@debian.me>
References: <20230508094432.603705160@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saZ15ehIGs6aFYK6"
Content-Disposition: inline
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saZ15ehIGs6aFYK6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:37:15AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built bindeb-pkgs for my computer (Acer Aspire E15, Intel
Core i3 Haswell) and booted. No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--saZ15ehIGs6aFYK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFm41AAKCRD2uYlJVVFO
o+x8AP90Lq+s2GGcwxyRb9hzvNGUrV705Jn0xjD9qaXeU2IVMwD9E1Pqy4nicVOA
00HXXWTvsNZCb8fzdRpz1hpdICraDgY=
=e4sA
-----END PGP SIGNATURE-----

--saZ15ehIGs6aFYK6--
