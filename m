Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB3734AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFSEDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSEDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:03:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F138FF;
        Sun, 18 Jun 2023 21:03:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qkx2W7293z4wg8;
        Mon, 19 Jun 2023 14:03:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1687147412;
        bh=TVJKR0fHhUqXJ3TbbCvXJXNSGk8DOs9SSkTVMI7js44=;
        h=Date:From:To:Cc:Subject:From;
        b=RRsL5Hs+voOIPw2EbO1s+QfDR3X6tnQa8lp51qQl3AKX+O1vtEK/gBNFz2D3XEIkq
         r7+4QUsrPUPVobpg6yMoAFxehufDDI/L4apLtj/XOxZp0TX9egxrK4wNl5niE+n+Gc
         iqQMgyg2xQCoHuBQ/IhKNYIKIckYzmx+t17kCDbDw/h3NNyf81+4NdYWLdW753eBw7
         of5tZHLX/eaL3PrPmh21PBGxZuEXUJPmK8/wzypx8dXBy0bMqzudqfGAvVOECzdVAs
         O+D0c24KTrR4RiP//USvQ/yRJyu0oASDeOOjytCMj3Mbjz1bvat+BI0wpXedFfVjwb
         VrJsyxJwL1clQ==
Date:   Mon, 19 Jun 2023 14:03:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20230619140330.28437ac3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P2ovrU.PT44xPxmwCi3HdIE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P2ovrU.PT44xPxmwCi3HdIE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/slab_common.c

between commits:

  fef594ee7142 ("mm/slab: simplify create_kmalloc_cache() args and make it =
static")
  6e6f174b6eda ("mm/slab: limit kmalloc() minimum alignment to dma_get_cach=
e_alignment()")

from the mm tree and commit:

  d5bf48574699 ("mm/slab_common: use SLAB_NO_MERGE instead of negative refc=
ount")

from the slab tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/slab_common.c
index 43c008165f56,90ecaface410..000000000000
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@@ -892,24 -876,17 +890,24 @@@ new_kmalloc_cache(int idx, enum kmalloc
  		flags |=3D SLAB_CACHE_DMA;
  	}
 =20
 +	if (minalign > ARCH_KMALLOC_MINALIGN) {
 +		aligned_size =3D ALIGN(aligned_size, minalign);
 +		aligned_idx =3D __kmalloc_index(aligned_size, false);
 +	}
 +
+ 	/*
+ 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
+ 	 * KMALLOC_NORMAL caches.
+ 	 */
+ 	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type =3D=3D KMALLOC_NORMAL))
+ 		flags |=3D SLAB_NO_MERGE;
+=20
 -	kmalloc_caches[type][idx] =3D create_kmalloc_cache(
 -					kmalloc_info[idx].name[type],
 -					kmalloc_info[idx].size, flags, 0,
 -					kmalloc_info[idx].size);
 +	if (!kmalloc_caches[type][aligned_idx])
 +		kmalloc_caches[type][aligned_idx] =3D create_kmalloc_cache(
 +					kmalloc_info[aligned_idx].name[type],
 +					aligned_size, flags);
 +	if (idx !=3D aligned_idx)
 +		kmalloc_caches[type][idx] =3D kmalloc_caches[type][aligned_idx];
-=20
- 	/*
- 	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
- 	 * KMALLOC_NORMAL caches.
- 	 */
- 	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type =3D=3D KMALLOC_NORMAL))
- 		kmalloc_caches[type][idx]->refcount =3D -1;
  }
 =20
  /*

--Sig_/P2ovrU.PT44xPxmwCi3HdIE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSP05IACgkQAVBC80lX
0Gy5xggAhp9cBxE8LgtT4OOc7WzPGHTC8VJo0BzFwoTKajrY13vID48gbCLxvCqs
ARm3L/mTpE6x/CnmONkqcj8+69wuMweo1Q/PCwQj9Jko3AL7/xRi3S1WEi7NEyGd
XsqRGCYWPrByN70Xj7JI4nuX0Z0HlpEiLCoKieR672jKs3Qx52IGIy+Fu79THk5C
I79ozx9QptBHEScdKrkxISO1f4Mls1ROo59RwEshfTxKMjbpCUXdUfmVaeCW6fM9
K9lTWi7eDN/ZSVEtAh6T/WrshLSsTj2k6yqQE6QPISxyJZUtbwRF634LCYCFBFvU
71qoLyjOEShQgVEhYHGPCcwSTr45og==
=Rfgw
-----END PGP SIGNATURE-----

--Sig_/P2ovrU.PT44xPxmwCi3HdIE--
