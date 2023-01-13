Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7866A22B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjAMSgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAMSfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:35:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D78209;
        Fri, 13 Jan 2023 10:32:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 078C7B82198;
        Fri, 13 Jan 2023 18:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7C0C433D2;
        Fri, 13 Jan 2023 18:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673634766;
        bh=LMQX4Yk9JoDU1EK8Wku4zAgoynNv0qGCi+JVZ96WGAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xt31pQVRh5BHWgj1bYntbih7Zsf1SbsQB/pBqL19TA5lLR45CbM2Zhaf1apqmt2L5
         Dn/YVTdiBrW1pxrI839F2pTvgfmukmQSKVTYHP14korUvBeUk95wUCVsZQoAPK4Vwj
         3eHdUg7uBvUzo+WFUnXL3F71WT6xtSUl1ykPY8VhBztyb65sNl9tBDw9A2MxxMIZJC
         r2USHW70NUOzjZtYtORHCJdVw1qkvfq1h5XSXi/JWx1dUTsPWMab9/5MDtihdpTIWl
         iEN0ccZtCX7tdYKT1iQ20EveNbVN+tvEKlouhPjbp+U/tHoY/VGmwMyekOq3EfjiBo
         1XG0rgSh3N6kA==
Date:   Fri, 13 Jan 2023 18:32:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        nylon7717@gmail.com, zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/2] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <Y8GjySjm9OjoZvCF@spud>
References: <20230113083115.2590-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8H29E2czozb1Ysd/"
Content-Disposition: inline
In-Reply-To: <20230113083115.2590-1-nylon.chen@sifive.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8H29E2czozb1Ysd/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Uwe, Thierry, linux-pwm

Hey Nylon,

Please run scripts/get_maintainer.pl before sending patches, you missed
both me & the PWM maintainers unfortunately!
AFAIK, the PWM maintainers use patchwork, so you will probably have to
resend this patchset so that it is on their radar.
I've marked the series as "Changes Requested" on the RISC-V one.

On Fri, Jan 13, 2023 at 04:31:13PM +0800, Nylon Chen wrote:

> According to the circuit diagram of User LEDs - RGB described in the
> manual hifive-unmatched-schematics-v3.pdf[0].
> The behavior of PWM is acitve-high.
>=20
> According to the descriptionof PWM for pwmcmp in SiFive FU740-C000
> Manual[1].
> The pwm algorithm is (PW) pulse active time  =3D (D) duty * (T) period[2].
> The `frac` variable is pulse "inactive" time so we need to invert it.
>=20
> So this patchset removes active-low in DTS and adds reverse logic to
> the driver.
>=20
> [0]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatch=
ed/hifive-unmatched-schematics-v3.pdf
> [1]:https://sifive-china.oss-cn-zhangjiakou.aliyuncs.com/HiFIve%20Unmatch=
ed/fu740-c000-manual-v1p2.pdf
> [2]:https://en.wikipedia.org/wiki/Duty_cycle

Please delete link 2, convert the other two to standard Link: tags and
put this information in the dts patch. Possibly into the PWM patch too,
depending on what the PWM maintainers think.
This info should be in the commit history IMO and the commit message for
the dts patch says what's obvious from the diff without any explanation
as to why.

I did a bit of looking around on lore, to see if I could figure out
why it was done like this in the first place, and I found:
https://lore.kernel.org/linux-pwm/CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=
=3DUaSbGCMMF_g@mail.gmail.com/

That doesn't explain the driver, but it does explain the dts being that
way. Perhaps a Fixes tag is also in order? But only if both patches get
one, otherwise backporting would lead to breakage.

The min() construct appears to have been there since the RFC driver was
first posted.

Thanks,
Conor.

>=20
> Nylon Chen (2):
>   riscv: dts: sifive unmatched: Remove PWM controlled LED's active-low

nit: s/sifive unmatched:/sifive: unmatched:/

>     properties
>   pwm: sifive: change the PWM controlled LED algorithm
>=20
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ----
>  drivers/pwm/pwm-sifive.c                            | 1 +
>  2 files changed, 1 insertion(+), 4 deletions(-)
>=20
> --=20
> 2.36.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--8H29E2czozb1Ysd/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8GjyQAKCRB4tDGHoIJi
0te3AQCOUP2q+X8xQoPB6gQEJSA6kxsp3o3UBJtLo2y3rj1ghgEAv5fpkfmkc7fM
XrAwr8T1JhNctwLAS7OsG6CQibVFcQ0=
=wA6w
-----END PGP SIGNATURE-----

--8H29E2czozb1Ysd/--
