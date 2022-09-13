Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13005B6484
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 02:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIMAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIMAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 20:25:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD414D13;
        Mon, 12 Sep 2022 17:25:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MRPPK5TYQz4xGF;
        Tue, 13 Sep 2022 10:25:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1663028710;
        bh=NeXKKKQHkquOZMHuSEMBOlA+2Tpk5LBwXb2iR79KQI4=;
        h=Date:From:To:Cc:Subject:From;
        b=imxlOwiXkgIVnTcAXpEH7zp5iCQTbNXvGYXCkA43vM3nDM/6xkDkD9l3+gUr+9tuT
         1OVdP6Ffy9sscyTXiGiVNSi+bl5USOFso+00CWfBYoqHAU6+zwwyEqB0/9rTk7MsKO
         lQTCc62ZDWCpEfVuQ2dhRvAE0rpr776BcHZmc6uMDkqgA+vS4bRxKkh1lbSdrs73zc
         wt4d/0gHratFT61XgMuVp5OlTdQhMS4sPuRHRDd3bOh/E3vpoJg8gp3qBLlEyaWGT6
         5L0yZj4S9fT0gj482jBYYeqeWViCfyLdMexxFEatEnFC6gUXXRg+gYJtvVjiLHJKFp
         loLcQwUbSS0KQ==
Date:   Tue, 13 Sep 2022 10:25:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the nfsd tree with the cel-fixes tree
Message-ID: <20220913102507.3295ce32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x71jjIHH/OQo31x58HL2qMX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x71jjIHH/OQo31x58HL2qMX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the nfsd tree got a conflict in:

  fs/nfsd/vfs.c

between commit:

  00801cd92d91 ("NFSD: fix regression with setting ACLs.")

from the cel-fixes tree and commit:

  e9de96c3df55 ("NFSD: Refactor nfsd_setattr()")

from the nfsd tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/nfsd/vfs.c
index 19f28c33e44d,8eda499de545..000000000000
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@@ -343,6 -339,44 +343,48 @@@ nfsd_get_write_access(struct svc_rqst *
  	return nfserrno(get_write_access(inode));
  }
 =20
+ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
+ {
+ 	int host_err;
+=20
+ 	if (iap->ia_valid & ATTR_SIZE) {
+ 		/*
+ 		 * RFC5661, Section 18.30.4:
+ 		 *   Changing the size of a file with SETATTR indirectly
+ 		 *   changes the time_modify and change attributes.
+ 		 *
+ 		 * (and similar for the older RFCs)
+ 		 */
+ 		struct iattr size_attr =3D {
+ 			.ia_valid	=3D ATTR_SIZE | ATTR_CTIME | ATTR_MTIME,
+ 			.ia_size	=3D iap->ia_size,
+ 		};
+=20
+ 		if (iap->ia_size < 0)
+ 			return -EFBIG;
+=20
+ 		host_err =3D notify_change(&init_user_ns, dentry, &size_attr, NULL);
+ 		if (host_err)
+ 			return host_err;
+ 		iap->ia_valid &=3D ~ATTR_SIZE;
+=20
+ 		/*
+ 		 * Avoid the additional setattr call below if the only other
+ 		 * attribute that the client sends is the mtime, as we update
+ 		 * it as part of the size change above.
+ 		 */
+ 		if ((iap->ia_valid & ~ATTR_MTIME) =3D=3D 0)
+ 			return 0;
+ 	}
+=20
 -	iap->ia_valid |=3D ATTR_CTIME;
 -	return notify_change(&init_user_ns, dentry, iap, NULL);
++	if (iap->ia_valid) {
++		iap->ia_valid |=3D ATTR_CTIME;
++		return notify_change(&init_user_ns, dentry, iap, NULL);
++	}
++
++	return 0;
+ }
+=20
  /*
   * Set various file attributes.  After this call fhp needs an fh_put.
   */
@@@ -357,9 -391,10 +399,10 @@@ nfsd_setattr(struct svc_rqst *rqstp, st
  	int		accmode =3D NFSD_MAY_SATTR;
  	umode_t		ftype =3D 0;
  	__be32		err;
 -	int		host_err;
 +	int		host_err =3D 0;
  	bool		get_write_count;
  	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
+ 	int		retries;
 =20
  	if (iap->ia_valid & ATTR_SIZE) {
  		accmode |=3D NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;

--Sig_/x71jjIHH/OQo31x58HL2qMX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMfzeMACgkQAVBC80lX
0GzJDAf9Hyc6QBzR86G/Z7ndvUx49p9y/mnBZTfPeOgl18HOWrrC3BAkqpaB+ao1
DitKIgKPp/1E+UmEC/ktkMeHD5Ri3ClQGrO8SYc/K4ZO7ag14gFubwhoTYUkGqdd
XpO6YscYq0xyPFupIhY+pDJ0QSHmZbHix32COOsu9rUXWJAjYWFLcV2md3c7ff9c
3nHrmZ6SXunFoff0iV0zAnA6gM5JndukLzq6CL2W1j2SptW2L50lkoIiRWUxe+Uh
8giWxFxtzSmPH8l/yp/9dFO3b/gTP3bOoBVHjX2bJ87N4NNim47kVsCTvDRQGmO5
UisODRbl7/W39+8ZGiq9jGVZxq+M4w==
=tlT4
-----END PGP SIGNATURE-----

--Sig_/x71jjIHH/OQo31x58HL2qMX--
