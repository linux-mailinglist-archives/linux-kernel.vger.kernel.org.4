Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C865F3CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJDGbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJDGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:31:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65A46D9E;
        Mon,  3 Oct 2022 23:31:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhSXH2Wjgz4xDn;
        Tue,  4 Oct 2022 17:31:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664865088;
        bh=LEOwJCID3wROPDUirmmrqUq88YWylSgQ4y2P5w+1FDw=;
        h=Date:From:To:Cc:Subject:From;
        b=WhSOWwKyLpspPl8OaK/NtxqWQ20dn1Kv50sZU2tqR+NyDYBUpbvAh0uKsPgmovNxr
         KApzfRlXQhiQBzVf7s16r+45x4BJqoF2dTyotfkTTftNo1DR6BMvAIGcNM2kZlXoc/
         ctnXwbgfT2MTdehodbuyodGG+iY4YAlSRbaopJTigOrC5Q1nvPUM7hZrT1rO3UJXh8
         s2mfB6iknLGm0N53SRFcRX6Y8ULcJsj2J6BxDQ8KSohUkEXnBqp9pf1foCa986Ju2r
         7yw7CtNIAJwQdTigx5bOZ60ZdqB/D2Fs3XgqYShpRKUMEwruPbPHOF2zitY6NT3G8P
         yZbE9qRkY2xLw==
Date:   Tue, 4 Oct 2022 17:31:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: linux-next: manual merge of the staging tree with the clk tree
Message-ID: <20221004173125.4ba8d782@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U=2HD_s8uAISKDVjapMgyPy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U=2HD_s8uAISKDVjapMgyPy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the staging tree got conflicts in:

  drivers/staging/Kconfig
  drivers/staging/Makefile

between commit:

  c822490f52da ("clk: clocking-wizard: Move clocking-wizard out")

from the clk tree and commit:

  db65becab2a3 ("staging: fwserial: delete the driver.")

from the staging tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/staging/Kconfig
index 211436b40c0a,64a531accd72..000000000000
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@@ -60,8 -60,8 +60,6 @@@ source "drivers/staging/board/Kconfig
 =20
  source "drivers/staging/gdm724x/Kconfig"
 =20
- source "drivers/staging/fwserial/Kconfig"
 -source "drivers/staging/clocking-wizard/Kconfig"
--
  source "drivers/staging/fbtft/Kconfig"
 =20
  source "drivers/staging/most/Kconfig"
diff --cc drivers/staging/Makefile
index f1be26a5f222,6af299b9045b..000000000000
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@@ -20,7 -20,7 +20,6 @@@ obj-$(CONFIG_USB_EMXX)		+=3D emxx_udc
  obj-$(CONFIG_MFD_NVEC)		+=3D nvec/
  obj-$(CONFIG_STAGING_BOARD)	+=3D board/
  obj-$(CONFIG_LTE_GDM724X)	+=3D gdm724x/
- obj-$(CONFIG_FIREWIRE_SERIAL)	+=3D fwserial/
 -obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+=3D clocking-wizard/
  obj-$(CONFIG_FB_TFT)		+=3D fbtft/
  obj-$(CONFIG_MOST)		+=3D most/
  obj-$(CONFIG_KS7010)		+=3D ks7010/

--Sig_/U=2HD_s8uAISKDVjapMgyPy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM70z0ACgkQAVBC80lX
0GwjzQf/WUjjHJ/rs+ciVxHdHAEuvmcbUwU0t/NnOsZ8shhxG7svOsZ1kzBDEK5m
WpDqNRqSesp1fbGQ7z70XR6A7wBjbVowzHpQ6gbgtnqjxYCUKEnSuYpH1ge6i8qe
jlqD14482p9kXJ8NnUxmrBvBEywfen0P02bNOl8uBKsDZpsT//t8XDCGzVBK+gye
LHAIIMc2IfXuYV6Q9u0bwli+BPuvedvKA237U/XD76OTxSXjpYaxupLf0TCsrOB9
mA5V3T0MhXeaHJNAVqdtCQz4AVM2TjIlv2S/dH/aYOHaOkGkRx1yzgpixofTNN+K
FFEzLoWljPO5iaemPy5vtGQy95rM3w==
=U85t
-----END PGP SIGNATURE-----

--Sig_/U=2HD_s8uAISKDVjapMgyPy--
