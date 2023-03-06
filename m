Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417686AB4C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 03:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCFCzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 21:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCFCy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 21:54:58 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DEFEFBD;
        Sun,  5 Mar 2023 18:54:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVNTp5n20z4wgq;
        Mon,  6 Mar 2023 13:54:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678071295;
        bh=Pn7ta1viWY+yaawNJcsj7+3gke8PlSKDAjlsev2h3a0=;
        h=Date:From:To:Cc:Subject:From;
        b=azuluoohLTPw91ZOTmoWSjqpeM7IMhUwHFUIc7SYYefpGu7G5ZWo0zH1KslnxCFKB
         iELiRVwnb8QEP4B0B4nrbKzGuFBsUy8qOjPuQ8+Xv2Y69xlJQ8D1GD85SZnk492N5A
         /jzBHyqSqfRlIRuzZqbwyPyrU4maetDoKZFAIVCs+l0/4WacL/QVfAyK1bQjzlNjh9
         GbSsOC+2LANwMANR2XWypGtdxw/9jGl0CFo6kXTp50e7UJf2w7/+FVPJ8x30RVIOcN
         WtQdtEkkHakCQHYARSmrC8a0Vte7Aea23xaIwtmNYskJsRZYfD6ihdjW07uWiyxXLy
         o4qLjl00SP2jQ==
Date:   Mon, 6 Mar 2023 13:54:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230306135447.2c657f48@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EktfoyZTQ9egu/Yoqqs8el2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EktfoyZTQ9egu/Yoqqs8el2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (various) failed
like this:

mm/khugepaged.c:1702:9: error: implicit declaration of function =E2=80=98vm=
a_try_start_write=E2=80=99; did you mean =E2=80=98vma_start_write=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]

Caused by commit

  92e3612279f9 ("mm/khugepaged: fix vm_lock/i_mmap_rwsem inversion in retra=
ct_page_tables")

The definition of vma_try_start_write() is protected by
CONFIG_PER_VMA_LOCK, but its use is not.

--=20
Cheers,
Stephen Rothwell

--Sig_/EktfoyZTQ9egu/Yoqqs8el2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQFVfcACgkQAVBC80lX
0GxwBQf/Zwx5irKLOgIBzYtUpHWD4WLfN1a6l/mFKO4s10ar6z6Vun2g2uuQTF02
PhPeJCSmIXAzwpNVDfY9vsbPnGsrBYJsH5GcLOWu5s7oCPYKBa3T8xiV5e4iFGwN
MhET0OIqDvYYcCfg/A5rBF8DqbcYhUpZ7K4yX+y6ZlHIsLc6uG4BwYvDH6RtQrbO
imDidegzHbF96G21QUQSyIXZl+z3673z3BMqMdPRB/NLuD3lKqerN2eVTjvaao0c
hHnguyZZgsLQZB1Bl498tinQJIx5C65YwrAt1R+vCaDOeA3LfXHIGqgi9De68/2p
EgPD3LmSh7L+h7aHBxT9yoDR+pZKsw==
=93Zt
-----END PGP SIGNATURE-----

--Sig_/EktfoyZTQ9egu/Yoqqs8el2--
