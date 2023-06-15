Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8232730D54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbjFOCqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjFOCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:46:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B342126;
        Wed, 14 Jun 2023 19:46:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhRVy57Csz4wjF;
        Thu, 15 Jun 2023 12:46:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1686797163;
        bh=nKyzclnLPcWFjNYP7oi3eE77p75xY/56CGKsZnifZvg=;
        h=Date:From:To:Cc:Subject:From;
        b=FsF1vWY5Ns92exTXpbe/LmG54Y1xUzqv54VbSdGu/EIiiKtFkmsFbzPat6VI+JVnQ
         kK3QRe1a3dvlMAbnA1P5RE2VDTIEGDED7u6bGAKpN1fHe9ks/fk2/8hdbajlpfpOBZ
         dVW2rNYdjivBIRCsB5YWN2xZVOCvZVBjlafMU+01e0nkZ1KzRkP9u28RTJDIuWZst8
         iZsYSdgfviRUYDWz2//nXg/7He6xozKt2aDfIUXIOAscklFTrYxL5BWnT6uPQ3COvP
         +aVc4+yXoc63NctDkEJO1gv2ZRbjTcjvnngk1QLCh1A0M3IF5g0HzsQylUt2p2+t6X
         lLkSANyORFV0Q==
Date:   Thu, 15 Jun 2023 12:45:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20230615124558.2cea58b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XQPD4Xdl0k8WcknO4fxyhlV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XQPD4Xdl0k8WcknO4fxyhlV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/kaslr.c

between commit:

  6e13b6b923b3 ("arm64: kaslr: split kaslr/module initialization")
  e46b7103aef3 ("arm64: module: move module randomization to module.c")

from the arm64 tree and commit:

  0ddc312b7c73 ("arm64: Turn kaslr_feature_override into a generic SW featu=
re override")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This is
now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your
tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/kaslr.c
index 17f96a19781d,5d4ce7f5f157..000000000000
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@@ -4,33 -4,46 +4,33 @@@
   */
 =20
  #include <linux/cache.h>
 -#include <linux/crc32.h>
  #include <linux/init.h>
 -#include <linux/libfdt.h>
 -#include <linux/mm_types.h>
 -#include <linux/sched.h>
 -#include <linux/types.h>
 -#include <linux/pgtable.h>
 -#include <linux/random.h>
 +#include <linux/printk.h>
 =20
 -#include <asm/fixmap.h>
 -#include <asm/kernel-pgtable.h>
 +#include <asm/cpufeature.h>
  #include <asm/memory.h>
 -#include <asm/mmu.h>
 -#include <asm/sections.h>
 -#include <asm/setup.h>
 =20
 -u64 __ro_after_init module_alloc_base;
  u16 __initdata memstart_offset_seed;
 =20
- struct arm64_ftr_override kaslr_feature_override __initdata;
-=20
 -static int __init kaslr_init(void)
 +bool __ro_after_init __kaslr_is_enabled =3D false;
 +
 +void __init kaslr_init(void)
  {
- 	if (kaslr_feature_override.val & kaslr_feature_override.mask & 0xf) {
 -	u64 module_range;
 -	u32 seed;
 -
 -	/*
 -	 * Set a reasonable default for module_alloc_base in case
 -	 * we end up running with module randomization disabled.
 -	 */
 -	module_alloc_base =3D (u64)_etext - MODULES_VSIZE;
 -
+ 	if (cpuid_feature_extract_unsigned_field(arm64_sw_feature_override.val &
+ 						 arm64_sw_feature_override.mask,
+ 						 ARM64_SW_FEATURE_OVERRIDE_NOKASLR)) {
  		pr_info("KASLR disabled on command line\n");
 -		return 0;
 +		return;
  	}
 =20
 -	if (!kaslr_enabled()) {
 +	/*
 +	 * The KASLR offset modulo MIN_KIMG_ALIGN is taken from the physical
 +	 * placement of the image rather than from the seed, so a displacement
 +	 * of less than MIN_KIMG_ALIGN means that no seed was provided.
 +	 */
 +	if (kaslr_offset() < MIN_KIMG_ALIGN) {
  		pr_warn("KASLR disabled due to lack of seed\n");
 -		return 0;
 +		return;
  	}
 =20
  	pr_info("KASLR enabled\n");

--Sig_/XQPD4Xdl0k8WcknO4fxyhlV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSKe2YACgkQAVBC80lX
0GxrjggAgJEMNlX2l1yrvVCoHIjN27l0p7hocz9bu0rH0GE3WsIE9dm6t2jGPIO3
Y2cPzVzf7lUM2DnkLRTsOBQj9evwiLEllP6u/Lc7048yV9zz4FrUBeLIqBECk5WG
UyZiF9XVCb0L/dmuhor8vqx3nFRcYZbK7PWII1wn4NEVa/hZfpeKqrDhH3Okee6m
9YuFomSyGAagOTrWi4al6cz6eL3fsnc7fbaDxQL0dFTGTyzKN7/nytDGUtMIvz1i
xxyXbAvwOu7RekcsljO4caXGPJK1b06HM1U9D5CGB/nbbBEHQIKgy/HAIiYIOgNj
Ydi9tPUIg2vrpgzEbg2x+DD/Ay0zYw==
=6B52
-----END PGP SIGNATURE-----

--Sig_/XQPD4Xdl0k8WcknO4fxyhlV--
