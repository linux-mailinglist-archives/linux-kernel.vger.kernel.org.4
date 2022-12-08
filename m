Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E86466A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLHBrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLHBrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:47:03 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D22E020;
        Wed,  7 Dec 2022 17:47:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSH801Qhdz4xGR;
        Thu,  8 Dec 2022 12:46:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670464016;
        bh=BrcZjgFnCX4I+Yu3flH1nq1Ho9Y5wmemxz6VeoaM0Ug=;
        h=Date:From:To:Cc:Subject:From;
        b=FfmFtRspk7xuUJXzygVfWpKb4hV9eqY3GDBYDUldJShBIg995rDRXKeHctdPlZh3d
         nO0ak4iIUl921x5SG+xS8cKmxnnjQZ+t8CP3IO/nvtff1mT1cz2ZrS1IY/B1w5KdXC
         Jws3cDx9BInfn+wf5WOpQ5qvdU/TFeS92aoBzLsEDVnIUuxBNRjjhKdndqKoYs+isy
         GzizMA1jbVPAeayPUiSrZcHjmeTHokPnuEpvEjCG1MUlcRuGlimaQHSew22CLbZ70y
         beDqek4TBYWDewVLvLi7RFzmWZphYFOLLlRqmC+wYzAjo0Oi5/2ZuaGogwm06pOMLO
         K2bDPUAMMdzpw==
Date:   Thu, 8 Dec 2022 12:46:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
Subject: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Message-ID: <20221208124653.71ba9491@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q+BBA6cEB4yIN0ghvRN3GVl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q+BBA6cEB4yIN0ghvRN3GVl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  security/apparmor/policy_unpack_test.c

between commits:

  371e50a0b19f ("apparmor: make unpack_array return a trianary value")
  32490541682b ("apparmor: Fix kunit test for out of bounds array")

from the apparmor tree and commit:

  2c92044683f5 ("apparmor: test: make static symbols visible during kunit t=
esting")

from the kunit-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/policy_unpack_test.c
index 7465da42492d,f25cf2a023d5..000000000000
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@@ -144,8 -147,8 +147,8 @@@ static void policy_unpack_test_unpack_a
 =20
  	puf->e->pos +=3D TEST_ARRAY_BUF_OFFSET;
 =20
- 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, NULL, &array_size),
 -	array_size =3D aa_unpack_array(puf->e, NULL);
 -
++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, NULL, &array_size),
 +			TRI_TRUE);
  	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
  	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
  		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
@@@ -159,8 -162,8 +162,8 @@@ static void policy_unpack_test_unpack_a
 =20
  	puf->e->pos +=3D TEST_NAMED_ARRAY_BUF_OFFSET;
 =20
- 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
 -	array_size =3D aa_unpack_array(puf->e, name);
 -
++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
 +			TRI_TRUE);
  	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
  	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
  		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
@@@ -175,8 -178,9 +178,8 @@@ static void policy_unpack_test_unpack_a
  	puf->e->pos +=3D TEST_NAMED_ARRAY_BUF_OFFSET;
  	puf->e->end =3D puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
 =20
- 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
 -	array_size =3D aa_unpack_array(puf->e, name);
 -
 -	KUNIT_EXPECT_EQ(test, array_size, 0);
++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
 +			TRI_FALSE);
  	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
  		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
  }

--Sig_/Q+BBA6cEB4yIN0ghvRN3GVl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmORQg0ACgkQAVBC80lX
0GzV5gf+JTwzJNKW1cEuJuCkTEF5EPMN1qLpObPKX4OORf6uX8LcICq9mTae/DVy
ijV+ef8vgI8pn2O40cZWaNDUOjXc1BUxVOeBO8/Qp8KR4svA8H194lwMbVPQcUvN
/b/YbNoAuakj+VwFXY8RQGjAYIDBFP2Ke5LL+dRVEZAATdjReAWA8y19r2h0oYAV
RL5mDy7unZ61QOuW+wMLQy3/N11i/GwnfYlL05yjLNhYR7csOMZPFhJiAN431dYF
zSMxXeGQ54g0nkSU9AuUVHIfztnh58hM1ZC704R2r+wEjy1nwYGa/T8IXxpj3mjL
QIKdIG55mSFw/nA4fHQy4bHMaDgD7Q==
=O70J
-----END PGP SIGNATURE-----

--Sig_/Q+BBA6cEB4yIN0ghvRN3GVl--
