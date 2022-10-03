Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B4E5F374A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJCUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJCUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:46:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9393F11A34;
        Mon,  3 Oct 2022 13:46:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so10646295pgq.8;
        Mon, 03 Oct 2022 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=KnBq49sbYCenPU4wAQl0NnG23Om40FiMnbxa/nf7FuQ=;
        b=GSJ2tOPoval6gE2aSglDSum0SLSna1M8pnpnZLIW2zvrIgjAQLDY29xEZvWTuJxGHl
         y2IFnigDvxA4V0UZjOvz+U5nUXs9RnjNoWFrqMhXZQEOzzM03zfE6/BbYlr9BBlnMq0h
         IQP/Nt2fnRPVd8BMcZwz6JMAal28AfxK0TTha5pyvgkA1VZQYJvNpBnciD/578yjW19B
         +XjaCBXfCPNcny97IBIAgJCtLBmrasK21CFl85uaX3KwjaE7GJ/QWUZ/dWdyG0e132oi
         JXeaqzzVSex8hOFemoSxyxXet1atP9R8LMNEfzHK0MlAVv1xcgGh5JQK+W01JCb1IarU
         5dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=KnBq49sbYCenPU4wAQl0NnG23Om40FiMnbxa/nf7FuQ=;
        b=HLR7k0POTCNEUe8ddXvMTm/hi/IGGVm8py1o3sJDK+bdoQdoVsFSkbX4y3i0PKWJPq
         iC7nZrff6mLslE2sGREj8SJPXuIF3xzhdcKcJDFiVd5RLRKspVyiOjFl+kfjpSvnDE6V
         Y6F5oWCoTVLKVNT2mmDZZOJYmfPMW5D6O/dbY9Ou9aKfWE9kEzu7Ld+ZisiloIj3Q5CU
         SXtQ57XJcLoniDQmKOcDF/nr728OjDLE1QiLqZ8zQeghMikaiyXfMfOcCKSWq0nHN2Qk
         ++oa/yIb6P1OERoYSoxZY4O3g4ENboXFtLh85+fZmeeW5FvnB4zmQn6AClvawLpYBEmO
         jWKw==
X-Gm-Message-State: ACrzQf2JoZQGGmI81L0w25oAK0tnXxKlHdf595oHplhgWZ27rcX6UAYL
        am29hBcqmEABydOZUw5PRto=
X-Google-Smtp-Source: AMsMyM52r+ze4VzdpnSAcI7r+HJzg3MswxqCMrJyeTxja8RPMeuxGM5NdH/BPQU567RtREF4RJn3WQ==
X-Received: by 2002:a05:6a00:1748:b0:55a:ddbe:85d7 with SMTP id j8-20020a056a00174800b0055addbe85d7mr24849037pfc.68.1664830010032;
        Mon, 03 Oct 2022 13:46:50 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:63c9:72b6:3eb9:490a])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090ac68c00b0020a821e97fbsm3522931pjt.13.2022.10.03.13.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:46:49 -0700 (PDT)
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
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/5] perf tools: Clean up cpu map handling for system-wide evsel (v3)
Date:   Mon,  3 Oct 2022 13:46:42 -0700
Message-Id: <20221003204647.1481128-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The system-wide evsel has a cpu map for all (online) cpus regardless
of user requested cpus.  But the cpu map handling code has some
special case for it and I think we can cleanup the code by making sure
that such a evsel has a proper cpu/thread maps from the beginning.
This patches should not cause any change in the behavior.

Changes from v2:
 * build evlist->core.all_cpus from the beginning  (Adrian)

Changes from v1:
 * use evlist->core.needs_map_propagation field
 * add Reviewed-by from Adrian

You can get the code from 'perf/cpumap-update-v3' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (5):
  libperf: Populate system-wide evsel maps
  libperf: Propagate maps only if necessary
  perf tools: Get rid of evlist__add_on_all_cpus()
  perf tools: Add evlist__add_sched_switch()
  perf tools: Remove special handling of system-wide evsel

 tools/lib/perf/evlist.c                  | 26 +++++++-------
 tools/lib/perf/evsel.c                   |  3 --
 tools/lib/perf/include/internal/evlist.h |  1 +
 tools/perf/arch/x86/util/intel-pt.c      | 15 +++-----
 tools/perf/builtin-script.c              |  3 --
 tools/perf/tests/switch-tracking.c       | 15 +++-----
 tools/perf/util/evlist.c                 | 46 ++++++++++--------------
 tools/perf/util/evlist.h                 |  1 +
 tools/perf/util/evsel.c                  | 12 ++-----
 tools/perf/util/stat.c                   |  3 --
 10 files changed, 46 insertions(+), 79 deletions(-)


base-commit: 62e64c9d2fd12839c02f1b3e8b873e7cb34e8720
-- 
2.38.0.rc1.362.ged0d419d3c-goog

