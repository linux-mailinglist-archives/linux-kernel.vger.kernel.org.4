Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C24668709
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjALWeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjALWeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:34:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518E5C7;
        Thu, 12 Jan 2023 14:34:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtK8l48kJz4wgq;
        Fri, 13 Jan 2023 09:33:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673562840;
        bh=PhoSnUakHyuJvTd+/WoPTqSpYsR8TzsBlmVWBiKMjPc=;
        h=Date:From:To:Cc:Subject:From;
        b=cEyFwdPgADBVaoQnWnuORqQzlSNCEeMxpb1XEsweyOGXh4DBk/vW+IKPDrkO/CDda
         Iy+ZRSEVEkPhEO1DY2VRo1U1I8nfzUJcM8wpPHTamU/xh/vKW3MOlvEULWZtlqrOak
         kNPjctGlcYRCbTgP7bnanMywaCGm8Pz/SoWgZ4JTVCeJyD5LXJjC1SN8W9KHc/h4nY
         WVdqdiyV4b4/Tme2IAv8n93XjyxH9Y2tRBeS0+TxkVLunhP47p5s3ECsolDvbiKBmg
         rD5Cva3AlJTkvxQDtQDVxPHIynGxyoAgApXL3ZUMVG9a2ftobGQv1SkJJsZWANTUvF
         iCPRa67EzWCqQ==
Date:   Fri, 13 Jan 2023 09:33:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc-fixes tree
Message-ID: <20230113093358.45a00788@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DTkdQoO84Te2p8NDHJMhYBg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DTkdQoO84Te2p8NDHJMhYBg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/vc4/vc4_bo.c: In function 'vc4_create_object':
drivers/gpu/drm/vc4/vc4_bo.c:398:13: warning: unused variable 'ret' [-Wunus=
ed-variable]
  398 |         int ret;
      |             ^~~

Caused by commit

  07a2975c65f2 ("drm/vc4: bo: Fix drmm_mutex_init memory hog")

I have used the drm-misc-fixes tree from next-20230112 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DTkdQoO84Te2p8NDHJMhYBg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAitYACgkQAVBC80lX
0Gy3SAgAgrOdVqEDfP+xxKnErHNmM9Au/FaYVo/KCi0HIbCdryKbzfVfVYqMQppV
DbN2/OK1hwaA8mVtnG5XIYs5HyMfEJF08IeCmVMW4pG7ZaPJHOMt9fhR1vn0YlCP
ooOAaO0x+dcJrNWMxJ1QtVeldybXQ+4n+/g2tkakpaflRsSVF24lG4d0a9FfNt/A
PZskOM7hMTAdVUP3vpBH2GLn+1wTEXFszoOvYs5irmkeKglag1mAuuf8LUbc0XPQ
+5+jch2OgEBNgGJVWy7mLs6o5v08P5yHZcEKYcEhJDLelOmK/Tn5H9Msw2LRmjRu
9tt8P/DG+9FKsc5L5Hqowi+Gmlp0Kw==
=fiE3
-----END PGP SIGNATURE-----

--Sig_/DTkdQoO84Te2p8NDHJMhYBg--
