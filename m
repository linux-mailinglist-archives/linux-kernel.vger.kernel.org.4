Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660DC6AA083
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCCURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjCCURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:17:03 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64F17CF7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:17:02 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1720433ba75so4308411fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmFCa3VFxJpE9VGMwqrT6gT1jwPfyi5J87AThBIzIh8=;
        b=JEya0L5PVw5C3QUCNumaRT8mrUWOcDeOgM6qmWd5A8e51F1r65z2IKChytOQkeproe
         cUjzo+1NgYbs8al56mE+w857rbCdxSX5EmvH9H+90v4D5pfsSyfrLGhiRlADtqw622+R
         C5oNPMCrOtaWD77IBdB8qrVz+/9TETq7SHaQdyhmg8xOIHSGEYL3L0MuiciXsIcdKNGE
         t6M4ngVWtOMjdEU8KcKlk1u4i1+rC+O+E96HnXzA9S6ok0Pvx13hI9VPe5N0aQVorp9C
         QxnBOB86t45ecx5+2fzZ3YWqNrbcsD6lbQO+/ewt9BtEtXvdo1p740ECeZryqdn+Tpiw
         c3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmFCa3VFxJpE9VGMwqrT6gT1jwPfyi5J87AThBIzIh8=;
        b=pesG4IUy2jFGQw7pSFNPOvRcnygt85CHja7mjNzXHNGLPHXiHFk4qdzvULbyXRa22J
         L20iBetdZB4iXdN4P4Vbr+UbiK5JdUfb+iRr/KSJMjDQyl9oMgLFe+tCTH4f6s6D94QZ
         U3oHyrYvggpUomZzBFDM17YuR3Xo83Cf2DARj0sQDEwwk3wLw3m8+5y/rt6AnJwHanUm
         q4a0UeBHjx9E8F2tWX3U15KlUhqNeQS9jRmqNfbcjGxtnq1uWGqfcgQvjPZBEOJBmVoA
         cviNiGC1cfSjk8f1DfLcZzpk54+UMC2fJsFX1xXuBgrnR269Uail5ROe4csvIOGQJX0v
         fOUQ==
X-Gm-Message-State: AO0yUKVeI/DoDec9krFxL3WJEYOM+0tmU41mqRQeVH7mkoOTw2YqjhvI
        bQ8SG3butQwbaVOE1BqXjDQ=
X-Google-Smtp-Source: AK7set8bs4st6xv/gNz3fvJdIkeFc5nNKUyNBwR95eabUJzIjnkIu6DV9Izi+Zr4C78UnWj06LDu1w==
X-Received: by 2002:a05:6870:c6a8:b0:16e:1d9b:9ecb with SMTP id cv40-20020a056870c6a800b0016e1d9b9ecbmr2278096oab.41.1677874621402;
        Fri, 03 Mar 2023 12:17:01 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u10-20020a4ae68a000000b00524f47b4682sm1198902oot.10.2023.03.03.12.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:17:00 -0800 (PST)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDCF84049F; Fri,  3 Mar 2023 17:16:57 -0300 (-03)
Date:   Fri, 3 Mar 2023 17:16:57 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 1/1 fyi] tools headers: Sync linux/coresight-pmu.h with the
 kernel sources
Message-ID: <ZAJVuRq2Db8vIdGX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

To pick up the fixes in:

  206bb3858949b650 ("coresight: trace id: Remove legacy get trace ID function.")
  aa19bb4c35834dd5 ("coresight: events: PERF_RECORD_AUX_OUTPUT_HW_ID used for Trace ID")

That just rebuild perf when CORESIGHT=1 is used in the make command line
to enable linking with the libopencsd.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
  diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: http://lore.kernel.org/lkml/ZAJUHuvK0yvVAQ95@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/coresight-pmu.h | 34 +++++++++++++++++++----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 6c2fd6cc5a983fa4..51ac441a37c3e38f 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -7,8 +7,19 @@
 #ifndef _LINUX_CORESIGHT_PMU_H
 #define _LINUX_CORESIGHT_PMU_H
 
+#include <linux/bits.h>
+
 #define CORESIGHT_ETM_PMU_NAME "cs_etm"
-#define CORESIGHT_ETM_PMU_SEED  0x10
+
+/*
+ * The legacy Trace ID system based on fixed calculation from the cpu
+ * number. This has been replaced by drivers using a dynamic allocation
+ * system - but need to retain the legacy algorithm for backward comparibility
+ * in certain situations:-
+ * a) new perf running on older systems that generate the legacy mapping
+ * b) older tools that may not update at the same time as the kernel.
+ */
+#define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
 /*
  * Below are the definition of bit offsets for perf option, and works as
@@ -34,15 +45,16 @@
 #define ETM4_CFG_BIT_RETSTK	12
 #define ETM4_CFG_BIT_VMID_OPT	15
 
-static inline int coresight_get_trace_id(int cpu)
-{
-	/*
-	 * A trace ID of value 0 is invalid, so let's start at some
-	 * random value that fits in 7 bits and go from there.  Since
-	 * the common convention is to have data trace IDs be I(N) + 1,
-	 * set instruction trace IDs as a function of the CPU number.
-	 */
-	return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
-}
+/*
+ * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
+ * Used to associate a CPU with the CoreSight Trace ID.
+ * [07:00] - Trace ID - uses 8 bits to make value easy to read in file.
+ * [59:08] - Unused (SBZ)
+ * [63:60] - Version
+ */
+#define CS_AUX_HW_ID_TRACE_ID_MASK	GENMASK_ULL(7, 0)
+#define CS_AUX_HW_ID_VERSION_MASK	GENMASK_ULL(63, 60)
+
+#define CS_AUX_HW_ID_CURR_VERSION 0
 
 #endif
-- 
2.39.2

