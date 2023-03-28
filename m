Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF286CCE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjC1X43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC1X4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:56:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5C22D47
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so13586010yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047760;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqxML7xkN1lg5mLK3PMobUIZG+frNSAW+D2pze+pEWQ=;
        b=MiMTpQr6+kNRUZmxlErxhLoP4NYq4RrGrVST1Sc3OVwcvCObBqd2kSgsQDG+bUmTEv
         zRc3wc7zHC2U9nW8W09sAccj5mTFLeyFg19sIFCsLfcid2NfUi9CtYnOJz6WW8d+YP73
         aNbh/DywCsGlwzC70wPA5lRUvXN+lZkbhcBQvc7w/cDjIyCbKdvTUJLQzDT53LbSL7Mp
         msgjcpf+q2Yj4npPCuPyhnBYOkE1hvuu1GFd2M0/CJ6lVwlfBlkBxI5G7d8vuAINBgMn
         az/7l7gylBmd1hogGLjlJnuS6Y9vV1EEjXFma1w5VIDYS8l8MS2XMl02t7+fLQmm1cL5
         woIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047760;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqxML7xkN1lg5mLK3PMobUIZG+frNSAW+D2pze+pEWQ=;
        b=N8FJPbkLeR1G693944NYPX8mcg+zlWo9Dl4zl+dbVkRUMK6Q6LsrNdT78pmxTOabX6
         PgzrdmeV6RgwBTGY2aK1fnQnRbv7JT5vlGsbA7i2eVH0y+1H/jAUlwAVE7N6JteUoQGA
         6gFb1XuGYEwNHc821PK0SABKirteUC6wHZSziv2+NV2/XSHdqkFDuMsEAcdo1ximjD+c
         nXX5NU81W019x/e5CIZetFdlUjMQoCENfaPsH4e2GfgtxAl/Qu9ojADDUVxWw1r/k8Tx
         ru+oNnqLANIIY7xONw9+7+L2+xHmM7sJUoJnwN4Rf5DtktwezHh3smv/OFumNTugnYNR
         4onQ==
X-Gm-Message-State: AAQBX9dcOvAszOQJK0KTTdHb1j7Gbs+IkUihQfvgN+no0H9o0+UfoqDb
        y0sJobThC9143DWSzqwSMr+5svgeJYXX
X-Google-Smtp-Source: AKy350ZZ9lVS00jsMGW8v4w4WleLMmPpByGkGSrq2CXRkk9qPGEztz5FAJobs50Rs8EBpLNwRbeAUJVOafcx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:6519:f0d3:9540:5c31])
 (user=irogers job=sendgmr) by 2002:a25:a323:0:b0:b35:91cc:9e29 with SMTP id
 d32-20020a25a323000000b00b3591cc9e29mr229665ybi.5.1680047760022; Tue, 28 Mar
 2023 16:56:00 -0700 (PDT)
Date:   Tue, 28 Mar 2023 16:55:37 -0700
Message-Id: <20230328235543.1082207-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 0/6] config file/command line for objdump & addr2line
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, James Clark <james.clark@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Andres Freund <andres@anarazel.de>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow objdump to be set as a perf config file variable. As previously
objdump was set via the command line, the string was owned by
argv. Now the string must be strdup-ed, so the corresponding logic
needs changing with an annotation_options__init/exit.

Add command line and config file options for addr2line, set in
symbol_conf for convenience. This doesn't allow the setting of
llvm-addr2line due to a bug, but could in the future.

Ian Rogers (6):
  perf annotate: Delete session for debug builds
  perf report: Additional config warnings
  perf annotate: Add init/exit to annotation_options remove default
  perf annotate: Own objdump_path and disassembler_style strings
  perf annotate: Allow objdump to be set in perfconfig
  perf symbol: Add command line support for addr2line path

 tools/perf/Documentation/perf-annotate.txt |  3 ++
 tools/perf/Documentation/perf-config.txt   |  8 +++-
 tools/perf/Documentation/perf-report.txt   |  3 ++
 tools/perf/Documentation/perf-top.txt      |  6 +++
 tools/perf/arch/common.c                   |  4 +-
 tools/perf/arch/common.h                   |  2 +-
 tools/perf/builtin-annotate.c              | 42 +++++++++++++-------
 tools/perf/builtin-report.c                | 35 ++++++++++++++---
 tools/perf/builtin-top.c                   | 27 +++++++++++--
 tools/perf/util/annotate.c                 | 45 +++++++++++++++++-----
 tools/perf/util/annotate.h                 |  9 +++--
 tools/perf/util/srcline.c                  | 26 ++++++++-----
 tools/perf/util/symbol_conf.h              |  1 +
 13 files changed, 163 insertions(+), 48 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

