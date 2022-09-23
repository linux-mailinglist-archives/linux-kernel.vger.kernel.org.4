Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1B5E7543
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIWH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIWH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:56:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7F012BDB6;
        Fri, 23 Sep 2022 00:55:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYkwr3K57z4xFt;
        Fri, 23 Sep 2022 17:55:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663919757;
        bh=5PmsY0I+WpfQJ1e1B8ggSK+yj8ur7fl3q0NjIItHC9k=;
        h=Date:From:To:Cc:Subject:From;
        b=DJwMJwqHWUK13ZtEx/VMmNOZ/fjulrP1hgphSZ85+jFSUcndTdyqInuDuHK2/MKJq
         RvnPtYGn/BfJaYCF3EMOPHvPZcqWuKi+V/KY5TGvtGYnkiCXnS4Elg8jkr63jFFsft
         Jy7Za8C7WXGhgRtZIMJlrytGtpnS23xaZGCIGWct4RSdkFvufSx686KSjLrWEuOTRe
         g11ULQ713B3GM98jVV7CuSBjY7f4C47I1RKbHSsmUB1FBt3/GlElplAq2jRIPzj302
         uUYpNwhoCyna5aWKU9/pn6552G78sdpqiR6XDBNoTzogUxtrJFbvGqocEbn/5+qlh3
         UIp6LpOr6FT3g==
Date:   Fri, 23 Sep 2022 17:55:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220923175554.59431f7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vd1HxF/OXtA5/lvB_oLqdgK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vd1HxF/OXtA5/lvB_oLqdgK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

drivers/base/memory.c: In function 'memory_block_online':
drivers/base/memory.c:186:34: error: 'struct memory_block' has no member na=
med 'nr_hwpoison'
  186 |         if (atomic_long_read(&mem->nr_hwpoison))
      |                                  ^~
drivers/base/memory.c: In function 'remove_memory_block_devices':
drivers/base/memory.c:870:61: error: 'struct memory_block' has no member na=
med 'nr_hwpoison'
  870 |                 clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hw=
poison));
      |                                                             ^~

Caused by commit

  69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")

This build has CONFIG_MEMORY_FAILURE not set.

I have applied the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 23 Sep 2022 17:50:50 +1000
Subject: [PATCH] fix up for "mm/hwpoison: introduce per-memory_block hwpois=
on counter"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/base/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c9bde4c4ffdf..143c63ceb4c3 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -183,8 +183,10 @@ static int memory_block_online(struct memory_block *me=
m)
 	struct zone *zone;
 	int ret;
=20
+#ifdef CONFIG_MEMORY_FAILURE
 	if (atomic_long_read(&mem->nr_hwpoison))
 		return -EHWPOISON;
+#endif
=20
 	zone =3D zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
 				  start_pfn, nr_pages);
@@ -867,7 +869,9 @@ void remove_memory_block_devices(unsigned long start, u=
nsigned long size)
 		mem =3D find_memory_block_by_id(block_id);
 		if (WARN_ON_ONCE(!mem))
 			continue;
+#ifdef CONFIG_MEMORY_FAILURE
 		clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hwpoison));
+#endif
 		unregister_memory_block_under_nodes(mem);
 		remove_memory_block(mem);
 	}
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/vd1HxF/OXtA5/lvB_oLqdgK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMtZooACgkQAVBC80lX
0Gw2QAf9HUn7UIOdAbSw/a4Rv+GTG4C4Jdzvk1gHVcq3NXbHA1Pf2DRVhWhTulxR
RNe52fMedFZAreBSHDNuLckmq0TSPlOELYiHyMxZRPIW3gd7VtpkIn52gRnUK8Jj
wwYZ1kqeimE9mS0bAy89eprsO7/X90BgAjTQxxNdOpnASlt4yuJCO2c78Z9iKKAH
nqcq3gJAKoR5qrWS1MolcJe9zh0DBtSw0M/8yBVD5+E92ubDW09gGP1ETBp5mNzi
stT8nOboBQaYWu4CRzcuS08OvrYleiClGTjPPB1wie4CioBG5G91zC9DcldQzzjy
4qxDV1d1S5F2OsYc5+Qu9bmWxUBdXg==
=u5li
-----END PGP SIGNATURE-----

--Sig_/vd1HxF/OXtA5/lvB_oLqdgK--
