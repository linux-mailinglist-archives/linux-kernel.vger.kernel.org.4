Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287455FF4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiJNUsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiJNUsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:48:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39481ACABB;
        Fri, 14 Oct 2022 13:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74554B82421;
        Fri, 14 Oct 2022 20:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60012C433D7;
        Fri, 14 Oct 2022 20:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665780493;
        bh=C3fOH2Mc8DRWmLYpWhPGyuj4dAcW5kYVpSBvOUxOFQc=;
        h=From:To:Cc:Subject:Date:From;
        b=pJdQ+TDxYwMeWzyEJyOKQ5BBV7ferow6GiaZchv9FWLdvRFrEENkmGWbNI5VhI9bZ
         QLEBqI3IDlO1DXZiVCzavpUqsRVOpOUJ4xN7SYmSBjY2vKx1N6wRTFZpeCKCpt3QWM
         MS9lRqcCaFCLrPizqRwI/wM+FNAJM+G8tpYP0AB4V8roJSuVicX095kjfB1qLmYIrM
         f0VMKqzxb90LlGeTyyckFIwNSqUSNrizHWqiJAve0tygFODyI0vZGfzgRUvaxeqDla
         lk/i63GdyfprtGwB8flJkDu7+uKY/v3bMn3c3jpHZFiLZ44xURS2ryrya4R2kpvhiP
         OgjlJzPY9Sp+Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2] lib/Kconfig.debug: Add check for non-constant .{s,u}leb128 support to DWARF5
Date:   Fri, 14 Oct 2022 13:42:11 -0700
Message-Id: <20221014204210.383380-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.0
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

When building with a RISC-V kernel with DWARF5 debug info using clang
and the GNU assembler, several instances of the following error appear:

  /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported

Dumping the .s file reveals these .uleb128 directives come from
.debug_loc and .debug_ranges:

  .Ldebug_loc0:
          .byte   4                               # DW_LLE_offset_pair
          .uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
          .uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
          .byte   1                               # Loc expr size
          .byte   90                              # DW_OP_reg10
          .byte   0                               # DW_LLE_end_of_list

  .Ldebug_ranges0:
          .byte   4                               # DW_RLE_offset_pair
          .uleb128 .Ltmp6-.Lfunc_begin0           #   starting offset
          .uleb128 .Ltmp27-.Lfunc_begin0          #   ending offset
          .byte   4                               # DW_RLE_offset_pair
          .uleb128 .Ltmp28-.Lfunc_begin0          #   starting offset
          .uleb128 .Ltmp30-.Lfunc_begin0          #   ending offset
          .byte   0                               # DW_RLE_end_of_list

There is an outstanding binutils issue to support a non-constant operand
to .sleb128 and .uleb128 in GAS for RISC-V but there does not appear to
be any movement on it, due to concerns over how it would work with
linker relaxation.

To avoid these build errors, prevent DWARF5 from being selected when
using clang and an assembler that does not have support for these symbol
deltas, which can be easily checked in Kconfig with as-instr plus the
small test program from the dwz test suite from the binutils issue.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
Link: https://github.com/ClangBuiltLinux/linux/issues/1719
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v2:
    - Rebase on commit bb1435f3f575 ("Kconfig.debug: add toolchain
      checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT") from the kbuild
      tree.
    - Limit CONFIG_AS_HAS_NON_CONST_LEB128 dependency to GNU as. There
      is no point to applying this dependency to the integrated
      assembler because it will always pass.
    - Apply the CONFIG_AS_HAS_NON_CONST_LEB128 dependency to
      CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as well, due to the
      aforementioned kbuild change.
    - Move comment block to above CONFIG_AS_HAS_NON_CONST_LEB128, as the
      configuration is now used in two places.
    - Drop Conor's tested by, as the patch is different enough to
      potentially require new testing.

v1: https://lore.kernel.org/20220928182523.3105953-1-nathan@kernel.org/

 lib/Kconfig.debug | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index db8d9271cabf..5c1c63575895 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -231,6 +231,11 @@ config DEBUG_INFO
 	  in the "Debug information" choice below, indicating that debug
 	  information will be generated for build targets.
 
+# Clang is known to generate .{s,u}leb128 with symbol deltas with DWARF5, which
+# some targets may not support: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
+config AS_HAS_NON_CONST_LEB128
+	def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
+
 choice
 	prompt "Debug information"
 	depends on DEBUG_KERNEL
@@ -253,7 +258,7 @@ config DEBUG_INFO_NONE
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
+	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
@@ -277,7 +282,7 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
 	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
+	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
 	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some

base-commit: bb1435f3f575b5213eaf27434efa3971f51c01de
-- 
2.38.0

