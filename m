Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E950867A709
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjAXXn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjAXXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:43:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF2650840;
        Tue, 24 Jan 2023 15:43:24 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P1k6d5Vx0z4xwy;
        Wed, 25 Jan 2023 10:42:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674603771;
        bh=kPBi/8E5CuSntCZaz43tWi9KctTXAvdEQiXJjhsQLOQ=;
        h=Date:From:To:Cc:Subject:From;
        b=H0+6J647IHzPsBmfE8Ycy+AKyzIHUVY4jVmE8deFienUcyjmkJuC7egk95FPRorxs
         /KM8NAwIVmTlyzGKDFH7Pr+4FYEK4WNSWPvE1WrexBn4X/TsGf5PLTbZFqyStp8vMI
         pYFzdE1cnP+bD1X4YYVWoeDzDO3JBEl3OYJDVB1STPSSwsdmdZfi2KwOYILr97gJgm
         qjJQ85RSE8cD3gwYkJz0rcpPZHzjBNsGsTBsl+5WsM8vrpGQ0TZPjRub1/e+vlQlFR
         z2XdUtXwUfWzg2w6TjrDj62Hv7glTUNrfzAxqhXte5LVKszcNg2OqQEaSKDEFD+PHb
         oB4q0v6ZDIe8g==
Date:   Wed, 25 Jan 2023 10:42:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm-intel tree with the drm tree
Message-ID: <20230125104248.1e9775ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YFEVt+CWCA0SvQrBVfs6TPm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YFEVt+CWCA0SvQrBVfs6TPm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_drv.h

between commit:

  f67986b0119c ("drm/i915/pxp: Promote pxp subsystem to top-level of i915")

from the drm tree and commit:

  a3f839762ceb ("drm/i915: move pch_ssc_use to display sub-struct under dpl=
l")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/i915_drv.h
index 48fd82722f12,ac4c3c6f5541..000000000000
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@@ -65,26 -65,40 +65,41 @@@
  #include "intel_uncore.h"
 =20
  struct drm_i915_clock_gating_funcs;
- struct drm_i915_gem_object;
- struct drm_i915_private;
- struct intel_connector;
- struct intel_dp;
- struct intel_encoder;
- struct intel_limit;
- struct intel_overlay_error_state;
  struct vlv_s0ix_state;
 +struct intel_pxp;
 =20
- #define I915_GEM_GPU_DOMAINS \
- 	(I915_GEM_DOMAIN_RENDER | \
- 	 I915_GEM_DOMAIN_SAMPLER | \
- 	 I915_GEM_DOMAIN_COMMAND | \
- 	 I915_GEM_DOMAIN_INSTRUCTION | \
- 	 I915_GEM_DOMAIN_VERTEX)
+ #define GEM_QUIRK_PIN_SWIZZLED_PAGES	BIT(0)
 =20
- #define I915_COLOR_UNEVICTABLE (-1) /* a non-vma sharing the address spac=
e */
+ /* Data Stolen Memory (DSM) aka "i915 stolen memory" */
+ struct i915_dsm {
+ 	/*
+ 	 * The start and end of DSM which we can optionally use to create GEM
+ 	 * objects backed by stolen memory.
+ 	 *
+ 	 * Note that usable_size tells us exactly how much of this we are
+ 	 * actually allowed to use, given that some portion of it is in fact
+ 	 * reserved for use by hardware functions.
+ 	 */
+ 	struct resource stolen;
 =20
- #define GEM_QUIRK_PIN_SWIZZLED_PAGES	BIT(0)
+ 	/*
+ 	 * Reserved portion of DSM.
+ 	 */
+ 	struct resource reserved;
+=20
+ 	/*
+ 	 * Total size minus reserved ranges.
+ 	 *
+ 	 * DSM is segmented in hardware with different portions offlimits to
+ 	 * certain functions.
+ 	 *
+ 	 * The drm_mm is initialised to the total accessible range, as found
+ 	 * from the PCI config. On Broadwell+, this is further restricted to
+ 	 * avoid the first page! The upper end of DSM is reserved for hardware
+ 	 * functions and similarly removed from the accessible range.
+ 	 */
+ 	resource_size_t usable_size;
+ };
 =20
  struct i915_suspend_saved_registers {
  	u32 saveDSPARB;
@@@ -366,10 -337,6 +338,8 @@@ struct drm_i915_private=20
  		struct file *mmap_singleton;
  	} gem;
 =20
 +	struct intel_pxp *pxp;
 +
- 	u8 pch_ssc_use;
-=20
  	/* For i915gm/i945gm vblank irq workaround */
  	u8 vblank_enabled;
 =20

--Sig_/YFEVt+CWCA0SvQrBVfs6TPm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPQbPgACgkQAVBC80lX
0GwZWgf/cbJAKEnE267fH8cg5Ou2oj/uN4NA3u7erJNrLODGNPIuGshxJ8um2fvh
B5+rknYhQsoMhqCPmwgXClt4+mjJURFyzqrDDZ8/Ya7hRd6D2MtOCaCB8lvFwGh8
GSd6KV/rVqPrULc91zBVSY3Cj+0rGjG/nJpviZ5qFB/T131DBtt+q34thgxMuZAe
BKbQS2gSzLJzSrhp88EKXrb6sGd/7SEbDfIRwbwm4Svzw5tZSOsnVq1SjjOH6QFY
+JFLP1U/UGYtZrAYt5BE5RHtZhBHTIeDwOH4stUH1xf0iccDZli9VKxvMrbt56x1
RLWhsh1+3GDhgl/4p8+WuILdAVkxng==
=MHe5
-----END PGP SIGNATURE-----

--Sig_/YFEVt+CWCA0SvQrBVfs6TPm--
