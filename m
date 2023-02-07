Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4BC68CB73
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBGAvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBGAvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:51:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9FB25289;
        Mon,  6 Feb 2023 16:51:20 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P9l1Z3cThz4x2c;
        Tue,  7 Feb 2023 11:51:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675731076;
        bh=Q4yn72gt58aznzYjQqkKTeYozF01rntmCupjrSi80uI=;
        h=Date:From:To:Cc:Subject:From;
        b=bHsqhcOc20UB87Ze1uC/fp4L7L9aSjeN9zzQCbvNOMnip5US1zTsOJy4IbYNT6UhL
         zRYuaMEXLAfO1fzXUlbijivOYAhUClcKEuQvFiWV8BPW7MP4KnQKZwx2w2Hn5oFO+X
         x220ILHVwvqihfgypqBFbnJiJnjCbXTz9tdH33TRNBXjwqArbtI2vXAy1N7wJQkOvt
         8ZgDD9TuALVsKw9qo3zo2TIULdYJ8r7m7yGU3YcYKyFl1sHU/p3ojC2a9AaB1o0/Wo
         ABAV6ethQ9GSrgFzrwE/u2GHVh0bRxtd+cR0LmhNdRmlugB1J4yXZoaTe1qPCgA5kz
         aVWDvZHSFwBFw==
Date:   Tue, 7 Feb 2023 11:51:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Seth Forshee <sforshee@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the integrity tree
Message-ID: <20230207115113.21efd917@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jWyH6pgvBNX_.ulFhqJ.PNw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jWyH6pgvBNX_.ulFhqJ.PNw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the integrity tree, today's linux-next build (x86_64
allmodconfig) failed like this:

security/integrity/ima/ima_main.c: In function 'ima_file_mprotect':
security/integrity/ima/ima_main.c:473:34: error: implicit declaration of fu=
nction 'file_mnt_user_ns'; did you mean 'get_user_ns'? [-Werror=3Dimplicit-=
function-declaration]
  473 |         action |=3D ima_get_action(file_mnt_user_ns(vma->vm_file), =
inode,
      |                                  ^~~~~~~~~~~~~~~~
      |                                  get_user_ns
security/integrity/ima/ima_main.c:473:34: error: passing argument 1 of 'ima=
_get_action' makes pointer from integer without a cast [-Werror=3Dint-conve=
rsion]
  473 |         action |=3D ima_get_action(file_mnt_user_ns(vma->vm_file), =
inode,
      |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                  |
      |                                  int
In file included from security/integrity/ima/ima_main.c:30:
security/integrity/ima/ima.h:258:38: note: expected 'struct mnt_idmap *' bu=
t argument is of type 'int'
  258 | int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
      |                    ~~~~~~~~~~~~~~~~~~^~~~~
cc1: all warnings being treated as errors

Caused by commit

  4958db3245fa ("ima: Introduce MMAP_CHECK_REQPROT hook")

interacting with commit

  39f60c1ccee7 ("fs: port xattr to mnt_idmap")

from the vfs-idmapping tree.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 7 Feb 2023 11:31:16 +1100
Subject: [PATCH] fixup for "ima: Introduce MMAP_CHECK_REQPROT hook"

interacting with "fs: port xattr to mnt_idmap"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index 7a05af9f481f..d66a0a36415e 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -470,7 +470,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsig=
ned long prot)
 	action =3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
 				&pcr, &template, NULL, NULL);
-	action |=3D ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
+	action |=3D ima_get_action(file_mnt_idmap(vma->vm_file), inode,
 				 current_cred(), secid, MAY_EXEC,
 				 MMAP_CHECK_REQPROT, &pcr, &template, NULL,
 				 NULL);
--=20
2.35.1
x
--=20
Cheers,
Stephen Rothwell

--Sig_/jWyH6pgvBNX_.ulFhqJ.PNw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPhoIEACgkQAVBC80lX
0Gwb2wgAgUWiS/0BoiZOyvsJIeJ5sR3U9xkuvqL9P1WpP0jd5UYv35pSOhVXV1Yi
Mw/wB8PGrcYEG9g+5vjEKGPiDkEWNd6QuvRXAnTL2cbZ3niEm3YAOKGvvIfv7069
X07UhKugLEw/hGsRKyJWxycGopTzDgTEuWu6Xb9tANTM9lVBtApjt+slwxgGlVbM
mlrasB6b2C7XhrOhfGQj3K4KsYjDsHrgmagcawFOUBrw+e040Uc4ktXy4/D8z6bw
4A6rpSb2uJbW0C/Ahgb0UKt8FAtof62nUgZYX8nrut/N0gQypmierMf38yHos1gQ
XUox5+X30nW7k0k5toFsacpbW7sj3g==
=+Jzj
-----END PGP SIGNATURE-----

--Sig_/jWyH6pgvBNX_.ulFhqJ.PNw--
