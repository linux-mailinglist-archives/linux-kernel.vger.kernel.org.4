Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815EC6C0871
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCTBZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCTBZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:25:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD789BDFC;
        Sun, 19 Mar 2023 18:17:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pfxf73b4yz4x5Q;
        Mon, 20 Mar 2023 12:16:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679275007;
        bh=oQV+JqrM+dO/bI9tW2qLa5xG3fe2PMYOspphm63mL0g=;
        h=Date:From:To:Cc:Subject:From;
        b=dWBtR54RXE0Uj4Wh0dbhZ3uiUhUNL5RULBrSh8NIZFCjvXQuhmL4sK2yyaUf21u4H
         ocQ8rOvJ6mzBTGhNxInbdryyfJLs5WBbWmFYWd6kGQ78OcoPwrgGElK+gu3gCyE2tB
         DUExmIJwwJMAoNolp+LoJQ2j0z5TWTVTnqMYnCaWbK9If7LGRtWuMYIJ9pCOcXUE16
         zBLH/f3NRu2S5QnJnbUs/L1QbP8Af7+q/h7gQI0G+ptBWaqHG1j5dIy3HmhJBJqv7L
         AFVhQtzzqMB2Gjk+DErGRfEfiEq2ylBoeTSoGp53z/pSwswZAgksDa/DeTwSYGwwyT
         dD9POW+W0m5xw==
Date:   Mon, 20 Mar 2023 12:16:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20230320121646.19a4b7ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EpLNRk3ZdFDCDs0kEqMuzo6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EpLNRk3ZdFDCDs0kEqMuzo6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi-mkp tree got a conflict in:

  drivers/scsi/mpi3mr/mpi3mr_fw.c

between commit:

  02ca7da2919a ("scsi: mpi3mr: ioctl timeout when disabling/enabling interr=
upt")

from Linus' tree and commit:

  23b3d1cf1572 ("scsi: mpi3mr: Fix admin queue memory leak upon soft reset")

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

diff --cc drivers/scsi/mpi3mr/mpi3mr_fw.c
index a565817aa56d,e9b3684a3c8f..000000000000
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@@ -2627,8 -2603,6 +2626,7 @@@ static int mpi3mr_setup_admin_qpair(str
  	    MPI3MR_ADMIN_REPLY_FRAME_SZ;
  	mrioc->admin_reply_ci =3D 0;
  	mrioc->admin_reply_ephase =3D 1;
- 	mrioc->admin_reply_base =3D NULL;
 +	atomic_set(&mrioc->admin_reply_q_in_use, 0);
 =20
  	if (!mrioc->admin_req_base) {
  		mrioc->admin_req_base =3D dma_alloc_coherent(&mrioc->pdev->dev,

--Sig_/EpLNRk3ZdFDCDs0kEqMuzo6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQXs/4ACgkQAVBC80lX
0GzxcAf/QiWaMt5nc0qwwhNlXJJrI/Ib3Wnuw1+W9D/GleZqT/RgLzTay2mM3U8s
bztdEKkooPymBnDB4n4/OKLyIPFwyNminypgUToZ1x7k969frVA2n/5DNypJLavK
S8ZAzjvU2U5rzN3mGm7XoeC513CJHwqR/kzv6t/I+DzYF3G9W+4WsmMtfqxx5IB4
BoMULpV8L4/0XmmBvx5WSrKz8g+8n8gvY8z5IpAfsEmAgr2dmhuH/8CfpiG9R/rR
8h2Mc2SNCZN0mtyRlTp/k13arBS5Pvf6EnsvXdK9IIUm6dMR95CiiebmdumlqD68
W00TvPatV6U5djynkUpSGeLZcVHjwA==
=Vpjb
-----END PGP SIGNATURE-----

--Sig_/EpLNRk3ZdFDCDs0kEqMuzo6--
