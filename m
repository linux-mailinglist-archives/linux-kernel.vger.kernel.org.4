Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439D9633223
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKVB3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:28:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6768FB2C;
        Mon, 21 Nov 2022 17:28:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGRVZ3Nzsz4xGK;
        Tue, 22 Nov 2022 12:28:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669080535;
        bh=r3Zq9zUP7eX1Hv56Y96Fbj75FRnDNCrFb/0crgzsSjE=;
        h=Date:From:To:Cc:Subject:From;
        b=ubAVMvdBvdfQKmzNayTxaIXvNdbm3RNy/BzJ4K62wszd/FAHKru/sdHvZ6qDAxD+K
         Ch+Hlp1t+RVGRT6fqZmp4kj02njXynLoKGis4Zq+JaI/yd2nF7UxVINAnKU9nQ3l3W
         qz6NJ3po/bkyotVTntTWCeQN1FUtgM06cB5Ep9DneDAZXzcMhe+l4bnv9ADVIANBO+
         U2zaTaeAlHw2LJHdnlF6N4wDYtASgo/ai/5IaoqlpwbOJb34KzQohsVaSMx8rEbwog
         +aLBa65/8I9+CceKzVxX8N2D9dQg711NDHvrAm3fKSu5zzWX+0WUNkCCUyshMZAebo
         lPZPFd74XcVuw==
Date:   Tue, 22 Nov 2022 12:28:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Stanley.Yang" <Stanley.Yang@amd.com>
Subject: linux-next: manual merge of the amdgpu tree with the drm tree
Message-ID: <20221122122850.3cd9657a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/meyUr.nqIgyWpregzYFRhPm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/meyUr.nqIgyWpregzYFRhPm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the amdgpu tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c

between commits:

  1b2d5eda5ad7 ("drm/amdgpu: move explicit sync check into the CS")
  1728baa7e4e6 ("drm/amdgpu: use scheduler dependencies for CS")

from the drm tree and commit:

  a61bf2f7299a ("drm/amdgpu: fix use-after-free during gpu recovery")

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

diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ffaac1c21c91,f4a3122352de..000000000000
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@@ -173,8 -166,14 +173,13 @@@ static void amdgpu_job_free_cb(struct d
 =20
  	drm_sched_job_cleanup(s_job);
 =20
 -	amdgpu_sync_free(&job->sync);
 -	amdgpu_sync_free(&job->sched_sync);
 +	amdgpu_sync_free(&job->explicit_sync);
- 	dma_fence_put(&job->hw_fence);
+=20
+ 	/* only put the hw fence if has embedded fence */
+ 	if (!job->hw_fence.ops)
+ 		kfree(job);
+ 	else
+ 		dma_fence_put(&job->hw_fence);
  }
 =20
  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,

--Sig_/meyUr.nqIgyWpregzYFRhPm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8JdIACgkQAVBC80lX
0Gxr+ggAoEPA1Y5lY/moFfUzHLgC6Q90pZRowb1WMlyJO78su6vpDIOm0v5yJFF7
cB2ijv3IeJhXZ1c4nOFNFxtGunE+dg37JYf+1yQHQ2nlWKAOTEjsxOobIH7ctdrc
WK8exzRcUV770i0L1D8hDb5FUpiFxnaLXAMkG7SvDCSjat8hNLAlYuUo7D5PH+2P
ePhxVqS32PrbhtGguLZxxHvkUcA0GJvYg4cT5Eg60LRG7mslNaorlAl/eUtc2U4C
Uw1p+Uq0TmkogWbIjijbK1647BtEB6SfOqRQoLOrTj49Vy+Z6UPR0rUCUQ6dN2f6
JkY9CwNMGmfhcaYWL0ZHousiKTMDPA==
=aSEP
-----END PGP SIGNATURE-----

--Sig_/meyUr.nqIgyWpregzYFRhPm--
