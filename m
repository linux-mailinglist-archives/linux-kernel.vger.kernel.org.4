Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6C68B3B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFBUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:20:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EE317156;
        Sun,  5 Feb 2023 17:19:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P97j76Rk9z4xG5;
        Mon,  6 Feb 2023 12:19:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675646397;
        bh=lPC3IKVanPO9dkNzXFt0WTexqI63oiTmoCdia64RHBY=;
        h=Date:From:To:Cc:Subject:From;
        b=LHab+XktxSuCFgyHrYyg/3ze+R55DQDFndX5Wd9k7hOjs42WfxLOrsflvuw8i5rRv
         39XWS+aTs1qoaifvbdXoijx/XUCkxP+E9B/tFfWihsBDMfkgR6jx9l4zBYLC7d2/e1
         KOOLkIqinFFA4ZQETaL+2CaTmgpWH0DqWSwD9o6E7K+P5I1H00YDC3m7fI4iR6FOyv
         V7GJqmi9w4XLJ+ELIgeevwX5FzOaCaIi/iRUao5ooALmd7CbXUGSHPdtWCC8mJYNBL
         Jkj4KxPPt3IeJHNcG0X+SaX9cuKGGAvkaxpyMSPMHGjJHtfDuv8MnoIB0bD5FbVPi5
         I/Rot2MD+vk+w==
Date:   Mon, 6 Feb 2023 12:19:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the irqchip tree with the tip tree
Message-ID: <20230206121954.57b521fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lr8hQB1aVgSSOf144VAv0Wj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lr8hQB1aVgSSOf144VAv0Wj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the irqchip tree got a conflict in:

  drivers/irqchip/irq-apple-aic.c

between commit:

  0e2213fe0ab4 ("irqchip: Use irq_domain_alloc_irqs()")

from the tip tree and commit:

  c19f89719428 ("irqchip/apple-aic: Move over to core ipi-mux")

from the irqchip tree.

I fixed it up (the latter removed the code modified by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

However, an earlier commit in the irqchip tree

  835a486cd9f5 ("genirq: Add mechanism to multiplex a single HW IPI")

created a new user of __irq_domain_alloc_irqs(), so I also added the
following merge fix up patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 Feb 2023 12:14:47 +1100
Subject: [PATCH] fix up for "irqchip: Use irq_domain_alloc_irqs()"

interacting with "genirq: Add mechanism to multiplex a single HW IPI"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 kernel/irq/ipi-mux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/ipi-mux.c b/kernel/irq/ipi-mux.c
index 3a403c3a785d..fa4fc18c6131 100644
--- a/kernel/irq/ipi-mux.c
+++ b/kernel/irq/ipi-mux.c
@@ -185,8 +185,7 @@ int ipi_mux_create(unsigned int nr_ipi, void (*mux_send=
)(unsigned int cpu))
 	domain->flags |=3D IRQ_DOMAIN_FLAG_IPI_SINGLE;
 	irq_domain_update_bus_token(domain, DOMAIN_BUS_IPI);
=20
-	rc =3D __irq_domain_alloc_irqs(domain, -1, nr_ipi,
-				     NUMA_NO_NODE, NULL, false, NULL);
+	rc =3D irq_domain_alloc_irqs(domain, nr_ipi, NUMA_NO_NODE, NULL);
 	if (rc <=3D 0) {
 		pr_err("unable to alloc IRQs from IPI Mux domain\n");
 		goto fail_free_domain;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lr8hQB1aVgSSOf144VAv0Wj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgVboACgkQAVBC80lX
0GwuhQf9FSQwMzVxr6BPPCV/f3w+BsyYsREMxIy+pDYgRfxSBcBeSzlyAWZjT/Sg
Ftb7YY2wzpuhy8rdMToVfoVEWKAQhadYEzlJDxbNsBYxXI2+gbzht7Gk2jGcP1a8
BqLHv9vdSdVtVC4JEPnuYSmo9INEiPATKGGcnSHBpRddKl5PIVdtxTKgzp3Sqyo5
PkoPTodm3jIMFRusPZaUmFqVeyXRnxuKMuTnFde+ULoyp0Iqv0t7vLmWHeXpceSC
QuDdBG3LrcrbPfkEyi+U0Jvd9Fqh0Ta3vmTCe6jYsiWcCMr6XE0ZnsJLudYKRe5F
6nOBk3PD128fof5hMqTTluosqkEAig==
=AxDS
-----END PGP SIGNATURE-----

--Sig_/lr8hQB1aVgSSOf144VAv0Wj--
