Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B662B095
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiKPBgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKPBgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:36:07 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDC165B4;
        Tue, 15 Nov 2022 17:36:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBlxV6fc2z4xDK;
        Wed, 16 Nov 2022 12:35:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668562559;
        bh=m1XHF8llPa7pw5nIxGLJkMt7l8j+r6J1+/3Hk0NmZEg=;
        h=Date:From:To:Cc:Subject:From;
        b=GLA2XPdtkpVerQX20bUt+beKDGkPgAD1qaHrEbmhb6osTA8nWoSlwECsbYpin/UFT
         NMNZRYMgI+te4Z7xqC4sEJ2300wmq/icabpEvqLyFPhLxTDlpG1T+Ummk2hki6rktR
         Zv+kLx6CFC/qD2Sgnr5Y2y7j4VOqZsB5i8XwPVzTJiH/7+HBR6bQk9KFjANew9AnmJ
         /UBmWhCbbM/j2wi6Fvgg2m/Mgy3ufQ78dVGpuLe7mp3y+yn1oPSUkYCq1MTB0HoiqW
         T7L+8twZqRM9DUhtGUa/p73B6ZuWda2gsvZsWo2gT2SFU0bdh5dawo4Ydv+i7Kie3z
         Ov/v9vqaRWHnQ==
Date:   Wed, 16 Nov 2022 12:35:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Stefan Metzmacher <metze@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20221116123556.79a7bbd8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xr/iw1wiKQizx0y_MS3Ex7r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xr/iw1wiKQizx0y_MS3Ex7r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:
./usr/include/linux/io_uring.h:672:41: error: field 'timeout' has incomplet=
e type
  672 |         struct __kernel_timespec        timeout;
      |                                         ^~~~~~~
make[4]: *** [/home/sfr/next/next/usr/include/Makefile:91: usr/include/linu=
x/io_uring.hdrtest] Error 1

Caused by commit

  958bfdd734b6 ("io_uring: uapi: Don't force linux/time_types.h for userspa=
ce")

I have used the block tree from next-20221115 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Xr/iw1wiKQizx0y_MS3Ex7r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0PnwACgkQAVBC80lX
0Gw4RwgAnho18sbwThzt6T+G1zpj3qsZhMiLmHPBihJ7oL6QaNq5p2gshrTv5/jJ
tTUG9Tj9L5MqPYPjnejrvH+yypJysFMmfVQx7i1ph3iWMDMS/poUWg+YwulUy2To
+bEK6nHurMyvAJqiYinWIJ4b+K7E4squ7MAPJPIFMGM/OSdYbpjrkCkXJOJhifzM
UZBOiVisQHawgrSr0iBXaZ5sY2a/r3FuuCnUhm8kYtNdfp753GfevGx71Jxk11zj
0DITK3/JtziaJ/FbQ+1sTAaq4iJBs3ERVvsbZxxbJkwDvdWeVqcSuToBS/M7+Oxw
8FFlQnBJ/Ki4abC9I4AtdfShVa5VuQ==
=p/BZ
-----END PGP SIGNATURE-----

--Sig_/Xr/iw1wiKQizx0y_MS3Ex7r--
