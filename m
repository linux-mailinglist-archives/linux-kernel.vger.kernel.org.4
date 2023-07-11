Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1DA74FBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjGKXRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGKXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:17:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78F6E74;
        Tue, 11 Jul 2023 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689117436;
        bh=Voycng5tZl4fvMvrRllI4DTHq2vqvF3FID/GJjuQmfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pgywdPrbFHSvgsYXbZwkbENzKappkSgyVAUVqL/yn3jgqSrhACfOohR/trlHvIg9b
         0ipappMwktMz1xGHxkHBFEc1/gv1SGbySN+b7Sqj9wHeEhhnyMf4+wUE5+3U28zEKU
         VpDrrUkEcE4FBgxYrq8LBrTCTyiXTiW8jTv0/YRM0bf8qBf5OO4Gwzocb43t7ZAUhq
         2dE35DDGvSkucZ8x7p+Xgu8Qa99BAC3cdSJVblurJQ5Z7LOh9GPPeB4M69XCcBF/kS
         KgkUcLUDUTUOqqK80LyT7KbKM/HjoLctJb0EOmGAAWSxQcqdrPg72ue98fEwmYh+X7
         dz432SuSsz5bA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0xbb4pvFz4wxW;
        Wed, 12 Jul 2023 09:17:15 +1000 (AEST)
Date:   Wed, 12 Jul 2023 09:17:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20230712091714.760c00c8@canb.auug.org.au>
In-Reply-To: <CAJs_Fx67+VQwveGE3i7Nyp+5R2+Z5mEeDJ9ZMTZEY_gnYtc5Sw@mail.gmail.com>
References: <20230330142818.7efb6d05@canb.auug.org.au>
        <CAJs_Fx67+VQwveGE3i7Nyp+5R2+Z5mEeDJ9ZMTZEY_gnYtc5Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IPwrynDl08lDiJT.Ja=Mn=j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IPwrynDl08lDiJT.Ja=Mn=j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 Mar 2023 07:28:26 -0700 Rob Clark <robdclark@chromium.org> wrote:
>
> On Wed, Mar 29, 2023 at 8:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > After merging the drm tree, today's linux-next build (htmldocs) produced
> > this warning:
> >
> > include/uapi/linux/sync_file.h:77: warning: Function parameter or membe=
r 'num_fences' not described in 'sync_file_info'
> > =20
>=20
> thanks, should be fixed by:
>=20
> https://patchwork.freedesktop.org/series/115871/
>=20
> > Revealed by commit
> >
> >   d71c11cc79d2 ("dma-buf/sync_file: Surface sync-file uABI")
> >
> > Introduced by commit
> >
> >   2d75c88fefb2 ("staging/android: refactor SYNC IOCTLs")
> >
> > in 2016.

I am still getting this warning (presumably now from Linus' tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/IPwrynDl08lDiJT.Ja=Mn=j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSt4voACgkQAVBC80lX
0GzKkgf+KCDHS4286YMtNrzJXdU74fTZ8wo2CzZapGQammrSXXE4/t+0ck9vW5ov
NO5N2WYWcMBLUCzepn0csMeb5UMC071rw5slJ0otTVdFYN5xZXAPT7K8KY8wHe/9
bVLor5rpDzWTwLGYizGBYlyMEQyA08rAbsE64fIvQ4C4AlCSz9CfVeSoy9rp/V5/
pu4K0cyVkhi82rwLMh5/Ups80aWkcfNog1w1fyR05M1gYB319F2J+l2tbt4C53x7
f8acMjTYu5CbZUVK3xUve90OfaW3OQfDpku7XbiDEl+288DosozvLEAYR1F3skBv
+FuKdqz/m3d5P23Ko3xoZmNMo13www==
=0jac
-----END PGP SIGNATURE-----

--Sig_/IPwrynDl08lDiJT.Ja=Mn=j--
