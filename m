Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA0710A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbjEYKdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjEYKde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF010B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:33:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF0F661382
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4966C433D2;
        Thu, 25 May 2023 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685010812;
        bh=lastZx5SZ9z5uaXi7f0nP+cp3xVMrDoq188o753MBdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbFjn/PfAY/ZC+BnbBH6Prx+vdzb0oTFDqpkPMJpHiHwGw3q1F+aWJ+KTL88cE90a
         obSlu80dtiN2iJ52db6wbnHHeVnla8cRFSV3JdTPNb5ozbtDTLAWQ+H6YKeMvqGJ4E
         Di+SH0YiqKLv7qKZKx8V5NdCC5KdxU1/Sjv2ZJdMPdTWIaoWAnFGlIZayI3DDG+Swl
         JqnPtgtUFNWZLadLViX8W31azH8Dt/972ymQqN89ea7jh8bg1W6MgaJ+sf17xSl7WT
         cenMfs4Q6uUycDWPd0q9VkwqE8vlhsxkji/respup7qXx/voWnjJKo21X+49hyf+JX
         OOv6xq8ooMSmg==
Date:   Thu, 25 May 2023 11:33:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Osama Muhammad <osmtendev@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] regulator: core: Fix more error checking for
 debugfs_create_dir()
Message-ID: <22d1dd88-6bf4-444a-8ea1-61ef627ca7a0@sirena.org.uk>
References: <cover.1684930647.git.geert+renesas@glider.be>
 <f8e4716278b0a6fe7d9e5537715eb21dcd991d1d.1684930647.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Ew73XuzqX1/lYTh"
Content-Disposition: inline
In-Reply-To: <f8e4716278b0a6fe7d9e5537715eb21dcd991d1d.1684930647.git.geert+renesas@glider.be>
X-Cookie: Enjoy yourself while you're still old.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Ew73XuzqX1/lYTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 02:22:17PM +0200, Geert Uytterhoeven wrote:
> In case of failure, debugfs_create_dir() does not return NULL, but an
> error pointer.  Most incorrect error checks were fixed, but the one in
> create_regulator() was forgotten.

This breaks the build:

/build/stage/linux/drivers/regulator/core.c:1916:11: error: expected identi=
fier=20
or =E2=80=98(=E2=80=99 before =E2=80=98else=E2=80=99
 1916 |         } else {
      |           ^~~~
/build/stage/linux/drivers/regulator/core.c:1933:9: error: expected identif=
ier o
r =E2=80=98(=E2=80=99 before =E2=80=98if=E2=80=99
 1933 |         if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS) =
&&
      |         ^~
/build/stage/linux/drivers/regulator/core.c:1937:9: error: expected identif=
ier o
r =E2=80=98(=E2=80=99 before =E2=80=98return=E2=80=99
 1937 |         return regulator;
      |         ^~~~~~
/build/stage/linux/drivers/regulator/core.c:1938:1: error: expected identif=
ier or =E2=80=98(=E2=80=99 before =E2=80=98}=E2=80=99 token
 1938 | }
      | ^

--1Ew73XuzqX1/lYTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvOXcACgkQJNaLcl1U
h9BgKgf+IxF8wNfDs3nf1qMktu3v4cIvlrN/cvCtFlQohBYLfBxs2I9E3qcORK0c
KvBo194IcIal+LDov9i6/CMMjkmvmR4VgtD3TplTb18NKBBgtYr6vi4LTVvmiqVZ
tWp6KtaAtEazfLIlr4ysGIBK69KTzdD4ghJAFmaaIvjfVuQ7E9CrR/Elu59Ru487
78+pURiWPCajru5USKgj1ve3gvITJ1q+I2xECqXHLgiLP/CkqXQ1RxF8RfnxNpzx
yOMmyLfzaMvRsYbTM1yZ1madTjdo1f4WfVhk3i3tS1n8aQ3xIRXWo3z8ecYPcAyV
MgIjjUXtZWCI2ItOEI0Oy2wkl2SQXA==
=gwy9
-----END PGP SIGNATURE-----

--1Ew73XuzqX1/lYTh--
