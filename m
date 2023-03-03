Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CF16A991C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCCOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:09:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24D34741B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 709FFB818DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC3CC433D2;
        Fri,  3 Mar 2023 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677852561;
        bh=DWuc80TU6jIXIb2OlS5m6P6q2jqlotFX19yA8oo6ATY=;
        h=Date:From:To:Cc:Subject:From;
        b=c/KvEgcNjKotp+ZRxoAiSIby0ricsjQ8d8+fABm8H/IZJ+x6tHu/uUccdo3UGvvR5
         TOn6NvvQN6O0DdEANRhcGS4vxN2A1JK3nBxtgzL3kfiTjrMIbXznmcLTkqJF05x0WV
         ihseYbZt11j0dmDHus+8KA09XyZLzMaH3cAfYmiKyxLUbgQdhTaMBEpZQwZn+WHTnB
         cKOyV9nnfNaliqi1ANwhvGTzPJF0S+d4JdM4+tWSc17LiMIQ+9Dt/Oc101vzxmdkw4
         tku1EqznXjSvZzMqtQXxPvsi3wM27zoavpCy4a3q+H43WPMjDlph0EdU2qNOAplTzf
         sp9X9cmgKo2ng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4CFCD4049F; Fri,  3 Mar 2023 11:09:18 -0300 (-03)
Date:   Fri, 3 Mar 2023 11:09:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/1 fyi] tools headers: Update the copy of x86's
 mem{cpy,set}_64.S used in 'perf bench'
Message-ID: <ZAH/jsioJXGIOrkf@kernel.org>
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

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

We also continue with SYM_TYPED_FUNC_START() in util/include/linux/linkage.h
and with an exception in tools/perf/check_headers.sh's diff check to ignore
the include cfi_types.h line when checking if the kernel original files drifted
from the copies we carry.

This is to get the changes from:

  69d4c0d3218692ff ("entry, kasan, x86: Disallow overriding mem*() functions")

That addresses these perf tools build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S | 5 ++---
 tools/arch/x86/lib/memset_64.S | 4 +++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 5418e2f99834e5de..a91ac666f758274c 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -7,7 +7,7 @@
 #include <asm/alternative.h>
 #include <asm/export.h>
 
-.pushsection .noinstr.text, "ax"
+.section .noinstr.text, "ax"
 
 /*
  * We build a jump to memcpy_orig by default which gets NOPped out on
@@ -42,7 +42,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS_WEAK(memcpy, __memcpy)
+SYM_FUNC_ALIAS(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 /*
@@ -183,4 +183,3 @@ SYM_FUNC_START_LOCAL(memcpy_orig)
 	RET
 SYM_FUNC_END(memcpy_orig)
 
-.popsection
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index fc9ffd3ff3b213a3..6143b1a6fa2caa0d 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -6,6 +6,8 @@
 #include <asm/alternative.h>
 #include <asm/export.h>
 
+.section .noinstr.text, "ax"
+
 /*
  * ISO C memset - set a memory block to a byte value. This function uses fast
  * string to get better performance than the original function. The code is
@@ -43,7 +45,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS_WEAK(memset, __memset)
+SYM_FUNC_ALIAS(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 /*
-- 
2.39.1

