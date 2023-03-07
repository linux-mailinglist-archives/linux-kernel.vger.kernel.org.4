Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6534D6AD357
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCGA1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCGA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:27:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FCA2B291;
        Mon,  6 Mar 2023 16:27:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PVx910jpdz4whh;
        Tue,  7 Mar 2023 11:27:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678148837;
        bh=UjxEY4JMdU+v4Ea7+Ufew8YWqYvURVFt/iiJkJ/ewxI=;
        h=Date:From:To:Cc:Subject:From;
        b=ciCfjQQmNpN47wmzs451YacZDxKvc88SuncQ/YGQkborZ+8RBU0iozrLZkVJy+43d
         naP9QBFFrg6JGbLJSwIi/wUKpR3FfWV2UKgOzwv/a2mBd900TCIWJmKpG4iURXVK9h
         itLviYtLbnDec8V588zmhIwoTTcnSYZ5VJr4aHlM5J37/+e2FqpH12ytmTEvPtSVed
         NNI8uz9xfJh9Kb3B9qvC5MQ1Lp/nwkhcQIFGmP9sfXXWMlVwoTkxreUWrsAEHFigbA
         +7wGYu3BNQPQoYNdxAiRKLdWPLT0ItyYMgap3q1DoqdZnQkPu04CiHWlhCdZ97EBxT
         Dcg7MPqmkevkA==
Date:   Tue, 7 Mar 2023 11:27:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bitmap tree with Linus' tree
Message-ID: <20230307112716.067bd9c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bWIMc5Bufqt2RdLa7DK2Bab";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bWIMc5Bufqt2RdLa7DK2Bab
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  include/linux/cpumask.h

between commit:

  596ff4a09b89 ("cpumask: re-introduce constant-sized cpumask optimizations=
")

from Linus' tree and commit:

  1507ca9f866c ("bitmap: switch from inline to __always_inline")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/cpumask.h
index ce8eb7ef2107,fcb35ea34090..000000000000
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@@ -157,9 -124,9 +157,9 @@@ static __always_inline unsigned int cpu
   *
   * Returns >=3D nr_cpu_ids if no cpus set.
   */
- static inline unsigned int cpumask_first(const struct cpumask *srcp)
+ static __always_inline unsigned int cpumask_first(const struct cpumask *s=
rcp)
  {
 -	return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
 +	return find_first_bit(cpumask_bits(srcp), small_cpumask_bits);
  }
 =20
  /**
@@@ -168,9 -135,9 +168,9 @@@
   *
   * Returns >=3D nr_cpu_ids if all cpus are set.
   */
- static inline unsigned int cpumask_first_zero(const struct cpumask *srcp)
+ static __always_inline unsigned int cpumask_first_zero(const struct cpuma=
sk *srcp)
  {
 -	return find_first_zero_bit(cpumask_bits(srcp), nr_cpumask_bits);
 +	return find_first_zero_bit(cpumask_bits(srcp), small_cpumask_bits);
  }
 =20
  /**
@@@ -180,10 -147,10 +180,10 @@@
   *
   * Returns >=3D nr_cpu_ids if no cpus set in both.  See also cpumask_next=
_and().
   */
- static inline
+ static __always_inline
  unsigned int cpumask_first_and(const struct cpumask *srcp1, const struct =
cpumask *srcp2)
  {
 -	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_c=
pumask_bits);
 +	return find_first_and_bit(cpumask_bits(srcp1), cpumask_bits(srcp2), smal=
l_cpumask_bits);
  }
 =20
  /**
@@@ -192,9 -159,9 +192,9 @@@
   *
   * Returns	>=3D nr_cpumask_bits if no CPUs set.
   */
- static inline unsigned int cpumask_last(const struct cpumask *srcp)
+ static __always_inline unsigned int cpumask_last(const struct cpumask *sr=
cp)
  {
 -	return find_last_bit(cpumask_bits(srcp), nr_cpumask_bits);
 +	return find_last_bit(cpumask_bits(srcp), small_cpumask_bits);
  }
 =20
  /**
@@@ -279,10 -246,20 +279,10 @@@ unsigned int cpumask_next_and(int n, co
   * After the loop, cpu is >=3D nr_cpu_ids.
   */
  #define for_each_cpu(cpu, mask)				\
 -	for_each_set_bit(cpu, cpumask_bits(mask), nr_cpumask_bits)
 -
 -/**
 - * for_each_cpu_not - iterate over every cpu in a complemented mask
 - * @cpu: the (optionally unsigned) integer iterator
 - * @mask: the cpumask pointer
 - *
 - * After the loop, cpu is >=3D nr_cpu_ids.
 - */
 -#define for_each_cpu_not(cpu, mask)				\
 -	for_each_clear_bit(cpu, cpumask_bits(mask), nr_cpumask_bits)
 +	for_each_set_bit(cpu, cpumask_bits(mask), small_cpumask_bits)
 =20
  #if NR_CPUS =3D=3D 1
- static inline
+ static __always_inline
  unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int sta=
