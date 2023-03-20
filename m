Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8236C0843
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 02:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCTBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjCTBHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 21:07:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8251B2D8;
        Sun, 19 Mar 2023 18:00:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PfxFD6GFQz4xFM;
        Mon, 20 Mar 2023 11:58:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679273921;
        bh=MI0XYywYczG3K7bOaIATz4F8xLX9bPF1QWo/wnhTVbM=;
        h=Date:From:To:Cc:Subject:From;
        b=EjoNjXUaHJYcaGK8LCNq9tx487dNSkl8O22usVQYG7n0BflA6InYfZXvJGRHHdKdx
         Oq6sXbruo5dECZD6UWRco8/zZCVdiE1GwB2PD+zxv1fBJkmwOHXNB2X+RQVe2pDXnW
         Sc25u1BlRUZdljNWvAWpfr0G77MZDaYGvhGzu+CBdzAfdr7yKNOGlXnvmAISvIWMLP
         aDIvqx49U7bRAA23K3GGjW7heGEy+qy1zKIIz6MoNI/ez3SCrhkgQftH3zWDvKmYFV
         H6H54oBir/bS4cuKb17E1NbKP+BKmSbXvrilENsDomoYkmCkIhbgZUERAXAJ5brTfa
         og1pGpDOSsmWA==
Date:   Mon, 20 Mar 2023 11:58:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>, Greg KH <greg@kroah.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the extcon tree with the driver-core
 tree
Message-ID: <20230320115839.5e645bb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0x8HCvzLhbJihMlPQzTJxu1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0x8HCvzLhbJihMlPQzTJxu1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the extcon tree got a conflict in:

  drivers/extcon/extcon.c

between commit:

  1aaba11da9aa ("driver core: class: remove module * from class_create()")

from the driver-core tree and commit:

  6384c02f33a9 ("extcon: Remove redundant null checking for class")

from the extcon tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/extcon/extcon.c
index d43ba8e7260d,adcf01132f70..000000000000
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@@ -1012,12 -1012,13 +1012,13 @@@ ATTRIBUTE_GROUPS(extcon)
 =20
  static int create_extcon_class(void)
  {
- 	if (!extcon_class) {
- 		extcon_class =3D class_create("extcon");
- 		if (IS_ERR(extcon_class))
- 			return PTR_ERR(extcon_class);
- 		extcon_class->dev_groups =3D extcon_groups;
- 	}
+ 	if (extcon_class)
+ 		return 0;
+=20
 -	extcon_class =3D class_create(THIS_MODULE, "extcon");
++	extcon_class =3D class_create("extcon");
+ 	if (IS_ERR(extcon_class))
+ 		return PTR_ERR(extcon_class);
+ 	extcon_class->dev_groups =3D extcon_groups;
 =20
  	return 0;
  }

--Sig_/0x8HCvzLhbJihMlPQzTJxu1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQXr78ACgkQAVBC80lX
0GwhvggAnjMc+pdxTWPFLXElgxvzQBFwoqvSAw8pMnYb8D01Mko1U/L6W30SN4MM
N8KRzeYgYJrIq/kBEknbhMJSxtJAPs9zMAXzYYjkdmPC8F2nLzbBQkMaro6xEJpP
WFjudA0yzxB0DtTK++e6aHr/js37Qubxh0kR69mc9rJK71trs7Z+OjYc0oFCfWXC
E9FSoiChjvgFyAGXhP63RboO+hFxTdKTCiAK59sJoP/rOWfFyt3unNMK1uQVHvmO
xkRHF6ITgKQMvVF/s+4YLLHmOv984Wa0RHCjhsTyGhZwpIwjKowuU7Eksae8PgRG
sPADgFN+b5kLrld7vs25G2u8BIIfJA==
=p4XR
-----END PGP SIGNATURE-----

--Sig_/0x8HCvzLhbJihMlPQzTJxu1--
