Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDCF6D41BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjDCKSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjDCKSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:18:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727CAEFAC;
        Mon,  3 Apr 2023 03:18:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pqn0G2lPqz4x4r;
        Mon,  3 Apr 2023 20:18:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680517086;
        bh=ru5t21vmlUCJYLbm/kwT474oscAtcYuhx1bI+RTdVmI=;
        h=Date:From:To:Cc:Subject:From;
        b=bZAKXePH/eHH+pyxxQd39poz/AVjbg8Pxkv2kumzmt8ISh7mCIjRuHsN/AbvA4LA4
         YCCAw04+Ta5nlMhkbTmwwKGiR067v6fRUdbtjstosxFYkV53+Z/piz/LlU03OC8VI3
         19NeJX0Rsf+0P9NKLWPOF9lMCBm0sS/UocKUY1tFsAkWQ/KfiK/nkM5JUd7o2SC+xT
         JtcnpQLZRAnVkGUqSU0oC9+5afXEdsKJRk7/MCkqdAU+ZvYdAj6cT55rdM3j/rwP2H
         Zv1QYa4DXdVrwE0Ji1zFDWbnW9OV+2bYC32g4QR4jiJr2mTGz9/tOQxL/iUMA/LprJ
         FTbLSYs+DLhcQ==
Date:   Mon, 3 Apr 2023 20:18:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20230403201801.02839c9a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/42w0VrcIT_O2t+VtyAP99_3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/42w0VrcIT_O2t+VtyAP99_3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (powerpc allyesconfig)
failed like this:

In file included from drivers/char/tpm/tpm_atmel.c:18:
drivers/char/tpm/tpm_atmel.h: In function 'atmel_get_base_addr':
drivers/char/tpm/tpm_atmel.h:50:14: error: implicit declaration of function=
 'of_find_node_by_name'; did you mean 'bus_find_device_by_name'? [-Werror=
=3Dimplicit-function-declaration]
   50 |         dn =3D of_find_node_by_name(NULL, "tpm");
      |              ^~~~~~~~~~~~~~~~~~~~
      |              bus_find_device_by_name
drivers/char/tpm/tpm_atmel.h:50:12: error: assignment to 'struct device_nod=
e *' from 'int' makes pointer from integer without a cast [-Werror=3Dint-co=
nversion]
   50 |         dn =3D of_find_node_by_name(NULL, "tpm");
      |            ^
drivers/char/tpm/tpm_atmel.h:55:14: error: implicit declaration of function=
 'of_device_is_compatible'; did you mean 'fwnode_device_is_compatible'? [-W=
error=3Dimplicit-function-declaration]
   55 |         if (!of_device_is_compatible(dn, "AT97SC3201")) {
      |              ^~~~~~~~~~~~~~~~~~~~~~~
      |              fwnode_device_is_compatible
drivers/char/tpm/tpm_atmel.h:56:17: error: implicit declaration of function=
 'of_node_put' [-Werror=3Dimplicit-function-declaration]
   56 |                 of_node_put(dn);
      |                 ^~~~~~~~~~~
drivers/char/tpm/tpm_atmel.h:60:15: error: implicit declaration of function=
 'of_get_property' [-Werror=3Dimplicit-function-declaration]
   60 |         reg =3D of_get_property(dn, "reg", &reglen);
      |               ^~~~~~~~~~~~~~~
drivers/char/tpm/tpm_atmel.h:60:13: error: assignment to 'const unsigned in=
t *' from 'int' makes pointer from integer without a cast [-Werror=3Dint-co=
nversion]
   60 |         reg =3D of_get_property(dn, "reg", &reglen);
      |             ^
drivers/char/tpm/tpm_atmel.h:61:18: error: implicit declaration of function=
 'of_n_addr_cells' [-Werror=3Dimplicit-function-declaration]
   61 |         naddrc =3D of_n_addr_cells(dn);
      |                  ^~~~~~~~~~~~~~~