rt, bool wrap)
  {
  	cpumask_check(start);
@@@ -377,9 -354,9 +377,9 @@@ unsigned int cpumask_any_but(const stru
   *
   * Returns >=3D nr_cpu_ids if such cpu doesn't exist.
   */
- static inline unsigned int cpumask_nth(unsigned int cpu, const struct cpu=
mask *srcp)
+ static __always_inline unsigned int cpumask_nth(unsigned int cpu, const s=
truct cpumask *srcp)
  {
 -	return find_nth_bit(cpumask_bits(srcp), nr_cpumask_bits, cpumask_check(c=
pu));
 +	return find_nth_bit(cpumask_bits(srcp), small_cpumask_bits, cpumask_chec=
k(cpu));
  }
 =20
  /**
@@@ -518,23 -495,19 +518,23 @@@ static __always_inline bool cpumask_tes
  /**
   * cpumask_setall - set all cpus (< nr_cpu_ids) in a cpumask
   * @dstp: the cpumask pointer
 + *
 + * Note: since we set bits, we should use the tighter 'bitmap_set()' with
 + * the eact number of bits, not 'bitmap_fill()' that will fill past the
 + * end.
   */
- static inline void cpumask_setall(struct cpumask *dstp)
+ static __always_inline void cpumask_setall(struct cpumask *dstp)
  {
 -	bitmap_fill(cpumask_bits(dstp), nr_cpumask_bits);
 +	bitmap_set(cpumask_bits(dstp), 0, nr_cpumask_bits);
  }
 =20
  /**
   * cpumask_clear - clear all cpus (< nr_cpu_ids) in a cpumask
   * @dstp: the cpumask pointer
   */
- static inline void cpumask_clear(struct cpumask *dstp)
+ static __always_inline void cpumask_clear(struct cpumask *dstp)
  {
 -	bitmap_zero(cpumask_bits(dstp), nr_cpumask_bits);
 +	bitmap_zero(cpumask_bits(dstp), large_cpumask_bits);
  }
 =20
  /**
@@@ -652,9 -637,9 +652,9 @@@ static __always_inline bool cpumask_sub
   * cpumask_empty - *srcp =3D=3D 0
   * @srcp: the cpumask to that all cpus < nr_cpu_ids are clear.
   */
- static inline bool cpumask_empty(const struct cpumask *srcp)
+ static __always_inline bool cpumask_empty(const struct cpumask *srcp)
  {
 -	return bitmap_empty(cpumask_bits(srcp), nr_cpumask_bits);
 +	return bitmap_empty(cpumask_bits(srcp), small_cpumask_bits);
  }
 =20
  /**
@@@ -670,9 -655,9 +670,9 @@@ static __always_inline bool cpumask_ful
   * cpumask_weight - Count of bits in *srcp
   * @srcp: the cpumask to count bits (< nr_cpu_ids) in.
   */
- static inline unsigned int cpumask_weight(const struct cpumask *srcp)
+ static __always_inline unsigned int cpumask_weight(const struct cpumask *=
srcp)
  {
 -	return bitmap_weight(cpumask_bits(srcp), nr_cpumask_bits);
 +	return bitmap_weight(cpumask_bits(srcp), small_cpumask_bits);
  }
 =20
  /**
@@@ -680,10 -665,10 +680,10 @@@
   * @srcp1: the cpumask to count bits (< nr_cpu_ids) in.
   * @srcp2: the cpumask to count bits (< nr_cpu_ids) in.
   */
- static inline unsigned int cpumask_weight_and(const struct cpumask *srcp1,
+ static __always_inline unsigned int cpumask_weight_and(const struct cpuma=
sk *srcp1,
  						const struct cpumask *srcp2)
  {
 -	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), nr_cp=
umask_bits);
 +	return bitmap_weight_and(cpumask_bits(srcp1), cpumask_bits(srcp2), small=
_cpumask_bits);
  }
 =20
  /**
@@@ -717,10 -702,10 +717,10 @@@ static __always_inline void cpumask_shi
   * @dstp: the result
   * @srcp: the input cpumask
   */
- static inline void cpumask_copy(struct cpumask *dstp,
+ static __always_inline void cpumask_copy(struct cpumask *dstp,
  				const struct cpumask *srcp)
  {
 -	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), nr_cpumask_bits);
 +	bitmap_copy(cpumask_bits(dstp), cpumask_bits(srcp), large_cpumask_bits);
  }
 =20
  /**
@@@ -802,9 -787,9 +802,9 @@@ static __always_inline int cpulist_pars
  /**
   * cpumask_size - size to allocate for a 'struct cpumask' in bytes
   */
- static inline unsigned int cpumask_size(void)
+ static __always_inline unsigned int cpumask_size(void)
  {
 -	return BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long);
 +	return BITS_TO_LONGS(large_cpumask_bits) * sizeof(long);
  }
 =20
  /*

--Sig_/bWIMc5Bufqt2RdLa7DK2Bab
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQGhOQACgkQAVBC80lX
0Gw4fAgApO3Ztrqi/4su3TYLBkwoKw0sjZy4OleOxJ2E+54YOZ0Iu+lQsymvL52S
jlQHIaaTa4MV8tW1ZWgygYAHBRN6eDpq0w5yFnNXlFhsUN0wUruHNBZK/D0mdajh
LUTzDzuCrCzYx/ImXuxorYnHjycKjolHEvd6Z17YpvN4FZ835PTo38FQwnPcn+24
UaW9sWlnJbn7adEU0ZnuZAziA40FXfCcAKnXz6w90slex7/QgQJtmVulhUxHS6cp
q0nW9U61Z53PSv6eaIfd70pGs9EyAdo8Q6IrJLjtiUS54Udybu2C4SCAArK9XZQo
3nRI/BZAmz0tUrKYKJS7LwXpc4SU6g==
=EoWQ
-----END PGP SIGNATURE-----

--Sig_/bWIMc5Bufqt2RdLa7DK2Bab--
