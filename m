Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B171FCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbjFBJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjFBJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:03:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1240EE58;
        Fri,  2 Jun 2023 02:03:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-650a9ba426fso1557062b3a.1;
        Fri, 02 Jun 2023 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685696581; x=1688288581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RSGExj07+kDKOGpTsWDuktSIgSKFw+xrB/fF73oAsI=;
        b=oz/hc9HZWDXBpBQp+hRcHEF+P+HV+mFdFnaDXYh1U3PRTV4K830iowYqzX8ggrmnFd
         wdwMzWDandHE050UjGq6cuIRqCABq+lt01gX0tGH1mW+UjFjgGC47p6R6rGymopak4o/
         dCwIUhE0BsTaKSeGYxaSDDEIihzt1PYBWvBqGlUKfPGg8IGQ4um9ZBLJwcPu17dGhtx4
         5Kgz0PzVplSOciLmKq8lZ7/wppUdoaJqCCJS5mHXIUv4Nifc93g8c2czKU3X2l4T+Df7
         XkcITJ1V0OruTz2AAPK+iIlcQ6zcbrB519DoEH6i6t15PIKGyfxInrlIrbGZCNQbw4cM
         Woag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696581; x=1688288581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RSGExj07+kDKOGpTsWDuktSIgSKFw+xrB/fF73oAsI=;
        b=HXCfsvQxgrrAh56nzqL1AKkh5Qx7NSJZPtc6RefNa9AKfydzXGheT5C9MVTwutxYr6
         PBbsDSN4Q4VC9GwgEThCZgN/L8lV+edOkOhOX2Df1RwTNQEk+4U6vF9MYSZh1R7cHAOZ
         NcCSlk7RpfMDdRoKSIfOpI9PMZcFWzTOI/7QaBSkCGCeG1JV9NLjwWLDc6DyJBbALqoR
         7s+v+RdopbqR5R/L2sDag+a0uKFrMH6ExljItXriDFVd3Dp4RapRQsXkjODcVUX5pimo
         3b1zdKocMc9DqEXduIlO1gFHOpUkogRR1W5hxbMqr/gUcpdh/I0YLjIqgeLPkFATFr9L
         Aung==
X-Gm-Message-State: AC+VfDwpOvHYCY9CgBEFg6s3vF2staBtXEorlGv4XAl3VoG59qB8MdN4
        HUdx54OB3qcNVXfJCODspnI=
X-Google-Smtp-Source: ACHHUZ5Ql6bYjAeNjsJaT/31JEizBoAZV6YmEI+qm4jxUoBJP9ohRom/8RPGg0qNoZHeZE96pfbtkA==
X-Received: by 2002:a05:6a20:a127:b0:10b:a9ca:97ca with SMTP id q39-20020a056a20a12700b0010ba9ca97camr14075082pzk.51.1685696581160;
        Fri, 02 Jun 2023 02:03:01 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b001af98dcf958sm791129plf.288.2023.06.02.02.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:03:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 55691106A05; Fri,  2 Jun 2023 16:02:58 +0700 (WIB)
Date:   Fri, 2 Jun 2023 16:02:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 00/45] 6.3.6-rc1 review
Message-ID: <ZHmwQrgb5ljgyd-G@debian.me>
References: <20230601131938.702671708@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sX5zVEfKkJ80vx6Q"
Content-Disposition: inline
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sX5zVEfKkJ80vx6Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 02:20:56PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--sX5zVEfKkJ80vx6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHmwQgAKCRD2uYlJVVFO
o/2IAP9JTqZ2cMARmce8gUY0sPGsCmpqfJ+0Zfbr93tg/ixEhQD+Oc1EH1y30UzD
2waw3v36fYhMML++2wpkvbBFmsDYVwo=
=RKny
-----END PGP SIGNATURE-----

--sX5zVEfKkJ80vx6Q--
