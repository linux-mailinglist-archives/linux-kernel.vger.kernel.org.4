Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE120601C89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJQWmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJQWl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:41:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A87C1DC;
        Mon, 17 Oct 2022 15:41:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrsS15t9zz4x1G;
        Tue, 18 Oct 2022 09:41:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666046514;
        bh=Svfbpekr8l+cruikb0VblpuqiyFBzQGVTDIwB4rSlyg=;
        h=Date:From:To:Cc:Subject:From;
        b=pnzHY6cP+45a2ghSTqDlRwlruy11J9er28Ob1UVxSv9mL3Z/rSRgFcsKI55zLoVZa
         56O3HsDy/MmeL4CRl/JwUyW/L9FL/Z7nfM0uHtobEMufkycOerJcyg/80TS9Tixui9
         Mk2/YDDJeG7fo7q1nx4F6Sj2g2R3Y7OuJYj6THBku+GaP45neJs30ymqoZIAXoIxDR
         Fg12CJslzEwI+hXJyCblaFRb3AY3KEF+186JZPA/WwHkbH1gcqbyXgaqvzqvC7auRH
         pHAyF/yGIMHfHbfhy8Cd8yV5HEhmKPmba5URMeYeYMLZMAKBPoxIaB4U7MtO7pPLKw
         1VZDlGEQfAW4g==
Date:   Tue, 18 Oct 2022 09:41:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20221018094152.39787a20@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o8Kwt..5HbQ8hGw799583UI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o8Kwt..5HbQ8hGw799583UI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  arch/loongarch/Kconfig

between commit:

  c78c43fe7d42 ("LoongArch: Use acpi_arch_dma_setup() and remove ARCH_HAS_P=
HYS_TO_DMA")

from Linus' tree and commit:

  839fc1e464eb ("arch/loongarch: Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig=
 option")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/loongarch/Kconfig
index 903096bd87f8,c8864768dc4d..000000000000
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@@ -10,6 -10,8 +10,7 @@@ config LOONGARC
  	select ARCH_ENABLE_MEMORY_HOTPLUG
  	select ARCH_ENABLE_MEMORY_HOTREMOVE
  	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+ 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 -	select ARCH_HAS_PHYS_TO_DMA
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
  	select ARCH_INLINE_READ_LOCK if !PREEMPTION

--Sig_/o8Kwt..5HbQ8hGw799583UI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNN2jAACgkQAVBC80lX
0GwA1Af/X3nWrtCvnFjZLknd8JHkZLYdgTRE/VMp1nMS+yuyaGaxa1DFYqy3jpnU
dggMJwPdJsjegS+gj2o8oILHd8quF8jbbikWX7592Xc7bhVX7wJO0PTRc0rnpRty
vgyaL9CYGvgvNIi+1QLbYm535nB+DBJXmv1/DQNSJyl2Z3bjHDEBugazB8b8S6HH
zaoLhBR2RVik208fbQepooAU00qcVOQPnPR9v3S7kiqnQgXnc2RPERLBA6hHYKMd
2ITXI3ORbSsuMvk2ARJzVN1cbtYKMMEG1EX4o4MahVFLN5yqZApUPLvfOxxQQXJ5
+G+A/Pg6x9SEYlorvd1RVck9zEmkZA==
=ikNb
-----END PGP SIGNATURE-----

--Sig_/o8Kwt..5HbQ8hGw799583UI--
