Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AB723594
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjFFDCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjFFDCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:02:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74109109;
        Mon,  5 Jun 2023 20:02:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZwJG2kyNz4x1N;
        Tue,  6 Jun 2023 13:02:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686020559;
        bh=9WP8Vb8OpZiakpRCpZvxyIWKdfQuuSxSiDxaW9Kul2g=;
        h=Date:From:To:Cc:Subject:From;
        b=lKGw+YBO3GS77JdqJswjEnRawx7wAtJFqbaywD3WNf9U5zatjyvm0HwBhflT0+QZN
         NPqiRTca/dU4Ka9iGmCOTh++09hES4ZyIsKrEGhlaatmbk9fJsPFrAhAk3/KVIlODa
         3VpPIdgZqNQ1xDLw8Ts45Bo6N3j1h8g7FBH8GgnDNEaQ72aScdkNAG9TTFdqMQCapX
         C2jwFyTLjAu71R7xb453QkgSBpvwa9qPk/VWy7UX7Brhm481RWBHdPsCIqqWv11Vp8
         mfCCvRExly/LaGbUq1hfJXDZ3GemosiWXfxcdG1jBAfbS3OzpZ2YQKOatwLw0LoAFe
         8lS6+qNSlFpKQ==
Date:   Tue, 6 Jun 2023 13:02:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the landlock tree
Message-ID: <20230606130236.4d339a46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cnkiTwGsSkP/ekDl/_0L5p/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cnkiTwGsSkP/ekDl/_0L5p/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

security/landlock/net.c:165:51: error: expected '=3D', ',', ';', 'asm' or '=
__attribute__' before '__lsm_ro_after_init'
  165 | static struct security_hook_list landlock_hooks[] __lsm_ro_after_in=
it =3D {
      |                                                   ^~~~~~~~~~~~~~~~~=
~~
security/landlock/net.c: In function 'landlock_add_net_hooks':
security/landlock/net.c:172:28: error: 'landlock_hooks' undeclared (first u=
se in this function)
  172 |         security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hook=
s),
      |                            ^~~~~~~~~~~~~~
security/landlock/net.c:172:28: note: each undeclared identifier is reporte=
d only once for each function it appears in
In file included from include/linux/container_of.h:5,
                 from include/linux/kernel.h:21,
                 from include/linux/uio.h:8,
                 from include/linux/socket.h:8,
                 from include/uapi/linux/in.h:25,
                 from include/linux/in.h:19,
                 from security/landlock/net.c:9:
include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not a=
n integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); }=
)))
      |                                                   ^
include/linux/compiler.h:231:33: note: in expansion of macro 'BUILD_BUG_ON_=
ZERO'
  231 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), =
&(a)[0]))
      |                                 ^~~~~~~~~~~~~~~~~
include/linux/kernel.h:56:59: note: in expansion of macro '__must_be_array'
   56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be=
_array(arr))
      |                                                           ^~~~~~~~~=
~~~~~~
security/landlock/net.c:172:44: note: in expansion of macro 'ARRAY_SIZE'
  172 |         security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hook=
s),
      |                                            ^~~~~~~~~~
security/landlock/net.c: At top level:
security/landlock/net.c:157:12: warning: 'hook_socket_connect' defined but =
not used [-Wunused-function]
  157 | static int hook_socket_connect(struct socket *const sock,
      |            ^~~~~~~~~~~~~~~~~~~
security/landlock/net.c:150:12: warning: 'hook_socket_bind' defined but not=
 used [-Wunused-function]
  150 | static int hook_socket_bind(struct socket *const sock,
      |            ^~~~~~~~~~~~~~~~

Caused by commit

  6d0bfdb25ce6 ("landlock: Add network rules and TCP hooks support")

I have use the landlock tree from next-20230605 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/cnkiTwGsSkP/ekDl/_0L5p/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR+ocwACgkQAVBC80lX
0Gw9YQf8CxDElM6AUs8o/MYQ7D8eE0+oTbWm5FgZDzNgfPDf+s4Q/IDf4tfMUKe6
Y1mgp9q4C20ErUjMM7BQhZUPsJ0WPJKIYn6UIBwROBA0TH2vf8Hycyro3AkCp5XP
90Np5BRgR/oDEZTzaCITjEB4c+gka1rKdfTxNrXUKRlrovQSMZpI4eKT6r8tccXF
rSKiSpkkq3rRg5uYKyEqJ045mlqRGS5m62YKLLjRQ0Pu+sNDA1SEEIFjC92BD1c7
rhYhwIvB2lU8COdV+QfMqOITdN/C11D884G6kimFaqRwEBMrRsETySCbhTNRzWuQ
p8sP2Nxa+PcIUMu4w2glceUUkPHIgg==
=7t/t
-----END PGP SIGNATURE-----

--Sig_/cnkiTwGsSkP/ekDl/_0L5p/--
