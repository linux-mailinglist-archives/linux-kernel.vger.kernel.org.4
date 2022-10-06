Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22E5F6D11
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiJFRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiJFRgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B889C14AC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23DD3B82126
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920ECC433C1;
        Thu,  6 Oct 2022 17:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665077776;
        bh=6Kd6Cfp1rvHPpfb4ji75I6uAJNzL9gBziSSr10EhLDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJgxs2TOuJHRJBN+ADQp7NubX5fSN5dECYLkUvZ18eenSVHABLnH3PWA4MBd5bQsL
         yieoo0sLAcPMXVxbF4MptlgcvLmkuVdl98h+Gn1P6gDv+RHebl6qb2TPhn0ZRAnLTe
         /89Xni8TLMh+Y1guQODy/1+CvhRvui3+4NxJXvkD3kRRa7eRqVnDkde2Rvw3sOiHYZ
         iMwlK17F+4yjsNjLh8KjYu2PKU+XCCg023IVxjpbJGKMAYCEZyqPa4bVJKAHebk0K+
         GHauadUQgiiRUcXqOqpmve/v7XIYGhIvGh9w1xJxNfZRJ4CMaUmx7uv41TEHGyemuo
         Cn/KkNSKI4vEA==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/2] riscv: fix detection of toolchain Zihintpause support
Date:   Thu,  6 Oct 2022 18:35:21 +0100
Message-Id: <20221006173520.1785507-3-conor@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221006173520.1785507-1-conor@kernel.org>
References: <20221006173520.1785507-1-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

It is not sufficient to check if a toolchain supports a particular
extension without checking if the linker supports that extension
too. For example, Clang 15 supports Zihintpause but GNU bintutils
2.35.2 does not, leading build errors like so:

riscv64-linux-gnu-ld: -march=rv64i2p0_m2p0_a2p0_c2p0_zihintpause2p0: Invalid or unknown z ISA extension: 'zihintpause'

Add a TOOLCHAIN_HAS_ZIHINTPAUSE which checks if each of the compiler,
assembler and linker support the extension. Replace the ifdef in the
vdso with one depending on this new symbol.

Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Palmer:
The VDSO change will conflict with Samuel's one, resolution should be
trivial.. I only made that change as you warned me about checking for
the __riscv_foo stuff if I made the march string depend on the Kconfig
entry rather than on the Makefile's cc-option check.
---
 arch/riscv/Kconfig                      | 7 +++++++
 arch/riscv/Makefile                     | 3 +--
 arch/riscv/include/asm/vdso/processor.h | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6da36553158b..d7c53896e24f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -425,6 +425,13 @@ config RISCV_ISA_ZICBOM
 
 	   If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZIHINTPAUSE
+	bool
+	default y
+	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zihintpause)
+	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zihintpause)
+	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23600
+
 config FPU
 	bool "FPU support"
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3607d38edb4f..6651517f3962 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -60,8 +60,7 @@ riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICBOM) := $(riscv-march-y)_zicbom
 
 # Check if the toolchain supports Zihintpause extension
-toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
-riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
 KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
 KBUILD_AFLAGS += -march=$(riscv-march-y)
diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
index 1e4f8b4aef79..fa70cfe507aa 100644
--- a/arch/riscv/include/asm/vdso/processor.h
+++ b/arch/riscv/include/asm/vdso/processor.h
@@ -21,7 +21,7 @@ static inline void cpu_relax(void)
 		 * Reduce instruction retirement.
 		 * This assumes the PC changes.
 		 */
-#ifdef __riscv_zihintpause
+#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
 		__asm__ __volatile__ ("pause");
 #else
 		/* Encoding of the pause instruction */
-- 
2.37.3

