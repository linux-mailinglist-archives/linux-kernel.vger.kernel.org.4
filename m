Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEF6687E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjALXhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjALXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:37:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53DFCE8;
        Thu, 12 Jan 2023 15:37:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NtLYN0m6Jz4x1R;
        Fri, 13 Jan 2023 10:36:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673566616;
        bh=RfGbf/SAguFvw42S/oWzarA1FRdM4Ya2Ur1Vj+FDe+8=;
        h=Date:From:To:Cc:Subject:From;
        b=oT9q9QSrSP5+RFbYcrf2xRpqZ4uf8PeBIf5WkxqtwX2dOKVUL8EfGVdhWXu99wjla
         lGEbh3r4eb769Zt135KYgnmw/NSAdiXtcbUsskdvBWz3YeB49ti/zovgZbjzbSg5As
         6aVDT3OeuNQ9RqkBghXKtuuCdrQv0m9VvcQeDC9RXJ/5vuSz4fE/mo6x4VC7ed8MkE
         qQ1BT08jIXA/gjD74GQcMbBufw69EN1vvuQkhIBrvjJYPRDDfE8drCSgbRlhtiDqO3
         /N+iOAYTAcmA6aznl56DpDssDOk7I8bCEPHid1cfe3DbzM3bgwSBD5wlejs9HcrPmX
         xeyKFGMAzZUaw==
Date:   Fri, 13 Jan 2023 10:36:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the btrfs tree
Message-ID: <20230113103654.5cbc1d54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WgQeCgdymxyNKSpH4wF288s";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WgQeCgdymxyNKSpH4wF288s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

fs/btrfs/disk-io.c: In function 'btrfs_init_fs_root':
fs/btrfs/disk-io.c:1531:22: warning: unused variable 'nofs_flag' [-Wunused-=
variable]
 1531 |         unsigned int nofs_flag;
      |                      ^~~~~~~~~

Caused by commit

  1556cd3d099a ("btrfs: locking: use atomic for DREW lock writers")

I have used the btrfs tree from next-20230112 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/WgQeCgdymxyNKSpH4wF288s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPAmZcACgkQAVBC80lX
0Gw+Bgf/f31vqhlOCL84m71We2covOd4wR0wZ8etWd9YZvsYOTLu3A0vEHJH7bbE
1eH6o8FPyEYjBmLiQl8Lq++BWZTaZLc9MyM88QkGQ4xbyewtsjhx7C3V5xsoumi0
cKc4JBtfR6fx9vMrkF0NzLfO3/UNsgyAOJ1huj9QTpOsTMRihcq12ad8VdIvlTjS
dyy3KaoIExfzx5eWS0F2rLt+OxwBmtvxSkyxaHq/yBnYF+//THuStBiYlMft9Ksz
+fMRK3pHVQ2ukovAfkQuE7FRr/YFVtivrIRBe4Y7/yuX6sSux2WOJlbQLzxuajH3
DWTTqzbpG1qS7B5tHGCGiSVtppx+cg==
=C5Bn
-----END PGP SIGNATURE-----

--Sig_/WgQeCgdymxyNKSpH4wF288s--
