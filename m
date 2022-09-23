Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2545E72F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIWEbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWEbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:31:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777A11F11F;
        Thu, 22 Sep 2022 21:31:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYfP8392zz4x3w;
        Fri, 23 Sep 2022 14:31:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663907500;
        bh=6RZSy8XkO3TVmI9kNqvZVcymc4bSnP8YYuNa6Wnieco=;
        h=Date:From:To:Cc:Subject:From;
        b=Af77s9pyLLWwKseYikKWP5S6/Vmg/t/j3sKeKmY2LgqjhLEoSCndDHX+aKyADegY7
         /SjjC2oM3RfuBOSGK8upF35DHQYM1tG82qPg3TSIZl61Mr0gdbmtt4StkEGo2mESaf
         +GK6KEVl2iaAo0DnCa63Vhj1VkgMoj24+4B12ddBECPj9hXtpAFKggh2Mlaj/2Kz9N
         doK1eDkBVPAoguODRpEtHQdXf+LT5P9xDIZbqv9a12h86x2KRMaTp3xRJ+7d9bw0vV
         uo3E3f/pA3jSl/BXZui9Ytu8HvC9JullB2+HFWM5+TMfRB++XngUa0gf3aWrH5v9Xo
         yzfPLwdvue0Hg==
Date:   Fri, 23 Sep 2022 14:31:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Bernardo Rodrigues <bernardocrodrigues@live.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the leds tree
Message-ID: <20220923143138.71765678@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/11IT.UHIXgDjJmKkZyWk+pc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/11IT.UHIXgDjJmKkZyWk+pc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the leds tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/leds/leds-pca963x.c: In function 'pca963x_register_leds':
drivers/leds/leds-pca963x.c:355:17: error: this 'if' clause does not guard.=
.. [-Werror=3Dmisleading-indentation]
  355 |                 if (hw_blink)
      |                 ^~
drivers/leds/leds-pca963x.c:357:25: note: ...this statement, but the latter=
 is misleadingly indented as if it were guarded by the 'if'
  357 |                         led->blinking =3D false;
      |                         ^~~

Caused by commit

  fd6dd9584ed3 ("leds: pca963x: fix blink with hw acceleration")

I have used the version of the leds tree from next-20220921 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/11IT.UHIXgDjJmKkZyWk+pc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMtNqoACgkQAVBC80lX
0GwI/Af8D2nDCMiAj0jbPyExIvmgUFgMj+VrmtU81hp9tyg5DQ38S4uayI1bUiMV
bKHRa3JqJ5q4UJlynOQRubrRBXlxX/PdPtptaX4ICqfWv4ylFnrBiS4QG3Mpabja
aQ3svVRpM392fhfZxbEtKv9FfrY0rW5THCFxgJmrz252XZ3c0c13O3vLZavAw8nr
c1HOELYapFP8V2PlXC9WGWrhSYjG8kMqh+XcdlgSbf4VzRgmeMpbD1+rxHGRZcQI
0tAmBtoNw6pQBjo4Oxi39VUTydYhPTNzjKZIvpfV0eQqIXjyPepWzbvjaVhi1W0F
IatkPlciH/N4bED3As6coZ6ax2/zZQ==
=ZsWV
-----END PGP SIGNATURE-----

--Sig_/11IT.UHIXgDjJmKkZyWk+pc--
