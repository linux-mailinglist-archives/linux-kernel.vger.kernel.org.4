Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C45F52B9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiJEKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJEKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA873B1F4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 03:39:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5BA6162A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 10:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C7AC433D6;
        Wed,  5 Oct 2022 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664966344;
        bh=oUmHl1Xtu+lT+FmSd3TPUL0sRmof/SNKdPvoAmpleRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CX5quxp7wwY9Yl/j4qTosTe0brNgD+XY4+5m1jCh7/5iFnRRer6mWYbJA4k2xMSp8
         BV8ljgugaJ6BPbWuNhCzeLmqYpl9AbMnWGdjSGhDmCQN9TJ3tA2TguCf4kxUtJsQzt
         n115G4Dmg2oKr8YskY4x/eFvvmO4UddoWvY9BiqXSXn0Rg+c8lfcsi9HWpsayBCUPZ
         ss8/v879kz8eZdoZzc2C5i1eLmw5XSzEyIKy+gcDveSln7/NSDutv8q1hC6gSJ55u/
         4r7WTSC9+wztZ9S+yz01Ye5E+3sbG4DL1U5pzqCp17xCFtw3E97ZZcQofwan7T50NP
         TcmxS+QwfTL2g==
Date:   Wed, 5 Oct 2022 11:38:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: mainline build failure due to 81c0386c1376 ("regmap: mmio:
 Support accelerared noinc operations")
Message-ID: <Yz1ew+EdD94TjQYK@sirena.org.uk>
References: <Yz0koHybNXGTFfDr@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hRCqAwe0BTcLGntM"
Content-Disposition: inline
In-Reply-To: <Yz0koHybNXGTFfDr@debian>
X-Cookie: Poland has gun control.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hRCqAwe0BTcLGntM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 07:30:56AM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
>=20
> The latest mainline kernel branch fails to build alpha allmodconfig
> with the error:
>=20
> drivers/base/regmap/regmap-mmio.c: In function 'regmap_mmio_noinc_write':
> drivers/base/regmap/regmap-mmio.c:222:17: error: implicit declaration of =
function 'writesb'; did you mean 'writeb'? [-Werror=3Dimplicit-function-dec=
laration]
>   222 |                 writesb(ctx->regs + reg, (const u8 *)val, val_cou=
nt);
>       |                 ^~~~~~~
>       |                 writeb

I'd forgotten about this one, sorry, and alpha isn't covered by things
like KernelCI so I didn't see the failure when I checked before sending
my pull request.  It's fixed in -next by 7e772dad9913992 ("alpha: Use
generic <asm-generic/io.h>") from Linus Walleij which is in the
asm-generic tree.

--hRCqAwe0BTcLGntM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM9XsMACgkQJNaLcl1U
h9CUBgf/SKtKMe9yVDcS1Yyf4tUnYgbAepauxKnEvxpc9TEtC6UKPijW45+tF3ko
PpwYclFYJZFIysR5X2+/IXW2aHUYL8mz2iY2mdasNb6DaLo+lWD58jf2U30kTKC4
s+yr/WdCG5m8yfWeTWcT5ckXJs+QNndpJjxMUFjny9YA4fSdRiBRSpD/KBN3QTZT
uudheRtwS+h5MTVcjGVxR6GS72J+9bAF5WQOInWOqpceyZFkN4kf5Y65nCdEFo2K
GkIwfhbk+kunTMmXnvYGSKjIfJHGE84Psjpjg1dW906GzR7V35gDyUfjTKwQUeRw
1DVMVHfGJn1+PaZ9kXG/dZKp1Efa5Q==
=oyjU
-----END PGP SIGNATURE-----

--hRCqAwe0BTcLGntM--
