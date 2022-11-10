Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AA624935
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiKJST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKJSTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:19:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200EF2CE3F;
        Thu, 10 Nov 2022 10:19:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b29so2819483pfp.13;
        Thu, 10 Nov 2022 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KsL/wRAm4nyOycOMfToP7JfNb8E+2RBLrLxA03bHh00=;
        b=mYjt6pHh+COaQ5sC5npZ549zLIl71Vq2OSxs2r3jesqCVm9kc8mAYtYOG+3UHhOwtU
         FX6FUJyIgxdB+MXvGEyEXpXPVaTUdehnx0/rA30oSJdHAD2ohCp2eyPlcuRvRQR1Kz4M
         bM0ZNA+pnG+7JmZoTPdCxbo7AN7u0iMaysIbx8/xYTBQ1LfXO9lLXZCgWPxBS4GUW9n7
         sLR90KcZ9x/yasviIhRphbyEwa5DjgrBzvO/HOvhwM+sxJwFfE7UI2MWMbRq3AulmVrf
         4Q2lOKdgiZJeB8p6BMHIPZg8G+Cqrv4n5offyCNCR+LPgefP1XtEcoG8hWqZvgPbZDuE
         xrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsL/wRAm4nyOycOMfToP7JfNb8E+2RBLrLxA03bHh00=;
        b=7/gxCdisULw0PySxnW3c5fBDfyYrz68QIT9a7f6VayrgNCiaw6acuUdUVx42VkQ0sJ
         kGxf1sbP7S2H78LuKp1cSN56091bFF7L73bZIYIzOs1QZ203QhjwJJLnda9ErzpH7TV5
         /PQwwu+EiZCzsImZqg/9rQr+nTQwZReOZ2Jh/g3r99tt1krE+YyZW97XqnDl3o25B9Hu
         CFdrEowJ7CW8ZAi/SnjgEvea6HUNwuJdRtg7r87u5ACIqwGMY6epJrKRzatGgBvpAlq+
         MBhSsnqCsXpF0wZPHoR37e89EP/JuCFxAuaWFgxY9tNZ4IUlcCF4c/mJ0cGvYTSvOS70
         eIow==
X-Gm-Message-State: ACrzQf15n9Cz8jy1PBqJ8sdhp0C+rIxwzt7/CVNkCAZE8N3rl6LwJTyE
        RQFLsllvEAxLBvgRH8+hFOQ=
X-Google-Smtp-Source: AMsMyM7EqvYuYWiTkIYaI4tqfcRdNiJvLy14s2MYuZRwtOG18reNGeSiqtUyt9spGh0HhYzUwDem4g==
X-Received: by 2002:a63:f741:0:b0:45f:b2a7:2659 with SMTP id f1-20020a63f741000000b0045fb2a72659mr3065054pgk.132.1668104363186;
        Thu, 10 Nov 2022 10:19:23 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:12cb:b694:b3d8:467c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902784900b00183e2a96414sm11518744pln.121.2022.11.10.10.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:19:22 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 00/12] perf test: Add test workloads (v2)
Date:   Thu, 10 Nov 2022 10:19:08 -0800
Message-Id: <20221110181920.84900-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
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

In the shell tests, it needs to run a custom test workload to verify
the behaviors.  This requires a working compiler when it runs the
tests.  However it's not available in some test environments, making
hard to run those tests.

changes in v2)
 * use sig_atomic_t  (Arnaldo)
 * fix callgraph fp test  (Leo)
 * fix bulid in sqrtloop  (German)
 * add tags from Leo Yan

So I've added the test workload to the perf binary directly, so that
we can run them simply like:

  $ perf test -w noploop

And convert most of the shell tests need compilers with this workloads.
The buildid test still requires a compiler since it needs to check
different build options to generate different kind of build-IDs.

I've checked perf test result after the changes but could not verify
architecture-specific ones (e.g. for arm64).  It'd be nice if anyone
can check it out.

You can find it in 'perf/test-workload-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (12):
  perf test: Add -w/--workload option
  perf test: Replace pipe test workload with noploop
  perf test: Add 'thloop' test workload
  perf test: Replace record test workload with thloop
  perf test: Add 'leafloop' test workload
  perf test: Replace arm callgraph fp test workload with leafloop
  perf test: Add 'sqrtloop' test workload
  perf test: Replace arm spe fork test workload with sqrtloop
  perf test: Add 'brstack' test workload
  perf test: Replace brstack test workload
  perf test: Add 'datasym' test workload
  perf test: Replace data symbol test workload with datasym

 tools/perf/tests/Build                        |  2 +
 tools/perf/tests/builtin-test.c               | 29 ++++++++
 tools/perf/tests/shell/pipe_test.sh           | 55 +++-------------
 tools/perf/tests/shell/record.sh              | 59 +----------------
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 34 +---------
 tools/perf/tests/shell/test_arm_spe_fork.sh   | 44 +------------
 tools/perf/tests/shell/test_brstack.sh        | 66 ++++---------------
 tools/perf/tests/shell/test_data_symbol.sh    | 29 +-------
 tools/perf/tests/tests.h                      | 27 ++++++++
 tools/perf/tests/workloads/Build              | 12 ++++
 tools/perf/tests/workloads/brstack.c          | 39 +++++++++++
 tools/perf/tests/workloads/datasym.c          | 24 +++++++
 tools/perf/tests/workloads/leafloop.c         | 34 ++++++++++
 tools/perf/tests/workloads/noploop.c          | 32 +++++++++
 tools/perf/tests/workloads/sqrtloop.c         | 45 +++++++++++++
 tools/perf/tests/workloads/thloop.c           | 53 +++++++++++++++
 16 files changed, 327 insertions(+), 257 deletions(-)
 create mode 100644 tools/perf/tests/workloads/Build
 create mode 100644 tools/perf/tests/workloads/brstack.c
 create mode 100644 tools/perf/tests/workloads/datasym.c
 create mode 100644 tools/perf/tests/workloads/leafloop.c
 create mode 100644 tools/perf/tests/workloads/noploop.c
 create mode 100644 tools/perf/tests/workloads/sqrtloop.c
 create mode 100644 tools/perf/tests/workloads/thloop.c


base-commit: 816815b852216f3aa3a43e2ce91c5510927cd61b
-- 
2.38.1.493.g58b659f92b-goog

