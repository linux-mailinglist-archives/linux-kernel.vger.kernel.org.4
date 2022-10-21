Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD66606C55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJUACr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJUACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:02:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA331F040A;
        Thu, 20 Oct 2022 17:02:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mtl5m5Rfdz4xGT;
        Fri, 21 Oct 2022 11:02:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666310557;
        bh=MjsN/eyeofQCiAF8hY6LImhgi5IuAOlTJYnxg+e5XII=;
        h=Date:From:To:Cc:Subject:From;
        b=htqxJ/s81/O5Nb0nGxtRIU1sQ+cNz9SmYkXxC6mGGVLs/zMniojTSUPPNkNxMB4lO
         1EjXixQE29xk2I/sNeJwy2fKYHsUwhaAdlLllUna8QVwPWLrPNyUxLN5tej2SEGxIa
         hD4crHPw0JStuFIf99kN/97nz1jYnJy89FBmrKa8xpognqql1tlZZPzRe7YVGAF9V9
         6Gbsu3TsBWYT0X2NatHPpusBEATu0IZ2BCrLjUGg/SRm0xa9y9LwDlAKcAUrZ1ubnt
         XgqwVdS4IZeihPIqLwQCYPDeZADGsPx38V8oF0eehUTo7qvlVt4ci5BghWnF/bxLCc
         j7yT5ceHOipUQ==
Date:   Fri, 21 Oct 2022 11:02:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20221021110234.51f9ab66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lwpP884_0BVkJrtlgfprAkY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lwpP884_0BVkJrtlgfprAkY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/nouveau/nouveau_display.c: In function 'nouveau_display_cre=
ate':
drivers/gpu/drm/nouveau/nouveau_display.c:662:29: error: unused variable 'd=
evice' [-Werror=3Dunused-variable]
  662 |         struct nvkm_device *device =3D nvxx_device(&drm->client.dev=
ice);
      |                             ^~~~~~
cc1: all warnings being treated as errors

Introduced by commit

  7c99616e3fe7 ("drm: Remove drm_mode_config::fb_base")

I have used the drm-misc tree from next-20221020 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/lwpP884_0BVkJrtlgfprAkY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNR4ZsACgkQAVBC80lX
0GxliAf9HxvpCb9hc+2CQgGCkBWspRTmqUs/DDH0l3jQSuG0lNIsBi2n4Do/iU46
3zkQa/4ujPahMMbxZI1SxYtv/DV7zhduW5vSSBgC3jSe/9+78fpJpQg9Uhqv/0G1
H58j9c+DbFNv4oReEAKlsBoMpE8VpafFUDqN62UBwAyV5h1Cp6gWl+FM0Nygu0fP
JgGAdvt8RYfYG6Y2KI+nF976WnxIDF7WinEui91ZJinjsnsSy+ftwF1IA34Q8kXk
3M3vTFkGRszQh8hDD5rjAcc/7xBjM3XlbDb82Fp1y85hvPMjalggMcS2+7B+NcYe
GlwRzVWfOlmGUNd1wIyqGGAj3BLPnQ==
=7Au/
-----END PGP SIGNATURE-----

--Sig_/lwpP884_0BVkJrtlgfprAkY--
