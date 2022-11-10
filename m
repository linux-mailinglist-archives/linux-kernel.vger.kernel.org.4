Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84547623919
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKJBop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiKJBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:44:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C0629812;
        Wed,  9 Nov 2022 17:44:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N74Q93CvXz4xZ0;
        Thu, 10 Nov 2022 12:44:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668044673;
        bh=ZeWw/pBrhB5XCaM3DHaahIUrvIcAQKT78oFK3ZsAtwE=;
        h=Date:From:To:Cc:Subject:From;
        b=IH2hg/DjzipNOIhtHxwpaI18PCjBsH543SYeuD0BfL8wmI7OrFy2APF5aD/g0LGbn
         jP239+BKg3h4niw3US8IDBG2+7szpiOWMqrk76rJcXpJNn+Fwcyafo6BeFq9CTe5Ik
         ayycTGkynBBPX4RdHIay8W9jnDCdHP6WDcXG9LtNzhGMDO4jNcSBcsJgxcvRd1bR3V
         5WNz9dXelReRq007SIMMUBuoGTg3cY3mbEjazjqIkz/3RSjaKlZWHRZdvjWqx3BNKt
         tpmO+a5I+SFGSqYo4aLlUxiowvOHSYXWuH+ER3neJU5mD3eNtsRviSPr8ghyQMDgVS
         hlvKEBu0PL/kQ==
Date:   Thu, 10 Nov 2022 12:44:32 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the selinux tree with Linus' tree
Message-ID: <20221110124118.37e626fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/whRV2wne/_eDbaPE.FvD4Ej";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/whRV2wne/_eDbaPE.FvD4Ej
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the selinux tree got conflicts in:

  security/selinux/ss/services.c
  security/selinux/ss/sidtab.c
  security/selinux/ss/sidtab.h

between commit:

  abe3c631447d ("selinux: enable use of both GFP_KERNEL and GFP_ATOMIC in c=
onvert_context()")

from Linus' tree and commit:

  048be156491f ("selinux: remove the sidtab context conversion indirect cal=
ls")

from the selinux tree.

I fixed it up (see below) and applied the following merge fix patch
as well and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 10 Nov 2022 12:38:01 +1100
Subject: [PATCH] selinux: fix up for "selinux: enable use of both GFP_KERNEL
 and GFP_ATOMIC in convert_context()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/selinux/ss/services.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index 6348c95ff0e5..c4301626487f 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -41,6 +41,7 @@ void services_compute_xperms_decision(struct extended_per=
ms_decision *xpermd,
 				      struct avtab_node *node);
=20
 int services_convert_context(struct convert_context_args *args,
-			     struct context *oldc, struct context *newc);
+			     struct context *oldc, struct context *newc,
+			     gfp_t gfp_flags);
=20
 #endif	/* _SS_SERVICES_H_ */
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

diff --cc security/selinux/ss/services.c
index 64a6a37dc36d,e63c4f942fd6..9086c4ea0255
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@@ -2014,18 -2008,20 +2008,21 @@@ static inline int convert_context_handl
  	return 0;
  }
 =20
- /*
-  * Convert the values in the security context
-  * structure `oldc' from the values specified
-  * in the policy `p->oldp' to the values specified
-  * in the policy `p->newp', storing the new context
-  * in `newc'.  Verify that the context is valid
-  * under the new policy.
+ /**
+  * services_convert_context - Convert a security context across policies.
+  * @args: populated convert_context_args struct
+  * @oldc: original context
+  * @newc: converted context
+  *
+  * Convert the values in the security context structure @oldc from the va=
lues
+  * specified in the policy @args->oldp to the values specified in the pol=
icy
+  * @args->newp, storing the new context in @newc, and verifying that the
+  * context is valid under the new policy.
   */
- static int convert_context(struct context *oldc, struct context *newc, vo=
id *p,
- 			   gfp_t gfp_flags)
+ int services_convert_context(struct convert_context_args *args,
 -			     struct context *oldc, struct context *newc)
++			     struct context *oldc, struct context *newc,
++			     gfp_t gfp_flags)
  {
- 	struct convert_context_args *args;
  	struct ocontext *oc;
  	struct role_datum *role;
  	struct type_datum *typdatum;
@@@ -2034,10 -2030,8 +2031,8 @@@
  	u32 len;
  	int rc;
 =20
- 	args =3D p;
-=20
  	if (oldc->str) {
 -		s =3D kstrdup(oldc->str, GFP_KERNEL);
 +		s =3D kstrdup(oldc->str, gfp_flags);
  		if (!s)
  			return -ENOMEM;
 =20
diff --cc security/selinux/ss/sidtab.c
index db5cce385bf8,1c3d2cda6b92..38d25173aebd
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@@ -324,8 -327,8 +327,9 @@@ int sidtab_context_to_sid(struct sidta
  			goto out_unlock;
  		}
 =20
- 		rc =3D convert->func(context, &dst_convert->context,
- 				   convert->args, GFP_ATOMIC);
+ 		rc =3D services_convert_context(convert->args,
 -					      context, &dst_convert->context);
++					      context, &dst_convert->context,
++					      GFP_ATOMIC);
  		if (rc) {
  			context_destroy(&dst->context);
  			goto out_unlock;
@@@ -402,9 -405,9 +406,10 @@@ static int sidtab_convert_tree(union si
  		}
  		i =3D 0;
  		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
- 			rc =3D convert->func(&esrc->ptr_leaf->entries[i].context,
- 					   &edst->ptr_leaf->entries[i].context,
- 					   convert->args, GFP_KERNEL);
+ 			rc =3D services_convert_context(convert->args,
+ 					&esrc->ptr_leaf->entries[i].context,
 -					&edst->ptr_leaf->entries[i].context);
++					&edst->ptr_leaf->entries[i].context,
++					GFP_KERNEL);
  			if (rc)
  				return rc;
  			(*pos)++;

--Sig_/whRV2wne/_eDbaPE.FvD4Ej
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNsV4AACgkQAVBC80lX
0GxG8wgAjpoVgExpS7o4Qa1EtzUZR6HJL3a9ObVLvrknTaFsMOlv2EDDOyFlwVkk
QWGYDuWQZhoRJSVgp9p0MtoeIA3peejO5gNw/89+rrvvu9c8rtxDhNFDEbzXBnjg
7wDrjCe1nAqjiK35Lwxla6C5VJI7jsHGhUQxY/wroUz2PzXabb6vPREmN32L9a4l
2dWNh2kierB58H/1Jm5SflnKNAPrGWIiVJVXl5h8bYMTcpdVO4wxsomy4KBxHL8E
QIoZageiWr9xcr9d5r2gSjh5CBha+o9jmagL94uhuHCV8E7mkwU5Y+Pd5xTCHNek
o398kb1nR1nZJDIRsrzIqHV4eOKcDw==
=ffWS
-----END PGP SIGNATURE-----

--Sig_/whRV2wne/_eDbaPE.FvD4Ej--
