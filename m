Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C522468E629
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBHClk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHCli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:41:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4613138E8B;
        Tue,  7 Feb 2023 18:41:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBPQP40XSz4wgv;
        Wed,  8 Feb 2023 13:41:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675824094;
        bh=HMwxK25m5TEOIepOfkozWcH/6Nc1cfBpMb0D/YdRs8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nBc8sGG16KR5XelfWJFPbShsAQJX7zp/gqvtfHMmbBB4nKPecMR06SYcO0osIZe2+
         BmMVE1K9J/xU/IczFpFYhVNdYqnQcMOATPLsoR9FTMVYCJ8382jkMkzF0zGK2Eq/U7
         sTWxqRZ4GyKT0JgDqpHW21GXxL53M2ey0ybKLSPsRhNcJIyykW8Gq0Eo343M0yc2ak
         uoWH3SR9AWH74GEaNFe5WN7YaO4sJJ1e/ZOnIqYOr34g5BEhIsTTjWr/U4H0krr8ig
         DeMl/Kg5NvELvl1U4Flt59hcicP2Z1/6z6O41X/zx7ANtayUGxaxgcKCAkTbS+qDd8
         j9S+nqvfhqiIg==
Date:   Wed, 8 Feb 2023 13:41:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230208134132.47246300@canb.auug.org.au>
In-Reply-To: <Y+JBak3Tt8Pdw3yE@nvidia.com>
References: <20230207153706.1821393e@canb.auug.org.au>
        <Y+JBak3Tt8Pdw3yE@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5wGf6R9p.Exv5zhi4uMYYYS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5wGf6R9p.Exv5zhi4uMYYYS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Tue, 7 Feb 2023 08:17:46 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> Just s/=3D FOLL_PIN/=3D 0/, it is unconditionally set internally when cal=
ling
> pin_user_pages_fast()

Thanks, I have done just that for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 8 Feb 2023 13:33:55 +1100
Subject: [PATCH] fixup for "mm/gup: move private gup FOLL_ flags to interna=
l.h"

interacting with "iov_iter: Add a function to extract a page list from
an iterator" from the block tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 95b8047be5a7..f6c6aef6fbfb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -2140,7 +2140,7 @@ static ssize_t iov_iter_extract_user_pages(struct iov=
_iter *i,
 					   size_t *offset0)
 {
 	unsigned long addr;
-	unsigned int gup_flags =3D FOLL_PIN;
+	unsigned int gup_flags =3D 0;
 	size_t offset;
 	int res;
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/5wGf6R9p.Exv5zhi4uMYYYS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPjC9wACgkQAVBC80lX
0GyRSgf/W75W4lmpKlU6sK8TbkZq8/F2ge4th3VHazB0d3ojYypNOD/A4KUYHjRB
S6R7i0voHSdFtC5uKB9W6LC80ohKB14lis8uaUiHWC14rEHbPd0lQaUrSv/ZCPDY
bnYQS2JO0fry8vWGuA09tXcgya9Z/F68neZi0kyQ8ozk90B1NED+ztfWOXQnIFZy
xon+js1/DnfeQb+ocUozIhSxDTSfWcSY6oEyU4gqv2eK21FFfcAM9Xh0IdcadZHV
ZwdwRsBfOUgPxNngzS7UkisPUsryHMcirhyeCC831leUBwbuxYngMmsIvmBZFVef
QwoybqH3UoUVtIhJ3p4hPjWYKR8OeA==
=Fiis
-----END PGP SIGNATURE-----

--Sig_/5wGf6R9p.Exv5zhi4uMYYYS--
