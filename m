Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2272B72D89D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbjFME3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjFME26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:28:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0172686;
        Mon, 12 Jun 2023 21:25:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b28fc460bcso3023573a34.1;
        Mon, 12 Jun 2023 21:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686630307; x=1689222307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uTV1jFTnCTF+meucMFZeTrQtmKUmgta7A2zi0G4+f6o=;
        b=q6CYDd1P73pEt7flSF5GqiX1ie6JOPBVuYBm8qDNP5syUxcB/lmpHMvmFIM7HX3ASp
         3HFjTFUS059+PTdY8KZH6E9qOFCcsHSPomX94LkhCB12m/xz3dC7Yz0h+TZP2TevqkW/
         PvRqGude5UsxfiSzUBRH7Xnpq93mpg325bATBkYKA4+uNUW6+0Lcw+19kZ1SjeODtU42
         PJ5rwxN1RSHqflUytb2lvn3/RWNCMo+Q55E7F7E8H3+w261uQtMyYxlTmGHM+FlQqhVv
         WUNcOTkPdREzxt0ZTAv5UO+PVmfDavNPtjBlF3CQhS8lP93PYXjgT1cQtTiEpuya3Zbz
         f1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686630307; x=1689222307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTV1jFTnCTF+meucMFZeTrQtmKUmgta7A2zi0G4+f6o=;
        b=e1tZfNlHEWTFzNFs+3cgYVDB7eeQHzqCpRrcdxLf2kE74q3b4+Yw96Al3Rbd/zDWHn
         nA+GTVgSvBNwxtY+LC4/ewkb/DWEQKlaGreksq66xAtK3Vna3N5MKsqptsU9WwIHe7U/
         rM+NHsZM/LKH9SyNQwNj3fBaTT70kOkrKt5ZALjz4EW9JrHh1CHlzXgclQ6MxYPxrdTL
         yTszH6GCgK/gnh/pqPYmamLFhnFN87Fy56qmgrN+ncIC3bqU0f8cNAPxEe58B+mSefVu
         HuIS/t4pucC2PvKS6y4DKlDCiWhg+d8SoZwPlr/SgiC52IC8XW8d3JC7Hy+HoWOwJyEd
         THnA==
X-Gm-Message-State: AC+VfDyqf87sMnfqafW6Q+Sk1Eh2PXGVX9H3xiM7YAlP4ftEz2gx/IG0
        U2R+XISaHgKOIQguqumCDS3UTy6dPiM=
X-Google-Smtp-Source: ACHHUZ6cRCkflRCxZhRgxzD4qd/JtQfF3kls8ihf4RVxq4GqCuWKtQ1Sr25dWUiRFC4+9a/DRzxsIg==
X-Received: by 2002:a05:6830:22ce:b0:6af:991d:126b with SMTP id q14-20020a05683022ce00b006af991d126bmr8111513otc.22.1686630307128;
        Mon, 12 Jun 2023 21:25:07 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id i1-20020aa787c1000000b0064f51ee5b90sm7677022pfo.62.2023.06.12.21.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 21:25:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EB3FA10666F; Tue, 13 Jun 2023 11:25:02 +0700 (WIB)
Date:   Tue, 13 Jun 2023 11:25:02 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/132] 6.1.34-rc1 review
Message-ID: <ZIfvnmNxKLAPEcaf@debian.me>
References: <20230612101710.279705932@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7klP0XdzA/mKyD+r"
Content-Disposition: inline
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7klP0XdzA/mKyD+r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 12:25:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.34 release.
> There are 132 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--7klP0XdzA/mKyD+r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIfvlgAKCRD2uYlJVVFO
o7FkAP97O6KDtfaoOB71+CFv81wOylEDc22EgYxuuagu5pnYnAD/SSLbOl/Co3ds
k6WTKHvfZYuyBpej3mLB6XqX9ZLBQgc=
=3PZu
-----END PGP SIGNATURE-----

--7klP0XdzA/mKyD+r--
