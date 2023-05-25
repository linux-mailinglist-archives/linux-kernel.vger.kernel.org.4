Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CE5710225
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEYBAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjEYBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:00:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54878F5;
        Wed, 24 May 2023 18:00:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QRV930clCz4x1R;
        Thu, 25 May 2023 11:00:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684976439;
        bh=OufjmZqKC0zG8gRNOtyYpkGGKrvvZktgoTrkVOag6VM=;
        h=Date:From:To:Cc:Subject:From;
        b=PWt28mWYxRb9OS6XkJcRjYVGJO1XwEwoGlPlKn2XryvJ7CBI1OgwrErE1P0pVHE+e
         kW610NVrSzb10A9ukGujrltba4wR+j8vAeY7YT6fiwUlOxW2EQwmKeC2I9QsueEDJ7
         NAzwz1kHJbDQWlxRwUoSIfJG+RbPXqLkeFA1Mxb1MBFY4u1LTwPRqxzmpftHxhqH67
         cACNSjONthVhnaiFD7S+hCW+4bbUcQE9Qv0mE1OvxTa3qk21/ot2Ly6s+s/UrVyVC2
         iKSbJMXdP2xwuE3DYZuwdDEA2a/5+o7I+b25go/lf9aYjk7wM63uHmecXkqsNR4Xsq
         Y0N+APTGF2tvA==
Date:   Thu, 25 May 2023 11:00:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>
Cc:     Networking <netdev@vger.kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230525110037.2b532b83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LUriyGLJLujz/Ky=UBnqrxw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LUriyGLJLujz/Ky=UBnqrxw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/ipv4/raw.c

between commit:

  3632679d9e4f ("ipv{4,6}/raw: fix output xfrm lookup wrt protocol")

from the net tree and commit:

  c85be08fc4fa ("raw: Stop using RTO_ONLINK.")

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

diff --cc net/ipv4/raw.c
index eadf1c9ef7e4,8b7b5c842bdd..000000000000
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@@ -600,9 -596,8 +599,8 @@@ static int raw_sendmsg(struct sock *sk
  		}
  	}
 =20
- 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos,
- 			   RT_SCOPE_UNIVERSE,
+ 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
 -			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
 +			   hdrincl ? ipc.protocol : sk->sk_protocol,
  			   inet_sk_flowi_flags(sk) |
  			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
  			   daddr, saddr, 0, 0, sk->sk_uid);

--Sig_/LUriyGLJLujz/Ky=UBnqrxw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRuszUACgkQAVBC80lX
0GyRAggAjksIqLWt9YT5QOD0ZFfXREBrzs9YAYA1+FfDIWIjZuMNmwm98JmbOlTt
jA3rFukI3PkjyLzUzwmzDn00JTjlsgjb8xf8n5aSQKeZLDmSr6YlEMbfV/lz/ico
Sq7vDiRpnp7wD0SQFt4d27hh4GidhZQFmisKepto7aqX3/9FU3FJnT5sDH1n3nU8
YsyYCobE7+9Sg8bJv/gEiLK+Ft+m5WoUcZk8EJr8nBelG0bJQuUqIzRP9sBxicXm
xnG6WjtqjdKIye14ByzHe8M+YlkGAXIDkJ/m1qBy8m+KHYUsHAMBD1HPNWCUZ+8I
pnZ1ohKGEm4nTrWn9o1lTD+PMiOhlA==
=FKsU
-----END PGP SIGNATURE-----

--Sig_/LUriyGLJLujz/Ky=UBnqrxw--
