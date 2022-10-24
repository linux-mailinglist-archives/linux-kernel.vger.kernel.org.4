Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5FA60B6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiJXTKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiJXTJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:09:51 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4950962A6D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:49:03 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id d4-20020a05683018e400b00661a05b6cf3so5786022otf.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YFlo4MLo2hX2jeXESO2A6LNaguFCae29tGLf3GNidYk=;
        b=ZGS6i81yil9zXXjp3+jzkPjW6Nq6onHh2W7XR+EhPWDsbPW8j3Sr+ARRyLEH07YgNj
         urHr3gg7kJCnF0QTVe1wFi9ltnBPG4kMJplrGvchu3bAUMI8hyj8VB4fDgScPt7E3yci
         3RzpLjdf93ULnobPhlzdHrcmz0aK1MPt9S6DFXZXjwEg8KbiomKOrZbNQQ1LOxd/IEQx
         V5oUX/kqXQAKkpYBum4ZgKSCInR/diwLNn0mGClyuwtUCwKUMqZr7ab+BJtHJKfDSiSP
         bDnL9+WccaIteWfVAMO3Xr2/+PssCf9SQxrUEfPHniUsFrSdTX/l3jV3Nh4Xozel3zJ/
         hFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFlo4MLo2hX2jeXESO2A6LNaguFCae29tGLf3GNidYk=;
        b=jidhOENARKmZ/U3xvvSlZ7dCV5LX2aAfA+EuRaMXE3el2jeE+ga3HO4JBVgHEWDB+x
         41iZDYiGXtk/Guc6LI3muzX/JoRS78lLWSz4D62FChRRDGw40Qq8HVPT/5VxJu7BCydl
         0zjRxvNiibfngT54t66Rq4YzYdlxQShsw4f7AKTUrMSj1zS1UIvRWOVIE31FB8AijjdH
         6/0XArfpU8XILcY3USuBheiizzLynYrk7vlZ/4FXTTVmPtk9LbuIUh+3CtTYivcx+EW6
         vt3fhY+IfwPgg+jZQdSImPJPiABegENXw584aUE+mo3fIrpzzpevIRsm6GpI6+TMy7s2
         zQKw==
X-Gm-Message-State: ACrzQf1UBCab2l+Wo/zAsnf2clmlkt+IIU/7eRxUNITdGH2rCx2RCLSf
        yKECEdf0zq2LQ7kz8X3kuGuDZb4On10N
X-Google-Smtp-Source: AMsMyM4TC2UOHQgUijqTe/CjUsLzraRvQ14rJaP27casQNWgKIjGSoNnf9yDeTk2i0Yp5rBOr6hFCHyHPOA4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:d7c4:0:b0:368:9884:fe84 with SMTP id
 z187-20020a0dd7c4000000b003689884fe84mr21397606ywd.252.1666632942781; Mon, 24
 Oct 2022 10:35:42 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:15 -0700
Message-Id: <20221024173523.602064-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of C11 is mainstream in the kernel [1]. There was some
confusion on volatile and signal handlers in [2]. Switch to using
stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
Yan <leo.yan@linaro.org> for the suggestions.

[1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
[3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers


Ian Rogers (8):
  perf build: Update to C standard to gnu11
  perf record: Use sig_atomic_t for signal handlers
  perf daemon: Use sig_atomic_t to avoid UB
  perf ftrace: Use sig_atomic_t to avoid UB
  perf session: Change type to avoid UB
  perf stat: Use sig_atomic_t to avoid UB
  perf top: Use sig_atomic_t to avoid UB
  perf trace: Use sig_atomic_t to avoid UB

 tools/perf/Makefile.config  | 2 +-
 tools/perf/builtin-daemon.c | 3 ++-
 tools/perf/builtin-ftrace.c | 4 ++--
 tools/perf/builtin-record.c | 9 +++++----
 tools/perf/builtin-stat.c   | 9 +++++----
 tools/perf/builtin-top.c    | 4 ++--
 tools/perf/builtin-trace.c  | 4 ++--
 tools/perf/util/session.c   | 3 ++-
 8 files changed, 21 insertions(+), 17 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

