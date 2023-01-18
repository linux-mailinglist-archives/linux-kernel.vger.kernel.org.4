Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A6670F88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjARBHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjARBGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:06:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865447EE2;
        Tue, 17 Jan 2023 16:56:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NxS4p1l4wz4xGq;
        Wed, 18 Jan 2023 11:56:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674003386;
        bh=78jfzVYrHK6KQH6CIQ3jrXYTdmiewoTa7X40atp7jLU=;
        h=Date:From:To:Cc:Subject:From;
        b=XTRiWSAsLQ4ilAeB4ScPw/GFXqGsOfLGc2q8fLoAxcq8TYZdDftz5WHV31jTxgV2o
         QGzY9V3pKLRHmIBB2MwLrW79Pz2p/UwMC4dij9wXEQ/xACLljOwghFq/a5SfJJ4N3g
         c8d8B1O0rBqEZXBG2tuKtvS2K3zcS+ESBgRMa8yffVexTElG9ZcLIEEMpy+CuNsiLy
         d6LXh36IMLCRWXoDzx45RSsDp5K0lioYgx46IJkvhTzHm+DuDAdxuBV4s2YyD7R7Fj
         6ipNhSXwGAZAK7Y8Je7InBkS/OxRQfeNbHjj1vjpP/XtMmnidcFYWpY7Q6jlHxgi7Q
         +GUrXSJZXfdng==
Date:   Wed, 18 Jan 2023 11:56:24 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jack Pham <quic_jackp@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        Rajaram Regupathy <rajaram.regupathy@intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20230118115624.72e7e756@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f/ewCbOgthe=eB4lTyvnDej";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f/ewCbOgthe=eB4lTyvnDej
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/typec/ucsi/ucsi.c

between commit:

  fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed=
")

from the usb.current tree and commit:

  b04e1747fbcc ("usb: typec: ucsi: Register USB Power Delivery Capabilities=
")

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

diff --cc drivers/usb/typec/ucsi/ucsi.c
index 1292241d581a,d04809476f71..000000000000
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@@ -1426,20 -1551,14 +1557,26 @@@ void ucsi_unregister(struct ucsi *ucsi
  		ucsi_unregister_altmodes(&ucsi->connector[i],
  					 UCSI_RECIPIENT_CON);
  		ucsi_unregister_port_psy(&ucsi->connector[i]);
 -		if (ucsi->connector[i].wq)
 +
 +		if (ucsi->connector[i].wq) {
 +			struct ucsi_work *uwork;
 +
 +			mutex_lock(&ucsi->connector[i].lock);
 +			/*
 +			 * queue delayed items immediately so they can execute
 +			 * and free themselves before the wq is destroyed
 +			 */
 +			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
 +				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
 +			mutex_unlock(&ucsi->connector[i].lock);
  			destroy_workqueue(ucsi->connector[i].wq);
 +		}
+ 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink=
_caps);
+ 		ucsi->connector[i].port_sink_caps =3D NULL;
+ 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sour=
ce_caps);
+ 		ucsi->connector[i].port_source_caps =3D NULL;
+ 		usb_power_delivery_unregister(ucsi->connector[i].pd);
+ 		ucsi->connector[i].pd =3D NULL;
  		typec_unregister_port(ucsi->connector[i].port);
  	}
 =20

--Sig_/f/ewCbOgthe=eB4lTyvnDej
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPHQ7gACgkQAVBC80lX
0GxStgf/S1iFYBTn/qxu7p1XSoz0mqNgDxvzusaSA7/vKMhjAKHK0Z/Z14ThBz86
PrO9CAxI4jbC6fJg2Q5gIUJUv6viIY/W/vusU04JsdZ+mwEMxQKPQmrOZBXaHqTd
gkFdDL2edfnb1dcWMaVNhR6IXsyT25HBr0sFq3UgJ3WP9EzLf4XNf9tf0Lf8t1hW
CkU93Qhpmlnno+1Gpzv6kKrPUivT8s1qdiolZYmhM1Ts4qo0FiUT4pqySuon1NDB
3WN5mZu5fyKKusGWKvJ5ujp7QCIYqQmNz9pQkC4WEVbtlcMlMfJZsR93APmmsRdE
fetn401IDnHNRGsttH5YWv1eiSY0Bw==
=RYIX
-----END PGP SIGNATURE-----

--Sig_/f/ewCbOgthe=eB4lTyvnDej--
