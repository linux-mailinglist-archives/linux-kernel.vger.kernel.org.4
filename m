Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA19612E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJaAN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:13:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89891C1;
        Sun, 30 Oct 2022 17:13:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0tsT4gYSz4x1H;
        Mon, 31 Oct 2022 11:13:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667175198;
        bh=xegPlFecIBiquH+rR1wquFUQHWsEBb6GVrP8Aob7dS4=;
        h=Date:From:To:Cc:Subject:From;
        b=DfpKFFfYKIPitKTTI+yIeNwQiKkOKXKhdQJiaWiGEGfAuCC0uzv6QIMtXAJS7GFEz
         y3f4uiGIovcTPtDk7sm7c+wh+Zh+z6ydgyP/ypYLW6hMEsQswj6DtlS6mbh9tjU4hf
         GX/sZyM3QPHSAWnFVlhA9zkHvypwbCOCuLQ4BZL1+IL5aLfOpv0jRmExQwMtiND76p
         JxtUsfxr0qFjIzLOXN4GM7Z9NlRGR1ASfjEzlvcdFnfpURmgA+PdqJaAy851iL6dMk
         wMMGD2g3WCAFYp0qPQXWZNnQTyIby3105AvRf0AvgXjjvZHPImFwDX6ngzDvxVNcK7
         k7KQlcTfj03vA==
Date:   Mon, 31 Oct 2022 11:13:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@redhat.com>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20221031111315.04b0f8fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+00LH7RwlwPcEvf_+_U2QpE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+00LH7RwlwPcEvf_+_U2QpE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c: In function 'amdgpu_firmware_info':
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:353:9: error: duplicate case value
  353 |         case AMDGPU_INFO_FW_IMU:
      |         ^~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:349:9: note: previously used here
  349 |         case AMDGPU_INFO_FW_IMU:
      |         ^~~~

Caused by commit

  22834837f8dd ("Merge branch 'drm-next' of https://gitlab.freedesktop.org/=
agd5f/linux")

because commits

  b72362962a66 ("drm/amd: Add IMU fw version to fw version queries")

from the amdgpu tree and

  68bc147363bd ("drm/amd: Add IMU fw version to fw version queries")

from Linus' tree are the same patch and git merged this hunk from
both :-(

I have applied the following merge fixup patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 31 Oct 2022 11:05:29 +1100
Subject: [PATCH] fixup for bad merge of "drm/amd: Add IMU fw version to fw =
version queries"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 662704371756..4e42dcb1950f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -350,10 +350,6 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,
 		fw_info->ver =3D adev->gfx.imu_fw_version;
 		fw_info->feature =3D 0;
 		break;
-	case AMDGPU_INFO_FW_IMU:
-		fw_info->ver =3D adev->gfx.imu_fw_version;
-		fw_info->feature =3D 0;
-		break;
 	default:
 		return -EINVAL;
 	}
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+00LH7RwlwPcEvf_+_U2QpE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNfExsACgkQAVBC80lX
0GySfgf/W01DZW6kyviTgOb9Wgvdk54hG4Q/r+yYsXpLGl6WCcFL8Kb6lyH7SnoR
tWsOG0xET7V4S6/c5ge0zPK1ktp/rg1qk55IxO0sq8uMcXk8cfP++lQ4fEdVHcJ8
ocH3Una4FR1ShNRZFPYf7XeOSxGWBcKqZZid0Gk/QCck376UJRoL85lTvTt6YZmv
BzDdjGzJIIdop/VG8YubaLNyGbK6By5a/qu/GqxzXXleBgsD5A/K7XK0Fk6Vsknz
rZrKXXOc2qZxTJhStW7fU1fbs450zkZ+nUoL0DPJ/cJY9xuuF9GeP3prFJHlIAxA
VgFLpau1Y7nuvCbxZmH/naKJcv7uCg==
=NgjN
-----END PGP SIGNATURE-----

--Sig_/+00LH7RwlwPcEvf_+_U2QpE--
