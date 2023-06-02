Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15071FCF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjFBJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjFBJBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:01:45 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D661AE;
        Fri,  2 Jun 2023 02:01:45 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39a50fcc719so1306525b6e.2;
        Fri, 02 Jun 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685696504; x=1688288504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kws7y4VkDTZYQ3nyC0nxFkZqfRS9Xqe8rcms/oZZOcU=;
        b=oWywxfMHX+105fVuwQITBZfdOAXhyC4cy5+yf73os1h/j9mjUddf9NBdUddAAuOBvZ
         AfnyWDHRHEKj7zMtgupGsf4ZoDRADlhi78QT2T9LBvNe5AITcEED1SvPBJiWDAFcKXhm
         9Dcn6f8vqUfhZATVnHBYohL/3N9Z8z/vFDkIEtdXoVVyjGkEbboK0h11y1YHvN4vvUT2
         LvoVHw2EWLknp3zzbdGye6WIqg3wKaFLvz0ldaKIjxGGdqiBDKfACYCgH1mvXNMj1eiy
         gn2u2uBmjIWJldlHfWM7tuDebf0Bp0ib6+CbpCzA5EUJ8P8huT85b/D/0EEo4fNgmnho
         4MOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696504; x=1688288504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kws7y4VkDTZYQ3nyC0nxFkZqfRS9Xqe8rcms/oZZOcU=;
        b=GPQFkRXOHTgzM5zlcc/sZNikIz7o4Pbeto5k61SZohUnrshcUuwqrQRDeSj+cAoFy/
         EWisQJ77f6saHEclu2tXWxrZ9JndcRiOesUa6ykF6DaxvTnMgb+q+iVtcF25Bxb/QaPu
         dlfNrvcSlNvKXoEhWqrPvnXPKFliu8T6ZWhdctA1581i0mTsbaQcUHHnbPD4nuAUzzYZ
         igsOwupae/SS5MEI65PmI7j2d0mDE6Dv5qg49hzVRv/EOojDXJ9A7au0HYMOLm9C1m0i
         2YpBn6PU/eR8TXSE6sM7RYkXJndUnpunxaiMT8HbhighEqVO/N6spPLZ1CE7gpHj94ij
         RziQ==
X-Gm-Message-State: AC+VfDwNkzDZeQJ/qbNDnrTp5xPdaTNmSKz2WrO3CPPGtucscYdPGVJw
        vLr6kz732cOCqvtFFrt/fF8=
X-Google-Smtp-Source: ACHHUZ71ASbbleh0vAkdGrczHAvNay7xsB8T1bsoYWAd7d5kyoqr4Pra+5RsRSdr/Ecn0nHyxbCeTQ==
X-Received: by 2002:a05:6808:1d5:b0:398:4d61:aad9 with SMTP id x21-20020a05680801d500b003984d61aad9mr2051172oic.24.1685696504349;
        Fri, 02 Jun 2023 02:01:44 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c28300b001a245b49731sm822266pld.128.2023.06.02.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:01:43 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id D15D0106A05; Fri,  2 Jun 2023 16:01:40 +0700 (WIB)
Date:   Fri, 2 Jun 2023 16:01:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 00/39] 6.1.32-rc2 review
Message-ID: <ZHmv9J2-oGhI7pQq@debian.me>
References: <20230601143327.479886832@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mJ8XI4Gw8QAc66Dd"
Content-Disposition: inline
In-Reply-To: <20230601143327.479886832@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mJ8XI4Gw8QAc66Dd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2023 at 03:35:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.32 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--mJ8XI4Gw8QAc66Dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHmv9AAKCRD2uYlJVVFO
o3NoAQDWtj/c35QsvmIKvWiUvDsh7nXEpnwgM0JLjSlWPohmoQEAnNUZJLfcQDeE
cPHHi8XeTuKRvoLU5oNEshjmsvUZnQ8=
=0WUK
-----END PGP SIGNATURE-----

--mJ8XI4Gw8QAc66Dd--
