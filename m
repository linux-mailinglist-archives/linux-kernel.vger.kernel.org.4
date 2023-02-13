Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96997695112
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjBMTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjBMTtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:49:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE81422A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:49:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31443B811E7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 19:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05913C433EF;
        Mon, 13 Feb 2023 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676317785;
        bh=mhvgqYfAqTjy/VKv9b0aYKBmBeJxoIq2bTrUjjXJRqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brVXOcna0MFGLoe+hPERwo6OwYDuT73MEadplSo7J4EbFvsgokLiDws3SRCHwfPDX
         R48jBuHv7CERQ1kbKdhib11togTXY6iNnSFt4PHRw39ZtSSg1ba0PSXm21d7l+qSwW
         2i6K5dv/CTN8wMQCurBIClODHk5cxEJ3aD/hzaigLpbzAjjiby2oBVzgv8CQrAw9kJ
         05H7av4Ulx+5PJ8L8ffAi5yRWfCwoN3CrJZs+Ahy3Oke7ef2x3jQL5C3Nd+lf34Qh2
         gUlQFNO6uLVn4gidD5e5GRQUByHYXKKXQRU1H7V0sTuyO1ythyn3j1MB9b8Rdit8bf
         PNU0zAj4cS+Fg==
Date:   Mon, 13 Feb 2023 19:49:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yimin Gu <ustcymgu@gmail.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 3/3] riscv: configs: Add nommu defconfig for RV32
Message-ID: <Y+qUVbhFUrb289xG@spud>
References: <20230212205506.1992714-1-Mr.Bossman075@gmail.com>
 <20230212205506.1992714-4-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ebkPMjNMgdMpUKGJ"
Content-Disposition: inline
In-Reply-To: <20230212205506.1992714-4-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ebkPMjNMgdMpUKGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Jesse,

On Sun, Feb 12, 2023 at 03:55:06PM -0500, Jesse Taube wrote:
> 32bit risc-v can be configured to run without MMU. This patch adds
> an example configuration for RV32 nommu virtual machine.

There's a patch on the list (I think it came in after you sent v1) that
pointed out that the rv32_defconfig in the tree is not actually used if
you do `make ARCH=riscv rv32_defconfig`, but instead a make target is
used. How would you feel about replacing this final patch with the
below? That way rv32_nommu_virt_defconfig would always be kept in sync
with the rv64 version.

Cheers,
Conor.

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7123511d977c..785d438ae5fe 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -173,3 +173,7 @@ rv64_randconfig:
 PHONY += rv32_defconfig
 rv32_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 32-bit.config
+
+PHONY += rv32_nommu_virt_defconfig
+rv32_nommu_virt_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config


--ebkPMjNMgdMpUKGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+qUVQAKCRB4tDGHoIJi
0kFgAQCYPofRMpx2bKqIEIsrpZ9a6/XDF3qu48tQ1nCqMAhS7wEAxLDTChTgBccl
Jwsbb/bx+fBRBYIUI22Ki1sDz+k1uwA=
=YZsi
-----END PGP SIGNATURE-----

--ebkPMjNMgdMpUKGJ--
