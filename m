Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C50672DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 02:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjASBN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 20:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjASBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 20:13:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68D689F8;
        Wed, 18 Jan 2023 17:13:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny4Pc5V6hz4xN4;
        Thu, 19 Jan 2023 12:13:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674090789;
        bh=38gPF9WCNIwlhkWACirRWDyLEnGY8N9VoQR90tcBLPk=;
        h=Date:From:To:Cc:Subject:From;
        b=O41Z/jl7V5AgTg3n9R89wwqYHhQ9FBmo8jn4bbdq+gNvn9l8LLXZtDBUuK/qEDKm0
         fEu/SDHgizpb6gt7U+H5uL/bqEjlV/5OtR/ru/gFZV8vJ+9BgZGrdfClFJzp9tBzK0
         K2dylru46iFKsrsLaRZIljFdFLAKyk2Hu80pag74XGEydZjo8ssmHaySWGNCkKzxRc
         7bzNiUapvHuBqbZCZH8blOSqpawUw871sW/U1m4gYpbuOCkufbrNZbBXBxwSaBYAw6
         rRhVPec2HTD4E7VkptANc5f1VzfczIUuX6WoBrkMQdG6lKZkEqnn7ne0QBW1FbJgmT
         x0kvLn+5rwxSw==
Date:   Thu, 19 Jan 2023 12:13:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zack Rusin <zackr@vmware.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20230119121307.4366ac4e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0hwf36qt=q.5jX13Fkq2FrR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0hwf36qt=q.5jX13Fkq2FrR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  drivers/gpu/drm/vmwgfx/ttm_object.h

between commit:

  a309c7194e8a ("drm/vmwgfx: Remove rcu locks from user resources")

from Linus' tree and commit:

  13acb368bf02 ("drm/ttm/vmwgfx: move ttm_bo_wait into VMWGFX")

from the drm-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/vmwgfx/ttm_object.h
index 8098a3846bae,95a9679f9d39..000000000000
--- a/drivers/gpu/drm/vmwgfx/ttm_object.h
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.h
@@@ -307,4 -309,27 +309,12 @@@ extern int ttm_prime_handle_to_fd(struc
  #define ttm_prime_object_kfree(__obj, __prime)		\
  	kfree_rcu(__obj, __prime.base.rhead)
 =20
 -struct ttm_base_object *
 -ttm_base_object_noref_lookup(struct ttm_object_file *tfile, uint64_t key);
 -
 -/**
 - * ttm_base_object_noref_release - release a base object pointer looked up
 - * without reference
 - *
 - * Releases a base object pointer looked up with ttm_base_object_noref_lo=
okup().
 - */
 -static inline void ttm_base_object_noref_release(void)
 -{
 -	__acquire(RCU);
 -	rcu_read_unlock();
 -}
 -
+ static inline int ttm_bo_wait(struct ttm_buffer_object *bo, bool intr,
+ 			      bool no_wait)
+ {
+ 	struct ttm_operation_ctx ctx =3D { intr, no_wait };
+=20
+ 	return ttm_bo_wait_ctx(bo, &ctx);
+ }
+=20
  #endif

--Sig_/0hwf36qt=q.5jX13Fkq2FrR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPImSMACgkQAVBC80lX
0GzCQAf/fIL3znz6gmPHSw9S8jB8gAKcOvfDx0QLArZSqxKxRDe+Oj0DkYOA7e2L
mBvET7giBmk9c2WcmTWv5vrHqSN3hNaXWySj0f3EzJd7PTkfigxKd4EOJEJOHnOz
tB8P0T/gykg2kJoGPQ10/FHd9d19Wx7r1rB5Wd7Lw3r8YHmudkKiDii89EH7aYX+
RZ8gD919W10NfaeKFjU7Ea6vkL+bIezQB28GOZFqXNSXupsI12BI+C1ivr17HSQD
fqgH49OfuOR7xkWUiT+YVJnWaXq+oYSACTxFJtYTIFfmEDYJUGnxhiMHP1uy99sD
xk19NQbhmoshnAiLvBexpnMB+yGS/g==
=IJWR
-----END PGP SIGNATURE-----

--Sig_/0hwf36qt=q.5jX13Fkq2FrR--
