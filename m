Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451AF6A2E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBZEVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZEVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:21:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22EABDFD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id l15so3563376pls.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtCAs/YFFr86XIDfqRqy7kxe4a72YAo+hwolG1inDOM=;
        b=sBZUrPHnNpZZctNY8LhbDZY7ekb7jqxIeaCi0kseTB/qguUAUe1bYA7THrmxBmfJuy
         7IuUKcthk066PTSg8U9Jf2w5BOvgV12Y7hCh2cFmswKORn0yBQDucjp8Z5VaFEQMn/Tu
         jP2yfSrZQIxQrjWqpOGmgosAEN6BxS6Z9FvNtGyYZsoZOmgL6sTi2FGilQbAyp+6ypGI
         63PeAJo+BV27mWvO0iHfhTkjJBY83kuXWUmhhhXG3ecQ/D4MNQodI6Rh7Yl12j0VgZHW
         S/q3lOgZMT4GMglpxPWJSe4Z0ZKXHe8Tms4WChxbSQPVVoAgqDeeQB/g3NcMIsUXzHV/
         7Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtCAs/YFFr86XIDfqRqy7kxe4a72YAo+hwolG1inDOM=;
        b=B1as/d6Lw6kNpoKLgmDOc+bSu2JSHfcn99MR1HbQNw5rEJGm6eCBbgejwZU4c5fW5Y
         lLq7zyNzhH5jWy9y9TKxUhVLoCYRzag8ViFuemSB4Ds0641R6/LIL/kJ/XU/d90nqHHp
         wKvIvfkPzX2jNsyt/QKMsNi290Yhd4JXNzjDw3B7XKj3/8Wu4H0Rbo6Jla1bZUf66INe
         ugtlwLh0rMivnvhN2kMRvIA1TMuDX3+mki2mzurfcHPh9oOU82V84wnpSnCPfXcDgi+u
         1U9jlG9B06F/lQNTR8vV0LtYlTVEq7smW5DhB5s/rDYbnwgZVxF3ftO5pjsuMx7kXjoM
         xVGQ==
X-Gm-Message-State: AO0yUKWJKBCTM1kfcJ3Zem6mvMQ3eBEgRRqHXQZsquQqstL9s6/oHnGE
        rvPu9M89ypXYQUf/er0AZPlfHw==
X-Google-Smtp-Source: AK7set9E52xh+xIv1mHte+MfOeP0FWxj3c4Lz+XbS6Ebpe4T0QSt9hx0z+d6uxQIoU3qZyj8qdcE3g==
X-Received: by 2002:a17:902:ec86:b0:196:11b1:101d with SMTP id x6-20020a170902ec8600b0019611b1101dmr24412942plg.28.1677385266205;
        Sat, 25 Feb 2023 20:21:06 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019aaab3f9d7sm1976036plb.113.2023.02.25.20.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:21:05 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 00/14] perf kvm: Support histograms and TUI mode
Date:   Sun, 26 Feb 2023 12:20:39 +0800
Message-Id: <20230226042053.1492409-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable histograms and (partially) TUI mode in perf
kvm tool.

Current tool uses its own RB tree to maintain KVM events, it's not easy
to extend to support more metrics and have no chance to support TUI
mode.  For this reason, we need firstly to refactor the code by using
histograms and its associated RB tree; based on histograms we can add
dimensions for KVM event statistics.  Finally, we need to enable TUI
mode in the tool.  This is the methodology applied in this series.

This series enables TUI mode for 'perf kvm stat report', but it doesn't
support TUI mode for 'perf kvm stat live'; this is because live mode is
different from report for TUI mode, which will be implemented in later
(TBH, I need to look into more details in histograms for this part).

Patches 01 ~ 04 are minor refactoring and they are preparation for later
enabling histograms and dimensions.

Patches 05 ~ 10 are for enabling histograms and dimensions; with these
changes the cached list is replaced by histograms list, and we extend to
support more sorting keys (max time, min time, mean time).

Patches 11 ~ 13 are to enable TUI mode in stat report, after this patch
TUI mode will be default mode, and user needs to input option '--stdio'
for stdio mode rather than TUI mode.

Patch 14 updates documentation for new sorting and 'stdio' mode.

After changes:

Please see the screenshot for the TUI with 'perf kvm stat report':
https://people.linaro.org/~leo.yan/debug/perf/perf_kvm_stat_report_tui.png

And I verified the '--stdio' mode and confirmed it has the same result
with before applying this series.

  # perf kvm stat report --stdio


  Analyze events for all VMs, all VCPUs:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time 

             MSR_WRITE        520    60.05%     0.07%      0.74us     16.92us      2.62us ( +-   2.66% )
                   HLT        179    20.67%    99.82%     64.53us  17159.69us  10123.40us ( +-   4.68% )
    EXTERNAL_INTERRUPT         71     8.20%     0.07%      1.16us     79.63us     17.56us ( +-  10.92% )
         EPT_MISCONFIG         68     7.85%     0.03%      5.53us     64.64us      8.09us ( +-  12.50% )
      PREEMPTION_TIMER         18     2.08%     0.01%      1.91us     12.06us      5.53us ( +-  10.25% )
      INTERRUPT_WINDOW          7     0.81%     0.00%      0.91us      1.66us      1.30us ( +-   9.09% )
              MSR_READ          3     0.35%     0.00%      4.06us      4.84us      4.42us ( +-   5.11% )

  Total Samples:866, Total events handled time:1815367.45us.

  # perf kvm stat live
  12:10:10.786799

  Analyze events for all VMs, all VCPUs:

               VM-EXIT    Samples  Samples%     Time%    Min Time    Max Time         Avg time 

             MSR_WRITE        121    66.85%    12.90%      0.67us  62918.87us    667.19us ( +-  80.72% )
                   HLT         34    18.78%    76.61%   2069.99us  52171.44us  14103.37us ( +-  14.25% )
    EXTERNAL_INTERRUPT         20    11.05%    10.49%      1.61us  47469.17us   3282.16us ( +-  75.75% )
      PREEMPTION_TIMER          5     2.76%     0.00%      3.98us      7.39us      5.84us ( +-  10.51% )
      INTERRUPT_WINDOW          1     0.55%     0.00%      2.01us      2.01us      2.01us ( +-   0.00% )

  Total Samples:181, Total events handled time:625919.05us.


Leo Yan (14):
  perf kvm: Refactor overall statistics
  perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
  perf kvm: Move up metrics helpers
  perf kvm: Use subtraction for comparison metrics
  perf kvm: Introduce histograms data structures
  perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
  perf kvm: Parse address location for samples
  perf kvm: Add dimensions for KVM event statistics
  perf kvm: Use histograms list to replace cached list
  perf kvm: Polish sorting key
  perf kvm: Support printing attributions for dimensions
  perf kvm: Add dimensions for percentages
  perf kvm: Add TUI mode for stat report
  perf kvm: Update documentation to reflect new changes

 tools/perf/Documentation/perf-kvm.txt |   9 +-
 tools/perf/builtin-kvm.c              | 847 +++++++++++++++++++++-----
 tools/perf/util/kvm-stat.h            |  26 +-
 3 files changed, 707 insertions(+), 175 deletions(-)

-- 
2.34.1

