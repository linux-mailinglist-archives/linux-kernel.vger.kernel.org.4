Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE362B1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 04:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKPDDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 22:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKPDDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 22:03:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9815713E23;
        Tue, 15 Nov 2022 19:03:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBnt237r2z4x1T;
        Wed, 16 Nov 2022 14:03:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668567788;
        bh=UY0ccI3aO6v1TmsIAsEjO7GSYU2Ug6bsvaaUvJWXiMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=LTKdcjZwHb/zHQzEtIEVprOBzl+Y3uuuOJpyhuB4GUTkdC+0+++faKzOv8NcEKzId
         TzL5XOQFwGmx83aRyA4Wx6+lJJMqC9mp4pATzcqvbuC3oUgFxjSCySRSifbsTt13ye
         VpZSDKh5q2ISpJFGbPfQ5eCxF0G529cmBTqJf1Rb76W6NRFREPNOJKXczdgsKJehlj
         bQ4SumTu2uyyRxpzyqNJGPERLCe2PX6VRlfv7yvloDsOiBoGXnFsyhnalWIcJd8YGs
         ZV3GZpixibbbNr/kqz0+fr2F/gJTq3CYnnwdJbLfxlU9aE6GaBiSqMnkFyw4lkhvcv
         Zf8sauDVR7QNg==
Date:   Wed, 16 Nov 2022 14:03:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Gavin Shan <gshan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the kvms390 tree with the kvm-arm tree
Message-ID: <20221116140304.48333261@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mzxMh2a2MppNBDeVeNrwBI9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mzxMh2a2MppNBDeVeNrwBI9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  include/uapi/linux/kvm.h

between commit:

  86bdf3ebcfe1 ("KVM: Support dirty ring in conjunction with bitmap")

from the kvm-arm tree and commit:

  57ecc06995f9 ("KVM: s390: pv: add KVM_CAP_S390_PROTECTED_ASYNC_DISABLE")

from the kvms390 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/kvm.h
index c87b5882d7ae,d3f86a280858..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -1178,7 -1178,7 +1178,8 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_S390_ZPCI_OP 221
  #define KVM_CAP_S390_CPU_TOPOLOGY 222
  #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
 -#define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 +#define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 224
++#define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 225
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/mzxMh2a2MppNBDeVeNrwBI9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0UugACgkQAVBC80lX
0GxI5QgAnyuHlbIYa4BK79/8oGra7RkwRp0ZwR9XEMQa6eP0RzWfwSyLxDJd120O
6NiOy2ZotxsbUKLdMOwRfJoiee6arwccqt13CfgbbhwcHdZCJIKgSR4AteY7m2hJ
fjf6toEXqjT1f1WRL+lTlyG+ryllzWv4GtUnwHuuSziqrCgUygy5EduLvIDOlITU
lIRWU7R/MrPThcE0RG7O/pXMq5vZbr7VmFC+6XuOe33TtriBnm4LVZmhBJto3f9d
9H0sGBZ6IhBxPQK/fGYz7c7d0jhX7thSYtxnOXdy75/nxQMiUUW35bQoPSYXWVzQ
3XdXWlyJ5iErjNXtzBitpJsKkF+76Q==
=PVhU
-----END PGP SIGNATURE-----

--Sig_/mzxMh2a2MppNBDeVeNrwBI9--
