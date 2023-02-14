Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B0695526
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 01:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBNAFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 19:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjBNAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 19:05:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B672A974E;
        Mon, 13 Feb 2023 16:05:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG1gQ1N2Qz4x4q;
        Tue, 14 Feb 2023 11:05:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676333122;
        bh=CAzSLDb1dEbfnAtFmlA4dMrg04aRPe2Txx15eZN3dho=;
        h=Date:From:To:Cc:Subject:From;
        b=Xr1i8k3oBTZ/5Pqc6KY0CKqYw6LZyBYLX+8RnitJYdvMsMhKlmR+wmfGruokDjLBN
         oGjjRoJhBxkMd8+PcQTMrVLr7PeczeOph2t8tsl5YK4ES5jU8XnlW1Xl3BWmUnlbbR
         n1bITYE1TZnxne270aV+7aveDBtrdId5ntM64X8n9DqIta0WCrue8HgTu5MyxY3g7Y
         OmtkURPc8KQRwXFk/O8Tl13wPGIW/Hq034e46K/kBZYs34bEVFqcZ48IIL/e/JL0nM
         qIjlm7XqUtVPBSxEksZtcJLWgHdz9ZiXgGmIXAKKgK/nHqqg/klhOj8lxYgCO9b3ki
         LIEFydIxCmiQQ==
Date:   Tue, 14 Feb 2023 11:05:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the device-mapper tree with the crypto
 tree
Message-ID: <20230214110521.77685fbb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/scfy7q3Wnh0HpAradU4zis/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/scfy7q3Wnh0HpAradU4zis/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  drivers/md/dm-integrity.c

between commits:

  96747228b725 ("dm: Add scaffolding to change completion function signatur=
e")
  dcfe653d7cd4 ("dm: Remove completion function scaffolding")

from the crypto tree and commit:

  ff65cea88e49 ("dm: add missing empty lines")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/md/dm-integrity.c
index c58156deb2b1,16aa68988363..000000000000
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@@ -955,9 -963,10 +963,10 @@@ static void xor_journal(struct dm_integ
  	async_tx_issue_pending_all();
  }
 =20
 -static void complete_journal_encrypt(struct crypto_async_request *req, in=
t err)
 +static void complete_journal_encrypt(void *data, int err)
  {
 -	struct journal_completion *comp =3D req->data;
 +	struct journal_completion *comp =3D data;
+=20
  	if (unlikely(err)) {
  		if (likely(err =3D=3D -EINPROGRESS)) {
  			complete(&comp->ic->crypto_backoff);

--Sig_/scfy7q3Wnh0HpAradU4zis/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPq0EEACgkQAVBC80lX
0GyJhwf/b0C84ZSrgtO04M3b2so/ej0poAKhCwioIKKpMwf165A5pu5D4AF/mbwX
VvXHgkosV7goOrTIycLxN4RX71qGQnAeSKWAW6XTFgkLG4XR6ZymruLj/wWdRPi3
20WreD2Uo/CnncB6xnzntgm8wW45/xogBKEvW6A8KtDb05r6dHIeqJJgq7OGrVjX
GJ72fHBbhqrbxtJ4hGtC1DAtGAFVSJ2vDxrImD1D7Sz/fv/dWzmHbbuIyccxT677
rn7U2WZt2Cgi5SnMYqq6Pn0ysK329AT+dW0jWXxRM97fsMPTMW0agmjPHly1VXgc
iPrrJqatYNak9beEtQ+Wnz9w0HB5uw==
=7B8D
-----END PGP SIGNATURE-----

--Sig_/scfy7q3Wnh0HpAradU4zis/--