drivers/char/tpm/tpm_atmel.h:62:18: error: implicit declaration of function=
 'of_n_size_cells' [-Werror=3Dimplicit-function-declaration]
   62 |         nsizec =3D of_n_size_cells(dn);
      |                  ^~~~~~~~~~~~~~~
drivers/perf/arm_dmc620_pmu.c:710:36: error: array type has incomplete elem=
ent type 'struct acpi_device_id'
  710 | static const struct acpi_device_id dmc620_acpi_match[] =3D {
      |                                    ^~~~~~~~~~~~~~~~~
drivers/perf/arm_dmc620_pmu.c:710:36: error: 'dmc620_acpi_match' defined bu=
t not used [-Werror=3Dunused-variable]
drivers/perf/alibaba_uncore_drw_pmu.c:757:36: error: array type has incompl=
ete element type 'struct acpi_device_id'
  757 | static const struct acpi_device_id ali_drw_acpi_match[] =3D {
      |                                    ^~~~~~~~~~~~~~~~~~
drivers/perf/alibaba_uncore_drw_pmu.c:757:36: error: 'ali_drw_acpi_match' d=
efined but not used [-Werror=3Dunused-variable]

Caused by commit

  054e68aae050 ("ACPI: Replace irqdomain.h include with struct declarations=
")

I have applied the following fixup patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 19:58:19 +1000
Subject: [PATCH] more fixups for "ACPI: Replace irqdomain.h include with
 struct declarations"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/tpm/tpm_atmel.h          | 2 ++
 drivers/perf/alibaba_uncore_drw_pmu.c | 1 +
 drivers/perf/arm_dmc620_pmu.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
index ba37e77e8af3..0129d76a4fa3 100644
--- a/drivers/char/tpm/tpm_atmel.h
+++ b/drivers/char/tpm/tpm_atmel.h
@@ -26,6 +26,8 @@ struct tpm_atmel_priv {
=20
 #ifdef CONFIG_PPC64
=20
+#include <linux/of.h>
+
 #include <asm/prom.h>
=20
 #define atmel_getb(priv, offset) readb(priv->iobase + offset)
diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_u=
ncore_drw_pmu.c
index 5c5be9fc1b15..208b1fe1d247 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -28,6 +28,7 @@
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/refcount.h>
+#include <linux/mod_devicetable.h>
=20
=20
 #define ALI_DRW_PMU_COMMON_MAX_COUNTERS			16
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 5de06f9a4dd3..3a006b34b515 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -27,6 +27,7 @@
 #include <linux/printk.h>
 #include <linux/rculist.h>
 #include <linux/refcount.h>
+#include <linux/mod_devicetable.h>
=20
 #define DMC620_PA_SHIFT					12
 #define DMC620_CNT_INIT					0x80000000
--=20
2.39.2



--=20
Cheers,
Stephen Rothwell

--Sig_/42w0VrcIT_O2t+VtyAP99_3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqp9kACgkQAVBC80lX
0GyFzwf+IbCP/bBYmKBeioQ0d/k0ev2xVd2UbK86K9Vnj/MAph3qxPqgY4JVnh2L
NpHiiQCXfJPk652kXtVYWbPK2rnRtX2pUtV1Di4WbM2BtyQBRvReJwzLW0XZMLX5
7n2Hdoc226hQ/XnVKllkGDz5jKH9+N7n6b6TPEbYPnGZOEeaVBdFlvp/KajuBdjJ
6L4goxT9eok87Ae/squvKxgUh5iRPpEpCsUPSDOTc4Dz7MKLPuQgtZWMmchy8mjc
MV3n/tySrL+Zn+9V9EraOHK1ERvFni4m7U1Ivsy5w7k0GeX+lDTQTGX5dqlDEJXt
Vh7TaLppMmr8LuiCm+zEZyYBSV1hPQ==
=yGVs
-----END PGP SIGNATURE-----

--Sig_/42w0VrcIT_O2t+VtyAP99_3--
