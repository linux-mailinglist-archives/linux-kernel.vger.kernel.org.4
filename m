Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D168636811
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbiKWSCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiKWSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5332C87540;
        Wed, 23 Nov 2022 10:02:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b11so16508894pjp.2;
        Wed, 23 Nov 2022 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rDn/mw+FagN1m2eiShMyH8xai72ctuc/pHCaCu8gIX8=;
        b=CQQ+Z2uEC/Y5KY8WYT4DVhjMlB7ix605zXjyMAlpj8C+mx25Kj75ljbsSLYrnVJRSJ
         89lilGxicPszpFQXQ38f2waR/TA/zcHw6EQ45k6zN0jjX3fU4NexNGbdufd8OPBIWeyH
         Ja/rv7cgOeBrSHYbu7jKk9n7Hv3eIfTqDr/pV0WfxXsoVUsjJSuECYgxoNMu2lZIxBK+
         fJ7inBMrWCPpMEeEaYvbIIrcNrsJulgusFV9AHUtkPkmVW5QjuQady76RcaLEuLWLVrp
         Vk8/ycPKTX+RbbqnLmCc5YOCQ6PUGDkwWXsjhhiVdMDYW1Q+4gOlO7yyjsKWNniIzEnq
         rlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDn/mw+FagN1m2eiShMyH8xai72ctuc/pHCaCu8gIX8=;
        b=RdzaJ7oi4O+hizM6NVgGazzZjESxCK14fB4XmOMXXtpQvOjMWaIZz2ZErzaz/8hafS
         IboGs4BPsghcPu86yoXbgcfJzus5oqSgbtRkfujiFkNArI2llVCXtahuK3nFtK0fpaLK
         gYAym+cUXgcoOrhn9HprjMXLjik7p/Ft0vlniiqI0nUdIOpzseQYvcT9HyVU1sd4i+oc
         yfPLyRa2FFAtPOpFeWJbcVbRrsPVlzCjwFARTh2MZ0QMz/76yVCGLETzic344f6454Ee
         KpZASJ66Tarm6hl41eVDwO+49ORMal55pgEslfuCbpku2rT7j+gIu8sVAxGXJdRBcdh3
         R+JQ==
X-Gm-Message-State: ANoB5pl2U/oTvPqXU6qEJ5NU6w4cQOLJ6h7LUCgo/S/Nr8gA5wiLCEvV
        j+KHMM3OsFDOiAYWjH7y8rs=
X-Google-Smtp-Source: AA0mqf4/ovAD9a9j1NKeTDoIo+X3I0vrIx0aPrt329o8qSrb2pXbEv4LDfkiobf4pTLeAZBa5iRXIA==
X-Received: by 2002:a17:90a:2e16:b0:20a:bb1f:44a with SMTP id q22-20020a17090a2e1600b0020abb1f044amr38726233pjd.160.1669226531222;
        Wed, 23 Nov 2022 10:02:11 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:10 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 00/15] perf stat: Improve perf stat output (v2)
Date:   Wed, 23 Nov 2022 10:01:53 -0800
Message-Id: <20221123180208.2068936-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a continuation of my perf stat cleanup work focusing on the
metric-only mode with JSON output now.  It's based on the previous
patchset which is already merged to acme/perf/core.

The JSON output + metric-only with aggregation has been broken for a
while.  The last update fixed the crash but it still produced invalid
JSON objects.  Also having a separate header and objects with their own
"metric-value" key is not convenient to process.

  # perf stat -aj --metric-only --per-socket sleep 1
  {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {"socket" : "S0", "aggregate-number" : 8, {"metric-value" : "0.809"}{"metric-value" : "2.10"}{"metric-value" : "0.37"}

So I removed the header and move the metric keys to the object.  Then
it doesn't need separate objects anymore.  The new output looks like:

  # perf stat -aj --metric-only --per-socket sleep 1
  {"socket" : "S0", "cpu-count" : 8, "GHz" : "0.817", "insn per cycle" : "2.15", "branch-misses of all branches" : "0.38"}

You can get it from 'perf/stat-display-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (15):
  perf stat: Fix cgroup display in JSON output
  perf stat: Move summary prefix printing logic in CSV output
  perf stat: Do not align time prefix in CSV output
  perf stat: Use scnprintf() in prepare_interval()
  perf stat: Remove prefix argument in print_metric_headers()
  perf stat: Remove metric_only argument in print_counter_aggrdata()
  perf stat: Pass const char *prefix to display routines
  perf stat: Use struct outstate in evlist__print_counters()
  perf stat: Pass struct outstate to print_metric_begin()
  perf stat: Pass struct outstate to printout()
  perf stat: Do not pass runtime_stat to printout()
  perf stat: Pass through struct outstate
  perf stat: Fix JSON output in metric-only mode
  perf stat: Rename "aggregate-number" to "cpu-count" in JSON
  perf stat: Tidy up JSON metric-only output when no metrics

 tools/perf/arch/x86/util/iostat.c |   4 +-
 tools/perf/util/iostat.c          |   3 +-
 tools/perf/util/iostat.h          |   4 +-
 tools/perf/util/stat-display.c    | 257 +++++++++++++++---------------
 4 files changed, 133 insertions(+), 135 deletions(-)


base-commit: 63a3bf5e8d9e79ce456c8f73d4395a5a51d841b1
-- 
2.38.1.584.g0f3c55d4c2-goog

