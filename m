Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9BE7402DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjF0SKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjF0SKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:10:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478C12D50
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-67106f598b1so1537122b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=LdeB8wUNlVIVV2gUpS55NLo9+v10Wb9Y0ceqjwzkT1yVBKxdnlhfogJAz+yevuVglS
         p2qYBwVh+8EtpHmOCT/vL8Oi1vglidxQ8F07mByDY+YTsQn18CZ7JM0m792WbQGeEiPh
         +5eiou41/39HNI9eSkKwLKKP8IGe5gRDTjOu7COs0HebGo00V1OePY87Xe/fIW5GCPVv
         B0MPWAWG7lxqKViXNWxhlF6ydOEX0jNxAFqauCpLipTVbm5Nu7Dvi4WXaaRwYmFWFade
         7qaZ2xOogFo1gAzQeuXNuf7Qk00QnDArWjBqzcEAiH7Z2G1BoPO7OaX7Bp8xoSxssXjr
         6bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889441; x=1690481441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Xopb4bdl/ldlCNcPlk1SBW3U6rHNjvHDq0o2AtiFJI=;
        b=PwCeYMTUCdfVD/+MYV/SayOx0zbhHwurivOC9Q4qttvs9h7LYOijmMuwRxqG852UKL
         XqKjdajKVjSe03bEzLqtrXGDOo+FXs9tgPL1+bWhy7EYn9GovINN9x8szjmC3XrTBJUG
         g3PHq0hrCM4DeFmvyzQUCjV0aJZg0bFuu8sJl/r3LmdVgCLhbuJEJb4mLsfgw+zFT51Z
         p8D4uqHiFpR1kSnUCwILbLdSA4oxoXgQcNrsxUYGQvs2w2o4JKg3w6z3Hhtr2ooNT1Gc
         wrH6A5WiOHrINREFhMM+pcFf8beHJ3C5ERo32eJsjkTsEG7rKPcDyZWGtvlN1bBQXeU7
         nSgw==
X-Gm-Message-State: AC+VfDwB5KYCvUlMX5PGAnLBVtr3c7zLREW6j0QHc1jthPpZrSY7aLRS
        wIv0J2omq8nsL+RtsRRDW7EF12DggWN+
X-Google-Smtp-Source: ACHHUZ6mT7X33BJiMUALcShfZoreYBIp2S3yS1Fc11hkbkfbrYxBsrXZVfgvcRxWjNGVzhcAy+ARaJSHoftN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a518:9a69:cf62:b4d9])
 (user=irogers job=sendgmr) by 2002:a05:6a00:2d9d:b0:668:6eed:7c1f with SMTP
 id fb29-20020a056a002d9d00b006686eed7c1fmr7849031pfb.3.1687889441460; Tue, 27
 Jun 2023 11:10:41 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:10:17 -0700
Message-Id: <20230627181030.95608-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 00/13] parse-events clean up
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
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

Remove some tokens the lexer never produces. Ensure abort paths set an
error. Previously scanning all PMUs meant bad events could fail with
an invalid token, detect this at the point parsing for a PMU fails and
add error strings. Try to be consistent in using YYNOMEM for memory
failures and YYABORT for bad input.

v2. Fix build error when building without libtraceevent.

Ian Rogers (13):
  perf parse-events: Remove unused PE_PMU_EVENT_FAKE token
  perf parse-events: Remove unused PE_KERNEL_PMU_EVENT token
  perf parse-events: Remove two unused tokens
  perf parse-events: Add more comments to parse_events_state
  perf parse-events: Avoid regrouped warning for wild card events
  perf parse-event: Add memory allocation test for name terms
  perf parse-events: Separate YYABORT and YYNOMEM cases
  perf parse-events: Move instances of YYABORT to YYNOMEM
  perf parse-events: Separate ENOMEM memory handling
  perf parse-events: Additional error reporting
  perf parse-events: Populate error column for BPF/tracepoint events
  perf parse-events: Improve location for add pmu
  perf parse-events: Remove ABORT_ON

 tools/perf/tests/bpf.c         |   2 +-
 tools/perf/util/parse-events.c |  98 +++++----
 tools/perf/util/parse-events.h |  20 +-
 tools/perf/util/parse-events.y | 351 +++++++++++++++++----------------
 4 files changed, 258 insertions(+), 213 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

