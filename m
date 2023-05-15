Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605817021D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjEOCue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEOCuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:50:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FCAE74;
        Sun, 14 May 2023 19:50:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QKP4J1gpVz4x1d;
        Mon, 15 May 2023 12:50:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684119025;
        bh=Jz3MRruVh3dU8KYalnJKGQ+MfSLuH1GZs3aqzlbyhH8=;
        h=Date:From:To:Cc:Subject:From;
        b=VFhhz0/MplnugKprTFl0M+sY83K9KoOEcl94S0A+kKBG+a3jdZqONiCwECbkqLkPA
         Kt3scp3KkwnCFn3v7BCJeSWoJCkLSo07k/NjciMRBfEAll87HoeBbOYxyvjmvH+p2v
         RISdpxlX5obiQXslcOIom89mPkeBKRr5KojGgBb6N9el2ue2gLk3dC3hx+QxJeJvqF
         wJ9a8qLpWuOFNE7NidpQlB4CW5wINamiT+jr8R6Ue9DnJfohXvfOmbh4Q2gnjl08kY
         cg/wZK8BxNq3hCkMs/JmULxQ6sN6K/3jULEXcupy7eKnK1qWw/gjrzS4tfAxrLvx+s
         t2Z3d3Cii5WiA==
Date:   Mon, 15 May 2023 12:50:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20230515125023.639f3ca3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NmrO53x+Us/b4UG.ATib=YK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NmrO53x+Us/b4UG.ATib=YK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/gadget/udc/core.c

between commit:

  f22e9b67f19c ("Revert "usb: gadget: udc: core: Invoke usb_gadget_connect =
only when started"")

from the usb.current tree and commit:

  d34f9bafa78d ("usb: gadget: udc: Handle gadget_connect failure during bin=
d operation")

from the usb tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/gadget/udc/core.c
index 52e6d2e84e35,69041cca5d24..000000000000
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@@ -1078,12 -1121,17 +1078,16 @@@ EXPORT_SYMBOL_GPL(usb_gadget_set_state)
 =20
  /* ----------------------------------------------------------------------=
--- */
 =20
- static void usb_udc_connect_control(struct usb_udc *udc)
 -/* Acquire connect_lock before calling this function. */
 -static int usb_udc_connect_control_locked(struct usb_udc *udc) __must_hol=
d(&udc->connect_lock)
++static int usb_udc_connect_control(struct usb_udc *udc)
  {
+ 	int ret;
+=20
 -	if (udc->vbus && udc->started)
 -		ret =3D usb_gadget_connect_locked(udc->gadget);
 +	if (udc->vbus)
- 		usb_gadget_connect(udc->gadget);
++		ret =3D usb_gadget_connect(udc->gadget);
  	else
- 		usb_gadget_disconnect(udc->gadget);
 -		ret =3D usb_gadget_disconnect_locked(udc->gadget);
++		ret =3D usb_gadget_disconnect(udc->gadget);
+=20
+ 	return ret;
  }
 =20
  /**
@@@ -1523,15 -1580,28 +1527,23 @@@ static int gadget_bind_driver(struct de
  	if (ret)
  		goto err_bind;
 =20
 -	mutex_lock(&udc->connect_lock);
 -	ret =3D usb_gadget_udc_start_locked(udc);
 -	if (ret) {
 -		mutex_unlock(&udc->connect_lock);
 +	ret =3D usb_gadget_udc_start(udc);
 +	if (ret)
  		goto err_start;
 -	}
  	usb_gadget_enable_async_callbacks(udc);
- 	usb_udc_connect_control(udc);
 -	ret =3D usb_udc_connect_control_locked(udc);
++	ret =3D usb_udc_connect_control(udc);
+ 	if (ret)
+ 		goto err_connect_control;
 =20
 -	mutex_unlock(&udc->connect_lock);
 -
  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
  	return 0;
 =20
+  err_connect_control:
+ 	usb_gadget_disable_async_callbacks(udc);
+ 	if (gadget->irq)
+ 		synchronize_irq(gadget->irq);
 -	usb_gadget_udc_stop_locked(udc);
++	usb_gadget_udc_stop(udc);
+=20
   err_start:
  	driver->unbind(udc->gadget);
 =20

--Sig_/NmrO53x+Us/b4UG.ATib=YK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRhne8ACgkQAVBC80lX
0GwsRAf/dgKysVLWm6VlBzJoMt53MdsTCm99u4j1AyoLylnOGJgo5EZ2cGmeK4Pv
VlcUXIIkMOZBezsF4H561deiA+wJzsXRr/XOFOWv6l0UYMBjWfftvD5qugkI2mQ4
WDpdCEZ0y6k3Xgx+iO703rktRo8bPm1aPMFXmG/6yGceUcEPtPSXCRg76J90nMZb
Q59gv4nDIjAZwFhAmOBWZ+sAos1r3SNK3kL2Pdtxfh9d3vFopglxv8DjxW7PN6UZ
ZFcZvU8tuVgFlsWQW0P0l1GXyUhdAMInsYhwr52kpT5rhT/jLT3pintuEAk5tUZ8
XQPJbvyl2lWpBKTzxNptPcpvrWH9fw==
=dBXS
-----END PGP SIGNATURE-----

--Sig_/NmrO53x+Us/b4UG.ATib=YK--
