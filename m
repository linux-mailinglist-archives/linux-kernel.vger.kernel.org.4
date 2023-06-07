Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF78A7252B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 06:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjFGEO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 00:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjFGENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 00:13:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A8210C;
        Tue,  6 Jun 2023 21:12:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbYmP54q0z4x41;
        Wed,  7 Jun 2023 14:10:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686111046;
        bh=L0EaDKlygTD6/hJSe6VBHSN9xPCJwLW3u+1oYmJzgyQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tuxorlyrzFkrH1xktaU1X/Q0X5NeASSJ0hSTgId56X0mA4LBXR0tJW7RR6XL3yrWJ
         e0IxnvCnyqv2B5eRvJJLHA7RmUa/MvGKX6EAR7x53IvI10tukx0SpfM+Pb7HGDMRBD
         vAZGpKfGLTDoGE1h5QSZWgfTK94UwtJ2fRpXIxFj0nOI6JDNTNAJouhYTJ80W4L7XU
         vYSUwaxcwfU9HJ4pJrSYlv3e6tlJnWxOxXcALcppUl/gs/KRjZyr11zP+XI5qgJV6K
         3wT2WOCMPC3JDP+YaQW8orKdger/JXGt3glTbP77hTToDLEmJW8N76JX4M7VU+MrNN
         nhQUQyMl773PQ==
Date:   Wed, 7 Jun 2023 14:10:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: runtime warning after merge of the landlock tree
Message-ID: <20230607141044.1df56246@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i=8nT44GQRpQ8sBi_oj3vig";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i=8nT44GQRpQ8sBi_oj3vig
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next qemu boot test (powerpc pseries_le_defconfig) produced
this warning:

WARNING: CPU: 0 PID: 53 at security/landlock/net.c:78 check_socket_access+0=
xfc/0x210
Modules linked in:
CPU: 0 PID: 53 Comm: init Not tainted 6.4.0-rc5-07746-gd88425633b73 #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
NIP:  c00000000090717c LR: c0000000008c54d4 CTR: c000000000907290
REGS: c000000006817970 TRAP: 0700   Not tainted  (6.4.0-rc5-07746-gd8842563=
3b73)
MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2800084a  XER: 20000000
CFAR: c0000000009070cc IRQMASK: 0=20
GPR00: c0000000008c54d4 c000000006817c10 c000000001558e00 c000000005040000=
=20
GPR04: c000000006817cf8 000000000000006e 0000000000000002 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 c00000000476bfe0 0000000000000000=
=20
GPR12: c000000000907290 c000000002ad0000 0000000000000000 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR28: c000000005040000 c000000006817cf8 000000000000006e 0000000000000000=
=20
NIP [c00000000090717c] check_socket_access+0xfc/0x210
LR [c0000000008c54d4] security_socket_connect+0x74/0xe0
Call Trace:
[c000000006817c10] [c000000006817c50] 0xc000000006817c50 (unreliable)
[c000000006817c50] [c000000006817ca0] 0xc000000006817ca0
[c000000006817c90] [c000000000e4e26c] __sys_connect_file+0x6c/0xe0
[c000000006817cd0] [c000000000e4e3c4] __sys_connect+0xe4/0x130
[c000000006817da0] [c000000000e50d1c] sys_socketcall+0x46c/0x530
[c000000006817e10] [c000000000030958] system_call_exception+0x128/0x330
[c000000006817e50] [c00000000000d6a0] system_call_common+0x160/0x2c4
--- interrupt: c00 at 0x7fff7fd9e544
NIP:  00007fff7fd9e544 LR: 00007fff7fd96c4c CTR: 0000000000000000
REGS: c000000006817e80 TRAP: 0c00   Not tainted  (6.4.0-rc5-07746-gd8842563=
3b73)
MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 24000842  =
XER: 00000000
IRQMASK: 0=20
GPR00: 0000000000000066 00007fffc31f3b30 00007fff7fe39900 0000000000000003=
=20
GPR04: 00007fffc31f3b60 000000000000006e 0000000000000000 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000000 00007fff7feba9a0 0000000000000000 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000016 0000000000000002 00007fff7fe33e14 00007fff7fe33e08=
=20
GPR24: 0000000000000001 00007fff7fe33e16 00007fff7fe07b48 ffffffffffffffff=
=20
GPR28: ffffffffffffffff 00007fff7fe30110 00007fff7fe33e08 00007fff7feb39b0=
=20
NIP [00007fff7fd9e544] 0x7fff7fd9e544
LR [00007fff7fd96c4c] 0x7fff7fd96c4c
--- interrupt: c00
Code: ebc10030 38600000 e9410028 e92d0c78 7d4a4a79 39200000 7c6307b4 408201=
0c 38210040 ebe1fff8 4e800020 ebc10030 <0fe00000> 7c0802a6 fbc10030 f801005=
0=20
---[ end trace 0000000000000000 ]---

--=20
Cheers,
Stephen Rothwell

--Sig_/i=8nT44GQRpQ8sBi_oj3vig
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSAA0QACgkQAVBC80lX
0Gy7JQf/ShJDyQZusw0go0tTOePXfZjpuPpp/2OsN+748oq4YzUHqN5OBOzYvNas
XMiz1ZcVYP1kcHqjzlwvIFubMgy6lGyaVbsC1F/TJmcCN6+f/RKK27gKL3CYEVgV
fwICs+tkldSCyXxi0HlVGIjfwJUpQbu0dgc5jVgMiiQZId6PSSkVD1+jj1uexvU2
RD2r6s7/7OXHoMbLuSYjJVZ1ld93/przCQA8QJ7JXkSoCVUK+iy9WoKbgY8PIZQQ
VW2f/Y95NWT8O1B5wIfVHHSU/oMs0dIiB1pi0M+BR5L0bq+DM7qkODAtE1G+hKuY
gbHn02PVuT2OW1Gl7nhmfQ98f5IyEA==
=gRSU
-----END PGP SIGNATURE-----

--Sig_/i=8nT44GQRpQ8sBi_oj3vig--
