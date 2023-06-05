Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C472315D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjFEU2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjFEU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:28:14 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3E898
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:28:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53b9eb7bda0so1933520a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=Q9T10dtnVViuYX7PiAM77gTQR0mNL3l97CIumpOUFIVSRAIJxcSd3D2ssFddid/ZER
         4yvhaKqX+CXtWJOEEHsIF1yDBSZMgW+3U2Dg0QjFQ55IN/igthyx8QVzi7TuPneZdMSo
         qBwAdbSf3nSWBH6RfewrhomP/I0PC2ahg28AHryNHnChrBkmAhLkUpbUku9HyU3wCGE5
         ZrrC6SF/Tn+Z0D4LZdyOmwPRCfQS2rkd8UCnKCqnnJLzFS3Q+Tmbf6YTv1J+HigoQAk3
         w8f7zo+pYQdVXX3jPv76zrwHgJEmr0M4X8TE03/0WaKp1+pSCpmpu4tGo/rWgZjL1i6y
         DVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996893; x=1688588893;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnxfahBFhDdYZkXlZPUfdWCh0pSs+dY9UekTfoE8XFc=;
        b=TTkQSl7lOUuaIHVmWeQSdUBuyOoIRDGoudD0Id9L5OeIZOIXFpR5luFUNp0UfF1Iht
         3r6UivaEYoUNQDfwV9xuxnnwlDWXAFoGcUjyxOAhhHpVjsmAfb34rRz89qAkwQ5dXWfX
         vlCzikAfVzcGYHiWzn02iF7HKG98bT6d+HhJq8ho3JNILbPhwb8HdlGF+PhjHrnfPwpA
         swGT9eqbT2dif7W61DZ07R88oKt5iCbJrv3FeWzjA98jL/j1y3UKM8TuDTEFx2OO1fSr
         rZ18fPLK7q2oXo9rbrxUvNC2Ltp9ze3aNt/T7i4eLwbjFhMIcCQ63DuoXHYaQxIqUUbB
         5hnw==
X-Gm-Message-State: AC+VfDwJDsM1woGGLiqgdvPL2xnXmH5tGIdBJUZZ+W6NeD135R1q2yoS
        hj3LvyFNnLAKGrNA2oAwXz2+kNu99zkL
X-Google-Smtp-Source: ACHHUZ5bhfZTZzASA6Lnd8k7u3qSQLLP0zYksqWxf+mRuBv7Pszw2pIpT7PC1WG+Mphjo3kJ1B+xcPEnKtB/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bed9:39b9:3df1:2828])
 (user=irogers job=sendgmr) by 2002:a63:f14c:0:b0:52c:4227:aa61 with SMTP id
 o12-20020a63f14c000000b0052c4227aa61mr193290pgk.6.1685996892776; Mon, 05 Jun
 2023 13:28:12 -0700 (PDT)
Date:   Mon,  5 Jun 2023 13:27:08 -0700
Message-Id: <20230605202712.1690876-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 0/4] Bring back vmlinux.h generation
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
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 760ebc45746b ("perf lock contention: Add empty 'struct rq' to
satisfy libbpf 'runqueue' type verification") inadvertently created a
declaration of 'struct rq' that conflicted with a generated
vmlinux.h's:

```
util/bpf_skel/lock_contention.bpf.c:419:8: error: redefinition of 'rq'
struct rq {};
       ^
/tmp/perf/util/bpf_skel/.tmp/../vmlinux.h:45630:8: note: previous definition is here
struct rq {
       ^
1 error generated.
```

Fix the issue by moving the declaration to vmlinux.h. So this can't
happen again, bring back build support for generating vmlinux.h then
add build tests.

v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 +++
 tools/perf/Makefile.perf                      | 33 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 +++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 --
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 ++++++
 6 files changed, 51 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.rc0.172.g3f132b7071-goog

