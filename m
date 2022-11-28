Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3F639F78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiK1CgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK1CgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:36:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4B210FEC;
        Sun, 27 Nov 2022 18:36:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL8jG0Tdbz4wgv;
        Mon, 28 Nov 2022 13:36:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669602962;
        bh=qfnhdrNVRcN1G/RAA9Tok8dMWH5Z11gtC9L8LpEE/BA=;
        h=Date:From:To:Cc:Subject:From;
        b=aeBPn3zv6N+KWDWSthW+XGbXhhEG6Ta51ozsDQvQkOrZzsAYdB4tBxsvK/F4pdmwx
         nv8HluuVR9QJOpUy/9Xf8lvkf0fJKWtOwEKW/SLw4MAx20slIsQA+LK/iX4XK0g/1D
         vgUv0zSsaRoU2tUzVjnbNOZxPliBI2Y4YVoL15+XSGPhMRSFCGOrNpbmoTmIAye/4h
         i3dGRXBZuawtRO9VXp6+oZQCK0bhIdb08zDlBNDgouhQOvoVtxQ5kuvK2FYg34/N+q
         I99PLIBIRU5/QeaEPRzu2YhR5uBkVqbKtdfc0s/axGS5UgYPeHGvWHRq2vf3UGUUe2
         86Ckia9+WOqZg==
Date:   Mon, 28 Nov 2022 13:36:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20221128133600.14ce44bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GC6FdFR/fJLb8n8lwxvbC2V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GC6FdFR/fJLb8n8lwxvbC2V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

arch/powerpc/platforms/book3s/vas-api.c: In function 'vas_register_coproc_a=
pi':
arch/powerpc/platforms/book3s/vas-api.c:590:38: error: assignment to 'char =
* (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct devi=
ce *, short unsigned int *)'} from incompatible pointer type 'char * (*)(st=
ruct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned=
 int *)'} [-Werror=3Dincompatible-pointer-types]
  590 |         coproc_device.class->devnode =3D coproc_devnode;
      |                                      ^
drivers/misc/cxl/file.c: In function 'cxl_file_init':
drivers/misc/cxl/file.c:687:28: error: assignment to 'char * (*)(const stru=
ct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsi=
gned int *)'} from incompatible pointer type 'char * (*)(struct device *, u=
mode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werr=
or=3Dincompatible-pointer-types]
  687 |         cxl_class->devnode =3D cxl_devnode;
      |                            ^

Caused by commit

  ff62b8e6588f ("driver core: make struct class.devnode() take a const *")

I have used the driver-core tree from next-20221125 for today.



--=20
Cheers,
Stephen Rothwell

--Sig_/GC6FdFR/fJLb8n8lwxvbC2V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOEHpAACgkQAVBC80lX
0GxCnQgAlfheAMgGd6YWwXB+Hywi9bs57oFTohYC4g7ysQE453u3mlD1A8qZ7F3G
+9xpiIQ5wPBaK2Ps+BjvFYMNMTiajyhAkhYmN9N2/CxEJ2jqFa+MBKGexEFCFQgj
jQoo/jUWFGi8A1q8qEJvsBlESKQ9cLN2MCU4mcnFnC3krKqk2Ij/48U7ptk+OzCK
YnqDAij1bVINA8Gl2qbGjgZs5A0gFxTzisqO/DghwjIKBLkXYNsDhBO971v+pWbM
2X3hbs/LVJLQJDxL6DAqtDAYmf0KQunW1ZZoeWyNevUeo5cSrbDKNQQyxVgSEI6I
tuh20oE7ZxyFwd4z//OU9nF9LnBimQ==
=RlK7
-----END PGP SIGNATURE-----

--Sig_/GC6FdFR/fJLb8n8lwxvbC2V--
