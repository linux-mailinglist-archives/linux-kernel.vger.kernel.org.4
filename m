Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C826A65974D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbiL3Kah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiL3Kae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:30:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D001D1A078
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:30:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pBCef-0006oC-Vy; Fri, 30 Dec 2022 11:30:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pBCeZ-002geM-QW; Fri, 30 Dec 2022 11:30:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pBCeZ-008xeU-4o; Fri, 30 Dec 2022 11:30:19 +0100
Date:   Fri, 30 Dec 2022 11:30:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: linux-next: Tree for Dec 30
Message-ID: <20221230103016.ebcjz7lky7wfkz6h@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="arwubzpzgnalgtaf"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,LOCALPART_IN_SUBJECT,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--arwubzpzgnalgtaf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

As there is no next tree since a few days and this will continue to be true=
 for
a few days, I tried to create my own next.

I did

	git show next/master:Next/Trees | sed 1,4d > trees
	git checkout linus/master

And then repeatedly run:

	while read rname protocol repohashbranch; do
		repo=3D"${repohashbranch%#*}"
		branch=3D"${repohashbranch#*#}"

		# git:// seems to be ratelimited at github
		repo=3D"${repo/#git:\/\/github.com\//https:\/\/github.com\/}"

		case "$repo" in
		*git.libc.org*)
			# if repo it on git.libc.org, skip it "Name or service not known"
			continue
			;;
		esac
		echo "fetch $repo $branch"
		rev=3D"$(git ls-remote "$repo" "$branch" | awk '{ print $1 }')" || contin=
ue
		echo $rev
		if git merge-base --is-ancestor "$rev" HEAD 2>/dev/null; then
			continue
		fi
		pgit pull "$repo" "$branch" || break
	done < trees

and fixed merge conflicts in between.

I was so bold to tag the result as next-20221230, it's available from

	https://git.pengutronix.de/git/ukl/linux tags/next-20221230

It doesn't contain the usual meta-data in the top commit (as I didn't
find the scripts next is usually created with) and I didn't do any build
tests.

There were a few conflicts:

 - In drivers/dma-buf/dma-buf.c between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	f728a5ea27c9 ("dma-buf: fix dma_buf_export init order v2")

   and

	git://anongit.freedesktop.org/drm/drm-misc for-linux-next-fixes
	28743e25fa1c ("dma-buf: Remove obsoleted internal lock")

 - In arch/arm/boot/dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	62d127eeac27 ("ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO l=
ine names")

   and

	https://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc for-next
	220a041d4cca ("ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO l=
ine names")
=09
   which is a problem because both commits are identical but the second tre=
e has
   some more commits touching the file.

 - In drivers/gpu/drm/amd/amdgpu/amdgpu_device.c between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	afa6646b1c5d ("drm/amdgpu: skip MES for S0ix as well since it's part of GF=
X")

   and

	https://gitlab.freedesktop.org/agd5f/linux drm-next
	5620a1889e4c ("drm/amdgpu: skip MES for S0ix as well since it's part of GF=
X")

   which is a problem because both commits are identical but the second tre=
e has
   some more commits touching the file.

 - In drivers/gpu/drm/i915/i915_drv.h between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	8f70f1ec587d ("drm/i915/mtl: Add Wa_14017073508 for SAMedia")

   and

	git://anongit.freedesktop.org/drm-intel for-linux-next
	2357f2b271ad ("drm/i915/mtl: Initial display workarounds")

 - In arch/arm64/kernel/stacktrace.c between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")

   and

	git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
	c2530a04a73e ("arm64: efi: Account for the EFI runtime stack in stack unwi=
nder")

 - In various files below mm/ between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	???

   and

	git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for-next
	???

   I didn't feel confident to fix this conflict correctly and skipped mergi=
ng the slab tree.
=09
 - In various files belwo mm/ between

	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
	???

   and

	git://git.infradead.org/users/willy/pagecache.git for-next
	???

   As above I didn't even try to fix these up and skipped merging the folio=
 tree

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--arwubzpzgnalgtaf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOuvbUACgkQwfwUeK3K
7Allygf6A4wVxCcx7EmnM8esM7pAIBa2XJPKY6d+FMktPBawfPkyUjwkEZNIsqZ9
or8azeJHgxumCV38giCEMRnI3zdCR9evuKdP7v8NNwR9AduptH71fJCus6t1/mGS
vY4RVWd0DTOQad0NWkJmieGYpTb8lB0bzdxlUtu8GccQgRx9P88/VyLbRML+c+0t
rGL6nnLc3AdW+mkYu/30vOtF19xhAky2072D5Y4CZxacndRXVvLwo+sBpG9BBu0l
VXBJcdiRTlhq9JVbJ8KGlgI9QSQc7HeKMjkhjnA50fPubQIyYmWyS6oMQgZSGbwk
SqqxBQcndw1e/AaevSDBCQOZt9H/Ng==
=O/rT
-----END PGP SIGNATURE-----

--arwubzpzgnalgtaf--
