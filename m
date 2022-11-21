Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE3163187A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiKUCGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKUCGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:06:16 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF2815728;
        Sun, 20 Nov 2022 18:06:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFrN03jyNz4x1D;
        Mon, 21 Nov 2022 13:06:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668996370;
        bh=1wBzHsAeVVrRJCJUDdbostIQLXeNLSDzuWh+o2GaUFQ=;
        h=Date:From:To:Cc:Subject:From;
        b=POoudHADR+ufkAmTrmN8ykUtKQDiFobuXdcLdlm+hqat92AIIujHtGHslHl70frZ/
         2BHjLTIYAlnh3gxJMhA87h4TyGbZVGguaxpCqKKqv9rHQdSfEi1ZQUmxItKGu6x1c7
         PTE/1l5bZMwpKCRO7N1GN0hkVHcT5R2gqAw8G9alfyeCr8poaDFY337FKzyMPUMW66
         bofINZflrVycZwiCmQshRceHYZkArShpDawr5tn7gfzyxpTtQwM6jFzNpayH6vzUKl
         A6NHI4SL9YbO63MB6vbZh/4bheC1I2FZnMpAObDuFR3p3S3+Ri/Bs2VNFFqmxYtGx+
         5zpSiAm0YTqJQ==
Date:   Mon, 21 Nov 2022 13:06:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20221121130607.78449b87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N2g78LjmJ+RdmLzAk4jyxdu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N2g78LjmJ+RdmLzAk4jyxdu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c

between commit:

  b09d6acba1d9 ("drm/amdgpu: handle gang submit before VMID")

from the drm-misc-fixes tree and commits:

  c5093cddf56b ("drm/amdgpu: drop the fence argument from amdgpu_vmid_grab")
  940ca22b7ea9 ("drm/amdgpu: drop amdgpu_sync from amdgpu_vmid_grab v2")
  1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
  1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")

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

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index abb99cff8b4b,032651a655f0..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@@ -243,30 -242,18 +242,18 @@@ amdgpu_job_prepare_job(struct drm_sched
  {
  	struct amdgpu_ring *ring =3D to_amdgpu_ring(s_entity->rq->sched);
  	struct amdgpu_job *job =3D to_amdgpu_job(sched_job);
- 	struct amdgpu_vm *vm =3D job->vm;
- 	struct dma_fence *fence;
+ 	struct dma_fence *fence =3D NULL;
  	int r;
 =20
- 	fence =3D amdgpu_sync_get_fence(&job->sync);
- 	if (fence && drm_sched_dependency_optimized(fence, s_entity)) {
- 		r =3D amdgpu_sync_fence(&job->sched_sync, fence);
- 		if (r)
- 			DRM_ERROR("Error adding fence (%d)\n", r);
- 	}
-=20
- 	if (!fence && job->gang_submit)
++	if (job->gang_submit)
 +		fence =3D amdgpu_device_switch_gang(ring->adev, job->gang_submit);
 +
- 	while (fence =3D=3D NULL && vm && !job->vmid) {
- 		r =3D amdgpu_vmid_grab(vm, ring, &job->sync,
- 				     &job->base.s_fence->finished,
- 				     job);
+ 	while (!fence && job->vm && !job->vmid) {
+ 		r =3D amdgpu_vmid_grab(job->vm, ring, job, &fence);
  		if (r)
  			DRM_ERROR("Error getting VM ID (%d)\n", r);
-=20
- 		fence =3D amdgpu_sync_get_fence(&job->sync);
  	}
 =20
 -	if (!fence && job->gang_submit)
 -		fence =3D amdgpu_device_switch_gang(ring->adev, job->gang_submit);
 -
  	return fence;
  }
 =20

--Sig_/N2g78LjmJ+RdmLzAk4jyxdu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN63Q8ACgkQAVBC80lX
0Gwf9wf/ZylZB4VDOa4uf9Vv+RmYSW/5LYWy/rUlxNF23ALMXV8Na41YozLEgUuC
FfGnbtUMMVQCzdcPtJ6jySnTl0eCIAw9HbNitz2urF8USvc7yZ7vf8nk8nKKuE9L
gRS8gz2y15q8ntIcD4gIizfr8ecZA2EGmmER63ewiOtmHbvZW4/kcakOpZV29fe1
SLvzDEHT91ZySVPeWMaMSMd/tj82wJ6Mr4+akti//eFR6qzF4dCD9InbMUOQ7L14
GQFU3gSuNhjg4YFVIZ7dUmNEt0cikiQm8fc5iSCIWZ0OL/TJKLxUY6/nGq2vI6fE
iW6acYFdLuS4vw7S/azPbtM6pX4tWQ==
=gi3n
-----END PGP SIGNATURE-----

--Sig_/N2g78LjmJ+RdmLzAk4jyxdu--
