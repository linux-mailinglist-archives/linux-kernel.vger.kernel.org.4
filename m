Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC60A6381E8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 01:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiKYAZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 19:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYAZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 19:25:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24401827E1;
        Thu, 24 Nov 2022 16:25:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NJFyH2lrNz4xN7;
        Fri, 25 Nov 2022 11:25:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669335944;
        bh=vHhDHdhQ7cy7gKTzyyO1n/uhTQymw8N+AlJaDSAhm5E=;
        h=Date:From:To:Cc:Subject:From;
        b=gkLHTHL/y+UXYwxPnxRlm7TeDdYy80Klq8S+aq5Z4AouPdP4TC7qXWFaxHzZw8k/F
         kpOWRTTYeKbkG1YX4WMZCeHTz0yaJXu7NGW/5unfzEFSRy6gyvT5ciZlFW0U3hRlKM
         7d1zQWkI2ZXV9U2v6UqAPFFx/Yf+M04qB2ddPJs4AZ2/EGEa+CYxJMm0huXBqkuGJs
         jKHalYGRxyF3PqwAGVMQ47pdHAjvUTz3dDXirPLdnXObjj/gyyT2RGmHy7aR0gptag
         pmliEAJiqi/T/Cvhw78EIycQODGKm4WwdwU+LL83kzbRAqOcNO1mTmYPDv2bVaaUfF
         /thV6r/5IX72w==
Date:   Fri, 25 Nov 2022 11:25:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>
Subject: linux-next: manual merge of the char-misc tree with the broadcom
 tree
Message-ID: <20221125112542.466ebc42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xr_1ppfyl/dfmvx4mdFtLbM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xr_1ppfyl/dfmvx4mdFtLbM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/firmware/raspberrypi.c

between commit:

  117bd98daca0 ("firmware: raspberrypi: Use dev_err_probe() to simplify cod=
e")

from the broadcom tree and commit:

  7b51161696e8 ("firmware: raspberrypi: fix possible memory leak in rpi_fir=
mware_probe()")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/firmware/raspberrypi.c
index ec07bf26e5eb,dba315f675bc..000000000000
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@@ -288,9 -268,13 +288,11 @@@ static int rpi_firmware_probe(struct pl
  	fw->cl.tx_block =3D true;
 =20
  	fw->chan =3D mbox_request_channel(&fw->cl, 0);
- 	if (IS_ERR(fw->chan))
- 		return dev_err_probe(dev, PTR_ERR(fw->chan),
- 				     "Failed to get mbox channel\n");
+ 	if (IS_ERR(fw->chan)) {
+ 		int ret =3D PTR_ERR(fw->chan);
 -		if (ret !=3D -EPROBE_DEFER)
 -			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
+ 		kfree(fw);
 -		return ret;
++		return dev_err_probe(dev, ret, "Failed to get mbox channel\n");
+ 	}
 =20
  	init_completion(&fw->c);
  	kref_init(&fw->consumers);

--Sig_/xr_1ppfyl/dfmvx4mdFtLbM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOAC4YACgkQAVBC80lX
0GxjFQf/aLHUbFePwhLqPE3Mv3ruJuMUYVgdD4CF1kmbIaepxlt6vtFqRhG+yFC1
lp2cMnnwBJO8j2bsF06u7Csstr3+Gr4Q1yq0MFBkXzv7j4KddroX+o1+eoWkJsHD
V1EDOXYEjaRV2eJBSXs3JABUQjdzw89h4mf4qMBtj50YbUjSQ3IpKSUArcuVZbAJ
6XLq0gfiAeb6q0zjiyYp9oIE9UI43+fXyiRIfxTkX+OCN7RmIW/gNbiCpev9zf3v
uF+6ZspocPYNREjphgcFXAu2QMWPZnaJVjNyR3q6j5tL9w2FQZ9Qr7LUy+E1Y8Ji
owCiJjgYTJ9JQfQ9znNVyjqwO7PyYA==
=dpQS
-----END PGP SIGNATURE-----

--Sig_/xr_1ppfyl/dfmvx4mdFtLbM--
