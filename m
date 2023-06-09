Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486ED728EF2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFIEct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFIEcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:32:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F030EE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:32:46 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-569e7aec37bso19346847b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=j3MQdwlPlNLSTAZ4JPSGVl2PkwH9k9SMKlrpWVwSIlZgNR8AhEh8j40ZMSq/Ij3yms
         qUeg4kfPtj5voC4sBWo+zdv9jE5SwHv8EKxP+EVpjDR1rku1BzGshxuoxH7oSEnHSJPx
         kADT7DRCNyNrO4Tqc/b3GGfDMKX6auftBx9DtFHn7E3HAJrjk9Zi6+45CWxFa8wPQ89m
         FwuYi8ld3YGYzpMLO0tIAdYyn9lXQBsmstAA3oJ9TDwZ7Oeg3suixjRtWNN6yB/JHw/w
         d6ldvdlJd9ASl3ZdlecZYVv19ohBwyMwOedDcxg9pJdyqiutkzn0p3/7DJiWYrFWEEgh
         y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686285166; x=1688877166;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWF7slA8vgXA8RW6bpiqoclUoglCNciaZKdWa5dk63U=;
        b=XOgFMzymYhbPFfp36NxaDDz6FDxjnoKcbZRdZHtkhBKWpmp6oEnJawhxIZdU1LbKoP
         QbWWm0Uw03qN4N6GeEAA9nleyhxmlI2yJRVTz79yz2y+TQwN7nyV2cSGaNzJoAKNXO50
         DigdffubEofDqguqmXuADr3n4yYXEHjaifSR/b4V0mWNDbuPTYwTt0HE0Pct+j21t5jR
         k2z5jPWCRoQFz7/9zgorLzoH/MyBPJIxk6ibR/YJXRPwt3cWGw5FldzbJ3s4jb/OHwMF
         Fu98bNjaaTkwue0W9kChzdZ4Thy+ndy7wR2CfoppM0CqRMKCR7GQBiWB9eDzE0sF5XYx
         Ab0w==
X-Gm-Message-State: AC+VfDwmirZh9AFAVo2T09T9HexPm7XjFJrpGB4gn3TR6nmU8oQgT6f7
        fZrFq0XM+TTsiJEBP6+ryQx7HfWYpoar
X-Google-Smtp-Source: ACHHUZ44KRlU5EFyYw3JMeyIqiBlwHsT9TKFRUfjhoaPmuiiLS4fTqN0WKDjiNqDuvWLoJ72BMqe5oYveMfj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c3e5:ebc6:61e5:c73f])
 (user=irogers job=sendgmr) by 2002:a81:ad17:0:b0:561:2d82:7f08 with SMTP id
 l23-20020a81ad17000000b005612d827f08mr230962ywh.0.1686285165838; Thu, 08 Jun
 2023 21:32:45 -0700 (PDT)
Date:   Thu,  8 Jun 2023 21:32:36 -0700
Message-Id: <20230609043240.43890-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 0/4] Bring back vmlinux.h generation
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

v3. Address Namhyung's comments on filtering ELF files with readelf.
v2. Rebase on perf-tools-next. Add Andrii's acked-by. Add patch to
    filter out kernels that lack a .BTF section and cause the build to
    break.

Ian Rogers (4):
  perf build: Add ability to build with a generated vmlinux.h
  perf bpf: Move the declaration of struct rq
  perf test: Add build tests for BUILD_BPF_SKEL
  perf build: Filter out BTF sources without a .BTF section

 tools/perf/Makefile.config                    |  4 ++
 tools/perf/Makefile.perf                      | 39 ++++++++++++++++++-
 tools/perf/tests/make                         |  4 ++
 tools/perf/util/bpf_skel/.gitignore           |  1 +
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  2 -
 .../util/bpf_skel/{ => vmlinux}/vmlinux.h     | 10 +++++
 6 files changed, 57 insertions(+), 3 deletions(-)
 rename tools/perf/util/bpf_skel/{ => vmlinux}/vmlinux.h (90%)

-- 
2.41.0.162.gfafddb0af9-goog

