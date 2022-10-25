Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7973360CF85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiJYOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiJYOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:48:57 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84519C220
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:48:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-12c8312131fso15843026fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbIETgbP3QGPBzS/+H8xqY4TN9qqk1LnkbQ9lqFB7wg=;
        b=TlKOycCUniWQ6MqZCFCYLS4iFNYGPWsVgp8o4amBVB+rgEX1GYohW4Mn9NTnICmiW0
         bm1FKq6+enezio8D6j6vvjaI7e4E9iznXpt0Iw3hDuJtSOXVuJNg5rx6Sf4OG8xKr+xU
         gkFMzlksALOT0CcBqX/Ta3GlFzOhrBS5Ov+dcs+1VEKlPyr0ENpMCt0/yATw90ILP37V
         siHDyH+A/ZxVrdOpqIAaAuqw9gcbJKR6YwwPMME8WMFwArU8zjfDatapNm/w0qikj0Fk
         YdAMG5SEW3z+og8fIjD8BY4Q0ikIHDR+PP4mkvivWRg3TF/sbO/s1FquF3jpGL/EH+48
         3cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbIETgbP3QGPBzS/+H8xqY4TN9qqk1LnkbQ9lqFB7wg=;
        b=A1WexKiPKigoxBduTBZ10CJkN/yw1A6vPv8j8ggRDsh7D9Ea+W/hqdh6jDtxqMjvYx
         zyQZyGnwVg6+biLHfezwtM3imPE4QZJc6yNXes9haTotvZupa7u3RoH3lOQL3yrDA383
         GDfOEiQyfNuhmeAsEoRJAAUH3hBoQIxqWkYq9KyaVtk26RwvC077zVS0iqub3cyRz2lA
         LaKB10pucs2T3kvb4T0nV3iu18WQiuPPneZ5lkNlyh5MSRnrjyDb2AkAQuvYFnrXCKLX
         /QvAgHORhlHg3Eds4+7gJ5PjPjo5Aue948KDQlvJEsDqbI/xqxEXpfWlMDNrSbl05dWy
         7/Fg==
X-Gm-Message-State: ACrzQf3kBMSIM8laXQra1R50Ys0kP/0NmL1NVP9YDRAjC9yIKKtySRov
        lMDtpagpeNetWP8p4gO+hRU=
X-Google-Smtp-Source: AMsMyM6nttbj38H3M5+7ezAMaRWQckl6AYETSqTIr+B5ECxLqwUQl56kLg/vqJhqzKtKhj4Frerz0A==
X-Received: by 2002:a05:6871:687:b0:132:fd73:4551 with SMTP id l7-20020a056871068700b00132fd734551mr40990547oao.195.1666709336414;
        Tue, 25 Oct 2022 07:48:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id ep2-20020a056870a98200b0013ae5246449sm1630989oab.22.2022.10.25.07.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:48:56 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 82D00404BE; Tue, 25 Oct 2022 11:48:53 -0300 (-03)
Date:   Tue, 25 Oct 2022 11:48:53 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH FYI 1/1] tools headers: Update the copy of x86's memcpy_64.S
 used in 'perf bench'
Message-ID: <Y1f3VRIec9EBgX6F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

We also need to add SYM_TYPED_FUNC_START() to util/include/linux/linkage.h
and update tools/perf/check_headers.sh to ignore the include cfi_types.h
line when checking if the kernel original files drifted from the copies
we carry.

This is to get the changes from:

  ccace936eec7b805 ("x86: Add types to indirectly called assembly functions")

Addressing these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S          |  2 +-
 tools/perf/check-headers.sh             |  2 +-
 tools/perf/util/include/linux/linkage.h | 13 +++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad394c..5418e2f99834e5de 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -27,7 +27,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START(__memcpy)
+SYM_TYPED_FUNC_START(__memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6ee44b18c6b57cf1..eacca9a874e2f334 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -143,7 +143,7 @@ for i in $SYNC_CHECK_FILES; do
 done
 
 # diff with extra ignore lines
-check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
+check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))" -I"^#include <linux/cfi_types.h>"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-index.h"'
 check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysreg.h"'
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index aa0c5179836d1bbb..75e2248416f55f67 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -115,4 +115,17 @@
 	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_WEAK)
 #endif
 
+// In the kernel sources (include/linux/cfi_types.h), this has a different
+// definition when CONFIG_CFI_CLANG is used, for tools/ just use the !clang
+// definition:
+#ifndef SYM_TYPED_START
+#define SYM_TYPED_START(name, linkage, align...)        \
+        SYM_START(name, linkage, align)
+#endif
+
+#ifndef SYM_TYPED_FUNC_START
+#define SYM_TYPED_FUNC_START(name)                      \
+        SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
 #endif	/* PERF_LINUX_LINKAGE_H_ */
-- 
2.37.3

