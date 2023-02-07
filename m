Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3825868CE46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBGEhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBGEhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:37:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0024699;
        Mon,  6 Feb 2023 20:37:15 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9r2D5hRmz4x2c;
        Tue,  7 Feb 2023 15:37:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675744629;
        bh=7lxNUNpo3zWsoEEgj7IAAJ4jSRFZnjBcATAFF+O6MCs=;
        h=Date:From:To:Cc:Subject:From;
        b=fqlqnGJsjwjPATeRilpRmk7tja60KXgaYq+keF6Pppsl4+cQlM/Hk1DONKyZUPjQQ
         1bcXdtoZ+3BAGpxHQp+UfHJiigdMkkPeJw9xzJKO1QnA9TNQe7/FBrSCGs4J2TJVa1
         XQiGuyPc/j8j61HbpKZidjvr/lA331OHihWzfEp1edCJ5jde1FcZC9b5PaNffR36Q8
         ROX97Y85sDc89kwPT9BC+jvgwfwJuOaxwuTl4+mccMeXzijqj7j77Q+Ar9s5nCZwKo
         BmZCfi72kBJXU1+hDEIImptfMjkdcplRLpG/83yRaAaGmEVXjAJslJ4dPm1Y0lUJMv
         JDJSG9bQ1Ztmg==
Date:   Tue, 7 Feb 2023 15:37:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230207153706.1821393e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/30m6fzZrHxRUjkSE__aqbhd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/30m6fzZrHxRUjkSE__aqbhd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

lib/iov_iter.c: In function 'iov_iter_extract_user_pages':
lib/iov_iter.c:2143:34: error: 'FOLL_PIN' undeclared (first use in this fun=
ction); did you mean 'POLL_IN'?
 2143 |         unsigned int gup_flags =3D FOLL_PIN;
      |                                  ^~~~~~~~
      |                                  POLL_IN
lib/iov_iter.c:2143:34: note: each undeclared identifier is reported only o=
nce for each function it appears in

Caused by commit

  0ff325d28700 ("mm/gup: move private gup FOLL_ flags to internal.h")

interacting with commit

  895d773054a2 ("iov_iter: Add a function to extract a page list from an it=
erator")

from the block tree.

I have reverted commit 0ff325d28700 for today.  A better resolution
would be appreciated.

--=20
Cheers,
Stephen Rothwell

--Sig_/30m6fzZrHxRUjkSE__aqbhd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPh1XMACgkQAVBC80lX
0GwAJQf/Vm4CiBAuj7HcmHqbgOjA9GgQ/DTqgLqzeNg3PBQCw0z4AO0fv2tGaMrF
rWWQTqqDOx2jblqc6q8lNtbPyg9RTOfK9s+yJNd8dQMEbP+3S1fT0557gCyIID8V
vQ+fJSJEy0ljP25Ihg7BBaPmq4JSMUeqgWEt7E5FrU36VDDOL59ZoT9p0YE533jP
pBSkouZhAnoV1tIH9n4TfMSZPTKq7mRFcu5amNv8UZvAhkyG/ofhC8Um7WdQlkDo
HLt/D5EmLI/5RUjIymeaKk6wN//SS+w2TZN5VyHMz4ioWKaMGVKwvRAKdi/wGoWP
+WntaiuJIo81PRLg0UXwJjk+4Oj3EQ==
=tJwH
-----END PGP SIGNATURE-----

--Sig_/30m6fzZrHxRUjkSE__aqbhd--
