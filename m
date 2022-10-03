Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E5D5F38A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJCWMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJCWMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:12:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB7263C0;
        Mon,  3 Oct 2022 15:12:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhFS64cPlz4x1F;
        Tue,  4 Oct 2022 09:12:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664835126;
        bh=0c+SzmccFkv+qi7iD7DLPmYckdmiYVEdqmGxGj+h9t4=;
        h=Date:From:To:Cc:Subject:From;
        b=nEhFnZ4+dmTDVXYht1hFM97IUlmTdGSsDwMt0Nxe1KHuvFJkT232Th8rMrdWdLKp+
         GWF26cSSseYAgGy56ookATcllUj2aVCcG8VYMLklidqxHVCBtlhhqLgUJeRjDIUCTV
         m/BAD5FyJ/EulQwUISCO4vjlNyhpCdMTzmDdwExWZlB33kMtf0o4lJmKCktonIvDBx
         AiwKWZ2zAd+WoE8C2k1lcalANaJGAaUiEUtYmEjkH9jaiVYj5mgCfqbvZJb89Ao/jE
         6iQH0V8Eoi/vqYMvS29B20NSZdxkM3dshnAyWFbFnGnDqfSblsQvByOEAYPIZpQSFH
         GpH7f1AskpsQQ==
Date:   Tue, 4 Oct 2022 09:12:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the powerpc tree with the kbuild tree
Message-ID: <20221004091205.2677b823@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CJ3sH5PGGLeblzCGnmsurzf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CJ3sH5PGGLeblzCGnmsurzf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in:

  arch/powerpc/kernel/Makefile

between commit:

  321648455061 ("kbuild: use obj-y instead extra-y for objects placed at th=
e head")

from the kbuild tree and commit:

  dfc3095cec27 ("powerpc: Remove CONFIG_FSL_BOOKE")

from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/kernel/Makefile
index ad3decb9f20b,1f121c188805..000000000000
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@@ -118,12 -116,12 +116,12 @@@ obj-$(CONFIG_PPC_E500)		+=3D cpu_setup_e5
  obj-$(CONFIG_PPC_DOORBELL)	+=3D dbell.o
  obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
 =20
 -extra-$(CONFIG_PPC64)		:=3D head_64.o
 -extra-$(CONFIG_PPC_BOOK3S_32)	:=3D head_book3s_32.o
 -extra-$(CONFIG_40x)		:=3D head_40x.o
 -extra-$(CONFIG_44x)		:=3D head_44x.o
 -extra-$(CONFIG_PPC_85xx)	:=3D head_85xx.o
 -extra-$(CONFIG_PPC_8xx)		:=3D head_8xx.o
 +obj-$(CONFIG_PPC64)		+=3D head_64.o
 +obj-$(CONFIG_PPC_BOOK3S_32)	+=3D head_book3s_32.o
 +obj-$(CONFIG_40x)		+=3D head_40x.o
 +obj-$(CONFIG_44x)		+=3D head_44x.o
- obj-$(CONFIG_FSL_BOOKE)		+=3D head_fsl_booke.o
++obj-$(CONFIG_PPC_85xx)		:=3D head_85xx.o
 +obj-$(CONFIG_PPC_8xx)		+=3D head_8xx.o
  extra-y				+=3D vmlinux.lds
 =20
  obj-$(CONFIG_RELOCATABLE)	+=3D reloc_$(BITS).o

--Sig_/CJ3sH5PGGLeblzCGnmsurzf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7XjUACgkQAVBC80lX
0Gzrhwf+K+L9GgrO9Z5+wx/WZVQcN4vQgA5tF+Yan3IyiYXlGsQyZYn6+nhuPZ51
WD24iaPE67tedyZk/3VHIuG1ZdFCu++/19D4MtEO2Dilq7XYhXY1PB0q4rLlyZkp
UhU9E/oi4CH5WfRwlu2eIWgWqnu50tdVfYDxMXBbEfZyc1If3eh09PDVkvBZBdJ2
cJXIr7d4HZvEeJZ7PqDrdq9s47Q5mgnyhUngDj2HV/HYgV23wwd2VgFnatltMK58
OoUfZWauGJkTUOWEDRylAYcYvH0O8031/WoKoAjoeBCtY1CTh/q02SyPWhjbsSBP
Ys27ZJgFpnkyO4EnVn2z/jPOA8ilKw==
=JLWo
-----END PGP SIGNATURE-----

--Sig_/CJ3sH5PGGLeblzCGnmsurzf--
