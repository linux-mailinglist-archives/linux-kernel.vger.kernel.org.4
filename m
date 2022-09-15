Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16D75B9B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIOMjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIOMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:39:07 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67049844CB;
        Thu, 15 Sep 2022 05:39:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id e18so7626791wmq.3;
        Thu, 15 Sep 2022 05:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JowbcqaoSeHYfBdTSmK7yPgn5pXXbUiwgqBzQ++Q3hY=;
        b=Zds6NGqWZZ8qjwOAkmr3ltzpBLskhG8fdSr3MDcQ2Y9bwqVzgQcnifi7N3M1lTlk5V
         PxmB/A8BKT3rs4TZogzc8BG8tw76D3WstQAobiHRlCJ5HhxKRnJxaemiTP6jT8+Zxcfs
         BtTsNSKXvFryyTsvhw8Q7uBJLlsXZPRF5A4Bc/cCR/xcQtny7OqCcgPfzPFZihXLi73F
         SCKiP1FiM0dpH4LH2yyWNrxZNkI9D0M5tJrFx7sEmDLWUHWy6ul6cO3y7ys24eGdPU0F
         2XWgSxU57fF7M/eZBmj3dYfKXIaB+rPXIwof6BTYBm/D+wEWRb52UqAAkqSRL4vSV3NS
         wHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JowbcqaoSeHYfBdTSmK7yPgn5pXXbUiwgqBzQ++Q3hY=;
        b=ldB3dYE9AbgLbF8Wet9EtYjPl7ZWaC8L9ahav+SBgipvI3c9TrBs3ioQKacIm+Xgy0
         /NqbkhW+I1+PcnGvw2UBziBhb/euUWJGXcvSMPZzBkKEs4WoaLa/1/3YN3nvOyOFM/A8
         MvPIR4W4bWY309VIxh0/1CwxJR0e9ORSrsCyuLhzFxRY/WASn9eyqtnH83WlRPMN4Cit
         HFeZwjxJ9KRe2ylxJFBj/RuX/HdnmK1cB69dzhXoDX6kjMRU+UjsMjFz7mWVwnabsROD
         Lcu8CHnRUhoUpZj6jE20zRr0r1rO8+QrspJttkkZ9z+AVB77A3+ea0qUX5Rn9gcb52E8
         wNAw==
X-Gm-Message-State: ACgBeo3f/ljQwvrrs6WFRy6mF7lANmHn6GsadWNWphsSiiDxjPfE0yXJ
        SbzG6dtYeslvWsGK4NGkeBg=
X-Google-Smtp-Source: AA6agR6p+cQR2KXMA9mKPBtsRgWmraQ/EvHReKZd5/k0gahtz19cEOPpIXYgYOGYaCCdfCyrrcA5ag==
X-Received: by 2002:a1c:7315:0:b0:3a5:ff61:4080 with SMTP id d21-20020a1c7315000000b003a5ff614080mr6482824wmb.196.1663245541937;
        Thu, 15 Sep 2022 05:39:01 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fc8-20020a05600c524800b003b48dac344esm3199521wmb.43.2022.09.15.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:38:57 -0700 (PDT)
Date:   Thu, 15 Sep 2022 14:38:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: Re: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO
 driver
Message-ID: <YyMc4OkYLLXjiHmL@orome>
References: <Yhe0pCpfeCpyfPWg@orome>
 <20220816102725.14708-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ObJgmcXHiByHBDO8"
Content-Disposition: inline
In-Reply-To: <20220816102725.14708-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ObJgmcXHiByHBDO8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 03:57:25PM +0530, Prathamesh Shete wrote:
> Using this patch we are adding PMC compatible string for
> Tegra234 in GPIO driver so the IRQ hierarchy can be set.
>=20
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/gpio/gpio-tegra186.c | 1 +
>  1 file changed, 1 insertion(+)

I already acked this on v1, but here goes again, for patchwork:

Acked-by: Thierry Reding <treding@nvidia.com>

--ObJgmcXHiByHBDO8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMjHOAACgkQ3SOs138+
s6Hy/Q//dhxKqkvTQwx5kDgrAsB3vWecsum9vMvaN3wqNcheDRlhaNuVY2Q+j2nF
qNZGvIDjJofnu7TNuCgZE/Kzmtla36JZxLwP1z8u4a5S8F7urkb4jHIJSIwROKfi
mFFx0Dhf0h1/48xmI1S0M3gf/cX78gLMoMRsZ2tRb8oaMxIrvrBI8Q/6kcQXHi5s
Ru3U918eU4sVeM3s6WhQHd14ynzkDTuALOOGWP0n1ouSnU0yClSxv8oxfnhdBqDr
FtNh1DaKDRGVRp0w/jbNFUJaPKBOuEHw2f8wRYAo4TqSFHqVfSfMlHwcbRyNR3JC
WjBo4ieXw6TPLHVHmeV0ol9+1oPUxevafOpxQk1IlZKXfzah2twdeR+HVhsV+3+B
0o6v6O43SomBnz1pzRTmBy73p4LdWGLd/Vx+42+1Bipl53vriWmjaAiapScJt+fK
wvGfeerLeZoUiEicL3y7PYQrhRF5ExAtvgICo2ndGhjDl0enPWUl+kYRchv4yDXE
oCJTONfKvoJDn7ttMGcM1Ar15p8E32GRhrHxIrYfkYGE6oklZFzQDWeTxvms+8YJ
bGZsj3kNSC7x1E2PxoRR+6ckGSB+fm5fuJiWl9mTfU/zocWYsINM3kGl1SzCV+ZZ
S+IbJWLrBm2blnEZhXAVCL0DOzUkl7hwqF8yc3+BKTxvKM9026M=
=wZRJ
-----END PGP SIGNATURE-----

--ObJgmcXHiByHBDO8--
