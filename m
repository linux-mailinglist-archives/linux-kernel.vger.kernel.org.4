Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F65639EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 02:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiK1BaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 20:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1BaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 20:30:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED70A45A;
        Sun, 27 Nov 2022 17:30:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL7F03kRbz4x7X;
        Mon, 28 Nov 2022 12:29:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669598997;
        bh=ZRRd6Gk8NWLzfHY82OUx4YCkMM3vE3XCFIJ8nTVL9TY=;
        h=Date:From:To:Cc:Subject:From;
        b=cS+hEbvSamFGFXQYcxoSOG7KKcbDzq4/3Owjw72mEtzEzmf9AT9+VG7C86mfK01hn
         hIAGAbDmlpuqFqmevr/rMrpfwAkPhiIg4oPhR4wlsze1CC/2pGjJIM07yzW0VYWJka
         bk+3l3ragKov1J8uICwP5sqifWX8QQT/vgcsjUb+FvHI3rOD53VQSEHXDAzaoGfH0k
         pVJoV9JQ1mRf0Iaz8l1n0fcWRk267Yh6f+j1g5v2+Ppzf1BI+zRuR5x1vE+DlaGGbs
         51O5JNUVvnuWbX7i3WHwTgP/DjD7NoifNoqo94lr0QiAY7U38UHAX9uJWnJB/NrAtv
         xEId8sqGQADuw==
Date:   Mon, 28 Nov 2022 12:29:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the crypto tree
Message-ID: <20221128122955.2f946b91@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xGg3BgsRxwqPA.oNe7gxZDF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xGg3BgsRxwqPA.oNe7gxZDF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  arch/x86/crypto/sha1_ni_asm.S
  arch/x86/crypto/sha256-avx-asm.S
  arch/x86/crypto/sha256-avx2-asm.S
  arch/x86/crypto/sha256-ssse3-asm.S
  arch/x86/crypto/sha256_ni_asm.S
  arch/x86/crypto/sm3-avx-asm_64.S
  arch/x86/crypto/sm4-aesni-avx-asm_64.S
  arch/x86/crypto/sm4-aesni-avx2-asm_64.S

between commits:

  32f34bf7e44e ("crypto: x86/sha1 - fix possible crash with CFI enabled")
  19940ebbb59c ("crypto: x86/sha256 - fix possible crash with CFI enabled")
  8ba490d9f5a5 ("crypto: x86/sm3 - fix possible crash with CFI enabled")
  2d203c46a0fa ("crypto: x86/sm4 - fix crash with CFI enabled")

from the crypto tree and commits:

  c2a3ce6fdb12 ("crypto: x86/sha1: Remove custom alignments")
  3ba56d0b8711 ("crypto: x86/sha256: Remove custom alignments")
  2f93238b87dd ("crypto: x86/sm[34]: Remove redundant alignments")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/crypto/sha1_ni_asm.S
index 3cae5a1bb3d6,cd943b2af2c4..000000000000
--- a/arch/x86/crypto/sha1_ni_asm.S
+++ b/arch/x86/crypto/sha1_ni_asm.S
@@@ -93,8 -92,7 +93,7 @@@
   * numBlocks: Number of blocks to process
   */
  .text
- .align 32
 -SYM_FUNC_START(sha1_ni_transform)
 +SYM_TYPED_FUNC_START(sha1_ni_transform)
  	push		%rbp
  	mov		%rsp, %rbp
  	sub		$FRAME_SIZE, %rsp
diff --cc arch/x86/crypto/sha256-avx-asm.S
index 06ea30c20828,3649370690c5..000000000000
--- a/arch/x86/crypto/sha256-avx-asm.S
+++ b/arch/x86/crypto/sha256-avx-asm.S
@@@ -347,8 -346,7 +347,7 @@@ a =3D TMP
  ## arg 3 : Num blocks
  ########################################################################
  .text
 -SYM_FUNC_START(sha256_transform_avx)
 +SYM_TYPED_FUNC_START(sha256_transform_avx)
- .align 32
  	pushq   %rbx
  	pushq   %r12
  	pushq   %r13
diff --cc arch/x86/crypto/sha256-avx2-asm.S
index 2d2be531a11e,c4c1dc5ee078..000000000000
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@@ -524,8 -523,7 +524,7 @@@ STACK_SIZE	=3D _CTX      + _CTX_SIZ
  ## arg 3 : Num blocks
  ########################################################################
  .text
 -SYM_FUNC_START(sha256_transform_rorx)
 +SYM_TYPED_FUNC_START(sha256_transform_rorx)
