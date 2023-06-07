Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD5725292
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbjFGDwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjFGDwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:52:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EABE78;
        Tue,  6 Jun 2023 20:52:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbYML4yZBz4x3g;
        Wed,  7 Jun 2023 13:52:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686109951;
        bh=I/2NGt9/9OWpznwlvbvdmVuCRC/6x38PLIihyNzMT6s=;
        h=Date:From:To:Cc:Subject:From;
        b=aeE1z1jazSGpNMm3VEvxBOSrNNA0VJlgtlOKKuQ45jc+kx66xHMOu6I7zJobpocCr
         6XPst+aaL7VSlC0DAtmflxgaOcumQqX5P8OC/N2A5Or7JW1DLK1em5FjUNP36JifeG
         54VB+KGaJQjOxXTYRweoa6VKi32UQgBaZvWYXYoWq4WVr9Rj88E8y0rfTjCaS7B0RK
         4weIFU6WsYw7X4yFlWgyeRjrezqOJhamav8tXwPaEb8oQ/XcSW2RSy5cCO8ktQMhpH
         YE4OSdAhWPdGx7ElnJxu3m3ChjlNOmvfe+iH0V/FCDYfw09B9I04pf//ZQ4OxcgWwq
         +lWrsQuvYC2ew==
Date:   Wed, 7 Jun 2023 13:52:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the landlock tree
Message-ID: <20230607135229.1f1e5c91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eT06aNhzNx=miB4dk7itc4g";
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

--Sig_/eT06aNhzNx=miB4dk7itc4g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
samples/landlock/sandboxer.c:190:78: warning: format '%lld' expects argumen=
t of type 'long long int', but argument 3 has type '__u64' {aka 'long unsig=
ned int'} [-Wformat=3D]
  190 |                                 "Failed to update the ruleset with =
port \"%lld\": %s\n",
      |                                                                    =
       ~~~^
      |                                                                    =
          |
      |                                                                    =
          long long int
      |                                                                    =
       %ld
  191 |                                 net_service.port, strerror(errno));
      |                                 ~~~~~~~~~~~~~~~~                   =
          =20
      |                                            |
      |                                            __u64 {aka long unsigned=
 int}

Introduced by commit

  1c5befb13501 ("samples/landlock: Add network demo")

--=20
Cheers,
Stephen Rothwell

--Sig_/eT06aNhzNx=miB4dk7itc4g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR//v0ACgkQAVBC80lX
0GwRywf/VdtVY19MZ8Wnjt5cQCq8XyetW8ok1AIatSt1gOmbj/OVntg6W5sfo1Dz
UThwW8KPBOhXZO8+1cXxW5IhkwA0sRMyyP6K0vIoL8DKubDIRWHXzL7y6CJr2J95
OWr+DI0Wlemg3BvB1EGQbb1Nu9Ym8gICIM1ljLksrv1qtIOcuSEeqvDtp9B1VDuC
2F8YBmPuGKR0kRGpmy7fZI2qLuL7s+83cSlANyCT3zP5rg+c6fV+ZJUMJsTZQycq
XpDYhfMM7OHe2SHEtuFs9Uvt6Qz6+0oEIcE8yeawGe8MJyw9VsU9dp2Ov8I26p+4
SECPschm7an8tyDAPTXpBI0BvHtI9g==
=YuuV
-----END PGP SIGNATURE-----

--Sig_/eT06aNhzNx=miB4dk7itc4g--
