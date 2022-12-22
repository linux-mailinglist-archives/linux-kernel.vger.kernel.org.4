Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6030654332
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiLVOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiLVOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:34:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAEF2CC8A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:34:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C51861BD1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3701AC433D2;
        Thu, 22 Dec 2022 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671719660;
        bh=poi7LVDy/UFsrTmGwq6lioam1cMDnvdsbKnL0S9SBbA=;
        h=Date:From:To:Cc:Subject:From;
        b=gcCZUV4+mkMTZ38H1tAJ0bggdr67WBovVWDPfZpB00FlIgoNbmIBMfrHqrBrHlVLP
         0oGPYlTrWuQYBzzifWiriNkOFg7meCfgeEsd3C3LG5qtLyuaQvTYG4g4PZvjSaaMTQ
         lUA0PYW8O4DvfeBd/sRnLX0rwxtJo3pGUmqbfAlrEjF/nflv+VC1FL8MA/tMyFWo/6
         WnzwrNFojGHXaCNiT39dCs3DimvN2xJ3chbMKWZIUCoG0pVANMUH+5mI24itYdmDWJ
         2t07JMuhWmVI69GNr9At8zjd/sT9Jxm+MXeELyFskFHAYXvoCXgs72nuwi7/rL5Xk8
         BFQqSgLYW8sRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27B2340350; Thu, 22 Dec 2022 11:34:12 -0300 (-03)
Date:   Thu, 22 Dec 2022 11:34:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Khem Raj <raj.khem@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 fyi] perf python: Fix splitting CC into compiler and
 options
Message-ID: <Y6Rq5F5NI0v1QQHM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just fyi, I'm carrying this in the perf tools tree.

- Arnaldo

----

Noticed this build failure on archlinux:base when building with clang:

  clang-14: error: optimization flag '-ffat-lto-objects' is not supported [-Werror,-Wignored-optimization-argument]

In tools/perf/util/setup.py we check if clang supports that option, but
since commit 3cad53a6f9cdbafa ("perf python: Account for multiple words
in CC") this got broken as in the common case where CC="clang":

  >>> cc="clang"
  >>> print(cc.split()[0])
  clang
  >>> option="-ffat-lto-objects"
  >>> print(str(cc.split()[1:]) + option)
  []-ffat-lto-objects
  >>>

And then the Popen will call clang with that bogus option name that in
turn will not produce the b"unknown argument" or b"is not supported"
that this function uses to detect if the option is not available and
thus later on clang will be called with an unknown/unsupported option.

Fix it by looking if really there are options in the provided CC
variable, and if so override 'cc' with the first token and append the
options to the 'option' variable.

Fixes: 3cad53a6f9cdbafa ("perf python: Account for multiple words in CC")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Fangrui Song <maskray@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Keeping <john@metanate.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/setup.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 4f265d0222c454e2..c294db713677c0c2 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -3,11 +3,20 @@ from subprocess import Popen, PIPE
 from re import sub
 
 cc = getenv("CC")
-cc_is_clang = b"clang version" in Popen([cc.split()[0], "-v"], stderr=PIPE).stderr.readline()
+
+# Check if CC has options, as is the case in yocto, where it uses CC="cc --sysroot..."
+cc_tokens = cc.split()
+if len(cc_tokens) > 1:
+    cc = cc_tokens[0]
+    cc_options = " ".join([str(e) for e in cc_tokens[1:]]) + " "
+else:
+    cc_options = ""
+
+cc_is_clang = b"clang version" in Popen([cc, "-v"], stderr=PIPE).stderr.readline()
 src_feature_tests  = getenv('srctree') + '/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc.split()[0], str(cc.split()[1:]) + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
+    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o))] == [ ]
 
 if cc_is_clang:
-- 
2.38.1

