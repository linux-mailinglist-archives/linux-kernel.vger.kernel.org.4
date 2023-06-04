Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCAC721AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjFDW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFDW6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:58:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128AD2;
        Sun,  4 Jun 2023 15:58:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZBwp50Mlz4x41;
        Mon,  5 Jun 2023 08:58:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685919498;
        bh=jKxnCJcf3svMipaWEU6XH0Q7Wcmx+SJXjgiE2JwSupE=;
        h=Date:From:To:Cc:Subject:From;
        b=QTlmQ54TGyGkUneOoDnMbQSMErwFlHjbIM63dQ+VCBsdKt93WK6PfLTbk04EROqS3
         druqImf/Bo75ZqM39i+hz39Ai2EXTVPUia5/tShCx2c8XCro4dddfJubVctfaQCMmU
         z6LJdruWMEKjXm67pe+MvRSjdF7eheZ5Lg9sEpJovBQJrL9/x7Rx72jeZlMHyCTP6Z
         iIiJdFeZXm/n8hXfe2+Yus3IDusMofVH063CPqAPy8msFrRuRU2Z93h4Opv2CXUKd2
         Y8BX5Ad4SV60NsA1hlHVXWHAiMo8iJpgPiFt3zqpEgKH93QV6TdYNooQJJnX7Qs+5k
         qlYlhWrxxot8Q==
Date:   Mon, 5 Jun 2023 08:58:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the asahi-soc tree
Message-ID: <20230605085816.4f54bb43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MEfKpnWJCz/ikhWn.0qA1Ks";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MEfKpnWJCz/ikhWn.0qA1Ks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the asahi-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/io.h:13,
                 from drivers/soc/apple/mailbox.c:22:
drivers/soc/apple/mailbox.c: In function 'apple_mbox_send':
drivers/soc/apple/mailbox.c:151:24: error: implicit declaration of function=
 'FIELD_PREP' [-Werror=3Dimplicit-function-declaration]
  151 |         writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg.msg1),
      |                        ^~~~~~~~~~
arch/x86/include/asm/io.h:103:42: note: in definition of macro 'writeq_rela=
xed'
  103 | #define writeq_relaxed(v, a)    __writeq(v, a)
      |                                          ^
drivers/soc/apple/mailbox.c: In function 'apple_mbox_poll_locked':
drivers/soc/apple/mailbox.c:188:28: error: implicit declaration of function=
 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
  188 |                 msg.msg1 =3D FIELD_GET(
      |                            ^~~~~~~~~

Caused by commit

  0d1f3f7f8486 ("soc: apple: mailbox: Add ASC/M3 mailbox driver")

I have used the asshi-soc tree from next-20230602 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MEfKpnWJCz/ikhWn.0qA1Ks
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR9FwgACgkQAVBC80lX
0GzT7gf7BejVMP1/O2HFhoj1kF5QNrpKOwGzkhv0rNvJJudC5EwubRjdJbSjQmn2
gpm/M6HB9KDO4P/eeA4yt4LVFVgkC0V8xqEDdQVhPsRAm8dJh1FBzYHhb5RHEikP
bqIr0By7ZWYzkSk6xmMTwjzuobnhFvwU5o+sVcttx2cdYWkJ7Ap1BAYx8VK/iuGw
h0TuILt/sc8+XY11nSciLubQLwnski4Np/0trVMz2lSde+j/Sv13jlApgub5aKqh
sfEM9rWoN0nITrs7Aamhfhy/dyFCMfRIv+WUnzyTH3HVaNCFJsT6MdOCazuTnHfY
jbdVZmMWmgQeSp920JauLqZQtenJlg==
=d5QJ
-----END PGP SIGNATURE-----

--Sig_/MEfKpnWJCz/ikhWn.0qA1Ks--
