Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00CC718FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjFAAuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAAuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:50:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A4B119;
        Wed, 31 May 2023 17:50:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWnbk75bZz4x4G;
        Thu,  1 Jun 2023 10:50:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1685580611;
        bh=eA7eocgBkId8q1Rlgtwq2v76SjWFhVtNa0dJ+BXsGdI=;
        h=Date:From:To:Cc:Subject:From;
        b=s8VwonAWvpwiuxncBmIEe7+p9sl+l2t0bG074II/TRNLkWveV9aJSWWbqy5/VL/vu
         YEHCEKiBmdD55IVvHSx390vnu1SN6OzmTkdkAs9lkddXcGFInGLeI/yRBu6QlJANIL
         6ipZ/cuqjNQX5ce+hhodkr6bc0algjqdQEIahktAX7x6dpfN1jqBuqZasKUcI0TPw0
         B7Y0vjjF0We7HuqdnSjqTUV5BpUMi2hoaJ61g8vk/Bha1YRGGxjXMBkuv1H0bJ7Psi
         suN9nHskg82j3ItmZGNKu2cK5k8ii7FH//5geo29pkkv+xP7/hAkaQKk0TZ0awUjoX
         +rWFEHMgbraXQ==
Date:   Thu, 1 Jun 2023 10:50:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20230601105006.199a32ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=kVi1+ymLEM5YE_QaP+1+Vd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=kVi1+ymLEM5YE_QaP+1+Vd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/slab.h:15,
                 from drivers/md/raid1.c:26:
drivers/md/raid1.c: In function 'alloc_behind_master_bio':
include/linux/gfp.h:320:36: error: passing argument 1 of 'free_pages' makes=
 integer from pointer without a cast [-Werror=3Dint-conversion]
  320 | #define free_page(addr) free_pages((addr), 0)
      |                                    ^~~~~~
      |                                    |
      |                                    struct page *
drivers/md/raid1.c:1151:25: note: in expansion of macro 'free_page'
 1151 |                         free_page(page);
      |                         ^~~~~~~~~
include/linux/gfp.h:303:38: note: expected 'long unsigned int' but argument=
 is of type 'struct page *'
  303 | extern void free_pages(unsigned long addr, unsigned int order);
      |                        ~~~~~~~~~~~~~~^~~~

Caused by commit

  6473bc325644 ("md: check for failure when adding pages in alloc_behind_ma=
ster_bio")

I have used the block tree from next-20230531 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=kVi1+ymLEM5YE_QaP+1+Vd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmR36z4ACgkQAVBC80lX
0GwgEQgAoehI9uDduHv7XyN1kvBumduCQsO8BMe/bNKP8n4hFT/ZqS5Vvhm1jejl
Qz0mllM32YnyV+A+TOkJM8wlhLku33glrR4CDQlSz1NTtuwNLfnbsfFPZRWxH3k9
dpEZHCfmW7XhsK1hHxI9ZnEIjU8EvElnyKswYr9/8HejbwrGa2QWRfL5fwSDHjLN
igJ714nXPs0qxhXx1XsPoM/MAnFl+1nyIJa3SZM15Fj3VDwPBrFkh7RtqodnIKRB
wWG4YPtcuk2slkDX2qW2f4yv/hde6He/PPCFpsa7uRXuLT/IO46qt+skRkIWFivm
tGHUV2CGMAqmZeQY7BivAtqFBAiPcg==
=RNiC
-----END PGP SIGNATURE-----

--Sig_/=kVi1+ymLEM5YE_QaP+1+Vd--
