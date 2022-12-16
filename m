Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D67464E51E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLPAVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPAV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:21:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CEF2497A;
        Thu, 15 Dec 2022 16:21:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NY8sZ1bCkz4xFy;
        Fri, 16 Dec 2022 11:21:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1671150082;
        bh=QL/yOUmVGbIFowZmSX2CWf7RRNEKla/HaxsZfmfae9o=;
        h=Date:From:To:Cc:Subject:From;
        b=hmOniOcanDiW9XyHjIjSWheBoKKpKGZolfdSYxaMVMi40nYVCIloDFkohKaDD9Rqi
         L9HKUqgDJ44hiojgb1bBaMWENW6lXyx8A6GkaDGbzj94/KPLujDQCyRoVEfGkRfs2E
         NZUKmC8AuRwmkK7JMSm3enuLT1D4cJTwUhDQZmsCXX3eGHAD3c9ovi7KDAeMgmNoCv
         7+qTqyNWHFT7oyqmYygOhHALEsr5XfN9xDzTYgqLOL4dwOjuse1rFWHmkKqjhOduf9
         j2D1tKqs0mxLzZNhFHwpN/udhzp1QKVKuju4IcjUXJT6zzPUZTIa9o9soqGijCayEj
         qRrobBYcwh8oA==
Date:   Fri, 16 Dec 2022 11:21:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20221216112121.4bcb5c43@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mapsk=RE/lB=xgF7z4Xk1DY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Mapsk=RE/lB=xgF7z4Xk1DY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from fs/btrfs/tree-checker.c:20:
include/linux/error-injection.h: In function 'get_injectable_error_type':
include/linux/error-injection.h:22:17: error: 'EOPNOTSUPP' undeclared (firs=
t use in this function)
   22 |         return -EOPNOTSUPP;
      |                 ^~~~~~~~~~
include/linux/error-injection.h:22:17: note: each undeclared identifier is =
reported only once for each function it appears in

Caused by commit

  fcb9954aa1dc ("error-injection: remove EI_ETYPE_NONE")

I have reverted that commit for today (and the following one).

--=20
Cheers,
Stephen Rothwell

--Sig_/Mapsk=RE/lB=xgF7z4Xk1DY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmObugEACgkQAVBC80lX
0Gw5wwgAmT6P6JYp56+yr+IRXElgNUxM6mMnurz3tcvX38HCoe0bpyjqynMGZoV2
Z1RUu49v0QQBVOvZy7hRyv89rioJiHianYqGG+S+sOQu7RvDvNckLOcKK7bE+7zo
opCTM7cjgWxmfdJYPG3NwhZ8RbrQoi8Nj77A7l/ffbAXgKpWtlm49fD8SdUaBT7s
8uLD7WrilXknzoEJN30unZ9aMZ7mjJ+oRP+W57RESOac5PT7hfuENORXMUuwypdZ
n3X2r3CaU2h266wclNNGXX+XwpoN9+NJcRrwBrPnopLrckatOEmbhOAL9PCP4XyX
8dhYj6o2dMFuV8upbEcm9Bau8TCA5Q==
=Uop7
-----END PGP SIGNATURE-----

--Sig_/Mapsk=RE/lB=xgF7z4Xk1DY--
