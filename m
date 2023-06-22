Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5000573ACEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 01:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFVXKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 19:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjFVXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 19:10:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96586193;
        Thu, 22 Jun 2023 16:10:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnGL06y7Dz4x04;
        Fri, 23 Jun 2023 09:10:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687475401;
        bh=Au03f7xLQfTU2zow8kOeULaIyTtn+azYlLTURG5opPk=;
        h=Date:From:To:Cc:Subject:From;
        b=lM2ZH+CLh6C8eUltDZw1FWOHmaJFteS6TZ39ccZ35Vzg02rPzOwR7geK+K5CqSyLk
         g76xi9QVCbQCxz6GZOElpmzn+u1RWzGnrJuLYuuGR6qH1hqi9UTa3Ma3AZAvZJpl7B
         8NwB9+T+sg7pwH71Ixkk+2ecL3o9dDcVjE2T/E4BvNoC+2nqLQ2JB8z0/pRmwKGARk
         1hulHaqZ0hne9wb6CPHX9xsw9M6u/PzqUS744bJDGr8BuoFoDIPt0SzDW3HNIFLhCI
         s/fTPeedv+jGLq/jOe8eFxRcOznx6p0zNFrFg26dC5qRWyPBxivIaYm35Mh+UINVHE
         goEH2oekgaFGA==
Date:   Fri, 23 Jun 2023 09:09:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Yunxiang Li <Yunxiang.Li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc-fixes tree
Message-ID: <20230623090959.7b5ce510@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v9Y/GsEo/xYLhTB/J0WD7wg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v9Y/GsEo/xYLhTB/J0WD7wg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc-fixes tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/build_bug.h:5,
                 from include/linux/init.h:5,
                 from include/linux/io.h:10,
                 from include/linux/iosys-map.h:10,
                 from drivers/gpu/drm/ttm/ttm_resource.c:25:
drivers/gpu/drm/ttm/ttm_resource.c: In function 'ttm_lru_bulk_move_del':
drivers/gpu/drm/ttm/ttm_resource.c:117:40: error: suggest parentheses aroun=
d '&&' within '||' [-Werror=3Dparentheses]
  117 |                      pos->first =3D=3D res && pos->last =3D=3D res)=
) {
      |                      ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
   77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
cc1: all warnings being treated as errors

Caused by commit

  4481913607e5 ("drm/ttm: fix bulk_move corruption when adding a entry")

I have used the drm-misc-fixes tree from next-20230622 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/v9Y/GsEo/xYLhTB/J0WD7wg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSU1McACgkQAVBC80lX
0GzBhwf9HFCkLl4s9TP1QEAZRSX6wn7Ei8uIrr3+3jSl5+3CWcHQI8+36xX+xKHt
MNWV+SXZ4slmE+jh8Lr5dWIO5LdnjahB5YEsDfh3ZIQEFEMNzLK5ar+SZ95LZGZM
7mrD4N35iI8s0z50WifBB5vK201vPtbwXA9y+Gzr7lvvSuLYSHRWYc3fJN/S1PpZ
pyM9fTc1dr51Ul8cEXgHhWSR5VDScR5SdxoXoVuC34QcdS8GmPAEEBUxZeQ0GxIO
QzZbs2p2wyHSknvv3Sto9eEkgxp0iQ/67237xMr+6LjRFTU67tIaIk9kVB7rOQVg
spL5OnukNcjZ5sJmNar2vieHB9IYVw==
=v0YD
-----END PGP SIGNATURE-----

--Sig_/v9Y/GsEo/xYLhTB/J0WD7wg--
