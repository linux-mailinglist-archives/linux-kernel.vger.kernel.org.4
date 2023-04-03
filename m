Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571236D3B7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjDCBZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjDCBZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:25:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62006C2;
        Sun,  2 Apr 2023 18:25:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqY9S04ZGz4x4r;
        Mon,  3 Apr 2023 11:25:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680485116;
        bh=K7bN2CvB53gdM9mpqDSBf2k4Lm1npAZ70x7lZmPaZcA=;
        h=Date:From:To:Cc:Subject:From;
        b=TSCBLzgLD8z7kb/dWBkOf8d27qW4TLmumjsU/PE9+soWc6E89IahKVlrKlfLn5sAl
         6Vx5H/hfd2/6rs67vBPl22JTYtDSoYpxNCFuV2/uKJOCDLWqHmM0w6gCleNrP1i7Zt
         Ubgdwy4Ok26hF32IKWbDueGVivpkvvQ8NzKMsir8nOuFm/1gVQJ3izy/WOXkUaUJ3h
         X3JKRqXjZLGkOeKwyGQy29kdba+SEh54Kb6st+nBJm3WD/I6D2Toa9pGBtEyh0grrS
         foUzTkiWFMHy5vWKOMwvk/a3wydGGm+Zbc/kHzTWi+iPs3ufj8jtl+IcGclUPuQSH4
         ld6iLrN6A+xZg==
Date:   Mon, 3 Apr 2023 11:25:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20230403112514.47ff91bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/efamJ5q6b2=Z4wJLwzeKllB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/efamJ5q6b2=Z4wJLwzeKllB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/fpga/lattice-sysconfig-spi.c:146:35: error: implicit declaration of=
 function 'of_match_ptr' [-Werror=3Dimplicit-function-declaration]
  146 |                 .of_match_table =3D of_match_ptr(sysconfig_of_ids),
      |                                   ^~~~~~~~~~~~
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: initialization of 'cons=
t struct of_device_id *' from 'int' makes pointer from integer without a ca=
st [-Werror=3Dint-conversion]
drivers/fpga/lattice-sysconfig-spi.c:146:35: note: (near initialization for=
 'lattice_sysconfig_driver.driver.of_match_table')
drivers/fpga/lattice-sysconfig-spi.c:146:35: error: initializer element is =
not constant
drivers/fpga/lattice-sysconfig-spi.c:146:35: note: (near initialization for=
 'lattice_sysconfig_driver.driver.of_match_table')
drivers/ata/pata_ixp4xx_cf.c: In function 'ixp4xx_pata_probe':
drivers/ata/pata_ixp4xx_cf.c:254:46: error: invalid use of undefined type '=
struct device_node'
  254 |         ixpp->rmap =3D syscon_node_to_regmap(np->parent);
      |                                              ^~
drivers/ata/pata_ixp4xx_cf.c:258:15: error: implicit declaration of functio=
n 'of_property_read_u32_index'; did you mean 'fwnode_property_read_u32_arra=
y'? [-Werror=3Dimplicit-function-declaration]
  258 |         ret =3D of_property_read_u32_index(np, "reg", 0, &csindex);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |               fwnode_property_read_u32_array

Caused by commit (I am pretty sure, but can't see why)

  054e68aae050 ("ACPI: Replace irqdomain.h include with struct declarations=
")

I have applied the following patch for today (and it could be applied
to the pm tree).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 11:21:33 +1000
Subject: [PATCH] lattice-sysconfig-spi, pata_ixp4xx_cf.c: fixup for "ACPI:
 Replace irqdomain.h include with struct declarations"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ata/pata_ixp4xx_cf.c         | 1 +
 drivers/fpga/lattice-sysconfig-spi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index e225913a619d..64f77fa457cd 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -18,6 +18,7 @@
 #include <linux/libata.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <scsi/scsi_host.h>
=20
diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sy=
sconfig-spi.c
index 2702b26b7f55..44691cfcf50a 100644
--- a/drivers/fpga/lattice-sysconfig-spi.c
+++ b/drivers/fpga/lattice-sysconfig-spi.c
@@ -3,6 +3,7 @@
  * Lattice FPGA programming over slave SPI sysCONFIG interface.
  */
=20
+#include <linux/of.h>
 #include <linux/spi/spi.h>
=20
 #include "lattice-sysconfig.h"
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/efamJ5q6b2=Z4wJLwzeKllB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqKvsACgkQAVBC80lX
0Gz+Igf9Fi8Myh18fz3bznDkWV2TY926trsVJnNigLBvCPxu5F9ZoBAnDCGAfOpx
3l7XNnI7vyqYhKl7uVnHcyaXCVlZeU87Ev6rgb9hDa0TBYcWqbOYtSv6zO+0fi7E
n6Lfm0LHUjN99R/zRrxcYsVdrzKjm8vARLWpEWS5rQxDAWCxrfqC6f+KAlXcHuDz
p1JCaQrs+7yhOxw3j7xKbeuZkdsEYfdLlgop4oDV/U94VgJyk6WXtmW4Xo0JkfLn
p77ROoXg8dIDYz3J7Yxw6ZQMP/Tb910kGbVzDgNnLZewsRvvLFzQVW4/8pIOduFZ
QpYVL75MzCwkMuJmQh0SAn8cyEg9OA==
=uPy2
-----END PGP SIGNATURE-----

--Sig_/efamJ5q6b2=Z4wJLwzeKllB--
