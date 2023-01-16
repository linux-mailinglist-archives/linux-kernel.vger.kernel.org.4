Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EF766B502
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjAPAsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjAPAsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:48:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F316A61;
        Sun, 15 Jan 2023 16:48:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwD012FZJz4xN4;
        Mon, 16 Jan 2023 11:48:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673830082;
        bh=Kk7LmYSiUdabC6NM/uJYVXidhPuM75gjB2dhBJCY2FE=;
        h=Date:From:To:Cc:Subject:From;
        b=gWcBwY3K/CV0U3EKvugXlSHcO4b1zPtcQCj5abYNNXrYeGf/43f4aPYOVb76ucw9K
         tKBCiLlRwcWN3qPLk31EJbfMwf7Dokj9KNh9Rg6qhoXUStYJwJBeSSi3zYMEr4VOTY
         wNk2qe9omm6hvjcdQJGM89pqNB73lqHYFkVZW50tN69/WTDu/ZXNEiClLZ9ukf4jAP
         eOlZbdrj5e1HhYCLZoW9e5tokoTwSoHQFomqS1aK3Er5Te4Gw1iF1cttzXxQDD4L6U
         oOt2fNr0xnzufyRBwfzUIHvzuXqvuNZs5bO9Z4uFJNRx5F1L5RFk6/rg+wtRkDwS4a
         JG9yLF8GZ9sIA==
Date:   Mon, 16 Jan 2023 11:48:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Wenjing Liu <wenjing.liu@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm-misc tree
Message-ID: <20230116114800.1c679494@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NVqzA=7Sy=nX.MN56hWX+xR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NVqzA=7Sy=nX.MN56hWX+xR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commit:

  a6276e92a037 ("drm: Include <linux/backlight.h> where needed")

from the drm-misc tree and commit:

  a98cdd8c4856 ("drm/amd/display: refactor ddc logic from dc_link_ddc to li=
nk_ddc")

from the amdgpu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 55a845eb0c6d,7bf21bb52a7d..000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@@ -66,8 -66,6 +66,7 @@@
 =20
  #include "ivsrcid/ivsrcid_vislands30.h"
 =20
- #include "i2caux_interface.h"
 +#include <linux/backlight.h>
  #include <linux/module.h>
  #include <linux/moduleparam.h>
  #include <linux/types.h>

--Sig_/NVqzA=7Sy=nX.MN56hWX+xR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEnsAACgkQAVBC80lX
0GyrjAf9GGbR9B/kINbc2o/KvNE3ntL0yHQjz40W9MfUn4wKnUi+gvwHr2y6p2it
GWZ/MXaBRdX2QaSs1iHu6RF5MYF/TF0/0QRjpdraOyDL1m9SM0CBoJZ9rFDGyAk2
8aQjQrmhvcysedcLTfe4U5w9cyFmLDKje3TZvyNzvBcOs4Dg/QTO53gFlIz/q/6Y
lxAp5TNfvkNWT4MgzMpvqbdaxAGkNDyQwUcoxLcUOjMlt/A8is2v/cM3wNZWo46z
NhfPFqt3nAZL8hDIWrvjW6B+dizMzVqRlPve/bS1BuxS0ny2upH9xCG2/6nQ3etF
ENVSxyxpSCMcqmOxA+OrEK2W9T6b0w==
=T2Ma
-----END PGP SIGNATURE-----

--Sig_/NVqzA=7Sy=nX.MN56hWX+xR--
