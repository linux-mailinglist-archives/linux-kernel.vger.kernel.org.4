Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5462260B67D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiJXS7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbiJXS7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:59:06 -0400
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5918E32
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:38:59 -0700 (PDT)
Received: by mail-pf1-f202.google.com with SMTP id f13-20020a62380d000000b0056a7486d9a1so4572409pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=WNe4EQeeykspT4w/Io584+kx9lh/QeoAHLehl3suvkUCe1Cp12l+MOrLPerfCGXYSl
         tkULm4/+1vo92FIS6jrd4ShA6Wd+GOg80wHhdUNFIbzKf+CrNIIAjHCwi3oT8c+RDn7I
         rLm16gXSUTHOzSc+IjDqbYXGp+Ssc+Z1x7rQuGXozqHAd2ZYNYN/Kv/ikwNHa7nd1L3T
         s3B9IpBNSrLhMbYoAfN4Qscgo0OjOPVbDyLFGAVmU0arJMtRwsJa2A7QotYaDgvYOkvw
         vgWeT/2lmLHaADWBVOZkK6uIAlE1BLHzV2/bDmUo59pB6FYxwRynWnYrLYqSpkif8lzg
         yngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJwUbAas6HwUpEbmohIDJ22IirHP0xTxc+7b+i3VB6U=;
        b=Dk0AKvX/eZvXXck6R6Jsiobwdg/W9QN/SMkgA81icyCF0nQvQRtJwElcb/CX71JvbX
         aG5GiOxluM8EMtP6wRf+pmCIksGheq7+/suqrg475yZYi2ip+Bo8w2m1pso0lS3XTTpi
         OSq2LRzBBmJ3+Z+WaSld7xPMnikmA2d4vZxLY5WNJLDROtJhcN5q+lQQiCKSEm8QNHW9
         U4nSn641lzI79sUc3X7DtHuBpzlVQZwfiHh4MsC3n7wmkuBu/n0+xF9yd56BovvnoWDK
         W6UpB9QGTdJ73TmvEJAwqKZ6P82BtHWSHY9JbWWWzN4zlwV1MB7jY6F8ru8cPA+TYkMG
         qnRQ==
X-Gm-Message-State: ACrzQf2scORKVbiegnMKmygjxv3AcdPLCzM3uYtvjqmalsb7UMtWMd8i
        rMTMlRN/g7tVBK/O0/KryBXZxmC6dtgy
X-Google-Smtp-Source: AMsMyM5Hal+np002XCO/XJUFdXFLqN4uPHd6YA51dLU/cUcRa+TfD0iPG/3RnFU9UaBwh/lgH18ME98noPZR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:e90:b0:213:2708:8dc3 with SMTP id
 fv16-20020a17090b0e9000b0021327088dc3mr233702pjb.2.1666633007051; Mon, 24 Oct
 2022 10:36:47 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:23 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-9-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 8/8] perf trace: Use sig_atomic_t to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sig_atomic_t for variables written/accessed in signal
handlers. This is undefined behavior as per:
https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3c757769b96..72991528687e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1535,8 +1535,8 @@ static size_t trace__fprintf_tstamp(struct trace *trace, u64 tstamp, FILE *fp)
 }
 
 static pid_t workload_pid = -1;
-static bool done = false;
-static bool interrupted = false;
+static volatile sig_atomic_t done = false;
+static volatile sig_atomic_t interrupted = false;
 
 static void sighandler_interrupt(int sig __maybe_unused)
 {
-- 
2.38.0.135.g90850a2211-goog

