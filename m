Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB26C7A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCXInm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjCXInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:43:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AA26C1E;
        Fri, 24 Mar 2023 01:43:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w4so1202013plg.9;
        Fri, 24 Mar 2023 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679647416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=63+c13PqLyD3QusfTBu8qhhFxvCe/K+kMt3rghnQ/7g=;
        b=LQxMHrd8au/vgIoe+cXhnOggiTzfubW9yupHlfxAHzjz5FUEfth5IkmdB9rUJ2+HxL
         TkGIkDyEwhfdG3ChBfsSVkk6K/w9dupZ/4bSujWFigqqwQVm66EvorOcuL1t9QVnxucN
         ipoSzWxeQF9uSUiZ6FQN1SilCOwTjpl2fi2zIrAZAz/wNzkUeIjlCqt2UQKeWLL8TIYN
         cChwHpaviTMKAQWGa8AcwaByZa/anP65UMciyloeSRrkP4v0fUK7fP7Dh9r4E1f6ovfn
         91x7kJ7f7lrKWmH/DtbMlJKZosNEZwR15dTJLxidmhc/utwtHWeqqE+sYcs7z1JqhHpt
         F+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679647416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63+c13PqLyD3QusfTBu8qhhFxvCe/K+kMt3rghnQ/7g=;
        b=ES1yhrf/XsdZH/hRiSsY0ow6bWYEMK7w91cdunU38MI+lR6Cl5Gb5DwazORHMMPYYy
         huKFpmGrJEhR1diutgPeZFzKh0bs+Dftbcw14jxnPrix9tnZRgoCXjUfc8u5WuWcSZ34
         qj9Um7Ig2rWRl/2srwgRtWwSUJP+Kc4T4ILf51pHuR1YUw9dNpgl/x/D1Eoaolzevdwe
         uGVB4vMLeG6ZOLCm0QsPSH7BFEmtTa31y03stTahjdweOQjX1PFlZWKjIX22ANx/nlxM
         K1X6TrSIayhajXT2kc6DgOv0cyYpjfJyISbQteM+hZUxIaZYxptCBjifRHqUuim9tvEY
         M7gg==
X-Gm-Message-State: AO0yUKVx7HODE5C7u3WFqAvqd4PnG9R5zbJWzqzX4+K+PyrZtgSlkfPR
        pUMDr4cDx6AipVFB4ERSJGY=
X-Google-Smtp-Source: AK7set+brpr+11TXhM8d9D//7dEUDCeAYcDvVBgnzWfCcR30Icrz/TOyh4NjbP8fBoe3iC6L+8zpJQ==
X-Received: by 2002:a05:6a20:1d57:b0:d6:c9e2:17c5 with SMTP id cs23-20020a056a201d5700b000d6c9e217c5mr1915374pzb.23.1679647416131;
        Fri, 24 Mar 2023 01:43:36 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-7.three.co.id. [116.206.28.7])
        by smtp.gmail.com with ESMTPSA id y6-20020aa78046000000b005941ff79428sm13682882pfm.90.2023.03.24.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 01:43:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 55A67106665; Fri, 24 Mar 2023 15:43:30 +0700 (WIB)
Date:   Fri, 24 Mar 2023 15:43:30 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error fetching the arm-soc-fixes tree
Message-ID: <ZB1ish+j4oDkbduT@debian.me>
References: <20230324160222.000aad9a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LClHAwlSDfdiRxet"
Content-Disposition: inline
In-Reply-To: <20230324160222.000aad9a@canb.auug.org.au>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LClHAwlSDfdiRxet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 04:02:22PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Fetching the arm-soc-fixes tree produces the following error:
>=20
> fatal: couldn't find remote ref refs/heads/arm/fixes
>=20
> This has been happening for the past few days.

I guess the tree should have been
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git soc/fixes .

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--LClHAwlSDfdiRxet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZB1irgAKCRD2uYlJVVFO
o14JAP4tMiTw0n3rqF1DmUCI27GK400jXEVC9CGNw+neaNG25gD/dRIBKtYgH6nu
0OaTFCwy1X8VQO5VAVgwei245Q2NbwY=
=S/dE
-----END PGP SIGNATURE-----

--LClHAwlSDfdiRxet--
