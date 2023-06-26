Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1373D6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFZEZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjFZEZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:25:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5610B;
        Sun, 25 Jun 2023 21:25:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqFBp3B5gz4wZy;
        Mon, 26 Jun 2023 14:25:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687753538;
        bh=g7b7ddot+g0kPi7NOWnnZg8cPvLdFiOfuEfMf9P7BwY=;
        h=Date:From:To:Cc:Subject:From;
        b=o3G6t36fi9QSX1N9bGABlL2uqcGIMkw0PervgnLC8zlN9RWW3JDoBRN8RWvZ7WX6V
         8i2NkbxNGXPs9Bt3KbXa8IQO6JlyrieU/jU8YuxhuyRk29pXshr1W9hEyEdTJZqKnH
         7sM7J4ob5H2EGTNTa2fnucT63TgBzEnkSXHSDeiS927j0QpaHvEhdZn4FSZngeMRrC
         SyY2XA1GsdCc0Y0AH7yfy3M8k9e1biEVcPjOJwrUtdl4QwmpH7Xk/Q4KGC9dyDRomM
         yfG02aZgse1btx7JSjd59LVaJeQYz8O/G6hZreG2MoGKqtQ3g3llsL4c5cjZKfLZZe
         y6W2XA3+H1u3Q==
Date:   Mon, 26 Jun 2023 14:25:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the char-misc tree
Message-ID: <20230626142537.755ec782@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g6vuXyYpDAxs1a9lIB4BfRs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g6vuXyYpDAxs1a9lIB4BfRs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the char-misc tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/char/bsr.c: In function 'bsr_init':
drivers/char/bsr.c:301:13: error: 'err' undeclared (first use in this funct=
ion)
  301 |         if (err)
      |             ^~~
drivers/char/bsr.c:301:13: note: each undeclared identifier is reported onl=
y once for each function it appears in

Caused by commit

  e55ce9fd3d8f ("bsr: make bsr_class a static const structure")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/g6vuXyYpDAxs1a9lIB4BfRs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSZE0EACgkQAVBC80lX
0GyNIAf/TBpRXH6Q8XxR7YxAQx12fWgd4FGw3/gHnzrCWbO96uqBTkF4bBiBCnsU
1PTNtC+ISL5VJh1qb7WxQILmTwFr9yQi+eUTOPk2u8eNN38kk0rzMB4DeTZpIC66
l6Ln4vr88NPREGmbP3pS4WN4ULES4UH9QDCnWwPZxL0iSi0747vpgiDz05cyDkC8
LBN9CUU7+a0zzSI7e3XyzbCCVD8iIAB3RgQRaEAlpN9xGTFmaXK+LXmjymQjO8L9
7h31sOn6MJAIPDYBmegcovPCcH29bWlckfCWdj0h9apqbB0fwSjaMFK0YbgGuy8a
lDW6d72fapJQj6gZXTjnphaC5pLBgQ==
=MgKH
-----END PGP SIGNATURE-----

--Sig_/g6vuXyYpDAxs1a9lIB4BfRs--
