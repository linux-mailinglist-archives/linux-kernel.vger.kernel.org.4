Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27493672675
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjARSOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjARSOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:14:47 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DC53A9C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:14:46 -0800 (PST)
Date:   Wed, 18 Jan 2023 18:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1674065684; x=1674324884;
        bh=6IvJXSVCAaTVN5zBpjbXw6aPUMZ1WI+M2fxhC/cShMU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ErPARWtsyqeFEFumrKFhwbJ2UTL4TfHQjSbb3XjydlL5sEIDnaNHhdneo258YApkJ
         uDoFqZpIlX9m96lhsHagOT8WEiHfTN9Lguj025Nwv1YjX6y5p7biYI/r9ZBn/r7OND
         ltZdeja0FF19kvnklrmiW61PXlTy5zEZ/X2eQhW3M9a+nVeBmG4gIuoelDZcIAyAw3
         te/Pj5WXqp+Ye2LzdmlPwX96globyJ8+w1sW2uJoCBhPagBah3g2fwrYiXfs2x6EbE
         3lhTqzxfOGfeEMdVHhiIRx3uf0RgL5xV/PkQY9sFDvhz8vTBlpH0dFlfU48rf2TjML
         tnmIgYeBmx2aw==
To:     Denis Kenzior <denkenz@gmail.com>
From:   Michael Yartys <michael.yartys@protonmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Berger <stefanb@linux.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: asymmetric: Fix ECDSA use via keyctl uapi
Message-ID: <-ZV1wRa2DQG_0s2MX9cYRQNRaxkwZkJAf5bqQQwjSy8pATVdr0oiYAwPGvKvdppGozE1qI2wiPNRbHMWEX8Xup2fzN3KULMvYXTASXSlfoI=@protonmail.com>
In-Reply-To: <20220826145119.9375-1-denkenz@gmail.com>
References: <20220826145119.9375-1-denkenz@gmail.com>
Feedback-ID: 6588689:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

What's the hold-up with this patch? I would really appreciate if someone co=
uld take a look at it and move it along to finally enable iwd to connect to=
 networks using ECDSA certificates (my eduroam network for example).

Michael


------- Original Message -------
On Friday, August 26th, 2022 at 16:51, Denis Kenzior <denkenz@gmail.com> wr=
ote:


>=20
>=20
> When support for ECDSA keys was added, constraints for data & signature
> sizes were never updated. This makes it impossible to use such keys via
> keyctl API from userspace.
>=20
> Update constraint on max_data_size to 64 bytes in order to support
> SHA512-based signatures. Also update the signature length constraints
> per ECDSA signature encoding described in RFC 5480.
>=20
> Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA=
 keys")
> Signed-off-by: Denis Kenzior denkenz@gmail.com
>=20
> ---
>=20
> Version History:
>=20
> v2: Update patch description according to Jarkko's comments. No
> functional code changes.
>=20
> crypto/asymmetric_keys/public_key.c | 24 ++++++++++++++++++++++--
> 1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys=
/public_key.c
> index 2f8352e88860..eca5671ad3f2 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -186,8 +186,28 @@ static int software_key_query(const struct kernel_pk=
ey_params *params,
>=20
> len =3D crypto_akcipher_maxsize(tfm);
> info->key_size =3D len * 8;
>=20
> - info->max_data_size =3D len;
>=20
> - info->max_sig_size =3D len;
>=20
> +
> + if (strncmp(pkey->pkey_algo, "ecdsa", 5) =3D=3D 0) {
>=20
> + /*
> + * ECDSA key sizes are much smaller than RSA, and thus could
> + * operate on (hashed) inputs that are larger than key size.
> + * For example SHA384-hashed input used with secp256r1
> + * based keys. Set max_data_size to be at least as large as
> + * the largest supported hash size (SHA512)
> + */
> + info->max_data_size =3D 64;
>=20
> +
> + /*
> + * Verify takes ECDSA-Sig (described in RFC 5480) as input,
> + * which is actually 2 'key_size'-bit integers encoded in
> + * ASN.1. Account for the ASN.1 encoding overhead here.
> + */
> + info->max_sig_size =3D 2 * (len + 3) + 2;
>=20
> + } else {
> + info->max_data_size =3D len;
>=20
> + info->max_sig_size =3D len;
>=20
> + }
> +
> info->max_enc_size =3D len;
>=20
> info->max_dec_size =3D len;
>=20
> info->supported_ops =3D (KEYCTL_SUPPORTS_ENCRYPT |
>=20
> --
> 2.35.1
