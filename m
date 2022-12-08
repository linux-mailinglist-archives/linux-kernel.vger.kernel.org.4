Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EAB646746
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLHCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLHCxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:53:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A3950C1;
        Wed,  7 Dec 2022 18:53:34 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSJcn0yzlz4xGR;
        Thu,  8 Dec 2022 13:53:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670468010;
        bh=e9hvLcMLZUTOVbj+xxmtqAtif4JsB1MMYGxaDkMJyJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=QEdkGtsdexr8I42Ntnk/K6UQtjr/ZNiur24n9/Yop6l4MNvsf+OiCyIXindS9Z6R3
         EjltF0HcteHcCuMPeWFMSyO2S+X5oQWuynwlM7HZ7vdX+yv+xPc5AA81sxs9CZ85Tt
         yhHogAbNwP1DMHf6byrt6eYAw8WiaNwWqHYtJVlGRebmzVuIMC0cwxhPCqm5HerE3b
         3ishY/4BpmPYkUBkQkDM2b9uG/qLUTsj4PBmA2PSmOii2Q2G3IZRhWA0hdfU+BcYtv
         qqgDLU6UcjGnzl4TR2Ex3nbguQL6TccWcMdB00kDXoJrYHIx1Fpi94HcjsE4cQuQrt
         Xop/CA1e0CeDA==
Date:   Thu, 8 Dec 2022 13:53:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
Subject: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Message-ID: <20221208135327.01364529@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/URPKV2lGuO/w5zMvj.Rt1nW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/URPKV2lGuO/w5zMvj.Rt1nW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  security/apparmor/policy_unpack.c

between commits:

  371e50a0b19f ("apparmor: make unpack_array return a trianary value")
  73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking tra=
ns_table")
  217af7e2f4de ("apparmor: refactor profile rules and attachments")
(and probably others)

