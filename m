Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899D070CB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjEVUl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbjEVUl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:41:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677DB5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2532da9e45bso2043879a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=xEa2mOQ2SU1uUUjttd9udMgRxPuLw8oCfRKbF8vtgTjACLQmxJkg3UlfAOJR42UukM
         2ceUcX4VaZ3REotSepvjFLOyzJj6wCM9CXPDxU6j3PR5bc5IPOtAhWh1/oqItWFbKb+l
         733AS0+sqdBmKeoiq9rksTo8cQroiIz3l70/cGsIUiBtEeuOHdNHejR/PaQdK6xnsVQJ
         XUBiLUf1hBSGbYMKJvUzpTcqDcCRL669NjLWUA27uHWUc0BBEx74CIGWM+tl8oxQrIKX
         XJTY0s8FmyqQUBkNT7x3lSqe4UciisM58DPS/vS7/Hav5LKzuhpyJ7um5LQ/px5A+9Rb
         Wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684788085; x=1687380085;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iR+BWwf4OJyjMqBDmvTGWi3YCxxOLx+95DOCyJVhKPk=;
        b=BLiqp/LR6k697PxH5Vj/AeI7sQYjk+S0dLZPN1uRKhjDzplx7X2qViWrmZ9hdSTw6I
         peVdcDW2dAb8sAX4wkSqm/BqrzoU3vmBjks6Rda5FK8CRQ8UVvLplycmc+dakiUrFYHw
         FXPIrns9pX+NllJrb177JkYUidVQltsEtBCP9VzghuQorpOHqDcPGXdPkoIcOxqV+Q8d
         YPagvCDoVQLB7Cn31no+iYdc7L8u7JZHFMzEiF3Oq0s2RgHf7Xk1D5MHrD6vez2OqLuJ
         WrpzhguuyMYh05wU0RyWQicCHFaEpFSJ4kNQ99OwylmcCp3PXluhAFATp9otvg+qt4E3
         iUng==
X-Gm-Message-State: AC+VfDwBYi22E9ChPtfEY0AV1edRbt5FjCcnffAbyU1Fy3sZuhxK1Uhp
        V/wXFMrKxJaeRBK2Fazn36QTqwaNUKGP
X-Google-Smtp-Source: ACHHUZ5UVJ/C3KmSAfO5qNKyH4H6nxwXGqLXpomHHJOGaFsacH0kVA5wReOpD9Jl2yVocPJozpRri3FrjLbf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a17:903:3390:b0:1ae:5474:4c82 with SMTP id
 kb16-20020a170903339000b001ae54744c82mr2770731plb.1.1684788085354; Mon, 22
 May 2023 13:41:25 -0700 (PDT)
Date:   Mon, 22 May 2023 13:40:44 -0700
Message-Id: <20230522204047.800543-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 0/3] Bring back vmlinux.h generation
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Ian Rogers (3):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL

 tools/perf/Makefile.config                       |  4 ++++
 tools/perf/Makefile.perf                         | 16 +++++++++++++++-
 tools/perf/tests/make                            |  4 ++++
 tools/perf/util/bpf_skel/.gitignore              |  1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c   |  2 --
 tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h | 10 ++++++++++
 6 files changed, 34 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.40.1.698.g37aff9b760-goog

