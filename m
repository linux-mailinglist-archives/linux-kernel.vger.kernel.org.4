Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B475734A84
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjFSDPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFSDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:15:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0439E;
        Sun, 18 Jun 2023 20:15:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QkvyR1qchz4wjD;
        Mon, 19 Jun 2023 13:14:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687144496;
        bh=VCYuTV/HoM9gCib5rBxVEAKMTPetL6gniafe4VOF73A=;
        h=Date:From:To:Cc:Subject:From;
        b=Nc5PDclXw/YfciOFRe9XPmMzhHt0HPoOJ7r9YBhRtLYP3VCo9Nes6C/fAiEijxeUQ
         OjYuyxN9zkWG9gtMD/KmTJ9UILwtybVdS33ylxJFJAmEj40temuNLlWvxLhkswi9n3
         sYz+M5IHIyATZPR9ejAyRdETMZE1fjHt2H0/ILMKideUk57a987JHN4coikumAs2zz
         1MexZPDdKUdiOxW8t1Tu1Ll0PB/ZBgHNXSt+YVMkC+PaOu677PFvKA63bgHZlAblcu
         sHzHheLVeMr/pGd6sBmSNdaO/6+BnrRc6H2hQFEIh3LvdXTg56nwtxDtGqb5vbGApG
         12rMPcDPkRKVw==
Date:   Mon, 19 Jun 2023 13:14:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Christie <michael.christie@oracle.com>
Subject: linux-next: manual merge of the scsi tree with the block tree
Message-ID: <20230619131453.25bf2153@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OCDj6O1=oGiyoWXuW=jgD.U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OCDj6O1=oGiyoWXuW=jgD.U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the scsi tree got a conflict in:

  drivers/nvme/host/Makefile

between commit:

  942e21c042e6 ("nvme: move sysfs code to a dedicated sysfs.c file")

from the block tree and commit:

  b668f2f5467c ("nvme: Move pr code to it's own file")

from the scsi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/nvme/host/Makefile
index d3fc5063e4be,06c18a65da99..000000000000
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@@ -10,7 -10,7 +10,9 @@@ obj-$(CONFIG_NVME_FC)			+=3D nvme-fc.
  obj-$(CONFIG_NVME_TCP)			+=3D nvme-tcp.o
  obj-$(CONFIG_NVME_APPLE)		+=3D nvme-apple.o
 =20
- nvme-core-y				+=3D core.o ioctl.o sysfs.o
 -nvme-core-y				+=3D core.o ioctl.o pr.o
++nvme-core-y				+=3D core.o ioctl.o
++nvme-core-y				+=3D sysfs.o
++nvme-core-y				+=3D pr.o
  nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+=3D constants.o
  nvme-core-$(CONFIG_TRACING)		+=3D trace.o
  nvme-core-$(CONFIG_NVME_MULTIPATH)	+=3D multipath.o

--Sig_/OCDj6O1=oGiyoWXuW=jgD.U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPyC0ACgkQAVBC80lX
0Gwu/gf/TEScqI3CtJaScHzG/c6jkZKnEnE8JWy+jt9Gtyne+S3naV/EMbAAQV9m
17axaQYE+0oHlxyu/rjIGaoAkyO6JZQhjjPiDcVyJgg6B+aL2RIwVckjRS+vPkRP
l6zrTlKOMn/dOwgE9wpKV9yLbG43FGlp2opNobR+opsmR2ucZozRLwLV7aODqMQ7
M6LFYhcdfu0dYXVJm++ihLtQ8SYAJ42VHn5n04uweBQO5w/jjWdPooVPakwfpWI2
b//n6/VuLbeDaxczlC/sAT8YVQm52x6o15+TLI+CTH5lvupG71MkkfoYNUXZjTM+
7eJwsOVXfNyJ8CkDQDcKVQX9O1LtPg==
=DV+e
-----END PGP SIGNATURE-----

--Sig_/OCDj6O1=oGiyoWXuW=jgD.U--
