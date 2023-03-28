Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC66CCE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC1X5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjC1X5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:57:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A38D35A3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-545d027103eso94280487b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8oj4Qh8LkL44qDfc+ww/WDT9C93iT4jvbUsjV4OLZU=;
        b=cRwj07ZHD3+kEgzI1WCsWo0Jn0PxpJhoWIxxnhZ/C7rF6MsGc783MzQ5sULdu71i2j
         jKqKOI5DzMxXW+0BLJuIMAJdE4wDTOIdWyzoqw1ciQFW3HG375hOaFxHwRs5efHw+CEj
         n6N1zd/G2NdnRxpXSB5JhmJicJcrK5cCQ3f14MaCMA1iz1tFMbmhlZVM11nQRilyoiHd
         eNCAeB42smeR++GjJcnlBMEyQc/fOOzn2h/3AV2L0kgNI1Gc9Caw/jCDtScqHcCN2v5z
         S5XlpUy8e5Lsv74mf9wqVeC3LfgRI3+SS0GSAiBq8gagDMTJ8a5CMreaHWT4KTDWCnBE
         mVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047803;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8oj4Qh8LkL44qDfc+ww/WDT9C93iT4jvbUsjV4OLZU=;
        b=Ql94GOyThZkNBOt3G6PnarcjC3aRo5Is7U57Usy4Xa3oi0LUWtdusAm1rU9JrZ6JkZ
         o/au+JcS2zD1q6n4bSRu+/LqIAWHoC6BZr37G8A5z/te9gN3qwZXoZ7BF1db0D1Kxe+Y
         GM2xarHEw8rTM8R762qpYpeFInzzOT4BW89eN0eqN4tSFKMXO43J3JpxGu8rwnM9rEWd
         QQ/uoxdQIWdZIbQXVzbQ0fmgKJwhauuGmRU+4QRy9HRr5btwOA+KlDMVso4mQBlQY9JW
         qulfApO9lqY0r1VYZjz376/fIFHcU8CQBXtKQht663kGspxfwEiqnpSCneLcTb8r5qLD
         UVLg==
X-Gm-Message-State: AAQBX9cDG+w5jF+R5kiBAZKmVYcOHewEyt1fPIczzaj4IVdFZCCBreCS
        HxjwGRTpEDJkD9aAzhAU+Jrs/IDZ9HKP
X-Google-Smtp-Source: AKy350bUp5S6wjQC6cWrYY34EcwAiZTBNWURmSqeR/1rTTGdHd3PnQclyh5VuNn5nGYPWejg8XtVkHfkE2gy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d5:b0:b75:3fd4:1b31 with SMTP
 id ck21-20020a05690218d500b00b753fd41b31mr11717269ybb.1.1680047803319; Tue,
 28 Mar 2023 16:56:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:42 -0700
In-Reply-To: <20230328235543.1082207-1-irogers@google.com>
Message-Id: <20230328235543.1082207-6-irogers@google.com>
Mime-Version: 1.0
References: <20230328235543.1082207-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 5/6] perf annotate: Allow objdump to be set in perfconfig
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the setting of the objdump command in the perfconfig. Update man
page for this new option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-config.txt | 5 ++++-
 tools/perf/util/annotate.c               | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 39c890ead2dc..697f7f924545 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -250,7 +250,10 @@ annotate.*::
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
-	annotate.disassembler_style:
+	annotate.objdump::
+		objdump binary to use for disassembly and annotations.
+
+	annotate.disassembler_style::
 		Use this to change the default disassembler style to some other value
 		supported by binutils, such as "intel", see the '-M' option help in the
 		'objdump' man page.
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7338249dfdd9..3eaa9b2df6c4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3211,6 +3211,12 @@ static int annotation__config(const char *var, const char *value, void *data)
 			pr_err("Not enough memory for annotate.disassembler_style\n");
 			return -1;
 		}
+	} else if (!strcmp(var, "annotate.objdump")) {
+		opt->objdump_path = strdup(value);
+		if (!opt->objdump_path) {
+			pr_err("Not enough memory for annotate.objdump\n");
+			return -1;
+		}
 	} else if (!strcmp(var, "annotate.demangle")) {
 		symbol_conf.demangle = perf_config_bool("demangle", value);
 	} else if (!strcmp(var, "annotate.demangle_kernel")) {
-- 
2.40.0.348.gf938b09366-goog

