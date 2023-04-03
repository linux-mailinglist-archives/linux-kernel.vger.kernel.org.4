Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D246D3D75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjDCGkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDCGkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:40:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879340D4;
        Sun,  2 Apr 2023 23:40:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pqh911QtPz4x91;
        Mon,  3 Apr 2023 16:40:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680504022;
        bh=tHgLzO0kk/+dH9Zv+rizQ/8ahulqmruiYBAr/sGer6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=gT6H+iIfWuPaMTE8eu8t4pSEnPeGVeBJb8PvDbuW0lJ86nRe7m/AQAddqMTc+45mt
         TE1QJhqLi9c41MmFO2gZBWjZErthth292ErKgDFye88u0RXwT3P8IicedunC1EHyiE
         viRX5QKuHXwBd2dgyf+oJ8RdMcafMEehZaPLv+XaSQM1nGZ4lhWSI6dN8kf3cbtwf1
         G5THIgJ/4U+UsGsgAAwXaHh/I5n2bkBjhP2nUUB0VXDAzzwZAWdpjQ8YI+4mBY0rsi
         82/T5/N+Eb/zYxEwz8a44cyRMh4Dd4jl5yORvWV8LNj5UUnuSwWHAytcJiAMGYbekd
         yAv5hEKQUk1lQ==
Date:   Mon, 3 Apr 2023 16:40:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Adrien Thierry <athierry@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: linux-next: manual merge of the scsi-mkp tree with the scsi tree
Message-ID: <20230403164019.5a97089a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nF9Tpw5Lv2Mzm+HnEFzaVXa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nF9Tpw5Lv2Mzm+HnEFzaVXa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/ufs/core/ufshcd.c

between commit:

  86eb94bf8006 ("scsi: Revert "scsi: ufs: core: Initialize devfreq synchron=
ously"")

from the scsi tree and commit:

  543a827b1db3 ("scsi: core: Clean up struct ufs_saved_pwr_info")

from the scsi-mkp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/ufs/core/ufshcd.c
index c32a927ac5d1,03c47f9a2750..000000000000
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@@ -8422,22 -8429,6 +8422,21 @@@ static int ufshcd_add_lus(struct ufs_hb
  	if (ret)
  		goto out;
 =20
 +	/* Initialize devfreq after UFS device is detected */
 +	if (ufshcd_is_clkscaling_supported(hba)) {
- 		memcpy(&hba->clk_scaling.saved_pwr_info.info,
++		memcpy(&hba->clk_scaling.saved_pwr_info,
 +			&hba->pwr_info,
 +			sizeof(struct ufs_pa_layer_attr));
- 		hba->clk_scaling.saved_pwr_info.is_valid =3D true;
 +		hba->clk_scaling.is_allowed =3D true;
 +
 +		ret =3D ufshcd_devfreq_init(hba);
 +		if (ret)
 +			goto out;
 +
 +		hba->clk_scaling.is_enabled =3D true;
 +		ufshcd_init_clk_scaling_sysfs(hba);
 +	}
 +
  	ufs_bsg_probe(hba);
  	ufshpb_init(hba);
  	scsi_scan_host(hba->host);

--Sig_/nF9Tpw5Lv2Mzm+HnEFzaVXa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqdNMACgkQAVBC80lX
0GzuyAf/c6sLsv3n5ARluXCCTQs5m+nwRJ2krsBubsJ0X1tvVcq9+78Cd5t2CiSR
Oe84ACss6D8RHHPUQFwIZ+gxDzju5PrNjX9qxbWNkUla63dLcbBqp3uHoaNlXvEQ
FlRO9rlQtruRR9lKP4mJCE5JIob/ybgTY6jEdeLnXnS28HC1Z4a99sQLZ1cV/D1m
Bxv/vSkofCRldcJPT7JCah3lcAhp6J2aNw1ii1cUJFeFkmcYjoFFvtcfoDyvUIVO
bnaIvjm1czRDVgD0aD5ebNuwhXMmDK9Ns+6Lxw9jiqI+Re8oHFSN/X/RYCx/rLX0
uxi5J1k1HtAOieF7+FTfWClEPvmq7A==
=/LoZ
-----END PGP SIGNATURE-----

--Sig_/nF9Tpw5Lv2Mzm+HnEFzaVXa--
