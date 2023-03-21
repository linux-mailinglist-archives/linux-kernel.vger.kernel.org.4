Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E746C2781
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCUBeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCUBee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:34:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28B23879;
        Mon, 20 Mar 2023 18:34:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PgZ052DbLz4x7s;
        Tue, 21 Mar 2023 12:34:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679362469;
        bh=ZlA4pbaiTF3e9ngHL/ahUie9GZ/wITT5iUPnRg/sE54=;
        h=Date:From:To:Cc:Subject:From;
        b=Z5RXzgslvAjsU0srKmxM5gq4vRPHAU6bAH6T1TNFEI6vo0BYUCNQBKoD0yJxC953U
         /zXyqne1M/rU2UDcD6zSf956P/N3xUQfVTyLkbhtj4Px2mKlkDc9OJc3vgV8AaXC5d
         RbBoSyNaO0Epe3ygU8HFChiwG7ODmKe/KcrjvrF701ZXSF0LLYLNxzTewzwvJ5nMXp
         AuSnOgh9RB1BYO3cwGK5F2W9HoxXdX4oshkPibgExWoFfNcBgoxP06SfhvD2FE0Xjr
         dYMt1OCJSx+SdgfKG2Mqnn5Ckv1FQD1+K4+hB2wGPqkh0SjdAZznZFKPykajYmgqQD
         L4TApARfCOFwA==
Date:   Tue, 21 Mar 2023 12:34:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: linux-next: manual merge of the driver-core tree with the s390 tree
Message-ID: <20230321123428.5c6956f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PbTEiaHO3HQCdXicM/QjMW2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PbTEiaHO3HQCdXicM/QjMW2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  arch/s390/kernel/topology.c

between commit:

  0599331c3da6 ("s390: simplify one-level sysctl registration for topology_=
ctl_table")

from the s390 tree and commit:

  9493ed19fbc3 ("s390/topology: move to use bus_get_dev_root()")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/kernel/topology.c
index e5d6a1c25d13,72af753d1bba..000000000000
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@@ -637,14 -637,33 +637,23 @@@ static struct ctl_table topology_ctl_ta
  	{ },
  };
 =20
 -static struct ctl_table topology_dir_table[] =3D {
 -	{
 -		.procname	=3D "s390",
 -		.maxlen		=3D 0,
 -		.mode		=3D 0555,
 -		.child		=3D topology_ctl_table,
 -	},
 -	{ },
 -};
 -
  static int __init topology_init(void)
  {
+ 	struct device *dev_root;
+ 	int rc =3D 0;
+=20
  	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
  	if (MACHINE_HAS_TOPOLOGY)
  		set_topology_timer();
  	else
  		topology_update_polarization_simple();
 -	register_sysctl_table(topology_dir_table);
 +	register_sysctl("s390", topology_ctl_table);
- 	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
+=20
+ 	dev_root =3D bus_get_dev_root(&cpu_subsys);
+ 	if (dev_root) {
+ 		rc =3D device_create_file(dev_root, &dev_attr_dispatching);
+ 		put_device(dev_root);
+ 	}
+ 	return rc;
  }
  device_initcall(topology_init);

--Sig_/PbTEiaHO3HQCdXicM/QjMW2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQZCaQACgkQAVBC80lX
0GwXlwgAjKQOBV0TWFS/qzghNSsQoRGhctl6iCo9/8hNJISP2s6Hon1aU1+u/QYb
h5MJ6xEbYqZ7SawaalGuOLVfc+kg7qC0PFyLET/epcuPhFZ4yM5FD4ltRuugFHwf
xRNUgnYUthSf8l+ZPDjro8+T2PPEF4iwRNP4hkYvKsnx78LnR8Mn95ZkykY1UAMH
UucYyB9zH8beReorfz/hnSzBmQuFKZZK41/8In0fK77moWQBQS8E0YwhfMbzObbg
SnFfZniWhndRkFP1zf0NUtrSrkW1HP3lnKQBtefapK1MiqfjgmLRku/CD7rcOE9F
sE1Qb1d0NOvNk4WCbGes5DhGimed+A==
=QEQY
-----END PGP SIGNATURE-----

--Sig_/PbTEiaHO3HQCdXicM/QjMW2--
