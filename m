Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811EF623803
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiKJAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKJAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:10:41 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E429365EC;
        Wed,  9 Nov 2022 16:10:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N72Kp0Kyvz4xGT;
        Thu, 10 Nov 2022 11:10:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668039038;
        bh=7NJVAvlEwmwSk1lEugHbvaQ3Djwk5pg2l77rzitW5zU=;
        h=Date:From:To:Cc:Subject:From;
        b=HbzjsAiTjm/cDpadZMmcAhg5e5Op/A/JZ6p+JTAv8DnAAZsuzx/0TWHqN7b9Q9sWq
         rxuAmcaABF3Syj9SyrIsLgEiZnHoshquZ4RkTrGdGanv8XT+pZ3hVrP5VWW2nmihku
         s7gT7B6MtOdrFtOQS9if4QhZIt/puLJbSYh8FNjXxof7uixLLlGtYkORLpJNt2LMPC
         mEHROv3V5PutaXXNQ40LxWLzN1ql46WmCkrx9hveBwotHpJMnt7hmVWzBt6QvnK1Vf
         ucGC3A7LU1xrgn4qwPWtMEHnHaRPPoebCjzoLr6viODVtgwcRVCURWYWrDQyZKZ3Mg
         EJkU20XZvbJ6Q==
Date:   Thu, 10 Nov 2022 11:10:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20221110111036.63cb67d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Q6grKnV+8CBG.WbU_PfLWh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Q6grKnV+8CBG.WbU_PfLWh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpu/drm/nouveau/nouveau_drm.c: In function 'nouveau_drm_probe':
drivers/gpu/drm/nouveau/nouveau_drm.c:797:17: error: implicit declaration o=
f function 'drm_fbdev_generic_setup' [-Werror=3Dimplicit-function-declarati=
on]
  797 |                 drm_fbdev_generic_setup(drm_dev, 8);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  8ab59da26bc0 ("drm/fb-helper: Move generic fbdev emulation into separate =
source file")

interacting with commit

  4a16dd9d18a0 ("drm/nouveau/kms: switch to drm fbdev helpers")

from the drm tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 10 Nov 2022 11:05:52 +1100
Subject: [PATCH] drm-misc: fix up for "drm/fb-helper: Move generic fbdev
 emulation into separate source file"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouvea=
u/nouveau_drm.c
index a19f18b251f3..80f154b6adab 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -34,6 +34,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_fbdev_generic.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_vblank.h>
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/.Q6grKnV+8CBG.WbU_PfLWh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsQXwACgkQAVBC80lX
0Gy5fwf9F/po7VaCxTJ5FVmjG4b9EztuGSqRYnGbQWwpMYOwCKLZK9vcP1ZRH6mo
GJAxnLmbRAUpJfZ5bopNGCqtdZTWJOB2H2fXrE6NX3LYw7x/u4rh2Sb0q83RQrEl
mBu6lqSXIG+LtXx9Wu9Pv/qfhD1aI2skHjLm1gMKNr6DbnEGMZ9Bwp/7E2+PoEAN
+5TsQ2b7KjosT5z8OxMgSJtuou3Y4/8YpxvLFuo1ikw/v0jn2jIcMvgEL2UImsi5
m4CQnFCybZ+NcPl1Y2z6XEtm+XIPYRtnZqnEDXFtFNLmBAz8ql7wFz4s/pfiZ0yy
uMADWcO7/rGwFvNMIsTiG2k7HI3MYw==
=KB/y
-----END PGP SIGNATURE-----

--Sig_/.Q6grKnV+8CBG.WbU_PfLWh--
