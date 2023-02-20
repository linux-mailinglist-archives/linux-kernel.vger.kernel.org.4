Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8469C4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBTE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTE3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:29:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFACEB49;
        Sun, 19 Feb 2023 20:29:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKqFb5NJ5z4x7s;
        Mon, 20 Feb 2023 15:29:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676867380;
        bh=47yAsNBVz/bF8v+GyORW2D28SeE3SrcQHkb19R889NY=;
        h=Date:From:To:Cc:Subject:From;
        b=QsHeLFR1lDNIOX8KiKdIlCg+c9QrshDaNx5JWnSQhzsyKT9gdHE+W/ZYq6OCl6mf4
         Pl8F6ksY4+WOjZR6WBRr4r0znGi8xuIuvcoBimRtFGIZOGbeE00UXLXmtt74h9JD/W
         4LRM4hs+0wP8xSRqlCRXJdXuxz+JV5kK73kGe19C95eNYKKP3Mo7/V8uzPibC/1kZq
         TYP3fQp4qj2CH+YXXlSDKbHO5PY8dfvsSxCbEPK8t2FV0/KnhvEmNPqiwTeTNoaq/3
         fPLvZjP69OQRUEoLc8BImbTm0mPRebxOF+f3iGkddFUZYWOagMoxtlFs5Th/qthZqu
         opDOWWpOGQ2Lg==
Date:   Mon, 20 Feb 2023 15:29:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: linux-next: manual merge of the mm-stable tree with the ext4 tree
Message-ID: <20230220152938.45f62d5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uyn7bLrtRm3WzoG1k/4goUs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uyn7bLrtRm3WzoG1k/4goUs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-stable tree got a conflict in:

  fs/ext4/inode.c

between commits:

  726432969963 ("ext4: use nr_to_write directly in mpage_prepare_extent_to_=
map()")
  9ff6a9153c8f ("ext4: move page unlocking out of mpage_submit_page()")
  b4d26e70a755 ("ext4: move mpage_page_done() calls after error handling")
  9b18c23c131a ("ext4: convert data=3Djournal writeback to use ext4_writepa=
ges()")

from the ext4 tree and commits:

  50ead2537441 ("ext4: convert mpage_prepare_extent_to_map() to use filemap=
_get_folios_tag()")
  d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")

from the mm-stable tree.

I have no idea how to fix this up, so I have used the ext4 tree from
next-20230217 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/uyn7bLrtRm3WzoG1k/4goUs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPy9zMACgkQAVBC80lX
0GwsgQf/Xfs+3JaBpg1PquuhVr1B0sx2lv9bfr68LMGqavvWKqBrQ5NT6rFlKjaI
1XToHXSpNAwBo3XF34i8MWZHxU643BxHxostWnHV70VMzmZmvxcvqrMXLYWeOgUn
9NMdy5P5gI1XUwlb04VccXtK2o6hTn+pwu3vTrwJdr3pBw0RlnyWtIfL3Vpic9G9
TOX199h8RQDt4PscTEOLrvRcJr4rPdo49MEjZ/783ghCwTiLjeT0BneAXt2ZPPbh
ZNC9azHhR8brRbnyP5f9ggAEQnG6p9u8Bdn94DgffLy+j8NFu6s/A5/YxI5O2hwO
TuRhxRhRKBhRlxaymQ2UgJIGicZNDA==
=Vy1o
-----END PGP SIGNATURE-----

--Sig_/uyn7bLrtRm3WzoG1k/4goUs--
