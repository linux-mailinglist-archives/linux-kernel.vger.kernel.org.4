Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B056380F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 23:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKXWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 17:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXWqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 17:46:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA285ED4;
        Thu, 24 Nov 2022 14:46:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJCly4n2wz4wgr;
        Fri, 25 Nov 2022 09:46:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669329999;
        bh=/61EB3InfPZNQkzeBQ1PJC8S/jDdwtaKgy/iFS5fl6c=;
        h=Date:From:To:Cc:Subject:From;
        b=W2WteE0X6vFyFdxvVkeM57ob/pf9TskIJJ8xXjcQVkHNSS9gFgMrpiUgTjf9Sd0Ov
         p2UTAsqXdXRzJG69qo5KNXM8zH2j3XIRjAChqLgwFIBkT/04FdsgrM7doNDGG8cGSr
         FqZiLYV7LxoLeI7/KEc7OYr5T+UPRtJHyvwYiGKCEPIn3x/lHn3DUPzHTgc1J++isL
         8feaM6jbc7/XPgRqnLn1TzV5d7gQk5HEyfXxrJXBKJY2XdL5+GB+c5imybXxyud5Im
         E7ehdgE9QVWqCXSPLXhn5XaJKIVLqvPZdslEk1rTXUn4I6ccyE31tYBS+ZE0hX/vcu
         6lx2gMNut8pKg==
Date:   Fri, 25 Nov 2022 09:46:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the nand tree with the mtd-fixes tree
Message-ID: <20221125094634.665b079c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z1rHAK78n=lgjS..EJ06kCf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z1rHAK78n=lgjS..EJ06kCf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/onenand/Kconfig

between commit:

  c717b9b7d6de ("mtd: onenand: omap2: add dependency on GPMC")

from the mtd-fixes tree and commit:

  b46ff0780f17 ("mtd: onenand: omap2: Drop obsolete dependency on COMPILE_T=
EST")

from the nand tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mtd/nand/onenand/Kconfig
index c94bf483541e,5c240533cea4..000000000000
--- a/drivers/mtd/nand/onenand/Kconfig
+++ b/drivers/mtd/nand/onenand/Kconfig
@@@ -25,8 -25,7 +25,8 @@@ config MTD_ONENAND_GENERI
  config MTD_ONENAND_OMAP2
  	tristate "OneNAND on OMAP2/OMAP3 support"
  	depends on ARCH_OMAP2 || ARCH_OMAP3 || (COMPILE_TEST && ARM)
- 	depends on OF || COMPILE_TEST
+ 	depends on OF
 +	depends on OMAP_GPMC
  	help
  	  Support for a OneNAND flash device connected to an OMAP2/OMAP3 SoC
  	  via the GPMC memory controller.

--Sig_/z1rHAK78n=lgjS..EJ06kCf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN/9EoACgkQAVBC80lX
0GwTwgf8D2FXPFrLgdJAjh9a/6Ei2diysleqo4EJ6DELMQkV6CIR7ekaCh3VcG8K
zfvZGuQGi9Xi7+C93lJ+SdDqI8Be0ttrPl+7FGMuzF/Yxa1foCDPYQG3DxEDlT8n
GDL3M7oOCrNGIRnpvWrDtbflM9r0fffoYC4PXqcRW36GrC8FS1q7MWc89ebLgwJY
r55Qapm+z52YHQ6k3c58bp0bDEY0Fxa3JMHUDm/LHg/GxbuErJB+jU3O7WaPd2Et
v/kEBFKXJTWrKAH3wZMoRkTeCVTb0oPqJ22u/wA8HJGjHbevNxkU3OoqnLv6ybRU
H6Ee9jlRCDP8YroqJ5VrB0A2EIORvQ==
=FFOT
-----END PGP SIGNATURE-----

--Sig_/z1rHAK78n=lgjS..EJ06kCf--
