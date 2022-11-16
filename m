Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDCD62CED6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiKPXjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiKPXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:38:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B02735;
        Wed, 16 Nov 2022 15:38:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so329467pjd.4;
        Wed, 16 Nov 2022 15:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdy3fEXtgXyoXwkPfALelVJoAp8iW4D1E4xvDfkIRRs=;
        b=Z1XuwqNsMJiG/461z0tHAjvyJ1484KFa7iBAFXP6j/SS8cPeKn5D6z/HLPqrOfu0LH
         z8ISXaOhxuBQc1MScEYVIrxZ5uR5KTdTj6GiGDDz0CAd/KEmq4FmHFncIclZ5RPDcvre
         PLZjYjsLEyMjs1MpCpWZL60MOAnZLoMRNzDb2VhvRgtsFutfXlIn26gR0h6YKIS/aLQO
         pzBRqXm1XxoFLTe5McYmJFe5S8zjtYswW4r6VInVJA/wxzI6UF8c+rNli21UxZ5LzN8K
         trj/Tqfori4kSyqgXrG7uaACflqZZuvFL7Utca3ydn/ja7TZedvFA7cjOpVyqxZdDXyf
         xOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdy3fEXtgXyoXwkPfALelVJoAp8iW4D1E4xvDfkIRRs=;
        b=bIwr71JbgD2V0U637m8ecs3MUCALTHNJMh8aLQHvflgeHJcrZvkVAF38vBZjL1VWaO
         i6pieriqUVXMGd4xRTClHVIdJ59bX+jSishWbh/Bcn2hdD8wuhWKXOBuMWA/NQcrpmBq
         5GtT6OuYVfV1EPZB6ehbQ6N6khqAQ1Q5JlbtZfE7ek1cRVjeTk7adS5x3Pz93wFL/LBW
         TEpvChA57XOIP/5tMouTgtp01/mZHMWPq671iSKp2CUgrUDaEusoULx+dzu+xymtXkxo
         XUqZQ5jgGlySETVZm06kA7f5QIR+/5hd/m5Zml4LBdUS4DrgBMwiwNO5yhZnjfc2a1l5
         Jc2g==
X-Gm-Message-State: ANoB5pk91qUeNDJLUfgTon5kGeR/aVa7sPiN0s7eQHKfay9HsnOBAq9I
        QP9s6KyL0ixp78FcCuUTwR8=
X-Google-Smtp-Source: AA0mqf5tsxVzsb1RRC5a9subudU8ELveHNpOe06mP98tByBEWZAJLviCi3xD+ggGe9+qubM204Q6CA==
X-Received: by 2002:a17:90b:810:b0:200:6637:a9e3 with SMTP id bk16-20020a17090b081000b002006637a9e3mr34656pjb.176.1668641938258;
        Wed, 16 Nov 2022 15:38:58 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:5b40:ce8c:1f7c:9acc])
        by smtp.gmail.com with ESMTPSA id bc10-20020a170902930a00b00188ef3ea2b6sm95929plb.262.2022.11.16.15.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:38:57 -0800 (PST)
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
Subject: [PATCHSET 00/12] perf test: Add test workloads (v3)
Date:   Wed, 16 Nov 2022 15:38:42 -0800
Message-Id: <20221116233854.1596378-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

In the shell tests, it needs to run a custom test workload to verify
the behaviors.  This requires a working compiler when it runs the
tests.  However it's not available in some test environments, making
hard to run those tests.

changes in v3)
 * update brstack to set num_loops  (James)
 * fix a typo in the brstack test  (German)
 * add tags rom German and James

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

You can find it in 'perf/test-workload-v3' branch in

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
 tools/perf/tests/workloads/brstack.c          | 41 ++++++++++++
 tools/perf/tests/workloads/datasym.c          | 24 +++++++
 tools/perf/tests/workloads/leafloop.c         | 34 ++++++++++
 tools/perf/tests/workloads/noploop.c          | 32 +++++++++
 tools/perf/tests/workloads/sqrtloop.c         | 45 +++++++++++++
 tools/perf/tests/workloads/thloop.c           | 53 +++++++++++++++
 16 files changed, 329 insertions(+), 257 deletions(-)
 create mode 100644 tools/perf/tests/workloads/Build
 create mode 100644 tools/perf/tests/workloads/brstack.c
 create mode 100644 tools/perf/tests/workloads/datasym.c
 create mode 100644 tools/perf/tests/workloads/leafloop.c
 create mode 100644 tools/perf/tests/workloads/noploop.c
 create mode 100644 tools/perf/tests/workloads/sqrtloop.c
 create mode 100644 tools/perf/tests/workloads/thloop.c


base-commit: 4dd7ff4a0311eee3ac946f0824442de94b34c42e
-- 
2.38.1.584.g0f3c55d4c2-goog

