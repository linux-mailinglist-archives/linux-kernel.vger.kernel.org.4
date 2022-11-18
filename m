Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8125762EAB7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiKRBHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiKRBHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:07:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED1124BFE;
        Thu, 17 Nov 2022 17:07:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NCzCh1Yq9z4xDK;
        Fri, 18 Nov 2022 12:07:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668733648;
        bh=F+iqyvnB5hnWasFe3ejyqxa7HEUiyJEk0LNreLORbGU=;
        h=Date:From:To:Cc:Subject:From;
        b=pAOEd6fRkcwGiT+ijmZSrc7yjezz/uTLN5gbpksIJ+4HMC7vASzNzNrUrUI/dKPMq
         uAHdQ1Jni+yLRVHPiOkeDewpHH+GGrpnxxzaeGORN1NbrvmeeCAWDj07e+4TLy8QeV
         yJTUfO3v+YRI+DPeS+6XT1FCfQM0Km5X/67Ij0SffSUupPZbrkhp5xit080BKMiQKC
         VmjBGs/n6Br2e4XNwyIFaf7KwMQ9JCMgi8dkl8A7hzvHIS1444Q6gzpY23LO2GZ2Q7
         i8kzQOJ8tWPyZy6P2Ho7ZA+UiJaKpUw1VQGKkCM7lZZsqgi4VSf+vi++YS7igSQ3xK
         S3YbeMU5fOp0Q==
Date:   Fri, 18 Nov 2022 12:07:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: linux-next: manual merge of the spi-nor tree with the mtd tree
Message-ID: <20221118120726.6c410939@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zcYv2rxHj9_yyRaU7+.hfcu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zcYv2rxHj9_yyRaU7+.hfcu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the spi-nor tree got a conflict in:

  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

between commit:

  e9a399caf031 ("dt-bindings: mtd: spi-nor: Drop common properties")

from the mtd tree and commit:

  7f2937efe186 ("dt-bindings: mtd: spi-nor: Add reset-gpios property")

from the spi-nor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 6cc491083650,8a843b9b8673..000000000000
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@@ -70,6 -70,26 +70,12 @@@ properties
        be used on such systems, to denote the absence of a reliable reset
        mechanism.
 =20
+   reset-gpios:
+     description:
+       A GPIO line connected to the RESET (active low) signal of the devic=
e.
+       If "broken-flash-reset" is present then having this property does n=
ot
+       make any difference.
+=20
 -  partitions:
 -    type: object
 -
 -  '#address-cells': true
 -  '#size-cells': true
 -
 -patternProperties:
 -  # Note: use 'partitions' node for new users
 -  '^partition@':
 -    type: object
 -
 -  "^otp(-[0-9]+)?$":
 -    type: object
 -
  unevaluatedProperties: false
 =20
  examples:

--Sig_/zcYv2rxHj9_yyRaU7+.hfcu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN22s4ACgkQAVBC80lX
0GwVJgf9E4AEVdBQ9hqjd+u9n8GcwtyCvjgtcHKFaJXZVd7TwPjsHU6qGqPDnSK/
ZCwMe33DY0Xwt4XAah6+H4YauuxLzMz5PrRDcravKyog6bE279dkaM8WDDZLmBzV
HtoyJzkUPn4IhXGgQd+EQWYH4zaaCvc29KQ/aQBya3Ua2B6aO2N3VBqTe6ZiRX2+
yVr+Kk1FwzQ/ekjADfZaBm5oHsDgctfBbG9d2+ohsVkf4nEy+u0ioYsxRP2Ldjoi
TSFxo6uyuRA1j/mDWFJTTi+2oF9dMBGhsWCPqmJYL73CtT98EuAbU4yu+XABmKQr
Ftj2m6P2RN6MwI/GkFA6BM4LOmpSYw==
=xQYI
-----END PGP SIGNATURE-----

--Sig_/zcYv2rxHj9_yyRaU7+.hfcu--
