Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72BC5E7305
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiIWEhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIWEhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:37:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D340122062;
        Thu, 22 Sep 2022 21:37:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYfWq1D80z4xG7;
        Fri, 23 Sep 2022 14:37:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663907848;
        bh=r79Fi2q7vDH+4keyU++nq/5BtRLQ9PuF+L6MJWPj3QM=;
        h=Date:From:To:Cc:Subject:From;
        b=Cc+9A/dbHjikYLgZgV2EX+JUlweOwI8rF9z+3xvzkV+rnJUyJsgNuAY3wcrK4rUK4
         P6MybwJORNSUJO2IBaaxFmU3DFpjggFubBBv0pZ4zuTLukGmt6ExDCmV4UC25rrJgv
         9Q2JR0De/bbmLjuVNMw2zSlWtkQADPJE19zGkeF8rqcLaBDh0Pbirep4k23gYfvuQ+
         iZZez8LMxH1cK6NYcji9FG70ou5IB6UAFGGsvQy+anLLwg9wrXYE/Y5LABWBZcNxbT
         ZPRkoO62wiv62jQRkHyMHzKiS8kMV4o120+MKxKM1UbQS/ZV1e8YZlB4azSeu18KxZ
         eRS5hwGLdScEA==
Date:   Fri, 23 Sep 2022 14:37:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Corey Minyard <cminyard@mvista.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Corey Minyard <minyard@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>
Subject: linux-next: manual merge of the ipmi tree with the i2c tree
Message-ID: <20220923143725.0641ee4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//tpbQMaQotCsAyBILEyG5e3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//tpbQMaQotCsAyBILEyG5e3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ipmi tree got a conflict in:

  drivers/char/ipmi/ipmi_ipmb.c

between commit:

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree and commit:

  80d98a33008c ("ipmi:ipmb: Don't call ipmi_unregister_smi() on a register =
failure")

from the ipmi tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Also, from Uwe:

"There is an immutable tag that can be merged into your tree to
resolve the conflict before you send your changes to Linux at

	https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/make_rem=
ove_callback_void-immutable"

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/char/ipmi/ipmi_ipmb.c
index 25c010c9ec25,740dc0f824e0..000000000000
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@@ -436,8 -434,16 +434,14 @@@ static void ipmi_ipmb_cleanup(struct ip
  	iidev->slave =3D NULL;
  	iidev->client =3D NULL;
  	ipmi_ipmb_stop_thread(iidev);
+ }
+=20
 -static int ipmi_ipmb_remove(struct i2c_client *client)
++static void ipmi_ipmb_remove(struct i2c_client *client)
+ {
+ 	struct ipmi_ipmb_dev *iidev =3D i2c_get_clientdata(client);
 =20
+ 	ipmi_ipmb_cleanup(iidev);
  	ipmi_unregister_smi(iidev->intf);
 -
 -	return 0;
  }
 =20
  static int ipmi_ipmb_probe(struct i2c_client *client)

--Sig_//tpbQMaQotCsAyBILEyG5e3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMtOAUACgkQAVBC80lX
0GwluQgApUUUI8r+mZFQ3RHr5guB1j0F9VPrsbuevJTX77cxvIk5ucVHNUm7Iyin
M35smueQxpKjeCGoJNOu+6cnBpG6/ZLy3wNlWr3MVoeXwXXUIIW3b4Ydpk1uB7tf
tcnncerI+rMDGCXvuFv/n2+NKs1vmMdiy+D0MinlbPSi03TJ0kQVoUF/p0PYM99N
T1T9MvzfaPi4i8vxMw4b7svsdacKbBCUbiv/NW9I5cgudJrJVi/KZ9b0exNe/3OQ
TrAKQplZo5olCKVvKKX8MrImL9JdmPjSo+RclPzUFm5hA5V+rhjS41jjOO0ffdRg
QEbuxrIkxSz7E9XJQ/WOQ+TapFCooQ==
=foYZ
-----END PGP SIGNATURE-----

--Sig_//tpbQMaQotCsAyBILEyG5e3--
