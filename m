Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A173D58C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 03:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFZB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 21:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFZB25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 21:28:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F03C6;
        Sun, 25 Jun 2023 18:28:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qq9Gp0wbgz4wb1;
        Mon, 26 Jun 2023 11:28:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687742930;
        bh=tHVai39HxgjGHNP/zksmmKbc9HmL2vXQATBH3nrtmIk=;
        h=Date:From:To:Cc:Subject:From;
        b=qRz3LYRs0stJLsICMI4jvbq0Lx+qk4n4L9VDO3L2lMdcrnyQ4oW4EikpbkZxS65xu
         rq+/IqZgIZTEfYOarRrpPsu9X1B8kTiNoeHQ+7vvipXJUACt0JzyCAbArG+x6CZz3h
         hfq6SsNXR4Pa8MnvbK5xT47bZ0e/v3OpmT2ltFEv0VFiVADClHsePJZImdCXH25JzN
         5YzsB5gPBPiEELo9UQt0JX2PpnG4wSMsqyqMnADd5y6lp6oweFdmeAu6lFS3+V7pTb
         eaf4gM+cil75xkojJI5St7jwNCa39iNsUBaVon0oBEf6EMl6GXQhIeLfVpJSHu4DOp
         1l6y60kjCu6gQ==
Date:   Mon, 26 Jun 2023 11:28:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20230626112847.2ef3d422@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xdtucNmpqhA0UpIbgQavQMZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xdtucNmpqhA0UpIbgQavQMZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (native perf)
failed like this:

In file included from builtin-trace.c:907:
trace/beauty/msg_flags.c: In function 'syscall_arg__scnprintf_msg_flags':
trace/beauty/msg_flags.c:28:21: error: 'MSG_SPLICE_PAGES' undeclared (first=
 use in this function)
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~
trace/beauty/msg_flags.c:28:21: note: each undeclared identifier is reporte=
d only once for each function it appears in
   28 |         if (flags & MSG_##n) { \
      |                     ^~~~
trace/beauty/msg_flags.c:50:9: note: in expansion of macro 'P_MSG_FLAG'
   50 |         P_MSG_FLAG(SPLICE_PAGES);
      |         ^~~~~~~~~~

Caused by commit

  b848b26c6672 ("net: Kill MSG_SENDPAGE_NOTLAST")

There is no MSG_SPLICE_PAGES in tools/perf/trace/beauty/include/linux/socke=
t.h

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xdtucNmpqhA0UpIbgQavQMZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSY6c8ACgkQAVBC80lX
0Gzy9gf7BbnAhJ+PyhJzcE3tD3D2p8tk+Ycg5XNOGQOQNfsOALTWKBnd4mkJaToX
eAg+moYZMw8mVHA56NuKPSiJT7+X2h3B5LTCt8Gf38nRVczvb57MWZKF4mBg2jZa
EGwTpazMY1j5H/0uYHkmLenJO1xVRYAkLoYcHgbQcm7fsoQ5L33pC+H0gY9NNHEY
fsb781ytiSdnS1HlZWc+JK2zO16DFLYtUKHXpW2AyIyzicpxrqHwleEwU/ezOplm
u8hSBPA6Omsy3qSOpMtiG6Sgr3em1sx1X7thXP/RTqg/fc4k7PsbqgqYwMzvy+Qr
KQvFsiTTPTyKqsZ7TgOTgQGrEuPMUg==
=eZf6
-----END PGP SIGNATURE-----

--Sig_/xdtucNmpqhA0UpIbgQavQMZ--
