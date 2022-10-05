Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7825F4D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJEAnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJEAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:43:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FB5EDF1;
        Tue,  4 Oct 2022 17:43:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhwls35XYz4wgv;
        Wed,  5 Oct 2022 11:43:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664930586;
        bh=u3+7g8/NTQ+C/yLguEF4M8kLu7VY03qew1r8TYkvPPA=;
        h=Date:From:To:Cc:Subject:From;
        b=oBhrBU/3DRwuDLjK5j0hbncOUx9U10IYEQMQzYxE2hDdCsF6Zcb52Y9oY/kfPEy3c
         r69oi4wYEDAcJeD+x3hWlCpkJkiYPsAR0GgnS7dXqqBXQSWAOX4P8uoaAWD/TaEebC
         GHZV9OJvIKvBM7rk6AGkssVa+NsrGkrsZTLMMFo3sM80zFGlI4vVXt/toLEEKwFLRL
         34bjkGHVyljwh4W0D/WgDYeZ8uHxoG0edkEHcsgCpNEzVhrGVIVci4cyMOp3G1ZM+p
         7DyFdtoL82uyV6khe8HYOLTOGKlYzeQojRuHDDtqzg6/odpwTaPGNpMTGBCgqoYC6O
         hH0OlSvqJzEzA==
Date:   Wed, 5 Oct 2022 11:43:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-misc tree with Linus' tree
Message-ID: <20221005114303.0e4b0881@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2Dkv2l7meS3IrTp5418XXDy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2Dkv2l7meS3IrTp5418XXDy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-misc tree got a conflict in:

  include/drm/drm_edid.h

between commit:

  c7943bb324e5 ("drm/edid: Handle EDID 1.4 range descriptor h/vfreq offsets=
")

from Linus' tree and commit:

  afd4429eba28 ("drm/edid: Define more flags")

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

diff --cc include/drm/drm_edid.h
index 1ed61e2b30a4,28dd80343afa..000000000000
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@@ -92,15 -92,13 +92,18 @@@ struct detailed_data_string=20
  	u8 str[13];
  } __attribute__((packed));
 =20
 +#define DRM_EDID_RANGE_OFFSET_MIN_VFREQ (1 << 0) /* 1.4 */
 +#define DRM_EDID_RANGE_OFFSET_MAX_VFREQ (1 << 1) /* 1.4 */
 +#define DRM_EDID_RANGE_OFFSET_MIN_HFREQ (1 << 2) /* 1.4 */
 +#define DRM_EDID_RANGE_OFFSET_MAX_HFREQ (1 << 3) /* 1.4 */
 +
- #define DRM_EDID_DEFAULT_GTF_SUPPORT_FLAG   0x00
- #define DRM_EDID_RANGE_LIMITS_ONLY_FLAG     0x01
- #define DRM_EDID_SECONDARY_GTF_SUPPORT_FLAG 0x02
- #define DRM_EDID_CVT_SUPPORT_FLAG           0x04
+ #define DRM_EDID_DEFAULT_GTF_SUPPORT_FLAG   0x00 /* 1.3 */
+ #define DRM_EDID_RANGE_LIMITS_ONLY_FLAG     0x01 /* 1.4 */
+ #define DRM_EDID_SECONDARY_GTF_SUPPORT_FLAG 0x02 /* 1.3 */
+ #define DRM_EDID_CVT_SUPPORT_FLAG           0x04 /* 1.4 */
+=20
+ #define DRM_EDID_CVT_FLAGS_STANDARD_BLANKING (1 << 3)
+ #define DRM_EDID_CVT_FLAGS_REDUCED_BLANKING  (1 << 4)
 =20
  struct detailed_data_monitor_range {
  	u8 min_vfreq;

--Sig_/2Dkv2l7meS3IrTp5418XXDy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM80xcACgkQAVBC80lX
0GxVjAf8CbvSrDGOmZ0YmOS+1QnJPPSnHY7WlsmNF+xMUM0oojq68RJpO4BRCKxT
FcyI7b8MU/MaQR6oFasXAuGM6mlZ8dq10Apyo79v8u45puNakdUknQC5wyrMW02d
eddRk1/RGxTLMkBx8JvM+s8S/X+RLc9Kqhu8qSC7boupKOR1mclAZ2p0XJxK5KaS
+iTm530JKlx8lTdFLgMe63LAvBCYQSmjljuaFSWcAWbDVXH8YNNykQhD7+jovqR0
GudyBypeoXh5UGrTynzLnTRASVCU7xDX8Oz9Teh1MJ2cmPDOoEfP81KJpPrQmv5Z
AsFbyrQGvAbJVDZSvpfw8A7RqA6MlA==
=rmrf
-----END PGP SIGNATURE-----

--Sig_/2Dkv2l7meS3IrTp5418XXDy--
