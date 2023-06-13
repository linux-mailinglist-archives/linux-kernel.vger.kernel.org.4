Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E072D686
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjFMAnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjFMAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:43:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E9E7A;
        Mon, 12 Jun 2023 17:43:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qg8tV5vR9z4x4G;
        Tue, 13 Jun 2023 10:43:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686617011;
        bh=Z3d8HXepKDGROKZfan+P+T9+z/WIb+eklER97vDRfNo=;
        h=Date:From:To:Cc:Subject:From;
        b=grJEPFT7Ekeodj0a46M6+YbYEB40Yg1oMzxfJ0og8tGO7CUlXdJVPoz67ODN2L9z7
         h2DBQD2qvJhR5VJC4gqm3/HTp5apjlBd0c9OYNjTBbx9U9Y/VkW4rMC4HIG0hJdbWz
         g+GAen3I5FNGJ3mtr3aw0ZqjcIuE9ovilGb6GfWDRaEy7jjd+N3vV9h/2ZIzXUloFR
         IfsrQ0nXO1YJUhjkRDAJLUCdKS9pH7gQVhFQ70z/aHRSkJo6r4E+/uy3v3uioaL2qE
         k2Q7zt99iPLC2BzaUvVVTH0sP+E8SEkwHYdeCUvxo599YMJeHiFA81/wmaEoApnPc9
         NYIVqSFZBM/UA==
Date:   Tue, 13 Jun 2023 10:43:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20230613104329.025f9e4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EBie48=d3B/bm7Or3j6Uisp";
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

--Sig_/EBie48=d3B/bm7Or3j6Uisp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/input/touchscreen/ads7846.c: In function 'ads7846_get_props':
drivers/input/touchscreen/ads7846.c:1126:24: error: cast from pointer to in=
teger of different size [-Werror=3Dpointer-to-int-cast]
 1126 |         pdata->model =3D (u32)device_get_match_data(dev);
      |                        ^
cc1: all warnings being treated as errors

Caused by commit

  8f7913c04f6a ("Input: ads7846 - Fix usage of match data")

I have used the arm-soc tree from next-20230609 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/EBie48=d3B/bm7Or3j6Uisp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSHu7EACgkQAVBC80lX
0GyaJgf+Ntj2hV9I7pQ3RUWf4lYdTLx5TCid2x87GIuxB4Oc3gkXTdlPWQi2Ts5u
+SZKCzm2VXyuCV56k3/CG8XAh+vV6f8CjCgrvcK5PlMZc/U9fdAmZw3tim2GdPFS
QJMKsD+h3fY96BhX0LRjT4Z2ZOdhL5OP9FnO49Y8YnVHBEMKZ9fkYZO3zk+svRrn
/rZ0UlrpEmGX5yibmeNON6L13z1kkL97h/Qi5hI9WItxXYPf/7gqn+H5KLkVc34t
W0x+1tcX0DdupTel8XFUBSXC+to8i/dd9pDcr26pgHjELaa4VgweLZg34c62TTSk
UPogjhnjwCP4N9N0yrlTvULQEmFLjw==
=Yqbj
-----END PGP SIGNATURE-----

--Sig_/EBie48=d3B/bm7Or3j6Uisp--
