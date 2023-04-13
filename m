Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F246E116A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjDMPti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjDMPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587BD9EE3;
        Thu, 13 Apr 2023 08:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA5F16124E;
        Thu, 13 Apr 2023 15:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE71CC4339E;
        Thu, 13 Apr 2023 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681400972;
        bh=6EtGrpXDbQ4r0pEsa7wO8I5/ItrKduaR+3mSvDeYZFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HvyfpSddbGVN4MazfdXwOhm49r6p/SUgBMpuz/TtXIalWwZWLMzhs4Faw9glIsKPg
         n06gkjBsr+E8c7FqhgMiKlmHE6m9/ZKGpcMGWHPwCjW3DeMeR2OfiPL+yUPGiFq4ew
         o5yX2QGI7pCb8okXM9U5YUvI2n762nzCVta2fq3tRM2ag1/5/5jSCRPh4qlsegsoAZ
         T+kP/JJr1ukHAP53lA2nfF2cawo1W1nTXn5l8MokfAu/BVmspdpJQZfwUBFo159Dm2
         Abdm2cQ56JPqu+USuxD65GGHHwpbhD3YqVlRHQ2JhHFhpw9PA7VSxu9ManFYEc4VYg
         tjReQz3+9L5lA==
Date:   Thu, 13 Apr 2023 16:49:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gao Xiang <xiang@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the erofs tree with the
 vfs-idmapping tree
Message-ID: <4f9fdec2-cc2a-4bc7-9ddc-87809395f493@sirena.org.uk>
References: <20230413144651.3519980-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n6RZDYGuxrYvmwhK"
Content-Disposition: inline
In-Reply-To: <20230413144651.3519980-1-broonie@kernel.org>
X-Cookie: Idleness is the holiday of fools.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n6RZDYGuxrYvmwhK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 03:46:51PM +0100, broonie@kernel.org wrote:

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

No, that's wrong.  This:

diff --cc fs/erofs/xattr.c
index 015462763bdd5,a04724c816e5f..0000000000000
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@@ -483,12 -517,28 +513,25 @@@ static int xattr_entrylist(struct xattr
  {
  	struct listxattr_iter *it =3D
  		container_of(_it, struct listxattr_iter, it);
- 	unsigned int prefix_len;
- 	const char *prefix;
+ 	unsigned int base_index =3D entry->e_name_index;
+ 	unsigned int prefix_len, infix_len =3D 0;
+ 	const char *prefix, *infix =3D NULL;
 -	const struct xattr_handler *h;
+=20
+ 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+ 		struct erofs_sb_info *sbi =3D EROFS_SB(_it->sb);
+ 		struct erofs_xattr_prefix_item *pf =3D sbi->xattr_prefixes +
+ 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+=20
+ 		if (pf >=3D sbi->xattr_prefixes + sbi->xattr_prefix_count)
+ 			return 1;
+ 		infix =3D pf->prefix->infix;
+ 		infix_len =3D pf->infix_len;
+ 		base_index =3D pf->prefix->base_index;
+ 	}
 =20
- 	prefix =3D erofs_xattr_prefix(entry->e_name_index, it->dentry);
 -	h =3D erofs_xattr_handler(base_index);
 -	if (!h || (h->list && !h->list(it->dentry)))
++	prefix =3D erofs_xattr_prefix(base_index, it->dentry);
 +	if (!prefix)
  		return 1;
 -
 -	prefix =3D xattr_prefix(h);
  	prefix_len =3D strlen(prefix);
 =20
  	if (!it->buffer) {

--n6RZDYGuxrYvmwhK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ4JIYACgkQJNaLcl1U
h9DoVQf/a2i9JBz4jgO0Nm2RRd4s79fyZYmzvrz77Elka3NqN6dIKk6goMUfmjwN
XqSXmYdFVHuHWULh59ByAhpXh2TWkrkkprDYSj+hCjgFXiwOzpcZU3zrLq0Vm53E
QBIarbIE7M415G4ccCP8zvQSqVt2GmcvB58MAuhKvOM7W54wtIvYpu+IUw/u0Xvd
c/NvMOajnaadUJq7T++oSG1HY8CZ+WfObNwE5nmNBHTYLhdRMCcjxJLLuPMdkDyl
m1dAh776MzvEOUaiobrRikkOqScMTE8pXBmrWJ8wPdLOcBgClI8LCMiHil2cUbrr
zEQDr7x4FnKbZxXD8WXThFuSoaS/aA==
=sE9W
-----END PGP SIGNATURE-----

--n6RZDYGuxrYvmwhK--
