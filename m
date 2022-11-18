Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0875F62EC0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiKRCqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKRCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:46:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C998DA4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:25 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-385bbf9bc8fso37715447b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgUYDEYaejS5dLEipBeiq3H0zkWJQSsfp95m7vR2umM=;
        b=aZps6l3/4Ba8QF7QljbhqdPR9mWG4AYeeRMon9lNjZFTYKwoCa7DKFRrFp5MGXFBV1
         nLLdyy5Jqgwi1iqPvWoOvXRS4XWty7N2uuoKaeW2nkfFmdFRwtBjnen0/LFFNgraexKR
         Zjcy2axt+651IrFDKC2nCRlSkFHSiLP9eVQYHk4kHeAiLQnYTfvxPnLpxhIMmgv4pf6w
         YhdONvGshrlhsr1lBLmplsNsIyf+xMx/gcdtyZPya8DnrdcNKAl6QdPOBQlnFAZfYCCP
         f7QZ9qOgrRvZVB6C58wkLpV7w0+aD3GtDTw4Aq7z8/hfQml4CVg6Pd4L/uHIRWYvo1x0
         eTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgUYDEYaejS5dLEipBeiq3H0zkWJQSsfp95m7vR2umM=;
        b=SzhG/98iJIjZpoG/6wCTdwIKGkcmBeLsUdSYzH8bO6Lg8GpaTLoMlrUXMUHOCZ2NhK
         4S+NSIWKvvl723e6uEIhPCZZKnXWkNZRVW+yRCjnAVvjx21FlFLpA2/2vWGKiC1joTgM
         cqBDnNsBcy6UDudPZWZqVkUvI1mt4BqoT7xlQ/VWcrKTROxMLcc3OoeQ6Qjhqm4YdToY
         hELq87OQH9c288kR0qsfDp3Bp57MLISg7Nb7axJs29gUuIS903lLWlBV5sNXlOymAStx
         0vLq46VA5scZjo30c4GX/reUnujdgxVQVVu2xaKoBkSIQ5/xXd3+AH+apR1LQnhsQnqR
         Qg4g==
X-Gm-Message-State: ANoB5plzWCUucBBzLVMB53G6TuYH2WG1OgPq9kuzO90a0S0ki0EvM2xs
        42qyvbrm0678w4RJ26RutX9Gk6JqjijG
X-Google-Smtp-Source: AA0mqf5IQI8LuAX2DEdLTN0ckGnLEo2SU8PUK9F1qBUkl1JfhOLPnMkXFaZhHLOLGCmKYb37iJShf1a4UtbY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3f1e:c462:d6b8:fba8])
 (user=irogers job=sendgmr) by 2002:a81:df14:0:b0:37c:24be:ce0f with SMTP id
 c20-20020a81df14000000b0037c24bece0fmr9ywn.124.1668739584353; Thu, 17 Nov
 2022 18:46:24 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:46:04 -0800
Message-Id: <20221118024607.409083-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Subject: [PATCH v2 0/3] perf list libpfm fixes
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a lack of libpfm support with the refactored perf list code. Add
some improvements to wordwrap and the escape printing for json to aid
this.

v2. Rebased on acme/linux.git tmp.perf/core

Ian Rogers (3):
  perf list: Support newlines in wordwrap
  perf list: Json escape encoding improvements
  perf list: List callback support for libpfm

 tools/perf/builtin-list.c | 120 +++++++++++++++++------------
 tools/perf/util/pfm.c     | 154 +++++++++++++++++---------------------
 tools/perf/util/pfm.h     |   6 +-
 3 files changed, 144 insertions(+), 136 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

