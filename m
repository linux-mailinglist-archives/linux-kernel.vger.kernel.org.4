Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37C56231C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiKIRqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKIRqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:39 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6566CE70;
        Wed,  9 Nov 2022 09:46:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so2548751pjk.2;
        Wed, 09 Nov 2022 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=re07EFtuKaEOGB0eQGg49+EHjkyElXhCnkp7HcHtDLo=;
        b=DFF5qFJpWYljLoTozfGQMth5gZ6mxCbKAQJayCTsy2IfWn1cLVndhE76GIxHAPIfVi
         lPfE5hb8c+dTDOqGfVNrHupZkd8hG5vHqkAQ43nBoi+pMMOy8mPevpy07pJKEzfDo/q9
         haet19MLhKMPy2cqdXg698wUJvF7XNB1JVEAfoIUxf/ZXAUHpC1m9jJzhxuj5rtAH8Z/
         we7RtHuIsG1oxIASnX3RHQoJeI/SUoiqfzfowcltrVK4c5P8GAtRs4LKr/AF8VBMK5A8
         AQLgF0NEUvq3ugyBKplDRxrc4zUCbZgP5uJT+2+5121lf8w97uvcZ1UHE/zlg9Kde7LA
         97hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re07EFtuKaEOGB0eQGg49+EHjkyElXhCnkp7HcHtDLo=;
        b=aSeNl2/QemPehXpdiDiDjhSxD7a8RUQsMdWSXxpfXbLkRi2n7bcmRddMSkcWRfHp/J
         lq/8BnHGGrOO1LVwMbvhjzu/sHImzFAlqE+eUO4sYX229tAoDBJyJBdKYE49kzFf/YSF
         BQ3+zeizPWJI/oN3vznRY9embgw26xBssNR/TkPL8jZDIRP/CDgqWHmFISN9Cl1u+zTY
         uoFxx5Noq/KvVygs+eE2/oXbDQtx4dBf2G46tzYG6wfn7nxojWMUTxCcmBu+wXXWiG5S
         s9NzNtIQIxIZlfQewxEAhMc+C6cOHZozyjn0K4PTfQJaeSxlzKURRFBoRJfF6mKGP7z6
         ayvQ==
X-Gm-Message-State: ANoB5pkUqgGQLMz+odd9sKB36v2KEWC3aYCneEe2Uo+O8kdmZFhCu7qE
        duqumSvHMyROiPCI92jux0Y=
X-Google-Smtp-Source: AA0mqf4dJ6SH7nQ3eMzDu4CGIqlpZeEiljNdmmLx7++/tiO6BF5StlZNzPqqh0vSnDZm8H722bb//Q==
X-Received: by 2002:a17:903:249:b0:188:8f93:dc3e with SMTP id j9-20020a170903024900b001888f93dc3emr6095998plh.124.1668015997761;
        Wed, 09 Nov 2022 09:46:37 -0800 (PST)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:fa05:f3cd:da75:3103])
        by smtp.gmail.com with ESMTPSA id a10-20020a63cd4a000000b0043941566481sm7877909pgj.39.2022.11.09.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:37 -0800 (PST)
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
        James Clark <james.clark@arm.com>
Subject: [PATCHSET 00/12] perf test: Add test workloads (v1)
Date:   Wed,  9 Nov 2022 09:46:23 -0800
Message-Id: <20221109174635.859406-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

So I've added the test workload to the perf binary directly, so that
we can run them simply like:

  $ perf test -w noploop

And convert most of the shell tests need compilers with this workloads.
The buildid test still requires a compiler since it needs to check
different build options to generate different kind of build-IDs.

I've checked perf test result after the changes but could not verify
architecture-specific ones (e.g. for arm64).  It'd be nice if anyone
can check it out.

You can find it in 'perf/test-workload-v1' branch in

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
 .../perf/tests/shell/test_arm_callgraph_fp.sh | 30 +--------
 tools/perf/tests/shell/test_arm_spe_fork.sh   | 44 +------------
 tools/perf/tests/shell/test_brstack.sh        | 66 ++++---------------
 tools/perf/tests/shell/test_data_symbol.sh    | 29 +-------
 tools/perf/tests/tests.h                      | 27 ++++++++
 tools/perf/tests/workloads/Build              | 12 ++++
 tools/perf/tests/workloads/brstack.c          | 39 +++++++++++
 tools/perf/tests/workloads/datasym.c          | 24 +++++++
 tools/perf/tests/workloads/leafloop.c         | 34 ++++++++++
 tools/perf/tests/workloads/noploop.c          | 32 +++++++++
 tools/perf/tests/workloads/sqrtloop.c         | 44 +++++++++++++
 tools/perf/tests/workloads/thloop.c           | 53 +++++++++++++++
 16 files changed, 324 insertions(+), 255 deletions(-)
 create mode 100644 tools/perf/tests/workloads/Build
 create mode 100644 tools/perf/tests/workloads/brstack.c
 create mode 100644 tools/perf/tests/workloads/datasym.c
 create mode 100644 tools/perf/tests/workloads/leafloop.c
 create mode 100644 tools/perf/tests/workloads/noploop.c
 create mode 100644 tools/perf/tests/workloads/sqrtloop.c
 create mode 100644 tools/perf/tests/workloads/thloop.c


base-commit: 816815b852216f3aa3a43e2ce91c5510927cd61b
-- 
2.38.1.431.g37b22c650d-goog

