Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A3601C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJQWFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJQWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:05:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60D7269C;
        Mon, 17 Oct 2022 15:05:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrrfH4Jy9z4xGm;
        Tue, 18 Oct 2022 09:05:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666044344;
        bh=EPhBXfS+bFT0iossjSTvhCbbZ9sAlv5VbZmlGq7HH/g=;
        h=Date:From:To:Cc:Subject:From;
        b=BKmqcFdarvAn9alD/3LlGWl4uOfgj23jEJcwWNU8Y0oPdWVwspPgCC9NffDevm9LJ
         k6ebiHR8Gse0INnL5tSpQUj/MbYxR/Eg7MMIJaobB6jt2zwxuu5yzUuviuA43cUZWr
         QQr8wNOr6bDbsMXF4Exmhzmfp8aDuK3K0N4loFJtRYECLRzOs/mKPbQ33WaIe0HPnN
         i6VbTv+WST4CO0wKHKERm0z6I3AWAomCUSuBK+I13OOaH3ovUFl7T8gcUITjOgIRUJ
         dcEo11ZjXfOza/FaHInY3Ac8srWY10lSUvKw2hbvTO2zDscBHHNnVSgOI1rQruTGxh
         B3W3nGnx1LF/w==
Date:   Tue, 18 Oct 2022 09:05:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20221018090541.74bff3e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fz0I3tpa+572v0s.XfWnKH8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fz0I3tpa+572v0s.XfWnKH8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_driver.c

between commit:

  1c66a12ab431 ("drm/i915: Handle each GT on init/release and suspend/resum=
e")

from Linus' tree and commit:

  3703060d17b0 ("drm/i915/display: remove drm_device aliases")

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

diff --cc drivers/gpu/drm/i915/i915_driver.c
index c459eb362c47,e7b2ebc6b88d..000000000000
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@@ -337,10 -324,11 +337,11 @@@ static int i915_driver_early_probe(stru
  	if (i915_inject_probe_failure(dev_priv))
  		return -ENODEV;
 =20
- 	intel_device_info_subplatform_init(dev_priv);
+ 	intel_device_info_runtime_init_early(dev_priv);
+=20
  	intel_step_init(dev_priv);
 =20
 -	intel_uncore_mmio_debug_init_early(&dev_priv->mmio_debug);
 +	intel_uncore_mmio_debug_init_early(dev_priv);
 =20
  	spin_lock_init(&dev_priv->irq_lock);
  	spin_lock_init(&dev_priv->gpu_error.lock);
@@@ -738,10 -716,6 +739,9 @@@ static void i915_driver_hw_remove(struc
   */
  static void i915_driver_register(struct drm_i915_private *dev_priv)
  {
- 	struct drm_device *dev =3D &dev_priv->drm;
 +	struct intel_gt *gt;
 +	unsigned int i;
 +
  	i915_gem_driver_register(dev_priv);
  	i915_pmu_register(dev_priv);
 =20

--Sig_/fz0I3tpa+572v0s.XfWnKH8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNN0bUACgkQAVBC80lX
0GwZswf9Ex70u3pOOY+Xt1dR5Q1NHc7MvwRTTfQB0LBv0FeHcWUYzyYGeX0GDZx9
Dy3Tzg20hypsU31r0I/Vtgb0k1Op3ejTuyhtqunilsvP6nEYlfWGlTmQNfUtVKHi
I8mgsje/YJY1AlNwWRE5vOSJYkwABuWRHjs1ooESN5gcoDRVreL2cU3dVz3oGgij
f2gGjG/JstVJHUZ52RTz5RIJl3w+BG8NX1Yv/pRWYRDGE6yEGSUIgRWryUogEnZh
QGeVPFswVnd1g2UDh0lc7h80SuxaCZDr/ZbAtH7zvfuu1eFk9wYRuerphunHBou5
oWhkP+R4nScB03Jv/h+n6qn6+dLHMA==
=5X0x
-----END PGP SIGNATURE-----

--Sig_/fz0I3tpa+572v0s.XfWnKH8--
