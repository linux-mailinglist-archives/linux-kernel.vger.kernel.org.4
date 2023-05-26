Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BAF712DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbjEZTot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjEZTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:44:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA233D9
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8337a578dso1525093276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685130286; x=1687722286;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ao0iXi5t0xlQzOCpiGrMaghimyku8bQxK75df2szPg8=;
        b=bDkloEG0Rnw1JsC3vOV7ZxpKphAXsXrNTAi+MuZ+WeHz8dO7ziObIIR2rTuqtCZsKB
         7iiymEgNUxbRZD0TjfDMZUdoLVzdV9SGBEfwfBpfmK8Q86MmkNeuetfImWPlMMNqDp7Z
         6Fc0sYzpiQ/vlaz3IfjMCmk7BMyybUCz3FedhrzoPEv9g9P58M9ikGMhvE/GVZg8w0fw
         VeUHinS9P8mOHNZJCVgnyVHn3KnA3Uy2rYW+kW3vBDGoVYF3UNhfAKju0E33wUPz2lff
         SgXzHjAyV0xqUz4/QjKIIPeKPi4o8ZxGvA6CRubu4RP+fQEiB9egSAyH6MFcFTNuHXd1
         KIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130286; x=1687722286;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ao0iXi5t0xlQzOCpiGrMaghimyku8bQxK75df2szPg8=;
        b=jCoFe3SscKatZuG1nwdME6izjCb+yx4XqYYqY1BBgZA/dnu47TbG1FQKruKCDbTI8h
         Ev+KzZXU7vN/ytithQykxfZaRFPr4uSHM6fBniPQAEKjBNa+Rap6wX+dk5LeVRD0VUmF
         zeFlveFTw2HV5H7dJ66KAOLDO1s0KINsNXfCBfiJnSZcUraEY93eW8NJUp2jh5hXeqWX
         mqPzzCfnvE6Y4Ic2/UpM1ZqBStwJXCuOV49Z/Y95jjQOYc/APis2L1XNrRynaJ9myYWO
         4qb0+xwxEynL+lBdy1Qm5TLpLASR7gy7cwXANA6TxoZE90TxfJlBqg0qZNcYX3jolAnL
         PLcA==
X-Gm-Message-State: AC+VfDzHjDbgQaB1MINN+Uyya035WbepLL5rQWddI6oBMwNsqPeF/UO8
        7NT5l9l96ut6zueC3J49WOcvuIjgTT0X
X-Google-Smtp-Source: ACHHUZ4QPxMg2MEKujpTlVEQB8eOlGqGBxBCiCGE4MUqS4avAb2neblRB5Vf4a39srNyN6USuHERbzQDoNaI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ef:b0:ba8:2e69:9e06 with SMTP id
 w15-20020a05690204ef00b00ba82e699e06mr1530393ybs.1.1685130286062; Fri, 26 May
 2023 12:44:46 -0700 (PDT)
Date:   Fri, 26 May 2023 12:44:40 -0700
Message-Id: <20230526194442.2355872-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v3 0/2] Fixes from evsel__group_pmu_name asan error
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
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

evsel__group_pmu_name triggered an asan error as a list_head was cast
to an evsel, when it was the head, and the accessed as if it were a
full evsel. Further investigation showed problematic list iteration
for evsel__group_pmu_name whilst the list was being sorted so switch
to pre-computation.

v3: Rebase on perf-tools-next (branch getting ready for 6.5) rather
    than perf-tools (fixes for 6.4).
v2: Address review comments/feedback from Adrian Hunter
    <adrian.hunter@intel.com>.

Ian Rogers (2):
  perf evsel: evsel__group_pmu_name fixes
  perf evsel: for_each_group fixes

 tools/perf/util/evsel.c         | 31 ++++-----------
 tools/perf/util/evsel.h         | 26 +++++++-----
 tools/perf/util/evsel_fprintf.c |  1 +
 tools/perf/util/parse-events.c  | 70 +++++++++++++++++++++++++++------
 4 files changed, 84 insertions(+), 44 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

