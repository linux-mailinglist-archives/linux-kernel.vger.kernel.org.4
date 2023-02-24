Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7E6A2524
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBXXkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXXkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:40:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AF46C538;
        Fri, 24 Feb 2023 15:39:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNmZx1LwXz4x7x;
        Sat, 25 Feb 2023 10:39:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677281993;
        bh=J33anLQ3zeSlAfgefkR5AYUaacZGuGp4hDY6Jfy0VbM=;
        h=Date:From:To:Cc:Subject:From;
        b=Fb2lD3OtBIw7NApDOPpCr6UtFI8YSo0cfI2hMNWLX5vKLp1HMjj/ME6P/lGkr6IWn
         Ilza0wARKbXdaWMqDaUAt9Zr2lUOrgNHlaufZ0jUo8LiYoXWYyOIyeSAaRR118rwBB
         UK70kTE6f9Ndj/4yeoNR4zvuVxOY2mkehM1cRCGFET9z1Iw2tQv5CE1EkCt/iAQAGX
         MYCQHUsWKM5o8zH/WE9hlJaFwNEoqoTYXJMJe3P+11xiA12ATxkSeWHavA0QQXpm1o
         T9NRT/91j6GCRDElKM6/lR+s2XEsN300AnKlRH4y22RHS4nqwxmjs86tTricZYT74g
         ynGrA4wc9sSNA==
Date:   Sat, 25 Feb 2023 10:39:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230225103951.59997ec3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MZqmxnVacH3.4FUyz9MheQU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MZqmxnVacH3.4FUyz9MheQU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/shmem.c

between commit:

  7a80e5b8c6fa ("shmem: support idmapped mounts for tmpfs")

from Linus' tree and commit:

  9323c8b93d95 ("mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/shmem.c
index 448f393d8ab2,31bd5e1f9faa..000000000000
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@@ -2344,9 -2347,120 +2347,121 @@@ static void shmem_set_inode_flags(struc
  #define shmem_initxattrs NULL
  #endif
 =20
+ static void shmem_isolate_pages_range(struct address_space *mapping, loff=
_t start,
+ 				loff_t end, struct list_head *list)
+ {
+ 	XA_STATE(xas, &mapping->i_pages, start);
+ 	struct folio *folio;
+=20
+ 	rcu_read_lock();
+ 	xas_for_each(&xas, folio, end) {
+ 		if (xas_retry(&xas, folio))
+ 			continue;
+ 		if (xa_is_value(folio))
+ 			continue;
+=20
+ 		if (!folio_try_get(folio))
+ 			continue;
+ 		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
+ 				folio_isolate_lru(folio)) {
+ 			folio_put(folio);
+ 			continue;
+ 		}
+ 		folio_put(folio);
+=20
+ 		/*
+ 		 * Prepare the folios to be passed to reclaim_pages().
+ 		 * VM can't reclaim a folio unless young bit is
+ 		 * cleared in its flags.
+ 		 */
+ 		folio_clear_referenced(folio);
+ 		folio_test_clear_young(folio);
+ 		list_add(&folio->lru, list);
+ 		if (need_resched()) {
+ 			xas_pause(&xas);
+ 			cond_resched_rcu();
+ 		}
+ 	}
+ 	rcu_read_unlock();
+ }
+=20
+ static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t s=
tart,
+ 				loff_t end)
+ {
+ 	LIST_HEAD(folio_list);
+=20
+ 	if (!total_swap_pages || mapping_unevictable(mapping))
+ 		return 0;
+=20
+ 	lru_add_drain();
+ 	shmem_isolate_pages_range(mapping, start, end, &folio_list);
+ 	reclaim_pages(&folio_list);
+=20
+ 	return 0;
+ }
+=20
+ static int shmem_fadvise_willneed(struct address_space *mapping,
+ 				 pgoff_t start, pgoff_t long end)
+ {
+ 	struct folio *folio;
+ 	pgoff_t index;
+=20
+ 	xa_for_each_range(&mapping->i_pages, index, folio, start, end) {
+ 		if (!xa_is_value(folio))
+ 			continue;
+ 		folio =3D shmem_read_folio(mapping, index);
+ 		if (!IS_ERR(folio))
+ 			folio_put(folio);
+ 	}
+=20
+ 	return 0;
+ }
+=20
+ static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, in=
t advice)
+ {
+ 	loff_t endbyte;
+ 	pgoff_t start_index;
+ 	pgoff_t end_index;
+ 	struct address_space *mapping;
+ 	struct inode *inode =3D file_inode(file);
+ 	int ret =3D 0;
+=20
+ 	if (S_ISFIFO(inode->i_mode))
+ 		return -ESPIPE;
+=20
+ 	mapping =3D file->f_mapping;
+ 	if (!mapping || len < 0 || !shmem_mapping(mapping))
+ 		return -EINVAL;
+=20
+ 	endbyte =3D fadvise_calc_endbyte(offset, len);
+=20
+ 	start_index =3D offset >> PAGE_SHIFT;
+ 	end_index   =3D endbyte >> PAGE_SHIFT;
+ 	switch (advice) {
+ 	case POSIX_FADV_DONTNEED:
+ 		ret =3D shmem_fadvise_dontneed(mapping, start_index, end_index);
+ 		break;
+ 	case POSIX_FADV_WILLNEED:
+ 		ret =3D shmem_fadvise_willneed(mapping, start_index, end_index);
+ 		break;
+ 	case POSIX_FADV_NORMAL:
+ 	case POSIX_FADV_RANDOM:
+ 	case POSIX_FADV_SEQUENTIAL:
+ 	case POSIX_FADV_NOREUSE:
+ 		/*
+ 		 * No bad return value, but ignore advice.
+ 		 */
+ 		break;
+ 	default:
+ 		return -EINVAL;
+ 	}
+=20
+ 	return ret;
+ }
+=20
 -static struct inode *shmem_get_inode(struct super_block *sb, struct inode=
 *dir,
 -				     umode_t mode, dev_t dev, unsigned long flags)
 +static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct supe=
r_block *sb,
 +				     struct inode *dir, umode_t mode, dev_t dev,
 +				     unsigned long flags)
  {
  	struct inode *inode;
  	struct shmem_inode_info *info;

--Sig_/MZqmxnVacH3.4FUyz9MheQU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP5SscACgkQAVBC80lX
0GxXHwgAgMWsrptuK+yFLkvLSLlJuh/vyJM7q+Xbw20Zt3BhsM/7hX46G+pq5Dck
C+czgYBzKw+zRbrBe7NazfH9Na8PoJ7OtDZBcoiQSDbgT2baVByXRLvVvxTEPoOg
W24sqHuO4MLlHuq/LplN7wd3p9ocz3WUmfcXNPdaEHS5xtmM7LdHoWHVIQ7Yij01
1fwc2C1wMSnVL1LW6rUXDT41rbEy50GTweIV1318Jzku10Xz108syAwa/apD0DNj
9a38/u40OhVGuL5U62J0GKm+GPoBTpLTvkOYfSZgyPpbpMnexWgAFYLEQXaCjXri
l4OYE7Snsv/2CqQfXsPSvBJjA9aA7A==
=v57b
-----END PGP SIGNATURE-----

--Sig_/MZqmxnVacH3.4FUyz9MheQU--
