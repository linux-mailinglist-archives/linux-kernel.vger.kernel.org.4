Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAE5F06F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiI3I4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiI3Iz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:55:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6682EFA79;
        Fri, 30 Sep 2022 01:55:54 -0700 (PDT)
Received: from zoe.. ([133.106.55.175]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 28U8rqts023720;
        Fri, 30 Sep 2022 17:53:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 28U8rqts023720
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664528034;
        bh=Tm274TiG3B2iiGvBDqEFbW4L718Tn4XqQDBXl7M9Ar0=;
        h=From:To:Cc:Subject:Date:From;
        b=qkCuQ4XSb+ap67aLvju+F/uT2VYfDYE95qJ0YT4vATaHDXRYlBkvOi4HkJnSXeQuR
         Snq2489M8kSZpsD3L2yi1cDUWHV/PDXgEDTcQN/6dSPcISCBIVhsSVgFkN92mbCh0q
         RQCUdxZ92grLUvgwhpVYF5Rxz+WSL3tQhbIjxNbXrZvfucLgHKIruMFyGif0+OPsi/
         AbhX32QmDor7/d72+WDrt1EHG9PsGGgn1cAOTBa+5BnNIynLDgF4deENtrS02PcDRn
         GRGk8dVMFlJdqhLrd6vW7ejofGz6v3ycHacxJx3hN7366CPKWviLZGryCpyaC8F0rd
         tPpN9PyBstdVQ==
X-Nifty-SrcIP: [133.106.55.175]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] Kconfig.debug: split debug-level and DWARF-version into separate choices
Date:   Fri, 30 Sep 2022 17:53:51 +0900
Message-Id: <20220930085351.2648034-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

This commit cosolidates CONFIG options into two choices:

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
---

 lib/Kconfig.debug | 60 +++++++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d3e5f36bb01e..03e75a54be6c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -232,17 +232,11 @@ config DEBUG_INFO
 	  information will be generated for build targets.
 
 choice
-	prompt "Debug information"
+	prompt "Debug information level"
 	depends on DEBUG_KERNEL
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
@@ -250,9 +244,41 @@ config DEBUG_INFO_NONE
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
+endchoice # "Debug information level"
+
+choice
+	prompt "DWARF version"
+	depends on DEBUG_INFO
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
 config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	bool "Rely on the toolchain's implicit default DWARF version"
-	select DEBUG_INFO
 	help
 	  The implicit default version of DWARF debug info produced by a
 	  toolchain changes over time.
@@ -261,9 +287,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 	  support newer revisions, and prevent testing newer versions, but
 	  those should be less common scenarios.
 
+	  If unsure, say Y.
+
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
 	help
 	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
@@ -275,7 +302,6 @@ config DEBUG_INFO_DWARF4
 
 config DEBUG_INFO_DWARF5
 	bool "Generate DWARF Version 5 debuginfo"
-	select DEBUG_INFO
 	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
 	help
 	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
@@ -290,22 +316,10 @@ config DEBUG_INFO_DWARF5
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

