Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078B56B8797
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCNB3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCNB3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:29:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4A7D55A;
        Mon, 13 Mar 2023 18:29:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PbGCR3TP7z4x5R;
        Tue, 14 Mar 2023 12:29:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678757363;
        bh=pkeAL5uiJUZSa/Hb44Za8UEvU/rv7ezU/yxwnLIUkbo=;
        h=Date:From:To:Cc:Subject:From;
        b=QPANtbEePEiDze008lpeZxMjK8tHyHBVVQMRyoi9Fc2VBHy1VT4lhbYtL+Uc6q55m
         gn3UOCdUwf9DB8TSBJeJxhvC96IN2e58hGBbrssmPAH+O1tcGfGVM7wJsoZ3n5wzlM
         Q3iQJVZntngengSHtHJ4eAwoC2zXoyy1rGxn46C6H9BL2KhfEG1/TLOjEJQGouIpCa
         18rWQrlhx3CbRDxCB2Nq5zPbpr/HE9rZ2gBeGl6J/uMXo8hbkOkbupugYA7hLRzZm2
         h8gOniRgvOxFovAjJIZS1tqPnRmDUjoeqjpSil+i8ZdPBoAloq+11nIrHRbNzfoy8R
         s1VGwjOLoddzQ==
Date:   Tue, 14 Mar 2023 12:29:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20230314122922.43c81767@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ys8XndELzEG0bHZWgwmL/f5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ys8XndELzEG0bHZWgwmL/f5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

net/mac802154/scan.c: In function 'mac802154_scan_cleanup_locked':
net/mac802154/scan.c:55:26: error: macro "kfree_rcu" requires 2 arguments, =
but only 1 given
   55 |         kfree_rcu(request);
      |                          ^
In file included from include/linux/rbtree.h:24,
                 from include/linux/mm_types.h:11,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from net/mac802154/scan.c:11:
include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
  984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
      |=20
net/mac802154/scan.c:55:9: error: 'kfree_rcu' undeclared (first use in this=
 function); did you mean 'kfree_skb'?
   55 |         kfree_rcu(request);
      |         ^~~~~~~~~
      |         kfree_skb
net/mac802154/scan.c:55:9: note: each undeclared identifier is reported onl=
y once for each function it appears in
net/mac802154/scan.c: In function 'mac802154_stop_beacons_locked':
net/mac802154/scan.c:406:26: error: macro "kfree_rcu" requires 2 arguments,=
 but only 1 given
  406 |         kfree_rcu(request);
      |                          ^
include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
  984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
      |=20
net/mac802154/scan.c:406:9: error: 'kfree_rcu' undeclared (first use in thi=
s function); did you mean 'kfree_skb'?
  406 |         kfree_rcu(request);
      |         ^~~~~~~~~
      |         kfree_skb
drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_dereg_mr':
drivers/infiniband/sw/rxe/rxe_mr.c:734:21: error: macro "kfree_rcu" require=
s 2 arguments, but only 1 given
  734 |         kfree_rcu(mr);
      |                     ^
In file included from include/linux/rculist.h:11,
                 from include/linux/dcache.h:8,
                 from include/linux/fs.h:8,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/bio.h:10,
                 from include/linux/libnvdimm.h:14,
                 from drivers/infiniband/sw/rxe/rxe_mr.c:7:
include/linux/rcupdate.h:984: note: macro "kfree_rcu" defined here
  984 | #define kfree_rcu(ptr, rhf) kvfree_rcu_arg_2(ptr, rhf)
      |=20
drivers/infiniband/sw/rxe/rxe_mr.c:734:9: error: 'kfree_rcu' undeclared (fi=
rst use in this function); did you mean 'kfree_skb'?
  734 |         kfree_rcu(mr);
      |         ^~~~~~~~~
      |         kfree_skb
drivers/infiniband/sw/rxe/rxe_mr.c:734:9: note: each undeclared identifier =
is reported only once for each function it appears in

Caused by commit

  62a2ac23b35f ("rcu/kvfree: Eliminate k[v]free_rcu() single argument macro=
")

I have used the rcu tree from next-20230310 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ys8XndELzEG0bHZWgwmL/f5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQPzfIACgkQAVBC80lX
0GxoSQf/ZltNEVi31JVQsszCeaXEdT6AJBuLDTBR5ydFFsr5VxOhdXZNzRvxDtA1
n2S/ipCDp7F34AF747eaQIRwcyY1wbRdYdsIba8dmp+XIRX9zw6od+Qwt2PYyMcS
b/BFqW2feNOkAeT6b58IIqEclxCWNAq4OGtcIEZXChtFoXriUkgqfNQhzdPLb61I
YE9L8WxzoLFvtLbJa41B1bQioNsBFlYaUO3+p/ItcBNbtnCHaM3OU+JH237yuEtT
xtL0uok78Y+LW1g3MQolee1DF6E7+aufhmm1B0brQ2jIP1RP71HPiItOGeRdzlNu
oj7izVh+PCgvFF3R6Ds2Nbv2jjd2jw==
=7tRl
-----END PGP SIGNATURE-----

--Sig_/ys8XndELzEG0bHZWgwmL/f5--
