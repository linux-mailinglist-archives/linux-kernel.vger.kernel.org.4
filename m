Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B02D6318E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 04:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiKUD1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 22:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKUD1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 22:27:06 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B8F26AD6;
        Sun, 20 Nov 2022 19:27:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NFt9J0qhjz4xFy;
        Mon, 21 Nov 2022 14:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669001220;
        bh=6aqiKY3bEZTrEiPV4A0hOaMTh+jqeYnyGttXV5Q2xD4=;
        h=Date:From:To:Cc:Subject:From;
        b=eY8vPm+BKIhgNYu1pUaZJ8TijIIFukzybNI0jsODKREYZxW3M7FIMZv+6gIwM8g37
         2vObue/Whcc8KKtZzqm7AtWXRsZnIOu3m/IZI9jsKxR+5Nx/sR5O5IBuOK6SYunEqt
         wwOV+eN8G3S5hgQohNBDXkgr17c8FvoMxxxA7+zDIUV2R7hbgPiyvaWqbC5GaK5HIx
         AWWh+lUvrL3WqMRzyBajEGCVWiEYB5fNtShIhN7K33CCU6Td4jPbxrOPuV+WcCGhJD
         /3HjM649jKhjWFgn5g95HxfO+zZ2d7xNWn1oUB6Z7HaynQGNFnkhD4T+EM3Na7NT7s
         fiF/rgnem0mLg==
Date:   Mon, 21 Nov 2022 14:26:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20221121142658.2e3f4108@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wwn7JLCJuK6TOGyJB2XRPx7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wwn7JLCJuK6TOGyJB2XRPx7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the apparmor tree got a conflict in:

  security/apparmor/domain.c

between commit:

  f6fbd8cbf3ed ("lsm,fs: fix vfs_getxattr_alloc() return type and caller er=
ror paths")

from the security tree and commit:

  217af7e2f4de ("apparmor: refactor profile rules and attachments")

from the apparmor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/domain.c
index 00dc0ec066de,b447bc13ea8e..000000000000
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@@ -308,14 -296,16 +296,15 @@@ static int change_profile_perms(struct=20
   * Returns: number of extended attributes that matched, or < 0 on error
   */
  static int aa_xattrs_match(const struct linux_binprm *bprm,
- 			   struct aa_profile *profile, unsigned int state)
+ 			   struct aa_profile *profile, aa_state_t state)
  {
  	int i;
 -	ssize_t size;
  	struct dentry *d;
  	char *value =3D NULL;
- 	int size, value_size =3D 0, ret =3D profile->xattr_count;
+ 	struct aa_attachment *attach =3D &profile->attach;
 -	int value_size =3D 0, ret =3D attach->xattr_count;
++	int size, value_size =3D 0, ret =3D attach->xattr_count;
 =20
- 	if (!bprm || !profile->xattr_count)
+ 	if (!bprm || !attach->xattr_count)
  		return 0;
  	might_sleep();
 =20

--Sig_/Wwn7JLCJuK6TOGyJB2XRPx7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN68AIACgkQAVBC80lX
0GxJJgf/RzyAD1DIeOb0wANDuJZrmRGhahYkMSpok5ZM9kN1e0XSAM3XYRk3E3qt
Z+n3nyyvrKGO6prrGGaQ6gG7+uUHQ4MxJXCVzfMt1mA+J1m13xhVeFn+J1mTtk6E
pOynIUGUdW4FS2eyjlrutlFm68vj+Y3C+1BAo/BwOaESQmJ1ELZWGVUk6YGw0h4Z
XdzxD2OfFFwWDuyXzn7HKdax6pyJiP5d3F6OnXqiI/wpeVWNE/fUFYFgblVcQNTs
3Wa50WSP+qF1bbeSY2DGTjKgPlQgXTocdK9mwjkn9kW5Pd3g21pGFU1qd0rM+NqM
41k8hBrJwx5CAiQFyDuO+DvbkSzZgg==
=7Cmh
-----END PGP SIGNATURE-----

--Sig_/Wwn7JLCJuK6TOGyJB2XRPx7--
