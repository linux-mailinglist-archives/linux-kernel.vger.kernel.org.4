Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1146D3B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDCBQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjDCBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:16:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C2A5D7;
        Sun,  2 Apr 2023 18:16:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PqXyt2cyJz4x1d;
        Mon,  3 Apr 2023 11:16:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680484566;
        bh=Eq34X4oBsarY8sKOnMd8UcyDXJyKSQMHQGeL0iJVB5o=;
        h=Date:From:To:Cc:Subject:From;
        b=NcNmG7ivywHpUHLbL2b2YRk8T7f/34a2/FKp57xpJB+EMx1BRm/SRTsdn1Zied/jR
         Vy4wph93x8SwXnZR8OVgVvN3QHIShAfOKZhRvMX5XfKGco59FCeWENVO+T+4itTaur
         VI7T4xNuUxq9Kp6TEx/EffpoBFI0KAQceQvIdF4+Pm444aAMM7b5SnOW2FNfu39Dn8
         Ue+ISf+WZ/zqd2zM0ZWMCLPBNRtmxkd/9I6oUcjnDcKuWtTjxvmz7MncLo+qND4CDi
         9OftrnbV0j4gMsxOV4Y96nnYoeDIK3Ok9MI14G3QDolwKfgSQUHWwS52a0UT8ZuFlB
         KJRse4K45XZBQ==
Date:   Mon, 3 Apr 2023 11:16:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20230403111605.7658ec62@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9FIjEAsBv/A+6tFJOfeHpfF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9FIjEAsBv/A+6tFJOfeHpfF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/virtio/virtio_mmio.c: In function 'vm_find_vqs':
drivers/virtio/virtio_mmio.c:492:13: error: implicit declaration of functio=
n 'of_property_read_bool'; did you mean 'fwnode_property_read_bool'? [-Werr=
or=3Dimplicit-function-declaration]
  492 |         if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeu=
p-source"))
      |             ^~~~~~~~~~~~~~~~~~~~~
      |             fwnode_property_read_bool

Caused by commit (I am pretty sure, but can't see why)

  054e68aae050 ("ACPI: Replace irqdomain.h include with struct declarations=
")

I have applied the following patch for today (and it could be applied
to the pm tree).

=46rom f920b59d2ca8dcbe8d80f103e109032800c699be Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 3 Apr 2023 11:11:09 +1000
Subject: [PATCH] virtio_mmio: fix up for "ACPI: Replace irqdomain.h include
 with struct declarations"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/virtio/virtio_mmio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 3ff746e3f24a..06f1ecff2a3a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -55,6 +55,7 @@
 #define pr_fmt(fmt) "virtio-mmio: " fmt
=20
 #include <linux/acpi.h>
+#include <linux/of.h>
 #include <linux/dma-mapping.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/9FIjEAsBv/A+6tFJOfeHpfF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQqKNUACgkQAVBC80lX
0Gx+rAf+JAA85K3leQJDMrnOUaFhIUABWSXL8Eo3Fh1XgOSnfF+XtJFgkw6Bf7hp
zUldkJpbw9PogNvUnelhMrLzzXvvY8WXUanp6Da8XujGAMOtXrVEmnfx65pDKf5P
qBoueyo0CmjMeyULZbeni0bvab8ow2hdOIlffqI6lczNKOfLsyEomgJwkGQxejKN
8T+PAOMOhBKMKdLokWJ7Mz9HUDlDY4ZL06uryxoQVu8jOW0aOfcFysqyOXJ9kX9w
/+87pHn6zD6hKXlekXxncnP2LuBVMaO8mccAUS6Wuz7KrxDb+7Ms3fWciFUQL3dJ
Y5hhSXs/9u618D++hmfc5skBsbAtuA==
=MgB1
-----END PGP SIGNATURE-----

--Sig_/9FIjEAsBv/A+6tFJOfeHpfF--
