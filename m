Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F426DCFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDKC3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjDKC27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:28:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9981982;
        Mon, 10 Apr 2023 19:28:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PwVC85ZDvz4xDh;
        Tue, 11 Apr 2023 12:28:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1681180133;
        bh=6e/jGpYDTAVw88CVqimS+a5Lt1DPmUftbnGWNhtg8oo=;
        h=Date:From:To:Cc:Subject:From;
        b=qp7qUKOZN3NpYLS8Vhe3ldz3K7BJodvVUfG/G0LiHStWw/lT+Opw/mkhahnskU3ls
         MBr0BfaRXB/DqAEMXBbQh+w0RdchJPWPPO1PuJFYg3doNiizWm3YTIuMw8ZLkV4t2M
         cWm70kPsbXn94qgsSCWlXh9pMhImJIvjpDYzdueoy+hNrkUfSg3/yJZYC/hCUCzlTO
         NoMhSJ6dg5MbyKO3fGr9Xzm54gaOPoaGMlhnOF2BHxdPyBVusVqyZ5TXdx6u81oPXR
         LIkRD0lwv6quiHxcM1tAVsOAhU8PMdDepdPVw+l6LYVFCKp1MQMtIOjXNEgGUUvliD
         TOF89gPwGEPGA==
Date:   Tue, 11 Apr 2023 12:28:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Petr Pavlu <petr.pavlu@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the devicetree tree
Message-ID: <20230411122851.57f3dac6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BprD_/xTEOv=gen9_bAa.hx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BprD_/xTEOv=gen9_bAa.hx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devicetree tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/cpufreq/acpi-cpufreq.c:1024:15: error: variable 'acpi_cpufreq_platd=
rv' has initializer but incomplete type
 1024 | static struct platform_driver acpi_cpufreq_platdrv =3D {
      |               ^~~~~~~~~~~~~~~
drivers/cpufreq/acpi-cpufreq.c:1025:10: error: 'struct platform_driver' has=
 no member named 'driver'
 1025 |         .driver =3D {
      |          ^~~~~~
drivers/cpufreq/acpi-cpufreq.c:1025:19: error: extra brace group at end of =
initializer
 1025 |         .driver =3D {
      |                   ^
drivers/cpufreq/acpi-cpufreq.c:1025:19: note: (near initialization for 'acp=
i_cpufreq_platdrv')
drivers/cpufreq/acpi-cpufreq.c:1025:19: error: excess elements in struct in=
itializer [-Werror]
drivers/cpufreq/acpi-cpufreq.c:1025:19: note: (near initialization for 'acp=
i_cpufreq_platdrv')
drivers/cpufreq/acpi-cpufreq.c:1028:10: error: 'struct platform_driver' has=
 no member named 'remove'
 1028 |         .remove         =3D acpi_cpufreq_remove,
      |          ^~~~~~
drivers/cpufreq/acpi-cpufreq.c:1028:27: error: excess elements in struct in=
itializer [-Werror]
 1028 |         .remove         =3D acpi_cpufreq_remove,
      |                           ^~~~~~~~~~~~~~~~~~~
drivers/cpufreq/acpi-cpufreq.c:1028:27: note: (near initialization for 'acp=
i_cpufreq_platdrv')
drivers/cpufreq/acpi-cpufreq.c: In function 'acpi_cpufreq_init':
drivers/cpufreq/acpi-cpufreq.c:1033:16: error: implicit declaration of func=
tion 'platform_driver_probe' [-Werror=3Dimplicit-function-declaration]
 1033 |         return platform_driver_probe(&acpi_cpufreq_platdrv, acpi_cp=
ufreq_probe);
      |                ^~~~~~~~~~~~~~~~~~~~~
drivers/cpufreq/acpi-cpufreq.c: In function 'acpi_cpufreq_exit':
drivers/cpufreq/acpi-cpufreq.c:1038:9: error: implicit declaration of funct=
ion 'platform_driver_unregister'; did you mean 'driver_unregister'? [-Werro=
r=3Dimplicit-function-declaration]
 1038 |         platform_driver_unregister(&acpi_cpufreq_platdrv);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |         driver_unregister
drivers/cpufreq/acpi-cpufreq.c: At top level:
drivers/cpufreq/acpi-cpufreq.c:1024:31: error: storage size of 'acpi_cpufre=
q_platdrv' isn't known
 1024 | static struct platform_driver acpi_cpufreq_platdrv =3D {
      |                               ^~~~~~~~~~~~~~~~~~~~

I am not sure which of the include file update commits were the direct
cause but they interacted with commit

  691a63712347 ("ACPI: cpufreq: Use platform devices to load ACPI PPC and P=
CC drivers")

from the pm tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 11 Apr 2023 12:15:29 +1000
Subject: [PATCH] devicetree: fix up for include rationalisation

interacting with "ACPI: cpufreq: Use platform devices to load ACPI PPC and =
PCC drivers"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cpufreq/acpi-cpufreq.c | 1 +
 drivers/cpufreq/pcc-cpufreq.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index e1a5384cf21c..29904395e95f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -20,6 +20,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/string_helpers.h>
+#include <linux/platform_device.h>
=20
 #include <linux/acpi.h>
 #include <linux/io.h>
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 0c362932ca60..b4318a1a9335 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/platform_device.h>
=20
 #include <acpi/processor.h>
=20
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/BprD_/xTEOv=gen9_bAa.hx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQ0xeQACgkQAVBC80lX
0GwkBQgAl8bZzR2qrb78D0W9Mvb7FH6hEyViM4Wnm2y8a8AO5ihwTaOMFNO3vZZp
1UR/uNKhky3v2DvqT0CLfReEOHtf+U6WbipYkp+5ofmI7HaPMRx5e+zUSfJzhSya
5YTRHtLF8JmIWlFuQ6bKNrVvjZw/KFDmRYZNlNmruM+gqfq+MqVxnxjfoNqy5UaF
WeVALYuk55RIcMZSRqSaQQGcavXEfF+sorC5xqoPvvmJLj3k/YPEHWhTvN3sdCsw
7ZaYZDjozKoKh2eli3YGNaN1O2qPwpokMJrpB82K6zjEBeqlp41ya8FvVShclDh0
yh23DL57VEWWv+z8oAuWe7Rqg3tCxg==
=JMvZ
-----END PGP SIGNATURE-----

--Sig_/BprD_/xTEOv=gen9_bAa.hx--
