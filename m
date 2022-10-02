Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835345F2482
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJBSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBSMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:12:16 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46E1ADA2;
        Sun,  2 Oct 2022 11:12:14 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 292IBAaE004037;
        Mon, 3 Oct 2022 03:11:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 292IBAaE004037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664734273;
        bh=zCQAWimx1b0EV8M8GrWxsKCps/Q6cJmJi+PVar9Dm/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdDFG5jVelGC1W2G54sqFkE1Rm9LKIjgC3cjhbYr0KaxNvRKDDi2dn0TNiNSxXbwR
         YZnvecs9JMEMMdO/3FVjClheUGXHsbtKoE1ojTDBoVti91W4ZiWN9y4PxjDpALoMCf
         hi0wZRpuig4U91iw6KdrbSWbjaa/iKyEHVI245xubgLJz/ki1/PB4XPcyCqqRNMZyz
         hXuGs7/T+XozI+/UacigH5ZFFDZzaZx2VwGRaO5g1uCNQOiz1mINTnI7zQw2bF74H4
         synPbEGye3IOnt02HVOHyt133v3aujCfxDzj0oJplF1fFjnjQEVymF5G3+IMJ7Ik6R
         RWz5XaY6YCUsQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 3/3] Kconfig.debug: split debug-level and DWARF-version into separate choices
Date:   Mon,  3 Oct 2022 03:11:07 +0900
Message-Id: <20221002181107.51286-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002181107.51286-1-masahiroy@kernel.org>
References: <20221002181107.51286-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
but it should rather belong to the debug level choice.

This commit consolidates CONFIG options into two choices:

 - Debug info level (NONE / REDUCED / DEFAULT)

 - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)

This is more consistent with compilers' policy because the -g0 compiler
flag means "no debug info".

  GCC manual:

    -g<level>

      Request debugging information and also use level to specify how
      much information. The default level is 2.

      Level 0 produces no debug information at all. Thus, -g0 negates -g.

      Level 1 produces minimal information, enough for making backtraces
      in parts of the program that you don’t plan to debug. This includes
      descriptions of functions and external variables, and line number
      tables, but no information about local variables.

      Level 3 includes extra information, such as all the macro
      definitions present in the program. Some debuggers support macro
      expansion when you use -g3.

  Rustc Codegen manual:

    debuginfo

      This flag controls the generation of debug information. It takes
      one of the following values:

      0: no debug info at all (the default).
      1: line tables only.
      2: full debug info.

I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.

This change will make it easier to add another debug info level if
necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
---

 lib/Kconfig.debug | 59 +++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cc90414d492e..ce1faae1a979 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -234,15 +234,10 @@ config DEBUG_INFO
 choice
 	prompt "Debug information"
 	depends on DEBUG_KERNEL
+	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Selecting something other than "None" results in a kernel image
 	  that will include debugging info resulting in a larger kernel image.
-	  This adds debug symbols to the kernel and modules (gcc -g), and
-	  is needed if you intend to use kernel crashdump or binary object
-	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
-
-	  Choose which version of DWARF debug info to emit. If unsure,
-	  select "Toolchain default".
 
 config DEBUG_INFO_NONE
 	bool "Disable debug information"
@@ -250,10 +245,40 @@ config DEBUG_INFO_NONE
 	  Do not build the kernel with debugging information, which will
 	  result in a faster and smaller build.
 
+config DEBUG_INFO_REDUCED
+	bool "Reduced debugging information"
+	select DEBUG_INFO
+	help
+	  If you say Y here compiler is instructed to generate less debugging
+	  information for structure types. This means that tools that
+	  need full debugging information (like kgdb or systemtap) won't
+	  be happy. But if you merely need debugging information to
+	  resolve line numbers there is no loss. Advantage is that
+	  build directory object sizes shrink dramatically over a full
+	  DEBUG_INFO build and compile times are reduced too.
+	  Only works with newer gcc versions.
+
+config DEBUG_INFO_DEFAULT
+	bool "Default-level debugging information"
+	select DEBUG_INFO
+	help
+	  If you say Y here compiler is instructed to generate the default
+	  level of debugging information.
+
+	  This adds debug symbols to the kernel and modules (gcc -g), and
+	  is needed if you intend to use kernel crashdump or binary object
+	  tools like crash, kgdb, LKCD, gdb, etc on the kernel.
+
+endchoice # "Debug information"
+
+choice
+	prompt "DWARF version"
+	depends on DEBUG_INFO
+	help
+	  Which version of DWARF debug info to emit.
+
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
-	select DEBUG_INFO
-	depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
@@ -262,9 +287,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	  support newer revisions, and prevent testing newer versions, but
 	  those should be less common scenarios.
 
+	  If unsure, say Y.
+
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
@@ -276,7 +302,6 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
@@ -291,22 +316,10 @@ config DEBUG_INFO_DWARF5
 	  config if they rely on tooling that has not yet been updated to
 	  support DWARF Version 5.
 
-endchoice # "Debug information"
+endchoice # "DWARF version"
 
 if DEBUG_INFO
 
-config DEBUG_INFO_REDUCED
-	bool "Reduce debugging information"
-	help
-	  If you say Y here gcc is instructed to generate less debugging
-	  information for structure types. This means that tools that
-	  need full debugging information (like kgdb or systemtap) won't
-	  be happy. But if you merely need debugging information to
-	  resolve line numbers there is no loss. Advantage is that
-	  build directory object sizes shrink dramatically over a full
-	  DEBUG_INFO build and compile times are reduced too.
-	  Only works with newer gcc versions.
-
 config DEBUG_INFO_COMPRESSED
 	bool "Compressed debugging information"
 	depends on $(cc-option,-gz=zlib)
-- 
2.34.1

