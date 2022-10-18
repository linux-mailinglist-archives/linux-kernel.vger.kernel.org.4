Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69E6020FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJRCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJRCNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:13:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD4912A85;
        Mon, 17 Oct 2022 19:13:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mry8D2tMWz4x1G;
        Tue, 18 Oct 2022 13:13:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666059212;
        bh=xkkcdp0//wKAI0Jdtp1I2x0RLjBWNFC7jv3X+ENzRnc=;
        h=Date:From:To:Cc:Subject:From;
        b=tdt7txRE4gdpOIvWXy+fYpTHY3MYXLa4jXjfv8UmNZXGMftaTjkOb5nKC1Bx1Dkro
         HCTMHQ3NwLgIZOEh+y43DI7FOfE1vvJk9jp8DlDVo6G4mE/5c+JnIPYLcotn0+lQLV
         kwptl8FenDGIYNIXRctEn13qhYHj2rsNcqijpMd/4XO1wXen2wo7U+aq16J9ciYzQg
         zNVDGdeZ6yn7IkhPXz1q84qNbojHIvZCcYpeeIUI02WhgRodlg8WX+ecGwXAyTWS3Z
         amLvxTEAWDPkG2bbpNf0XL8sIplg9to9BlQOyeLjeQbv/Gw6Vp26pmY2veJYd9tEFv
         0GK0LuVym9G2g==
Date:   Tue, 18 Oct 2022 13:13:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl-intel tree
Message-ID: <20221018131330.75fc1807@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cSQsey3m2yig/09V6eHz8RY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cSQsey3m2yig/09V6eHz8RY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl-intel tree, today's linux-next build (arm64
defconfig) failed like this:


Presumably caused by commit

  e6b665a1c9ae ("pinctrl: Clean up headers")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 18 Oct 2022 13:06:39 +1100
Subject: [PATCH] fix up for "pinctrl: Clean up headers"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zyn=
qmp.c
index 1a94db1ffa4f..f2be341f73e1 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -18,6 +18,7 @@
 #include <linux/firmware/xlnx-zynqmp.h>
=20
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/cSQsey3m2yig/09V6eHz8RY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNOC8oACgkQAVBC80lX
0Gyp2Qf+KZxzeGMR/kl4xR80i7VAYdXB82H1EV8myMQfg6Wnx8fedkhwneDDm7i4
g9hkRxT1OBrPvZMQhHy4qK6AdVJjcNjKlMw+npjQOKKF4I/l0jpKvqIsGfVUSvjR
XZdCROUO9VwDx1+z6G3BRmbxhvPHh2CRqWqLlphQkKMipaSDQDVcwBHl16LfhswP
QKN1ICdAuvxuLctvOY0rVMb/FoLmRSjU6e9OLMA2shXYy2EJNRExJNmgge9iEKl9
9a5sx7bxf7QX0vhTo8qxi3RqGlUeI0QI4fFymx8Wfhz/5UuCCkSBkZdHOM7SJv5t
kEJeEFeVGzPe7L6hvJjBfyV+kcRweg==
=GE0f
-----END PGP SIGNATURE-----

--Sig_/cSQsey3m2yig/09V6eHz8RY--
