Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8BA6C7544
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCXB5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 21:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCXB5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 21:57:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D144B252A9;
        Thu, 23 Mar 2023 18:57:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PjQLq634vz4x4r;
        Fri, 24 Mar 2023 12:57:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679623028;
        bh=oHihvewVwDnXNl4zUqa8R15d/bxI1Sr8bzJkv0X3MpE=;
        h=Date:From:To:Cc:Subject:From;
        b=PmV+MbdAIcOKnyoID8DeC8lpkf5nXNWvbiqC5wMqtQNkIR7KNLeyec4Stc1aJWDZk
         yrtcLsR/Ibrw27P4EZX2dZxMJ8B6h+0apWNvsvPNJAz04LNxMXu2NAOOcwK1C/GHDH
         cSHW9QUCW99B+syUqMEkRgYTGqhXHOS8ESwVIxFJh5Scgjri5TgaohDx7/FaTxC+bl
         tFSZ31ONCiYb+xvv4JvvEGQn3otH8au5QKCDSwdZ0bqBMPKmrVYUPuz+PrA1zCFl9h
         DWV3pIIetflHZY1dyPHlb8A1IlUZ5eIELziIpi/BZkHNNVf39Nyqjj+GXtf7BNRlM4
         fDsDLQ5TxI9JQ==
Date:   Fri, 24 Mar 2023 12:57:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the block tree
Message-ID: <20230324125706.2c6d955d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yP/MIZnYfmpXjMQbYCd6QXM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yP/MIZnYfmpXjMQbYCd6QXM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from arch/powerpc/include/asm/cmpxchg.h:6,
                 from arch/powerpc/include/asm/atomic.h:11,
                 from include/linux/atomic.h:7,
                 from include/crypto/hash.h:11,
                 from lib/iov_iter.c:2:
lib/iov_iter.c: In function 'copy_page_to_iter_nofault':
lib/iov_iter.c:497:22: error: implicit declaration of function 'iov_iter_is=
_pipe'; did you mean 'iov_iter_is_bvec'? [-Werror=3Dimplicit-function-decla=
ration]
  497 |         if (unlikely(iov_iter_is_pipe(i)))
      |                      ^~~~~~~~~~~~~~~~
include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
   78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
      |                                             ^
lib/iov_iter.c:498:24: error: implicit declaration of function 'copy_page_t=
o_iter_pipe'; did you mean 'copy_page_to_iter'? [-Werror=3Dimplicit-functio=
n-declaration]
  498 |                 return copy_page_to_iter_pipe(page, offset, bytes, =
i);
      |                        ^~~~~~~~~~~~~~~~~~~~~~
      |                        copy_page_to_iter

Caused by commit

  a53f5dee3448 ("iov_iter: Kill ITER_PIPE")

interacting with commit

  14116ab76dc2 ("iov_iter: add copy_page_to_iter_nofault()")

from the mm tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 24 Mar 2023 12:44:44 +1100
Subject: [PATCH] fix up for "iov_iter: add copy_page_to_iter_nofault()"

interatcing with "iov_iter: Kill ITER_PIPE"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/iov_iter.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 9f4ec9adc036..f7b06366882b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -494,8 +494,6 @@ size_t copy_page_to_iter_nofault(struct page *page, uns=
igned offset, size_t byte
 		return 0;
 	if (WARN_ON_ONCE(i->data_source))
 		return 0;
-	if (unlikely(iov_iter_is_pipe(i)))
-		return copy_page_to_iter_pipe(page, offset, bytes, i);
 	page +=3D offset / PAGE_SIZE; // first subpage
 	offset %=3D PAGE_SIZE;
 	while (1) {
--=20
2.39.2

--=20
Cheers,
Stephen Rothwell

--Sig_/yP/MIZnYfmpXjMQbYCd6QXM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQdA3IACgkQAVBC80lX
0GyzEgf/Se7iOpy7IJjKB2Wl8RN4aPMUQnF6+M1wfPTazJEpQtkXFRoNxDLnbCcZ
u9q87HxjmPbRiTxD+OMN+SCO2Fvcy5MnYNQpTH54ab3vob3s2CdkIf3ZOBgFfPPh
2LuZdGJsoWVMNAej23z8seWeFwO0Yih+3x+nkXK4/IQuBW/WEPLxo4jbWmi3Swlk
p3p7G/iR9xYWo7QkTiWe18n5YuauanJKyvde/0zBsHWODqvFgYU1KA0PqOORnLBY
Hc7v12RpcCjBQ3PMhm9eeqUtHz+nbtVkslf1wKT53lQiQSdAND9Gu1J9YuSKh/nh
48nMd+lQR1mVl9WqLOSM4XDJVafFqQ==
=B619
-----END PGP SIGNATURE-----

--Sig_/yP/MIZnYfmpXjMQbYCd6QXM--
