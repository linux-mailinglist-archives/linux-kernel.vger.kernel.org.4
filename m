Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA76FC7F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjEINct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjEINcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:32:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E374E61;
        Tue,  9 May 2023 06:32:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaec6f189cso40503165ad.3;
        Tue, 09 May 2023 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683639165; x=1686231165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R45zpegW8LI8padWNnS29ORnNeyMT0Hk+g1EjT/I0Pg=;
        b=ahc1dkY7gQE3vzZvvJiOVnbQxnBH05m7XApvQnuyzgNSGwGCP6oi4sn5kBv6xhrahU
         BVmLSIlBXdRlEB7egXwFr0wKHnH7wsnk32lWBqbFKf29H2gCKrEqgCPLTmCDKpEHMrNh
         irVHDxNkwjj9Ja9aoAnjOmQYs9mViINfeX3yCARacUiAre1nmh7MCIEs/iPlfHw8bz8t
         HAf+aHZa3IrMWoBmAajmqlHyzeVsBF4QkiJsLlNfqDZ5mtPo1OVtpX0kbdHLL0DBUCPv
         g94ghlF4gP+X6ScUejLxatJRPRF0i4GeR3YdqFFYfNPG52Ln0YdBJQG8AYVZjZZE16vE
         mY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683639165; x=1686231165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R45zpegW8LI8padWNnS29ORnNeyMT0Hk+g1EjT/I0Pg=;
        b=MblJrjf7pvLgyi9S/x0NoYD6nYwqbRNSiYgRnFnTWgvfJUkdybVLZmq41VYFSNcs5+
         ExqFrWCHEmrWMDnDyWoxx71cnJleBY39eY4h/s+qAsgv2tjoF2icfmcgABnl45QKWXSL
         +SZ951l/FjO5/rA1I6SMxuONRzGHwxN8douRanIIVF2HFmfgw1kbQVgFfV9hJ8tZePMJ
         CClGyILE900JcZ06/mpMZO3nweMTZXLl2smoqUnB/i1HU6Ak0YN+Wh+28jjCSMaQIpqp
         cMKl+Dii0pT4MB+aTD4AfpRdVb/MXsxUScMdnnBh6dp1Tc8BPeQYoSDkmcNtNtLwfYTo
         uCLw==
X-Gm-Message-State: AC+VfDz4s+w8IM615JiK7t71cPPTz1tcOaMvdgXFtUXHSuHB3WQynar8
        yW4ybWs6/nol7EaGSVwNy5s=
X-Google-Smtp-Source: ACHHUZ7ynVUKLRNNssZgavv0BMhAnpo8Go1J/M6wEoWvNt7OEPYVEsPk9pWvnN34+iMaczbrU4uNGw==
X-Received: by 2002:a17:902:db0e:b0:1ac:2b37:5ab4 with SMTP id m14-20020a170902db0e00b001ac2b375ab4mr16065276plx.55.1683639165336;
        Tue, 09 May 2023 06:32:45 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001aafc8cea5fsm1544833plo.148.2023.05.09.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:32:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D765410692B; Tue,  9 May 2023 20:32:41 +0700 (WIB)
Date:   Tue, 9 May 2023 20:32:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Message-ID: <ZFpLee99HVY+N6EP@debian.me>
References: <20230509030705.399628514@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vy0GeF7T+GQUzWUw"
Content-Disposition: inline
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vy0GeF7T+GQUzWUw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 05:26:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled in my computer (Acer Aspire E15, Intel Core i3
Haswell).

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--vy0GeF7T+GQUzWUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFpLeQAKCRD2uYlJVVFO
oze1AQCLLhbGeg5X1U06eeBymA4qSF+b6ddktSTiryIi6KpW3wEA+KcI3TIN3Ru0
Pk9mBZN53dblVHXNqcqWRxcNV3Rcww4=
=XQ6x
-----END PGP SIGNATURE-----

--vy0GeF7T+GQUzWUw--
