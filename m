Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC46F23A0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjD2Hmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjD2Hmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:42:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF301FFD;
        Sat, 29 Apr 2023 00:42:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b7096e2e4so661299b3a.2;
        Sat, 29 Apr 2023 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682754165; x=1685346165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeNcPQTPZBgnBI2IkCYPJMsqtzHgVNgFNOuqYXxOVAQ=;
        b=F6+++vSXR9TxroEWJ/qt93G/k1aFq12YhlwKNSxCSvm6mojLy4KgRWun77aDK7G9ek
         gndD1uJz0l/cYyLDEEP9j7h3OCyzBuh/1TRpDa8OQzLON8AUGBCFoUnab95RF2ka8If0
         lXyPyYwWk8yKXXmNhcgog8hBjpJD/Wk8hWDrdWUZBW2kxVjhyuURoqrsFoM9X4xDc5ds
         Jgwo1sO0Q7YEEfdnsKH0quMnXaqscq5LWXmlMotTRu/rZK9+5o/gv6WvHztyJBCsnKxh
         s/DePv5jaNBmdV6zgRLPrAecpGHGr2jtoNqche/NlPJxtjzPCZvz1Eh+x2Hym8auSf5q
         jInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682754165; x=1685346165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeNcPQTPZBgnBI2IkCYPJMsqtzHgVNgFNOuqYXxOVAQ=;
        b=d3VsgDAxEHvOhIZCZScARxCRb+w2Gl+lkMAxGGTIIPv1bzlNj3WXoAKbYNJNoh3k4h
         VY3Uwv6q/vMealdwf0wgzPKSVH3i+mLbozKcVutO8LexgSuzqC/Tyr4qQfcpIWEgbQaH
         nnT2s/32Z9pPZODPz1LA9IhwN16hhFDoUQ9QvSAT7oDbkCD1KhGLtlolEOXT3LhsJCfl
         FjhqR5cVkZEI/AAzrlWe3o2YS+/8mjRcNarJDop1/hQxgC/B07DbqM1sMolIRE1r/P2H
         +Em9pKGw/91t+o+80c5ELguz1WB4lKLP0QpnuMHmqyJKLOkwv7zbWxwpmFT5dOA6jC0i
         OGJg==
X-Gm-Message-State: AC+VfDy2w2fX7ok+U3e8cajxlvLTKoASPxSv9YH2NwiBqIKSR8LCxBkw
        rTb6JyDDtivf9ClFhxI29Zk=
X-Google-Smtp-Source: ACHHUZ6rDpYRi/riL+A0zo2zK8Ea/uILnmI0S4Sh7FBlN5AgTKX43YwsfZ2B1dMsOV13U3bDF/EgWQ==
X-Received: by 2002:a05:6a21:1690:b0:f6:8d47:17f5 with SMTP id np16-20020a056a21169000b000f68d4717f5mr8866288pzb.11.1682754165157;
        Sat, 29 Apr 2023 00:42:45 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id h2-20020a63c002000000b004fc1d91e695sm14121674pgg.79.2023.04.29.00.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:42:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 15EFF106971; Sat, 29 Apr 2023 14:42:42 +0700 (WIB)
Date:   Sat, 29 Apr 2023 14:42:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/13] 5.15.110-rc1 review
Message-ID: <ZEzKcQ7enbwpbDCP@debian.me>
References: <20230428112039.133978540@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="APjJtR1Yu04Jbzl2"
Content-Disposition: inline
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--APjJtR1Yu04Jbzl2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 01:28:04PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.110 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built and installed bindeb-pkgs for my computer (Acer E15,
Intel Core i3 Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--APjJtR1Yu04Jbzl2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZEzKTQAKCRD2uYlJVVFO
oz0dAP9qqBqAmc52bNn3EsMT9oSv5OgadEtDmYxVzbnKu6uhegD/fORrZMZroG5Q
H8/RkC3s0OHzvSAOQIml9OKrDHQQ2Ak=
=R6s6
-----END PGP SIGNATURE-----

--APjJtR1Yu04Jbzl2--
