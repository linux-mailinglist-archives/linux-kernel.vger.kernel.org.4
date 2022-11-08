Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F72D621A32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiKHRNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiKHRNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:13:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B151AF24
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EE5C616F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24078C433C1;
        Tue,  8 Nov 2022 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667927621;
        bh=Q9Hg77J+hEn8L00u0qa6BZ7pMVT5amjAWhxu/7L9ZfU=;
        h=From:To:Cc:Subject:Date:From;
        b=Lo6dFWKcTlR9+dBOhuw/BumPrjFGR31fDofSYIHW4hMcd+70Ib7hElVF+T04rsJBd
         dttFiSyH4eZG7yDGwrdqJsrYliD7HmYwxmfbB+ZeNgqW+xUE8l9e+tHIMb0uz0CKn3
         zSqzGk3cgxLirqeItEJIKNTiWAu6fHIW3x+vO9EWgKG27jr3oeP3VXM6jco8a2N8l3
         DbpIhLnsy98oVwwEit8gHJS7Kqx0ZKhoQ3TFW674pEW+EpBp10prQz2wqwYrKlWTev
         Esnkqw7i+WHgTrojt5j2AcAxDDlxb1xuz5ilVudLyjxyHrT/4Qqr/T/h3Zcgwd4QII
         Cl8v5Jp+qcs9g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] RISC-V: vdso: Do not add missing symbols to version section in linker script
Date:   Tue,  8 Nov 2022 10:13:23 -0700
Message-Id: <20221108171324.3377226-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Recently, ld.lld moved from '--undefined-version' to
'--no-undefined-version' as the default, which breaks the compat vDSO
build:

  ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_gettimeofday' failed: symbol not defined
  ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_gettime' failed: symbol not defined
  ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_getres' failed: symbol not defined

These symbols are not present in the compat vDSO or the regular vDSO for
32-bit but they are unconditionally included in the version section of
the linker script, which is prohibited with '--no-undefined-version'.

Fix this issue by only including the symbols that are actually exported
in the version section of the linker script.

Link: https://github.com/ClangBuiltLinux/linux/issues/1756
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/kernel/vdso/Makefile   | 3 +++
 arch/riscv/kernel/vdso/vdso.lds.S | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index f2e065671e4d..82416ebf4cca 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -28,6 +28,9 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
 obj-y += vdso.o
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
+ifneq ($(filter vgettimeofday, $(vdso-syms)),)
+CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
+endif
 
 # Disable -pg to prevent insert call site
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 01d94aae5bf5..150b1a572e61 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -68,9 +68,11 @@ VERSION
 	LINUX_4.15 {
 	global:
 		__vdso_rt_sigreturn;
+#ifdef HAS_VGETTIMEOFDAY
 		__vdso_gettimeofday;
 		__vdso_clock_gettime;
 		__vdso_clock_getres;
+#endif
 		__vdso_getcpu;
 		__vdso_flush_icache;
 	local: *;

base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.38.1

