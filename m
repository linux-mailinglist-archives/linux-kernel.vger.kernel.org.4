Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EB073AF4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWEOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjFWEOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:14:15 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B472117
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565ba5667d5so2239797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=Z6TPQvcA237450CbME4sySp4GZO5k8VXvDqisLx4wxKL4CKK/VN69L/LEq+H/jaxaa
         9jSPwdoN4ybnlf8zZXY2xA2TmCMbDjvpEblejvKPPC0N0bZ8bPoTy+JIdGEkptUU73zh
         E3XHe1UxVrOjHWaHcF5+wDYec6y8ndt8Nyq6paH6a+aoXZ0WVt3QQmKzMXCDOyaul7ag
         eByKdsLT4j27OEzLPHGbfYd3dwkCjRhmsTB3THolp9iILFJwADGV1IkAkP4dPjDZiyLZ
         Lg73CBhNQYuWVz6YdXlqTjET0jJZcFUOvcAispoSjBR0zBurogbz/GQYj3z9DIjRh6T6
         aN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493653; x=1690085653;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IWD9j1HDpuBwOtgRD8+VR/HyczlG3iSDWYis44Ihg3g=;
        b=ZhdFk8bnN3WaaITmvZBo+dg8+BjvHcii6F3a5bSt93kxFKRTSVw2/o8AY9II5QY+xE
         KbyWzDsybFkcn3kfui+s5eTLRZr3MOEIDd/ekZlOzXPQbYgwQYHUf9DsLDCAlbRhg6/p
         Fip39fozpOUBnyIy6XoaUxqJgpP966WJAaRpoiQPrmoJCEZwTOKHHqT1QB4wMaQ3TLKl
         yp9nQVBFyZ9E74lwnbcrNnNO1LAgz9Vg64kdHKTwBJpAhrXCvlgez1b67JPrK/56DYsX
         Vrqfx9vYeNVQuhwbHU43R1yFiweCJhpmJNXzVk0VaU3Dy+HDWhMvJi8VVnQEI4CJukKj
         3bBg==
X-Gm-Message-State: AC+VfDxVRFJW4xul9WbOZMBH97RneeTIy/6SLtUoBDLtlZV9Yi/U33eD
        LLg3UYMJGXKD1Z1EJIgSR7s68KO6mk8W
X-Google-Smtp-Source: ACHHUZ4ktfc6111JvR7+3Ed89DYQF4EkwuteMc+RPTAZXpHpUpH1nYrRdu+tu44wMR35qHiNSmWLIti3pmo/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a81:ae07:0:b0:570:200:18e1 with SMTP id
 m7-20020a81ae07000000b00570020018e1mr7911028ywh.3.1687493653716; Thu, 22 Jun
 2023 21:14:13 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:14:01 -0700
Message-Id: <20230623041405.4039475-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 0/4] Bring back vmlinux.h generation
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

v4. Rebase and add Namhyung and Jiri's acked-by.
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

