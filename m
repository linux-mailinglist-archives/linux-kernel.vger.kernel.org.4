Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB5633077
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKUXGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:06:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECCCB94D;
        Mon, 21 Nov 2022 15:06:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NGNKx4PM1z4xGW;
        Tue, 22 Nov 2022 10:06:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669071973;
        bh=jaILjJ+OkM3rv3C1UpX0CD1h89Cp9OT7MBWDCbXWDq4=;
        h=Date:From:To:Cc:Subject:From;
        b=JBqeW8zNQQMUlQr47RTzINWU6jI9B2BX1XXJjK5C0kWh+LCW+MZ1UkWhoPA+FU0z4
         VqzN6l+XAkaE9l99teKqml9LziMtPBsRt7ND8Qw43qLtyXAEYfQi7x81zo17bVPiSz
         DzUBtxtMTh8DeWJpoR727d7N61tB0SvYX/kAu4rGQpzOr/MH5ZWobFRxNoS+UwRmyV
         0pGCIN21FaHnrtk2FfDrdMB0Jm+ohf9MqnH2Ddx/HJgtSyRJYuv5W/OWIkZGDsneIz
         oI2XCS1RG88+AIBfiaP/ULjqAJdHGsd8bEZnDCc3HuhL3JKg9RdeGPaKUnV202SDkI
         QCTTMGR+34BrQ==
Date:   Tue, 22 Nov 2022 10:06:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: linux-next: manual merge of the dma-mapping tree with Linus' tree
Message-ID: <20221122100611.13a374e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPWGVDULKSX8GhPoi./p7fM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DPWGVDULKSX8GhPoi./p7fM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dma-mapping tree got a conflict in:

  sound/core/memalloc.c

between commits:

  9736a325137b ("ALSA: memalloc: Don't fall back for SG-buffer with IOMMU")
  9d8e536d36e7 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")

from Linus' tree and commit:

  3306877aff07 ("ALSA: memalloc: don't pass bogus GFP_ flags to dma_alloc_*=
")

from the dma-mapping tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc sound/core/memalloc.c
index ba095558b6d1,fe03cf796e8b..000000000000
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@@ -543,9 -541,9 +542,9 @@@ static void *snd_dma_noncontig_alloc(st
  	void *p;
 =20
  	sgt =3D dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
- 				      DEFAULT_GFP, 0);
+ 				      DEFAULT_GFP | __GFP_COMP, 0);
 -	if (!sgt) {
  #ifdef CONFIG_SND_DMA_SGBUF
 +	if (!sgt && !get_dma_ops(dmab->dev.dev)) {
  		if (dmab->dev.type =3D=3D SNDRV_DMA_TYPE_DEV_WC_SG)
  			dmab->dev.type =3D SNDRV_DMA_TYPE_DEV_WC_SG_FALLBACK;
  		else

--Sig_/DPWGVDULKSX8GhPoi./p7fM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN8BGQACgkQAVBC80lX
0GylTAf+PqGca0yV+5axvYVYmDlGGX8U9NowKWW6qUbaSmp67IPLbPoTHS68C6xZ
9gMGfYRzUQXcW7IEj2lZ86E1akyJVKEHW/kwZRIuB8yMzsVtY9QxEgG3y+Y0ZKvJ
/JySdQv3GygVF3oM7ZN6iwX1Rk8KU3uQ/8g4JKTIGrnY6U1IGfshEDVhsCfvbBYP
oGGDPupxwJ8/Qtp3X8bL9Aqvwzb/sq2wukzwnEOAgeUOQznZ8OwgtFrMXn3PLLS8
j9OQLDKb6NS3+jwITSbN8NrdfUUOoNNL4oeh1dYKEAlHWEoqotGYe14EGWYwBsbb
Wtp4Bsk0qX6sKCWfPkFO+mxj7yHkcg==
=eHra
-----END PGP SIGNATURE-----

--Sig_/DPWGVDULKSX8GhPoi./p7fM--
