Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022863E3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK3W5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK3W5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:57:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97192A0A;
        Wed, 30 Nov 2022 14:57:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMvjD3ktTz4xGM;
        Thu,  1 Dec 2022 09:57:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669849025;
        bh=lH3ZdNsbzBDqZQvPGPjYU5CgMs8PuJgaZZ7rFv3jwkY=;
        h=Date:From:To:Cc:Subject:From;
        b=dPhWv0FYg+1/xZLFLgSXaQDwgo7cEg9x/dRCSwEVx7gVbMk2Cpwx36VExiqtLvz+N
         l6Ncul0o4h0Ekk9S0/Qnne+YlEy4b+sG+chOKvsJ8y95cRg6RFfBLhnD2u7cE00vFC
         KChZxC+sbFwRBwAsm9bYhUBxRBwI7W58jkthMUz7tTwkGGrByD1VCOlrxKztTxsD6G
         QvcNU+qKTizVa8Xbk5h8RWRaUbdiCX7SI1WbW0QYCry00F2CrMXfU5h9KNJxVOF0Pb
         WfFfdf+i7i26kw+67Ru2ZjPeny7h43IVV0czp82qnDqnO8Vp/JPyaoJ+kHdVGCogX7
         HWAIwX2rsrfjg==
Date:   Thu, 1 Dec 2022 09:57:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: linux-next: manual merge of the drm tree with Linus' tree
Message-ID: <20221201095700.7325e73a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oxECwUXRyVqokrbyUg1Ffx.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oxECwUXRyVqokrbyUg1Ffx.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/gt/intel_gt.c

between commit:

  04aa64375f48 ("drm/i915: fix TLB invalidation for Gen12 video and compute=
 engines")

from Linus' tree and commit:

  46c507f03a46 ("drm/i915/gt: Always use MCR functions on multicast registe=
rs")

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

diff --cc drivers/gpu/drm/i915/gt/intel_gt.c
index 7caa3412a244,0325f071046c..000000000000
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@@ -1018,16 -1103,17 +1108,22 @@@ static void mmio_invalidate_full(struc
  		if (!intel_engine_pm_is_awake(engine))
  			continue;
 =20
- 		rb =3D get_reg_and_bit(engine, regs =3D=3D gen8_regs, regs, num);
- 		if (!i915_mmio_reg_offset(rb.reg))
- 			continue;
-=20
- 		if (GRAPHICS_VER(i915) =3D=3D 12 && (engine->class =3D=3D VIDEO_DECODE_=
CLASS ||
- 		    engine->class =3D=3D VIDEO_ENHANCEMENT_CLASS ||
- 		    engine->class =3D=3D COMPUTE_CLASS))
- 			rb.bit =3D _MASKED_BIT_ENABLE(rb.bit);
-=20
- 		intel_uncore_write_fw(uncore, rb.reg, rb.bit);
+ 		if (GRAPHICS_VER_FULL(i915) >=3D IP_VER(12, 50)) {
+ 			intel_gt_mcr_multicast_write_fw(gt,
+ 							xehp_regs[engine->class],
+ 							BIT(engine->instance));
+ 		} else {
+ 			rb =3D get_reg_and_bit(engine, regs =3D=3D gen8_regs, regs, num);
+ 			if (!i915_mmio_reg_offset(rb.reg))
+ 				continue;
+=20
++			if (GRAPHICS_VER(i915) =3D=3D 12 && (engine->class =3D=3D VIDEO_DECODE=
_CLASS ||
++			    engine->class =3D=3D VIDEO_ENHANCEMENT_CLASS ||
++			    engine->class =3D=3D COMPUTE_CLASS))
++				rb.bit =3D _MASKED_BIT_ENABLE(rb.bit);
++
+ 			intel_uncore_write_fw(uncore, rb.reg, rb.bit);
+ 		}
  		awake |=3D engine->mask;
  	}
 =20

--Sig_/oxECwUXRyVqokrbyUg1Ffx.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOH37wACgkQAVBC80lX
0GzfMwf/Qepx3h9aOZxYgOEt7rWD7j5qK0RXF6BWoM3cH7eFzzP5/+fFuLrXB2ma
ZVZVrSZYw3hUps2CuxGuPGGvlfl+p+PWT3r8RQYOeYeh1a9r2eFPIghL8k9PALz8
Qw0StT3jlOwiq4YiUNgKQL54SCG2AxLKZTRuzZ7rig1RWFASuOk6gCdMJZlcygjf
pA7WdCwXtJl+7dw9Qx5rJtdYXktuEiFeFz7Ne+Jw1bFjocKFOirlUsBuDfmOOcfn
bK2L1o8zU7WfJAKUXyfkVvgJniEkb1E0cV7O5ZmMdowXPV1b2AnD7mRZZVoDgqHO
L8tmtAccPuBye0y+9nrd8WUdcJG/ww==
=+Eex
-----END PGP SIGNATURE-----

--Sig_/oxECwUXRyVqokrbyUg1Ffx.--