- .align 32
  	pushq	%rbx
  	pushq	%r12
  	pushq	%r13
diff --cc arch/x86/crypto/sha256-ssse3-asm.S
index 7db28839108d,96b7dcdeaebe..000000000000
--- a/arch/x86/crypto/sha256-ssse3-asm.S
+++ b/arch/x86/crypto/sha256-ssse3-asm.S
@@@ -356,8 -355,7 +356,7 @@@ a =3D TMP
  ## arg 3 : Num blocks
  ########################################################################
  .text
 -SYM_FUNC_START(sha256_transform_ssse3)
 +SYM_TYPED_FUNC_START(sha256_transform_ssse3)
- .align 32
  	pushq   %rbx
  	pushq   %r12
  	pushq   %r13
diff --cc arch/x86/crypto/sha256_ni_asm.S
index 47f93937f798,b3f1a1a12027..000000000000
--- a/arch/x86/crypto/sha256_ni_asm.S
+++ b/arch/x86/crypto/sha256_ni_asm.S
@@@ -97,8 -96,7 +97,7 @@@
   */
 =20
  .text
- .align 32
 -SYM_FUNC_START(sha256_ni_transform)
 +SYM_TYPED_FUNC_START(sha256_ni_transform)
 =20
  	shl		$6, NUM_BLKS		/*  convert to bytes */
  	jz		.Ldone_hash
diff --cc arch/x86/crypto/sm3-avx-asm_64.S
index 8fc5ac681fd6,b28d804ee10d..000000000000
--- a/arch/x86/crypto/sm3-avx-asm_64.S
+++ b/arch/x86/crypto/sm3-avx-asm_64.S
@@@ -328,8 -327,7 +328,7 @@@
   * void sm3_transform_avx(struct sm3_state *state,
   *                        const u8 *data, int nblocks);
   */
- .align 16
 -SYM_FUNC_START(sm3_transform_avx)
 +SYM_TYPED_FUNC_START(sm3_transform_avx)
  	/* input:
  	 *	%rdi: ctx, CTX
  	 *	%rsi: data (64*nblks bytes)
diff --cc arch/x86/crypto/sm4-aesni-avx-asm_64.S
index 22b6560eb9e1,e13c8537b2ec..000000000000
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@@ -420,8 -415,7 +416,7 @@@ SYM_FUNC_END(sm4_aesni_avx_crypt8
   * void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
   *                                 const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (8 blocks)
@@@ -495,8 -489,7 +490,7 @@@ SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8
   * void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
   *                                 const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (8 blocks)
@@@ -545,8 -538,7 +539,7 @@@ SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8
   * void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
   *                                 const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (8 blocks)
diff --cc arch/x86/crypto/sm4-aesni-avx2-asm_64.S
index 23ee39a8ada8,2212705f7da6..000000000000
--- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@@ -282,8 -278,7 +279,7 @@@ SYM_FUNC_END(__sm4_crypt_blk16
   * void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
   *                                   const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (16 blocks)
@@@ -395,8 -390,7 +391,7 @@@ SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk
   * void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
   *                                   const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (16 blocks)
@@@ -449,8 -443,7 +444,7 @@@ SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk
   * void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
   *                                   const u8 *src, u8 *iv)
   */
- .align 8
 -SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
 +SYM_TYPED_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
  	/* input:
  	 *	%rdi: round key array, CTX
  	 *	%rsi: dst (16 blocks)

--Sig_/xGg3BgsRxwqPA.oNe7gxZDF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOEDxMACgkQAVBC80lX
0GwMGwgAge2NkOZEXniXUJgME6xyJk1Xt5TH0JZGjj0rrBKpZNK4egIeubx0do4s
tb+wdjnkKepVDjMlj6yrK8LEuGKSQTCpjjl4lYccZWinmbAJI7zDw/JO87ZTkmCq
JtJ2t31VH5Hw0mZbyO91+mMS2seR6/MGnLYUNF3+WFX7bQNPW9l3LMnMHSO61XkZ
onhS6XWUHlegU1l2tbgT1SP177GU/D1L5LNzWWM64Kv6rpHabuzLpyieE83C46I3
52oqzSjT8Q70Sq1Uns/uigzpqB7ylXNMpn44MatXE87vb1ea0vRxg/+a8ep1hqGB
rPhvTHmzz7omg/I6Qvnp1pNA+J4cfA==
=2waI
-----END PGP SIGNATURE-----

--Sig_/xGg3BgsRxwqPA.oNe7gxZDF--
