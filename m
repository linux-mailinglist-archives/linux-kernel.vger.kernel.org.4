Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F05673055
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjASE3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjASEO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:14:57 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3856D698;
        Wed, 18 Jan 2023 20:06:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny7sK0s8Mz4xFv;
        Thu, 19 Jan 2023 14:48:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674100133;
        bh=qvUnDvl24TJjYuCmg922ifqYfr5NA/yxRHn4nk5sc9o=;
        h=Date:From:To:Cc:Subject:From;
        b=lTDzgalY4gHnysDQJQ+cc3727zIzmRYk0E6/vOTSDhMCKD65FHD2umOVD7jeOY16f
         bo1zhCzqLVxy7svqf/HTFEqz9Q8b6E/N/NjZJLb4SJRYMwoh0MxUxSco/W+VA/0mum
         yiBbOceEewphV51qcIb6MVCy7Fkrs4+vuwE//8iSdpLQrbVVay54lHnyLe2pcnSz2B
         BHPKsgoAOzwvgBR5i6vo1uG5BOkoxsc4YFl+JxMFjPoCninjUs169NUjooa6WqF7Fw
         z5/bLBztsZPxDI/OdFsj0Gg1bFuPAHxr/56iW+ZYie0vtUqZlyLnoRnoSjQrLucqnm
         7gVHhncohE/wg==
Date:   Thu, 19 Jan 2023 14:48:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jim Lin <jilin@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20230119144851.50ffab73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DOfp7NbnYQuE5TJz63=R5ax";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DOfp7NbnYQuE5TJz63=R5ax
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the usb tree got conflicts in:

  drivers/usb/host/xhci.c
  drivers/usb/host/xhci.h

between commit:

  23a3b8d5a236 ("xhci: Add update_hub_device override for PCI xHCI hosts")

from the usb.current tree and commit:

  592338dde854 ("xhci: Add hub_control to xhci_driver_overrides")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/host/xhci.c
index 2b280beb0011,748c7158198f..000000000000
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@@ -5516,8 -5502,8 +5516,10 @@@ void xhci_init_driver(struct hc_driver=20
  			drv->check_bandwidth =3D over->check_bandwidth;
  		if (over->reset_bandwidth)
  			drv->reset_bandwidth =3D over->reset_bandwidth;
 +		if (over->update_hub_device)
 +			drv->update_hub_device =3D over->update_hub_device;
+ 		if (over->hub_control)
+ 			drv->hub_control =3D over->hub_control;
  	}
  }
  EXPORT_SYMBOL_GPL(xhci_init_driver);
diff --cc drivers/usb/host/xhci.h
index dcee7f3207ad,f71841812f06..000000000000
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@@ -1944,8 -1943,8 +1944,10 @@@ struct xhci_driver_overrides=20
  			     struct usb_host_endpoint *ep);
  	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
  	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
 +	int (*update_hub_device)(struct usb_hcd *hcd, struct usb_device *hdev,
 +			    struct usb_tt *tt, gfp_t mem_flags);
+ 	int (*hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+ 			   u16 wIndex, char *buf, u16 wLength);
  };
 =20
  #define	XHCI_CFC_DELAY		10

--Sig_/DOfp7NbnYQuE5TJz63=R5ax
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIvaMACgkQAVBC80lX
0Gxwpwf+KJSyaakX3TNKNz49nKvExGmYRdEiKd3uVo28H4Q5bbkB5rR7RnwRzQ5X
TLrx/QY/PeDhW/TQSfr2hUdGh1OtFUTj4NAXOFMKywQ9LawVBjzqRkhtWy4GzLfz
GrdUiWec1qU6nhCzjh5AvA7wi3UquGRT7NcyXfBrLXlWSsPsUGBNWBl8o+fjIn9t
N3kiedQVkrKBquJg/pzQEPRP8j+6S2bV+bYXI3c9EvizBFTOloe8sDE9D2MsuC9F
jG6oXFF5XGuJi4Q3+qiUCFrSkPr8Pj44b/Li9lsP0P7RzqaR4nxaR5qlVRLgNnnV
ipFnZ5227NhhEy9M8YU/p/MFLhmEgQ==
=cc5S
-----END PGP SIGNATURE-----

--Sig_/DOfp7NbnYQuE5TJz63=R5ax--
