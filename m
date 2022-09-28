Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44475EE449
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiI1SZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbiI1SZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C35332BA4;
        Wed, 28 Sep 2022 11:25:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D9FE61F61;
        Wed, 28 Sep 2022 18:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C3FC433C1;
        Wed, 28 Sep 2022 18:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664389539;
        bh=D/ciu09dBj727+i/dCSd2okVI+OFeY1RXfqr8ayPQyw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ja6+Evw8ILUOwbp8ir0QYyANu1iVEBthMSfaxun0Lb1Z7HXRXkyImBlrl+ltFBUrF
         eAMXcxvhVmWoDu1tW62IsiCoSD0/u/enlyeHty+82QWL/lOovW2BKZswp7TVKGdnYr
         CxvmilxfPN0J24dSXYOXDU73LklcP8en1J3GxyTPI/q6VnoQpODjY0Ycguwx9QHe6u
         vTPVSS3qyGka3AE6skbCRr7gz1e0XNS7LlJPHs1s7t1z/PmNzD6kaO3sRm92Y+bzxT
         kywBAOh42GsixzjdjXP0gy6AsJ1kzt9MfBgbw9s4g6+SHLO0be9CDALFWnof0deesq
         9nBuhnGMxt6Aw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH] lib/Kconfig.debug: Add check for non-constant .{s,u}leb128 support to DWARF5
Date:   Wed, 28 Sep 2022 11:25:23 -0700
Message-Id: <20220928182523.3105953-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Tested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.debug | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d3e5f36bb01e..19de03ead2ed 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -231,6 +231,9 @@ config DEBUG_INFO
 	  in the "Debug information" choice below, indicating that debug
 	  information will be generated for build targets.
 
+config AS_HAS_NON_CONST_LEB128
+	def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
+
 choice
 	prompt "Debug information"
 	depends on DEBUG_KERNEL
@@ -277,6 +280,10 @@ config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
 	select DEBUG_INFO
 	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
+	# Clang is known to generate .{s,u}leb128 with symbol deltas with
+	# DWARF5, which some targets may not support.
+	# https://sourceware.org/bugzilla/show_bug.cgi?id=27215
+	depends on !CC_IS_CLANG || AS_HAS_NON_CONST_LEB128
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
 	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some

base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.37.3

