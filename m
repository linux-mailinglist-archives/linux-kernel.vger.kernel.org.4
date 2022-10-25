Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94FB60D4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJYTgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiJYTgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:36:33 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E35E31B1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:36:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id y67so15706179oiy.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5KZUhup4jJixRQuwMmSTA7VXjfMytd2d0aeoTsmATI=;
        b=nurwmnw5fqG/7bz98ByJfHS/5RdBOm+m8eu0FDRcjbA6cDY1xLYv/ftlfWcov7VBua
         eQdJsM4KsYvUM8eQW7fnjfHc9a9CySGmZTysdrGhxuDbuOm3DftwFYEIAqJeHP1ybCf1
         sRmM6m1ctJVX8LlrRCRU56qovhzPEOZafh2oj3RbcGy0AS9lLpfmaxWaFpsXyyqE83z1
         xEG09B4h4T/SYJU5E0BnjaaOLOiK7lYCQ02s+qyfDyNgF2CbtcQaAa2MaB4AYcldbRkV
         GqNlxTTN59hLHiPNO00SENVGNkCUkq9X7qBg4yKG+PnDbVdjNNnt+faPqk5zF3+3XV3b
         kKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5KZUhup4jJixRQuwMmSTA7VXjfMytd2d0aeoTsmATI=;
        b=k0RyzuNxtImgnmok2kUMEIDMSd2D20VjvT4C8MTD0f9bY7QD+dFJBfGM25FuOXgA+F
         xn1ZYS929YuQdQwCn0uiNBBQPtn3y0EGRXIIRjkeL/YW8h738KcEh9rUtEU4uucnjKHq
         55IiUl/zrsaLVuM4F4dXxCV6ZhfOnYNInIVjWMd6i//1OLxwoYGAkUZx8gSGvegYS7x6
         VdNVDD3DcWZF9ukfc+E+NzvxC3WM0HCWIKG7lxLWR3mxkLnoFsMESnKniAOCJTbwAx2U
         3r47uScCOEzbjtOSidxk4EuBmLZdH7yYh29lYhNfInh/9e3AF++VgBTzCgjbQmybjyCf
         j4eQ==
X-Gm-Message-State: ACrzQf1Xdh+KjNuMzanASNuKge1Rwi1X5etCWxFP0ao0kIvEnwOyE8yW
        Ok5G7QzpthlRWtjwRm9bjNw=
X-Google-Smtp-Source: AMsMyM5papOm/8tW6JmpiRAYow7zC9PkXU8YnK2tc5U4q3C304+lUaU5/5SXX30HzGbLCq29Sb+1Zw==
X-Received: by 2002:a05:6808:10cc:b0:355:2dff:5e14 with SMTP id s12-20020a05680810cc00b003552dff5e14mr19808289ois.103.1666726592348;
        Tue, 25 Oct 2022 12:36:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.238.93])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d4915000000b00666a5b5d20fsm845680otf.32.2022.10.25.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:36:31 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8F6F404BE; Tue, 25 Oct 2022 16:36:28 -0300 (-03)
Date:   Tue, 25 Oct 2022 16:36:28 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 1/1 FYI] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <Y1g6vGPqPhOrXoaN@kernel.org>
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

To pick the changes from:

  257449c6a50298bd ("x86/cpufeatures: Add LbrExtV2 feature bit")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ef4775c6db01c128..b71f4f2ecdd571a4 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -96,7 +96,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-/* FREE!                                ( 3*32+17) */
+#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
 #define X86_FEATURE_LFENCE_RDTSC	( 3*32+18) /* "" LFENCE synchronizes RDTSC */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
-- 
2.37.3

