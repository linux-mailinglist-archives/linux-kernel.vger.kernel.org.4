Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE07349AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjFSBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:18:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED61B4;
        Sun, 18 Jun 2023 18:18:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QksMT5PTjz4x0B;
        Mon, 19 Jun 2023 11:17:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687137478;
        bh=3GkgCEb+I0Mdl4Zdw8oQq3JXp496a5S+tCyi6fFcyEE=;
        h=Date:From:To:Cc:Subject:From;
        b=eOBZJ5LJIVq1z65Qm9w/Rq1cPme57oMCPkwhzfW5r0YQqJkBVbpzmWns4FSYJBUbh
         julOp30RTo4F5KjopvWwZ7YSeRhBgaX2QFdlimCTQY4TVJB5Nszc+F3ThHDSkR/EvL
         P1ZaxxEfxI+WkHOei2/vLT5iuwhGShhWcPba3oXoK+yumIqpfkwdmdD+xlGQz4octd
         wJpArpy0aIFlUuVq5u8JXRp1LYSo+3IoanEdhBORX51digpEFwSiNnbAH11z1RMO4K
         Hr84NMxnCn10zzuVlqakQDXMYFwXK4okzmwb48EDyAXV1p7VLCL+3mLUnjnMY7XqXv
         FeZ84TuQMxEgw==
Date:   Mon, 19 Jun 2023 11:17:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Philip Yang <Philip.Yang@amd.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20230619111756.452d0129@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sx=Nyc1AJ_H3UC9q_ot56pt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Sx=Nyc1AJ_H3UC9q_ot56pt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c

between commit:

  34e5a54327dc ("Revert "drm/amdgpu: remove TOPDOWN flags when allocating V=
RAM in large bar system"")

from Linus' tree and commit:

  7f6db89418f9 ("drm/amdgpu: dGPU mode placement support memory partition")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a70103ac0026,f76649e523a0..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@@ -139,8 -149,8 +149,8 @@@ void amdgpu_bo_placement_from_domain(st
  		places[c].flags =3D 0;
 =20
  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
- 			places[c].lpfn =3D visible_pfn;
+ 			places[c].lpfn =3D min_not_zero(places[c].lpfn, visible_pfn);
 -		else if (adev->gmc.real_vram_size !=3D adev->gmc.visible_vram_size)
 +		else
  			places[c].flags |=3D TTM_PL_FLAG_TOPDOWN;
 =20
  		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)

--Sig_/Sx=Nyc1AJ_H3UC9q_ot56pt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPrMQACgkQAVBC80lX
0GxaDQf/Yya5+wwBnWUhQ71mkV9FJuG0vgv44/j3JjsUyFWi9gEZhVmXL6aLBd3Q
kph+xmMNJbISAQ+NPv/euPSl8lP9M5UIG5h+6ELPOqe74r/QXlI8gzc9sLz7U7UG
r5PY2JCJhh2++EYIq+z+iYLtDzDUNQCEZcOoKuyUbFkx0u/REoRKHcWTOscZHbsD
nhkOoya3cDSkhuEdr00mg03IwC3rX135WSQ2Vc0sVLMXW2KiaSYijMP+iACUPtvz
9V+ax6kTJlHHKc7pmjl29pFRDXDeOQPgCbWUEC9gwsO0JnzrnVTZMpMxmc2y+UBt
eHCHopbw85Jm87YT8hpR2CO9JVB6Vw==
=JQkm
-----END PGP SIGNATURE-----

--Sig_/Sx=Nyc1AJ_H3UC9q_ot56pt--
