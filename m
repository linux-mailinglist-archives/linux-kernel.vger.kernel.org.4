Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A011E71439C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 07:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjE2FMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 01:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2FL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 01:11:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185383;
        Sun, 28 May 2023 22:11:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d3fbb8c1cso3342881b3a.3;
        Sun, 28 May 2023 22:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685337116; x=1687929116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fWsFszs5kxFXpxFnuf42wnvADDMveTm0oNoJ2D/ov4=;
        b=BxdF15YGTOpjAaVjgDpRjdkJbrdFqLP3TK2/U/61DfKn82XUM36NhvPQg0KB5a6uhk
         59/GOELY+NsE67m81mBP6t8WyQJamm4MQoU9rK4iwcBvowKgNYt4Wm1kNQIbNwY+/oNb
         KDmLo2CgxFz6dVQEz8LpC/ddLODUckzLyw6c5lf0vkyxBFxSQkzCWiV03JK5RaMIfbgD
         zDHPEDbPc8fya120tdzVqRrhvd7nIWbdKZoVUyl/JrWJuy5cLOzngk1mhrmGRJwVURAp
         JiXPH19+FCV5iVgKJSs1eZbbLBCU3X6CXsb7N2pkV1JH1kPjTqxsY+SOl/wD28/Lj+Ms
         3RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685337116; x=1687929116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fWsFszs5kxFXpxFnuf42wnvADDMveTm0oNoJ2D/ov4=;
        b=Ikc2yNAJpYfCc/CevWom+z51kcO/Py55RQE4GslpgbMRn1+bvF6ExadjjAVJv2y17l
         yiXt4ums2DuXa5VuHMNXWOJv8pvyCJNnErmGXiObYQ4IJsdFCr+xjyN0hwuC9R2JHX51
         0Q1KySnzTZFwjLlsg7IPN/2Xg9PZ2CrPg1AtG1rYZZxGQBVllVsPTn5O38w+vy1bpqBi
         dddbi6UTkVcArYbXXwdboRL++JRkGzATfwfze90hunrZrX0bkGZm99x/BKorIpWOdKBB
         PHCaTb2BfN+1KgiW45q8RfOrvVq/j7284fGtDHbbVOfCqHo7rwsTHnwlBbkEnY5XmqDk
         kpRA==
X-Gm-Message-State: AC+VfDzxcsqGhztxK56IQck/fbWoIV3/shNb2hXYxnnn+Qr7V6o/7S+Q
        vvT09RyazR+aomxWUdOLVOQ=
X-Google-Smtp-Source: ACHHUZ5Lla/hNu5LlJ/h2XcIpuieHaRitgQ4OCLZz8tvU8S0cDgEbUxNTYgZTAgQOGkV8bDHWraS+Q==
X-Received: by 2002:a05:6a00:2484:b0:64c:a554:f577 with SMTP id c4-20020a056a00248400b0064ca554f577mr13982201pfv.11.1685337115665;
        Sun, 28 May 2023 22:11:55 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0064d71d8dddasm5962620pfi.196.2023.05.28.22.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 22:11:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E5CD5106A15; Mon, 29 May 2023 12:11:51 +0700 (WIB)
Date:   Mon, 29 May 2023 12:11:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
Message-ID: <ZHQ0FypIRK5rWY2Z@debian.me>
References: <20230528190835.386670951@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S//Goj1zUX6CRAB2"
Content-Disposition: inline
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--S//Goj1zUX6CRAB2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2023 at 08:10:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--S//Goj1zUX6CRAB2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHQ0FAAKCRD2uYlJVVFO
o1uxAQDTFAwpmMjunL/H6GMVVczQ4uO9M1qQMA/r3WMrS+fuogEAxhRy3r+Rvars
GObpMDDqMIDC6I9TH85UeKFuPea6dww=
=NCX7
-----END PGP SIGNATURE-----

--S//Goj1zUX6CRAB2--
