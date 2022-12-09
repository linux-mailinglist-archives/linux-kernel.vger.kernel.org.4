Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6CA648B51
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 00:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLIXZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 18:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLIXZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 18:25:18 -0500
X-Greylist: delayed 1136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Dec 2022 15:25:17 PST
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CB236D71;
        Fri,  9 Dec 2022 15:25:17 -0800 (PST)
Received: from 213.219.160.184.adsl.dyn.edpnet.net ([213.219.160.184] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1p3mRe-0003If-BR; Sat, 10 Dec 2022 00:06:18 +0100
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1p3mRd-00152y-20;
        Sat, 10 Dec 2022 00:06:17 +0100
Date:   Sat, 10 Dec 2022 00:06:17 +0100
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Daniel Wagner <wagi@monom.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH 4.19-rt] Revert "percpu: include irqflags.h for
 raw_local_irq_save()"
Message-ID: <Y5O/aVw/zHKqmpu7@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uuwevuhf7j7y0M7M"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 213.219.160.184
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uuwevuhf7j7y0M7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This reverts commit 0d796a9e6a93608b4dd84fbd09f01e912ae34bdc.

After merging stable release 4.19.266 into the -rt branch, an x86
build will fail with the following error:

    .../include/linux/percpu-defs.h:49:34: error: 'PER_CPU_BASE_SECTION' un=
declared here (not in a function); did you mean 'PER_CPU_FIRST_SECTION'?

This is due to an #include loop:

    <asm/percpu.h>
     -> <linux/irqflags.h>
         -> <asm/irqflags.h>
             -> <asm/nospec-branch.h>
                 -> <asm/percpu.h>

which appears after the merge because:

- The reverted commit added <asm/percpu.h> -> <linux/irqflags.h>
- 4.19.266 added <asm/nospec-branch.h> -> <asm/percpu.h>

Neither upstream nor any other maintained stable-rt branch has this
include, and my build succeeded without it.  Revert it here as well.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/asm-generic/percpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 942d64c0476e..1817a8415a5e 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -5,7 +5,6 @@
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
-#include <linux/irqflags.h>
=20
 #ifdef CONFIG_SMP
=20

--Uuwevuhf7j7y0M7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmOTv2UACgkQ57/I7JWG
EQm8cxAAjgtgenRHvJGVsZhKsRxMqfv6YxDmRz3vbTNy+Stvwjb3GqJMqmFK6QMT
atMwt6p25lzTvBKnyaZ2z1st1t/33iXBWzklXAAuX3RKmcR2MJcvg06Rp8VQPHP+
4q6fVrXiwhz+6IqBcfJ87co+3jtAwofG00GRn1y5/Vva6Dsf4nVLFflneY+YsTBW
tWz5G5V7ZduSUdr7EsYiUZB11CFjs/FKnE6DJ5+OGce7blbSoFDEGW+B0VXZ7NJO
fItRT5BhW0j6uxZp1n1rTeai5nhDa6Z1o4xSWTKFcS0CkWBmxk3Fr30PgMZBcVRx
BRwJT7pVWbR5U4hFVAdqxEEfEi03W4t7Ny0OHFkIVyPPxl40bu8+/6Lav4nTyuQh
M6baQ8oikJHdNLFoY4oFGbt8Xu2f7LdPFFx6+awcKP3MLOhOCgQf9G19dmnysc59
PPwzziobGTS4ePiInddpvGTiZi+Q9c/JFJyWYwVDuLJ9/GX4DSO5u7iwfYL681in
6s9isg0xQVY7O2aEXXK27p4D+ejx9iVXuy4cqYNIj1ZolnSlf/2uaMH1s6p8h+Rj
Yui3j+PkqbGISWxD7kq7L4MkENhegMawM0DuZIcn5P4xvRJc59yqSF2XbnO/W1p6
RjrxviiedM55Tu49+Nnh/TyVGH16faOvWdFXhvcKK6kctBX7Tfo=
=g2T+
-----END PGP SIGNATURE-----

--Uuwevuhf7j7y0M7M--
