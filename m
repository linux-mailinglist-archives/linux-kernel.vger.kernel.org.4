Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362916D3B43
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjDCBHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjDCBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:06:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD5C9ED7;
        Sun,  2 Apr 2023 18:06:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqXmD659Tz4x1N;
        Mon,  3 Apr 2023 11:06:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680484013;
        bh=PTPcScOYIe7xSx8sdW5O4tpkVeWuH6u+Wl9huNtOAhI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZZY9NIQt4fTTQW9qQeU4xOCto984z9/P7OxwZac+eXbLhQIleubZIcw/b/1HbRg/L
         gP3WSmwy2yVArGws4kA0hm6Mf0DSmIWR+udaTwrFkja/bZMrXT8nvOVWyOw5F7Mted
         L2I/aR5t6cPXu9FKintSFT/g7nxlrHY4KEP+2lTRGh8QynoytASkkgvl+KszI8KrY4
         BJmuxk3q9vIQ1/app+zJEXYyT1CBos9dA81sAJIZVw5ch4IvN0IRgjsU5cDr6eM2sk
         2uTPiTScNQokVBakIbUnT0YtSvUgpGqO6oefVwPXvqCCnGgACZafFFWQ4fz9KioXct
         8IT7zydlbxl7A==
Date:   Mon, 3 Apr 2023 11:06:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20230403110650.6b13cb71@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iHBm0RMfkxAmt9y+pxm86Fo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iHBm0RMfkxAmt9y+pxm86Fo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/ata/pata_macio.c: In function 'pata_macio_attach':
drivers/ata/pata_macio.c:1172:23: error: implicit declaration of function '=
irq_create_mapping' [-Werror=3Dimplicit-function-declaration]
 1172 |                 irq =3D irq_create_mapping(NULL, 13);
      |                       ^~~~~~~~~~~~~~~~~~

Caused by commit (I am pretty sure, but can't see why)

  054e68aae050 ("ACPI: Replace irqdomain.h include with struct declarations=
")

I have applied the following patch for today (and it could be applied
to the pm tree).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 10:59:16 +1000
Subject: [PATCH] pata_macio: fixup for "ACPI: Replace irqdomain.h include w=
ith struct declarations"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ata/pata_macio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9ccaac9e2bc3..6aa4558d88e6 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/gfp.h>
 #include <linux/pci.h>
+#include <linux/irqdomain.h>
=20
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/iHBm0RMfkxAmt9y+pxm86Fo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqJqoACgkQAVBC80lX
0Gx9xgf/eJyGDVNaMFxyCe3DIgq/53fzdQ+/XYoByvNtNRxWhIL1gI8OjsHf4NSb
mkN7Ew9V24YEa97oiuDRJ3+gZdHDze3oG7x4D5CY2iqSQf8McMuNUDTPF3tGEvWK
zDjPNrCKCUgOa39/8bZsN3i3IVYuFqedVV5Mk0y5zRMKu3GRLLoPNsr80/n8nMaz
mVEs0i0M3hqrvBkvzuTDIAewYccU9+qu+hdq2nvOSEs7WimihGo9wfA/pUJNcNzD
k6b2s1exZpQNIUR79D4kT3xMCjpVLXbwYlyJf2Z4PUw8cEiV+P2U0fLHYzs057ls
tNtlP7ec0vuZUYB2lfy95ZKvQUHTuA==
=xe7f
-----END PGP SIGNATURE-----

--Sig_/iHBm0RMfkxAmt9y+pxm86Fo--
