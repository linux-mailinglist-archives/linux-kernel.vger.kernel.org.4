Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78CE72D859
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjFMEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbjFMEOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:14:51 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2058910DF;
        Mon, 12 Jun 2023 21:14:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-65314ee05c6so4128790b3a.1;
        Mon, 12 Jun 2023 21:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686629685; x=1689221685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q68FLd8Lf8c88U2yU1AjX1ynx75CBETxpHufNs3LkRk=;
        b=C+DDSC4oivLipSV1OSoBz/cmklXs+3ZmdvqSXolMhlXiYAszxWutgU1874ONcQRwSu
         ESP32Hg7dqm1vjH3sj89j606bAyYguVProcvT4M5h8xFLqghJKElHNL7kIZeqDPBsgp0
         vGYl/oQqRL5yzMdJcQjw59k8HeRcAVp5rwWWa91muPXWN3GZwp71p22H4TBvmuX9HQP8
         /R/j3Hp8GcEofeU55m7lwTofmkS/RHKZpvzZEJGIH1+7ttBHidXT/gED2GevHjl7Wjrj
         VRWW2EFmu1LlIAtkiKThGaTjw8ODqs55d3etG0N5EeRY0p57cdiLtE4azM/7eIDdnuOK
         f+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686629685; x=1689221685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q68FLd8Lf8c88U2yU1AjX1ynx75CBETxpHufNs3LkRk=;
        b=J52zUV7mbi6anAemhzyNDjNIAyg7158mz6TKQfOqL6wZvNiQrwfucKDMLbEkVt8tqY
         b2LC1WL2qt0f/qB+uhU71L4+MudoNOzOFGpwgUKH2HU5WaDbVDa91dprmJTeU0DXB368
         MohCMPe7kAclZ6fXf1ZrYSyYuv401NK34GFVeS3j3sIqd/SwbG03x7JvEP2lyy3xyN3C
         jcHWc9FpIoINOMo5RU0h/FZTF1/UoQlADDNOXAdhYBwFVe7CGmPo+Ac2j399tMijg/mW
         tvJ14BqSW6118AqEn3W7eOOvvYJ5oTZftcOCSD2j63LZK/x5/1cLCc9t7x5MBLZ5mLF6
         z9VA==
X-Gm-Message-State: AC+VfDwXY/+USLLZ3HB7iZ9Lo0iCqlIPi7AEH+Ot7d7gDIF76uyHjv4j
        HYEfLwr/SXtVOvDJply+Xv636D3Z86o=
X-Google-Smtp-Source: ACHHUZ6gpgq7SxCh3va4CCldJkvqQEi2+kAUOUf9vIlHlTK48C/xvFhyFU6zwXsDOS0NbbuSzelG0w==
X-Received: by 2002:a05:6a20:9384:b0:e9:5b0a:deff with SMTP id x4-20020a056a20938400b000e95b0adeffmr13167699pzh.22.1686629685444;
        Mon, 12 Jun 2023 21:14:45 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902a60e00b001b05e96d859sm9005098plq.135.2023.06.12.21.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 21:14:44 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9429B106994; Tue, 13 Jun 2023 11:14:41 +0700 (WIB)
Date:   Tue, 13 Jun 2023 11:14:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
Message-ID: <ZIftMfwrT4dLp3_L@debian.me>
References: <20230612101702.085813286@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PjzAGnKqwk+LHmb1"
Content-Disposition: inline
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PjzAGnKqwk+LHmb1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 12:25:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--PjzAGnKqwk+LHmb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIftKwAKCRD2uYlJVVFO
o1N8AQDCFAbWcn+AHT2ebgUOuWoz0U3nhB4+mh8GczcCJGSBZQD9HfQXOGMEF4nW
baoUGb0Ekt3T56dp2gzvoVGSY3tv8QI=
=U6VQ
-----END PGP SIGNATURE-----

--PjzAGnKqwk+LHmb1--
