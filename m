Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E645F5D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJEX7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:59:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BBD13F;
        Wed,  5 Oct 2022 16:59:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MjWkq57tCz4xGR;
        Thu,  6 Oct 2022 10:59:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665014355;
        bh=ZiP+7X6vJOlOtas5bfBwJ9czNkaHQb78pfGJ/b1jMhc=;
        h=Date:From:To:Cc:Subject:From;
        b=SC3qBkpUrpbdb3wr50Ir7Ci2d8BnRrj7DuceHnAnVzgtETVEMpwl04WjUroruq83c
         mfqAhbdcmePZH18mwuLNGm56ivG6HohNQlJdpkbyFv0NHfF896Q5eBDPp6Sbp/tvg+
         Si5EG7OGZyv625XcSZtb/zDOc7RIWC9gjGhFGULcJYTvJ/PX/yBGluJnKcPrQCP6xz
         Fu4jcyQwsrPzn1u6N5xCeA6pdVmnZ70O3BoADGyI99y3uO1z9mdNyPU4SmrAoorG9S
         SdZ5baQ8O2kNByk+5NomyXtyELTM4Rx76HQO3zcmWRMlcqH4m7hW3e566TWZdgIun9
         w3lAAFbW3Gt+w==
Date:   Thu, 6 Oct 2022 10:59:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Steve French <smfrench@gmail.com>
Cc:     Atte =?UTF-8?B?SGVpa2tpbMOk?= <atteh.mailbox@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the vfs tree with the ksmbd tree
Message-ID: <20221006105913.5be8a631@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mAqK48flFuwYx5jEjaycAW4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mAqK48flFuwYx5jEjaycAW4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/ksmbd/vfs.c

between commit:

  dbab80e2071a ("ksmbd: make utf-8 file name comparison work in __caseless_=
lookup()")

from the ksmbd tree and commit:

  25885a35a720 ("Change calling conventions for filldir_t")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ksmbd/vfs.c
index 8d8af724df70,48b2b901f6e5..000000000000
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@@ -1150,23 -1149,13 +1148,23 @@@ static bool __caseless_lookup(struct di
  	buf =3D container_of(ctx, struct ksmbd_readdir_data, ctx);
 =20
  	if (buf->used !=3D namlen)
- 		return 0;
+ 		return true;
 -	if (!strncasecmp((char *)buf->private, name, namlen)) {
 +	if (IS_ENABLED(CONFIG_UNICODE) && buf->um) {
 +		const struct qstr q_buf =3D {.name =3D buf->private,
 +					   .len =3D buf->used};
 +		const struct qstr q_name =3D {.name =3D name,
 +					    .len =3D namlen};
 +
 +		cmp =3D utf8_strncasecmp(buf->um, &q_buf, &q_name);
 +	}
 +	if (cmp < 0)
 +		cmp =3D strncasecmp((char *)buf->private, name, namlen);
 +	if (!cmp) {
  		memcpy((char *)buf->private, name, namlen);
  		buf->dirent_count =3D 1;
- 		return -EEXIST;
+ 		return false;
  	}
- 	return 0;
+ 	return true;
  }
 =20
  /**

--Sig_/mAqK48flFuwYx5jEjaycAW4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM+GlEACgkQAVBC80lX
0Gwp4ggAhhaWNI6+8iGakKPf3dwk7a9OHhr+symb2j79dlZxdKsAoBd+yAzVsSu4
QnBfXN9HjbObQbNRzmHcgW29P7zAO5niv31PTn2tdo5H23C2FTDMAa7OmWBgMiw8
fUnC3v3VGZ/dFTk+tS5i3C7qvuDo6FOWx0z+mBkTJpmprcG5jB8zuOnXAMLp54o3
tJVmZWmG3DVa03UJHPRqs441LF28K8/QsF+nVAKFp9KFDE+nQSxNNTgFZPaLKGl7
js8hXFsj6U7SbQ39sg+FVYhIw9c27qCAYYr3ZCOd62WSHa+5cMylzKlZQuN+29zq
rMJ1h4jVJ4hk1FjwESZkpKf6iM5cJA==
=K+4k
-----END PGP SIGNATURE-----

--Sig_/mAqK48flFuwYx5jEjaycAW4--
