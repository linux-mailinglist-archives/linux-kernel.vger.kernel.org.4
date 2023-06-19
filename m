Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D321734991
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 02:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFSAyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 20:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSAyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 20:54:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C7199;
        Sun, 18 Jun 2023 17:54:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QkrrP47JKz4wgC;
        Mon, 19 Jun 2023 10:54:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687136070;
        bh=UGzDDf6+2/OAPf09/wxh38XnQsJqOh/a9BOPRdmOeVQ=;
        h=Date:From:To:Cc:Subject:From;
        b=JJ9IgFgrqRdWyPHeiLzWx9in/kR7/UtwtodhP+T+XwdBMjTlFPNe3u5n8qus8kPZo
         VRmcZFtdFScQPG9pUy9RnjD6qsIxCJyl5cfZ7uE0PnQJGBDHx1lrDaQ8v+JtvjIscY
         WqI+zlFfxE2zUAE64hQsVjyvpNMSE1YMY+h2Ub44voZTzCTQ6kUYVCVdgAZmz2aJCs
         Trvy5Hgokl4Yr6tQI/cyypXEo9yUVNg4rJM1OmxUDI3n3q+DTGck8jTntMAwMh33+s
         prfFbRJkTQiRyfYLtDMsIMuWOC8zWJWSeJwXAoMydel//Yb7XORos8/g92QMsgjZYz
         M7n6AQfdZ8bJg==
Date:   Mon, 19 Jun 2023 10:54:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Networking <netdev@vger.kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Magali Lemes <magali.lemes@canonical.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230619105427.4a0df9b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x7PcscfeSFP7Kyq/4C7U+Yp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x7PcscfeSFP7Kyq/4C7U+Yp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  tools/testing/selftests/net/fcnal-test.sh

between commit:

  d7a2fc1437f7 ("selftests: net: fcnal-test: check if FIPS mode is enabled")

from the net tree and commit:

  dd017c72dde6 ("selftests: fcnal: Test SO_DONTROUTE on TCP sockets.")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/net/fcnal-test.sh
index ee6880ac3e5e,05b5c4af7a08..000000000000
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@@ -1223,7 -1283,10 +1290,10 @@@ ipv4_tcp_novrf(
  	run_cmd nettest -d ${NSA_DEV} -r ${a}
  	log_test_addr ${a} $? 1 "No server, device client, local conn"
 =20
 -	ipv4_tcp_md5_novrf
 +	[ "$fips_enabled" =3D "1" ] || ipv4_tcp_md5_novrf
+=20
+ 	ipv4_tcp_dontroute 0
+ 	ipv4_tcp_dontroute 2
  }
 =20
  ipv4_tcp_vrf()

--Sig_/x7PcscfeSFP7Kyq/4C7U+Yp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSPp0MACgkQAVBC80lX
0GyQOgf/W1COtAPl8x0lAkHUCHBAmW7xCkco3BBYDCXDffXmwm3QfkOQSi5dLHI3
C4pH+RtRzAhy69QIuen5LQQ9LOGp47Ov8mPSjWx53hxwhu46PlB1s4EH+/rkDYa2
kPiIh8Xcmy+f1jpyOAEn22mpofz1t8SQrYGBxhtVdKXjejrULRFNgA+RhBFSQo11
e5LAgKL1yH5cKynK7B3DapJynQCQPd8oPmEaS2CFMzKLyRWhcRlAX70JcPhUksFz
IWFJygJuRAz4sDZcxRMOEoDaEJTBrEU8GTU++DHKFgYhX+xKbCTmobVYG795I/OT
Rk+BQscmdxQiSRvxIC4F9THtfMGWmw==
=Tf4J
-----END PGP SIGNATURE-----

--Sig_/x7PcscfeSFP7Kyq/4C7U+Yp--
