Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C800A672C95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjARX1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjARX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:27:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EC544BCB;
        Wed, 18 Jan 2023 15:27:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny2381lY4z4xyK;
        Thu, 19 Jan 2023 10:27:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674084420;
        bh=npFU5NpuSEX4/9Hu3wzGdj/WCwP5gGwG/HTUwzMAaoc=;
        h=Date:From:To:Cc:Subject:From;
        b=l0pTru9raXR3Po59YqjX+qY2ulOakFEZGiOYVRJf/+rFEf+Dj3xvURo4C9w4UH8Iq
         /m4THVzCRSTH7Q4vidrFfbDUmPZGIELku4vuNFlgxdUtHPFuIwcnceHo+eOOLJdSzn
         buy9gIcDz9FlYyBiWmh/FcrmfShsQsWIGjvE0wUe3kH1do3AzVyC5OnaVrLTTFV9IS
         FQaSaiT4GL3NdiAzIDKW2oK2Hz7yyEqQJT+gOZ5hSa7iqvjqLAG1V29BmeKmRXRkqi
         k6C8G0e3/gh2n/fdDHSAfTbnjKEfXWBnh4d/HzEA7fXeq/Ltz3ohlmy+TAutOf9vH2
         EA8CZHDOR99IA==
Date:   Thu, 19 Jan 2023 10:26:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the vfs-idmapping tree
Message-ID: <20230119102659.5f7d3b39@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+.IM.G9dM1kj7Izb0NfavF5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+.IM.G9dM1kj7Izb0NfavF5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-idmapping tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/cell/spufs/inode.c: In function 'spufs_setattr':
arch/powerpc/platforms/cell/spufs/inode.c:103:22: error: passing argument 1=
 of 'setattr_copy' from incompatible pointer type [-Werror=3Dincompatible-p=
ointer-types]
  103 |         setattr_copy(&idmap, inode, attr);
      |                      ^~~~~~
      |                      |
      |                      struct mnt_idmap **
In file included from arch/powerpc/platforms/cell/spufs/inode.c:12:
include/linux/fs.h:2941:19: note: expected 'struct mnt_idmap *' but argumen=
t is of type 'struct mnt_idmap **'
 2941 | void setattr_copy(struct mnt_idmap *, struct inode *inode,
      |                   ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  2e906ff8067f ("fs: port ->setattr() to pass mnt_idmap")

I have used the vfs-idmapping tree from next-20230118 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+.IM.G9dM1kj7Izb0NfavF5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIgEMACgkQAVBC80lX
0Gwkpwf9ERwIb67MZImnYXKOKU6Z1mlB67YOA7jcEE3w1i1K0hbBxLc1rq5fQrSy
smJnskqfdIfXTfTY+NkYLQbJ0A+L7yMznMKCUqviaK6cQ/aK9jrNKuUg6+HPBLwl
6SLkhwvR39ixugPhkLrVQxVQFziJvqHugeQXhjAcE489ommFmkz/SjvTgER+hHq0
pkp7zOEjoREYbMOkLvJgFhQK0/CKWu73XA24q5rxsTn4mb3M3Bm08Syt1tKHMVlK
qgfDgxZ2zlwUD+D4PsqSCYDnYZz05ROkaqEqYOxY5uliFKJEGzldXnHbCNoa9nXW
qDkVD2nXpFWTkd18UPZNjAIE2pUGvg==
=rVc1
-----END PGP SIGNATURE-----

--Sig_/+.IM.G9dM1kj7Izb0NfavF5--