from the apparmor tree and commit:

  2c92044683f5 ("apparmor: test: make static symbols visible during kunit t=
esting")

from the kunit-next tree.

This is somewhat of a mess ... pity there is not a shared branch (or
better routing if the patches).

I fixed it up (hopefully - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

I also had to add this patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 8 Dec 2022 13:47:43 +1100
Subject: [PATCH] fixup for "apparmor: make unpack_array return a trianary v=
alue"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 security/apparmor/include/policy_unpack.h | 8 +++++++-
 security/apparmor/policy_unpack.c         | 5 -----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/include/policy_unpack.h b/security/apparmor/=
include/policy_unpack.h
index 940da8a33e0c..8fdf8f703bd0 100644
--- a/security/apparmor/include/policy_unpack.h
+++ b/security/apparmor/include/policy_unpack.h
@@ -172,7 +172,13 @@ bool aa_unpack_X(struct aa_ext *e, enum aa_code code);
 bool aa_unpack_nameX(struct aa_ext *e, enum aa_code code, const char *name=
);
 bool aa_unpack_u32(struct aa_ext *e, u32 *data, const char *name);
 bool aa_unpack_u64(struct aa_ext *e, u64 *data, const char *name);
-size_t aa_unpack_array(struct aa_ext *e, const char *name);
+
+#define tri int
+#define TRI_TRUE 1
+#define TRI_NONE 0
+#define TRI_FALSE -1
+
+tri aa_unpack_array(struct aa_ext *e, const char *name, u16 *size);
 size_t aa_unpack_blob(struct aa_ext *e, char **blob, const char *name);
 int aa_unpack_str(struct aa_ext *e, const char **string, const char *name);
 int aa_unpack_strdup(struct aa_ext *e, char **string, const char *name);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_u=
npack.c
index 6513545dad5e..173d832fc4ee 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -30,11 +30,6 @@
 #include "include/policy_unpack.h"
 #include "include/policy_compat.h"
=20
-#define tri int
-#define TRI_TRUE 1
-#define TRI_NONE 0
-#define TRI_FALSE -1
-
 /* audit callback for unpack fields */
 static void audit_cb(struct audit_buffer *ab, void *va)
 {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/policy_unpack.c
index 1bf8cfb8700a,12e535fdfa8b..000000000000
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@@ -14,9 -14,10 +14,10 @@@
   */
 =20
  #include <asm/unaligned.h>
+ #include <kunit/visibility.h>
  #include <linux/ctype.h>
  #include <linux/errno.h>
 -#include <linux/zlib.h>
 +#include <linux/zstd.h>
 =20
  #include "include/apparmor.h"
  #include "include/audit.h"
@@@ -27,50 -27,16 +28,12 @@@
  #include "include/path.h"
  #include "include/policy.h"
  #include "include/policy_unpack.h"
 +#include "include/policy_compat.h"
 =20
-=20
- /*
-  * The AppArmor interface treats data as a type byte followed by the
-  * actual data.  The interface has the notion of a named entry
-  * which has a name (AA_NAME typecode followed by name string) followed by
-  * the entries typecode and data.  Named types allow for optional
-  * elements and extensions to be added and tested for without breaking
-  * backwards compatibility.
-  */
-=20
- enum aa_code {
- 	AA_U8,
- 	AA_U16,
- 	AA_U32,
- 	AA_U64,
- 	AA_NAME,		/* same as string except it is items name */
- 	AA_STRING,
- 	AA_BLOB,
- 	AA_STRUCT,
- 	AA_STRUCTEND,
- 	AA_LIST,
- 	AA_LISTEND,
- 	AA_ARRAY,
- 	AA_ARRAYEND,
- };
-=20
- /*
-  * aa_ext is the read of the buffer containing the serialized profile.  T=
he
-  * data is copied into a kernel buffer in apparmorfs and then handed off =
to
-  * the unpack routines.
-  */
- struct aa_ext {
- 	void *start;
- 	void *end;
- 	void *pos;		/* pointer to current position in the buffer */
- 	u32 version;
- };
 -#define K_ABI_MASK 0x3ff
 -#define FORCE_COMPLAIN_FLAG 0x800
 -#define VERSION_LT(X, Y) (((X) & K_ABI_MASK) < ((Y) & K_ABI_MASK))
 -#define VERSION_GT(X, Y) (((X) & K_ABI_MASK) > ((Y) & K_ABI_MASK))
--
 -#define v5	5	/* base version */
 -#define v6	6	/* per entry policydb mediation check */
 -#define v7	7
 -#define v8	8	/* full network masking */
 +#define tri int
 +#define TRI_TRUE 1
 +#define TRI_NONE 0
 +#define TRI_FALSE -1
 =20
  /* audit callback for unpack fields */
  static void audit_cb(struct audit_buffer *ab, void *va)
@@@ -348,26 -319,28 +316,28 @@@ fail
  	e->pos =3D pos;
  	return false;
  }
+ EXPORT_SYMBOL_IF_KUNIT(aa_unpack_u64);
 =20
- static tri unpack_array(struct aa_ext *e, const char *name, u16 *size)
 -VISIBLE_IF_KUNIT size_t aa_unpack_array(struct aa_ext *e, const char *nam=
e)
++VISIBLE_IF_KUNIT tri aa_unpack_array(struct aa_ext *e, const char *name, =
u16 *size)
  {
  	void *pos =3D e->pos;
 =20
- 	if (unpack_nameX(e, AA_ARRAY, name)) {
- 		if (!inbounds(e, sizeof(u16)))
+ 	if (aa_unpack_nameX(e, AA_ARRAY, name)) {
 -		int size;
+ 		if (!aa_inbounds(e, sizeof(u16)))
  			goto fail;
 -		size =3D (int)le16_to_cpu(get_unaligned((__le16 *) e->pos));
 +		*size =3D le16_to_cpu(get_unaligned((__le16 *) e->pos));
  		e->pos +=3D sizeof(u16);
 -		return size;
 +		return TRI_TRUE;
  	}
 =20
 +	return TRI_NONE;
  fail:
  	e->pos =3D pos;
 -	return 0;
 +	return TRI_FALSE;
  }
+ EXPORT_SYMBOL_IF_KUNIT(aa_unpack_array);
 =20
- static size_t unpack_blob(struct aa_ext *e, char **blob, const char *name)
+ VISIBLE_IF_KUNIT size_t aa_unpack_blob(struct aa_ext *e, char **blob, con=
st char *name)
  {
  	void *pos =3D e->pos;
 =20
@@@ -470,36 -447,32 +443,36 @@@ static struct aa_dfa *unpack_dfa(struc
  /**
   * unpack_trans_table - unpack a profile transition table
   * @e: serialized data extent information  (NOT NULL)
 - * @profile: profile to add the accept table to (NOT NULL)
 + * @table: str table to unpack to (NOT NULL)
   *
 - * Returns: true if table successfully unpacked
 + * Returns: true if table successfully unpacked or not present
   */
 -static bool unpack_trans_table(struct aa_ext *e, struct aa_profile *profi=
le)
 +static bool unpack_trans_table(struct aa_ext *e, struct aa_str_table *str=
s)
  {
  	void *saved_pos =3D e->pos;
 +	char **table =3D NULL;
 =20
  	/* exec table is optional */
- 	if (unpack_nameX(e, AA_STRUCT, "xtable")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "xtable")) {
 -		int i, size;
 -
 -		size =3D aa_unpack_array(e, NULL);
 -		/* currently 4 exec bits and entries 0-3 are reserved iupcx */
 -		if (size > 16 - 4)
 +		u16 size;
 +		int i;
 +
- 		if (unpack_array(e, NULL, &size) !=3D TRI_TRUE)
++		if (aa_unpack_array(e, NULL, &size) !=3D TRI_TRUE)
 +			/*
 +			 * Note: index into trans table array is a max
 +			 * of 2^24, but unpack array can only unpack
 +			 * an array of 2^16 in size atm so no need
 +			 * for size check here
 +			 */
  			goto fail;
 -		profile->file.trans.table =3D kcalloc(size, sizeof(char *),
 -						    GFP_KERNEL);
 -		if (!profile->file.trans.table)
 +		table =3D kcalloc(size, sizeof(char *), GFP_KERNEL);
 +		if (!table)
  			goto fail;
 =20
 -		profile->file.trans.size =3D size;
  		for (i =3D 0; i < size; i++) {
  			char *str;
- 			int c, j, pos, size2 =3D unpack_strdup(e, &str, NULL);
- 			/* unpack_strdup verifies that the last character is
+ 			int c, j, pos, size2 =3D aa_unpack_strdup(e, &str, NULL);
+ 			/* aa_unpack_strdup verifies that the last character is
  			 * null termination byte.
  			 */
  			if (!size2)
@@@ -534,13 -507,10 +507,13 @@@
  				/* fail - all other cases with embedded \0 */
  				goto fail;
  		}
- 		if (!unpack_nameX(e, AA_ARRAYEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
 +
 +		strs->table =3D table;
 +		strs->size =3D size;
  	}
  	return true;
 =20
@@@ -554,23 -524,21 +527,23 @@@ static bool unpack_xattrs(struct aa_ex
  {
  	void *pos =3D e->pos;
 =20
- 	if (unpack_nameX(e, AA_STRUCT, "xattrs")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "xattrs")) {
 -		int i, size;
 +		u16 size;
 +		int i;
 =20
- 		if (unpack_array(e, NULL, &size) !=3D TRI_TRUE)
 -		size =3D aa_unpack_array(e, NULL);
 -		profile->xattr_count =3D size;
 -		profile->xattrs =3D kcalloc(size, sizeof(char *), GFP_KERNEL);
 -		if (!profile->xattrs)
++		if (aa_unpack_array(e, NULL, &size) !=3D TRI_TRUE)
 +			goto fail;
 +		profile->attach.xattr_count =3D size;
 +		profile->attach.xattrs =3D kcalloc(size, sizeof(char *), GFP_KERNEL);
 +		if (!profile->attach.xattrs)
  			goto fail;
  		for (i =3D 0; i < size; i++) {
- 			if (!unpack_strdup(e, &profile->attach.xattrs[i], NULL))
 -			if (!aa_unpack_strdup(e, &profile->xattrs[i], NULL))
++			if (!aa_unpack_strdup(e, &profile->attach.xattrs[i], NULL))
  				goto fail;
  		}
- 		if (!unpack_nameX(e, AA_ARRAYEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
  	}
 =20
@@@ -581,34 -549,32 +554,34 @@@ fail
  	return false;
  }
 =20
 -static bool unpack_secmark(struct aa_ext *e, struct aa_profile *profile)
 +static bool unpack_secmark(struct aa_ext *e, struct aa_ruleset *rules)
  {
  	void *pos =3D e->pos;
 -	int i, size;
 +	u16 size;
 +	int i;
 =20
- 	if (unpack_nameX(e, AA_STRUCT, "secmark")) {
- 		if (unpack_array(e, NULL, &size) !=3D TRI_TRUE)
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "secmark")) {
 -		size =3D aa_unpack_array(e, NULL);
++		if (aa_unpack_array(e, NULL, &size) !=3D TRI_TRUE)
 +			goto fail;
 =20
 -		profile->secmark =3D kcalloc(size, sizeof(struct aa_secmark),
 +		rules->secmark =3D kcalloc(size, sizeof(struct aa_secmark),
  					   GFP_KERNEL);
 -		if (!profile->secmark)
 +		if (!rules->secmark)
  			goto fail;
 =20
 -		profile->secmark_count =3D size;
 +		rules->secmark_count =3D size;
 =20
  		for (i =3D 0; i < size; i++) {
 -			if (!unpack_u8(e, &profile->secmark[i].audit, NULL))
 +			if (!unpack_u8(e, &rules->secmark[i].audit, NULL))
  				goto fail;
 -			if (!unpack_u8(e, &profile->secmark[i].deny, NULL))
 +			if (!unpack_u8(e, &rules->secmark[i].deny, NULL))
  				goto fail;
- 			if (!unpack_strdup(e, &rules->secmark[i].label, NULL))
 -			if (!aa_unpack_strdup(e, &profile->secmark[i].label, NULL))
++			if (!aa_unpack_strdup(e, &rules->secmark[i].label, NULL))
  				goto fail;
  		}
- 		if (!unpack_nameX(e, AA_ARRAYEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
  	}
 =20
@@@ -632,27 -598,26 +605,27 @@@ static bool unpack_rlimits(struct aa_ex
  	void *pos =3D e->pos;
 =20
  	/* rlimits are optional */
- 	if (unpack_nameX(e, AA_STRUCT, "rlimits")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "rlimits")) {
 -		int i, size;
 +		u16 size;
 +		int i;
  		u32 tmp =3D 0;
- 		if (!unpack_u32(e, &tmp, NULL))
+ 		if (!aa_unpack_u32(e, &tmp, NULL))
  			goto fail;
 -		profile->rlimits.mask =3D tmp;
 +		rules->rlimits.mask =3D tmp;
 =20
- 		if (unpack_array(e, NULL, &size) !=3D TRI_TRUE ||
 -		size =3D aa_unpack_array(e, NULL);
 -		if (size > RLIM_NLIMITS)
++		if (aa_unpack_array(e, NULL, &size) !=3D TRI_TRUE ||
 +		    size > RLIM_NLIMITS)
  			goto fail;
  		for (i =3D 0; i < size; i++) {
  			u64 tmp2 =3D 0;
  			int a =3D aa_map_resource(i);
- 			if (!unpack_u64(e, &tmp2, NULL))
+ 			if (!aa_unpack_u64(e, &tmp2, NULL))
  				goto fail;
 -			profile->rlimits.limits[a].rlim_max =3D tmp2;
 +			rules->rlimits.limits[a].rlim_max =3D tmp2;
  		}
- 		if (!unpack_nameX(e, AA_ARRAYEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
  	}
  	return true;
@@@ -662,144 -627,6 +635,144 @@@ fail
  	return false;
  }
 =20
 +static bool unpack_perm(struct aa_ext *e, u32 version, struct aa_perms *p=
erm)
 +{
 +	bool res;
 +
 +	if (version !=3D 1)
 +		return false;
 +
- 	res =3D unpack_u32(e, &perm->allow, NULL);
- 	res =3D res && unpack_u32(e, &perm->allow, NULL);
- 	res =3D res && unpack_u32(e, &perm->deny, NULL);
- 	res =3D res && unpack_u32(e, &perm->subtree, NULL);
- 	res =3D res && unpack_u32(e, &perm->cond, NULL);
- 	res =3D res && unpack_u32(e, &perm->kill, NULL);
- 	res =3D res && unpack_u32(e, &perm->complain, NULL);
- 	res =3D res && unpack_u32(e, &perm->prompt, NULL);
- 	res =3D res && unpack_u32(e, &perm->audit, NULL);
- 	res =3D res && unpack_u32(e, &perm->quiet, NULL);
- 	res =3D res && unpack_u32(e, &perm->hide, NULL);
- 	res =3D res && unpack_u32(e, &perm->xindex, NULL);
- 	res =3D res && unpack_u32(e, &perm->tag, NULL);
- 	res =3D res && unpack_u32(e, &perm->label, NULL);
++	res =3D aa_unpack_u32(e, &perm->allow, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->allow, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->deny, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->subtree, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->cond, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->kill, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->complain, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->prompt, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->audit, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->quiet, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->hide, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->xindex, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->tag, NULL);
++	res =3D res && aa_unpack_u32(e, &perm->label, NULL);
 +
 +	return res;
 +}
 +
 +static ssize_t unpack_perms_table(struct aa_ext *e, struct aa_perms **per=
ms)
 +{
 +	void *pos =3D e->pos;
 +	u16 size =3D 0;
 +
 +	AA_BUG(!perms);
 +	/*
 +	 * policy perms are optional, in which case perms are embedded
 +	 * in the dfa accept table
 +	 */
- 	if (unpack_nameX(e, AA_STRUCT, "perms")) {
++	if (aa_unpack_nameX(e, AA_STRUCT, "perms")) {
 +		int i;
 +		u32 version;
 +
- 		if (!unpack_u32(e, &version, "version"))
++		if (!aa_unpack_u32(e, &version, "version"))
 +			goto fail_reset;
- 		if (unpack_array(e, NULL, &size) !=3D TRI_TRUE)
++		if (aa_unpack_array(e, NULL, &size) !=3D TRI_TRUE)
 +			goto fail_reset;
 +		*perms =3D kcalloc(size, sizeof(struct aa_perms), GFP_KERNEL);
 +		if (!*perms)
 +			goto fail_reset;
 +		for (i =3D 0; i < size; i++) {
 +			if (!unpack_perm(e, version, &(*perms)[i]))
 +				goto fail;
 +		}
- 		if (!unpack_nameX(e, AA_ARRAYEND, NULL))
++		if (!aa_unpack_nameX(e, AA_ARRAYEND, NULL))
 +			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
++		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
 +			goto fail;
 +	} else
 +		*perms =3D NULL;
 +
 +	return size;
 +
 +fail:
 +	kfree(*perms);
 +fail_reset:
 +	e->pos =3D pos;
 +	return -EPROTO;
 +}
 +
 +static int unpack_pdb(struct aa_ext *e, struct aa_policydb *policy,
 +		      bool required_dfa, bool required_trans,
 +		      const char **info)
 +{
 +	void *pos =3D e->pos;
 +	int i, flags, error =3D -EPROTO;
 +	ssize_t size;
 +
 +	size =3D unpack_perms_table(e, &policy->perms);
 +	if (size < 0) {
 +		error =3D size;
 +		policy->perms =3D NULL;
 +		*info =3D "failed to unpack - perms";
 +		goto fail;
 +	}
 +	policy->size =3D size;
 +
 +	if (policy->perms) {
 +		/* perms table present accept is index */
 +		flags =3D TO_ACCEPT1_FLAG(YYTD_DATA32);
 +	} else {
 +		/* packed perms in accept1 and accept2 */
 +		flags =3D TO_ACCEPT1_FLAG(YYTD_DATA32) |
 +			TO_ACCEPT2_FLAG(YYTD_DATA32);
 +	}
 +
 +	policy->dfa =3D unpack_dfa(e, flags);
 +	if (IS_ERR(policy->dfa)) {
 +		error =3D PTR_ERR(policy->dfa);
 +		policy->dfa =3D NULL;
 +		*info =3D "failed to unpack - dfa";
 +		goto fail;
 +	} else if (!policy->dfa) {
 +		if (required_dfa) {
 +			*info =3D "missing required dfa";
 +			goto fail;
 +		}
 +		goto out;
 +	}
 +
 +	/*
 +	 * only unpack the following if a dfa is present
 +	 *
 +	 * sadly start was given different names for file and policydb
 +	 * but since it is optional we can try both
 +	 */
- 	if (!unpack_u32(e, &policy->start[0], "start"))
++	if (!aa_unpack_u32(e, &policy->start[0], "start"))
 +		/* default start state */
 +		policy->start[0] =3D DFA_START;
- 	if (!unpack_u32(e, &policy->start[AA_CLASS_FILE], "dfa_start")) {
++	if (!aa_unpack_u32(e, &policy->start[AA_CLASS_FILE], "dfa_start")) {
 +		/* default start state for xmatch and file dfa */
 +		policy->start[AA_CLASS_FILE] =3D DFA_START;
 +	}	/* setup class index */
 +	for (i =3D AA_CLASS_FILE + 1; i <=3D AA_CLASS_LAST; i++) {
 +		policy->start[i] =3D aa_dfa_next(policy->dfa, policy->start[0],
 +					       i);
 +	}
 +	if (!unpack_trans_table(e, &policy->trans) && required_trans) {
 +		*info =3D "failed to unpack profile transition table";
 +		goto fail;
 +	}
 +
 +	/* TODO: move compat mapping here, requires dfa merging first */
 +	/* TODO: move verify here, it has to be done after compat mappings */
 +out:
 +	return 0;
 +
 +fail:
 +	e->pos =3D pos;
 +	return error;
 +}
 +
  static u32 strhash(const void *data, u32 len, u32 seed)
  {
  	const char * const *key =3D data;
@@@ -858,29 -683,26 +831,29 @@@ static struct aa_profile *unpack_profil
  	}
 =20
  	profile =3D aa_alloc_profile(name, NULL, GFP_KERNEL);
 -	if (!profile)
 -		return ERR_PTR(-ENOMEM);
 +	if (!profile) {
 +		info =3D "out of memory";
 +		error =3D -ENOMEM;
 +		goto fail;
 +	}
 +	rules =3D list_first_entry(&profile->rules, typeof(*rules), list);
 =20
  	/* profile renaming is optional */
- 	(void) unpack_str(e, &profile->rename, "rename");
+ 	(void) aa_unpack_str(e, &profile->rename, "rename");
 =20
  	/* attachment string is optional */
- 	(void) unpack_str(e, &profile->attach.xmatch_str, "attach");
 -	(void) aa_unpack_str(e, &profile->attach, "attach");
++	(void) aa_unpack_str(e, &profile->attach.xmatch_str, "attach");
 =20
  	/* xmatch is optional and may be NULL */
 -	profile->xmatch =3D unpack_dfa(e);
 -	if (IS_ERR(profile->xmatch)) {
 -		error =3D PTR_ERR(profile->xmatch);
 -		profile->xmatch =3D NULL;
 +	error =3D unpack_pdb(e, &profile->attach.xmatch, false, false, &info);
 +	if (error) {
  		info =3D "bad xmatch";
  		goto fail;
  	}
 -	/* xmatch_len is not optional if xmatch is set */
 -	if (profile->xmatch) {
 +
 +	/* neither xmatch_len not xmatch_perms are optional if xmatch is set */
 +	if (profile->attach.xmatch.dfa) {
- 		if (!unpack_u32(e, &tmp, NULL)) {
+ 		if (!aa_unpack_u32(e, &tmp, NULL)) {
  			info =3D "missing xmatch len";
  			goto fail;
  		}
@@@ -943,38 -757,38 +916,38 @@@
  		profile->path_flags =3D PATH_MEDIATE_DELETED;
 =20
  	info =3D "failed to unpack profile capabilities";
- 	if (!unpack_u32(e, &(rules->caps.allow.cap[0]), NULL))
 -	if (!aa_unpack_u32(e, &(profile->caps.allow.cap[0]), NULL))
++	if (!aa_unpack_u32(e, &(rules->caps.allow.cap[0]), NULL))
  		goto fail;
- 	if (!unpack_u32(e, &(rules->caps.audit.cap[0]), NULL))
 -	if (!aa_unpack_u32(e, &(profile->caps.audit.cap[0]), NULL))
++	if (!aa_unpack_u32(e, &(rules->caps.audit.cap[0]), NULL))
  		goto fail;
- 	if (!unpack_u32(e, &(rules->caps.quiet.cap[0]), NULL))
 -	if (!aa_unpack_u32(e, &(profile->caps.quiet.cap[0]), NULL))
++	if (!aa_unpack_u32(e, &(rules->caps.quiet.cap[0]), NULL))
  		goto fail;
- 	if (!unpack_u32(e, &tmpcap.cap[0], NULL))
+ 	if (!aa_unpack_u32(e, &tmpcap.cap[0], NULL))
  		goto fail;
 =20
  	info =3D "failed to unpack upper profile capabilities";
- 	if (unpack_nameX(e, AA_STRUCT, "caps64")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "caps64")) {
  		/* optional upper half of 64 bit caps */
- 		if (!unpack_u32(e, &(rules->caps.allow.cap[1]), NULL))
 -		if (!aa_unpack_u32(e, &(profile->caps.allow.cap[1]), NULL))
++		if (!aa_unpack_u32(e, &(rules->caps.allow.cap[1]), NULL))
  			goto fail;
- 		if (!unpack_u32(e, &(rules->caps.audit.cap[1]), NULL))
 -		if (!aa_unpack_u32(e, &(profile->caps.audit.cap[1]), NULL))
++		if (!aa_unpack_u32(e, &(rules->caps.audit.cap[1]), NULL))
  			goto fail;
- 		if (!unpack_u32(e, &(rules->caps.quiet.cap[1]), NULL))
 -		if (!aa_unpack_u32(e, &(profile->caps.quiet.cap[1]), NULL))
++		if (!aa_unpack_u32(e, &(rules->caps.quiet.cap[1]), NULL))
  			goto fail;
- 		if (!unpack_u32(e, &(tmpcap.cap[1]), NULL))
+ 		if (!aa_unpack_u32(e, &(tmpcap.cap[1]), NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
  	}
 =20
  	info =3D "failed to unpack extended profile capabilities";
- 	if (unpack_nameX(e, AA_STRUCT, "capsx")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "capsx")) {
  		/* optional extended caps mediation mask */
- 		if (!unpack_u32(e, &(rules->caps.extended.cap[0]), NULL))
 -		if (!aa_unpack_u32(e, &(profile->caps.extended.cap[0]), NULL))
++		if (!aa_unpack_u32(e, &(rules->caps.extended.cap[0]), NULL))
  			goto fail;
- 		if (!unpack_u32(e, &(rules->caps.extended.cap[1]), NULL))
 -		if (!aa_unpack_u32(e, &(profile->caps.extended.cap[1]), NULL))
++		if (!aa_unpack_u32(e, &(rules->caps.extended.cap[1]), NULL))
  			goto fail;
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
  	}
 =20
@@@ -993,55 -807,62 +966,55 @@@
  		goto fail;
  	}
 =20
- 	if (unpack_nameX(e, AA_STRUCT, "policydb")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "policydb")) {
  		/* generic policy dfa - optional and may be NULL */
  		info =3D "failed to unpack policydb";
 -		profile->policy.dfa =3D unpack_dfa(e);
 -		if (IS_ERR(profile->policy.dfa)) {
 -			error =3D PTR_ERR(profile->policy.dfa);
 -			profile->policy.dfa =3D NULL;
 -			goto fail;
 -		} else if (!profile->policy.dfa) {
 -			error =3D -EPROTO;
 +		error =3D unpack_pdb(e, &rules->policy, true, false,
 +				   &info);
 +		if (error)
  			goto fail;
 -		}
 -		if (!aa_unpack_u32(e, &profile->policy.start[0], "start"))
 -			/* default start state */
 -			profile->policy.start[0] =3D DFA_START;
 -		/* setup class index */
 -		for (i =3D AA_CLASS_FILE; i <=3D AA_CLASS_LAST; i++) {
 -			profile->policy.start[i] =3D
 -				aa_dfa_next(profile->policy.dfa,
 -					    profile->policy.start[0],
 -					    i);
 -		}
 +		/* Fixup: drop when we get rid of start array */
 +		if (aa_dfa_next(rules->policy.dfa, rules->policy.start[0],
 +				AA_CLASS_FILE))
 +			rules->policy.start[AA_CLASS_FILE] =3D
 +			  aa_dfa_next(rules->policy.dfa,
 +				      rules->policy.start[0],
 +				      AA_CLASS_FILE);
- 		if (!unpack_nameX(e, AA_STRUCTEND, NULL))
+ 		if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
  			goto fail;
 +		error =3D aa_compat_map_policy(&rules->policy, e->version);
 +		if (error) {
 +			info =3D "failed to remap policydb permission table";
 +			goto fail;
 +		}
  	} else
 -		profile->policy.dfa =3D aa_get_dfa(nulldfa);
 +		rules->policy.dfa =3D aa_get_dfa(nulldfa);
 =20
  	/* get file rules */
 -	profile->file.dfa =3D unpack_dfa(e);
 -	if (IS_ERR(profile->file.dfa)) {
 -		error =3D PTR_ERR(profile->file.dfa);
 -		profile->file.dfa =3D NULL;
 -		info =3D "failed to unpack profile file rules";
 +	error =3D unpack_pdb(e, &rules->file, false, true, &info);
 +	if (error) {
  		goto fail;
 -	} else if (profile->file.dfa) {
 -		if (!aa_unpack_u32(e, &profile->file.start, "dfa_start"))
 -			/* default start state */
 -			profile->file.start =3D DFA_START;
 -	} else if (profile->policy.dfa &&
 -		   profile->policy.start[AA_CLASS_FILE]) {
 -		profile->file.dfa =3D aa_get_dfa(profile->policy.dfa);
 -		profile->file.start =3D profile->policy.start[AA_CLASS_FILE];
 +	} else if (rules->file.dfa) {
 +		error =3D aa_compat_map_file(&rules->file);
 +		if (error) {
 +			info =3D "failed to remap file permission table";
 +			goto fail;
 +		}
 +	} else if (rules->policy.dfa &&
 +		   rules->policy.start[AA_CLASS_FILE]) {
 +		rules->file.dfa =3D aa_get_dfa(rules->policy.dfa);
 +		rules->file.start[AA_CLASS_FILE] =3D rules->policy.start[AA_CLASS_FILE];
  	} else
 -		profile->file.dfa =3D aa_get_dfa(nulldfa);
 -
 -	if (!unpack_trans_table(e, profile)) {
 -		info =3D "failed to unpack profile transition table";
 -		goto fail;
 -	}
 +		rules->file.dfa =3D aa_get_dfa(nulldfa);
 =20
 +	error =3D -EPROTO;
- 	if (unpack_nameX(e, AA_STRUCT, "data")) {
+ 	if (aa_unpack_nameX(e, AA_STRUCT, "data")) {
  		info =3D "out of memory";
  		profile->data =3D kzalloc(sizeof(*profile->data), GFP_KERNEL);
 -		if (!profile->data)
 +		if (!profile->data) {
 +			error =3D -ENOMEM;
  			goto fail;
 -
 +		}
  		params.nelem_hint =3D 3;
  		params.key_len =3D sizeof(void *);
  		params.key_offset =3D offsetof(struct aa_data, key);

--Sig_/URPKV2lGuO/w5zMvj.Rt1nW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmORUacACgkQAVBC80lX
0Gzxnwf/RMQYhRAPD8sRGAaPbx8HxDqynAxxSUxA4n/vdTtnQtILEQLS9GtqBP2b
PO0pRL5+24qobng4qzfIWzOWml1ci7G1E/+YSpdVmYxBu3LAan1q34YuxHZNWnq9
8p7y8rXBSR8DrbuZp9NJOGSkJmwqA+XixS83Gt9O/HN8eUTSR6y6mXe7lxCNTBa2
V4cklnALR3kTcog5kc1UmPkoGMzQbdClC2ftSeqNc0ZmH9WS94n1jGPcKmEgTh7f
g1tAxdsh7BwjjIYpotg9QAg0CSf5MaMnhNj5hok0BJUtWUwFC2D0ljSQzZrL7sib
j80YFHKaAjobG3BPvFp1nOQmJ1hKSQ==
=O7Ak
-----END PGP SIGNATURE-----

--Sig_/URPKV2lGuO/w5zMvj.Rt1nW--
