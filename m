Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7BD63CD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiK3CTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiK3CTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:19:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB355E3FB;
        Tue, 29 Nov 2022 18:19:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMNDb6pkpz4x1R;
        Wed, 30 Nov 2022 13:18:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669774736;
        bh=kD4blEFge91GWwdYs77NTKaflNYGmYoRLiHgReBp9Sk=;
        h=Date:From:To:Cc:Subject:From;
        b=QkP+v0bqsRghlRA0gw4sY4DrVsYQkZwjoWmqj5l2Ge6yvY+fVISK5CRSn4mM77XCZ
         +Ywguu/h9Js5vNPGwIPlnmmpF1pyOV4TNRxS3YG0Aa4OsvVfXwKAlDsWArZC2v5KOV
         OMX4XustRiIzWQF8M8nKqkuS/+l7kQXhuNTJcpC2brfen24yd29hUiL+SKHe3ZAhQG
         8aH0KVbP14KEVEgPuZNbFkvdqM/PeVAdAP7mOGF2O86TmAFC6pY0CIucX+lOQ+SE2g
         bVXiW/jVrNIvR59+9Mjyj01T9kFC8xk5lh/MqRyf2xImFP2ewIg5EvM258FGdAynzD
         l9GtiJW4aPY3w==
Date:   Wed, 30 Nov 2022 13:18:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20221130131854.35b58b16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9Y/Rr6rWsLMj+Xb=jl/s9KQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9Y/Rr6rWsLMj+Xb=jl/s9KQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/xen/unpopulated-alloc.c:17:21: error: 'list_count' redeclared as di=
fferent kind of symbol
   17 | static unsigned int list_count;
      |                     ^~~~~~~~~~
In file included from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:56,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from drivers/xen/unpopulated-alloc.c:3:
include/linux/list.h:662:22: note: previous definition of 'list_count' with=
 type 'size_t(struct list_head *)' {aka 'long unsigned int(struct list_head=
 *)'}
  662 | static inline size_t list_count(struct list_head *head)
      |                      ^~~~~~~~~~

Caused by commit

  a9efc04cfd05 ("i915: Move list_count() to list.h for broader use")

I have used the usb tree from next-20221129 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9Y/Rr6rWsLMj+Xb=jl/s9KQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOGvY4ACgkQAVBC80lX
0Gwiygf8CIyjvTa+bNq+X1+BjSH/3SujZe8la/FQwXred850016fx/WCYpiAu5wn
o7sV7TCPsV/4pvE/90vs9TAc9/eXFXXhrdmxC1aXAeMVWC9lTzquaxKlOWaTMEcj
zJTWW1s5J/AADYpZ6vQnX93uNWZTyiLO6wFbml4t6Hl+g7+lVEQOFchTn3RkG6DN
h6yomEUnkfV4tbzJsXAHugX5746ckvZKHQoEBdWQk0Uv+QHnW4rQkzSIkJUBrv1F
OqNPG1uit5syR5TbBM4U1rx/aJqOozXcLro9rmj74Dl7/GNNIYoHIm6F5ZBzrrk3
AHtJb/+q2qetzAXJJJ4enPlbKMBF/A==
=KG50
-----END PGP SIGNATURE-----

--Sig_/9Y/Rr6rWsLMj+Xb=jl/s9KQ--
