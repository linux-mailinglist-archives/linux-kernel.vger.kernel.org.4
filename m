Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96F564E1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLOT20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:22 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B584730E;
        Thu, 15 Dec 2022 11:28:21 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so3745382pjr.3;
        Thu, 15 Dec 2022 11:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KgpUHqqYDUqhmNzo2oR6wZhkiWPpZ+XKcsqymCWuryU=;
        b=cGMOGjuGIsRcVif1Na+rwqQSWe8rJvW6s7MPQ7iTkgHqQoAJ+vK9pTNWgXN/hvtV07
         vcPmEsRVMC1bpq10nYSF/+Y418CUW1PdwkHVWYvjotuxoiA6xPLF0oyn6IAmf6Nevfp9
         /PCN8wxIXN0zDX8/mDiX7eEEYkm13cQ5th0xqLpEZZv7ffYqscaJfp4EjIIFuLj+5Y+8
         T6AcUKIuVcFtw64HcGV2F8C2Tzzhv2IP2PAI39m+krAxDryCFi2sySQORysTU/DEd3pC
         Rw8gRG/umTG5fGTWcgX5IRBnGde7w5GdNf+E2gD+EqRvjM3+AUK+XarwBm/LBa5+v0zu
         +Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgpUHqqYDUqhmNzo2oR6wZhkiWPpZ+XKcsqymCWuryU=;
        b=IaPEXtPuWISwGSvYJO2842LNsDnWdviQ/daynW5zZ74i0v25FRSmQIQd1A+BlzC0Jh
         SKdj4SgeW9YrN3ZkuYEPLfxjKwDzLlzq03mchh3vH2GnEJGcUegq7778+/P3Cvd+8vgE
         +seJthp69NlZXqZzer1fKnUI3IeVV0kMHyvw+vNdxrx/oexvGfPz58HOdNHIE80UtRJG
         ZT4dObYYVxXss9hEvLHEmVqb+9u9osVFZ0jyn94Fr30H1v19K3nckzcaeqi5YSBrN3vV
         agJKcnEaRJ+TiqUYyPbkeB9dFsE6f27Jd3qcIyQA6F0sCN+7w3ebNGQvPhL7BKcn8Ffw
         6Z0g==
X-Gm-Message-State: ANoB5pk5vfn3KvK0tP2i4E15lvWKQtgjJP/c2pXmCKoFhH4GJmPZtMtU
        FWkBjbYJ5qUUm3Bg25SoCYddRqarhcM=
X-Google-Smtp-Source: AA0mqf6ThnGuDWGwBFQ3R1LYLalSl2tvNm6N753JXiU1eZFZA2Ax+pH2GRvkZygiAyKKMaWJBTcTtw==
X-Received: by 2002:a17:90a:c396:b0:21d:6327:ab6 with SMTP id h22-20020a17090ac39600b0021d63270ab6mr27499383pjt.1.1671132500521;
        Thu, 15 Dec 2022 11:28:20 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:20 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCHSET 0/9] perf report: Improve srcline sort performance (v1)
Date:   Thu, 15 Dec 2022 11:28:08 -0800
Message-Id: <20221215192817.2734573-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
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

I noticed a performance problem in the srcline/srcfile processing during
perf report when it's using an external addr2line process.  I guess it's
also helpful even if it uses the libbfd to get the srcline info.

Also note that it's mostly from large (static) binaries, but smaller
binaries should also benefit from the fix if they have a lot of samples.

The first 5 patches are general fixes and updates.  The latter 4 patches
implemented the actual speed-up.

Let's test it with the perf tools itself.  Build a static binary like below.

  $ cd tools/perf
  $ make NO_JVMTI=1 LDFLAGS=-static

Then run the perf test workload.

  $ ./perf record -- ./perf test -w noploop

And run the perf report with srcline sort key like this.

  $ ./perf report -n -s srcline --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 4K of event 'cycles:u'
  # Event count (approx.): 3572938596
  #
  # Overhead       Samples  Source:Line
  # ........  ............  ............
  #
      99.94%          4010  noploop.c:26
       0.03%            14  ??:0
       0.03%             1  perf.c:330
       0.00%             1  wcscpy.o:0

The problem is that it runs the addr2line when it processes each sample.
But as you can see many samples can have same result.  IOW, if the samples
have same address, we don't need to run the addr2line each time.

So I changed the sort_key->cmp() to compare the addresses only and moved
the addr2line from sort_key->collapse() so that they can be run after
merging the samples with the same address.

With the change, I can get a huge speed-up in processing srcline info
while they generate the same output.

Before:

  $ ./perf stat -- ./perf report -s srcline > /dev/null

   Performance counter stats for './perf report -s srcline':

           15,397.13 msec task-clock:u                     #    0.993 CPUs utilized
                   0      context-switches:u               #    0.000 /sec
                   0      cpu-migrations:u                 #    0.000 /sec
               3,810      page-faults:u                    #  247.449 /sec
      54,516,351,820      cycles:u                         #    3.541 GHz
      31,494,118,293      instructions:u                   #    0.58  insn per cycle
       8,577,271,187      branches:u                       #  557.069 M/sec
       1,216,165,520      branch-misses:u                  #   14.18% of all branches

        15.505066606 seconds time elapsed

        15.094122000 seconds user
         0.396962000 seconds sys

After:

  $ ./perf stat -- ./perf report -s srcline > /dev/null

   Performance counter stats for './perf report -s srcline':

              105.66 msec task-clock:u                     #    0.994 CPUs utilized
                   0      context-switches:u               #    0.000 /sec
                   0      cpu-migrations:u                 #    0.000 /sec
               3,275      page-faults:u                    #   30.995 K/sec
         185,063,407      cycles:u                         #    1.751 GHz
         142,470,215      instructions:u                   #    0.77  insn per cycle
          34,584,038      branches:u                       #  327.311 M/sec
           3,226,005      branch-misses:u                  #    9.33% of all branches

         0.106270464 seconds time elapsed

         0.074254000 seconds user
         0.032871000 seconds sys

The code is available at 'perf/srcline-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (9):
  perf srcline: Do not return NULL for srcline
  perf report: Ignore SIGPIPE for srcline
  perf symbol: Add filename__has_section()
  perf srcline: Skip srcline if .debug_line is missing
  perf srcline: Conditionally suppress addr2line warnings
  perf hist: Add perf_hpp_fmt->init() callback
  perf hist: Improve srcline sort key performance
  perf hist: Improve srcfile sort key performance
  perf hist: Improve srcline_{from,to} sort key performance

 tools/perf/builtin-report.c      |   1 +
 tools/perf/util/hist.c           |  10 +--
 tools/perf/util/hist.h           |   1 +
 tools/perf/util/sort.c           | 129 ++++++++++++++++++++++++++++---
 tools/perf/util/sort.h           |   1 +
 tools/perf/util/srcline.c        |  20 +++--
 tools/perf/util/symbol-elf.c     |  28 +++++++
 tools/perf/util/symbol-minimal.c |   5 ++
 tools/perf/util/symbol.h         |   1 +
 9 files changed, 176 insertions(+), 20 deletions(-)


base-commit: 818448e9cf92e5c6b3c10320372eefcbe4174e4f
-- 
2.39.0.314.g84b9a713c41-goog

