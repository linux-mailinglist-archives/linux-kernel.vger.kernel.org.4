Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8009162B3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKPHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiKPHNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:13:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523491F9F2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:13:04 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37010fefe48so156384337b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WXJjn8PYB9SLY1j1q0EeB8Piy7lrBilE/8YOyXaTxKY=;
        b=R9DPkR8U/JCqLAjy/iASbJFaNlfs13ciAt/+B1Xr6//ErVax+n55QLO+EUZuvA+VfB
         2pVuOsgmRzil/fEpWYMoEcLPRglB0Ehzkq21mYEGqsPs4A4YF+E5RMmBAoLmjWsO1eWj
         but174NBpm33mr/15kApu2yitVhNIprLILB8Msli2IKr+rakI4O7hv654m4STCOQAAJc
         j2jVVZLhQ2z94499I6GSdUIptbgySnp9m6CvRAfNWmRGy1mh7TscKwNCD5HF9mVnwVa7
         94KF1dMAsMJviEXYeH3Ov9KuR2HUPm0jDJuKWxYnX4ALW14ApmAgvLI4MN0HT5hMBeb0
         RvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXJjn8PYB9SLY1j1q0EeB8Piy7lrBilE/8YOyXaTxKY=;
        b=2Uec/m0lZFCGPtDtAnBxLUQnMjnCaeNxj25PJG+zG8U9Z/SM1+S4stz9bFUPamHHUh
         W/tvAC/bXAFxC2/i4t0T6we8MvG/IclVO5JNPB1lz4Lmh00gg2H55p9erWhVfeQsEY7Q
         88Y5lDg7qqhQBLU2DiLvuD2Q51pkRp+o++XQY+tIGtJrUPV13YneW0Fhcw0tV1aQ6DM5
         01O9U95uNbE6tTGhSAmXCAfGsZEh9BYwKGwALyQTX2ibo1cS+q3eMfOUxe/SdMalpz5F
         w0OkT6nKuRJ6MjVc+1mHcTks6Cguf1uQ6pIh4hTYynO+XQXdxMFqLjXERb0fHoJpc2mi
         a6yg==
X-Gm-Message-State: ANoB5plYUaT9Casz8kQgqcPV8Q9tOewUGi3r6M8WaCo0CDlfreChAEko
        sr4BVQxoKQJN/51Yt7qoBgiTnwe4J2VV
X-Google-Smtp-Source: AA0mqf5xyH2ENNOTYNJSqYf1bFldRQd/ujUpLe2WBGMxK8gXwmldQunucYc1jZ8DurLzY459eLTt3lmSL+n1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a25:d808:0:b0:6bd:d36:f096 with SMTP id
 p8-20020a25d808000000b006bd0d36f096mr20960547ybg.150.1668582783603; Tue, 15
 Nov 2022 23:13:03 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:12:55 -0800
Message-Id: <20221116071259.2832681-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 0/4] perf list libpfm support and other fixes
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an asan issue and a a lack of libpfm support with the refactored
perf list code. Add some improvements to wordwrap and the escape
printing for json to aid this.

Ian Rogers (4):
  perf list: Fix asan issue
  perf list: Support newlines in wordwrap
  perf list: Json escape encoding improvements
  perf list: List callback support for libpfm

 tools/perf/builtin-list.c | 122 ++++++++++++++++++------------
 tools/perf/util/pfm.c     | 154 +++++++++++++++++---------------------
 tools/perf/util/pfm.h     |   6 +-
 3 files changed, 145 insertions(+), 137 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

