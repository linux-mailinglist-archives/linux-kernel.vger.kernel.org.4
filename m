Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8967DABB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjA0A0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA0A0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:26:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E0346AC;
        Thu, 26 Jan 2023 16:26:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2z0K0Xv5z4x1T;
        Fri, 27 Jan 2023 11:26:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674779202;
        bh=7W+o3SEh8LHcXFVjlnNFe6JICjd6gXkmn5eBv3655gM=;
        h=Date:From:To:Cc:Subject:From;
        b=kVUFknaDpgsjZ0ef2fehvMHHneAyY0P2FGAmR68odPyizhHhahJyXUugiufPxHh8/
         Rk6KMHgPOXKiDtmCoKuShvyBdivQkjZ4Ed3Qe4YzqU3US9FHvWL/SDfeaUB1qlYmzk
         ebmMvVJ7P3zQZoEOSv/zhsS6OjqjRF2ToKU7kMf3P1JFT++LFueprEzKjt+ODucnqJ
         X7m6T0UtSGn6rVgwhbwKmYgZV+HPO4FB3jHHaxn0Kh6pv1Zk9AGej1/jENzmdyKLOm
         pEBAf7LczL49B8GDLktl2CrP3J4xhiA7zwau8tyokB8N3MI9kccFSDK78CQx7CRyC8
         kaknKE/IkIfEw==
Date:   Fri, 27 Jan 2023 11:26:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: linux-next: manual merge of the file-locks tree with the fuse tree
Message-ID: <20230127112640.6f55e705@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xrKXj_7XRnL1G3rt_ORqcTo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xrKXj_7XRnL1G3rt_ORqcTo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the file-locks tree got a conflict in:

  fs/fuse/file.c

between commit:

  5a8bee63b10f ("fuse: in fuse_flush only wait if someone wants the return =
code")

from the fuse tree and commit:

  5970e15dbcfe ("filelock: move file locking definitions to separate header=
 file")

from the file-locks tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/fuse/file.c
index 5a98cf915bd3,1458412f2492..000000000000
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@@ -18,7 -18,7 +18,8 @@@
  #include <linux/falloc.h>
  #include <linux/uio.h>
  #include <linux/fs.h>
 +#include <linux/file.h>
+ #include <linux/filelock.h>
 =20
  static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
  			  unsigned int open_flags, int opcode,

--Sig_/xrKXj_7XRnL1G3rt_ORqcTo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPTGkAACgkQAVBC80lX
0GwVvwf/RQTyhZ2zmKUQnyCriqbQ1CReN38H57nh1c9LkjP62NY58J2CjwcdHvpl
9XItdqim4NfBv4jkfbMAg+LLrOoYDuS8ENrUfkpNtnVYXKchAy68z4pTtmLcS3wW
97f8QXA4lJrXufn1m1FCB7BVAWkqY2mIotpjK2rKpu5iARNUOewMlUNav81ijmhJ
s9gCTwFcXOwhBCxItRbiNphZZPCII5J3rt8xLhFb4h39PHsN3iO1cny5BdkqeMNA
nOcVQ0I7H6FO5dzI8IzJNsGN0nv2eKu7FOyAxJf725IcT1hmZ+0LHAEQURksVNXm
OKHlvznR6HkVNrZbghJldHPs/nr39w==
=NQZg
-----END PGP SIGNATURE-----

--Sig_/xrKXj_7XRnL1G3rt_ORqcTo--
