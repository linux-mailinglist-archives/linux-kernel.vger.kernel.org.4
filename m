Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1263D66B4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 01:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjAPA3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 19:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAPA3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 19:29:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0062CC22;
        Sun, 15 Jan 2023 16:29:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NwCZr35Crz4x1N;
        Mon, 16 Jan 2023 11:29:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673828980;
        bh=N2kwPoMMz0R6pHkbqhmQk0W0f8pwQljldJVKjQUdfFI=;
        h=Date:From:To:Cc:Subject:From;
        b=I4n2wZNh7W6ip9TSYGLiTof9ewMzDX4Jx6n4jCwyU7SEK8jYmIePymtUGbbTOILww
         T+l81cj/I5nT3d+gbZzLNZkW4S9AOcOxAp/RQxyhPXwwJ24Iv20TPUIpIRj4c/fFKn
         4tgjbOGNG1EyXT29mwE4X6hilA5+sf9fj715hcc4rKXPP9+WDZon8O7rxL8WAwEkzR
         Pvf2hqzj/OsVg/qO8GINFubUme6SyEtDqKkld2KSM5Rx0gsP+yOXM3j2I0EhyWmJTS
         aVtAYYdeLvXWxc9aza1NmlOreMhrT4MgK+1JyXknR3pf70nvFHoF/23UqKZ7flzaUn
         beT3gj+a4j2tQ==
Date:   Mon, 16 Jan 2023 11:29:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Danny Tsen <dtsen@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20230116112939.0820ff24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oizzXh1XaAGuFYdWc2C7=3y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oizzXh1XaAGuFYdWc2C7=3y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: ".aes_p10_gcm_decrypt" [arch/powerpc/crypto/p10-aes-gcm-cry=
pto.ko] undefined!
ERROR: modpost: ".aes_p10_gcm_encrypt" [arch/powerpc/crypto/p10-aes-gcm-cry=
pto.ko] undefined!

Caused by commits

  cc40379b6e19 ("crypto: p10-aes-gcm - Glue code for AES/GCM stitched imple=
mentation")
  ca68a96c37eb ("crypto: p10-aes-gcm - An accelerated AES/GCM stitched impl=
ementation")

I have used the crypto tree from next-20230113 for today.

BTW, that series seems to have been committed in the wrong order -
there are refrerences to files/functions before they are created.

--=20
Cheers,
Stephen Rothwell

--Sig_/oizzXh1XaAGuFYdWc2C7=3y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPEmnMACgkQAVBC80lX
0GwrIgf/WctXiHQJZ7ArzEDBvM4OUVs9cwDjeN1AGScgP3tjlafxGq7Zm0G9PFkM
Ftpw7L8YAZ6E6G/4jO6lob1jB3niHAgIZ7MT9I5MwN4qpffLeUTwiywanYyKofBy
lP5/eGlPKY298tkxvzNh5eV2YE9Po7rzjb7lV24aH3gWYwJIJiNRZoQxmzRdmXr5
+2LJi5TESrWWWb7S4iWiG9b7pwV01BNQzZTJrA69RW85Y4LxVIanICtBmztav9WD
PJILprxrZ7Ij3GNMPAPzuWpNQeIIkVcz5Lnqr9j/2pMKYnlFAh06CPb3Tb64xTpB
IaQipqMB1BWDazTjbsv6M1w7hUqvOA==
=rDnh
-----END PGP SIGNATURE-----

--Sig_/oizzXh1XaAGuFYdWc2C7=3y--
