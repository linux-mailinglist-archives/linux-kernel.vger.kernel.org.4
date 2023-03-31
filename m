Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352856D2972
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjCaU34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaU3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:29:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8721BB76E;
        Fri, 31 Mar 2023 13:29:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so26666938pjt.2;
        Fri, 31 Mar 2023 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294592; x=1682886592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EM4VZff1q+6h3vaykd1WLHQlMObm8C8qOyNRp5sdWMA=;
        b=WCRyLmo7uPfZViqaH0L7lGJ+YbXI5HyzZ2r6/Y2oi98sbgCf6eQwEBFQcsybQ+Tl8c
         V1d4XIchh9l43w25NOWoONUSenF0lHRGt1te+NvTdqgvhsagC86TwQwaQy+PyfayIDpa
         ARUy66BIMF025vVABrqUmFC/ALEuHiiTNNeYDNhNF+HQ1m3WdeEpw6T7scbBn5U09p3i
         J7+FYnwcMe6gll77jxjen01FCBqX4KIibVH807N4q0nDLTYkFplVgNiX4fjGEljy9AAa
         ezJRTkqgaGVqZbGEhNUWiuRL+54lj/QfR5aZp8IIaJMD0W6y7lim7TbC49YhvYZlo3Ln
         mv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294592; x=1682886592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM4VZff1q+6h3vaykd1WLHQlMObm8C8qOyNRp5sdWMA=;
        b=LB3dXIIXNmmluNRvsvsplRfNTN/KIMKB5jPtpYH7Fe0sn2xdVIbWKs2wJlXndI4J6a
         g1ceVGnQPaQGjVSj9ePUnAFOFhPu5Vlwh+XY540gVtS+uADYGDEKJvoOXa5znC8tUL5F
         rYGwzSAlPo5o5zu3NSmfmptMPeKbqskN3bW1/sYK1maVTfqK0YXeACWkkEsjRDHlQTJV
         rHGE5XuOJYpj8YOsiOwUmMop2cz4J6N7GsKCmrWGmsrirC7HdLabLzP6ZQW6ygEs+83E
         +m3ebdOIvbN6cYarvY0ORYzZe/DUXKQitzRQN5UWKcVlakWGZAa46790ioIIq4teQxD4
         Dq7Q==
X-Gm-Message-State: AAQBX9eyJxZHCkPk0GtEy/khHoCa6SKHYFVQi67dvIk4xvlXVH3OtAdL
        fOG7RGv77XuuvO2z2OGuCdU=
X-Google-Smtp-Source: AKy350a0hkv5Sk3dyUFuLyV1+BV3PdFVTOayILfVN3QyjN+ruH8ofDTi9Ow+wQUxI9rSK85vlku+vw==
X-Received: by 2002:a17:903:22c4:b0:1a2:8924:224a with SMTP id y4-20020a17090322c400b001a28924224amr10763591plg.25.1680294591631;
        Fri, 31 Mar 2023 13:29:51 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:29:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCHSET 0/9] perf tools: Update pmu scan using openat() (v1)
Date:   Fri, 31 Mar 2023 13:29:40 -0700
Message-Id: <20230331202949.810326-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset changes PMU info scanning on sysfs using openat()
basically.  I got reports of occasional contention on the
opening files in sysfs.  While the root cause was a separate
issue, I discovered some inefficiencies in the perf code.

To scan PMUs, it roughly does something like below:

  dir = opendir("/sys/bus/event_source/devices");
  while (dentry = readdir(dir)) {
    char buf[PATH_MAX];

    snprintf(buf, sizeof(buf), "%s/%s",
             "/sys/bus/event_source/devices", dentry->d_name);
    fd = open(buf, O_RDONLY);
    ...
  }

But this is not good since it needs to copy the string to build the
absolute pathname, and it makes redundant pathname walk (from the /sys)
in the kernel unnecessarily.  We can use openat(2) to open the file in
the given directory.

Add a couple of new helper to return the file descriptor of PMU
directory so that it can use it with relative paths.

 * perf_pmu__event_source_devices_fd()
   - returns a fd for the PMU root ("/sys/bus/event_source/devices")

 * perf_pmu__pathname_fd()
   - returns a fd for "<pmu>/<file>" under the PMU root

Now the above code can be converted something like below:

  dirfd = perf_pmu__event_source_devices_fd();
  dir = fdopendir(dirfd);
  while (dentry = readdir(dir)) {
    fd = openat(dirfd, dentry->d_name, O_RDONLY);
    ...
  }

I added a benchmark for pmu-scan and it showed a slight speedup
in the normal case too.

  $ ./perf.old bench internals pmu-scan
  # Running 'internals/pmu-scan' benchmark:
  Computing performance of sysfs PMU event scan for 100 times
    Average PMU scanning took: 6670.970 usec (+- 13.022 usec)

  $ ./perf.new bench internals pmu-scan
  # Running 'internals/pmu-scan' benchmark:
  Computing performance of sysfs PMU event scan for 100 times
    Average PMU scanning took: 6296.980 usec (+- 14.891 usec)

The 5~6% of improvement might be small but it may have bigger impact
when the system is contended.

You can get the code from 'perf/pmu-scan-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (9):
  perf list: Use relative path for tracepoint scan
  perf tools: Fix a asan issue in parse_events_multi_pmu_add()
  perf pmu: Add perf_pmu__destroy() function
  perf bench: Add pmu-scan benchmark
  perf pmu: Use relative path for sysfs scan
  perf pmu: Use relative path in perf_pmu__caps_parse()
  perf pmu: Use relative path in setup_pmu_alias_list()
  perf pmu: Add perf_pmu__{open,scan}_file_at()
  perf intel-pt: Use perf_pmu__scan_file_at() if possible

 tools/perf/arch/x86/util/intel-pt.c |  52 ++++--
 tools/perf/arch/x86/util/pmu.c      |  13 +-
 tools/perf/bench/Build              |   1 +
 tools/perf/bench/bench.h            |   1 +
 tools/perf/bench/pmu-scan.c         | 184 ++++++++++++++++++
 tools/perf/builtin-bench.c          |   1 +
 tools/perf/tests/pmu.c              |   9 +-
 tools/perf/util/parse-events.c      |   2 +-
 tools/perf/util/pmu.c               | 278 ++++++++++++++++++++--------
 tools/perf/util/pmu.h               |  12 +-
 tools/perf/util/print-events.c      |  26 ++-
 11 files changed, 466 insertions(+), 113 deletions(-)
 create mode 100644 tools/perf/bench/pmu-scan.c


base-commit: 417c6adfb155f906f0441cc1034827f6e2b3c372
-- 
2.40.0.348.gf938b09366-goog

