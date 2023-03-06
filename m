Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191366AD287
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCFXJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCFXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:09:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C0303DE;
        Mon,  6 Mar 2023 15:09:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVvQr1kRHz4xDh;
        Tue,  7 Mar 2023 10:09:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678144149;
        bh=Zu980PEf3uYdJqFmYlQ36m7G+AYyS3zkGCPtGK8eeqI=;
        h=Date:From:To:Cc:Subject:From;
        b=oc3cmjg40DSfntGJbigyvNXzPHUs7bTKLHKGbox8PerHedolSp/qLpt9K9j3z+KH3
         J3Es0KLANBikK6IYFSI436dBuXCoL3T04coddv6aj6IJYqJFYA4wlDy2yuUYTVdmd3
         519foK98XxnQ3pfvUP0jPP3EPs2J2uC3Lq2e8c6Y9yjEZXPE20wNu5i7HRkC+FOFOO
         St9wVITQOFlvNmlrYOL64SdFbooFmEQyiA7C55pVpHXXsvYu27/X/cac8jJEaWRQOq
         4TWrdydj6uxoMdsfmFvCNItmdRgV5tfCeiED5Q4LbI1JNZyHTLvyhJRCtOhqt0KjDP
         EAkCfX5a7FIzA==
Date:   Tue, 7 Mar 2023 10:09:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20230307100906.60384f71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KfzsMz2nuDG5O7oKpHgeQgG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KfzsMz2nuDG5O7oKpHgeQgG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_driver.c

between commit:

  2293a73ad4f3 ("drm/i915: Remove unused variable")

from Linus' tree and commit:

  e5e43d3363d7 ("drm/i915/display: Pass drm_i915_private as param to i915 f=
uncs")

from the drm-intel tree.

I fixed it up (the latter commit means that the variable removed in
the former is still needed - see below ) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/i915_driver.c
index cf1c0970ecb4,4a2dc43791c3..000000000000
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@@ -936,9 -930,12 +930,11 @@@ static int i915_driver_open(struct drm_
   */
  static void i915_driver_lastclose(struct drm_device *dev)
  {
- 	intel_fbdev_restore_mode(dev);
+ 	struct drm_i915_private *i915 =3D to_i915(dev);
+=20
+ 	intel_fbdev_restore_mode(i915);
 =20
 -	if (HAS_DISPLAY(i915))
 -		vga_switcheroo_process_delayed_switch();
 +	vga_switcheroo_process_delayed_switch();
  }
 =20
  static void i915_driver_postclose(struct drm_device *dev, struct drm_file=
 *file)

--Sig_/KfzsMz2nuDG5O7oKpHgeQgG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQGcpIACgkQAVBC80lX
0Gx6Ygf/RZZReLwAWdHhqnVcS9m61JdNvARZPjvB04KgE4yeoIKbwECCleSBbSOC
c5xBxJobMri0Bqs6EXRXphRq+4lZpszt1VhbAo8jA3im3OIcoxkjH+RdhW0Vuk8L
AjAGuoRlW7IzM6Lv1ABq0CRWb3BbFM8mrqdqzU3GQ/SYekibILqtrch+zZBAa1DD
o2ETeeFfWlG1OQpwUMO01XDQFzv86Na0hBQazcjFMpxoDz44up7J2zM2q2+qic2q
MFraf6xh9iTAV4jLZGG7g3i/t9xikvqL32JA4Bqe0tefVNl5nlOvaX5F80Q6J5KX
kr5s88TzGbCQZMZjATuboLfbi++tnA==
=5ab0
-----END PGP SIGNATURE-----

--Sig_/KfzsMz2nuDG5O7oKpHgeQgG--
