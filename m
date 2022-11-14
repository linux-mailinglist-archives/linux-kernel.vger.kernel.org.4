Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D8628CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 00:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiKNXCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 18:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbiKNXCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 18:02:31 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A444F1B1CE;
        Mon, 14 Nov 2022 15:02:30 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o13so11570777pgu.7;
        Mon, 14 Nov 2022 15:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=w8L1Se3Yk/PGelGv3QJC7H32KbLMR1dNvqfIm1yn+rk=;
        b=BxgWppQvGezMur7LmfR88t7DtUCSJ5P89qum9buHmCqzvGu6kgpT9TJrw5cbPJTN77
         d4toeDxb0n/JUa2TeodSTC5X3Se7fpt0769M93IzduJS6Ol+nqc2ev6tc2A1JZgeui/r
         8gqd8oBlFu9KvdxmboibzcWlQOqtRR7HKBv8nt8FpJtxtF8elQzI60gtvY+cL8ocpGwV
         7M58SAKzB1nGbLKcZs90MPcuvy5tb53DjXCXl5UZrxa4cSYCgCNttl7/lDnjy3A9sLd6
         Z5CBOiocAL3j+IzzaSo/CN4fHnmgf+muWHIlPhHzrjxg8ZxTl8MlDevcv7aW623ezNBF
         ZLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8L1Se3Yk/PGelGv3QJC7H32KbLMR1dNvqfIm1yn+rk=;
        b=QazZPE2P6f7/vHnX44uVhFJIJtbwkR0wzVm12cn4Kdq+p9/SsEkUMVPtCthsMi+Is2
         CIwtnUNsUHvA4IjOT7Ay8YyLkAR0os5gJMZNKcE6ZW1WkCSY7toht6cdfSNBQrgUhTRW
         IXCezLUUSRGRKevZvz2k0sZBUJH6FNt3SPgcWKHqpCsGu18YjDjskAnpJsipVz1BQTjI
         vQ1h/EorWEh+/TxQkVOa+AG5hklDGx5m7VSzWaQgsbaxTnUiSZp2hoMgGoo4eP0WQhO0
         mpr/fH+aKibvVNjRd/1W1eHRFY6L8/oOZmiMxVjaXg6AEeF2KjWwEo+0Z7tt0cZig1uT
         nrNA==
X-Gm-Message-State: ANoB5plG3l85KdVy2GF84sKaBNYvirY4DOrWLMTTBmrXtYSDR9yRpZ1E
        2dgCA2gLvn4Lg78yzQDyIH4=
X-Google-Smtp-Source: AA0mqf70MiA829YKIrb9tO1msM9YuYGEOCdHXGynnk3X12pt7GY23ughKjOQ+llUJRII2M4UTfjZwA==
X-Received: by 2002:a63:c009:0:b0:46e:bcc1:28df with SMTP id h9-20020a63c009000000b0046ebcc128dfmr13290321pgg.187.1668466949874;
        Mon, 14 Nov 2022 15:02:29 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:cf9f:e038:c19b:797e])
        by smtp.gmail.com with ESMTPSA id 132-20020a62148a000000b0056c814a501dsm7534724pfu.10.2022.11.14.15.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 15:02:29 -0800 (PST)
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
Subject: [PATCHSET 00/19] perf stat: Improve perf stat output (v1)
Date:   Mon, 14 Nov 2022 15:02:08 -0800
Message-Id: <20221114230227.1255976-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on cleanup up the perf stat code.  The main focus this time
is the display logic which has various combinations of options.

I split the code for each output mode - std, csv and json.  And then
organize them according to the purpose like header, prefix, value,
metric and footer.  I hope this would help maintaining the code a bit
more.

Also I found that cgroup support is missing or insufficient.
Specifically when --for-each-cgroup option is given, it'd have multiple
copies of the events for those cgroups.  Then the output should group
the result.  This is true for the normal output mode, but the metric-
only mode didn't support it well.

With this change, I can see the per-cgroup topdown metrics like below:

  $ sudo ./perf stat -a --topdown --for-each-cgroup user.slice,system.slice sleep 3
  nmi_watchdog enabled with topdown. May give wrong results.
  Disable with echo 0 > /proc/sys/kernel/nmi_watchdog

   Performance counter stats for 'system wide':

                                  retiring      bad speculation   frontend bound    backend bound
  S0-D0-C0      2  user.slice            117.3%         3.9%            47.8%           -69.1%
  S0-D0-C1      2  user.slice            119.8%         4.1%            49.3%           -73.2%
  S0-D0-C2      2  user.slice             24.4%         7.9%            68.4%             0.0%
  S0-D0-C3      2  user.slice             24.0%         9.2%            91.2%           -24.4%
  S0-D0-C0      2  system.slice           73.5%         4.0%            19.4%             3.1%
  S0-D0-C1      2  system.slice           90.0%         5.8%            19.7%           -15.5%
  S0-D0-C2      2  system.slice          101.2%         6.6%            33.4%           -41.1%
  S0-D0-C3      2  system.slice           90.7%         4.9%            22.3%           -18.0%

         3.001678216 seconds time elapsed

You can get it from 'perf/stat-display-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (19):
  perf stat: Clear screen only if output file is a tty
  perf stat: Split print_running() function
  perf stat: Split print_noise_pct() function
  perf stat: Split print_cgroup() function
  perf stat: Split aggr_printout() function
  perf stat: Factor out print_counter_value() function
  perf stat: Handle bad events in abs_printout()
  perf stat: Add before_metric argument
  perf stat: Align cgroup names
  perf stat: Split print_metric_headers() function
  perf stat: Factor out prepare_interval()
  perf stat: Cleanup interval print alignment
  perf stat: Remove impossible condition
  perf stat: Rework header display
  perf stat: Move condition to print_footer()
  perf stat: Factor out prefix display
  perf stat: Factor out print_metric_{begin,end}()
  perf stat: Support --for-each-cgroup and --metric-only
  perf stat: Add print_aggr_cgroup() for --for-each-cgroup and --topdown

 tools/perf/builtin-stat.c      |   8 +
 tools/perf/util/stat-display.c | 996 ++++++++++++++++++++-------------
 2 files changed, 624 insertions(+), 380 deletions(-)


base-commit: 7565f9617efac0c0c8e2dbd08dbe0695d56684f5
-- 
2.38.1.493.g58b659f92b-goog

